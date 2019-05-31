FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get install -y --no-install-recommends wget ca-certificates gnupg2 \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN printf "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update \
&& apt-get install -y --no-install-recommends google-chrome-stable fonts-dejavu-core tzdata pulseaudio pavucontrol flashplugin-installer \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN groupadd -g 1000 udocker \
&& useradd --create-home -d /home/udocker -g udocker -u 1000 udocker \
&& usermod -a -G audio,video udocker
USER udocker
WORKDIR /home/udocker

ENTRYPOINT ["/usr/bin/google-chrome-stable"]
