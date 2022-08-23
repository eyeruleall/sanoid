FROM ubuntu:latest
ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone && \
  apt update && \
  apt install -y git debhelper libcapture-tiny-perl libconfig-inifiles-perl pv lzop mbuffer build-essential tzdata && \
  git clone https://github.com/jimsalterjrs/sanoid.git && \
  cd sanoid && \
  # checkout latest stable release or stay on master for bleeding edge stuff (but expect bugs!)
  git checkout $(git tag | grep "^v" | tail -n 1) && \
  ln -s packages/debian . && \
  dpkg-buildpackage -uc -us && \
  apt install -y ../sanoid_*_all.deb
CMD tail -f /dev/null
