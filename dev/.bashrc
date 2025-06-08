############################ Alias #####################################
alias dockerexec="docker exec --detach-keys=\"ctrl-x\" -it"
alias apc="git add . && pre-commit"
alias eswitch="conda deactivate && conda activate"
alias cdatv="conda deactivate"
alias catv="conda activate"
alias n="nvim"
############################ Alias #####################################

############################ Path ##################################
graphviz_path="$HOME/.local/graphviz"
cuda_home="$HOME/.local/cuda/"
nccl_home="$HOME/.local/nccl/"

export PATH="${cuda_home}/bin:\
${nccl_home}/bin:\
$HOME/workspace/gitee/quingo-compiler/build/bin/:\
$HOME/.local/texlive/2024/bin/x86_64-linux:\
$HOME/.local/bin/chrome-linux:\
${graphviz_path}/bin:\
$PATH"

export LD_LIBRARY_PATH="${cuda_home}/lib64:\
${nccl_home}/lib/x86_64-linux-gnu/:\
${graphviz_path}/lib:\
${LD_LIBRARY_PATH}"

export MANPATH=$HOME/.local/texlive//2024/texmf-dist/doc/man:${MANPATH}
export INFOPATH=$HOME/.local/texlive//2024/texmf-dist/doc/info:${INFOPATH}
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
############################ Path ##################################
