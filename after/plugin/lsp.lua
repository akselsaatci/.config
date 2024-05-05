local lsp_zero = require('lsp-zero')
local k, l, api = vim.keymap.set, vim.lsp, vim.api

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
    if client.name == "omnisharp" then client.server_capabilities.semanticTokensProvider = nil end
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    k("n", "gD", l.buf.declaration, bufopts)
    k("n", "gd", l.buf.definition, bufopts)
    k("n", "gi", l.buf.implementation, bufopts)
    k("n", "<leader>D", l.buf.type_definition, bufopts)
    k("n", "gr", l.buf.references, bufopts)
    k("n", "<leader>ca", l.buf.code_action, bufopts)
    k("v", "<leader>ca", l.buf.code_action, bufopts)
    k("n", "<leader>rn", l.buf.rename, bufopts)
    k("n", "<leader>h", l.buf.signature_help, bufopts)
end)

local cmp = require('cmp')

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    })
})


require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
    },
})
