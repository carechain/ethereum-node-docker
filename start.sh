#!/usr/bin/env sh

: ${NETWORK_ID:=41358}
: ${PORT:=30303}
: ${CACHE:=512}
: ${MAXPEERS:=512}
: ${ETHSTATS_NAME:="name"}
: ${ETHSTATS_SECRET:="secret"}
: ${ETHSTATS_HOST:="host"}
: ${ETHSTATS_PORT:=80}
: ${BOOTNODES:=""}
: ${LIGHTSERV:=50}
: ${LIGHTPEERS:=256}
: ${TARGETGASLIMIT:=4712388}
: ${GASPRICE:=18000000000}
: ${RPCPORT:=8545}
: ${RPCAPI:="[\"eth\", \"net\", \"web3\", \"shh\"]"}
: ${RPCCORSDOMAIN:="[\"*\"]"}
: ${ACCOUNT_FILE:=""}

nodetype=$1

case $nodetype in
    boot)
        TYPE_ARGS="--lightserv $LIGHTSERV --lightpeers $LIGHTPEERS --v5disc"
    ;;
    signer)
        TYPE_ARGS="--mine --targetgaslimit $TARGETGASLIMIT --gasprice $GASPRICE"
    ;;
    api)
#        TYPE_ARGS="--rpc --rpcaddr 0.0.0.0 --rpcport $RPCPORT --rpcapi $RPCAPI --rpccorsdomain $RPCCORSDOMAIN --shh"
        TYPE_ARGS="--config /config.toml --shh"
    ;;
    *)
        echo "Invalid node type $nodetype"
        exit 1
esac

GETH_ARGS="--networkid $NETWORK_ID --port $PORT --cache $CACHE --maxpeers $MAXPEERS $TYPE_ARGS --ethstats $ETHSTATS_NAME:$ETHSTATS_SECRET@$ETHSTATS_HOST:$ETHSTATS_PORT"

if [ ! -z "$BOOTNODES" ]
then
    GETH_ARGS="$GETH_ARGS --bootnodes $BOOTNODES"
fi

if [ ! -z "$ACCOUNT_FILE" ]
then
    mkdir -p /root/.ethereum/keystore/ && cp /config/${ACCOUNT_FILE}.json /root/.ethereum/keystore/
    GETH_ARGS="$GETH_ARGS --unlock 0 --password /config/${ACCOUNT_FILE}.pass"
fi

echo "NODETYPE: $nodetype"
echo "ARGS: $GETH_ARGS"

/usr/local/bin/geth init /config/genesis.json
/usr/local/bin/geth $GETH_ARGS
