#!/bin/bash

cd /monero

/deploy_monero.sh
if [ $? -ne 0 ] ; then
    echo "Deploy ended with an error. Exiting."
    exit 1
fi
/start_mining.sh

exit 0

# vim: set sts=4 et tw=0 :
