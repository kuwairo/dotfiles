local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
    return
end

local ls_status, luasnip = pcall(require, "luasnip")
if not ls_status then
    return
end

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    },
})

