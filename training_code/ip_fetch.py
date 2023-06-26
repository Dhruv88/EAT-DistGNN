import argparse
parser = argparse.ArgumentParser(description="make_ip_list")
parser.add_argument("--log_file", type=str, help="log file name")
args = parser.parse_args()

import os
cmd = 'scontrol show hostnames'
os.system(cmd)
import time

with open(args.log_file) as f:
    lines = f.readlines()
new_lines = [''.join([x.strip(), ".iitk.ac.in"]) for x in lines if x[0] not in ['S', '=']]
with open('training_code/ip_config.txt', 'w') as f:
    for j in new_lines:
        f.writelines(os.popen('cat /etc/hosts | grep -i {}'.format(j)).read().split(' ')[0]+'\n')
# os.system("cut -d' ' -f1 temp.txt >> training_code/ip_config.txt")
