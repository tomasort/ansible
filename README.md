# Ansible IaC

This project showcases how I use Ansible to streamline and automate the configuration of my diverse set of personal devices – a macOS laptop, an Ubuntu desktop, and a Raspberry Pi. By leveraging Ansible's infrastructure-as-code approach, I maintain consistent setups, reduce manual errors, and effortlessly provision new systems or roll back changes

# Setup
## Install ansible
You can install ansible by following the instructions [here](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) or you can install it and install the required roles by using the `install` script. 
```ssh
sudo chmod +x install
./install
```

# Usage

## MacOS
```shell
ansible-playbook --ask-become-pass --ask-vault-pass macos.yml
```
## Odroid
```shell
ansible-playbook --ask-become-pass --ask-vault-pass odroid.yml
```
## Raspberry Pi
```shell
ansible-playbook --ask-become-pass --ask-vault-pass pi.yml
```

# Common Role and Configurations

## zsh

The default theme for zsh is at: 
```shell
cat roles/common/defaults/main.yml
```
you can change it using the variable `zsh_theme` for any playbook

## Encrypted files
Some files are encrypted using `ansible-vault`
The files that are encrypted can be decrypted with: 
```shell
xargs -n1 ansible-vault decrypt < (grep -v '^#' encrypted.txt) 
```