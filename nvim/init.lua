vim.g.mapleader = " " -- Space is the mapleader.
vim.keymap.set("n", "<leader>fe", vim.cmd.Ex) -- Type Space-p-v to open netrw.
vim.keymap.set("n", "<leader><Space>", ":noh<CR>") -- Hit space twice to clear search highlighting.

require("config")
require("pack")
require("plugins")

-- Experiments below.
-- Some servers have issues with backup files, see #649.
vim.opt.backup = false
vim.opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appear/become resolved.
vim.opt.signcolumn = "yes"

--local keyset = vim.keymap.set
---- Auto complete
--function _G.check_back_space()
--    local col = vim.fn.col('.') - 1
--    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
--end

---- Use tab for trigger completion with characters ahead and navigate.
---- NOTE: There's always complete item selected by default, you may want to enable
---- no select by `"suggest.noselect": true` in your configuration file.
---- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
---- other plugin before putting this into your config.
--local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
--keyset("i", "<c-n>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
--keyset("i", "<c-p>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

---- Make <CR> to accept selected completion item or notify coc.nvim to format
---- <C-g>u breaks current undo, please make your own choice.
--keyset("i", "<TAB>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

---- Use <c-j> to trigger snippets
--keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
---- Use <c-space> to trigger completion.
--keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

---- Use `[g` and `]g` to navigate diagnostics
---- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
--keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
--keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

---- GoTo code navigation.
--keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
--keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
--keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
--keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
--keyset("n", "gh", "<Plug>(coc-hover)", {silent = true})

---- Use "gh" to show documentation in preview window.
--function _G.show_docs()
--    local cw = vim.fn.expand('<cword>')
--    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
--        vim.api.nvim_command('h ' .. cw)
--    elseif vim.api.nvim_eval('coc#rpc#ready()') then
--        vim.fn.CocActionAsync('definitionHover')
--    else
--        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
--    end
--end
--keyset("n", "gh", '<CMD>lua _G.show_docs()<CR>', {silent = true})


---- Highlight the symbol and its references when holding the cursor.
--vim.api.nvim_create_augroup("CocGroup", {})
--vim.api.nvim_create_autocmd("CursorHold", {
--    group = "CocGroup",
--    command = "silent call CocActionAsync('highlight')",
--    desc = "Highlight symbol under cursor on CursorHold"
--})


---- Symbol renaming.
--keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})


---- Formatting selected code.
--keyset("x", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})
--keyset("n", "<leader>f", "<Plug>(coc-format-selected)", {silent = true})


---- Setup formatexpr specified filetype(s).
--vim.api.nvim_create_autocmd("FileType", {
--    group = "CocGroup",
--    pattern = "typescript,json",
--    command = "setl formatexpr=CocAction('formatSelected')",
--    desc = "Setup formatexpr specified filetype(s)."
--})

---- Update signature help on jump placeholder.
--vim.api.nvim_create_autocmd("User", {
--    group = "CocGroup",
--    pattern = "CocJumpPlaceholder",
--    command = "call CocActionAsync('showSignatureHelp')",
--    desc = "Update signature help on jump placeholder"
--})


---- Applying code actions to the selected code block.
---- Example: `<leader>aap` for current paragraph
--local opts = {silent = true, nowait = true}
--keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
--keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

---- Remap keys for apply code actions at the cursor position.
--keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
---- Remap keys for apply code actions affect whole buffer.
--keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
---- Apply the most preferred quickfix action to fix diagnostic on the current line.
--keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

---- Remap keys for apply refactor code actions.
--keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
--keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
--keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

---- Run the Code Lens action on the current line.
--keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)


---- Map function and class text objects
---- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
--keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
--keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
--keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
--keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
--keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
--keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
--keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
--keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)


---- Remap <C-f> and <C-b> for scroll float windows/popups.
-----@diagnostic disable-next-line: redefined-local
--local opts = {silent = true, nowait = true, expr = true}
--keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
--keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
--keyset("i", "<C-f>",
--       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
--keyset("i", "<C-b>",
--       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
--keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
--keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

