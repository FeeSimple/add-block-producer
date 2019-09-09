# Adding a new producer to the blockchain network

The currently deployed network (165.22.134.182) includes 2 producers running on same server. The network producer status can be viewed here:

https://feesimpletracker.io/producers

The following instructions describe the steps for adding a new producer to the network. For this example, the new producer named `prodwallet11` is located on the `feesimplewallet` server.

### Need a staked account

Create a new account named `prodwallet11` with https://fsmanager.io 
Can also request faucet with https://feesimplewallet.io/

Remember to store the private key :)

### Deploy a producer on new server

A running producer normally occupies between 1.5GB RAM and 2GB RAM. However, your server should have min 4GB RAM. 

Download and install the EOSIO software (including `nodeos`, `cleos` and `keosd`) **version 1.6**
https://github.com/EOSIO/eos/releases/tag/v1.6.0


Needed scripts are located in the sub-folder `start-new-producer`

Start the producer by executing the script `script_start_producer.sh`.
To restart the producer with preserved blockchain data, execute the script `script_restart_producer.sh`.

### Register the producer

This is done by executing the following commands:

1. Start wallet manager `keosd`

`keosd --http-server-address=127.0.0.1:6666 --http-validate-host=false &`

2. Create wallet (if not yet)

`cleos wallet create --to-console`

or unlock the existing wallet

`cleos --wallet-url http://localhost:6666 wallet unlock`

3. Check the list of current producers

`cleos --wallet-url http://localhost:6666 --url http://165.22.134.182:8877 system listproducers`

4. Import priv key of the producer account to be registered (e.g. `prodwallet11`)

```
cleos --wallet-url http://localhost:6666 --url http://165.22.134.182:8877 wallet import --private-key 5JhV5JtjxfKH8rYmoq75fSa8kJMKexLnB74cC48C1uCvgCwZBzR
```

5. Register the producer with its pub key

```
cleos --wallet-url http://localhost:6666 --url http://165.22.134.182:8877 system regproducer prodwallet11 EOS7d4fQXjJnvsverft9ooGd2YnkzSd1xRLgFAUA6BrwDctUavxtt https://prodwallet11.com/EOS7d4fQXjJnvsverft9ooGd2YnkzSd1xRLgFAUA6BrwDctUavxtt
```

6. Approve the producer from any other user account (e.g. `usertrung123`)

```
cleos --wallet-url http://localhost:6666 --url http://165.22.134.182:8877 system voteproducer approve usertrung123 prodwallet11

```

**Notice**

Private key of the voting user account (e.g. `usertrung123`) must be imported before being able to use it

7. Check if the new producer is incorporated into the network by viewing this:

https://feesimpletracker.io/producers


**Notice**

The producer name is identical to the account name used in the command `system regproducer`

### Unregister the producer from the network

This is done by executing the following commands:

```
// Unapprove producer
cleos --wallet-url http://localhost:6666 --url http://165.22.134.182:8877 system voteproducer unapprove usertrung123 prodwallet11

// Unregister as producer
cleos --wallet-url http://localhost:6666 --url http://165.22.134.182:8877 system unregprod prodwallet11
```


**Notice**

After unregistered, the producer is still producing blocks and is not removed from the active producer list. An explanation can be found here:

https://github.com/EOSIO/eos/issues/5531


### Stop the producer

To turn off the producer so that it stops producing blocks, simply terminate the producer process.

```
// Find the producer proc ID
ps aux | grep nodeos

// Kill it
kill -9 {PID}
```

# Start/Stop/Control network

### Access network

`ssh root@165.22.134.182`

### Check process status

`pm2 status`

### Restart all processes

`pm2 restart all`

### Check network status

Open this link with a web browser:

http://165.22.134.182:8877/v1/chain/get_info


## If this does not work, perform the following steps:

### cd to folder of bios-boot-tutorial

`cd ~/eos-release1.1/tutorials/bios-boot-tutorial`

### Cleanup

```
pm2 delete all
./cleanup.sh`
```

### Run the bios-boot-tutorial script for deploying the network

`pm2 start script_bios_boot.sh`

### cd to folder bios_boot_script

`cd ~/bios_boot_script`

### kill MongoDB server

`killall mongod`

### Start MongoDB server

`./script_mongo_start.sh`

Observe MongoDB server log with `./script_mongo_view_log.sh`

### cd to the client node folder

`cd ~/eos-tracker/nodeos/client_node_connect_to_network_mongo`

### Start the client nodeos

```
rm -rf blocks
rm -rf state
pm2 start script_client_nodeos.sh
```
