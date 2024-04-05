{
  description = "development environment for godot 4 project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.mkShell {
      packages = [ pkgs.godot_4 ];

      # shellHook = ''
      #   godot4 --editor --path ./src && exit
      # '';
    };
  };
}