# Adding a new producer to the testnet

The currently deployed testnet (138.197.194.220) includes 4 producers running on same server. The testnet producer status can be viewed here:

https://feesimpletracker.io/producers

The following instructions describe the steps for adding a new producer to the testnet. For this example, the new producer (trungprod111) is located on the feesimplewallet server.

### Need a staked account

Create a new account and request faucet with:

https://feesimplewallet.io/

Remember to store the private key :)

### Deploy a producer on new server

A running producer normally occupies between 1.5GB RAM and 2GB RAM. However, your server should have min 4GB RAM. 

Pre-built software on Ubuntu can be found here:

https://drive.google.com/open?id=1RrnShLfefEKCzdmcsAIzeoKkreSjZMDn

Download the required software (nodeos, cleos and keosd) into the folder `start-new-producer`
which contains the needed scripts.

Start the producer by executing the script `script_start_producer.sh`.
To restart the producer with preserved blockchain data, execute the script `script_restart_producer.sh`.

### Register the producer

This is done by executing the following commands:

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

Check if the new producer is incorporated into the testnet by viewing this:

https://feesimpletracker.io/

and this:

https://feesimpletracker.io/producers

Note that the producer name is identical to the account name used in the command `system regproducer`

### Unregister the producer from the testnet

This is done by executing the following commands:

```
// Unapprove producer
cleos --wallet-url http://localhost:6666 --url http://138.197.194.220:8877 system voteproducer unapprove usertrung123 trungprod111

// Unregister as producer
cleos --wallet-url http://localhost:6666 --url http://138.197.194.220:8877 system unregprod trungprod111

```

Note that, after unregistered, the producer is still producing blocks and is not removed from the active producer list. An explanation can be found here:

https://github.com/EOSIO/eos/issues/5531


### Stop the producer

To turn off the producer so that it stops producing blocks, simply terminate the producer process.

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

Open this link with a web browser:

http://138.197.194.220:8877/v1/chain/get_info


## If this does not work, perform the following steps:

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
