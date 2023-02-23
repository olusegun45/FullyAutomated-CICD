user_data = <<-EOF
                  #!/bin/bash
                    # Setting up for Kubernetes
                    sudo apt-get update -y

                    # Installing all the Utilities to manage all the binaries in all system
                    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

                    # Setting up Docker Repo in all system 
                    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

                    # Adding Docker Repo in all system
                    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

                    #   update again in all system
                    sudo apt-get update -y

                    #  set up local cache for Docker on all systems
                    sudo apt-cache policy docker-ce

                    # Intall docker on all systems
                    sudo apt install -y docker-ce

                    # setting up docker in systemd to use systemctl or service cmd on all systems
                    sudo cat << | sudo tee /etc/docker/daemon.json
                    {
                    "exec-opts": ["native.cgroupdriver=systemd"]
                    }
                  

                    <<-EOF
                    # Enabling the docker service
                    sudo systemctl enable --now docker

                    # Adding ubuntu user locally accross the board
                    sudo usermod -aG docker ubuntu

                    # Restarting docker deamon on all systems
                    sudo systemctl restart docker

                    # We will need to turn off swapoff "t2-medium" to allow kubelet agent or kubectl intallation.
                    sudo swapoff -a

                    # Persisting swapoff configuration using Fs tab table
                    sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

                    # Set up Network bridge for Kubernetes 
                    sudo sysctl net.bridge.bridge-nf-call-iptables=1

                    # 1. Pulling the Repo for Kubernetes accross the board 
                    sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

                    # 2. Pulling the Repo for Kubernetes accross the board 
                    sudo cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
                    deb https://apt.kubernetes.io/ kubernetes-xenial main
                    EOF
                    
                    <<-EOF
                    # update again all system
                    sudo apt-get update -y

                    # Installing kubelet, kubectl and kubeadm on all systems { but kubeadmin will be initialize at the level of the Master}
                    sudo apt install -y kubelet kubeadm kubectl

                    # putting on hold kubelet, kubectl and kubeadm so they not be updated automatically on all
                    sudo apt-mark hold kubelet kubeadm kubectl

                    # Adding kubectl for auto complete 
                    sudo echo "source <(kubectl completion bash)" >> ~/.bashrc

                    # Update the file for back up on All system
                    sudo mv /etc/containerd/config.toml /etc/containerd/config.toml.bak

                EOF