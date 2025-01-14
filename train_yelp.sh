#!/bin/sh
#SBATCH -N 4
#SBATCH --ntasks-per-node=2
#SBATCH --job-name=yelp_exp
#SBATCH --partition=standard
#SBATCH --output=experiments/yelp_logs.txt
#SBATCH --time=16:00:00

python3 training_code/ip_fetch.py --log_file "experiments/yelp_logs.txt"
sleep 5
#module load python/conda-python/3.9
#module list

#Directories to store the partitions and experiment results
mkdir -p experiments/yelp

#Update perimission to allow execution
chmod +x deploy_trainers.sh

#Yelp METIS
./deploy_trainers.sh -G yelp -S 1 -P metis -n 100 -p 0.4 -d 0.1 -r 0.001 -s 20 -v cbs+gp -e 300 -c 1
./deploy_trainers.sh -G yelp -S 1 -P metis -n 100 -p 0.4 -d 0.1 -r 0.001 -s 15 -v cbs+gp+fl -e 200 -c 0 -g 0.1
./deploy_trainers.sh -G yelp -P metis -n 100 -p 1.0 -d 0.1 -r 0.0001 -s 20 -v default -e 100 -c 1

#Yelp Edge_Weighted
# ./deploy_trainers.sh -G yelp -S 1 -P edge-weighted -n 100 -p 0.34 -d 0.1 -r 0.001 -s 20 -v cbs+gp -e 300 -c 1

# #Yelp Entropy_Balanced
# ./deploy_trainers.sh -G yelp -S 1 -P entropy-balanced -n 100 -p 0.34 -d 0.1 -r 0.001 -s 15 -v cbs+gp+fl -e 100 -c 0 -g 0.1

# #Make Results
# python3 make_results.py --graph_name yelp