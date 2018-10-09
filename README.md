# Add a new producer to the testnet

The currently-deployed testnet (138.197.194.220) includes 4 producers running on same server.
The testnet producer status can be viewed at here:

https://feesimpletracker.io/producers

The following instruction describes the steps for adding a new producer to the testnet.
Ultimate goal is to get the testnet decentralized.

In this instruction, the new producer whose name is `trungprod111` is located on the feesimplewallet server.

### Need a staked account

Can create a new account and request faucet with

https://feesimplewallet.io/

Remember to store the private key

In this instruction, the newly-created account used as producer is `trungprod111`

### Deploy a producer on new server

Server should have min 4GB RAM.
A running producer normally occupies between 1.5GB RAM and 2GB RAM.

Pre-built software on Ubuntu can be found at here

https://drive.google.com/open?id=1RrnShLfefEKCzdmcsAIzeoKkreSjZMDn

Download the needed software (nodeos, cleos and keosd) into the folder `start-new-producer`
where it contains needed scripts.

Start the producer by executing the script `script_start_producer.sh`.
For restarting the producer with preserved blockchain data, execute the script `script_restart_producer.sh`.

### Register the producer to join the testnet

This is done by executing the following commands one by one:

```
1. Start wallet manager `keosd`

keosd --http-server-address=127.0.0.1:6666 --http-validate-host=false &

2. Create wallet

cleos wallet create

3. Check the list of current producers

cleos --wallet-url http://localhost:6666 --url http://138.197.194.220:8877 system listproducers

// Import priv key of the producer account to be registered (e.g. trungprod111)
cleos --wallet-url http://localhost:6666 --url http://138.197.194.220:8877 wallet import --private-key 5KSGw8iY8eaVcLxLUTh4CUB2Wzc23afWoWwfKMHNbJUPk5amB7z

// Register as producer
cleos --wallet-url http://localhost:6666 --url http://138.197.194.220:8877 system regproducer trungprod111 EOS5sxsW17cvjcviWz4U6VSm9Ca84n6KkEbXk23eoX9GqMkYsfqYd https://trungprod111.com/EOS5sxsW17cvjcviWz4U6VSm9Ca84n6KkEbXk23eoX9GqMkYsfqYd

// Approve producer
cleos --wallet-url http://localhost:6666 --url http://138.197.194.220:8877 system voteproducer approve usertrung123 trungprod111

```

Eventually, check if the new producer is incorporated into the testnet by viewing this:

https://feesimpletracker.io/

and this

https://feesimpletracker.io/producers

Noted that, producer name is identical to the account name used in the command `system regproducer`

### Unregister the producer from the testnet

This is done by executing the following commands one by one:

```
// Unapprove producer
cleos --wallet-url http://localhost:6666 --url http://138.197.194.220:8877 system voteproducer unapprove usertrung123 trungprod111

// Unregister as producer
cleos --wallet-url http://localhost:6666 --url http://138.197.194.220:8877 system unregprod trungprod111

```

Noted that, after having unregistered, the producer is still producing blocks and is not really removed
from the active producer list. Explanation can be found at here:

https://github.com/EOSIO/eos/issues/5531


### Stop the producer

To completely turn off the producer so that it stops producing blocks, simply terminate the producer process.

```
// Find the producer proc ID
ps aux | grep nodeos

// Kill it
kill -9 {PID}
```

# Start/Stop/Control Testnet

### Access testnet

`ssh root@138.197.194.220`

### Check process status

`pm2 status`

### Restart all processes

`pm2 restart all`

### Check testnet status

Open this link with some web browser:

http://138.197.194.220:8877/v1/chain/get_info


## If not work, do the following steps

### cd to folder of bios-boot-tutorial

`cd ~/eos-release1.1/tutorials/bios-boot-tutorial`

### Cleanup

```
pm2 delete all
./cleanup.sh`
```

### Run the bios-boot-tutorial script for deploying the testnet

`pm2 start script_bios_boot.sh`

### cd to folder bios_boot_script

`cd ~/bios_boot_script`

### kill MongoDB server

`killall mongod`

### Start MongoDB server

`./script_mongo_start.sh`

Observe MongoDB server log with `./script_mongo_view_log.sh`

### cd to the client node folder

`cd ~/eos-tracker/nodeos/client_node_connect_to_testnet_mongo`

### Start the client nodeos

```
rm -rf blocks
rm -rf state
pm2 start script_client_nodeos.sh
```
