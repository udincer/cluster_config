ARG BASE_CONTAINER="condaforge/mambaforge"
FROM --platform=linux/amd64 $BASE_CONTAINER

LABEL maintainer="tev"

SHELL ["/bin/bash", "--login", "-c"] 

RUN apt-get update; apt-get install -y build-essential less nano vim curl git sudo ripgrep fd-find

RUN mamba install -n base -c conda-forge --yes python=3.10 nb_conda_kernels nbdime jupyterlab_execute_time ipywidgets jupyterlab_code_formatter git exa && \
    pip install loguru black isort && \
    mamba clean --all  --yes

RUN mamba create -n tev -c conda-forge -c defaults -c bioconda --yes python=3.8 numpy scipy pandas scikit-learn umap-learn seaborn tqdm statsmodels yapf cython joblib parallel nbdime widgetsnbextension bedops snakemake samtools=1.15 pybedtools bedtools htslib pytables ipywidgets exa && \
    mamba install -n tev -c conda-forge -c bioconda --yes pybigwig && \
    mamba clean --all  --yes

RUN conda init bash && \
    source activate tev && \
    pip install loguru black isort statannotations

# the following language server works fine but messes up path autocomplete by truncating
# try setting %config Completer.use_jedi = False
RUN mamba install -n base -c conda-forge --yes jupyterlab-lsp python-lsp-server
RUN jupyter labextension install jupyterlab-tailwind-theme

WORKDIR "${HOME}"