FROM octopusdeploy/tentacle

LABEL Maintainer='Stuart Auld <stuart.auld@viostream.com>'

# This is required for the tentacle to run
ENV ACCEPT_EULA=Y
ENV PACKER_VERSION=v1.0.1
ENV TERRAFORM_VERSION=v1.0.1

RUN \
     apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
       groff \
       python3-distutils \
       zip \
  && rm -rf /var/lib/apt/lists/* \
  && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python3 get-pip.py \
  && pip install awscli --upgrade \
  && curl https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_$TERRAFORM_VERSION_linux_amd64.zip \
       -o /usr/local/bin/terraform \
  && chmod +x /usr/local/terraform \
  && curl https://releases.hashicorp.com/packer/$PACKER_VERSION/packer_$PACKER_VERSION_linux_amd64.zip \
       -o /usr/local/bin/packer \
  && chmod +x /usr/local/bin/packer

