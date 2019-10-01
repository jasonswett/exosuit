#!/bin/sh

FILENAME=dist/exosuit-0.0.1.tar.gz
echo $FILENAME
tar cvf "$FILENAME" .
openssl dgst -sha256 $FILENAME
