#!/bin/bash
#SBATCH -n 1
#SBATCH -p gpu_shared
#SBATCH --gres=gpu:gtx1080ti:2
#SBATCH -c 6
#SBATCH -t 3:00
#SBATCH -o gpipe-exercise-%j.out
#SBATCH -e gpipe-exercise-%j.out
#SBATCH --reservation=jupyterhub_jhlptc001_course_tuesday

module purge
module load 2019
module load Python/3.6.6-foss-2019b

TEACHER_DIR=/home/ptc0000/

source ${TEACHER_DIR}/JHL_hooks/env

tar -C "$TMPDIR" -zxf ${TEACHER_DIR}/JHL_data/MNIST.tar.gz

export PYTHONUNBUFFERED=1
python ~/JHL_notebooks/GPipe/mnist_gpipe_exercise.py --arch resnet50 --datadir="$TMPDIR" --batchsize=512 --num_microbatches=6 --balance_by=time
