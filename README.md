# Docker Environment for Testing

I have created docker images for both agent and remote nodes and a `build.py` script for creating a test environment.

## Attack Scenario

This repository contains the code used to run a simulated network attack. I created a Docker network of 15 internal hosts with 3 malicious remote hosts that were used to carry out the attack. I simulate RDP bruteforcing for initial access, lateral movement over SMB, beaconing over DNS to a C2, and finally data exfiltration from the network.

### Code

The `agent_scenario` folder contains the necessary code to create a docker image of my agents along with the automated traffic generator, `traffic_gen.sh`. The `scenario` folder contains the code for building out my Docker network and creating the 3 malicious remote hosts for my attack scenario.

## Building Agent Docker Image

```bash
# Move into agent directory
cd /agent_scenario

# -t tag name must match docker-compose name
docker build -t viz_agent .
```

## Building Remote Docker Image

```bash
# Move into remote host folder for scenario
cd /scenario/remote_host

# -t tag name must match docker-compose name
docker build -t remote_host .
```

### Rebuilding Docker Scenario

The below example creates five agent nodes with one remote or "attacker" node for our scenario.

```bash
./build.py -a 5 -r 1; docker network prune; docker-compose up --force-recreate
```

### Cleaning Docker

Use this if docker occasionally slows down or needs to be reset.

```bash
docker system prune
````