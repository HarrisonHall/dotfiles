{ lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "cdtest";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "harrisonhall";
    repo = pname;
    rev = "9d363b171c1e29c98b8de9d65ffe7bec9a79ffc7";
    hash = "sha256-tYAbGGPAcKH7i65zdf7TXMKRAzuhlYi0mgnjVK5e8Dk=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  meta = with lib; {
    description = "Simple tool to traverse and manage semi-temporary test directories";
    homepage = "https://github.com/harrisonhall/cdtest";
    license = licenses.mit;
    mainProgram = "cdtest";
    # maintainers = [ maintainers.tailhook ];
  };
}