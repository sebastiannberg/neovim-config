# neovim-config
Inspired by neovim kickstart

## Install

### Required Tools
- nodejs and npm
```bash
node -v
npm -v
```

- tree-sitter-cli
  - rust and cargo is needed for building tree-sitter
  - build tree-sitter/cli and cp it to a bin location
```bash
tree-sitter --version
```

- command-line utilities
```bash
sudo apt install ripgrep fd-find wget
```

### Installing Neovim
- install build dependencies
```bash
sudp apt install cmake gettext
```

- clone and build neovim
```bash
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
nvim --version
```

### Clone Config
- go to config location
```bash
~/.config
```
- clone this repo
```bash
git clone https://github.com/sebastiannberg/neovim-config.git nvim
```

### WSL Clipboard Support
for clipboard sync between WSL and Windows clipboard
- download win32yank.exe
- add win32yank.exe location to PATH
- neovim in WSL will automatically use win32yank.exe for clipboard operations
