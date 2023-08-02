# Dotfiles
* This repository contains by dotfiles and nixos configuration

# Usage
This repository contains configuarations for multiple machines. To adapt a config to your own machine, choose one of the availible configurations and replace the `hardware-configuation.nix` file with the one generated on your machine using `nixos-generate-config`.

## Availible configs

| Name | Description | Command |
|------|-------------|---------|
| desktop | My desktop computer configuration designed for development, gaming, and general usage | `sudo nixos-rebuild switch --flake .#desktop` |
| laptop | My microsoft surface configuation designed primarly for devleopment and school | `sudo nixos-rebuild switch --flake .#laptop` |
| usb | My portable USB OS. For more information see my repo [Kappabyte/USB](https://github.com/Kappabyte/USB) | `sudo nixos-rebuild switch --flake .#usb` |

## Repository Layout
There are 4 main directories in this repository

| Name | Purpose |
|------|---------|
|`custom`| Contains custom packages and services |
|`nixos`| Contains overlays, package configuation, and user configuation |
|`machine`| Contains machine specific configuation, including a common configuation among machines |
|`home`| Contains home-manager configuration |
