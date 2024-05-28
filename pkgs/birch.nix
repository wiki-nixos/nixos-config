{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "birch";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "dylanaraps";
    repo = "birch";
    rev = "master";
    sha256 = "sha256-8TBsrRmpMl0z9e2gbPpj0ZR0zt1Kn+A4xRAq89Ww4og=";
  };

  nativeBuildInputs = [];

  buildInputs = [];

  installPhase = ''
    mkdir -p $out/bin
    cp birch $out/bin
  '';

  meta = with lib; {
    description = "An IRC client written in bash";
    homepage = "https://github.com/dylanaraps/birch";
    license = licenses.mit;
    maintainers = with maintainers; [];
  };
}
