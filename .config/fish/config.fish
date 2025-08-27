if status is-interactive
    # Commands to run in interactive sessions can go here
end

zoxide init fish | source

alias nvch="NVIM_APPNAME=nvim-nvchad nvim"
alias nvlz="NVIM_APPNAME=nvim-lazyvim nvim"

nvv() {
  local config=$(fd --max-depth 1 --glob "nvim-*" ~/.config | fzf --prompt="Open Neovim with > " --height=~50% --layout-reverse --exit-0)
}

# Aliases
alias zshrc="source ~/.zshrc"
alias bat="batcat"
alias ls="eza"
alias li="eza --icons"
alias tree="eza --tree"


# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish
