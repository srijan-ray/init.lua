return {
    -- {
    -- 	"hrsh7th/nvim-cmp",
    -- 	dependencies = {
    -- 		{ "onsails/lspkind.nvim" },
    -- 		{ "hrsh7th/cmp-nvim-lsp" },
    -- 		{ "hrsh7th/cmp-path" },
    -- 		{ "saadparwaiz1/cmp_luasnip" },
    -- 		{ "L3MON4D3/LuaSnip" },
    -- 		{ "rafamadriz/friendly-snippets" },
    -- 		{ "hrsh7th/cmp-buffer" },
    -- 		{ "hrsh7th/cmp-nvim-lua" },
    -- 		{ "kdheepak/cmp-latex-symbols" },
    -- 		{ "jmbuhr/cmp-pandoc-references" },
    -- 		{ "hrsh7th/cmp-calc" },
    -- 		{ "hrsh7th/cmp-emoji" },
    -- 		{ "kdheepak/cmp-latex-symbols" },
    -- 		{ "jmbuhr/cmp-pandoc-references" },
    -- 		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
    -- 	},
    -- 	event = "InsertEnter",
    -- 	config = function()
    -- 		local cmp = require("cmp")
    -- 		require("luasnip.loaders.from_vscode").lazy_load()
    -- 		local lspkind = require("lspkind")
    -- 		local luasnip = require("luasnip")
    -- 		local has_words_before = function()
    -- 			unpack = unpack or table.unpack
    -- 			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    -- 			return col ~= 0
    -- 				and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    -- 		end
    --
    -- 		cmp.setup({
    -- 			window = {
    -- 				completion = {
    -- 					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
    -- 				},
    -- 				-- documentation = cmp.config.window.bordered(),
    -- 			},
    -- 			formatting = {
    -- 				fields = { "kind", "abbr", "menu" },
    -- 				format = lspkind.cmp_format({
    -- 					mode = "symbol",
    -- 					menu = {
    -- 						otter = "[🦦]",
    -- 						nvim_lsp = "[LSP]",
    -- 						nvim_lsp_signature_help = "[LSP_Sig]",
    -- 						luasnip = "[LuaSnip]",
    -- 						buffer = "[Buffer]",
    -- 						path = "[Path]",
    -- 						pandoc_references = "[Pandoc]",
    -- 						tags = "[Tag]",
    -- 						calc = "[Calc]",
    -- 						latex_symbols = "[Tex]",
    -- 						emoji = "[Emoji]",
    -- 					},
    -- 				}),
    -- 			},
    -- 			mapping = cmp.mapping.preset.insert({
    -- 				["<c-n>"] = cmp.mapping.select_next_item(),
    -- 				["<c-p>"] = cmp.mapping.select_prev_item(),
    -- 				["<c-j>"] = cmp.mapping.scroll_docs(-4),
    -- 				["<c-k>"] = cmp.mapping.scroll_docs(4),
    -- 				["<c-Space>"] = cmp.mapping.complete({}),
    -- 				[";j"] = cmp.mapping.confirm({ select = true }),
    -- 				-- ["<Tab>"] = cmp.mapping(function(fallback)
    -- 				--     if cmp.visible() then
    -- 				--         cmp.select_next_item()
    -- 				--         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    -- 				--         -- that way you will only jump inside the snippet region
    -- 				--     elseif luasnip.expand_or_jumpable() then
    -- 				--         luasnip.expand_or_jump()
    -- 				--     elseif has_words_before() then
    -- 				--         cmp.complete()
    -- 				--     else
    -- 				--         fallback()
    -- 				--     end
    -- 				-- end, { "i", "s" }),
    -- 				--
    -- 				-- ["<S-Tab>"] = cmp.mapping(function(fallback)
    -- 				--     if cmp.visible() then
    -- 				--         cmp.select_prev_item()
    -- 				--     elseif luasnip.jumpable(-1) then
    -- 				--         luasnip.jump(-1)
    -- 				--     else
    -- 				--         fallback()
    -- 				--     end
    -- 				-- end, { "i", "s" }),
    -- 				-- ["<CR>"] = cmp.mapping.confirm({
    -- 				--     behavior = cmp.ConfirmBehavior.Replace,
    -- 				--     select = true,
    -- 				-- }),
    -- 			}),
    -- 			snippet = {
    -- 				expand = function(args)
    -- 					require("luasnip").lsp_expand(args.body)
    -- 				end,
    -- 			},
    -- 			sources = cmp.config.sources({
    -- 				{ name = "otter" },
    -- 				{ name = "path" },
    -- 				{ name = "nvim_lsp_signature_help" },
    -- 				{ name = "nvim_lsp" },
    -- 				{ name = "luasnip", max_item_count = 3 },
    -- 				{ name = "pandoc_references" },
    -- 				{ name = "buffer", keyword_length = 5, max_item_count = 3 },
    -- 				{ name = "calc" },
    -- 				{ name = "latex_symbols" },
    -- 				{ name = "emoji" },
    -- 			}, {}),
    -- 		})
    --
    -- 		cmp.config.formatting = {
    -- 			format = require("tailwindcss-colorizer-cmp").formatter,
    -- 		}
    -- 	end,
    -- },
    {
        "saghen/blink.compat",
        -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
        version = "*",
        -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
        lazy = true,
        -- make sure to set opts so that lazy.nvim calls blink.compat's setup
        opts = {},
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
            { "erooke/blink-cmp-latex" },
            -- { "jmbuhr/cmp-pandoc-references" },
            -- { "hrsh7th/cmp-calc" },
        },
        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            -- snippets = { preset = "luasnip" },
            keymap = { preset = "default" },

            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            sources = {
                default = { "snippets", "lsp", "path", "buffer", "latex" },
                providers = {
                    latex = {
                        name = "Latex",
                        module = "blink-cmp-latex",
                        opts = {
                            -- set to true to insert the latex command instead of the symbol
                            insert_command = true
                        },
                    },
                }
            },
        },
        opts_extend = { "sources.default" },
    },
}
