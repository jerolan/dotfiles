# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-autosuggestions

# Tell Antigen that you're done.
antigen apply

# remove OMZ hooks and any custom title hooks
typeset -ga precmd_functions preexec_functions
precmd_functions=(${precmd_functions:#omz_termsupport_precmd} ${precmd_functions:#title})
preexec_functions=(${preexec_functions:#omz_termsupport_preexec} ${preexec_functions:#title})
function title() { :; }  # no-op

# rebind autosuggestions only once
(( $+functions[_zsh_autosuggest_bind_widgets] )) && _zsh_autosuggest_bind_widgets
