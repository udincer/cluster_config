## setting up from scratch on the cluster

# don't forget to qrsh for faster installation

# install conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh

conda install -y -c conda-forge tmux

conda install -y numpy scipy pandas scikit-learn seaborn tqdm jupyter statsmodels yapf cython joblib
conda install -y -c conda-forge jupyter_contrib_nbextensions

# set up jupyter
jupyter notebook --generate-config
jupyter notebook password

FAV_NUMBER=24599

mkdir ~/utils
cat <<EOT >> ~/utils/start_jupyter.sh
echo \$(hostname) > ~/.jupyter_hostname.txt; 
jupyter notebook --no-browser --port $FAV_NUMBER
EOT

echo "alias jn='. ~/utils/start_jupyter.sh'" >> ~/.bashrc
echo "alias t='tmux attach'" >> ~/.bashrc