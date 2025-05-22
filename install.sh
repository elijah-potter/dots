#! /bin/bash

set -eo pipefail

pacman -Syu --noconfirm base-devel texlive neovim zip unzip zstd gzip pigz ripgrep eza dust fish git rustup nodejs npm starship pandoc wasm-pack go dotnet-sdk aspnet-runtime clang docker docker-buildx mold lazygit bacon xdg-utils tokei openssh gnuplot bat pandoc-plot mdbook fd jq tree-sitter-cli jdk17-openjdk gradle sudo perf man python-pytorch jupyterlab python-pyarrow

# Create my user, add it to wheel, and give wheel `sudo` permission.
useradd -m -G wheel -s /usr/bin/fish elijahpotter
sed -i 's/# \(%wheel ALL=(ALL:ALL) ALL\)/\1/' /etc/sudoers

corepack enable

sudo -i -u elijahpotter bash << EOF
yarn set version stable

rustup install stable
rustup install nightly

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ..
rm -rf paru

git clone git@github.com:elijah-potter/dots.git
mv dots .config

echo "[target.x86_64-unknown-linux-gnu]
      linker = \"clang\"
      rustflags = [\"-C\", \"link-arg=-fuse-ld=$(which mold)\"]" > ~/.cargo/config.toml

git clone https://github.com/elijah-potter/tatum
cd tatum
cargo install --path .
cd ..
rm -rf tatum
EOF
