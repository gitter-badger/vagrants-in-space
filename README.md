<img src="https://raw.githubusercontent.com/ChanceArthur/vagrants-in-space/master/.img/logo.png" width="187">

# Vagrants in Space

A Vagrant machine for **[Grav](https://getgrav.org)** development within **VirtualBox**.

## Prepare for launch

**3**. You will need to already have [Vagrant](https://www.vagrantup.com) and [VirtualBox](https://www.virtualbox.org) installed along with the following Vagrant plugins:
```
$ vagrant plugin install vagrant-hostsupdater
$ vagrant plugin install vagrant-vbguest
```

**2**. Download or clone this repo.  
*Optional: Rename the project directory to whatever you want. It will become the name of your VM within VirtualBox.*

**1**. Edit `config/hosts` and replace the included .dev domain with the one you want to use for your Grav test site.

**Lift off!** Open Terminal, `cd` into your project directory, and run `vagrant up`.

## Technical stuff
This is a quick overview of what this Vagrant machine is configured to do. Feel free to modify the `Vagrantfile` and `setup.sh` if needed. They're both commented fairly well.

- Based off of the Debian Jessie box.
- Configured to mimic the lowest configuration for a DigitalOcean droplet. 1 CPU, 512MB RAM.
- Points your .dev domain to a private IP address of `192.168.50.5` in the hosts file.
- Syncs the `config` directory so that `setup.sh` can update the Nginx configuration from within the Vagrant machine.
- Creates and syncs the `user` directory with Grav's user directory.
- Installs the following packages:
	- `nginx`
	- `php-fpm` `php-curl` `php7.0-apcu` `php7.0-gd` `php7.0-mbstring` `php7.0-mcrypt` `php7.0-xml` `php7.0-zip`
	- `unzip` `zip`
- Downloads, unzips, and copies Grav with Admin plugin to `/var/www/html` and assigns ownership to `www-data`.
