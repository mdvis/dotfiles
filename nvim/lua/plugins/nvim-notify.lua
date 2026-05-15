return {
    "rcarriga/nvim-notify",
    opts = {
        timeout = 2000,
        max_width = 50,
        max_height = 10,
        -- 可选: "top_left", "top_right", "bottom_left", "bottom_right"
        stages = "fade_in_slide_out",
        background_colour = "#000000",
        minimum_width = 30,
        icons = {
            ERROR = "",
            WARN = "",
            INFO = "",
            DEBUG = "",
            TRACE = "✎",
        },
        render = "compact",
        level = vim.log.levels.INFO,
        top_down = true,
    },
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)
        vim.notify = notify
        vim.keymap.set("n", "<leader>nc", function()
            notify.dismiss({ silent = true, pending = true })
        end, { desc = "Clear all notifications" })
    end,
}
