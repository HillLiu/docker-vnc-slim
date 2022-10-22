#!/usr/bin/env bash
DIR="$(
  cd "$(dirname "$0")"
  pwd -P
)"
sourceImage=$(${DIR}/../support/sourceImage.sh)
pid=$$
folderName=${PWD##*/}

cli='env docker run --rm -it'
cli+=" -v ${DIR}/../docker/entrypoint.sh:/usr/local/bin/entrypoint.sh"
cli+=" --entrypoint bash"
cli+=" --name ${folderName}_${pid} ${sourceImage}"
echo $cli
bash -c "$cli"
