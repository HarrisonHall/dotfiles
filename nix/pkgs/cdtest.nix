{ lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "cdtest";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "harrisonhall";
    repo = pname;
    rev = "53e484708795f8a7497f11209d73930555a6c248";
    hash = "sha256-PjBad79DoJyws/wIcgWG53KWXefLOCvkc02ivp4gp78=";
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