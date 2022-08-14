set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set noswapfile
set nobackup
set backupdir=~/.vim/backup
set undofile
set incsearch
set scrolloff=8
set signcolumn=yes
set ignorecase
set splitbelow splitright
set clipboard=unnamedplus

" Call Install
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'andweeb/presence.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'wfxr/minimap.vim'
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'luochen1990/rainbow'

" Themes
Plug 'EdenEast/nightfox.nvim'
Plug 'ayu-theme/ayu-vim'

" Lua line plugins
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'
Plug 'windwp/nvim-autopairs'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'williamboman/nvim-lsp-installer'

" Line Indent
Plug 'Yggdroot/indentLine'

call plug#end()

let g:python3_host_prog = expand('~/.config/nvim/env/bin/python')

set termguicolors
" colorscheme nightfox

let ayucolor = "mirage"
colorscheme ayu

highlight Normal guibg=NONE ctermbg=NONE
highlight LineNr guibg=NONE ctermbg=NONE

""" Functions

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

augroup Trim
    autocmd!
    autocmd bufWritePre * :call TrimWhitespace()
augroup END


""" Plugins

" Rainbow
let g:rainbow_active = 1

" Discord Presence
lua << END
require("presence"):setup({
    -- General options
    auto_update         = true,
    neovim_image_text   = "Install Neovim Now",
    main_image          = "neovim",
    client_id           = "793271441293967371",
    enable_line_number  = true,
    blacklist           = {},
    buttons             = true,
    file_assets         = {},

    -- Rich Presence text options
    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Working on %s",
    line_number_text    = "Line %s out of %s",
})
END

" NERDTree
lua << END
require("nvim-tree").setup()
END

" Commenter
lua << EOF
require("nvim-autopairs").setup {}
EOF

" LuaLine
lua << END
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme='ayu_dark'
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'location','fileformat', 'filetype'},
        lualine_y = {},
        lualine_z = {'time'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {'branch'},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    }
}
END

" Snippets
set completeopt=menu,menuone,noselect
lua << EOF

    local cmp = require'cmp'

    cmp.setup({
        snippet = {
            expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
            end
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered()
        },
         mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    --[[
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    --]]

  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = "  "
      vim_item.menu = ({
        luasnip = "",
        cmdline = "",
        buffer = "",
      })[entry.source.name]
      return vim_item
    end,
   },
   sources = cmp.config.sources ({
            {name = 'ultisnips'}
            }, {
            { name= 'buffer' },
            })
    })
EOF

" LSP
lua << EOF
require("lspconfig").pyright.setup {}
require("nvim-lsp-installer").setup {}
EOF

" bufferline
lua << EOF
require("bufferline").setup{}
EOF

" Indent
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Comment
lua << END
require('Comment').setup()
END

""" Mapping
let mapleader = " "

" nvim-tree
nnoremap <leader>n :NvimTreeToggle<CR>
nnoremap <leader>c :NvimTreeCollapse<CR>

nmap <silent> <leader><leader> :noh<CR>

" bnext-bprev
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
nnoremap <leader>x :bd<CR>

" Terminal
nmap <leader>h <C-w>s<C-w>j:terminal<CR>
nmap <leader>v <C-w>v<C-w>l:terminal<CR>
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
"tmap <C-d> <Esc>:q<CR>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert
