{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "cmus-notify";
  version = "1.0.0"; 
  src = fetchFromGitHub {
    owner = "EternalBlissed";
    repo = "cmus-notify";
    rev = "3f41f4724961006d479ac1776342ca028eda3819";
    sha256 = "sha256-W1UWiWVLHqPqysrDuPig0kBGbZjHcPVcYdJHY2HJUHg=";
    };

  cargoSha256 = "sha256-PwDGY7Oiw3G3yzE5IVy88kiCc3l1OyJ4gxktlkjbkZQ=";

  meta = with lib; {
    description = "A Rust program to send notifications for cmus";
    license = licenses.mit;
    maintainers = with maintainers; [ yourGithubUsername ];
    platforms = platforms.linux;
    homepage = "https://github.com/mathieu-lemay/cmus-notify";
  };
}

