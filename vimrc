"Generated by vimrcGen(http://unoriginal.tk/vimrc), coded by shrsv 

 
"Behave like vim instead of vi 
set nocompatible
 
"Attempt to detect filetype/contents so that vim can autoindent etc 
filetype indent plugin on
 
"Enable syntax highlighting 
syntax on
 
"Enable switching from an  unsaved buffer without saving it first and keep an undo history for multiple files. Warn when quitting without saving, and keep swap files.
set hidden
 
"Better command-line completion 
set wildmenu
 
"Show partial commands in the last line of the screen
set showcmd
 
"Highlight searches (use Ctrl+L to temporarily turn off highlighting)
set hlsearch 
nnoremap <C-L> :nohl<CR><C-L>
 
"Use case insensitive search, except when using capital letters
set ignorecase 
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
"When opening a new line and no filetype-specific indenting is enabled, keep the same indent as the line you're currently on(Useful for READMEs, etc)
set autoindent
 
"Display the cursor position on the last line of the screen or in the status line of a window
set ruler
 
"Always display the status line, even if only one window is displayed
set laststatus=2
 
"Instead of failing a command because of unsaved changes, instead raise a  dialogue asking if you wish to save changed files 
set confirm
 
"Use visual bell instead of beeping when doing something wrong 
set visualbell
 
"Set the command window height to 2 lines, to avoid many cases of having to press <Enter> to continue  
set cmdheight=2
 
"Display line numbers on the left
set number
 
"Quickly time out on keycodes, but never time out on mappings 
set notimeout ttimeout ttimeoutlen=200
 
"Use F11 to toggle between paste and nopaste
set pastetoggle=<F11>
 
"Enable firefox/google chrome like tab navigation
nmap <C-S-tab> :tabprevious<CR> 
nmap <C-tab> :tabnext<CR> 
map <C-S-tab> :tabprevious<CR> 
map <C-tab> :tabnext<CR> 
imap <C-S-tab> <Esc>:tabprevious<CR>i 
imap <C-tab> <Esc>:tabnext<CR>i 
nmap <C-t> :tabnew<CR> 
imap <C-t> <Esc>:tabnew<CR>
 
"Highlight the current line
set cursorline
 
"Share windows clipboard
set clipboard+=unnamed
 
"Indentation hardtab express settings
set shiftwidth=4 
set softtabstop=4 
set expandtab
 

"setup minibufexplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

let Tlist_Ctags_Cmd="/usr/bin/etags"

autocmd FileType python set omnifunc=pythoncomplete#Complete

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
:syntax on

fun! EnsureVamIsOnDisk(vam_install_path)
  " windows users may want to use http://mawercer.de/~marc/vam/index.php
  " to fetch VAM, VAM-known-repositories and the listed plugins
  " without having to install curl, 7-zip and git tools first
  " -> BUG [4] (git-less installation)
  let is_installed_c = "isdirectory(a:vam_install_path.'/vim-addon-manager/autoload')"
  if eval(is_installed_c)
    return 1
  else
    if 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
      " I'm sorry having to add this reminder. Eventually it'll pay off.
      call confirm("Remind yourself that most plugins ship with ".
                  \"documentation (README*, doc/*.txt). It is your ".
                  \"first source of knowledge. If you can't find ".
                  \"the info you're looking for in reasonable ".
                  \"time ask maintainers to improve documentation")
      call mkdir(a:vam_install_path, 'p')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
      " VAM runs helptags automatically when you install or update 
      " plugins
      exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
    endif
    return eval(is_installed_c)
  endif
endf

fun! SetupVAM()
  " Set advanced options like this:
  " let g:vim_addon_manager = {}
  " let g:vim_addon_manager['key'] = value
  "     Pipe all output into a buffer which gets written to disk
  " let g:vim_addon_manager['log_to_buf'] =1

  " Example: drop git sources unless git is in PATH. Same plugins can
  " be installed from www.vim.org. Lookup MergeSources to get more control
  " let g:vim_addon_manager['drop_git_sources'] = !executable('git')
  " let g:vim_addon_manager.debug_activation = 1

  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  if !EnsureVamIsOnDisk(vam_install_path)
    echohl ErrorMsg
    echomsg "No VAM found!"
    echohl NONE
    return
  endif
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  call vam#ActivateAddons(['ack', 'The_NERD_tree','Tagbar', 'bufexplorer.zip','Conque_Shell','vim-coffee-script','Wombat','mayansmoke','SuperTab%182', 'Command-T', 'snipmate', 'vim-ipython', 'taglist'], {'auto_install' : 1})
  call vam#ActivateAddons(['Zenburn', 'Solarized'], {'auto_install':1})
  " sample: call vam#ActivateAddons(['pluginA','pluginB', ...], {'auto_install' : 0})

  " Addons are put into vam_install_path/plugin-name directory
  " unless those directories exist. Then they are activated.
  " Activating means adding addon dirs to rtp and do some additional
  " magic
  " How to find addon names?
  " - look up source from pool
  " - (<c-x><c-p> complete plugin names):
  " You can use name rewritings to point to sources:
  "    ..ActivateAddons(["github:foo", .. => github://foo/vim-addon-foo
  "    ..ActivateAddons(["github:user/repo", .. => github://user/repo
  " Also see section "2.2. names of addons and addon sources" in VAM's documentation
endfun
call SetupVAM()

let NERDTreeChDirMode = 2
let NERDTreeIgnore=['\~$','.*\.pyc$']
let NERDTreeQuitOnOpen=0
let g:CommandTMaxHeight=20
set noswapfile
set nobackup
set scrolloff=3
set ruler
set scrolljump=5
set wildignore+=*.pyc,*.pyo

" Set ctrl space to autocomplete
inoremap <C-Space> <C-p>

map <C-A> :NERDTreeToggle<cr>
map <C-D> :TagbarToggle<cr>

"Set the color theme to be used 
"colors Zenburn 
colorscheme zenburn 

