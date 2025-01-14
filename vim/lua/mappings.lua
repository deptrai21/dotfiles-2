local map = require("utils").map
local git = require "git"
local leader = "<space>"

map("n", leader .. leader, ":<C-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<CR>")

map("n", leader .. "<C-o>", ":lua require 'buffers'.close_others()<CR>")

map("n", leader .. "q", ":lua require 'buffers'.close()<CR>")
map("n", leader .. "w", ":update<CR>")

map("n", leader .. "z", "1z=")

map("n", leader .. "rr", ":%s/\\v()", { silent = false })
map("x", leader .. "rr", ":s/\\v%V()", { silent = false })

map("n", leader .. "N", ":e %:h/", { silent = false })

map("n", leader .. "of", "<CMD>lua require('orgmode').action('capture.prompt')<CR>")
map("n", leader .. "oa", "<CMD>lua require('orgmode').action('agenda.prompt')<CR>")

vim.keymap.set("n", leader .. "e", require("treesj").toggle)

local virtual_lines_enabled = false
vim.keymap.set("n", leader .. "ll", function()
    virtual_lines_enabled = not virtual_lines_enabled
    vim.diagnostic.config {
        virtual_lines = virtual_lines_enabled,
        virtual_text = not virtual_lines_enabled and {
            spacing = 3,
            prefix = " ",
            severity_sort = true,
            source = "if_many",
        },
    }
end)

vim.keymap.set("n", leader .. "tt", function()
    require("neotest").run.run()
end)
vim.keymap.set("n", leader .. "to", function()
    require("neotest").output.open {
        enter = true,
        open_win = function(settings)
            local height = math.min(settings.height, vim.o.lines - 2)
            local width = math.min(settings.width, vim.o.columns - 2)
            return vim.api.nvim_open_win(0, true, {
                relative = "editor",
                row = 7,
                col = (vim.o.columns - width) / 2,
                width = width,
                height = height,
                style = "minimal",
                border = vim.g.floating_window_border,
                noautocmd = true,
            })
        end,
    }
end)
vim.keymap.set("n", leader .. "ts", function()
    require("neotest").summary.toggle()
end)
vim.keymap.set("n", leader .. "tf", function()
    require("neotest").run.run(vim.fn.expand "%")
end)
vim.keymap.set("n", leader .. "td", function()
    require("neotest").run.run { strategy = "dap" }
end)

vim.keymap.set("n", leader .. "dc", require("dap").continue)
vim.keymap.set("n", leader .. "db", require("dap").toggle_breakpoint)
vim.keymap.set("n", leader .. "dB", function()
    require("dap").toggle_breakpoint(vim.fn.input "Breakpoint condition: ")
end)
vim.keymap.set("n", leader .. "do", require("dapui").toggle)
vim.keymap.set("n", leader .. "di", function()
    require("lists").change_active "Quickfix"
    require("dap").list_breakpoints()
    vim.cmd [[copen]]
end)
vim.keymap.set("n", leader .. "dp", require("dap").clear_breakpoints)
vim.keymap.set("n", leader .. "d<CR>", require("dapui").eval)
vim.keymap.set("n", leader .. "dh", require("dap").step_out)
vim.keymap.set("n", leader .. "dj", require("dap").step_over)
vim.keymap.set("n", leader .. "dk", require("dap").step_back)
vim.keymap.set("n", leader .. "dl", require("dap").step_into)

map("n", "<UP>", ":lua require('lists').move('up')<CR>")
map("n", "<DOWN>", ":lua require('lists').move('down')<CR>")
map("n", "<LEFT>", ":lua require('lists').move('left')<CR>")
map("n", "<RIGHT>", ":lua require('lists').move('right')<CR>")
map(
    "n",
    leader .. "c",
    "<Plug>(qf_qf_toggle_stay):lua require('lists').change_active('Quickfix')<CR>",
    { noremap = false }
)
map(
    "n",
    leader .. "v",
    "<Plug>(qf_loc_toggle_stay):lua require('lists').change_active('Location')<CR>",
    { noremap = false }
)
map("n", leader .. "b", ":lua require('lists').toggle_active()<CR>")
map("n", leader .. "a", ":lua require('lists').change_active('Quickfix')<CR>:silent grep ", { silent = false })

map("n", "Y", "y$", { noremap = false })
map("n", "x", '"_x')

map("x", "iu", ':lua require"treesitter-unit".select()<CR>', { noremap = true })
map("x", "au", ':lua require"treesitter-unit".select(true)<CR>', { noremap = true })
map("o", "iu", ':<c-u>lua require"treesitter-unit".select()<CR>', { noremap = true })
map("o", "au", ':<c-u>lua require"treesitter-unit".select(true)<CR>', { noremap = true })

map("n", "<C-h>", "<CMD>lua require('Navigator').left()<CR>")
map("n", "<C-j>", "<CMD>lua require('Navigator').down()<CR>")
map("n", "<C-k>", "<CMD>lua require('Navigator').up()<CR>")
map("n", "<C-l>", "<CMD>lua require('Navigator').right()<CR>")

map("n", "<c-w>l", "<c-w>5>")
map("n", "<c-w>h", "<c-w>5<")
map("n", "<c-w>k", "<c-w>5+")
map("n", "<c-w>j", "<c-w>5-")

map({ "n", "o", "v" }, "H", "^")
map({ "n", "o", "v" }, "L", "$")

map({ "n", "v" }, "J", "5j")
map({ "n", "v" }, "K", "5k")

map({ "n", "v" }, "j", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'j' : 'gj'", { expr = true })
map({ "n", "v" }, "k", "v:count ? (v:count > 5 ? \"m'\" . v:count : '') . 'k' : 'gk'", { expr = true })

map("", "w", "<Plug>CamelCaseMotion_w", { noremap = false })
map("", "b", "<Plug>CamelCaseMotion_b", { noremap = false })
map("", "e", "<Plug>CamelCaseMotion_e", { noremap = false })
map("", "ge", "<Plug>CamelCaseMotion_ge", { noremap = false })

map("n", "<C-p>", ":lua require('fuzzy').files('')<CR>")
map("n", leader .. "gf", ":lua require('fuzzy').git_files()<CR>")
map("n", leader .. "n", ":lua require('fuzzy').files(vim.fn.expand('%:h'))<CR>")
map("n", leader .. "p", ":Buffers<CR>")
map("n", leader .. "<C-p>", ":Commands<CR>")
map("n", leader .. "<C-h>", ":Helptags<CR>")
map("n", leader .. "m", ":Marks<CR>")
map("n", leader .. "f", ":lua require('fuzzy').symbols()<CR>")

vim.keymap.set("n", "-", function()
    if git.is_repo() then
        vim.cmd(string.format("Neotree reveal git_base=%s", vim.g.git_base))
    else
        vim.cmd [[Neotree reveal]]
    end
end)
vim.keymap.set("n", "g-", function()
    if git.is_repo() then
        vim.cmd(string.format("Neotree current git_status git_base=%s", vim.g.git_base))
    else
        vim.notify("Not a git repo", vim.log.levels.ERROR)
    end
end)

map(
    "i",
    "<CR>",
    [[pumvisible() ? complete_info()["selected"] != "-1" ? "\<Plug>(completion_confirm_completion)" : "\<c-e>" : lexima#expand('<LT>CR>', 'i')]],
    { expr = true, noremap = false }
)

map("n", "grr", "<Plug>ReplaceWithSameIndentRegisterLine", { noremap = false })
map("n", "grR", "<Plug>ReplaceWithRegisterLine", { noremap = false })
map("n", "gr", "<Plug>ReplaceWithRegisterOperator", { noremap = false })

map("n", "<CLEAR-1>", "<Plug>UnconditionalPasteLineAfter", { noremap = false })
map("n", "<CLEAR-2>", "<Plug>UnconditionalPasteLineBefore", { noremap = false })
map("n", "<CLEAR-3>", "<Plug>UnconditionalPasteCommaAfter", { noremap = false })
map("n", "<CLEAR-4>", "<Plug>UnconditionalPasteCommaBefore", { noremap = false })
map("n", "<CLEAR-5>", "<Plug>UnconditionalPasteCommaSingleQuoteAfter", { noremap = false })
map("n", "<CLEAR-6>", "<Plug>UnconditionalPasteCommaSingleQuoteBefore", { noremap = false })
map("n", "<CLEAR-7>", "<Plug>VimwikiIncrementListItem", { noremap = false })
map("n", "<CLEAR-8>", "<Plug>VimwikiDecrementListItem", { noremap = false })
map("n", "<CLEAR-9>", "<Plug>UnconditionalPasteUnjoinBefore", { noremap = false })
map("n", "<CLEAR-10>", "<Plug>UnconditionalPasteUnjoinAfter", { noremap = false })
map("n", "glp", "<Plug>UnconditionalPasteIndentedAfter", { noremap = false })
map("n", "glP", "<Plug>UnconditionalPasteIndentedBefore", { noremap = false })

map("n", "gck", "m'yypgcc`'", { noremap = false })

map({ "n", "o" }, "*", "<Plug>(is-*)N", { noremap = false })
map({ "n", "o" }, "g*", "<Plug>(is-g*)N", { noremap = false })

map("n", "gj", "<Plug>(GitGutterNextHunk)", { noremap = false })
map("n", "gk", "<Plug>(GitGutterPrevHunk)", { noremap = false })
map("n", leader .. "gd", ":set nosplitright<CR>:execute 'Gvdiff ' .. g:git_base<CR>:set splitright<CR>")
map("n", leader .. "gr", ":Gread<CR>")
map("n", leader .. "gb", ":Git blame<CR>")
map("n", leader .. "gs", ":Git<CR>")
map("n", leader .. "gm", "<Plug>(git-messenger)", { noremap = false })
map("n", leader .. "gu", "<Plug>(GitGutterUndoHunk)", { noremap = false })
map("n", leader .. "ga", "<Plug>(GitGutterStageHunk)", { noremap = false })
map("n", leader .. "gc", ":0Gclog<CR>", { noremap = false })
map(
    "n",
    leader .. "gg",
    ":lua require('lists').change_active('Quickfix')<CR>:execute 'Git difftool ' .. g:git_base<CR>"
)
map("n", leader .. "gn", ":lua require('lists').change_active('Quickfix')<CR>:Git mergetool<CR>")
map("n", leader .. "gh", ":diffget //2<CR> :diffupdate<CR>")
map("n", leader .. "gl", ":diffget //3<CR> :diffupdate<CR>")

map({ "n", "v" }, "gx", "<Plug>(openbrowser-smart-search)", { noremap = false })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("v", "I", "<Plug>(niceblock-I)", { noremap = false })
map("v", "gI", "<Plug>(niceblock-gI)", { noremap = false })
map("v", "A", "<Plug>(niceblock-A)", { noremap = false })

map("x", "P", [['"_d"'.v:register.'P']], { expr = true })

map("n", leader .. "j", "<cmd>lua require'luasnip'.jump(1)<Cr>")
map("n", leader .. "k", "<cmd>lua require'luasnip'.jump(-1)<Cr>")

-- map({ "i", "s" }, "<Tab>", "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", { expr = true })
-- map({ "i", "s" }, "<S-Tab>", "<cmd>lua require'luasnip'.jump(-1)<Cr>")

map({ "i", "s" }, "<C-e>", "<Plug>luasnip-next-choice", { noremap = false })

map("c", "<C-J>", "<DOWN>")
map("c", "<C-K>", "<UP>")

vim.cmd [[cabbrev nw noautocmd write]]
