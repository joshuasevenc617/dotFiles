# dotFiles
---
*created and used by Joshua C.*

### Run the following commands to configure a new mac
1. Download nix os
```
sh <(curl -L https://nixos.org/nix/install)
```

2. Download the `dotFiles` repo from git
```
nix-shell -p git --run 'git clone https://github.com/joshuasevenc617/dotFiles.git ~/dotFiles'
```
3. Install xcode command line tools
```
xcode-select --install
```
4. Run nix darwin using flake config from dotFiles
```
nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/dotFiles/nix#mbp
```
