-- Set Space as your leader key (do this before mapping shortcuts)
vim.g.mapleader = " "

-- Base GitHub URL to trick the chat interface and give Pack what it needs
local github = "https://github.com"

-- ==========================================================================
-- 1. PLUGIN INSTALLATION (Using Built-in Pack Manager)
-- ==========================================================================
vim.pack.add({
  -- Tree-sitter Syntax Engine
  github .. '/nvim-treesitter/nvim-treesitter',

  -- Neo-tree Sidebar File Explorer & Dependencies
  github .. '/nvim-neo-tree/neo-tree.nvim',
  github .. '/nvim-tree/nvim-web-devicons', 
  github .. '/nvim-lua/plenary.nvim',        
  github .. '/MunifTanjim/nui.nvim',         
})

-- ==========================================================================
-- 2. PLUGIN CONFIGURATION
-- ==========================================================================

-- Configure Tree-sitter syntax highlighting (Safely wrapped)
local ts_status, treesitter = pcall(require, 'nvim-treesitter.configs')
if ts_status then
  treesitter.setup({
    ensure_installed = {  "lua", "vim", "vimdoc", "query", "javascript", "python", "rust" },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true, additional_vim_regex_highlighting = false },
  })
end

-- Initialize Neo-tree sidebar plugin
local nt_status, neotree = pcall(require, 'neo-tree')
if nt_status then
  neotree.setup({
    window = {
      width = 30,
    }
  })
end

-- ==========================================================================
-- 3. HOTKEYS & KEYMAPS
-- ==========================================================================
-- Bind Space + e to toggle the file explorer sidebar open and closed!
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true, desc = 'Toggle Sidebar File Explorer' })

-- ==========================================================================
-- 4. GENERAL VIM OPTIONS
-- ==========================================================================
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers for fast navigation
vim.opt.expandtab = true       -- Convert tabs to spaces
vim.opt.shiftwidth = 4         -- Indent size
-- Easy window navigation
vim.keymap.set('n', '<C-w>', '<C-w>w', { desc = 'Move focus to the left window' })
vim.opt.clipboard = "unnamedplus"


