FROM ubuntu:22.04

RUN apt update

# Install lipcap libraries
RUN apt install -y libpcap-dev curl git

# Install liblinear and things necessary for go-dpi
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandio/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libwandder/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libtrace/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libflowmanager/cfg/setup/bash.deb.sh' | bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/wand/libprotoident/cfg/setup/bash.deb.sh' | bash

RUN apt update
RUN apt install -y liblinear4 liblinear-dev libtrace4-dev libtrace4 autoconf libtool git make build-essential
RUN git clone --branch 3.2-stable https://github.com/ntop/nDPI/ /tmp/nDPI
RUN cd /tmp/nDPI && ./autogen.sh && ./configure && make && make install && cd -

# Download and build libflowmanager from source
RUN git clone https://github.com/LibtraceTeam/libflowmanager /opt/libflowmanager
WORKDIR /opt/libflowmanager
RUN ./bootstrap.sh
RUN ./configure
RUN make
RUN make install

# Download and build libprotoident from source
RUN git clone https://github.com/LibtraceTeam/libprotoident /opt/libprotoident
WORKDIR /opt/libprotoident
RUN ./bootstrap.sh
RUN ./configure
RUN make
RUN make install

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


# Copy in our expect scripts to automate traffic (hidden files)
COPY ftp.exp /.ftp.exp
COPY smb.exp /.smb.exp

COPY docker-entrypoint.sh /.docker-entrypoint.sh
RUN chmod +x /.docker-entrypoint.sh

# Install Golang
RUN curl -L https://go.dev/dl/go1.19.3.linux-amd64.tar.gz -o /opt/go1.19.3.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf /opt/go1.19.3.linux-amd64.tar.gz
RUN export PATH=$PATH:/usr/local/go/bin

# Download and compile the agent
RUN git clone https://github.com/artemis19/riverside /viz --depth 1
RUN cd /viz/agent && /usr/local/go/bin/go build

# Prepare the traffic generator
COPY traffic_gen.sh /viz/
RUN chmod +x /viz/traffic_gen.sh

WORKDIR /viz/agent/

ENTRYPOINT [ "/.docker-entrypoint.sh" ]