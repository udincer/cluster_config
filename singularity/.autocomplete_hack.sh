# find paths: jupyter --paths

# this should work as a one liner
rg -F "lsp-completer-max-label-width" --files-with-matches | xargs -I{} sed -i -E 's/(lsp-completer-max-label-width: )[0-9]+(px)/\11200\2/g' {}

# to get files: rg -F lsp-completer-max-label-width --files-with-matches

sed -i 's/lsp-completer-max-label-width:\ 300px/lsp-completer-max-label-width:\ 1200px/' share/jupyter/labextensions/@krassowski/jupyterlab-lsp/static/501.bc0329be89ee2a4fe618.js
sed -i 's/lsp-completer-max-label-width:\ 300px/lsp-completer-max-label-width:\ 1200px/' lib/python3.10/site-packages/jupyterlab_lsp/labextensions/@krassowski/jupyterlab-lsp/static/44.6ffa88e8d2d188863696.js
sed -i 's/lsp-completer-max-label-width:\ 300px/lsp-completer-max-label-width:\ 1200px/' lib/python3.10/site-packages/jupyterlab_lsp/labextensions/@krassowski/jupyterlab-lsp/static/501.bc0329be89ee2a4fe618.js
sed -i 's/lsp-completer-max-label-width:\ 300px/lsp-completer-max-label-width:\ 1200px/' pkgs/jupyterlab-lsp-3.10.1-pyhd8ed1ab_0/share/jupyter/labextensions/@krassowski/jupyterlab-lsp/static/501.bc0329be89ee2a4fe618.js
sed -i 's/lsp-completer-max-label-width:\ 300px/lsp-completer-max-label-width:\ 1200px/' pkgs/jupyterlab-lsp-3.10.1-pyhd8ed1ab_0/site-packages/jupyterlab_lsp/labextensions/@krassowski/jupyterlab-lsp/static/44.6ffa88e8d2d188863696.js
sed -i 's/lsp-completer-max-label-width:\ 300px/lsp-completer-max-label-width:\ 1200px/' pkgs/jupyterlab-lsp-3.10.1-pyhd8ed1ab_0/share/jupyter/labextensions/@krassowski/jupyterlab-lsp/static/44.6ffa88e8d2d188863696.js
sed -i 's/lsp-completer-max-label-width:\ 300px/lsp-completer-max-label-width:\ 1200px/' pkgs/jupyterlab-lsp-3.10.1-pyhd8ed1ab_0/site-packages/jupyterlab_lsp/labextensions/@krassowski/jupyterlab-lsp/static/501.bc0329be89ee2a4fe618.js
