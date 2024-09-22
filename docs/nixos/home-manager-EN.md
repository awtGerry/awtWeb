<div style="padding:40px">
<img src="./nixos.svg" style="width: 100px; height: 100px; justify-content: center; display: block; margin-left: auto; margin-right: auto; margin-bottom: 40px;">

# Configuring NixOS with [home-manager](https://github.com/nix-community/home-manager)
## My first look
Since I started to use linux on all my devices I had always the same problem, **installing all
my programs**. Of course we always have our dotfiles in a repository on git, but configuring
that to be automated af is painfull, it takes time and not necessarily had to work all the time,
I make `sh` scripts like a maniac to get a semi-automated installed system and when I finally
did it it broke 6 months after. I gave up, I actually went to use arch linux on all my devices to
install ubuntu on my laptops because I couldn't hold up, that until I discovered `NixOS`.

***

I started using NixOS not to long ago, and I ran into flakes and home-manager like 2 days after I install
the distro. I read a little bit and saw that finally I can have the same programs with the same configuration
on all my devices, but the learning curve is so high but at the same time very very rewarding. I created a repository
called [home-cfg](https://github.com/awtgerry/home-cfg) to start immediately, I used a couple of configurations that
I saw online but for lack of time I didn't make the best configuration possible.

## First steps
Now let's get dirty. To get started we need to create a repository folder and create
a `flake.nix` file in, you can do that manually or you can run
`nix flake init`. I will do it manually.

Usually home-manager recommends something like this:

`flake.nix`
```nix
{
  description = "Home-manager configuration"; # Put whatever you like.

  inputs = {
    # Import nix ecosystem
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Here we import home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager
    ...
  } @ inputs: let
    # More config...
  in
}
```

Now let's stylish a little.

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    systems.url = "github:nix-systems/default-linux";

    nixos-hardware.url = "github:nixos/nixos-hardware";
    # nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gl = {
      url = "github:nix-community/nixgl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib; # // means merge
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
          import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          }
      );
    in {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home-manager;
    };
}
```

</div>
