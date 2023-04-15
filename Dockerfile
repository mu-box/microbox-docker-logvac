FROM mubox/base

# Create directories
RUN mkdir -p \
  /var/log/gomicro \
  /var/microbox \
  /opt/microbox/hooks

# Install and rsync
RUN apt-get update -qq && \
    apt-get install -y rsync && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

# Download logvac
RUN curl \
      -f \
      -k \
      -o /usr/local/bin/logvac \
      https://s3.amazonaws.com/tools.microbox.cloud/logvac/linux/amd64/logvac && \
    chmod 755 /usr/local/bin/logvac

# Download md5 (used to perform updates in hooks)
RUN curl \
      -f \
      -k \
      -o /var/microbox/logvac.md5 \
      https://s3.amazonaws.com/tools.microbox.cloud/logvac/linux/amd64/logvac.md5

# Install hooks
RUN curl \
      -f \
      -k \
      https://s3.amazonaws.com/tools.microbox.cloud/hooks/logvac-stable.tgz \
        | tar -xz -C /opt/microbox/hooks

# Download hooks md5 (used to perform updates)
RUN curl \
      -f \
      -k \
      -o /var/microbox/hooks.md5 \
      https://s3.amazonaws.com/tools.microbox.cloud/hooks/logvac-stable.md5

WORKDIR /data

# Run runit automatically
CMD [ "/opt/gomicro/bin/microinit" ]
