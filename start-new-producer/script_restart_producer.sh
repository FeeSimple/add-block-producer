# Script to start a new producer that is connected to the testnet via peer list

## Producer params
httpServerAddr=127.0.0.1:8005
p2pListenEndpoint=0.0.0.0:9005
producerName=trungprod111
producerKeyPair='["EOS5sxsW17cvjcviWz4U6VSm9Ca84n6KkEbXk23eoX9GqMkYsfqYd","5KSGw8iY8eaVcLxLUTh4CUB2Wzc23afWoWwfKMHNbJUPk5amB7z"]'
producerPeerList='--p2p-peer-address 138.197.194.220:9000 --p2p-peer-address 138.197.194.220:9001 --p2p-peer-address 138.197.194.220:9002'
producerPluginList='--plugin eosio::http_plugin --plugin eosio::chain_api_plugin --plugin eosio::producer_plugin'

## For restart
REPLAY='--replay-blockchain --hard-replay-blockchain'

## cmd
./nodeos --max-irreversible-block-age -1 --contracts-console --blocks-dir ./blocks --config-dir ./ --data-dir ./ --http-server-address $httpServerAddr --p2p-listen-endpoint $p2pListenEndpoint --max-clients 14 --p2p-max-nodes-per-host 14 --enable-stale-production --producer-name $producerName --private-key $producerKeyPair $producerPeerList $producerPluginList --http-validate-host false $REPLAY 2>>./stderr &
