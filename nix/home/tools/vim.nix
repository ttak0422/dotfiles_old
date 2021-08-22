# TODO vim/default.nix
{ config, pkgs, lib, ... }:

let
  sources = import ./../../sources.nix;
  configPath = ".config/nvim";
  indentSpace = 2;
  wrap = txt: "'${txt}'";
  wrap3 = txt:
    wrap (wrap (wrap (''

      ${txt}
    '')));
  # WIP https://github.com/Shougo/dein.vim/blob/master/doc/dein.txt
  makePlugin = { repo, on_ft ? [ ], build ? null, marged ? null, depends' ? [ ]
    , hookAdd ? null, hookSource ? null, hookPostSource ? null
    , hookPostUpdate ? null, hookDoneUpdate ? null }: ''
      [[plugins]]
      repo = ${wrap repo}
      ${lib.optionalString (on_ft != [ ])
      "on_ft = [${lib.strings.concatMapStringsSep ", " wrap on_ft}]"}
      ${lib.optionalString (build != null) "build = ${wrap3 build}"}
      ${lib.optionalString (marged != null) "marged = ${toString marged}"}
      ${lib.optionalString (hookAdd != null) "hook_add = ${wrap3 hookAdd}"}
      ${lib.optionalString (hookSource != null)
      "hook_source = ${wrap3 hookSource}"}
      ${lib.optionalString (hookPostSource != null)
      "hook_post_source = ${wrap3 hookPostSource}"}
      ${lib.optionalString (hookPostUpdate != null)
      "hook_post_update = ${wrap3 hookPostUpdate}"}
      ${lib.optionalString (hookDoneUpdate != null)
      "hook_done_update = ${wrap3 hookDoneUpdate}"}
    '';
  plugins = with pkgs;
    [
      # vimPlugins.ayu-vim
    ];
  deinPluginsList = [
    { repo = "ryanoasis/vim-devicons"; }
    { repo = "mengelbrecht/lightline-bufferline"; }
    {
      repo = "itchyny/lightline.vim";
      hookAdd = ''
        let g:lightline = {
          \ 'colorscheme': 'one',
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
          \ },
          \ 'tabline': { 'left': [ ['buffers'] ],
          \   'right': [ ['close'] ]
          \ },
          \ 'component_expand': {
          \   'buffers': 'lightline#bufferline#buffers'
          \ },
          \ 'component_type': {
          \   'buffers': 'tabsel'
          \ },
          \ 'component_function': {
          \   'filename': 'LightlineFilename'
          \ }
          \ }
        let g:lightline.separator = { 'left': "\ue0b0", 'right': "\ue0b2" }
        let g:lightline.subseparator = { 'left': "\ue0b1", 'right': "\ue0b3" }
        function! LightlineFilename()
          return expand('%')
        endfunction
      '';
    }
    {
      repo = "iamcco/markdown-preview.nvim";
      on_ft = [ "markdown" "pandoc.markdown" "rmd" ];
      build = ''sh -c "cd app && yarn install"'';
    }
    {
      repo = "junegunn/fzf";
      build = "./install --all";
    }
    {
      repo = "junegunn/fzf.vim";
      marged = 0;
      hookAdd = ''
        nnoremap <C-p> :Files<CR>
        nnoremap <C-h> :History<CR>
        nnoremap <C-f> :Rg<CR>
        " https://github.com/junegunn/fzf.vim/issues/346#issuecomment-288483704
        command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
      '';
    }
    { repo = "prabirshrestha/vim-lsp"; }
    { repo = "mattn/vim-lsp-settings"; }
    { repo = "simeji/winresizer"; }
    { repo = "mattn/emmet-vim"; }
    {
      repo = "LnL7/vim-nix";
      on_ft = [ "nix" ];
    }
    {
      repo = "vim-jp/vimdoc-ja";
      hookAdd = ''
        set helplang=ja
      '';
    }
    { repo = "markonm/traces.vim"; }
    { repo = "Xuyuanp/nerdtree-git-plugin"; }
    {
      repo = "ayu-theme/ayu-vim";
      hookAdd = "";
    }
    {
      repo = "rakr/vim-one";
    }
    # {
    #   repo = "tomasr/molokai";
    #   hookAdd = ''
    #     let g:molokai_original = 1
    #     let g:rehash256 = 1
    #     set background=dark
    #     colorscheme molokai
    #   '';
    # }
    # {
    #   repo = "rakr/vim-one";
    #   hookAdd = ''
    #     set background=dark
    #     colorscheme one
    #   '';
    # }
    # {
    #   repo = "cocopon/iceberg.vim";
    #   hookAdd = ''
    #     set background=dark
    #     colorscheme iceberg
    #   '';
    # }
    {
      repo = "mhinz/vim-startify";
      hookAdd = ''
                " https://mjhd.hatenablog.com/entry/recommendation-of-vim-startify
                function! s:filter_header(lines) abort
                  let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
                  let centered_lines = map(copy(a:lines), 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
                  return centered_lines
                endfunction  
                let g:startify_custom_header = s:filter_header([
        \ '                                          ▒▒▓  ░▒░',
        \ '                                        ▒▒▓▓▓  ░▒▒░░',                  
        \ '                                      ▒▒▓▓▓▓▓  ░▒▒▒▒░░',            
        \ '                                    ▒▒▓▓▓▓▓▓▓  ░▒▒▒▒▒▒░░',                 
        \ '                                  ▒▒▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒░░',           
        \ '                                ▒▒▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒░░',      
        \ '                              ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒░░',            
        \ '                            ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',                          
        \ '                          ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',                           
        \ '                         ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',       
        \ '                       ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',                  
        \ '                     ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒   ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',                      
        \ '                   ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒      ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                 ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒          ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '               ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',           
        \ '             ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒▓▓          ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '           ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒▓▓▓▓            ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '         ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒     ▒▓▓▓▓▓▓              ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '       ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒     ▒▓▓▓▓▓▓▓▓                ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '     ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒     ▒▓▓▓▓▓▓▓▓▓▓                  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '   ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒     ▒▓▓▓▓▓▓▓▓▓▓▓▓                    ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ ' ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒     ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓                      ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒     ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ ' ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓                      ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '   ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒▓▓▓▓▓▓▓▓▓▓▓▓                    ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '     ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒▓▓▓▓▓▓▓▓▓▓                  ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░ ',
        \ '       ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒▓▓▓▓▓▓▓▓                ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░ ',
        \ '         ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒▓▓▓▓▓▓              ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '           ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▒▓▓▓▓            ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '             ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ▒▓▓▓          ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '              ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒     ▒▒         ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒            ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                  ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                    ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                      ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                          ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                            ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░',
        \ '                              ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒▒▒░░',    
        \ '                                ▒▓▓▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒▒▒░░',
        \ '                                  ▒▓▓▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒▒▒░░',    
        \ '                                    ▒▓▓▓▓▓▓▓▓  ░▒▒▒▒▒▒░░',             
        \ '                                      ▒▓▓▓▓▓▓  ░▒▒▒▒░░',
        \ '                                        ▒▓▓▓▓  ░▒▒░░',              
        \ '                                          ▒▓▓  ░▒░',            
        \ ])
              '';
    }
    # { repo = "cohama/lexima.vim"; }
    { repo = "alvan/vim-closetag"; }
    { repo = "prabirshrestha/asyncomplete.vim"; }
    { repo = "prabirshrestha/asyncomplete-lsp.vim"; }
    { repo = "airblade/vim-gitgutter"; }
    {
      repo = "luochen1990/rainbow";
      hookAdd = ''
        let g:rainbow_active = 1
        let g:rainbow_conf = {
          \	'separately': {
          \		'nerdtree': 0,
          \	}
          \ }
      '';
    }
    { repo = "preservim/nerdtree"; }
    {
      repo = "hashivim/vim-terraform";
      on_ft = [ "tf" ];
    }
  ];
  deinLazyPluginsList = [

  ];
  deinPlugins = lib.strings.concatMapStringsSep "\n" makePlugin deinPluginsList;
  deinLazyPlugins =
    lib.strings.concatMapStringsSep "\n" makePlugin deinLazyPluginsList;
  deinDir = ".cache/dein";
  deinRepoDir = "${sources."dein.vim".outPath}";
  deinPluginsPath = "${configPath}/.dein.toml";
  deinLazyPluginsPath = "${configPath}/.dein_lazy.toml";
  deinConfigPath = "${configPath}/plugin.vim";
  deinConfig = ''
    let s:dein_dir = '${config.home.homeDirectory}/${deinDir}'
    let s:dein_repo_dir = '${deinRepoDir}'

    " Required
    set runtimepath^=${deinRepoDir}

    " if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml('${config.home.homeDirectory}/${deinPluginsPath}', {'lazy': 0})
    call dein#load_toml('${config.home.homeDirectory}/${deinLazyPluginsPath}', {'lazy': 1})
    call dein#end()
    " call dein#save_state()
    " endif

    " If you want to install not installed plugins on startup.
    if dein#check_install()
    call dein#install()
    endif

    let s:removed_plugins = dein#check_clean()
    if len(s:removed_plugins) > 0
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
    endif
  '';
in {
  nixpkgs.overlays = [
    (import
      (builtins.fetchTarball { url = sources.neovim-nightly-overlay.url; }))
  ];
  home = {
    packages = lib.lists.unique (lib.lists.flatten (builtins.map (x: x.depends')
      (builtins.filter (x: x ? depends')
        (deinPluginsList ++ deinLazyPluginsList)))) ++ [ ];
    file = {
      "${deinPluginsPath}".text = deinPlugins;
      "${deinLazyPluginsPath}".text = deinLazyPlugins;
      "${deinConfigPath}".text = deinConfig;
    };
  };
  programs = {
    vim = { enable = true; };
    neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      plugins = plugins;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraConfig = ''
        " プラグイン読み込み
        exec 'source' '${builtins.getEnv "HOME" + "/" + deinConfigPath}'

        " カラースキーム
        set termguicolors
        set background=dark
        colorscheme one

        set encoding=utf-8
        scriptencoding utf-8
        syntax enable
        filetype plugin indent on
        set cursorline
        set number
        set relativenumber
        set virtualedit=block
        set wildmenu
        set hidden
        \" https://qiita.com/lighttiger2505/items/166a4705f852e8d7cd0d
        augroup GrepCmd
        autocmd!
        autocmd QuickFixCmdPost vim,grep,make if len(getqflist()) != 0 | cwindow | endif
        augroup END  
        nnoremap <ESC><ESC> :nohl<CR>

        " , キーで次タブのバッファを表示
        nnoremap <silent> , :bprev<CR>
        " . キーで前タブのバッファを表示
        nnoremap <silent> . :bnext<CR>
        " C-q キーでバッファを閉じる
        nnoremap <silent> <C-q> :bd<CR>

        " replace grep
        let &grepprg = 'rg --vimgrep --hidden'
        set grepformat=%f:%l:%c:%m

        " temporary change cwd 
        autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
        autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)       

        " search
        set hlsearch
        set ignorecase
        set smartcase
        set incsearch

        " indent
        set tabstop=${toString indentSpace}
        set shiftwidth=${toString indentSpace}
        set expandtab
        set smartindent

        " tab 
        set showtabline=2
        " statusline
        set laststatus=2

        " mouse
        set mouse=a

        " auto mkedir (https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html)
        augroup vimrc-auto-mkdir " {{{
          autocmd!
          autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
          function! s:auto_mkdir(dir, force) " {{{
            if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
              call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
            endif
          endfunction " }}}
        augroup END " }}}
      '';
    };
  };
}
