FROM python:3.7
RUN apt-get update \
	&& apt-get -y install zip \
	&& apt-get clean autoclean \
	&& apt-get autoremove --yes \
	&& rm -rf /var/lib/{apt,dpkg,cache,log}/
COPY /package.sh /
VOLUME /src
VOLUME /target

CMD [ "/bin/bash", "-x", "/package.sh" ]
