{ lib, fetchFromGitHub, rustPlatform, ... }:

rustPlatform.buildRustPackage rec {
  pname = "slipstream";
  version = "2.0.1";

  # nix run nixpkgs#nurl -- https://github.com/harrisonhall/slipstream
  src = fetchFromGitHub {
    owner = "harrisonhall";
    repo = "slipstream";
    rev = "768d7330a5339d5a549b2e3568aff7d260031b66";
    # hash = lib.fakeHash;
    hash = "sha256-loGow8d/wUfzrAi2HZJkVKqJGPk7ymzbrxOnjxKwBRs=";
  };

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  meta = with lib; {
    description = "Simple CLI `slipfeed` server, with web support and a TUI reader.";
    homepage = "https://github.com/harrisonhall/slipstream";
    license = licenses.mit;
    mainProgram = "slipstream";
    # maintainers = [ maintainers.tailhook ];
  };
}
