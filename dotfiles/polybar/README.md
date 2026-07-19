## Contents

- [Introduction](#introduction)
- [Steps](#steps)
- [Resources](#resources)

## Introduction

Project to configure Polybar.

## Steps

Install Polybar.

Create the folder to save the configuration:

```bash
mkdir -p ~/.config/polybar/
```

Copy the `config` and `launch.sh` files in the previous folder.

Run polybar:

```bash
bash $HOME/.config/polybar/launch.sh
```

Note, you can run polybar with `polybar bar1` but you need to configure in `~/.bashrc` the environment variables `INTERFACE_ETHERNET` and `INTERFACE_WIRELESS` configured at `launch.sh` and run `source ~/.bashrc`.

## Resources

Polybar

<https://github.com/polybar/polybar>

Tutorial

<https://atareao.es/tutorial/polybar/>

