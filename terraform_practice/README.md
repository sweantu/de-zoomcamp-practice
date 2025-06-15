export GOOGLE_CREDENTIALS="$HOME/.gcp/terraform-practice.json"

sudo apt-get update
sudo apt-get install docker.io
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart

wget https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh
bash Anaconda3-2024.10-1-Linux-x86_64.sh
eval "$(/home/sweantu/anaconda3/bin/conda shell.bash hook)"
conda init

nano .bashrc
export PATH="$HOME/bin:$PATH"
source ~/.bashrc

mkdir bin
cd bin

wget https://github.com/docker/compose/releases/download/v2.33.1/docker-compose-linux-x86_64 -O docker-compose
chmod +x docker-compose
wget https://releases.hashicorp.com/terraform/1.10.5/terraform_1.10.5_linux_amd64.zip
unzip terraform_1.10.5_linux_amd64.zip

cd ~/.gcp
sftp gcp-practice
cd ~/.gcp
put terraform-practice.json