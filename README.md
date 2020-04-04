# Monero (XMR) CPU Miner

A [Monero](https://getmonero.org/) CPU miner that updates itself on every (re-)start.

## Concept

The Dockerfile actually only specifies a very minimal base system. The real work is done by the provided Shell scripts.

* `init.sh` is a wrapper that calls the other scripts.
* `deploy_monero.sh` fetches the current Monero binaries directly from getmonero.org and deploys them inside the container.
* `start_mining.sh` starts the Monero daemon monerod with the appropriate options for mining.

As `init.sh` is defined as the entrypoint for Docker, the deploy and start scripts will be executed on every (re-)start of the container. Thus, the image is automatically updated with the most current, stable Monero application.

Directory-wise everything is kept within `/monero` inside the container. It is highly recommended to map the directory `/monero/data` from the container to a persistent storage, as the blockchain will be stored inside this directory. If not kept persistent, the full blockchain must be synchronized every time the container is started.

When creating or running the container, please provide the XMR address that shall be mined for via `XMRADDRESS` and the number of threads used for mining via `XMRTHREADS`.

### Directories

Please map the following directories to a persistent storage using Dockers `-v` parameter.

* `/monero/data`: This should be mapped to a local directory as it contains the blockchain.

### Variables

Please provide the following variables using Dockers `-e` parameter.

* `XMRADDRESS`: The XMR wallet that mining should be done for. Defaults to the authors wallet.
* `XMRTHREADS`: The number of threads that shall be used for mining. Defaults to 1.

### Ports

Monero requires port 18080 to be reachable from the Internet for RPC communication. Forward it using Dockers `-p` parameter.

## Usage

### Build or Pull

Use `docker build -t monero-cpu-miner:latest .` to build the Docker image locally. A precompiled image can be fetched from Docker Hub by executing `docker pull rbrtweiler/monero-cpu-miner:latest`.

### Run

Assuming you want to mine for the wallet _431234...7890_ using _3_ threads and your persistent storage is setup in _/var/docker/monero-cpu-miner_. Replace the values in the example below with what you want to use.

Use `docker create -it --name monero-cpu-miner --restart unless-stopped -e XMRADDRESS="431234...7890" -e XMRTHREADS=3 -v /var/docker/monero-cpu-miner:/monero/data -p 18080:18080 monero-cpu-miner:latest` to create a persistent container. Afterwards, execute `docker start monero-cpu-miner` to start the container.

### Inspect

A one-time view of the current status can be obtained by executing `docker logs monero-cpu-miner`. In addition, it is possible to attach to the container using `docker attach monero-cpu-miner`. This will show the current status and enable you to interact with the monerod shell. Exit with Ctrl+p Ctrl+q.

### Stop

The usual `docker stop monero-cpu-miner` can be used to stop the running container. To remove it completely, run `docker rm monero-cpu-miner` after stopping the container.

## Source

The original project is [hosted at GitLab](https://gitlab.com/rbrt-weiler/docker-monero-cpu-miner), with a [copy over at GitHub](https://github.com/rbrt-weiler/docker-monero-cpu-miner) for the folks over there.
