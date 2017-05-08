FROM alpine:3.4
MAINTAINER Pavithra K C <Pavithra.KC@intlfcstone.com>

ARG SDC_USER=sdc
 
USER root


RUN apk --no-cache add bash \
    curl \
    krb5-libs \
    libstdc++ \
    sed
	
RUN apk add --update bash libressl curl fping libcap && rm -rf /var/cache/apk/* && mkdir /opt 
	
	
# add streamsets user

RUN addgroup -S ${SDC_USER} && \
    adduser -S ${SDC_USER} ${SDC_USER}
	

ENV DATA_VOLUME=/usr/share/streamsets/data

RUN mkdir -p ${DATA_VOLUME}

# Set permissions on shared libs folder

RUN chown -R "${SDC_USER}:${SDC_USER}" "${DATA_VOLUME}" 


ADD root /
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]



