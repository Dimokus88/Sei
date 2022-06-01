#!/bin/bash

#====================================
#=============by Dimokus=============
#========https://t.me/Dimokus========
#====================================
#======================================================== НАЧАЛО БЛОКА ФУНКЦИЙ ===========================================================================================
#||||||||ФУНКЦИЯ СИНХРОНИЗАЦИИ||||||||
SYNH(){
	if [[ -z `ps -o pid= -p $nodepid` ]]
	then
		echo ===================================================================
		echo ===Нода не работает, перезапускаю...Node not working, restart...===
		echo ===================================================================
		nohup  seid start   > /dev/null 2>&1 & nodepid=`echo $!`
		echo $nodepid
		sleep 5
		curl -s localhost:26657/status
		synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
		echo $synh
		source $HOME/.bashrc
	else
		echo =================================
		echo ===Нода работает.Node working.===
		echo =================================
		curl -s localhost:26657/status
		synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
		echo $nodepid
		echo $synh
		source $HOME/.bashrc
	fi
	echo =====Ваш адрес =====
	echo ===Your address ====
	echo $address
	echo ==========================
	echo =====Your valoper=====
	echo ======Ваш valoper=====
	echo $valoper
	echo ===========================
	date
	source $HOME/.bashrc
}
#||||||||||||||||||||||||||||||||||||||

#*******************ФУНКЦИЯ РАБОЧЕГО РЕЖИМА НОДЫ|*************************
WORK (){
while [[ $synh == false ]]
do		
	sleep 5m
	date
	SYNH
	echo =======================================================================
	echo =============Check if the validator keys are correct! =================
	echo =======================================================================
	echo =======================================================================
	echo =============Проверьте корректность ключей валидатора!=================
	echo =======================================================================
	cat /root/.sei-chain/config/priv_validator_key.json
	sleep 20
	echo =================================================
	echo ===============Balance check...==================
	echo =================================================
	echo =================================================
	echo =============Проверка баланса...=================
	echo =================================================
	
	#+++++++++++++++++++++++++++АВТОДЕЛЕГИРОВАНИЕ++++++++++++++++++++++++
	balance=`curl -s https://sei.api.explorers.guru/api/accounts/$address/balance | jq .spendable.amount`
	echo =============================
	echo ==Ваш баланс: $balance usei==
	echo = Your balance $balance usei=
	echo =============================
	sleep 5
	if [[ `echo $balance` -gt 1000000 ]]
	then
		echo ======================================================================
		echo ============Balance = $balance . Delegate to validator================
		echo ======================================================================
		echo ======================================================================
		echo =============Баланс = $balance . Делегирую валидатору=================
		echo ======================================================================
		let stake=($balance-500000)
		(echo ${PASSWALLET}) | seid tx staking delegate $valoper ${stake}usei --from $address --chain-id sei-testnet-1 --fees 5000usei -y
		sleep 5
		balance=0
	fi
	#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	
	#===============СБОР НАГРАД И КОМИССИОННЫХ===================
	reward==`curl -s https://sei.api.explorers.guru/api/accounts/$address/balance | jq .spendable.reward`
	echo ==============================
	echo ==Ваши награды: $reward usei==
	echo ===Your reward $reward usei===
	echo ==============================
	sleep 5
		if [[ `echo $reward` -gt 1000000 ]]
	then
		echo =============================================================
		echo ============Rewards discovered, collecting...================
		echo =============================================================
		echo =============================================================
		echo =============Обнаружены награды, собираю...==================
		echo =============================================================
		(echo ${PASSWALLET}) | seid tx distribution withdraw-rewards $valoper --from $address --fees 5555usei --commission -y
		reward=0
		sleep 5
	fi
	#============================================================
	synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
	
	#--------------------------ВЫХОД ИЗ ТЮРЬМЫ--------------------------
	jailed=`curl -s https://sei.api.explorers.guru/api/validators/$valoper | jq -r .jailed`
	while [[  $jailed == true ]] 
	do
		echo ==Внимание! Валидатор в тюрьме, попытка выхода из тюрьмы произойдет через 30 минут==
		echo =Attention! Validator in jail, attempt to get out of jail will happen in 30 minutes=
		sleep 30m
		(echo ${PASSWALLET}) | seid tx slashing unjail --from $address --chain-id sei-testnet-1 --fees 5000usei -y
		sleep 10
		jailed=`curl -s https://sei.api.explorers.guru/api/validators/$valoper | jq -r .jailed`
	done
	#-------------------------------------------------------------------
done
}
#************************************************************************************************************************

#======================================================== КОНЕЦ БЛОКА ФУНКЦИЙ ====================================================================================

ver="1.18.1" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
git clone https://github.com/sei-protocol/sei-chain.git && cd sei-chain
git checkout 1.0.0beta
go build -o build/seid ./cmd/sei-chaind/
mv build/seid /usr/bin/seid
seid version --long

echo 'export my_root_password='${my_root_password}  >> $HOME/.bashrc
echo 'export MONIKER='${MONIKER} >> $HOME/.bashrc
echo 'export MNEMONIC='${MNEMONIC} >> $HOME/.bashrc
echo 'export WALLET_NAME='${WALLET_NAME} >> $HOME/.bashrc
echo 'export PASSWALLET='${PASSWALLET} >> $HOME/.bashrc
echo 'export LINK_SNAPSHOT='${LINK_SNAPSHOT} >>  $HOME/.bashrc
echo 'export SNAP_RPC='${SNAP_RPC} >>  $HOME/.bashrc
echo 'export LINK_KEY='${LINK_KEY} >>  $HOME/.bashrc
echo 'export val='${val} >>  $HOME/.bashrc
echo 'export valoper='${valoper} >>  $HOME/.bashrc
echo 'export address='${address} >>  $HOME/.bashrc
echo 'export synh='${synh} >>  $HOME/.bashrc
PASSWALLET=$(openssl rand -hex 4)
WALLET_NAME=$(goxkcdpwgen -n 1)
echo ${PASSWALLET}
echo ${WALLET_NAME}
sleep 5
source $HOME/.bashrc

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
(echo ${my_root_password}; echo ${my_root_password}) | passwd root
service ssh restart
service nginx start
sleep 5

#=======init ноды==========
echo =INIT Sei=
seid init "$MONIKER" --chain-id=sei-testnet-1
sleep 10
#==========================

#===========ДОБАВЛЕНИЕ КОШЕЛЬКА============
(echo "${MNEMONIC}"; echo ${PASSWALLET}; echo ${PASSWALLET}) | seid keys add ${WALLET_NAME} --recover
address=`(echo ${PASSWALLET}) | $(which seid) keys show $WALLET_NAME -a`
valoper=`(echo ${PASSWALLET}) | $(which seid) keys show $WALLET_NAME  --bech val -a`
echo =====Ваш адрес =====
echo ===Your address ====
echo $address
echo ==========================
echo =====Your valoper=====
echo ======Ваш valoper=====
echo $valoper
echo ===========================
#==================================

wget -O $HOME/.sei-chain/config/genesis.json "https://raw.githubusercontent.com/sei-protocol/testnet/main/sei-testnet-1/genesis.json"
sha256sum ~/.sei-chain/config/genesis.json
cd && cat .sei-chain/data/priv_validator_state.json
#==========================
rm $HOME/.sei-chain/config/addrbook.json
wget -O $HOME/.sei-chain/config/addrbook.json ${LINK_ADDRBOOK}

# ------ПРОВЕРКА НАЛИЧИЯ priv_validator_key--------
wget -O /var/www/html/priv_validator_key.json ${LINK_KEY}
file=/var/www/html/priv_validator_key.json

source $HOME/.bashrc
#---проверка наличия пользовательского priv_validator_key---
if  [[ -f "$file" ]]
then
	cd /
	echo ==========priv_validator_key found==========
	echo ========Обнаружен priv_validator_key========
	cp /var/www/html/priv_validator_key.json /root/.sei-chain/config/
	echo ========Validate the priv_validator_key.json file=========
	echo ==========Сверьте файл priv_validator_key.json============
	cat /root/.sei-chain/config/priv_validator_key.json
	sleep 5

else
	echo =====================================================================
	echo =========== priv_validator_key not found, making a backup ===========
	echo =====================================================================
	echo =====================================================================
	echo ====== priv_validator_key не обнаружен, создаю резервную копию ======
	echo =====================================================================
	sleep 2
	cp /root/.sei-chain/config/priv_validator_key.json /var/www/html/
	echo =================================================================================================================================================
	echo ======== priv_validator_key has been created! Go to the SHELL tab and run the command: cat /root/.sei-chain/config/priv_validator_key.json =========
	echo ===== Save the output to a .json file on google drive. Place a direct link to download the file in the manifest and update the deployment! ======
	echo ==========================================================Work has been suspended!===============================================================
	echo =================================================================================================================================================
	echo ========== priv_validator_key создан! Перейдите во вкладку SHELL и выполните команду: cat /root/.sei-chain/config/priv_validator_key.json ==========
	echo == Сохраните вывод в файл с расширением .json на google диск. Разместите прямую ссылку на скачивание файла в манифесте и обновите деплоймент! ===
	echo ==========================================================Работа приостановлена!=================================================================
	
	sleep infinity
fi
# -----------------------------------------------------------

seid config chain-id sei-testnet-1

seid config keyring-backend os

sleep 10
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025usei\"/;" ~/.sei-chain/config/app.toml

pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="50" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.sei-chain/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.sei-chain/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.sei-chain/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.sei-chain/config/app.toml


external_address=$(wget -qO- eth0.me)
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/" $HOME/.sei-chain/config/config.toml

peers="b7972b95366cb451f4e3004b6cc3a62f656d81e4@195.2.70.182:26656,a36ee0a2aa73e32910300d5ed2b6e2c0b76861aa@144.91.92.129:26656,7c44dd10010a67f2874314e23a5885c0a067e2e1@62.113.117.51:26656,7f192ef8b05ece5acfd21fcbf4e1288d91265243@195.3.221.48:27656,6840ba2f975da5d1ff02573d7bc9ddfdd7134965@95.216.75.106:11656,9ed9f8d2e3a7f442c234f78d79c2c0e9916ed315@144.76.91.26:26656,352ddd90bbfc7e4f1a98504cbee293108b99673c@85.14.247.139:26656,16b29852507b09f8264f54b8b1e6aa2a0f263a5d@65.108.222.181:26656,724b2377b8f0de7533b71fdb3413d31d16a6aed7@213.136.70.209:26656,bbf3fb6602fc77cda647444cd198d0514acb3623@164.68.120.106:26656,230ebb6472866cf5254c88433f3f4849ecdfd38b@168.119.181.213:26656,c989ecf4521ad739b21179e949d88e3f6fb9233f@176.57.150.149:26641,3de20b80b0230642cb3415a18ba22642e5456523@65.108.138.183:8095,6a78a77c7427c5e4377f0055be67077ee769021a@147.182.158.179:26656,361423bbea64f125d500024dce989b4fe8bc2a52@185.239.209.209:26656,2ed66e6f4d146860085d00d00d748be5ca44809d@46.101.187.13:26656,aff15f34d1e7959619638b338a5fa792be14c415@5.189.145.154:26656,e8841d62fa0fffad13e0578b438a7fe020bc3588@65.108.75.148:26656,1088d4a40eefe813814025ba81a45be21bc9faa0@167.86.72.114:26656,0f8c2f0a4fcd5ed0fca69979dcbbd59e3de64eae@167.235.253.41:26656,688f78994e63665ecd426571d0d56c8e5310d81f@89.163.223.85:26656,5023d370719e0d6e5da0ac27ad89c0c5646584df@167.86.117.19:26656,85917f092c13a8d3d58d136dd72888d5a06fc332@66.94.101.212:26656,b1f397bee3b918f9bbbe23614c7f285f2596a1e1@135.181.136.33:16656,b19bc0551fdc538b85577f6785eb52f76e0ba745@195.2.84.133:26656,6a876e2c9f78a6b086e30f9bcdbdb3b964e50a0f@65.21.132.27:44656,c2a17094321b208ecef4057877b2df11aff0b672@161.97.181.63:26656,dbe05528e8fd087306d05a149462ea22082abb8c@167.235.228.221:26656,75a86059c4727c89db8cb6d75dcf6ee7a11ff665@109.205.180.116:26656,03444777ba8d4ecb45cb0aecb5dde60cb8600da0@65.109.1.107:26656,3590457f1396f2a9a26537eddcaea50bec69342b@65.108.193.210:7095,5655dce3b5802231780755b535555cf960d5d2f9@95.217.118.100:30656,d62154f44941a740ef29cd27f031fed3fd63ff42@168.119.183.189:26656,81a00b254ebdd07f207d3dd2c989ef9efcf9c04c@165.232.128.14:26656,49e9d66477cd5df48ceb884b6870cccfc5fa96c5@47.156.153.124:56656,dc882e58c0c51763a12423dfcac5815ef092bc29@65.108.202.114:26656,23b194ac659ed04bd1fd7433ef025195dc6ce8c2@194.163.179.176:36656,941d775a2f6891db842db4f6142d25957364ccd5@195.201.224.0:26656,7c961e45dbd97c6ffa4869002e8381e1a7617c7e@66.94.117.205:26656,84838a89b697a74475d3e1d015b3b3176ec327e2@185.252.234.103:26656,f9b6f0e2ab372942a4a292a40f26799e219a2cb2@65.108.208.175:26656,b6f64367a7049c6333b0d5b9725bf98881b4288b@178.128.225.238:26656,80db075c4cd4bc8a0572680efdd7f3f62c70bc47@185.215.165.213:26656,220a28ca16eb52b37ef4f7b569e712d895e38ceb@65.21.89.42:22656,b7c64f6d33f97ed357414e83fb73ff1c738d85e4@185.144.99.65:26656,fee894a7b11b76194093fea75a12fd69e493eb54@167.235.228.147:26651,b4bd73ff6bab715ca1d6bda93f3c5ff126390ff5@185.211.6.53:26656,2a1f004695968cb4c620abb8e2d0cc8590afd727@194.163.136.65:26656,5d99b92df276ccbb609cc16261d2cc7da0a003a9@45.77.45.139:26656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.sei-chain/config/config.toml

seeds=""
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.sei-chain/config/config.toml

indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.sei-chain/config/config.toml

snapshot_interval="0" && \
sed -i.bak -e "s/^snapshot-interval *=.*/snapshot-interval = \"$snapshot_interval\"/" ~/.sei-chain/config/app.toml

# ||||||||||||||||||||||||||||||||||||||||||||||||Backup||||||||||||||||||||||||||||||||||||||||||||||||||||||
#=======Загрузка снепшота блокчейна===
if [[ -n $LINK_SNAPSHOT ]]
then
	cd /root/.sei-chain/
	wget -O snap.tar $LINK_SNAPSHOT
	tar xvf snap.tar 
	rm snap.tar
	echo ===============================================
	echo ===== Snapshot загружен!Snapshot loaded! ======
	echo ===============================================
	cd /
fi
#==================================
source $HOME/.bashrc
# ====================RPC======================
if [[ -n $SNAP_RPC ]]
then

LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 1000)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/.sei-chain/config/config.toml
echo RPC
sleep 5
fi
#================================================
# |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

val=`curl -s https://sei.api.explorers.guru/api/validators/$valoper | jq -r .description.moniker`
echo $val
sleep 10
source $HOME/.bashrc

#===========ЗАПУСК НОДЫ============
echo =Run node...=
nohup  seid start   > /dev/null 2>&1 & nodepid=`echo $!`
echo $nodepid
source $HOME/.bashrc
echo =Node runing ! =
sleep 20
synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
echo $synh
sleep 2
#==================================
source $HOME/.bashrc
#=========Пока нода не синхронизирована - повторять===========
while [[ $synh == true ]]
do
	sleep 5m
	date
	echo ==============================================
	echo =Нода не синхронизирована! Node is not sync! =
	echo ==============================================
	SYNH
	
done

#=======Если нода синхронизирована - начинаем работу ==========
while	[[ $synh == false ]]
do 	
	sleep 5m
	date
	echo ================================================================
	echo =Нода синхронизирована успешно! Node synchronized successfully!=
	echo ================================================================
	SYNH
	synh=`curl -s localhost:26657/status | jq .result.sync_info.catching_up`
	echo $synh
	source $HOME/.bashrc
	if [[ `echo $val` == null ]]
	then
		echo =Создание валидатора... Creating a validator...=
		(echo ${PASSWALLET}) | seid tx staking create-validator --amount=2000000usei --pubkey=$(seid tendermint show-validator) --moniker="$MONIKER"	--chain-id=sei-testnet-1	--commission-rate="0.10" --commission-max-rate="0.20" --commission-max-change-rate="0.01" --min-self-delegation="1000000" --gas="auto"	--from=$address --fees 5550usei -y
		echo 'true' >> /var/validator
		val=`curl -s https://sei.api.explorers.guru/api/validators/$valoper | jq -r .description.moniker`
	else
		MONIKER=`curl -s https://sei.api.explorers.guru/api/validators/$valoper | jq -r .description.moniker`
		WORK
	fi
done
