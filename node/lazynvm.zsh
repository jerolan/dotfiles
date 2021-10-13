# # Add every binary that requires nvm, npm or node to run to an array of node globals
# NODE_GLOBALS=($(find ~/.nvm/versions/node -maxdepth 3 -type l -wholename '*/bin/*' | xargs -n1 basename | sort | uniq))
# NODE_GLOBALS+=("node")
# NODE_GLOBALS+=("nvm")
# NODE_GLOBALS+=("npx")

# # Lazy-loading nvm + npm on node globals call
# load_nvm() {
#   export NVM_DIR=~/.nvm
#   [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
#   if [ -f "$NVM_DIR/bash_completion" ]; then
#     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
#   fi
# }

# # Making node global trigger the lazy loading
# for cmd in "${NODE_GLOBALS[@]}"; do
#   eval "${cmd}(){ unset -f ${cmd} >/dev/null 2>&1; load_nvm; ${cmd} \$@; }"
# done
