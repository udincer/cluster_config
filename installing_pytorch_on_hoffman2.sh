## installing pytorch on hoffman2
# 2020-02-08

conda install numpy ninja pyyaml mkl mkl-include setuptools cmake cffi

# CUDA can only be used on GPU nodes
USE_CUDA=0 

git clone --recursive https://github.com/pytorch/pytorch
cd pytorch

module load gcc/7.2.0
# conda install -c anaconda gcc_linux-64

# this is stupid, uses the wrong ld
mv /u/home/d/dincer/work/miniconda3/compiler_compat/ld /u/home/d/dincer/work/miniconda3/compiler_compat/ld-old

export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
python setup.py install

mv /u/home/d/dincer/work/miniconda3/compiler_compat/ld-old /u/home/d/dincer/work/miniconda3/compiler_compat/ld 
