{
    description = "Cytnx package flake";

    inputs = {
        flake-utils.url = "github:numtide/flake-utils";
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    }; 

    outputs = { self, nixpkgs, flake-utils, ... }:
        flake-utils.lib.eachDefaultSystem
        (system:
        let 
            pkgs = import nixpkgs { 
                system = "x86_64-linux"; 
                config.allowUnfree = true; 
            }; 
        in  
            {
                packages.default = pkgs.callPackage ./default.nix { };

            # Optionally, you can also define a devShell for *this specific project*
            # if someone were to 'cd your-project; nix develop'
                # devShells.default = pkgs.mkShell {
                #     packages = [ self.packages.default ];
                #     shellHook = "echo 'Dev shell for YOUR PROJECT ITSELF (built with flake-utils)!'";
                # };
                devShells.default = import ./shell.nix { 
                    inherit pkgs; 
                    Cytnx = self; 
                }; 
            }
        );
}
