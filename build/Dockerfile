FROM python:3.7 as base
RUN apt-get update \
	&& apt-get -y install zip \
	&& apt-get clean autoclean \
	&& apt-get autoremove --yes \
	&& rm -rf /var/lib/{apt,dpkg,cache,log}/

FROM base as built
RUN mkdir -p /build/package/ \
	&& python3 -m venv /build/.venv
COPY /requirements.txt /build/package/
WORKDIR /build/package
RUN . /build/.venv/bin/activate \
	&& if [ -f "/src/requirements-dev.txt" ]; then pip3 --disable-pip-version-check install -r /src/requirements-dev.txt; fi
RUN . /build/.venv/bin/activate \
	&& if [ -f "/src/requirements-test.txt" ]; then pip3 --disable-pip-version-check install -r /src/requirements-test.txt; fi
RUN . /build/.venv/bin/activate \
	&& pip3 --disable-pip-version-check install --target /build/package/ --requirement /build/package/requirements.txt --force-reinstall
#COPY --from=deps /build/package/ /build/package/
COPY / /build/package/
RUN . /build/.venv/bin/activate \
	&& python -m compileall -b . \
	&& zip -r9q /build/package.zip . --recurse-paths -i '*' --exclude 'requirements*.txt'

FROM built
VOLUME /target
CMD [ "bash", "-c", "cp -r /build/* /target/" ]
