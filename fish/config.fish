# Stop .lesshst from appearing
export LESSHISTFILE=-

set -x EDITOR nvim

# Add rust toolchain to path
set -x PATH $HOME/.cargo/bin/ $PATH

starship init fish | source
