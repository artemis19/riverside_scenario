## Attack Scenario

This repository contains the code used to run a simulated network attack. I created a Docker network of 15 internal hosts with 3 malicious remote hosts that were used to carry out the attack. I simulate RDP bruteforcing for initial access, lateral movement over SMB, beaconing over DNS to a C2, and finally data exfiltration from the network.

### Code

The `agent_scenario` folder contains the necessary code to create a docker image of my agents along with the automated traffic generator, `traffic_gen.sh`. The `scenario` folder contains the code for building out my Docker network and creating the 3 malicious remote hosts for my attack scenario.