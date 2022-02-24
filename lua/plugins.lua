local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  use 'will133/vim-dirdiff'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }

  use "mhinz/vim-startify"

  use 'numToStr/Comment.nvim'

  use 'hoob3rt/lualine.nvim'

  use 'wellle/targets.vim'

  use 'norcalli/nvim-colorizer.lua'

  use 'numToStr/Navigator.nvim'

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    }
  }

  use 'onsails/lspkind-nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'fatih/vim-go'
  use 'windwp/nvim-autopairs'
  use 'folke/trouble.nvim'
  use 'sbdchd/neoformat'
  use 'ray-x/lsp_signature.nvim'
  use 'f-person/git-blame.nvim'
  use 'tpope/vim-surround'
  use 'j-hui/fidget.nvim'
end)