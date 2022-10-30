# Shared autostart commands (with or without output)
if [ -f ~/.shared_autostart ]; then
    . ~/.shared_autostart --all
fi

# Load shared aliases if existent.
if [ -f ~/.shared_aliases ]; then
    . ~/.shared_aliases
fi
