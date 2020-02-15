#!/bin/bash

set +x
set +e

trap "exit 1" INT

#rm -rf /target/package /target/package.zip
mkdir -p /target/package
pip3 --disable-pip-version-check install --target /target/package/ --requirement /src/requirements.txt --force-reinstall
cd /target/package/
zip -r9q /target/package.zip . --recurse-paths -i '*'
#unzip -l /target/package.zip
cd /src/
zip -r9q /target/package.zip . --recurse-paths -i '*' --exclude requirements*.txt
#unzip -l /target/package.zip
ls -lah /target/package.zip
