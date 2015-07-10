FROM ubuntu:14.04
MAINTAINER asyrique@gmail.com

#Add sources
RUN echo "deb http://deb.torproject.org/torproject.org trusty main" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.torproject.org/torproject.org trusty main" >> /etc/apt/source.list

#Add Key
RUN gpg --keyserver keys.gnupg.net --recv 886DDD89
RUN gpg --export A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89 | sudo apt-key add -

#Install packages
RUN apt-get update -qq && apt-get install -y supervisor privoxy deb.torproject.org-keyring tor

# Add custom supervisor config
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add custom config
ADD ./privoxy/config /etc/privoxy/config
ADD ./tor/ /etc/tor/

#Expose relevant ports
EXPOSE 9050
EXPOSE 8118


CMD ["/usr/bin/supervisord"]