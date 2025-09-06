vim.diagnostic.config({
    virtual_text = {
        enabled = true,
        -- Customize how the virtual text is formatted
        format = function(diagnostic)
            return diagnostic.message
        end,
    },
})
