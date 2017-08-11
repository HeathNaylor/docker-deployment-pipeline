FROM nginx:alpine

ADD ./Entrypoint.sh /srv/Entrypoint.sh
RUN chmod 777 /srv/Entrypoint.sh

ENTRYPOINT "/srv/Entrypoint.sh"
