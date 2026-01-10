fish_add_path $HOME/.go/bin
fish_add_path $HOME/cbin/nvim/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/zig-linux-x86_64-0.13.0
fish_add_path $HOME/go/bin
fish_add_path $HOME/.turso

set -gx PNPM_HOME $HOME/.local/share/pnpm
fish_add_path $PNPM_HOME

set -gx SDPATH /storage/AAEE-1306
set -gx EDITOR nvim
set -gx DEBUG 'grammy*'
set -gx STARSHIP_LOG error
set -gx ATUIN_NOBIND true
set -gx TERMINFO ~/.terminfo
set -gx NODE_OPTIONS "--max-old-space-size=2200"

set -U fish_greeting

if status is-interactive
    starship init fish | source
    fzf --fish | source
    atuin init fish | source
    zoxide init --cmd cd fish | source

    fish_vi_key_bindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert block
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_visual block

    fzf_configure_bindings --directory=\ct --variables=\e\cv

    function fish_user_key_bindings
        bind -M insert \cf accept-autosuggestion
        bind -M insert \cp history-search-backward
        bind -M insert \cn history-search-forward
        bind -M insert \cr _atuin_search
    end

    function nvv
        set config (fd --max-depth 1 --glob 'nvim-*' $HOME/.config | fzf --prompt="Neovim Configs > " --height=50% --layout=reverse --border --exit-0)
        if test -z "$config"
            echo "No config selected"
            return 1
        end
        set -gx NVIM_APPNAME (basename $config)
        nvim $argv
    end

    function mkcd
        mkdir -p $argv[1]; and cd $argv[1]
    end

    function extract
        if test -f $argv[1]
            switch $argv[1]
                case '*.tar.gz'
                    tar xzf $argv[1]
                case '*.rar'
                    unrar x $argv[1]
                case '*.gz'
                    gunzip $argv[1]
                case '*.tar'
                    tar xf $argv[1]
                case '*.tgz'
                    tar xzf $argv[1]
                case '*.zip'
                    unzip $argv[1]
                case '*'
                    echo "'$argv[1]' cannot be extracted"
            end
        else
            echo "'$argv[1]' is not a valid file"
        end
    end

    function rmfzf
        set files (fd --max-depth 1 . --type file | fzf -m --preview "bat --style=numbers --color=always --line-range :500 {}")
        if set -q files[1]
            echo "Deleting: $files"
            read -P "Confirm? (Y/n): " confirm
            if string match -qi n $confirm
                echo "Skipped deleting: $files"
                return
            else
                rm $files
                echo "Deleted: $files"
            end
        end
    end

    function adbpush
        adb push $argv[1] $argv[2] $argv[3] $argv[4] $argv[5] $argv[6] $SDPATH
    end

    function apt-install
        set -l package (apt-cache search . | fzf --preview 'apt-cache show {1}' --layout=reverse --height=50% | awk '{print $1}')
        if test -z "$package"
            echo "No package selected"
            return 1
        end
        sudo apt install $package
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
    alias fishrc='source ~/.config/fish/config.fish'
    # alias bat=batcat
    alias ls='eza --icons'
    alias tree='eza --tree'
    alias rmrf='rm -rf'
    alias v='NVIM_APPNAME=nvim-lazyvim nvim'
    alias nvki='NVIM_APPNAME=nvim-kickstart nvim'
    alias nvch='NVIM_APPNAME=nvim-nvchad nvim'
    alias nv2='NVIM_APPNAME=nvim2 nvim'
    alias vim='NVIM_APPNAME=nvim-plain nvim'
    alias adbsh='adb shell'
    alias apt-search="apt-cache search . | fzf --preview 'apt-cache show {1}' --layout=reverse --height=50% | awk '{print $1}'"
end

set -gx FZF_DEFAULT_OPTS \
    '--height 40% --layout reverse' \
    '--color=fg:#B4BEFE,header:#F38BA8,info:#EBA0AC,pointer:#F5E0DC' \
    '--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8' \
    '--color=selected-bg:#45475A' \
    '--color=border:#6C7086,label:#CDD6F4'

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
