FROM debian:11

RUN apt update

# Install lipcap libraries
RUN apt install -y libpcap-dev curl 

# Install liblinear and things necessary for go-dpi
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandio/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandder/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libtrace/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libflowmanager/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libprotoident/cfg/setup/bash.deb.sh' | bash

RUN apt update
RUN apt install -y liblinear4 liblinear-dev libtrace3-dev libtrace3 autoconf libtool git make build-essential
RUN git clone --branch 3.2-stable https://github.com/ntop/nDPI/ /tmp/nDPI
RUN cd /tmp/nDPI && ./autogen.sh && ./configure && make && make install && cd -

RUN apt install -y  libprotoident libprotoident-dev

# install traffic generator dependencies
RUN apt install -y iputils-ping dnsutils curl ftp netcat smbclient

# Install RDP server without prompting
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y xrdp

# Install Samba server without prompting
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y samba

# Install FTP server without prompting
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y proftpd

# Install Expect scripting without prompting
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y expect

# Prepare the agent folder
RUN mkdir /viz
# Prepare the traffic generator
COPY traffic_gen.sh /viz/
RUN chmod +x /viz/traffic_gen.sh

# Copy in our expect scripts to automate traffic (hidden files)
COPY ftp.exp /.ftp.exp
COPY smb.exp /.smb.exp

COPY docker-entrypoint.sh /.docker-entrypoint.sh
RUN chmod +x /.docker-entrypoint.sh

COPY agent /viz

ENTRYPOINT [ "/.docker-entrypoint.sh" ]