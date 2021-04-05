## setting up from scratch on the cluster

# install miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

# mamba makes conda faster
conda install -c conda-forge mamba

# tmux
conda install tmux libevent -c conda-forge --no-deps

# make seperate conda environments for base, jupyter, and kernel
mamba create -n jupyter_base -c conda-forge python=3.8 jupyterlab jupyter-lsp nb_conda_kernels nbdime jupyterlab_execute_time jupytext

# jupytext is dangerous! it could corrupt notebooks. be very careful with autosaves. 
# jupytext rules for pycharm integration (with auto-deployment setting): 
# 1- do not talk about jupytext
# 2- DO NOT talk about jupytext
# 3- do not open ipynb files in pycharm, it could autosave and overwrite the py
# 4- do not open _py files in jupyter, for the same reason
# 5- you must "reload notebook from disk" for _py -> ipynb
# 6- watch out for pycharm deployment "file updated" warnings after editing ipynb
# 7- set .jupytext.toml to default_jupytext_formats = "ipynb,_/py:percent"
# 8- magics should be commented out for pycharm to not freak out
# 9- only git-push on the server side, and only pull on pycharm side

mamba create -n tev -c conda-forge -c defaults -c bioconda python=3.8 numpy scipy pandas scikit-learn seaborn tqdm statsmodels yapf cython joblib parallel nbdime widgetsnbextension bedops snakemake pybedtools bedtools htslib pytables
conda activate tev
pip install loguru black jupyterlab_code_formatter

# my version of snakeviz profiling visualization tool, works with remote setup
pip install git+https://github.com/udincer/snakeviz.git

# for jupyterlab_execute_time:
# notebook settings {"recordTiming": true}

# set up jupyter
conda activate jupyter_base

jupyter notebook --generate-config
jupyter notebook password

# this is a more performant fork of pyls, future you might want to check the latest version
pip install git+https://github.com/krassowski/python-language-server.git@main

pip install papermill
pip install jupyterlab-code-snippets
# follow instructions here to enable papermill to work with nb_conda_kernels
# https://github.com/Anaconda-Platform/nb_conda_kernels#use-with-nbconvert-voila-papermill

# this might be needed for tqdm_notebook
jupyter nbextension install --user --py widgetsnbextension

FAV_NUMBER=24599

mkdir ~/utils
cat <<EOT >> ~/utils/start_jupyter.sh
echo \$(hostname) > ~/.jupyter_hostname.txt;
conda activate jupyter_base;
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
cargo install du-dust

# sed replacement
cargo install sd

# undoable rm
cargo install rm-improved
echo "alias rip='rip --graveyard /u/flashscratch/d/dincer/graveyard '" >> ~/.bashrc

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
