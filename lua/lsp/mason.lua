local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    vim.notify("Error from mason!")
    return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    vim.notify("Error from mason-lspconfig!")
    return
end

local mason_null_ls_status_ok, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status_ok then
    vim.notify("Error from mason-null-ls!")
    return
end

-- Setup mason and mason-lspconfig --
mason.setup({
    ui = {
        -- Whether to automatically check for new versions when opening the :Mason window.
        check_outdated_packages_on_open = true,

        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },

        -- Size of the window. Accepts:
        -- - Integer greater than 1 for fixed width.
        -- - Float in the range of 0-1 for a percentage of screen width.
        width = 0.8,
        height = 0.9,

        icons = {
            -- The list icon to use for installed packages.
            package_installed = "◍",
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = "◍",
            -- The list icon to use for packages that are not installed.
            package_uninstalled = "◍",
        },

        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = "i",
            update_package = "u",
            check_package_version = "c",
            update_all_packages = "U",
            check_outdated_packages = "C",
            uninstall_package = "X",
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    },
})

mason_lspconfig.setup({
    -- list of servers for mason to install
    ensure_installed = {
        "lua_ls",
        "jsonls",
        "clangd",
        "pyright",
    },
    automatic_installation = true, -- auto-install configured servers with lspconfig
})

mason_null_ls.setup({
    ensure_installed = {
        "stylua",
        "prettier",
        "eslint_d",
    },
    automatic_installation = true,
    automatic_setup = true,
})

mason_null_ls.setup_handlers() -- if `automatic_setup` is true.
