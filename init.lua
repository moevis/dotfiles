require("plugins")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[highlight NvimTreeFolderIcon guibg=blue]])
vim.cmd([[let g:go_list_type = "quickfix"]])
vim.cmd([[let g:go_def_mapping_enabled = 0]])
vim.cmd([[let g:go_doc_keywordprg_enabled = 0    ]])

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
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_indent_markers = 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_disable_window_picker = 0
vim.g.nvim_tree_icon_padding = " "
vim.g.nvim_tree_symlink_arrow = " >> "
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_create_in_closed_folder = 0
vim.g.nvim_tree_refresh_wait = 500
vim.g.nvim_tree_special_files = { ["README.md"] = 1, ["package.json"] = 1, ["Makefile"] = 1 }
vim.g.nvim_tree_window_picker_exclude = {
	["filetype"] = { "notify", "packer", "qf", "Trouble" },
	["buftype"] = { "terminal", "Trouble" },
}

vim.g.nvim_tree_show_icons = {
	["git"] = 1,
	["folders"] = 1,
	["files"] = 0,
	-- ['folder_arrows']= 0,
}

require("nvim-tree").setup({
    diagnostics = {
        enable = false,
        icons = {
            hint = "ÔÅ™",
            info = "ÔÅö",
            warning = "ÔÅ±",
            error = "ÔÅó"
        }
    },
    git = {
        custom = {".git", "node_modules", ".cache"},
        ignore = true
    }
})

require("Comment").setup({})

require("lualine").setup({
	options = { theme = "gruvbox" },
})

require("colorizer").setup({})

-- refactor
local refactor = require("refactoring")
refactor.setup({})

-- telescope refactoring helper
local function refactor(prompt_bufnr)
	local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
	require("telescope.actions").close(prompt_bufnr)
	require("refactoring").refactor(content.value)
end

M = {}
M.refactors = function()
	local opts = require("telescope.themes").get_cursor() -- set personal telescope options
	require("telescope.pickers").new(opts, {
		prompt_title = "refactors",
		finder = require("telescope.finders").new_table({
			results = require("refactoring").get_refactors(),
		}),
		sorter = require("telescope.config").values.generic_sorter(opts),
		attach_mappings = function(_, map)
			map("i", "<CR>", refactor)
			map("n", "<CR>", refactor)
			return true
		end,
	}):find()
end

map(
	"v",
	"<Leader>re",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
map(
	"v",
	"<Leader>rf",
	[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
	{ noremap = true, silent = true, expr = false }
)
map("v", "<Leader>rt", [[ <Esc><Cmd>lua M.refactors()<CR>]], { noremap = true, silent = true, expr = false })

-- LSPConfig
require("lsp_signature").setup()
local nvim_lsp = require("lspconfig")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "clangd", "tsserver", "gopls", "diagnosticls" }
for _, lsp in ipairs(servers) do
	nvim_lsp[lsp].setup({
		capabilities = capabilities,
	})
end

-- Set completeopt to have a better completion experience
o.completeopt = "menu,menuone,noselect"
-- o.completeopt = "menuone,noselect"

-- luasnip setup
local luasnip = require("luasnip")
local s = luasnip.snippet
local sn = luasnip.snippet_node
local t = luasnip.text_node
local i = luasnip.insert_node
local f = luasnip.function_node
local c = luasnip.choice_node
local d = luasnip.dynamic_node

luasnip.snippets = {
	go = {
		s("//@swag", {
			t("// @Title "),
			i(1, "api title"),
			t({ "", "// @Version " }),
			i(2, "1.0.0"),
			t({ "", "// @Description " }),
			i(3, "api desc"),
			t({ "", "@Accpet " }),
			i(4, "json"),
		}),
		s("//@api", {
			t("// @Summary "),
			i(1),
			t({ "", "// @Tags " }),
			t({ "", "// @Accept json" }),
			t({ "", "// @Produce json" }),
			t({ "", "// @Router /" }),
			i(2),
			t(" ["),
			i(3, "get"),
			t({ "]", "" }),
		}),
		s("//@param", {
			t("// @Param "),
			i(1, "name"),
			c(2, { t("path"), t("body"), t("query") }),
			c(3, { t("string"), t("integer"), t("number") }),
			t(" "),
			c(4, { t("true"), t("false") }),
			t(' "'),
			i(5, "desc"),
			t('"'),
		}),
		s("//@path", {
			t("// @Param "),
			i(1, "name"),
			t(" path "),
			c(2, { t("string"), t("integer"), t("number") }),
			t(" "),
			c(3, { t("true"), t("false") }),
			t(' "'),
			i(4, "desc"),
			t('"'),
		}),
		s("//@body", {
			t("// @Param "),
			i(1, "name"),
			t(" body "),
			c(2, { t("object") }),
			t(" "),
			c(3, { t("true"), t("false") }),
			t(' "'),
			i(4, "desc"),
			t('"'),
		}),
		s("//@query", {
			t("// @Param "),
			i(1, "name"),
			t(" query "),
			c(2, { t("string"), t("integer"), t("number") }),
			t(" "),
			c(3, { t("true"), t("false") }),
			t(' "'),
			i(4, "desc"),
			t('"'),
		}),
		s("//@success", {
			t("// @Success 200 {object} "),
			i(1, "model"),
		}),
	},
}

vim.cmd([[imap <silent><expr> <C-j> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-j>']])
vim.cmd([[imap <silent><expr> <C-k> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-k>']])
vim.cmd([[imap <silent><expr> <C-j> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-j>']])
vim.cmd([[smap <silent><expr> <C-k> luasnip#choice_active() ? '<Plug>luasnip-prev-choice' : '<C-k>']])

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		-- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
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

-- tmux Navigator
require("Navigator").setup({})

local opts = { noremap = true, silent = true }

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
				luasnip = "[SN]",
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
})

require "fidget".setup {}