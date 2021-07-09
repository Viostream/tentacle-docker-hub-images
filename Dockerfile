FROM octopusdeploy/tentacle

LABEL Maintainer='Stuart Auld <stuart.auld@viostream.com>'

RUN \
     apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
       groff \
       python3-distutils \
  && rm -rf /var/lib/apt/lists/* \
  && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python3 get-pip.py \
  && pip install awscli --upgrade
