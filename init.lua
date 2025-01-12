-- ~/.config/nvim/init.lua

-----------------------------------------------------
-- 0) netrw を無効化 (nvim-tree の推奨設定)
-----------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-----------------------------------------------------
-- 1) packer.nvim のブートストラップ & プラグイン一覧
-----------------------------------------------------
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print("Cloning packer...")
    fn.system({
      'git', 'clone', '--depth', '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- packer.nvim が存在する場合に読み込む
vim.cmd([[packadd packer.nvim]])

require('packer').startup(function(use)
  -- packer.nvim 自体を管理
  use 'wbthomason/packer.nvim'

  ---------------------------------------------------------
  -- Vimscript プラグイン
  ---------------------------------------------------------
  use 'tpope/vim-commentary'
  -- use 'mattn/emmet-vim'

  ---------------------------------------------------------
  -- LSP・補完系
  ---------------------------------------------------------
  use 'neovim/nvim-lspconfig'   -- Neovim 公式の LSP 設定プラグイン
  use 'hrsh7th/nvim-cmp'        -- 補完プラグイン
  use 'hrsh7th/cmp-nvim-lsp'    -- nvim-cmp で LSP ソースを使うため
  use 'L3MON4D3/LuaSnip'        -- (オプション) snippet エンジン
  use 'saadparwaiz1/cmp_luasnip'-- (オプション) snippet 補完連携


  ---------------------------------------------------------
  -- UI 系 (vim-airline)
  ---------------------------------------------------------
  use 'vim-airline/vim-airline'

  ---------------------------------------------------------
  -- nvim-tree
  ---------------------------------------------------------
  use {
    'nvim-tree/nvim-tree.lua',
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-tree').setup({
        update_focused_file = {
          enable = true,
          update_cwd = true,
        }
      })
    end
  }
  vim.api.nvim_create_user_command("T", "NvimTreeToggle", {})

  ---------------------------------------------------------
  -- nvim-treesitter + autotag
  ---------------------------------------------------------
  use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = function()

    -- 標準の syntax を切る
    vim.cmd([[syntax off]]) 

    require('nvim-treesitter.configs').setup({
      ensure_installed = { "vue", "javascript", "typescript", "html", "css" },
      highlight = {
        enable = true,
        -- 一部の言語だけ従来のvimハイライトも併用したい場合は true にする
        -- 何も無ければ false 推奨
        additional_vim_regex_highlighting = false,
      },
    })
  end
  }


  use {
    'windwp/nvim-ts-autotag',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function()
      -- 新しい書き方: 直接セットアップを呼び出す
      require('nvim-ts-autotag').setup()
    end
  }
  ---------------------------------------------------------
  -- packer の初回起動時だけ :PackerSync を自動実行
  ---------------------------------------------------------
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-----------------------------------------------------
-- 2) 各種オプション 
-----------------------------------------------------
vim.opt.number = true
vim.opt.autoread = true
vim.opt.clipboard = "unnamed"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.whichwrap = "h,l,b,s,<,>,[,]"
vim.opt.textwidth = 0
vim.opt.termguicolors = true
vim.opt.wrap = false  -- 相当する :set nowrap

-----------------------------------------------------
-- 3) カラースキーム & シンタックス
-----------------------------------------------------
vim.cmd([[colorscheme industry]])

-----------------------------------------------------
-- 4) キーマップ (nnoremap, inoremapなどを Lua で書く)
-----------------------------------------------------
vim.keymap.set('n', '<CR><CR>', '<C-w><C-w>')
vim.keymap.set('n', '<M-v>', '<C-v>')
vim.keymap.set('n', '<C-h>', '10zh')
vim.keymap.set('n', '<C-l>', '10zl')
vim.keymap.set('n', '<C-j>', '4<C-e>')
vim.keymap.set('n', '<C-k>', '4<C-y>')
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

vim.keymap.set('i', '(', '()<Left>')
vim.keymap.set('i', '[', '[]<Left>')
vim.keymap.set('i', '{', '{}<Left>')

-----------------------------------------------------
-- 5) Coc.nvim の特有設定 (未使用ならスキップでOK)
-----------------------------------------------------

-----------------------------------------------------
-- 6) ハイライト関連
-----------------------------------------------------
vim.cmd([[highlight trailingWhitespace ctermbg=red guibg=red]])
vim.cmd([[
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>
]])

-----------------------------------------------------
-- 7) Ultisnips 設定 (今は使ってないならスキップ)
-----------------------------------------------------
--[[ 
-- ...
--]]

-----------------------------------------------------
-- 8) LSP & 補完 (nvim-lspconfig / nvim-cmp) の設定
-----------------------------------------------------
local lspconfig = require('lspconfig')
local cmp       = require('cmp')
local luasnip   = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<CR>']    = cmp.mapping.confirm({ select = true }),
    ['<Tab>']   = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    -- { name = 'buffer' },
  },
})

-- capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()


-- もし共通の on_attach を使うなら
local on_attach = function(client, bufnr)
  local opts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K',  vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
end

-- TailwindCSS LSP
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Volar: Hybrid Mode (template/style)
  lspconfig.volar.setup({
    -- パスを指定※プロジェクトの都度確認
    cmd = { "./node_modules/.bin/vue-language-server", "--stdio" },
    filetypes = { "typescript", "javascript", "vue" },
    init_options = {
      vue = {
        -- "No Hybrid Mode"
        hybridMode = false,
      },
    },
    capabilities = capabilities, 
    on_attach = on_attach, 
  })


-----------------------------------------------------
-- 9) vim-airline (タブラインの設定)
-----------------------------------------------------
vim.opt.hidden = true
vim.cmd([[
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  set showtabline=2
]])

-----------------------------------------------------
-- 以上で init.lua の記述は完了
-----------------------------------------------------
