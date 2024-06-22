# ansible

This project showcases how I use Ansible to streamline and automate the configuration of my diverse set of personal devices – a macOS laptop, an Ubuntu desktop, and a Raspberry Pi. By leveraging Ansible's infrastructure-as-code approach, I maintain consistent setups, reduce manual errors, and effortlessly provision new systems or roll back changes

---

Use this command for the role you want to use

```shell
ansible-playbook --ask-become-pass --ask-vault-pass odroid.yml
```

The files that are encrypted can be decrypted with: 
```shell
xargs -n1 ansible-vault decrypt < (grep -v '^#' encrypted.txt) 
```


# zsh

The default theme for zsh is at: 
```shell
cat roles/common/defaults/main.yml
```

you can change it using the variable `zsh_theme` for any playbook