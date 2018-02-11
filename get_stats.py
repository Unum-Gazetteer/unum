import csv

from config import path_to_output

max_lengths = {}

with open(path_to_output) as f:
    reader = csv.DictReader(f, delimiter="\t")
    max_lengths = dict([(name, 0) for name in reader.fieldnames])
    print("max_lengths:", max_lengths)
    for line in reader:
        for key, value in line.items():
            length = len(value)
            if length > max_lengths[key]:
                max_lengths[key] = length

print("max_lengths:", max_lengths)
            
