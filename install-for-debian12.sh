#!/bin/bash

# install dotnet sdk
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt install dotnet-sdk-6.0 dotnet-host dotnet-hostfxr-6.0 -y

# build avstplg
git clone https://github.com/thesofproject/avsdk.git
cd avsdk/avstplg
sudo apt install alsa-utils -y
make 
cd ../../

# build topology
git clone --branch v2024.02 https://github.com/thesofproject/avs-topology-xml.git
cd avs-topology-xml
PATH=$PATH:$PWD/../avsdk/avstplg/build/bin/Debug/net6.0/publish make
make dist

sudo mkdir -p /tmp/avs_tplg
sudo tar -xvf avs-topology.tar.gz -C /tmp/avs_tplg/

./setup-audio
