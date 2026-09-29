#!/bin/bash
source /gpfs/home/fortetenreiro/scratch/run/mod1.sh

sbatch scripts/job1.sh
sbatch scripts/job2.sh
sbatch scripts/job3.sh
sbatch scripts/job4.sh
sbatch scripts/plot.sh