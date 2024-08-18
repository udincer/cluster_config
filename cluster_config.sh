## setting up from scratch on the cluster

# install miniconda + mamba
# wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh
# bash Miniforge-Linux-x86_64.sh

# for installing to scratch
rip "/u/home/d/dincer/scratch/mambaforge"
bash Miniforge3-Linux-x86_64.sh -p "/u/home/d/dincer/miniforge"

# optional - if conda init is not run
# eval "$(/u/home/d/dincer/scratch/mambaforge/bin/conda shell.bash hook)" 

# tmux (might be better to install through linuxbrew)
# conda install tmux libevent -c conda-forge --no-deps

# micromamba stuff
"${SHELL}" <(curl -L micro.mamba.pm/install.sh)
micromamba create -n b1 -c conda-forge python=3.12 jupyterlab ipywidgets jupyterlab_code_formatter git rsync bat jupyterlab-lsp python-lsp-server nodejs black isort ruff python-lsp-ruff jupyterlab_execute_time
micromamba create -n tev01 -c conda-forge -c bioconda python=3.12 numpy scipy "pandas>2.1" polars scikit-learn umap-learn "seaborn>0.13" tqdm statsmodels yapf cython joblib parallel nbdime widgetsnbextension snakemake pybedtools bedtools htslib pytables eza bat python-graphviz murmurhash sqlalchemy cytoolz bokeh distributed samtools pysam pybigwig loguru black isort ipykernel ipywidgets


mamba install -n base -c conda-forge --yes python=3.10 nb_conda_kernels nbdime jupyterlab_execute_time ipywidgets jupyterlab_code_formatter git exa rsync bat jupyterlab-lsp python-lsp-server nodejs loguru black isort

# alternative to base
mamba create -n b1 -c conda-forge python=3.10 nb_conda_kernels nbdime ipywidgets jupyterlab_code_formatter git exa rsync bat jupyterlab-lsp python-lsp-server nodejs loguru black isort ruff python-lsp-ruff "jupyterlab_execute_time<3"
mamba create -n tev_old_pandas -c conda-forge -c defaults -c bioconda --strict-channel-priority python=3.10 numpy scipy "pandas<2" "seaborn>=0.12" scikit-learn umap-learn  tqdm statsmodels yapf cython joblib parallel nbdime widgetsnbextension bedops snakemake pybedtools bedtools htslib pytables ipywidgets exa bat dask dask-jobqueue python-graphviz fastparquet murmurhash sqlalchemy cytoolz bokeh distributed samtools pysam pybigwig loguru black isort

conda activate b1
pip install -e "/u/home/d/dincer/work/psub"

conda activate tev_old_pandas
pip install -e "/u/home/d/dincer/work/psub"
pip install -e "/u/home/d/dincer/toasted_almonds"


mamba clean --all


mamba create -n tev -c conda-forge -c defaults -c bioconda --strict-channel-priority python=3.10 numpy scipy pandas scikit-learn umap-learn seaborn tqdm statsmodels yapf cython joblib parallel nbdime widgetsnbextension bedops snakemake pybedtools bedtools htslib pytables ipywidgets exa bat dask dask-jobqueue python-graphviz fastparquet murmurhash sqlalchemy cytoolz bokeh distributed samtools pysam pybigwig loguru black isort statannotations
mamba clean --all

mamba activate tev

# my version of snakeviz profiling visualization tool, works with remote setup
pip install git+https://github.com/udincer/snakeviz.git

# my version of tuna profiling visualization tool, works with remote setup
pip install git+https://github.com/udincer/tuna.git

# for jupyterlab_execute_time:
# notebook settings {"recordTiming": true}

# set up jupyter
mamba deactivate

jupyter notebook --generate-config
jupyter notebook password

ipython profile create
# set default figure format for retina display (png2x)
echo "c.InlineBackend.figure_format = 'retina'" >> ~/.ipython/profile_default/ipython_kernel_config.py
# turn of jedi autocompleter which spits out bad suggestions
echo "c.Completer.use_jedi = False" >> ~/.ipython/profile_default/ipython_kernel_config.py

# pip install papermill
# pip install jupyterlab-code-snippets
# follow instructions here to enable papermill to work with nb_conda_kernels
# https://github.com/Anaconda-Platform/nb_conda_kernels#use-with-nbconvert-voila-papermill

# this might be needed for tqdm_notebook
# jupyter nbextension install --user --py widgetsnbextension

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

# adds capability to start a remote vscode session directly from terminal
cat << 'EOT' >> ~/.bashrc
# open file/folder in vscode
code() {
  if [ -z "$1" ]; then
    echo "code --remote ssh-remote+$HOSTNAME $(pwd)"
  else
    echo "code --remote ssh-remote+$HOSTNAME $(realpath $1)"
  fi
}
EOT

# optional, install ucsc utils
# not using this link might results in link errors to zlib
# rsync -aP rsync://hgdownload.soe.ucsc.edu/genome/admin/exe/linux.x86_64.v369/ ~/ucsc_utils/

# install rust (interactive)
curl https://sh.rustup.rs -sSf | sh

# if installing on Windows Subsystem for Linux (WSL)
# sudo apt-get update
# sudo apt-get install build-essential

cargo install exa
echo "alias l='exa -lhF'" >> ~/.bashrc

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

# linuxbrew
# export HOMEBREW_GIT_PATH=/u/home/d/dincer/work/miniconda3/bin/git
# export HOMEBREW_CURL_PATH=/u/home/d/dincer/work/miniconda3/bin/curl

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install zstd --ignore-dependencies
brew install gcc

# optional:
# how to disable ctrl F behavior for codemirror regex search
# comment out
# "codemirror/addon/search/searchcursor",
# "codemirror/addon/search/search",
# In [env]/share/jupyter/nbextensions/select_keymap/main.js
