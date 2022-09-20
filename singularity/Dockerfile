ARG BASE_CONTAINER="condaforge/mambaforge"
FROM --platform=linux/amd64 $BASE_CONTAINER
LABEL maintainer="tev"

SHELL ["/bin/bash", "--login", "-c"] 

RUN apt-get update; apt-get install -y build-essential less nano vim curl git sudo ripgrep fd-find fzf

# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# install eget
RUN cd /usr/local/bin && \
    curl https://zyedidia.github.io/eget.sh | bash && \
    ./eget zyedidia/micro -a static

RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# the language server (jupyterlab-lsp) works fine but messes up path autocomplete by truncating
# try setting %config Completer.use_jedi = False
# also unset lsp-completer-max-label-width in the browser
RUN mamba install -n base -c conda-forge --yes python=3.10 nb_conda_kernels nbdime jupyterlab_execute_time ipywidgets jupyterlab_code_formatter git exa rsync bat jupyterlab-lsp python-lsp-server nodejs && \
    pip install loguru black isort && \
    mamba clean --all  --yes

RUN mamba create -n tev -c conda-forge -c defaults -c bioconda --yes python=3.8 numpy scipy pandas scikit-learn umap-learn seaborn tqdm statsmodels yapf cython joblib parallel nbdime widgetsnbextension bedops snakemake samtools=1.15 pybedtools bedtools htslib pytables ipywidgets exa bat dask dask-jobqueue python-graphviz fastparquet murmurhash sqlalchemy cytoolz bokeh distributed && \
    mamba install -n tev -c conda-forge -c bioconda --yes pybigwig && \
    mamba clean --all  --yes

RUN conda init bash && \
    source activate tev && \
    pip install loguru black isort statannotations

RUN jupyter labextension install jupyterlab-tailwind-theme

RUN useradd --shell /bin/bash dev
USER dev

WORKDIR "${HOME}"
