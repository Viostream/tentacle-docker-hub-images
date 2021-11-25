FROM octopusdeploy/tentacle

LABEL Maintainer='Stuart Auld <stuart.auld@viostream.com>'

# This is required for the tentacle to run
ENV ACCEPT_EULA=Y
ENV CHAMBER_VERSION=2.10.6
ENV FUSION_THEME_SYNC_VERSION=0.1.2
ENV PACKER_VERSION=1.7.8
ENV SNOWFLAKE_DRIVER_VERSION=2.24.2
ENV TERRAFORM_VERSION=1.0.11

# Add in github.com public key
COPY known_hosts /root/.ssh/known_hosts

RUN \
     curl -sSfL https://apt.octopus.com/public.key | apt-key add - \
     && echo deb https://apt.octopus.com/ stable main > /etc/apt/sources.list.d/octopus.com.list \
     && echo deb [arch=amd64] https://deb.debian.org/debian bullseye main > /etc/apt/sources.list.d/bullseye.list \
     && apt-get update \
     && apt-get upgrade -y \
     && apt-get install -y \
     git \
     groff \
     jq \
     octopuscli \
     python3-distutils \
     skopeo \
     wget \
     unixodbc \
     zip \
     && rm -rf /var/lib/apt/lists/* \
     && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
     && python3 get-pip.py \
     && pip install awscli --upgrade \
     && curl -q https://releases.hashicorp.com/terraform/"$TERRAFORM_VERSION"/terraform_"$TERRAFORM_VERSION"_linux_amd64.zip \
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
     && rm packer.zip \
     && wget -q "https://sfc-repo.snowflakecomputing.com/odbc/linux/latest/snowflake-odbc-${SNOWFLAKE_DRIVER_VERSION}.x86_64.deb" \
     && dpkg -i "snowflake-odbc-${SNOWFLAKE_DRIVER_VERSION}.x86_64.deb" \
     && rm "snowflake-odbc-${SNOWFLAKE_DRIVER_VERSION}.x86_64.deb" \
     && wget -q "https://github.com/segmentio/chamber/releases/download/v$CHAMBER_VERSION/chamber-v$CHAMBER_VERSION-linux-amd64" \
     -O chamber \
     && chmod +x chamber \
     && mv chamber /usr/local/bin/ \
     && wget -q "https://github.com/Viostream/fusion-theme-sync/releases/download/v$FUSION_THEME_SYNC_VERSION/fusion-theme-sync" \
     && mv fusion-theme-sync /usr/local/bin/ \
     && chmod +x /usr/local/bin/fusion-theme-sync
