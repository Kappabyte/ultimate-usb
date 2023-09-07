# ultimate-usb
A script to generate an ultimate USB stick including Ventoy, Medicat, and a live NixOS install

## Dependencies
 - `wget`
 - `nixos-install`
 - `ventoy`
 - `7za`
 - `refind-install`

### Using Nix Package Manager

You can use the provided `shell.nix` to create a shell with the required
 dependencies.
```sh
$ nix-shell
```

If you have direnv installed, simply enable direnv for this repo.
```sh
$ direnv allow
```

## How to use
Simply run the `install.sh` script on your system.
