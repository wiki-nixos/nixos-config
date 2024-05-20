{ lib, stdenv, fetchFromGitHub, pkg-config, SDL, SDL_gfx, SDL_image }:

stdenv.mkDerivation rec {
  pname = "vecx";
  version = "1.1.r0.gbe44a67";

  src = fetchFromGitHub {
    owner = "jhawthorn";
    repo = "vecx";
    rev = "be44a67";
    sha256 = "sha256-p7z+EXq+HPboujU+yl+RiHanHAW9eSIepbrXacl/yes=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ SDL SDL_gfx SDL_image ];

  meta = with lib; {
    description = "SDL-based Vectrex console emulator";
    license = licenses.gpl2;
    platforms = platforms.linux;
    homepage = "https://github.com/jhawthorn/vecx";
    maintainers = with maintainers; [ "prg <prg@xannode.com>" ];
  };

  prePatch = ''
    sed -i 's/-O3/-fgnu89-inline -O3/g' Makefile
    sed -i 's|rom.dat|${placeholder "out"}/share/vecx/rom.dat|' osint.c
  '';

  configurePhase = ''
    echo "Skipping configure phase"
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    install -m755 vecx $out/bin/vecx
    mkdir -p $out/share/vecx
    install -m644 rom.dat $out/share/vecx/rom.dat
  '';
}


