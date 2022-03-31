ARG BASE_CONTAINER="condaforge/mambaforge"
FROM --platform=linux/amd64 $BASE_CONTAINER

LABEL maintainer="tev"

RUN mamba create -n jb2 -c conda-forge --yes python=3.10 nb_conda_kernels nbdime jupyterlab_execute_time ipywidgets
RUN mamba create -n tev -c conda-forge -c defaults -c bioconda --yes python=3.8 numpy scipy pandas scikit-learn seaborn tqdm statsmodels yapf cython joblib parallel nbdime widgetsnbextension bedops snakemake samtools=1.15 pybedtools bedtools htslib pytables ipywidgets

SHELL ["/bin/bash", "-c"] 

RUN conda init bash && \
    source activate tev && \
    pip install loguru black isort

RUN source activate jb2 && \
    pip install loguru black isort

RUN mamba install -n tev -c conda-forge -c bioconda --yes pybigwig

RUN apt-get update; apt-get install -y build-essential less nano vim curl git sudo

RUN mamba install -n jb2 -c conda-forge jupyterlab_code_formatter git
RUN apt-get install ripgrep fd-find

# the following language server works fine but messes up path autocomplete by truncating
# RUN mamba install -n jb2 -c conda-forge --yes jupyterlab-lsp jupyter-lsp-python

WORKDIR "${HOME}"