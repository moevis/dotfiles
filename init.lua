require("plugins")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[let g:go_list_type = "quickfix"]])
vim.cmd([[let g:go_def_mapping_enabled = 0]])
vim.cmd([[let g:go_doc_keywordprg_enabled = 0 ]])

vim.g.mapleader = ","
local map = vim.api.nvim_set_keymap

local o = vim.o
local api = vim.api

o.splitright = true
o.showmatch = true
o.termguicolors = true
o.wildoptions = "pum"

map("c", "<up>", 'pumvisible() ? "<C-p>" : "<up>"', { noremap = true, expr = true, silent = false })
map("c", "<down>", 'pumvisible() ? "<C-n>" : "<down>"', { noremap = true, expr = true, silent = false })
map("c", "<left>", 'pumvisible() ? "<up>" : "<left>"', { noremap = true, expr = true, silent = false })
map("c", "<right>", 'pumvisible() ? "<C-e>" : "<right>"', { noremap = true, expr = true, silent = false })

o.autoread = true
o.hidden = true
o.writebackup = true
o.backupcopy = "yes"
o.undodir = vim.fn.expand("~/.vim/undodir")
o.undofile = true
o.swapfile = false
o.wb = false

o.number = true
o.laststatus = 2
o.cursorline = true

o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.autoindent = true

o.ignorecase = true
o.smartcase = true

map("v", "<leader>o", ':OSCYank<cr>', { noremap = true })
map("v", "<leader>y", '"+y<cr>', { noremap = true })
map("v", "<leader>p", '"+p<cr>', { noremap = true })
map("v", "<leader>x", '"_d<cr>', { noremap = true })
map("n", "gp", "`[v`]", {})
map("n", "<leader>l", ":set invnumber<cr>", {})
map("n", "<backspace>", ":nohl<cr>", { noremap = true })

-- telescope
local opts = { noremap = true, silent = true }

map("n", "<leader>w", "<cmd>lua require('telescope.builtin').git_files({show_untracked = false})<CR>", opts)
map("n", "<leader>s", "<cmd>lua require('telescope.builtin').git_status()<CR>", opts)
map("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep() <CR>", opts)
map("n", "<leader>k", "<cmd>lua require('telescope.builtin').grep_string()<CR>", opts)

map("n", "<leader>nn", "<cmd>NvimTreeToggle<CR>", opts)

-- nvim-tree
require("nvim-tree").setup({
    diagnostics = {
        enable = true,
        icons = { hint = "", info = "", warning = "", error = "" }
    },
	git = { ignore = true },
	filters = { custom = { ".git", "node_modules", ".cache" } },
	renderer = { indent_markers = { enable = true }, },
	actions = {
		open_file = {
    	quit_on_open = true,
			window_picker = {
				enable = true,
				exclude = {
					["filetype"] = { "notify", "packer", "qf", "Trouble" },
					["buftype"] = { "terminal", "Trouble" },
				},
			},
		},
	},
})

require("Comment").setup({})

require("lualine").setup({
	options = {
		theme = "gruvbox",
		section_separators = { left = "", right = "" },
		component_separators = { left = "", right = "" },
	},
	sections = {
		lualine_b = { "branch", "diff", "diagnostics" },
	},
	extensions = { "quickfix", "nvim-tree" },
})

require("colorizer").setup({})

-- LSPConfig
require("lsp_signature").setup()
local nvim_lsp = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Lua language server config
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

nvim_lsp.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
})


-- Set completeopt to have a better completion experience
o.completeopt = "menu,menuone,noselect"
-- o.completeopt = "menuone,noselect"

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	},
})

-- Mappings.
local opts = { noremap = true, silent = true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

map('n', 'gl', '<cmd>GoToFile<CR>', opts)

-- tmux Navigator
require("Navigator").setup({})

map("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>", opts)
map("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>", opts)
map("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>", opts)
map("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>", opts)
map("n", "<C-p>", "<CMD>lua require('Navigator').previous()<CR>", opts)

require("Navigator").setup({
	disable_on_zoom = false,
})

require("nvim-autopairs").setup({
	map_cr = true,
})

local lspkind = require("lspkind")
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			with_text = true,
			maxwidth = 50,
			maxheight = 50,
			menu = {
				buffer = "[B]",
				nvim_lsp = "[LS]",
			},
		}),
	},
})
vim.cmd([[hi CmpItemKind ctermfg=White]])
vim.cmd([[hi CmpItemMenu ctermfg=White]])

require("trouble").setup({})

map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
map("n", "<leader>ff", "<cmd>Neoformat<cr>", opts)

require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = true },
	rainbow = { enable = true },
	textsubjects = {
		enable = true,
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
		},
	},
})

require "fidget".setup {}

require('gitsigns').setup{
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
    end

    -- Navigation
    map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
    map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

    -- Actions
    map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
    map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
    map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
    map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
    map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
    map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
    map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
    map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')

    -- Text object
    map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

require("scrollbar").setup()
require("transparent").setup({ enable = true })
require("indent_blankline").setup({ show_end_of_line = true })

vim.notify = require("notify")
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
vim.ui.select = require("popui.ui-overrider")
vim.ui.input = require("popui.input-overrider")
