FROM python:3.7 as base
RUN apt-get update \
	&& apt-get -y install zip \
	&& apt-get clean autoclean \
	&& apt-get autoremove --yes \
	&& rm -rf /var/lib/{apt,dpkg,cache,log}/
RUN mkdir -p /src

FROM base as deps
COPY /requirements.txt /src
WORKDIR /src
RUN mkdir -p /build/package \
	&& pip3 --disable-pip-version-check install --target /build/package/ --requirement /src/requirements.txt --force-reinstall

FROM deps
COPY --from=deps /build/package/ /build/package/
COPY / /build/package/
WORKDIR /build/package
RUN ls -lah /build/package/ \
	&& zip -r9q /build/package.zip . --recurse-paths -i '*' --exclude 'requirements*.txt'
VOLUME /target

CMD [ "bash", "-c", "cp -r /build/* /target/" ]
