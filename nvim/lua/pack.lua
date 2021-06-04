-- Packer
--
-- Bootstraps Packer if it's not installed.
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- If the install path is empty, clone the Packer repo into it, then attempt
-- to add packer itself via the packadd install command.
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.api.nvim_command("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.api.nvim_command("packadd packer.nvim")
end
