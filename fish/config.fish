if status is-interactive
    set fish_greeting
    abbr --add c clear
    abbr --add battery "bash ~/battery.sh"
    abbr --add whereami pwd
    export NIXPKGS_ALLOW_UNFREE=1
    export EDITOR=vim
    function starship_transient_prompt_func
        starship module character
    end
    starship init fish | source
    enable_transience
end
