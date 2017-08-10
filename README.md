# CareChain Ethereum node Docker image

Boot node example:

      bootnode:
        image: carechain/ethereum-node
        ports:
          - "30303:30303"
          - "30303:30303/udp"
        volumes:
          - ./config:/config
          - ./data/bootnode:/root/.ethereum
        environment:
          - NODE_TYPE=boot
          - ETHSTATS_HOST=${ETHSTATS_HOST}
          - ETHSTATS_NAME=boot
          - ETHSTATS_SECRET=${ETHSTATS_SECRET}


Signer node example:

      signer:
        image: carechain/ethereum-node
        ports:
          - "30403:30303"
          - "30403:30303/udp"
        volumes:
          - ./config:/config
          - ./data/signer:/root/.ethereum
        environment:
          - NODE_TYPE=signer
          - BOOTNODES=${BOOTNODES}
          - MAXPEERS=50
          - ETHSTATS_HOST=${ETHSTATS_HOST}
          - ETHSTATS_NAME=signer
          - ETHSTATS_SECRET=${ETHSTATS_SECRET}
          - TARGETGASLIMIT=4712388
          - GASPRICE=18000000000

API node example:

      api:
        image: carechain/ethereum-node
        ports:
          - "30603:30303"
          - "30603:30303/udp"
          - "8545:8545"
        volumes:
          - ./config:/config
          - ./data/api:/root/.ethereum
        environment:
          - NODE_TYPE=api
          - BOOTNODES=${BOOTNODES}
          - RPCPORT=8545
          - ETHSTATS_HOST=${ETHSTATS_HOST}
          - ETHSTATS_NAME=api
          - ETHSTATS_SECRET=${ETHSTATS_SECRET}
