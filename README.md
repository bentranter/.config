# dotfiles

Config for Neovim 0.6 or higher.

<p align="center">
  <img src="screenshot.png" alt="Screenshot of terminal" title="Screenshot of terminal">
</p>

### Installation

To install these, you'll need either [Neovim](https://neovim.io/) 0.6 prerelease installed on your machine. This can be done by running,

```sh
brew install neovim --HEAD # Installs Neovim 0.6 prerelease.
brew install luajit --HEAD # Install the latest LuaJIT, required for Neovim to work on macOS Catalina.
```

Once Neovim and LuaJIT are installed, you'll need to run `:PackerInstall` and `:PackerCompile` inside Neovim to install third party dependencies.

### Language Server

This config relies on the following Language Servers being installed,

1. `gopls` (See [github.com/golang/gopls](https://github.com/golang/tools/tree/master/gopls))
2. `sourcegraph` (`gem install --user-install solargraph`)
3. `tailwindcss` (`npm install -g @tailwindcss/language-server`)
