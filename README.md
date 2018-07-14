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
