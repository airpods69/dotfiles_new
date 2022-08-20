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

" Jupyter Notebook
Plug 'luk400/vim-jukit'

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
    editing_text        = "Crying cause of %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Dying cause of %s",
    line_number_text    = "Line %s out of %s",
})
END

" " Jupyter Notebook
" let g:jukit_shell_cmd = 'ipython'
" "    - Specifies the command used to start a shell in the output split. Can also be an absolute path. Can also be any other shell command, e.g. `R`, `julia`, etc. (note that output saving is only possible for ipython)
" let g:jukit_terminal = 'kitty'
" "   - Terminal to use. Can be one of '', 'kitty', 'vimterm', 'nvimterm' or 'tmux'. If '' is given then will try to detect terminal
" let g:jukit_auto_output_hist = 0
" "   - If set to 1, will create an autocmd with event `CursorHold` to show saved ipython output of current cell in output-history split. Might slow down (n)vim significantly, you can use `set updatetime=<number of milliseconds>` to control the time to wait until CursorHold events are triggered, which might improve performance if set to a higher number (e.g. `set updatetime=1000`).
" let g:jukit_use_tcomment = 0
" "   - Whether to use tcomment plugin (https://github.com/tomtom/tcomment_vim) to comment out cell markers. If not, then cell markers will simply be prepended with `g:jukit_comment_mark`
" let g:jukit_comment_mark = '#'
" "   - See description of `g:jukit_use_tcomment` above
" let g:jukit_mappings = 1
" "   - If set to 0, none of the default function mappings (as specified further down) will be applied
"
" let g:jukit_highlight_markers = 1
" "   - If set to 1, will highlight cell markers with `g:jukit_highlight_markers_color`
" let g:jukit_enable_textcell_bg_hl = 1
" "   - If set to 1, will highlight text cells with `g:jukit_textcell_bg_hl_color`
" let g:jukit_enable_textcell_syntax = 1
"
" let g:jukit_text_syntax_file = $VIMRUNTIME . '/syntax/' . 'markdown.vim'
" let g:jukit_hl_ext_enabled = '*'


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
            {name = 'nvim_lsp'}},
            {{name = 'ultisnips'}
            }, {
            { name= 'buffer' },
            })
    })
EOF

" LSP
lua << EOF
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end

require("lspconfig").pyright.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    }
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
