CONFIGS=($(ls /ibm/gpfs-dataP/uye/repos/kme_net/results/cifar10/2021032922*/config.json))

for config in "${CONFIGS[@]}"
do
  ts=$(date +"%Y%m%d%H%M%S%3N")
  JOB_NAME="kme_cifar10_${ts}"
  echo "#!/bin/bash

#BSUB -q prod.med
#BSUB -R \"rusage[ngpus_excl_p=1]\"
#BSUB -e \"logs/${JOB_NAME}.stderr.%J\"
#BSUB -o \"logs/${JOB_NAME}.stdout.%J\"
#BSUB -J \"logs/${JOB_NAME}\"

# LOAD MODULES
module purge
source activate torch36

# LAUNCH
python bin/run_experiment.py --config_file ${config}" > tmp.lsf
  bsub < tmp.lsf

done
