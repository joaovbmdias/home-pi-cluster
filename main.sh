#!/bin/bash
#cur_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

initial_setup=true
deploy_server=true
external_storage_mount=true

echo Executing Initial Setup
if [ "$initial_setup" = true ] ; then
    chmod +x initial-pi-setup.sh
    sh initial-pi-setup.sh
fi