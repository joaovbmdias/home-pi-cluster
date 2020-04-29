initial_setup=true
deploy_server=true
external_storage_mount=true

if [ "$initial_setup" = true ] ; then
    ./initial_setup.sh
fi