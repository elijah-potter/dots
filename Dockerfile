FROM archlinux:latest

WORKDIR ~
COPY install.sh .
RUN bash install.sh


