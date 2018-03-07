# RHVH Team Ansible Playbooks

this repo contains some routine jobs, such as:

*   create pxe profile
*   upgrade rhevm instance
*   server maintenance

## Installation

1.  make sure install [pipenv](https://github.com/pypa/pipenv) first
2.  clone the repo, then run `$> pipenv install`

## Usage

**create pxe profile**

```shell
$> export ANSIBLE_HOST_KEY_CHECKING=False
$> ansible-playbook -i production.inv.ini site.yml -e "iso_name=[iso_name]"  -t pxe_pre -t pxe_post  --limit server75
```

**upgrade rhevm**

```shell
$> export ANSIBLE_HOST_KEY_CHECKING=False
$> ansible-playbook -i production.inv.ini site.yml --limit rhevm42
```

## Other

role-based var is encrypted with gpg symmetric, so contace repo owner to get passphrase
