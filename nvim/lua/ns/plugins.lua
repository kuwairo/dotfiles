local fn = vim.fn

-- Packer auto-install
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git", "clone",
        "--depth", "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing Packer... Restart Neovim"
    vim.cmd [[packadd packer.nvim]]
end

-- Reload Neovim on plugins.lua update
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Safe-require Packer
local pr_status, packer = pcall(require, "packer")
if not pr_status then
    return
end

-- Packer as a popup window with rounded corners
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

return packer.startup(function(use)
    -- Packer
    use "wbthomason/packer.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-lua/popup.nvim"

    -- Colorscheme
    use "folke/tokyonight.nvim"

    -- Completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"

    -- Snippet engine for nvim-cmp
    use "saadparwaiz1/cmp_luasnip"
    use "L3MON4D3/LuaSnip"

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

