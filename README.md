# README: GRAND Simulation Data Analysis Script

## Introduction
This script helps process and convert CoREAS simulation data into the GRANDroot format.

## Prerequisites
Before using this script, ensure that you have the following prerequisites installed on your system:

- Python 3
- CoREAS simulation data
- The path to the GRAND library, which can be modified in the script if necessary.

## Usage
The script provides two main options for data processing:

### Option 1: Process Multiple Simulation Sets (Directories)
If you have multiple simulation sets organized in directories and want to process them in bulk, you can use this option. Here's how to use it:

```bash
python unzip_andconvert2root.py --directory /path/to/simulation_sets
```

Replace `/path/to/simulation_sets` with the full path to the directory containing your multiple simulation sets. The script will identify and process all `.tar.gz` files within this directory.

### Option 2: Process a Single Simulation Set (File)
If you have a single simulation set stored in a `.tar.gz` file and want to process it individually, you can use this option. Here's how to use it:

```bash
python unzip_andconvert2root.py --file /path/to/single_simulation_set.tar.gz
```

Replace `/path/to/single_simulation_set.tar.gz` with the full path to your single simulation set file. The script will extract the contents of this file and process it.

### Output Directory
The converted simulation data in GRANDroot format will be saved to the following directory:

```bash
/sps/grand/jelena/stshp+GP13/GRANDroot_format/
```

## Running the Script
The script will perform the following steps:

1. Create a temporary directory for processing the data.
2. Extract the contents of the `.tar.gz` files (simulation data) into the temporary directory.
3. Convert the simulation data to GRANDroot format using the CoREAS pipeline.
4. Save the converted data in the specified output directory.
5. Delete the temporary directory and its contents to free up disk space.

If your scripts crash, saying "0 showers found":
1. check the path
2. check the parameter `reas_names = glob.glob(options.directory + "**/SIM??????.reas")` in `grand/sim2root/CoREASRawToRoot/coreas_pipeline.py` and modify the `**` according to your paths.


## Customization
You can customize the path to the GRAND library by modifying the `path_to_grandlib` variable at the beginning of the script.

You can also change the output path by modifying the `out_dir` variable inside the script.

## Authors
- Script Author: [@jelenakhlr](https://github.com/jelenakhlr)
