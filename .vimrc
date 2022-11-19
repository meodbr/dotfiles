
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
"
"
"
" if v:progname =~? "evim"
"   finish
" endif
" 
" " Get the defaults that most users want.
" source $VIMRUNTIME/defaults.vim
" 
" if has("vms")
"   set nobackup		" do not keep a backup file, use versions instead
" else
"   set backup		" keep a backup file (restore to previous version)
"   if has('persistent_undo')
"     set undofile	" keep an undo file (undo changes after closing)
"   endif
" endif
" 
" if &t_Co > 2 || has("gui_running")
"   " Switch on highlighting the last used search pattern.
"   set hlsearch
" endif
" 
" " Put these in an autocmd group, so that we can delete them easily.
" augroup vimrcEx
"   au!
" 
"   " For all text files set 'textwidth' to 78 characters.
"   autocmd FileType text setlocal textwidth=78
" augroup END
" 
" " Add optional packages.
" "
" " The matchit plugin makes the % command work better, but it is not backwards
" " compatible.
" " The ! means the package won't be loaded right away but when plugins are
" " loaded during initialization.
" if has('syntax') && has('eval')
"   packadd! matchit
" endif
" 
filetype on          " Détection du type de fichier 
" syntax on            " Coloration syntaxique
" set background=dark  " Adapte les couleurs pour un fond noir (idéeal dans PuTTY)
" set linebreak        " Coupe les lignes au dernier mot et pas au caractère (requier Wrap lines, actif par défaut)
" set visualbell       " Utilisation du clignotement à la place du "beep"
" set showmatch        " Surligne le mots recherchés dans le texte
" set hlsearch         " Surligne tous les résultats de la recherche
" set autoindent       " Auto-indentation des nouvelles lignes
" set shiftwidth=4     " (auto) Indentation de 4 espaces
" set smartindent      " Active "smart-indent" (améliore l'auto-indentation, notamment en collant du texte déjà indenté)
" set smarttab         " Active "smart-tabs" (améliore l'auto-indentation, Gestion des espaces en début de ligne pour l'auto-indentation)
" set softtabstop=4    " Tabulation = 4 espaces
" set mouse=a          " Active la souris, dans tous les modes (note il faudra alors d'appuyer sur "shift" pour faire les sélections de copier-coller dans l'éditeur)

" configure expanding of tabs for various file types
au BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.c set expandtab
au BufRead,BufNewFile *.h set expandtab
au BufRead,BufNewFile Makefile* set noexpandtab

" --------------------------------------------------------------------------------
" configure editor with tabs and nice stuff...
" --------------------------------------------------------------------------------
set expandtab           " enter spaces when tab is pressed
set textwidth=120       " break lines when line length increases
set tabstop=4           " use 4 spaces to represent tab
set softtabstop=4
set shiftwidth=4        " number of spaces to use for auto indent
set autoindent          " copy indent from current line when starting a new line

" make backspaces more powerfull
set backspace=indent,eol,start

set ruler                           " show line and column number
syntax on               " syntax highlighting
set showcmd             " show (partial) command in status line

" Ctrl-Flèches D/G
map ^[[D <C-Left>
map ^[[C <C-Right>
map! ^[[D <C-Left>
map! ^[[C <C-Right>

" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
