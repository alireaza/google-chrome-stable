# Google Chrome

## Build
Via GitHub repository
```bash
$ docker build --tag alireaza/google-chrome-stable:$(date -u +%Y%m%d) --tag alireaza/google-chrome-stable:latest https://github.com/alireaza/google-chrome-stable.git
```

## Run
```bash
$ docker run \
--interactive \
--tty \
--rm \
--mount="type=bind,source=/tmp/.X11-unix,target=/tmp/.X11-unix" \
--env="DISPLAY=$DISPLAY" \
--device="/dev/dri:/dev/dri" \
--env="PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
--mount="type=bind,source=${XDG_RUNTIME_DIR}/pulse/native,target=${XDG_RUNTIME_DIR}/pulse/native" \
--env="TZ=$(cat /etc/timezone)" \
--cap-add=SYS_ADMIN \
--ipc host \
--mount="type=bind,source=/dev/shm,target=/dev/shm" \
--mount="type=bind,source=/etc/machine-id,target=/etc/machine-id" \
--mount="type=bind,source=/var/run/dbus/system_bus_socket,target=/var/run/dbus/system_bus_socket" \
--mount="type=bind,source=$(pwd)/udocker,target=/home/udocker" \
--name="google-chrome-stable" \
alireaza/google-chrome-stable \
--enable-logging=stderr \
--high-dpi-support=1 \
--force-device-scale-factor=.75
```

