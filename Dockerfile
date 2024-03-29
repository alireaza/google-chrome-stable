FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
wget ca-certificates gnupg2 apt-transport-https \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

RUN wget -O- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor > /usr/share/keyrings/google-chrome-archive-keyring.gpg
RUN printf "deb [signed-by=/usr/share/keyrings/google-chrome-archive-keyring.gpg] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
google-chrome-stable \
fontconfig fonts-liberation fonts-dejavu fonts-freefont-ttf fonts-indic fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-symbola fonts-noto \
pulseaudio ffmpeg libsm6 libxext6 dbus-x11 tzdata \
&& apt-get update \
&& apt-get upgrade -y \
&& apt-get remove -fy \
&& apt-get autoclean -y \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

ARG UNAME=udocker
ARG UID=1000
ARG GNAME=$UNAME
ARG GID=1000
ARG GROUPS=audio,video

RUN groupadd -g $GID $GNAME \
&& useradd --create-home -d /home/$UNAME -g $GID -u $UID $UNAME \
&& usermod -a -G $GROUPS $UNAME
USER $UNAME
WORKDIR /home/$UNAME

ENTRYPOINT ["/usr/bin/google-chrome-stable"]
