{ lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "cdtest";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "harrisonhall";
    repo = pname;
    rev = "54888408ab387bcfa17d668840d2403c52af146d";
    # hash = lib.fakeHash;
    hash = "sha256-eTvy7p8PZ4uAux+mvENZx5zBax1DgAic8g/2KJt2jnA=";
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
