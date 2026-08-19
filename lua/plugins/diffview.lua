return {
    'sindrets/diffview.nvim',
    config = function()
        require('diffview').setup({
            default_args = { DiffviewOpen = { '--imply-local' } },
        })

        -- Pick side-by-side diffs when each pane gets >= 100 cols, stacked otherwise
        local function sync_layout()
            local conf = require('diffview.config').get_config()

            local panel_width = 35
            if type(conf.file_panel.win_config) == 'table'
                and type(conf.file_panel.win_config.width) == 'number' then
                panel_width = conf.file_panel.win_config.width
            end

            local pane_width = (vim.o.columns - panel_width - 1) / 2
            conf.view.default.layout =
                pane_width < 100 and 'diff2_vertical' or 'diff2_horizontal'
        end

        sync_layout()
        vim.api.nvim_create_autocmd('VimResized', {
            group = vim.api.nvim_create_augroup('DiffviewLayout', {}),
            callback = sync_layout,
        })
    end,
}
