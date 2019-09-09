# Script to start a new producer that is connected to the blockchain network via peer list

## Producer params
httpServerAddr=0.0.0.0:8001
p2pListenEndpoint=0.0.0.0:9001
producerName=prodwallet11
producerKeyPair='["EOS7d4fQXjJnvsverft9ooGd2YnkzSd1xRLgFAUA6BrwDctUavxtt","5JhV5JtjxfKH8rYmoq75fSa8kJMKexLnB74cC48C1uCvgCwZBzR"]'
producerPeerList='--p2p-peer-address 165.22.134.182:9000 --p2p-peer-address 165.22.134.182:9001 --p2p-peer-address 165.22.134.182:9002'
producerPluginList='--plugin eosio::http_plugin --plugin eosio::chain_api_plugin --plugin eosio::producer_plugin'

## cmd
/usr/bin/nodeos --max-irreversible-block-age -1 --contracts-console --genesis-json ./genesis.json --blocks-dir ./blocks --config-dir ./ --data-dir ./ --http-server-address $httpServerAddr --p2p-listen-endpoint $p2pListenEndpoint --max-clients 14 --p2p-max-nodes-per-host 14 --enable-stale-production --producer-name $producerName --private-key $producerKeyPair $producerPeerList $producerPluginList --http-validate-host false --delete-all-blocks  2>>./stderr &

