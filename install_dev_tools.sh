#!/bin/bash

echo "= Start script with comand 'set -e' ="

set -e

echo "= Check if/and install Python =" 

if ! command -v python3 &>/dev/null; then
    echo "Python is not installed. Installing python or python3..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get update
        sudo apt-get install -y python3 python3-pip
    elif command -v yum &>/dev/null; then
        sudo yum install -y python3 python3-pip
    else
        echo "Unsupported package manager. Please install Python manually."
        exit 1
    fi
else
    echo "Python is already installed: $(python3 --version)"


echo "= Check if/and Install pip ="

if ! command -v pip3 &>/dev/null; then
    echo "pip is not installed. Installing pip..."
    if command -v apt-get &>/dev/null; then
        if ! sudo apt-get install -y python3-pip; then
            echo "apt-get failed. try get-pip..."
            curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
            python3 get-pip.py --break-system-packages
            rm get-pip.py
        fi
    elif command -v yum &>/dev/null; then
        if ! sudo yum install -y python3-pip; then
            echo "yum failed. try get-pip..."
            curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
            python3 get-pip.py --break-system-packages
            rm get-pip.py
        fi        
    else
        echo "Unsupported package manager. Please install pip manually."
        exit 1
    fi
else
    echo "pip is already installed: $(pip3 --version)"
fi


echo "Check if/and Django installed"

if ! python3 -c "import django" &>/dev/null; then
    echo "Django is not installed. Installing Django..."
    pip3 install Django --break-system-packages
else
    echo "Django is already installed: $(python3 -m django --version)"
fi


echo "= Check if/and Docker Installed ="

if ! command -v docker &>/dev/null; then
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker $USER
else
    echo "Docker is already installed: $(docker --version)"
fi


echo "= Check if/and Docker-Compose installed ="

if ! command -v docker-compose &>/dev/null; then
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
      -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "Docker Compose is already installed: $(docker-compose --version)"
fi


echo "= Your tools INSTALLED!"
