#!/bin/sh
#SBATCH -N 4
#SBATCH --ntasks-per-node=2
#SBATCH --job-name=ogbn_papers_exp
#SBATCH --partition=standard
#SBATCH --output=experiments/ogbn-papers_logs.txt

python3 training_code/ip_fetch.py --log_file "experiments/ogbn-papers_logs.txt"
sleep 5
#module load python/conda-python/3.9
#module list

#Directories to store the partitions and experiment results
mkdir -p ./experiments/ogbn-papers

#Update perimission to allow execution
chmod +x deploy_trainers.sh

#Reddit default
./deploy_trainers.sh -G ogbn-papers -P metis -n 172 -p 1.0 -d 0.1 -r 0.01 -v default -e 60 -c 1 -l 0.01 -b 4000 -h 256

#Reddit gp
./deploy_trainers.sh -G ogbn-papers -P metis -n 172 -p 0.5 -d 0.1 -r 0.01 -v gp -e 60 -c 1 -l 0.01 -b 4000 -h 256

#Reddit gp+fl
./deploy_trainers.sh -G ogbn-papers -P metis -n 172 -p 0.5 -d 0.1 -r 0.01 -v gp+fl -e 60 -c 1 -g 0.2 -l 0.01 -b 4000 -h 256

#Make Results
python3 make_results.py --graph_name ogbn-papers