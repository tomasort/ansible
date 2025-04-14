# Ansible IaC

This project showcases how I use Ansible to streamline and automate the configuration of my diverse set of personal devices – a macOS laptop, an Ubuntu desktop, and a Raspberry Pi. By leveraging Ansible's infrastructure-as-code approach, I maintain consistent setups, reduce manual errors, and effortlessly provision new systems or roll back changes.

## Requirements

- Ansible 2.9+
- SSH access to target machines
- Sudo privileges on target machines

## Setup

### Install Ansible

You can install Ansible by following the [official installation guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) or use the provided installation script:

```bash
sudo chmod +x install
./install
```

The install script will set up Ansible and install all required roles and collections.

## Usage

### MacOS Configuration

```bash
ansible-playbook --ask-become-pass --ask-vault-pass macos.yml
```

### Odroid Configuration

```bash
ansible-playbook --ask-become-pass --ask-vault-pass odroid.yml
```

> **Note:** When running on an Odroid computer with a kernel >= 4.9, run the following commands and restart before running the playbook:
> ```bash
> sudo apt upgrade -y
> sudo apt dist-upgrade -y
> ```

### Raspberry Pi Configuration

```bash
ansible-playbook --ask-become-pass --ask-vault-pass pi.yml
```

## Roles and Configurations

### Common Role

The common role applies shared configurations across all devices.

#### ZSH Configuration

The default ZSH theme is defined in:
```bash
cat roles/common/defaults/main.yml
```

You can customize the theme by overriding the `zsh_theme` variable in your playbook.

## Working with Encrypted Files

This project uses `ansible-vault` to securely store sensitive information.

### Viewing Encrypted Files

To see which files are encrypted:
```bash
cat encrypted.txt
```

### Decrypting Files

To decrypt all encrypted files:
```bash
grep -v '^#' encrypted.txt | xargs -n1 ansible-vault decrypt
```

⚠️ **Warning:** Always verify which files will be decrypted before running this command!

### Encrypting Files

To encrypt a file:
```bash
ansible-vault encrypt path/to/file
```

### Content of encrypted files

In `roles/common/vars/main/vault.yml` we need to put:
- `github_token` - The token from github so that gh works.
- `email` - The email that is supposed to be used with git

In `roles/odroid/vars/main/vault.yml` we need:
- `TRNetwork` wich should contain the `wifi_name` and the `wifi_password`

In `roles/raspberrypi/vars/main/vault.yml` we have variables for the VPN 
- `ipv4_dev`: network interface that we want to use for the vpn
- `ipv4_addr`: local ip address
- `ipv4_gw`: gateway ip address
- `install_user`: name of the user
- `pivpn_port`: port to use
- `pivpn_dns1`: for example "9.9.9.9"
- `pivpn_dns2`: for example "149.112.112.112"
- `pivpn_host`: ip address of the host
- `pivpn_net`: ip address range for the users of the vpn


## Project Structure

- `roles/` - Contains all roles used by the playbooks
- `macos.yml` - Playbook for macOS configuration
- `odroid.yml` - Playbook for Odroid configuration
- `pi.yml` - Playbook for Raspberry Pi configuration
- `encrypted.txt` - List of encrypted files
