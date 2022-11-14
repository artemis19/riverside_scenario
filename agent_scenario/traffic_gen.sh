#!/bin/bash

# Define protocols, domains, and ftp servers to use

PROTOCOLS=(
    "HTTP"
    "SSL"
    "FTP"
    "DNS"
    "ICMP"
    "TCP"
    "UDP"
)

DOMAINS=(
    "www.youtube.com"
    "www.facebook.com"
    "www.baidu.com"
    "www.yahoo.com"
    "www.amazon.com"
    "www.wikipedia.org"
    "www.qq.com"
    "www.google.co.in"
    "www.twitter.com"
    "www.live.com"
    "www.taobao.com"
    "www.bing.com"
    "www.instagram.com"
    "www.weibo.com"
    "www.sina.com.cn"
    "www.linkedin.com"
    "www.yahoo.co.jp"
    "www.msn.com"
    "www.vk.com"
    "www.google.de"
    "www.yandex.ru"
    "www.hao123.com"
    "www.google.co.uk"
    "www.reddit.com"
    "www.ebay.com"
    "www.google.fr"
    "www.t.co"
    "www.tmall.com"
    "www.google.com.br"
    "www.360.cn"
    "www.sohu.com"
    "www.amazon.co.jp"
    "www.pinterest.com"
    "www.netflix.com"
    "www.google.it"
    "www.google.ru"
    "www.microsoft.com"
    "www.google.es"
    "www.wordpress.com"
    "www.gmw.cn"
    "www.tumblr.com"
    "www.paypal.com"
    "www.blogspot.com"
    "www.imgur.com"
    "www.stackoverflow.com"
    "www.aliexpress.com"
    "www.naver.com"
    "www.ok.ru"
    "www.apple.com"
    "www.github.com"
    "www.chinadaily.com.cn"
    "www.imdb.com"
    "www.google.co.kr"
    "www.fc2.com"
    "www.jd.com"
    "www.blogger.com"
    "www.163.com"
    "www.google.ca"
    "www.whatsapp.com"
    "www.amazon.in"
    "www.office.com"
    "www.tianya.cn"
    "www.google.co.id"
    "www.youku.com"
    "www.rakuten.co.jp"
    "www.craigslist.org"
    "www.amazon.de"
    "www.nicovideo.jp"
    "www.google.pl"
    "www.soso.com"
    "www.bilibili.com"
    "www.dropbox.com"
    "www.xinhuanet.com"
    "www.outbrain.com"
    "www.pixnet.net"
    "www.alibaba.com"
    "www.alipay.com"
    "www.microsoftonline.com"
    "www.booking.com"
    "www.googleusercontent.com"
    "www.google.com.au"
    "www.popads.net"
    "www.cntv.cn"
    "www.zhihu.com"
    "www.amazon.co.uk"
    "www.diply.com"
    "www.coccoc.com"
    "www.cnn.com"
    "www.bbc.co.uk"
    "www.twitch.tv"
    "www.wikia.com"
    "www.google.co.th"
    "www.go.com"
    "www.google.com.ph"
    "www.doubleclick.net"
    "www.onet.pl"
    "www.googleadservices.com"
    "www.accuweather.com"
    "www.googleweblight.com"
    "www.answers.yahoo.com"
)



FTP_SERVERS=(
    "79.96.8.212"
    "104.244.89.37"
    "117.239.155.22"
    "107.151.182.78"
    "109.239.59.242"
    "198.50.198.220"
    "129.121.41.40"
    "189.207.167.40"
    "89.161.242.113"
    "156.54.170.63"
    "51.254.155.146"
    "223.130.4.102"
    "103.193.150.182"
    "89.161.185.65"
    "185.114.0.197"
    "79.96.188.245"
    "172.240.246.146"
    "94.152.51.45"
    "79.96.88.221"
    "192.185.230.2"
    "98.130.192.173"
    "89.161.201.170"
    "64.64.1.153"
    "79.96.3.218"
    "192.185.59.87"
    "89.161.154.155"
    "89.161.131.133"
    "94.203.216.70"
    "198.57.218.14"
    "89.161.160.134"
    "216.74.208.226"
    "103.55.25.1"
    "98.126.105.234"
    "198.1.71.53"
    "23.238.82.193"
    "107.151.229.67"
    "23.27.33.103"
    "74.201.38.123"
    "59.156.101.79"
    "217.128.231.137"
    "211.22.241.50"
    "213.58.195.226"
    "74.50.30.141"
    "199.223.210.112"
    "119.202.242.227"
    "122.212.34.246"
    "125.134.162.194"
    "142.4.19.252"
    "162.210.196.85"
    "178.32.250.109"
)

## Define traffic generator functions

function random(){
    local RINDEX
    list=${@}
    size=${#@}
    RINDEX=$(($RANDOM % $size))
    echo $RINDEX
}

function random_protocol(){
    RINDEX=$(random "${PROTOCOLS[@]}")
    echo ${PROTOCOLS[RINDEX]}
}

function random_http_url(){
    RINDEX=$(random "${DOMAINS[@]}")
    echo "http://${DOMAINS[RINDEX]}"
}

function random_https_url(){
    RINDEX=$(random "${DOMAINS[@]}")
    echo "https://${DOMAINS[RINDEX]}"
}

function random_ftp_server(){
    RINDEX=$(random "${FTP_SERVERS[@]}")
    echo "${FTP_SERVERS[RINDEX]}"
}

function random_domain(){
    RINDEX=$(random "${DOMAINS[@]}")
    echo "${DOMAINS[RINDEX]}"
}

TIMEOUT_TIME="5s"
JITTER_TIME="5"
MAX_NUM_OF_OPS="3"

function do_random_traffic(){

protocol=$(random_protocol)

    case ${protocol} in
        #statements
        HTTP)
            url=$(random_http_url)
            echo "HTTP protocol, run curl against ${url}"
            COMMAND="curl -s ${url}"
            ;;
        SSL)
            url=$(random_https_url)
            echo "SSL/HTTPS protocol, run curl against ${url}"
            COMMAND="curl -s ${url}"
            ;;
        FTP)
            server=$(random_ftp_server)
            echo "FTP protocol, run ftp against ${server}"
            COMMAND="ftp ${server}"
            ;;
        DNS)
            domain=$(random_domain)
            echo "DNS protocol, run dig against ${domain}"
            COMMAND="dig ${domain}"
            ;;
        ICMP)
            domain=$(random_domain)
            echo "ICMP protocol, run ping against ${domain}"
            COMMAND="ping ${domain}"
            ;;
        TCP)
            ip_address=$(random_ftp_server)
            echo "TCP protocol, run nc against ${ip_address}"
            COMMAND="nc ${ip_address} ${RANDOM}"
            ;;
        UDP)
            ip_address=$(random_ftp_server)
            echo "TCP protocol, run nc against ${ip_address}"
            COMMAND="nc -u ${ip_address} ${RANDOM}"
            ;;
        *)
            echo "protocol: ${protocol}"
            COMMAND="true"
            ;;
    esac

    timeout ${TIMEOUT_TIME} ${COMMAND} > /dev/null
}

while [ 1 ]; do
    NUM_OF_OPS=$(($RANDOM % $MAX_NUM_OF_OPS))

    for i in $(seq 1 $NUM_OF_OPS); do
        do_random_traffic &
    done

    SLEEP=$(($RANDOM % $JITTER_TIME))
    echo "Done, sleeping for ${SLEEP} seconds..."

    sleep ${SLEEP}
done