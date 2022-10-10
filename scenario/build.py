#!/usr/bin/env python3

import argparse

parser = argparse.ArgumentParser()
parser.add_argument(
    "-a",
    "--agents",
    required=True,
    type=int,
    help="Number of agents to have in the environment",
)
parser.add_argument(
    "-r",
    "--remote",
    required=True,
    type=int,
    help="Number of remote hosts to have in the environment",
)
parser.add_argument(
    "-e", "--env", type=int, help="Environment variables for agents to reference"
)

args = parser.parse_args()

docker_compose_prologue = 'version: "3.9"'

docker_compose_epilogue = """
networks:
  viz:
    driver: bridge
    ipam:
      config:
        - subnet: 10.10.10.0/24
          gateway: 10.10.10.1
  external:
    driver: bridge
    ipam:
      config:
        - subnet: 153.17.52.0/24
          gateway: 153.17.52.1
"""

docker_compose_services = ["services:"]
for i in range(args.agents):
    agent_num = str(i + 1)
    agent_config = f"""
    agent{agent_num}:
        image: viz_agent
        hostname: agent{agent_num}
        environment:
          - VIZSERVER=172.17.0.1:1533
        entrypoint: bash -c "head /dev/urandom | sha256sum > /var/lib/dbus/machine-id; cat /var/lib/dbus/machine-id; /.docker-entrypoint.sh"
        networks:
            viz:
                ipv4_address: 10.10.10.1{agent_num.zfill(2)}
    """

    # First agent will have a public IP address so that the "external" network has a way in
    if agent_num == "1":
        agent_config += f"""
            external:
                ipv4_address: 153.17.52.1{agent_num.zfill(2)}
    """

    docker_compose_services.append(agent_config)

for i in range(args.remote):
    remote_num = str(i + 1)
    remote_config = f"""
    remote{remote_num}:
        image: remote_host
        hostname: remote_node{remote_num}
        environment:
            - RDPATTACK=true
            # - DONOTHING=true
        networks:
            external:
                ipv4_address: 153.17.52.2{remote_num.zfill(2)}
    """

    docker_compose_services.append(remote_config)

docker_compose_file = [
    docker_compose_prologue,
    "\n".join(docker_compose_services),
    docker_compose_epilogue,
]

with open("docker-compose.yml", "w") as filp:
    filp.write("\n".join(docker_compose_file))
