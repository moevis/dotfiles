local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd([[packadd packer.nvim cfilter]])

return require("packer").startup(function()
	-- ui
	use({ "ellisonleao/gruvbox.nvim", requires = "rktjmp/lush.nvim" })
	use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
	use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
	use("hoob3rt/lualine.nvim")
	use("norcalli/nvim-colorizer.lua")
	use({ "numToStr/Navigator.nvim" })
	use("folke/trouble.nvim")
	use("will133/vim-dirdiff")
	use({ "lewis6991/gitsigns.nvim", requires = "nvim-lua/plenary.nvim" })
	use("rcarriga/nvim-notify")
	use("petertriho/nvim-scrollbar")
	use("xiyaowong/nvim-transparent")
	use("RishabhRD/popfix")
	use({ "hood/popui.nvim", require = { "RishabhRD/popfix" } })
	use("lukas-reineke/indent-blankline.nvim")
	use("jeffkreeftmeijer/vim-numbertoggle")

	-- better code editing
	use("nvim-treesitter/nvim-treesitter")
	use({ "ThePrimeagen/refactoring.nvim", requires = "nvim-lua/plenary.nvim" })
	use("RRethy/nvim-treesitter-textsubjects")
	use("p00f/nvim-ts-rainbow")
	use("onsails/lspkind-nvim")
	use("neovim/nvim-lspconfig")
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("windwp/nvim-autopairs")

	-- lsp
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/cmp-nvim-lsp")
	use("ray-x/lsp_signature.nvim")

	-- toolset
	use("moevis/json.nvim")
	use("moevis/base64.nvim")
	use("moevis/smartjump.nvim")
	use("sbdchd/neoformat")
	use("tpope/vim-surround")
	use("numToStr/Comment.nvim")
	use("wellle/targets.vim")
	use("sindrets/diffview.nvim")
	use("NTBBloodbath/rest.nvim")
	use("github/copilot.vim")

	-- language specific
	use("mtdl9/vim-log-highlighting")
	use("fatih/vim-go")
	use("b0o/schemastore.nvim")

	-- copy via ssh
	use("ojroques/vim-oscyank")
end)
