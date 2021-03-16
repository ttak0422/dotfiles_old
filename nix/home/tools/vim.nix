{ config, pkgs, lib, ... }:

let
  sources = import ./../../sources.nix;
  configPath = ".config/nvim";
  indentSpace = 2;
  fontSize = 14;
  wrap = txt: "'${txt}'";
  # WIP https://github.com/Shougo/dein.vim/blob/master/doc/dein.txt
  makePlugin = { repo, on_ft ? [ ], build ? null, marged ? null, depends ? [ ]
    , config' ? null }: ''
      [[plugins]]
      repo = ${wrap repo}
      ${lib.optionalString (on_ft != [ ])
      "on_ft = [${lib.strings.concatMapStringsSep ", " wrap on_ft}]"}
      ${lib.optionalString (build != null) "build = ${wrap build}"}
      ${lib.optionalString (marged != null) "marged = ${toString marged}"}
    '';
  deinPluginsList = [
    {
      repo = "itchyny/lightline.vim";
      config' = ''
        let g:lightline = {
        \ 'separator': { 'left': "\ue0bc ", 'right': "\ue0be" },
        \ 'subseparator': { 'left': "\ue0bd ", 'right': "\ue0bf" },
        \ }
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
      config' = ''
        set helplang=ja
      '';
    }
    { repo = "markonm/traces.vim"; }
    {
      repo = "preservim/nerdtree";
      config' = ''
        autocmd VimEnter * execute 'NERDTree'
      '';
    }
    { repo = "Xuyuanp/nerdtree-git-plugin"; }
    {
      repo = "tomasr/molokai";
      config' = ''
        let g:molokai_original = 1
        let g:rehash256 = 1
        set background=dark
        colorscheme molokai
      '';
    }
    { repo = "ryanoasis/vim-devicons"; }
    { repo = "mhinz/vim-startify"; }
    { repo = "cohama/lexima.vim"; }
    { repo = "prabirshrestha/asyncomplete.vim"; }
    { repo = "prabirshrestha/asyncomplete-lsp.vim"; }
  ];
  deinLazyPluginsList = [ ];
  deinPlugins = lib.strings.concatMapStringsSep "\n" makePlugin deinPluginsList;
  deinLazyPlugins =
    lib.strings.concatMapStringsSep "\n" makePlugin deinLazyPluginsList;
  deinDir = ".cache/dein";
  deinRepoDir = builtins.fetchTarball {
    name = "dein";
    url = sources."dein.vim".url;
  };
  deinPluginsPath = "${configPath}/.dein.toml";
  deinLazyPluginsPath = "${configPath}/.dein_lazy.toml";
  deinConfig = ''
    let s:dein_dir = '${config.home.homeDirectory}/${deinDir}'
    let s:dein_repo_dir = '${deinRepoDir}'
    set runtimepath+=${deinRepoDir}

    if !isdirectory(s:dein_dir)
      call mkdir(s:dein_dir, 'p')
    endif

    " if dein#load_state(s:dein_dir)
      call dein#begin(s:dein_dir)
      let s:toml = '${config.home.homeDirectory}/${deinPluginsPath}'
      let s:lazy_toml = '${config.home.homeDirectory}/${deinLazyPluginsPath}'
      call dein#load_toml(s:toml, {'lazy': 0})
      call dein#load_toml(s:lazy_toml, {'lazy': 1})
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
    packages = lib.lists.unique (lib.lists.flatten (builtins.map (x: x.depends)
      (builtins.filter (x: x ? depends)
        (deinPluginsList ++ deinLazyPluginsList))));
    file = {
      "${deinPluginsPath}".text = deinPlugins;
      "${deinLazyPluginsPath}".text = deinLazyPlugins;
    };
  };
  programs = {
    vim = { enable = true; };
    neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraConfig = deinConfig + ''
        set encoding=utf-8
        scriptencoding utf-8
        set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ ${
          toString fontSize
        }
        syntax enable
        filetype plugin indent on
        set cursorline
        set number
        set relativenumber
        autocmd TermOpen * setlocal nonumber norelativenumber
        set virtualedit=block
        set wildmenu
        nnoremap <ESC><ESC> :nohl<CR>
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
        set smartindent
        set clipboard+=${
          if pkgs.stdenv.isDarwin then "unnamed" else "unnamedplus"
        }
        " tab 
        set showtabline=2
        " statusline
        set laststatus=2
      '' + (lib.concatStringsSep "\n" (builtins.map (x: x.config')
        (builtins.filter (x: x ? config')
          (deinPluginsList ++ deinLazyPluginsList))));
    };
  };
}
