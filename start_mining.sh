#!/bin/bash

MONEROD="./bin/monerod"
DATADIR="./data"

if [ ! -f "$MONEROD" ] ; then
    echo "monerod missing, exiting."
    exit 1
fi
if [ ! -d "$DATADIR" ] ; then
    echo "Monero data dir missing, exiting."
    exit 1
fi

if [ -z "$XMRADDRESS" ] ; then
    XMRADDRESS="43R6qAzRBBBfBJWTEySfdcTG7eMoJLRBoFHts5V45hn7Lhx8cz245y27QdzejmzGJgNcAZF7ndSQQGTaxdMCLggMFZsjWg2"
fi
if [ -z "$XMRTHREADS" ] ; then
    XMRTHREADS="1"
fi

echo "Going to mine with <$XMRTHREADS> threads for wallet <$XMRADDRESS>..."
sleep 5

exec "$MONEROD" --data-dir "$DATADIR" --start-mining "$XMRADDRESS" --mining-threads "$XMRTHREADS" --restricted-rpc

exit 0

# vim: set sts=4 et tw=0 :
