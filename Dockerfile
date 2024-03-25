FROM archlinux:latest

RUN pacman -Syu --noconfirm
RUN pacman -S neovim fish ripgrep fd bat rustup wasm-pack zip unzip zstd wget tokei pigz nodejs jq lazygit mold mdbook htop git gnuplot gdb dotnet-sdk cmake clang cross aspnet-runtime texlive --noconfirm

RUN rustup update

RUN mkdir ~/.config
COPY * ~/.config/

