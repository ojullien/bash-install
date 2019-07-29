# Bash-Install

Simple tool for configuring a fresh debian/ubuntu installation with just one command.

*Note: I use this script for my own projects, it contains only the features I need.*

## Table of Contents

[Installation](#installation) | [Features](#features) | [Test](#test) | [Contributing](#contributing) | [License](#license)

## Installation

Requires: a Debian/Ubuntu version of linux and a Bash version ~4.4. [bash-sys](https://github.com/ojullien/bash-sys) installed. SSH is already installed and configured.

1. [Download a release](https://github.com/ojullien/bash-install/releases) or clone this repository.
2. Use [scripts/install.sh](scripts/install.sh) to automatically install the application in the /opt/oju/bash project folder.
3. If needed, add `PATH="$PATH:/opt/oju/bash/bin"` to the .profile files.
4. Update the [config.sh](src/app/install/config.sh) configuration file.

## Features

With just one command, this tool installs and configures all the softwares I need on a fresh debian/ubuntu server installation, like:

1. Initial update and upgrade
  i. update source.list
  ii. update system
  iii. upgrade system
2. Install or modify .bashrc, .bash_alias, .bash_profile, .profile files
3. Configure swap
4. Uninstall packages (vim-tiny, ...)
5. Install system packages (dkms, build-essential, util-linux, deborphan, localepurge, hdparm, smartmontools, ...)
6. Install and configure app packages (vim, fail2ban, ftp, mlocate, chkrootkit, logwatch, ...)
7. Optimize SSD

The local user name is defined in the [config.sh](src/app/savesystemconf/config.sh) file.

```bash
Usage: install.sh [options]

options
  -h | --help           Show this help.
  -l | --active-log     Log mode. Content outputs are logged in a file.
  -n | --no-display     Display mode. Nothing is displayed in terminal.
  -t | --trace          Display var and constants.
  -v | --version        Show the version.
  -w | --wait           Wait user. Wait for user input between actions.
```

## Test

I didn't write any line of 'unit test' code. Sorry.

## Contributing

Thanks you for taking the time to contribute. Please fork the repository and make changes as you'd like.

As I use these scripts for my own projects, they contain only the features I need. But If you have any ideas, just open an [issue](https://github.com/ojullien/bash-install/issues/new/choose) and tell me what you think. Pull requests are also warmly welcome.

If you encounter any **bugs**, please open an [issue](https://github.com/ojullien/bash-install/issues/new/choose).

Be sure to include a title and clear description,as much relevant information as possible, and a code sample or an executable test case demonstrating the expected behavior that is not occurring.

## License

This project is open-source and is licensed under the [MIT License](LICENSE).
