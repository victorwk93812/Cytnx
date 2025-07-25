{pkgs ? import <nixpkgs> {} }: 
pkgs.stdenv.mkDerivation rec {
    pname = "Cytnx";
    version = "1.0.0";

    src = ./.; 

    # nativeBuildInputs = [
    #     pkgs.cmake
    #     pkgs.ninja
    # ];
    
    buildInputs = with pkgs; [
        # nixpkgs-fmt
        gnumake
        cmake
        doctest
        boost
        openblas
        llvmPackages_18.openmp
        graphviz
        (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
# select Python packages here
            numpy
            scipy
            # pandas
            # pyqt5
            # pyqt6
            matplotlib
            # uncertainties
            venvShellHook
            pybind11
            pygraphviz
            beartype
        ]))
        mkl
    ];

    cmakeFlags = [
        "-DPYTHON_EXECUTABLE=${pkgs.python3}/bin/python"
    ];

    shellHook = ''
        echo "Cytnx flake successfully built"
    ''; 
}
