{pkgs ? import <nixpkgs> {} }: 
pkgs.mkShell {
    # Using packages instead of buildInputs is also fine
    buildInputs = with pkgs; [ 
        # nixpkgs-fmt
        gnumake
        cmake
   ];

    shellHook = ''
        cmake --version
    ''; 
}
