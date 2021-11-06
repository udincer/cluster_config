wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh

mamba create -n jupyter_base -c conda-forge python=3.8 jupyterlab jupyter-lsp nb_conda_kernels nbdime jupyterlab_execute_time jupytext ipywidgets
mamba create -n tev -c conda-forge -c defaults -c bioconda python=3.8 numpy scipy pandas scikit-learn seaborn tqdm statsmodels yapf cython joblib parallel nbdime widgetsnbextension bedops snakemake pybedtools bedtools htslib pytables ipywidgets
conda activate tev
pip install loguru black jupyterlab_code_formatter

conda config --set changeps1 false