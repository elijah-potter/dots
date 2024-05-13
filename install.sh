#! /bin/bash

set -eo pipefail

sudo pacman -S base-devel texlive neovim zip unzip zstd gzip pigz ripgrep exa dust fish git rustup nodejs yarn npm starship pandoc wasm-pack go dotnet-sdk aspnet-runtime docker mold clang lazygit bacon xdg-utils tokei openssh gnuplot bat pandoc-plot mdbook fd jq tree-sitter-cli

rustup install stable
rustup install nightly

sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

git clone https://github.com/elijah-potter/dots
mv dots .config

echo "[target.x86_64-unknown-linux-gnu]
      linker = \"clang\"
      rustflags = [\"-C\", \"link-arg=-fuse-ld=$(which mold)\"]" >> ~/.cargo/config.toml

chsh -s /usr/bin/fish
