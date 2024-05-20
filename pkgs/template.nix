{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "Package NAME";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "Github User";
    repo = "Repo Name";
    rev = "master";
    sha256 = "sha256-AAAAAAAAAA";
  };

  nativeBuildInputs = [ ];

  buildInputs = [ ];

  installPhase = ''
    mkdir -p $out/bin
    cp program $out/bin
  '';

  meta = with lib; {
    description = "Repo Description";
    homepage = "https://github.com/user/repo";
    license = licenses.licensehere;
    maintainers = with maintainers; [ ];
  };
}

