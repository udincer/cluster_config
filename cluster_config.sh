## setting up from scratch on the cluster

# install conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

conda install -y -c conda-forge tmux

conda install -y numpy scipy pandas scikit-learn seaborn tqdm jupyter statsmodels yapf cython joblib 
conda install -y -c conda-forge jupyter_contrib_nbextensions parallel nbdime widgetsnbextension

conda install -y -c bioconda bedops

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
