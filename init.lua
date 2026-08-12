-- Enable Neovim's Lua-module bytecode cache. This is the single biggest startup
-- win: compiled Lua chunks (config + every plugin) are cached, so subsequent
-- launches skip re-parsing. Must run before anything is require()d.
vim.loader.enable()

require("srijan")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
    -- Borderless :Lazy UI to match the seamless float theme
    ui = { border = "none" },
    -- Try to load one of these colorschemes when starting an install during startup
    install = { colorscheme = { "catppuccin", "habamax" } },
    -- Check for plugin updates periodically (notification only)
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
    performance = {
        rtp = {
            -- Disable unused built-in plugins to shave startup time
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

-- Colorscheme is applied by the catppuccin plugin spec (see lua/plugins/catppuccin.lua)
