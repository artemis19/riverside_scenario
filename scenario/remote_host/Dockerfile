FROM ubuntu:latest

RUN apt update

# Install traffic generator dependencies
RUN apt install -y iputils-ping dnsutils curl ftp netcat smbclient bind9

# Install RDP connection utilities
RUN apt install -y freerdp2-x11 xvfb

# Install FTP server
RUN apt install -y proftpd

COPY docker-entrypoint.sh /.docker-entrypoint.sh
RUN chmod +x /.docker-entrypoint.sh

ENTRYPOINT [ "/.docker-entrypoint.sh" ]