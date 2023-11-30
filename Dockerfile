FROM ghcr.io/backstage/backstage:latest

USER root
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install mkdocs-techdocs-core==1.2.0