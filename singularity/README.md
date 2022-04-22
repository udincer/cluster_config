# Running up-to-date Jupyter environment on H2

## Running a pre-built Jupyter image on H2. 
All of the following should be done on an interactive node (i.e. qrsh).

Step 1: Getting the pre-built image
```bash
IMAGE_DIR="$SCRATCH/singularity_images"
WORKSPACE_DIR="$HOME/work/workspace_singularity"

# IMAGE_DIR should be in SCRATCH directory to take full advantage of speedup
mkdir -p ${IMAGE_DIR} ${WORKSPACE_DIR}

wget -P ${WORKSPACE_DIR}/ https://raw.githubusercontent.com/udincer/cluster_config/master/singularity/workspace_config_files/.bashrc
# code formatter black complains if this directory doesn't exist
mkdir -p ${WORKSPACE_DIR}/.cache/black/22.3.0

module load singularity
singularity build --sandbox "${IMAGE_DIR}/jb_mamba" docker://tevzilla/jb_mamba
```

Step 2: Make changes to the environment
```bash
IMAGE_DIR="$SCRATCH/singularity_images"
WORKSPACE_DIR="$HOME/work/workspace_singularity"

# to make changes to the environment, e.g. install packages with pip or mamba
singularity exec \
    --userns \
    --home ${WORKSPACE_DIR}:/home \
    --bind /tmp:/tmp \
    --containall \
    --writable \
    "${IMAGE_DIR}/jb_mamba" \
    bash
```
Should run `jupyter lab password` inside the container to set notebook access password at this point. `$WORKSPACE_DIR` will have its own .bashrc that you can modify inside or outside the container. 

Step 3: Run Jupyter in new environment.
```bash
IMAGE_DIR="$SCRATCH/singularity_images"
WORKSPACE_DIR="$HOME/work/workspace_singularity"

singularity exec \
    --userns \
    --home ${WORKSPACE_DIR}:/home \
    --bind /tmp:/tmp \
    --containall \
    "${IMAGE_DIR}/jb_mamba" \
    bash -c "jupyter lab --port 8897 --ServerApp.token=token123"
```

Consider putting this command in a script or bash alias for quick access. 

Step 4: Run Jupyter in browser. 
Make SSH tunnel to interactive node (replace `n0000` and H2 username):
`ssh -t -J HOFFMAN_USERNAME@login2.hoffman2.idre.ucla.edu HOFFMAN_USERNAME@n0000 -L 8897:localhost:8897`

Change port both here and singularity command if you get a port error. 

## Building the image
(Instructions for Tev)
1. On laptop, run `docker build -t tevzilla/jb_mamba .` (might need `--platform=linux/amd64`)
2. `docker push tevzilla/jb_mamba`