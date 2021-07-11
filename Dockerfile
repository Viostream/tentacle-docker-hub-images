FROM octopusdeploy/tentacle

LABEL Maintainer='Stuart Auld <stuart.auld@viostream.com>'

# This is required for the tentacle to run
ENV ACCEPT_EULA=Y
ENV PACKER_VERSION=1.7.3
ENV TERRAFORM_VERSION=1.0.1

# Add in github.com public key
COPY known_hosts /root/.ssh/known_hosts

RUN \
     apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y \
       git \
       groff \
       python3-distutils \
       wget \
       zip \
  && apt-get remove -y jq \
  && echo "deb [arch=amd64] https://deb.debian.org/debian bullseye main" > /etc/apt/sources.list.d/bullseye.list \
  && apt-get update \
  && apt-get install -y \
       jq \
       skopeo \
  && rm -rf /var/lib/apt/lists/* \
  && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python3 get-pip.py \
  && pip install awscli --upgrade \
  && curl https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip \
       -o terraform.zip \
  && unzip terraform.zip \
  && mv terraform /usr/local/bin/terraform \
  && chmod +x /usr/local/bin/terraform \
  && rm terraform.zip \
  && curl https://releases.hashicorp.com/packer/"$PACKER_VERSION"/packer_"$PACKER_VERSION"_linux_amd64.zip \
       -o packer.zip \
  && unzip packer.zip \
  && mv packer /usr/local/bin/packer \
  && chmod +x /usr/local/bin/packer \
  && rm packer.zip