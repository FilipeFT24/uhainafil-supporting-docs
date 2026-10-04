#!/bin/bash
#SBATCH --job-name=Vortexbath
#SBATCH --output=Vortexbath-%j.out-%N
#SBATCH --error=Vortexbath-%j.err-%N
#SBATCH --partition=thin,fat
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=0-00:30:00
#SBATCH --no-requeue

HOME_DIR="/gpfs/scratch/fortetenreiro"
TEST_DIR="${HOME_DIR}/run/${SLURM_JOB_NAME}"
OPT="R0_M6_P3_visu"
HOME_DIR="/gpfs/scratch/fortetenreiro"
TEST_DIR="${HOME_DIR}/run/${SLURM_JOB_NAME}"
JOB_NAME="${OPT}-${SLURM_NNODES}-${SLURM_NTASKS}"
OUTPUT_FILE="${TEST_DIR}/${JOB_NAME}.out"
EXE="${HOME_DIR}/uhainafil/build/Release/src/uhaina/Uhaina"
EXE_ARGS="-i ${TEST_DIR}/xml/${OPT}.xml"

export OMP_NUM_THREADS=1
export OPENBLAS_NUM_THREADS=1
export SCOTCH_PTHREAD_NUMBER=1
export SCOTCH_THREAD_NUMBER=1
export OMPI_MCA_coll_hcoll_enable=0
export UCX_RCACHE_ENABLE=n
export PAMPA_OVLP_NOGT=0

rm -f "${TEST_DIR}/visu/${OPT}"/*.{h5,loc,mem,report,xmf}
#  -f "${TEST_DIR}/visu/${OPT}/data"/*.txt
find "${TEST_DIR}/visu/${OPT}/data" -maxdepth 1 -name "*.txt" -delete
rm -f "${TEST_DIR}/restart/${OPT}"/*.{root,pampa,post}
srun --mpi=pmix_v5 --cpu-bind=cores,verbose --distribution=cyclic:cyclic --exact --verbose ${EXE} ${EXE_ARGS} > "${OUTPUT_FILE}" 2>&1