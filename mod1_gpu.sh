#!/bin/bash
module purge
module load compilers/gcc/13.2.0
module load lib/pmix/5.0.1
module load lib/zlib/1.3.1_gcc
module load nvidia/cuda/13.0.3_580.126.20
module load physics/uhaina_env/02.07.2026
module load devel/cmake/3.31.0-rc2