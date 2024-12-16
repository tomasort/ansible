syntax on               " enable syntax highlighting
set cursorline          " highlight the current line
set ruler             " show line number in bar
set nobackup            " don't create pointless backup files; Use VCS instead
set autoread            " watch for file changes
set number              " show line numbers
set nu rnu              " show relative line numbers
set showcmd             " show selection metadata
set showmode            " show INSERT, VISUAL, etc. mode
set showmatch           " show matching brackets
set autoindent smartindent  " auto/smart indent
set smarttab            " better backspace and tab functionality
set scrolloff=8         " show at least 8 lines above/below
set mouse=a
set ruler
set laststatus=2
set ignorecase
set smartcase
set undofile
set hls ic

filetype on             " enable filetype detection
filetype indent on      " enable filetype-specific indenting
filetype plugin on      " enable filetype-specific plugins
" colorscheme cobalt      " requires cobalt.vim to be in ~/.vim/colors

" column-width visual indication
" let &colorcolumn=join(range(81,999),",")
" highlight ColorColumn ctermbg=235 guibg=#001D2F

" tabs and indenting
set autoindent          " auto indenting
set smartindent         " smart indenting
set expandtab           " spaces instead of tabs
set tabstop=4           " 2 spaces for tabs
set shiftwidth=4        " 2 spaces for indentation

" bells
set noerrorbells        " turn off audio bell
set visualbell          " but leave on a visual bell

" search
set hlsearch            " highlighted search results
set showmatch           " show matching bracket

" other
set guioptions=aAace    " don't show scrollbar in MacVim
" call pathogen#infect()  " use pathogen

" clipboard
set clipboard=unnamed   " allow yy, etc. to interact with OS X clipboard

" remapped keys
inoremap {      {}<Left>
inoremap {<CR>  {<CR>}<Esc>O
inoremap {{     {
inoremap {}     {}

nnoremap <leader>x :!chmod +x %<CR>
nnoremap <silent> <C-f> :silent !tmux neww tmux-sessionizer<CR>

let mapleader = " "
nnoremap <leader>pv :Vex<CR>
nnoremap <leader><CR> :so ~/.config/nvim/init.vim<CR>
" Redraw screen and remove search highlighting
nnoremap <leader>l :nohl<CR><C-L>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>tf :Telescope find_files<CR>
nnoremap <leader>u :UndotreeToggle<CR>

" Super Awsome remaps
vnoremap <leader>p "_dP
vnoremap <leader>y "+y
nnoremap <leader>y "+y
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" PLUGINS
" -----------------------------------
call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'ayu-theme/ayu-vim'
Plug 'tpope/vim-fugitive'
Plug 'williamboman/mason.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'theprimeagen/harpoon', { 'branch': 'harpoon2' }
Plug 'mbbill/undotree'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v4.x'}
Plug 'dense-analysis/ale'
Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
if has('nvim')
  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction

  Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
else
  Plug 'gelguy/wilder.nvim'

  " To use Python remote plugin features in Vim, can be skipped
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
" Plug 'Yggdroot/indentLine'

call plug#end()

" Key bindings can be changed, see below
call wilder#setup({'modes': [':', '/', '?']})
call wilder#set_option('renderer', wilder#popupmenu_renderer({ 'pumblend': 20, }))
" ------------------------------------
"
" Ayu colors
set termguicolors     " enable true colors support
let ayucolor="dark"   " for dark version of theme
colorscheme ayu
" I didn't like the color of the line numbers
exe "hi! LineNr guifg=#4d5c6d guibg=NONE gui=NONE" 
exe "hi! NonText guifg=#4d5c6d guibg=NONE gui=NONE" 
exe "hi! SpecialKey guifg=#4d5c6d guibg=NONE gui=NONE" 

let b:ale_fixers = ['prettier', 'eslint', 'djlint', 'markdownlint', 'ansible-lint']

lua << EOF
-- Initialize treesitter using lua within init.vim
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "cmake", "diff", "dot", "gitignore", "html", "http", "java", "javascript", "json", "json5", "regex", "sql", "ssh_config", "tmux", "terraform", "typescript", "xml", "yaml", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "dockerfile", "awk", "bash",  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = false,

  highlight = {
    enable = true,

    -- Disable syntax highlighting for certain file types if needed
    additional_vim_regex_highlighting = false,
  },
}

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
-- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-k>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<C-l>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)


-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

-- LSP setup
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
ensure_installed = {'ts_ls', 'rust_analyzer', 'dockerls', 'docker_compose_language_service', 'arduino_language_server', 'ansiblels', 'bashls', 'cmake', 'cssls', 'gopls', 'html', 'java_language_server', 'jsonls', 'marksman', 'texlab', 'pyright'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},  
    {name = 'luasnip'},  
  }, {
    {name = 'buffer'},
  }),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- This function attempts to set the correct filetype for Docker Compose YAML files
function docker_fix()
    -- Get the current file's name without extension
    local filename = vim.fn.expand("%:t:r")

    -- List of common Docker Compose file name patterns
    local docker_file_names = { "^docker%-compose", "^compose" }

    -- Iterate through the list of Docker Compose file name patterns
    for _, pattern in ipairs(docker_file_names) do
        -- Check if the current file's name matches any of the patterns
        if filename:match(pattern) then
            -- If it does, set the filetype to "yaml.docker-compose"
            vim.bo.filetype = "yaml.docker-compose"
            return
        end
    end
    -- If no Docker Compose file name pattern is matched, the function exits without changing the filetype
end

-- This function attempts to set the correct filetype for Ansible YAML files
function ansible_fix()
    -- Get the current file's full path
    local filepath = vim.fn.expand("%:p")

    -- List of directories commonly used in Ansible projects
    local ansible_dirs = { "/playbook/", "/tasks/", "/roles/" }

    -- Iterate through the list of Ansible directories
    for _, dir in ipairs(ansible_dirs) do
        -- Check if the current file's path contains any of the Ansible directories
        if filepath:match(dir) then
            -- If it does, set the filetype to "yaml.ansible"
            vim.bo.filetype = "yaml.ansible"
            return
        end
    end
    -- If no Ansible directory is found, the function exits without changing the filetype
end


function yaml_filetype_detector()
    -- Get the file extension
    local file_ext = vim.fn.expand("%:e")
    
    -- Only proceed if the file is a YAML file
    if file_ext ~= "yaml" and file_ext ~= "yml" then
        return
    end

    docker_fix()
    ansible_fix()
    
end

-- Create an autocommand to run the yaml_filetype_detector function every time a file is read
vim.cmd([[au BufRead * lua yaml_filetype_detector()]])


require('mason-tool-installer').setup {

  -- a list of all tools you want to ensure are installed upon
  -- start
  ensure_installed = {
    'ansible-lint',
    'curlylint',
    'djlint',
    'jsonlint',
    'misspell',
    'eslint_d',
    'pydocstyle',
  }
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp", { clear = true }),
  callback = function(args)
    -- 2
    vim.api.nvim_create_autocmd("BufWritePre", {
      -- 3
      buffer = args.buf,
      callback = function()
        -- 4 + 5
        vim.lsp.buf.format {async = false, id = args.data.client_id }
      end,
    })
  end
})

EOF
