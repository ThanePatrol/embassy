let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
in
  with nixpkgs;
  stdenv.mkDerivation {
    name = "moz_overlay_shell";
    buildInputs = [
      ((nixpkgs.rustChannelOf { date = "2023-06-28"; channel = "nightly"; } ).rust.override {
        targets = [
           "thumbv6m-none-eabi"
        ];
      })

      libusb1
      libudev-zero
      probe-run
      probe-rs
      flip-link
      pkg-config
      zlib
      binutils
    ];

    shellHook = ''
        rustup target add thumbv6m-none-eabi
    '';
  }
