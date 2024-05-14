{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "simple-sddm";
  src = pkgs.fetchFromGitHub {
    owner = "EternalBlissed";
    repo = "simple-sddm";
    rev = "f5adce061af04e2f59b397c877b88ab76d02bc6f";
    sha256 = "sha256-V3roNmYS35zvhYGm7A6vTGowFPnahuDqM7TSMGJIDIs=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
   '';
}
