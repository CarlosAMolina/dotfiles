## Contents

- [Introduction](#introduction)
- [Steps](#steps)
- [Resources](#resources)

## Introduction

Proyect to configure Polybar.

## Steps

Install Polybar.

Create the folder to save the configuration:

```bash
mkdir -p ~/.config/polybar/
```

Configure environment variables:

```bash
vi ~/.bashrc
# Add:
# # Network interfaces
# export INTERFACE_ETHERNET="$(ls /sys/class/net | grep enp)"
# export INTERFACE_WIRELESS="$(ls /sys/class/net | grep wlp)"
source ~/.bashrc
```

Copy the `config` file in the previous folder.

Run polybar:

```bash
polybar bar1
```

## Resources

Polybar

<https://github.com/polybar/polybar>

Tutorial

<https://atareao.es/tutorial/polybar/>

