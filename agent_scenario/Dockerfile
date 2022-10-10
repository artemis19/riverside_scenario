FROM ubuntu:latest

RUN apt update

# Install libpcap libraries
RUN apt install -y libpcap-dev curl

# Install liblinear and things necessary for go-dpi
RUN echo "deb http://packages.wand.net.nz trusty main" | tee -a /etc/apt/sources.list
RUN curl https://packages.wand.net.nz/keyring.gpg -o /etc/apt/trusted.gpg.d/wand.gpg
RUN apt update
RUN apt install -y liblinear4 liblinear-dev libtrace3-dev libtrace3 autoconf libtool git make build-essential
RUN git clone --branch 3.2-stable https://github.com/ntop/nDPI/ /tmp/nDPI
RUN cd /tmp/nDPI && ./autogen.sh && ./configure && make && make install && cd -

RUN apt install -y libprotoident libprotoident-dev

# Install traffic generator dependencies
RUN apt install -y iputils-ping dnsutils curl ftp netcat smbclient samba

# Install RDP server without prompting
RUN DEBIAN_FRONTEND=noninteractive apt install -y xrdp

# Install FTP server
RUN DEBIAN_FRONTEND=noninteractive apt install -y proftpd

# Install expect
RUN DEBIAN_FRONTEND=noninteractive apt install -y expect

# Prepare agent folder
RUN mkdir /viz

# Prepare traffic generator
COPY traffic_gen.sh /viz/
RUN chmod +x /viz/traffic_gen.sh

# Copy in expect scripts
COPY ftp.exp /.ftp.exp
COPY smb.exp /.smb.exp

COPY docker-entrypoint.sh /.docker-entrypoint.sh
RUN chmod +x /.docker-entrypoint.sh

COPY agent /viz

ENTRYPOINT [ "/.docker-entrypoint.sh" ]