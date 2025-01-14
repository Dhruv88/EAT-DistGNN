#!/bin/sh
#SBATCH -N 4
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=ogbn_products_exp
#SBATCH --partition=standard
#SBATCH --output=experiments/ogbn-products_logs.txt
#SBATCH --time=16:00:00

python3 training_code/ip_fetch.py --log_file "experiments/ogbn-products_logs.txt"
sleep 5
#module load python/conda-python/3.9
#module list

#Directories to store the partitions and experiment results
mkdir -p experiments/products

#Update perimission to allow execution
chmod +x deploy_trainers.sh

#Products METIS
./deploy_trainers.sh -G ogbn-products -S 1 -P metis -n 47 -p 0.34 -d 0.5 -r 0.004 -s 15 -v cbs+gp -e 100 -c 1
./deploy_trainers.sh -G ogbn-products -S 1 -P metis -n 47 -p 0.34 -d 0.5 -r 0.004 -s 15 -v cbs+gp+fl -e 100 -c 0 -g 0.1
./deploy_trainers.sh -G ogbn-products -P metis -n 47 -p 1.0 -d 0.5 -r 0.001 -s 15 -v default -e 100 -c 1

#Products Edge_Weighted
# ./deploy_trainers.sh -G ogbn-products -S 1 -P edge-weighted -n 47 -p 0.34 -d 0.5 -r 0.004 -s 15 -v cbs+gp -e 100 -c 1

#Products Entropy_Balanced
# ./deploy_trainers.sh -G ogbn-products -S 1 -P entropy-balanced -n 47 -p 0.34 -d 0.5 -r 0.004 -s 15 -v cbs+gp+fl -e 100 -c 0 -g 0.1

#Make Results
# python3 make_results.py --graph_name ogbn-products