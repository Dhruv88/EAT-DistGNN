#!/bin/sh
#SBATCH -N 4
#SBATCH --ntasks-per-node=1
#SBATCH --job-name=flickr_exp
#SBATCH --partition=standard
#SBATCH --output=experiments/flickr_logs.txt
#SBATCH --time=6:00:00

python3 training_code/ip_fetch.py --log_file "experiments/flickr_logs.txt"
sleep 5
#module load python/conda-python/3.9
#module list

#Directories to store the partitions and experiment results
mkdir -p experiments/flickr

#Update perimission to allow execution
chmod +x deploy_trainers.sh

#Flickr METIS
./deploy_trainers.sh -G flickr -P metis -n 7 -p 1.0 -d 0.5 -s 15 -v default -e 100 -c 1 -h 256
./deploy_trainers.sh -G flickr -P metis -n 7 -p 0.4 -d 0.5 -s 15 -v gp -e 100 -c 1 -h 256
./deploy_trainers.sh -G flickr -P metis -n 7 -p 0.4 -d 0.5 -s 15 -v gp+fl -e 100 -c 0 -h 256


# #Flickr Edge_Weighted
# ./deploy_trainers.sh -G flickr -P edge-weighted -n 7 -p 0.34 -d 0.5 -s 15 -v gp+fl -e 100 -c 1

# #Flickr Entropy_Balanced
# ./deploy_trainers.sh -G flickr -P entropy-balanced -n 7 -p 0.34 -d 0.5 -s 15 -v gp+fl -e 100 -c 0

# #Make Results
# python3 make_results.py --graph_name flickr