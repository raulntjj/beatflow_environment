FROM node:18

ARG user=admin
ARG uid=1000

RUN apt-get update && apt-get install -y \
    git \
    curl \
    openssh-client \
    zip \
    unzip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY /docker/id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa && \
    ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN mkdir -p /var/www/app
RUN chown -R www-data:www-data /var/www/app

WORKDIR /var/www/app

EXPOSE 3000

COPY ./docker/node/entrypoint.sh /usr/local/bin/entrypoint_node.sh

RUN chmod +x /usr/local/bin/entrypoint_node.sh

ENTRYPOINT ["/usr/local/bin/entrypoint_node.sh"]

CMD ["npm", "run", "dev"]
