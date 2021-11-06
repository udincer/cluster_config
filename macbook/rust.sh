# install rust (interactive)
curl https://sh.rustup.rs -sSf | sh

cargo install exa
echo "alias l='exa -lhF --git'" >> ~/.bashrc

cargo install fd-find
cargo install ripgrep
cargo install du-dust

# sed replacement
cargo install sd

# undoable rm
cargo install rm-improved