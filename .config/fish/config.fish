fish_add_path $HOME/.go/bin
fish_add_path $HOME/cbin/nvim/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/zig-linux-x86_64-0.13.0
fish_add_path $HOME/go/bin

# Disable Greeting
set -U fish_greeting

# PNPM PATH
set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $PNPM_HOME

# Turso PATH
fish_add_path /home/xdagiz/.turso

set -gx SDPATH /storage/AAEE-1306

set -gx EDITOR nvim
set -gx DEBUG 'grammy*'

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    atuin init fish | source
    zoxide init fish | source

    function cd
        z $argv
    end

    function apt-search
        set package (apt-cache search . | fzf --preview 'apt-cache show {1}' --layout=reverse --height=50% | awk '{print $1}')
        if test -z "$package"
            echo "No package selected"
            return
        end
        sudo apt install $package
    end

    # FZF opts (interactive)
    set -gx FZF_DEFAULT_OPTS --height 40% --layout reverse --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 --color=selected-bg:#45475A --color=border:#6C7086,label:#CDD6F4
    fzf --fish | source

    # Vi key bindings
    fish_vi_key_bindings

    # Keybinds (Vi Insert mode)
    bind -M insert \cf accept-autosuggestion # Ctrl+F: Accept suggest
    bind -M insert \eb backward-word # Ctrl+Left: Backward word
    bind -M insert \ef forward-word # Ctrl+Right: Forward word
    bind -M insert \ep history-search-backward # Ctrl+P: History up
    bind -M insert \en history-search-forward # Ctrl+N: History down
    bind -M insert \cr _atuin_search

    # Functions (translated)
    function nvv
        set config (fd --max-depth 1 --glob 'nvim-*' $HOME/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)
        if test -z "$config"
            echo "No config selected"
            return
        end
        set -gx NVIM_APPNAME (basename $config)
        nvim $argv
    end

    function mkcd
        mkdir -p $argv[1]
        cd $argv[1]
    end

    function extract
        if test -f $argv[1]
            switch $argv[1]
                case '*.tar.bz2' tar xjf $argv[1]
                case '*.tar.gz' tar xzf $argv[1]
                case '*.bz2' bunzip2 $argv[1]
                case '*.rar' unrar x $argv[1]
                case '*.gz' gunzip $argv[1]
                case '*.tar' tar xf $argv[1]
                case '*.tbz2' tar xjf $argv[1]
                case '*.tgz' tar xzf $argv[1]
                case '*.zip' unzip $argv[1]
                case '*.7z' 7z x $argv[1]
                case '*'
                    echo "'$argv[1]' cannot be extracted"
            end
        else
            echo "'$argv[1]' is not a valid file"
        end
    end

    function adbpush
        adb.exe push $argv[1] $argv[2] $argv[3] $argv[4] $argv[5] $argv[6] $SDPATH
    end

    alias g='git'
    alias ga='git add'
    alias gc='git commit'
    alias gcm='git commit -m'
    alias gco='git checkout'
    alias gs='git status -sb'
    alias gss='git status'
    alias gd='git diff'
    alias gl='git log --oneline --graph --decorate'
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias clr=clear
    alias zshrc='source ~/.config/fish/config.fish' # Now for fishrc
    alias bat=batcat
    alias ls='eza --icons'
    alias tree='eza --tree'
    alias nvlz='NVIM_APPNAME=nvim-lazyvim nvim'
    alias nvki='NVIM_APPNAME=nvim-kickstart nvim'
    alias nvch='NVIM_APPNAME=nvim-nvchad nvim'
    alias nv2='NVIM_APPNAME=nvim2 nvim'
    alias vim='NVIM_APPNAME=nvim-plain nvim'
    alias adbsh=adb.exe
end
