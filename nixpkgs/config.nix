{
  packageOverrides = pkgs : with pkgs; rec {

    allowUnfree = true;

    # VScode
    extensions = (with pkgs.vscode-extensions; [
      bbenoist.Nix
      haxe
    ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vim";
        publisher = "vscodevim";
        version = "1.18.8";
        sha256 = "0cvmnq932xsc8bi3jas764dq2irfvy14lwa0jak5ky9cjsp6h94g";
      }
      {
        name = "markdown-preview-enhanced";
        publisher = "shd101wyy";
        version = "0.5.16";
        sha256 = "0w5w2np8fkxpknq76yv8id305rxd8a1p84p9k0jwwwlrsyrz31q8";
      }
      {
        name = "markdown-all-in-one";
        publisher = "yzhang";
        version = "3.4.0";
        sha256 = "0ihfrsg2sc8d441a2lkc453zbw1jcpadmmkbkaf42x9b9cipd5qb";
      }
      {
        name = "vshaxe";
        publisher = "nadako";
        version = "2.21.4";
        sha256 = "1462fby2p0ar2gl167h9nfp3h91kx4lcqigy3b87wqrlli0dkdq7";
      }
      {
        name = "haxe-extension-pack";
        publisher = "vshaxe";
        version = "1.3.0";
        sha256 = "1h59qgxd1j7h9fbcb7dhym5j2gazfkmkvkywcgq6dk851a846wqq";
      }
      {
        name = "haxe-hl";
        publisher = "haxefoundation";
        version = "1.1.1";
        sha256 = "1x40rw3dpcr81imm95iibhz58ifqrfykvxqpqmvxh0scvnsxk7zl";
      }
      {
        name = "nix-env-selector";
        publisher = "arrterian";
        version = "0.1.2";
        sha256 = "1n5ilw1k29km9b0yzfd32m8gvwa2xhh6156d4dys6l8sbfpp2cv9";
      }
      {
        name = "vscode-firefox-debug";
        publisher = "firefox-devtools";
        version = "2.9.1";
        sha256 = "1xr1z96kd2lcamklc0x4sv0if8n78cr0ara5lmc7bh5afy0h085g";
      }
      {
        name = "debugger-for-chrome";
        publisher = "msjsdiag";
        version = "4.12.12";
        sha256 = "0nkzck3i4342dhswhpg4b3mn0yp23ipad228hwdf23z8b19p4b5g";
      }
    ];
		vscode-with-extensions = pkgs.vscode-with-extensions.override {
      vscodeExtensions = extensions;
    };

    # Python
		my-python-packages = python-packages: with python-packages; [
      requests
			# other python packages you want
		]; 
		python-with-my-packages = pypy.withPackages my-python-packages;

    # Vim
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
