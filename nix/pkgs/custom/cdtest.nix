{ lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "cdtest";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "harrisonhall";
    repo = pname;
    rev = "30602c8d9115431ac6d49d3d54e2ca5167deb60e";
    # hash = lib.fakeHash;
    hash = "sha256-VIIgoEAy+lHr1zGSByLLYbs2+lRWdpI7hTFWDagoEhw=";
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
