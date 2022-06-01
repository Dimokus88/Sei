# Sei validator node on Akash Network
# Нода валидатора сети Sei, развертка в Akash Network.
<div align="center">

![pba](https://user-images.githubusercontent.com/23629420/163564929-166f6a01-a6e2-4412-a4e9-40e54c821f05.png)
| [Akash Network](https://akash.network/) | [Forum Akash Network](https://forum.akash.network/) | 
|:--:|:--:|
___
Before you start - subscribe to our news channels: 

Прежде чем начать - подпишитесь на наши новостные каналы:

| [Discord Akash](https://discord.gg/3SNdg3BS) | [Telegram Akash EN](https://t.me/AkashNW) | [Telegram Akash RU](https://t.me/akash_ru) | [TwitterAkash](https://twitter.com/akashnet_) | [TwitterAkashRU](https://twitter.com/akash_ru) |
|:--:|:--:|:--:|:--:|:--:|

</div>
<div align="center">
  
| [Discord Sei](https://discord.gg/3A3TdWfF) | [Explorer Sei](https://sei.explorers.guru/) | [Site Sei](https://www.seinetwork.io/) | [Twitter Sei](https://twitter.com/SeiNetwork) |
|:--:|:--:|:--:|:--:|
  
</div>
<div align="center">
  
[English version](https://github.com/Dimokus88/Sei#english-version) | [Русская версия](https://github.com/Dimokus88/Sei#%D1%80%D1%83%D1%81%D1%81%D0%BA%D0%B0%D1%8F-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%8F)
  
[Useful Commands | Полезные команды](https://github.com/Dimokus88/Sei#useful-commands--%D0%BF%D0%BE%D0%BB%D0%B5%D0%B7%D0%BD%D1%8B%D0%B5-%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B)
</div>

# English version

Fill out the [form](https://forms.gle/CzBeqENRZrrXXG4x7) . Tasks for a testnet [this](https://3pgv.notion.site/All-Testnet-Missions-16c0a40320244c24b0bc3f663c0cf00b) !

> If you want to migrate your Sei node to Akash, or if you have priv_validator_key.json, then go [to this step](https://github.com/Dimokus88/Sei#if-you-have-priv_validator_keyjson).

>You must have more than ***5 AKT*** on your Akash wallet (5 АКТ will be blocked for deployment + transaction gas payment). АКТ can be found on the exchanges Gate, AsendeX, Osmosis . Also in our community[Akash RU](https://t.me/akash_ru) we regularly hold events in which we distribute АКТ.

## If starting for the first time:

***Create an additional Cosmos ecosystem wallet for the Sei project using Keplr or Cosmostation. Rewrite the seed phrase from the created wallet, we will need it when deploying.***

* Open ***Akashlytics***,if you don't have it installed, then [link for download](https://www.akashlytics.com/deploy).

* We check the presence of a balance  ***(>5АКТ)*** and the presence of an installed certificate.

![image](https://user-images.githubusercontent.com/23629420/165339432-6f053e43-4fa2-4429-8eb7-d2fc66f47c70.png)

* Click ***CREATE DEPLOYMENT***. Select ***Empty*** and copy the contents there [deploy.yml](https://github.com/Dimokus88/Sei/blob/main/deploy.yml)

* Let's take a look at what is there, so the ```services``` section indicates the ```docker``` node image, as well as a block with environment variables ```env```:

* ```my_root_password``` - password  ```root``` user, for connection to container via ```ssh```.
* ```MONIKER```       - Node name .
* ```MNEMONIС```      -  insert the mnemonic phrase from your wallet ***Sei***.
* ```LINK_ADDRBOOK```       - link addrbook.json
* ```SNAP_RPC```      - link RPC node.
> ```LINK_KEY``` -  comment out the env to the priv_validator_key.json. 

In the ```resources``` field, we set the capacity to be rented. ```4 CPU x 32 GB RAM x 1 TB SSD``` recommended for ***Sei*** node. 

* Click on ```CREATE DEPLOYMENT``` and we are waiting for the appearance of providers with free capacities (BIDS).

![image](https://user-images.githubusercontent.com/23629420/165608527-da85c84e-edcc-4b15-8843-441d3e76dcb6.png)


* We choose the one that suits us in terms of price and equipment. Then we press ```ACCEPT BID```.

We are waiting for the completion of the deployment.

* In the ```LOGS``` tab, wait for a message about the generated file ```priv_validator_key.json``` .

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171269920-572ee8c5-5e9b-4b3f-b7a6-56f704200d7a.png)
  
</div>

* In the ```SHELL``` tab, run the command```cat /root/.sei-chain/config/priv_validator_key.json```, save the answer in a file```priv_validator_key``` with extension```.json```.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171270286-4d33c89d-64c8-4807-b8a1-ca853163fd42.png)
  
</div>

> Then open access to the file on google drive and copy its link, it will look like:
```https://drive.google.com/open?id=xxxxxxxxxxxxxx-xxxxxxxxxxxx&authuser=gmail%40gmail.com&usp=drive_fs```
 you need to take a part: ```id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` and put in front of it: ```https://drive.google.com/uc?export=download&```.  
Thus, you will get a link to a direct download of the file:
```https://drive.google.com/uc?export=download&id=xxxxxxxxxxxxxx-xxxxxxxxxxxx```

* Go to the ```UPDATE``` tab, uncomment the ***LINK_KEY*** line (remove the # symbol) and paste the link to directly download your ```priv_validator_key.json``` file. Then click ```UPDATE DEPLOYMENT```. Confirm the transaction.

*In the process of work, your address ***Sei*** will be displayed, you need to request tokens to it. Everything is difficult with a faucet, there is a resource https://bitszn.com/faucets.html , may give something. If not, then go to [Discord Sei](https://discord.gg/3A3TdWfF) and ask for tokens to your ***Sei*** address there.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171263925-fb3abceb-3816-4c09-8470-c247d332a48e.png)
 
</div>

* In the ```LOGS``` tab , you can view the operation of the node. Synchronization will start from the block that is ***2000*** blocks "below" the last one. For example, if there are ***596562*** blocks in the network at the time the node is launched, then synchronization and "catching up" will start from 596562-2000= ***594562*** blocks. After full synchronization, a validator will be created (***if it has not been created earlier***) and the node will enter the automatic mode of operation. Every ***5 minutes*** the balance will be checked, and if it is positive - auto-delegation to yourself. There will also be a check on the jail, the exit from the jail will be performed automatically.

[Go to start](https://github.com/Dimokus88/Sei#Sei-validator-node-on-akash-network)

[Useful Commands](https://github.com/Dimokus88/Sei#useful-commands--%D0%BF%D0%BE%D0%BB%D0%B5%D0%B7%D0%BD%D1%8B%D0%B5-%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B)

### Thank you for choosing Akash Network!

## If you have priv_validator_key.json

> Then open access to the file on google drive and copy its link, it will look like:
```https://drive.google.com/open?id=xxxxxxxxxxxxxx-xxxxxxxxxxxx&authuser=gmail%40gmail.com&usp=drive_fs```
 you need to take a part: ```id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` and put in front of it: ```https://drive.google.com/uc?export=download&```.  
Thus, you will get a link to a direct download of the file:
```https://drive.google.com/uc?export=download&id=xxxxxxxxxxxxxx-xxxxxxxxxxxx```

* Open ***Akashlytics***,if you don't have it installed, then [link for download](https://www.akashlytics.com/deploy).

* We check the presence of a balance  ***(>5АКТ)*** and the presence of an installed certificate.

![image](https://user-images.githubusercontent.com/23629420/165339432-6f053e43-4fa2-4429-8eb7-d2fc66f47c70.png)

* Click ***CREATE DEPLOYMENT***. Select ***Empty*** and copy the contents there [deploy.yml](https://github.com/Dimokus88/Sei/blob/main/deploy.yml)

* Let's take a look at what is there, so the ```services``` section indicates the ```docker``` node image, as well as a block with environment variables ```env```:

* ```my_root_password``` - password  ```root``` user, for connection to container via ```ssh```.
* ```MONIKER```       - Node name .
* ```MNEMONIС```      -  insert the mnemonic phrase from your wallet ***Sei***.
* ```LINK_ADDRBOOK```       - link addrbook.json
* ```SNAP_RPC```      - link RPC node.
* ```LINK_KEY``` -  paste the link to the hosted priv_validator_key.json (direct download).

In the ```resources``` field, we set the capacity to be rented. ```4 CPU x 32 GB RAM x 1 TB SSD``` recommended for ***Sei*** node. 

* Click on ```CREATE DEPLOYMENT``` and we are waiting for the appearance of providers with free capacities (BIDS).

![image](https://user-images.githubusercontent.com/23629420/165608527-da85c84e-edcc-4b15-8843-441d3e76dcb6.png)

* We choose the one that suits us in terms of price and equipment. Then we press ```ACCEPT BID```.

We are waiting for the completion of the deployment.

* In the ```LOGS```  tab , you can view the operation of the node. Synchronization will start from the block that is ***2000*** blocks "below" the last one. For example, if there are ***596562*** blocks in the network at the time the node is launched, then synchronization and "catching up" will start from 596562-2000= ***594562*** blocks. After full synchronization, a validator will be created (***if it has not been created earlier***) and the node will enter the automatic mode of operation. Every ***5 minutes*** the balance will be checked, and if it is positive - auto-delegation to yourself. There will also be a check on the jail, the exit from the jail will be performed automatically.

* In the process of work, your address ***Sei*** will be displayed, you need to request tokens to it. Everything is difficult with a faucet, there is a resource https://bitszn.com/faucets.html , may give something. If not, then go to [Discord Sei](https://discord.gg/3A3TdWfF) and ask for tokens to your ***Sei*** address there.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171263901-721229e6-96b0-4bd9-adbf-4f0edfed354a.png)
 
</div>

[Go to start](https://github.com/Dimokus88/Sei#Sei-validator-node-on-akash-network)

[Useful Commands](https://github.com/Dimokus88/Sei#useful-commands--%D0%BF%D0%BE%D0%BB%D0%B5%D0%B7%D0%BD%D1%8B%D0%B5-%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B)

### Thank you for choosing Akash Network!

# Русская версия

Заполняем [форму](https://forms.gle/CzBeqENRZrrXXG4x7) . Задачи по тестнету [тут](https://3pgv.notion.site/All-Testnet-Missions-16c0a40320244c24b0bc3f663c0cf00b)!

> Если хотите перенести вашу ноду на Akash, или у вас есть priv_validator_key.json, то перейдите [к этому пункту](https://github.com/Dimokus88/Sei#%D0%B5%D1%81%D0%BB%D0%B8-%D1%83-%D0%B2%D0%B0%D1%81-%D0%B5%D1%81%D1%82%D1%8C-priv_validator_keyjson).

> На вашем кошельке ```Akash``` (с которого будет разворачивать ***Sei***) должно быть более ***5 АКТ*** (5 АКТ будут заблокированы на развертывание + оплата газа транзакций). АКТ можно пробрести на биржах ```Gate```, ```AsendeX```, ```Osmosis``` . Так же в нашем сообществе [Akash RU](https://t.me/akash_ru) мы регулярно проводим эвенты в которых раздаем АКТ.

## Если запуск производится впервые:

***Создайте дополнительный кошелек экосистемы Cosmos для проекта Sei, с помощью Keplr или Cosmostation. Перепишите seed фразу от созданного кошелька, она понадобится нам при развертке.***

* Открываем ```Akashlytics```, если он у вас не установлен - то вот [ссылка на скачивание](https://www.akashlytics.com/deploy).

* Проверяем наличие баланса (>5АКТ) и наличие установленного сертификата.

![image](https://user-images.githubusercontent.com/23629420/165339432-6f053e43-4fa2-4429-8eb7-d2fc66f47c70.png)

* Нажимаем ```CREATE DEPLOYMENT```. Выбираем ```Empty```(пустой template) и копируем туда содержимое [deploy.yml](https://github.com/Dimokus88/Sei/blob/main/deploy.yml) .

Раберем что там есть, итак раздел ```services``` здесь указывается ```docker``` образ ноды, а также блок с переменными окружения ```env```:

В поле ***my_root_password*** - задаем пароль root для подключения по ssh.

В поле ***MONIKER*** - задаем имя ноды.

В поле ***MNEMONIС*** - вставляем мнемоник фразу от вашего кошелька ***Sei***.

В поле ***LINK_ADDRBOOK*** - ссылка на скачивание адресной книги пиров .

В поле ***SNAP_RPC*** - ссылка на ***RPC*** ноду, для начала синхронизации с последних блоков (рекомендуется) .

> Поле ***LINK_KEY*** -  оставьте закомментированным ссылка на размещенный priv_validator_key.json (прямое скачивание).

Ниже, в поле ```resources``` мы выставляем арендуюмую мощность. для ноды ***Sei*** рекомендуется ```2 CPU x 4 GB RAM x 600 GB SSD```. В случае синхронизации с ***RPC*** ноды - мы храним не полный блокчейн, поэтому можно поставить  ```2 CPU x 4 GB RAM x 100 GB SSD```. 

Нажимаем кнопку ```CREATE DEPLOYMENT``` и ждем появления провайдеров, со свободными мощностями (***BIDS***).

![image](https://user-images.githubusercontent.com/23629420/165608527-da85c84e-edcc-4b15-8843-441d3e76dcb6.png)

* Выбираем подходящий для нас по цене и оборудованию. После чего нажимаем ```ACCEPT BID```.

Ждем заверщения развертывания.

* Во вкладке ```LOGS``` дождитесь сообщения о сгенерированном файле ```priv_validator_key.json``` .

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171269962-0010a5be-8e45-4dec-a7c9-156fcaedf1cc.png)
  
</div>

* Во вкладке ```SHELL``` выполните команду ```cat /root/.sei-chain/config/priv_validator_key.json```, ответ сохраните в файле ```priv_validator_key``` с расширением ```.json```.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171270347-472f6652-e624-4e9c-bd5f-2655c3f12a97.png)
  
</div>

> Откройте доступ к файлу на ```google``` диск и скопируйте его ссылку, она будет вида:
```https://drive.google.com/open?id=xxxxxxxxxxxxxx-xxxxxxxxxxxx&authuser=gmail%40gmail.com&usp=drive_fs``
 вам нужно взять часть: ```id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` и вставить перед ней: ```https://drive.google.com/uc?export=download&```.  
Таким образом, у вас получится ссылка на прямое скачивание файла:
```https://drive.google.com/uc?export=download&id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` . Сохраните ее.

* Перейдите во вкладку ```UPDATE```, расскаментируйте строку  ***LINK_KEY*** (удалив символ #) и вставьте ссылку на прямое скачивание вашего файла ```priv_validator_key.json```. После чего нажмите ```UPDATE DEPLOYMENT```. Подтвердите транзакцию.

* В процессе работы будет выводится ваш адрес ***Sei***, на него нужно запросить токены. С краном все сложно, есть ресурс https://bitszn.com/faucets.html , может что то даст. Если нет - то идем в [Discord Sei](https://discord.gg/3A3TdWfF) и просим токены на наш адрес Sei там.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171263863-67705657-e0aa-4fe1-9530-ac97007318ba.png)
 
</div>

* В поле ```LOGS``` можете наблюдать работу ноды. Синхронизация начнеся с блока который на ***2000*** блоков "ниже" последнего. Например, если в сети на момент запуска ноды ***596562*** блоков, то синхронизивароться и "догонять" начнет с 596562-2000= ***594562*** блока. После полной синхронизации будет создан валидатор (если он не был созда ранее) и нода войдет в автоматический режим работы. Каждые  5 минут будет проверяться баланс, и в случае если он положителен - автоделегирование на себя. Так же будет происходить проверка на тюрьму, выход из тюрьмы будет выполнен автоматически.

[Перейти к началу](https://github.com/Dimokus88/Sei#Sei-validator-node-on-akash-network)

[Полезные команды](https://github.com/Dimokus88/Sei#useful-commands--%D0%BF%D0%BE%D0%BB%D0%B5%D0%B7%D0%BD%D1%8B%D0%B5-%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B)

### Спасибо что используете Akash Network!

## Если у вас есть priv_validator_key.json

> Откройте доступ к файлу на google диск и скопируйте его ссылку, она будет вида:
```https://drive.google.com/open?id=xxxxxxxxxxxxxx-xxxxxxxxxxxx&authuser=gmail%40gmail.com&usp=drive_fs```
 вам нужно взять часть: ```id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` и вставить перед ней: ```https://drive.google.com/uc?export=download&```.  
Таким образом, у вас получится ссылка на прямое скачивание файла:
```https://drive.google.com/uc?export=download&id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` . Сохраните ее.

* Открываем ```Akashlytics```, если он у вас не установлен - то вот [ссылка на скачивание](https://www.akashlytics.com/deploy).

* Проверяем наличие баланса (>5АКТ) и наличие установленного сертификата.

![image](https://user-images.githubusercontent.com/23629420/165339432-6f053e43-4fa2-4429-8eb7-d2fc66f47c70.png)

* Нажимаем ```CREATE DEPLOYMENT```. Выбираем ```Empty```(пустой template) и копируем туда содержимое [deploy.yml](https://github.com/Dimokus88/Sei/blob/main/deploy.yml) .

Давайте раберем что там есть, итак раздел ```services``` здесь указывается ```docker``` образ ноды, а также блок с переменными окружения ```env```:

В поле ***my_root_password*** - задаем пароль root для подключения по ssh.

В поле ***MONIKER*** - указываем имя ноды.

В поле ***MNEMONIС*** - вставляем мнемоник фразу от вашего кошелька ***Sei***.

В поле ***LINK_KEY*** -  скопируйте ссылку на размещенный priv_validator_key.json (прямое скачивание). 

В поле ***LINK_ADDRBOOK*** - ссылка на скачивание адресной книги пиров .

В поле ***SNAP_RPC*** - ссылка на ***RPC*** ноду, для начала синхронизации с последних блоков.

Ниже, в поле ```resources``` мы выставляем арендуюмую мощность. для ноды ***Sei*** рекомендуется ```2 CPU x 4 GB RAM x 600 GB SSD```. В случае синхронизации с ***RPC*** ноды - мы храним не полный блокчейн, поэтому можно поставить  ```2 CPU x 4 GB RAM x 100 GB SSD```. 

Нажимаем кнопку ```CREATE DEPLOYMENT``` и ждем появления провайдеров, со свободными мощностями (***BIDS***).

![image](https://user-images.githubusercontent.com/23629420/165608527-da85c84e-edcc-4b15-8843-441d3e76dcb6.png)

* Выбираем подходящий для нас по цене и оборудованию. После чего нажимаем ```ACCEPT BID```.

Ждем заверщения развертывания.

* В вкладке ```LOGS``` можете наблюдать работу ноды. Синхронизация начнеся с блока который на ***2000*** блоков "ниже" последнего, например если в сети на момент запуска ноды ***596562*** блоков, то синхронизивароться и "догонять" начнет с 596562-2000= ***594562*** блока. После чего будет создан валидатор (если он не был созда ранее) и нода войдет в автоматический режим работы. Каждые  5 минут будет проверяться баланс, и в случае если он положителен - автоделегирование на себя. Так же будет происходить проверка на тюрьму, выход из тюрьмы будет выполнен автоматически.

* В процессе работы будет выводится ваш адрес ***Sei***, на него нужно запросить токены. С краном все сложно, есть ресурс https://bitszn.com/faucets.html , может что то даст. Если нет - то идем в [Discord Sei](https://discord.gg/3A3TdWfF) и просим токены на наш адрес Sei там.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171263840-eace007a-3c06-41bf-894a-9514e3c70163.png)

 
</div>

[Перейти к началу](https://github.com/Dimokus88/Sei#Sei-validator-node-on-akash-network)

[Полезные команды](https://github.com/Dimokus88/Sei#useful-commands--%D0%BF%D0%BE%D0%BB%D0%B5%D0%B7%D0%BD%D1%8B%D0%B5-%D0%BA%D0%BE%D0%BC%D0%B0%D0%BD%D0%B4%D1%8B)

### Спасибо что используете Akash Network!

___

#### Useful Commands | Полезные команды

Use the ```SHELL``` tab of the ***Akashlytics*** user interface to enter commands.

Для ввода команд используйте вкладку ```SHELL``` пользовательского интерфейса ***Akashlytics*** .

Node status | Статус ноды

```curl -s localhost:26657/status``` node status

Checking balance | Проверка баланса

```seid q bank balances your_sei_address``` 

Distribution withdraw rewards | Вывод комиссионных

```seid tx distribution withdraw-rewards your_valoper --from your_sei_address ---fees 5555usei --commission -y``` 

Send tokens | Отправка токенов

```seid tx bank send name_wallet your_sei_address 1001000usei --fees 5550usei --chain-id sei-private-1 -y```

Voting | Голосование

```seid tx gov vote 1 yes --from your_sei_address --fees 5550usei```
