#!/usr/bin/env python3

import subprocess
import argparse

def read_clusters_from_file(file_path):
    with open(file_path, 'r') as file:
        return [line.strip() for line in file.readlines()]

clusters = read_clusters_from_file('clusters.txt')

parser = argparse.ArgumentParser()
parser.add_argument("-y", "--yes", help="Answer yes to all prompts", action="store_true")
args = parser.parse_args()

for cluster in clusters:
    cluster_info = cluster.split(":")
    cluster_name = cluster_info[0]
    project_id = cluster_info[1]
    zone = cluster_info[2]

    if args.yes:
        confirm = "y"
    else:
        confirm = input(f"Get credentials for cluster: {cluster_name} (y/n)? ")
    if confirm.lower() != "y":
        continue

    print(f"Getting credentials for cluster: {cluster_name}")
    try:
        subprocess.check_call(["gcloud", "container", "clusters", "get-credentials", cluster_name, "--zone", zone, "--project", project_id])
    except subprocess.CalledProcessError:
        print(f"Error: Failed to get credentials for cluster: {cluster_name}")
        exit(1)

print("All cluster credentials retrieved successfully.")
