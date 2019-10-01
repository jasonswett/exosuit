#!/bin/sh

VERSION=$(./bin/exo --version)
FILENAME=dist/exosuit-$VERSION.tar.gz
tar cvf $FILENAME .
openssl dgst -sha256 $FILENAME
