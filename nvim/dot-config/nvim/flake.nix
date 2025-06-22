{
    description = "A flake for Super NVIM";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    };

    outputs = { self, nixpkgs, ... }:
    let
        inherit (self) outputs;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        devShells.${system} = {
            default = pkgs.mkShell rec {
                buildInputs = with pkgs; [
                    neovim
                    lazygit
                    zathura # PDF viewer

                    # Telescope
                    fzf
                    ripgrep

                    # lsp deps
                    tinymist
                    lua-language-server
                    clang # lsp

                    # For making dependencies
                    gnumake

                    bashInteractive # requires for nvim term
                ];

                # Define shell setup actions
                shellHook = ''
                    alias snvim='NVIM_APPNAME=superNvim nvim'
                '';
            };
        };
    };
}
