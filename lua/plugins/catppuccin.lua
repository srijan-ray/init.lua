return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			background = { -- :h background
				light = "latte",
				dark = "macchiato",
			},

			-- NOTE: integration flags MUST live under `integrations`. They were
			-- previously at the top level, where catppuccin silently ignored them.
			integrations = {
				alpha = true,
				blink_cmp = true,
				dap = true,
				dap_ui = true,
				fidget = true,
				gitsigns = true,
				indent_blankline = { enabled = true },
				markdown = true,
				mason = true,
				mini = true,
				noice = true,
				notify = true,
				rainbow_delimiters = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,

				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},

			-- Floating windows, the catppuccin way: a subtly-raised `mantle`
			-- background with a soft, thin rounded border (`surface1`) so every
			-- float reads as a floating card — defined, but never a harsh black box.
			-- No near-black `crust` anywhere.
			custom_highlights = function(C)
				local float = C.mantle
				local preview = C.base -- a touch lighter, to separate the fzf preview pane
				local border = C.surface1
				return {
					-- Generic floats (LSP hover, signature, diagnostics, etc.)
					NormalFloat = { bg = float },
					FloatBorder = { fg = border, bg = float },
					FloatTitle = { fg = C.lavender, bg = float, style = { "bold" } },

					-- Built-in popup menus
					Pmenu = { bg = float },
					PmenuSel = { bg = C.surface1, style = { "bold" } },
					PmenuSbar = { bg = float },
					PmenuThumb = { bg = C.surface2 },

					-- blink.cmp
					BlinkCmpMenu = { bg = float },
					BlinkCmpMenuBorder = { fg = border, bg = float },
					BlinkCmpDoc = { bg = float },
					BlinkCmpDocBorder = { fg = border, bg = float },
					BlinkCmpSignatureHelp = { bg = float },
					BlinkCmpSignatureHelpBorder = { fg = border, bg = float },

					-- fzf-lua (borderless, Mason-style): the results/prompt sit on the
					-- mantle float and the preview on the slightly lighter `base`, so the
					-- two panes are distinguishable even with no border between them.
					FzfLuaNormal = { bg = float },
					FzfLuaBorder = { fg = float, bg = float },
					FzfLuaTitle = { fg = C.lavender, bg = float, style = { "bold" } },
					FzfLuaPreviewNormal = { bg = preview },
					FzfLuaPreviewBorder = { fg = preview, bg = preview },
					FzfLuaPreviewTitle = { fg = C.lavender, bg = preview, style = { "bold" } },
					FzfLuaCursorLine = { bg = C.surface0, style = { "bold" } },
					FzfLuaScrollFloatFull = { fg = C.surface2, bg = preview },

					-- which-key
					WhichKeyNormal = { bg = float },
					WhichKeyBorder = { fg = border, bg = float },

					-- Command-line popup + its completion/selection popupmenu: rounded
					-- border with a lavender accent.
					NoiceCmdlinePopup = { bg = float },
					NoiceCmdlinePopupBorder = { fg = C.lavender, bg = float },
					NoiceCmdlineIcon = { fg = C.lavender },
					NoicePopupmenu = { bg = float },
					NoicePopupmenuBorder = { fg = C.lavender, bg = float },
					NoicePopupmenuSelected = { bg = C.surface1, style = { "bold" } },

					-- Subtle split separators
					WinSeparator = { fg = C.surface0 },

					-- Notifications: mantle-body floating cards with a rounded border
					-- coloured by severity (see nvim-notify `on_open` border = rounded),
					-- so each toast reads as a distinct floating card.
					NotifyBackground = { bg = float },
					NotifyINFOBody = { bg = float },
					NotifyWARNBody = { bg = float },
					NotifyERRORBody = { bg = float },
					NotifyDEBUGBody = { bg = float },
					NotifyTRACEBody = { bg = float },
					NotifyINFOBorder = { fg = C.blue, bg = float },
					NotifyWARNBorder = { fg = C.yellow, bg = float },
					NotifyERRORBorder = { fg = C.red, bg = float },
					NotifyDEBUGBorder = { fg = C.surface2, bg = float },
					NotifyTRACEBorder = { fg = C.mauve, bg = float },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
