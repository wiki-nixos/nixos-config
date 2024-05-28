{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "cmus-notify";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "mathieu-lemay";
    repo = "cmus-notify";
    rev = "master";
    sha256 = "sha256-W1UWiWVLHqPqysrDuPig0kBGbZjHcPVcYdJHY2HJUHg=";
  };

  cargoSha256 = "sha256-PwDGY7Oiw3G3yzE5IVy88kiCc3l1OyJ4gxktlkjbkZQ=";

  meta = with lib; {
    description = "A Rust program to send notifications for cmus";
    license = licenses.mit;
    maintainers = with maintainers; [yourGithubUsername];
    platforms = platforms.linux;
    homepage = "https://github.com/mathieu-lemay/cmus-notify";
  };
}
