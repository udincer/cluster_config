# Running up-to-date Jupyter environment on H2

Skip to step 3 if you're not Tev. 

On laptop:
1. On laptop, run `docker build -t tevzilla/jb_mamba .` (might need `--platform=linux/amd64`)
2. `docker push tevzilla/jb_mamba`

On H2:
3. On Hoffman2, `module load singularity`
4. `singularity build --sandbox jb_mamba/ docker://tevzilla/jb_mamba`
5. Writable container: `singularity shell --userns --home ${NEW_HOME_DIR}:/home --containall --writable jb_mamba/` (symbolic link issues)
   Non-writable (symbolic links possible): `singularity shell --userns --home ${NEW_HOME_DIR} --containall jb_mamba/`
6. Run jupyter: `conda activate jb2 && jupyter lab --port 8899 --ServerApp.token=tokentokentoken123`
