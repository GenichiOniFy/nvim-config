vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set clipboard=unnamedplus")
vim.diagnostic.config({
    virtual_text = true,  -- Включить отображение ошибок и предупреждений в виде текста
    signs = true,         -- Включить значки для ошибок и предупреждений
    underline = true,     -- Подчеркнуть ошибки и предупреждения
    update_in_insert = true, -- Обновлять диагностику в режиме вставки
})

