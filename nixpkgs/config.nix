{
  packageOverrides = pkgs : with pkgs; rec {

		my-python-packages = python-packages: with python-packages; [
      requests
			# other python packages you want
		]; 
		python-with-my-packages = pypy.withPackages my-python-packages;

    my_vim = vim_configurable.customize {
      name = "vim";

      vimrcConfig.customRC = ''
        syntax on
        filetype on
        set expandtab
        set bs=2
        set tabstop=2
        set shiftwidth=2
        set autoindent
        set smartindent
        set smartcase
        set ignorecase
        set modeline
        set nocompatible
        set encoding=utf-8
        set hlsearch
        set incsearch
        set history=700
        set t_Co=256
        set background=dark
        set tabpagemax=1000
        set ruler
        set nojoinspaces
        set number
        set shiftround
        colorscheme sierra
        set nolbr
        set tw=0
        set pastetoggle=<C-p>
        let mapleader = ","
        " Disable highlight when <leader><cr> is pressed
        map <silent> <leader><cr> :noh<cr>
        " Smart way to move between windows
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l
        " I accidentally hit F1 all the time
        imap <F1> <Esc>
        " nice try, Ex mode
        map Q <Nop>
        " ==== custom macros ====
        " Delete a function call. example:  floor(int(var))
        "         press when your cursor is       ^        results in:
        "                                   floor(var)
        map <C-H> ebdw%x<C-O>x
        nnoremap gp `[v`]
        
        " Toggle paste mode on and off
        map <leader>v :setlocal paste!<cr>
        
        " run ctags in current directory
        filetype plugin on
        " Clear highlight
        nnoremap <C-L> :nohl<CR><C-L>
        map <C-F12> :!ctags -R -I --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
        " Tagbar shortcut
        nmap <F8> :TagbarToggle<CR>
        
        " File finder
        nmap <Leader>t :FZF<CR>
        nmap <Leader>h :Ag<CR>
        
        let g:syntastic_cpp_compiler = 'clang++'
        let g:syntastic_cpp_compiler_options = ' -std=c++11'
        let g:syntastic_c_include_dirs = [ 'src', 'build' ]
        let g:syntastic_cpp_include_dirs = [ 'src', 'build' ]
        let g:ycm_autoclose_preview_window_after_completion = 1
        let g:zig_fmt_autosave = 1

      '';

      vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
      vimrcConfig.vam.pluginDictionaries = [
        { names = [
          "vim-addon-nix"
          "Syntastic"
          "Tagbar"
          "fzfWrapper"
          "fzf-vim"
          "vim-colorschemes"
          "awesome-vim-colorschemes"
        ]; }
      ];
    };
    all = pkgs.buildEnv {
      name = "all";
      paths = [
        asciinema
        ag
        ctags
        my_vim
        wolfebin
        #youtube-dl
        signal-desktop
        wineWowPackages.base
      ];
    };
  };
}
