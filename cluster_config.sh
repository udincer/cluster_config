## setting up from scratch on the cluster

# install conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# mamba makes conda faster
conda install -c conda-forge mamba

#conda install -y -c conda-forge tmux
# this seems to be a cleaner install
conda install tmux libevent -c conda-forge --no-deps

mamba install -c conda-forge -c defaults -c bioconda numpy scipy pandas scikit-learn seaborn tqdm jupyter statsmodels yapf cython joblib nb_conda parallel nbdime widgetsnbextension jupyterlab bedops snakemake pybedtools bedtools htslib pytables
# Might also include this if it's not already installed: jupyter_contrib_nbextensions

pip install loguru

# IDE tools for Jupyter
pip install jupyter-lsp
jupyter labextension install @krassowski/jupyterlab-lsp 
pip install python-language-server

# black code formatter
jupyter labextension install @ryantam626/jupyterlab_code_formatter
pip install jupyterlab_code_formatter
jupyter serverextension enable --py jupyterlab_code_formatter
mamba install black

jupyter labextension install jupyterlab-execute-time
# notebook settings {"recordTiming": true}

pip install jupyterlab-quickopen
jupyter labextension install @parente/jupyterlab-quickopen

# set up jupyter
jupyter notebook --generate-config
jupyter notebook password

# this might be needed for tqdm_notebook
jupyter nbextension install --user --py widgetsnbextension

FAV_NUMBER=24599

mkdir ~/utils
cat <<EOT >> ~/utils/start_jupyter.sh
echo \$(hostname) > ~/.jupyter_hostname.txt; 
jupyter notebook --no-browser --port $FAV_NUMBER
EOT

echo "alias jn='. ~/utils/start_jupyter.sh'" >> ~/.bashrc
echo "alias t='tmux attach'" >> ~/.bashrc

echo "alias ..='cd ..'" >> ~/.bashrc
echo "alias ...='cd ...'" >> ~/.bashrc
echo "alias ....='cd ....'" >> ~/.bashrc

# optional, install ucsc utils
# not using this link might results in link errors to zlib
# rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64.v369/ ~/ucsc_utils/

# install rust (interactive)
curl https://sh.rustup.rs -sSf | sh

# if installing on Windows Subsystem for Linux (WSL)
# sudo apt-get update
# sudo apt-get install build-essential

cargo install exa
echo "alias l='exa -lhF --git'" >> ~/.bashrc

cargo install fd-find
cargo install ripgrep

# install julia and ijulia (might want to change version)
wget https://julialang-s3.julialang.org/bin/linux/x64/1.4/julia-1.4.1-linux-x86_64.tar.gz -P tmp/
tar xzvf tmp/julia-1.4.1-linux-x86_64.tar.gz -C work/
ln -s ~/work/julia-1.4.1-linux-x86_64/bin/julia  ~/bin/julia # symbolic link to ~/bin
julia -e 'using Pkg; Pkg.add("IJulia")' # if doesn't work just run it in julia prompt

# optional:
# how to disable ctrl F behavior for codemirror regex search
# comment out
# "codemirror/addon/search/searchcursor",
# "codemirror/addon/search/search",
# In [env]/share/jupyter/nbextensions/select_keymap/main.js
