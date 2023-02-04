local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    vim.notify("Error from lspconfig!")
    return
end

local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status_ok then
    vim.notify("Error from cmp_nvim_lsp!")
    return
end

-- Signs --
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local config = {

    virtual_text = false, -- disable virtual text
    signs = {
        active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
}

vim.diagnostic.config(config)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})

-- Keybinds for available lsp server --
local keymap = vim.keymap

local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    -- set keybinds
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
    keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declearation()<CR>", opts) -- got to declaration
    keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- show documentation for what is under cursor
    keymap.set("n", "<leader>fm", "<cmd>lua vim.lsp.buf.format{ async = ture }<CR>", opts) -- show documentation for what is under cursor

    keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- show diagnostics for cursor
    keymap.set("n", "<leader>gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- jump to previous diagnostic in buffer
    keymap.set("n", "<leader>gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- jump to next diagnostic in buffer
    keymap.set("n", "<leader>gs", "<cmd>Lspsaga show_buf_diagnostics<CR>", opts) -- see available code actions

    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
    keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actins
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- see available code actions

    -- specific server keymaps
    --[[
    if client.name == "sumneko_lua" then
    end
    --]]
end
-- Used to enable autocompletion --
local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig["sumneko_lua"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = { -- custom settings for lua
        Lua = {
            -- make the language server recognize "vim" global
            diagnostics = { globals = { "vim" }, },
            -- make language server aware of runtime files
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    },
})

lspconfig["jsonls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig["clangd"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

--[[
lspconfig["gopls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig["graphql"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig["jdtls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})
--]]
