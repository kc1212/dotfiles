# install this environment using:
# nix-env -f "<nixpkgs>" -iA myHaskellEnv

# {
#   packageOverrides = super: let self = super.pkgs; in
#   {
#     myHaskellEnv = self.haskellPackages.ghcWithHoogle
#                      (haskellPackages: with haskellPackages; [
#                        # libraries
#                        mtl containers bytestring directory filepath
#                        # tools
#                        stack cabal-install cabal2nix codex ghc-mod hasktags
#                      ]);
#   };
# }
#

{ allowUnfree = true; }

