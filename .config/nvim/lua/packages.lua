-- Packer plugins manager
-- Use `:PackerSync` to install/update
-- Use `:PackerClean` to delete unused
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end

return require("packer").startup(
  function()
    use "wbthomason/packer.nvim"
    use "joshdick/onedark.vim" -- Theme inspired by Atom
    use "mhartington/formatter.nvim"
    use "neovim/nvim-lspconfig" -- Collection of configurations for built-in LSP client
    use 'williamboman/nvim-lsp-installer'

    use "ludovicchabant/vim-gutentags" -- Automatic tags management
    use "itchyny/lightline.vim" -- Fancier statusline

    -- Autocompletion plugins
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"

    -- Add indentation guides
    use "lukas-reineke/indent-blankline.nvim"
    use "/windwp/nvim-autopairs" -- Autopairs

    use {
      "goolord/alpha-nvim",
      requires = {"kyazdani42/nvim-web-devicons"},
      config = function()
        require "alpha".setup(require "alpha.themes.startify".config)
        local startify = require("alpha.themes.startify")
        startify.section.bottom_buttons.val = {
          startify.button("v", "neovim config", ":e ~/.config/nvim/init.lua <cr>"),
          startify.button("q", "quit nvim", ":qa <cr>")
        }
        vim.api.nvim_set_keymap("n", "<c-n>", ":Alpha <cr>", {noremap = true})
      end
    }

    -- IDE
    use "nvim-treesitter/nvim-treesitter"

    if packer_bootstrap then
      require("packer").sync()
    end
  end
)
