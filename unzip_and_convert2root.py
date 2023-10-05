# author: @jelenakhlr
import os
import tarfile
import tempfile
import subprocess
from optparse import OptionParser

path_to_grandlib = "/pbs/home/j/jpeterei/grandlib_dev_io_root/grand/" #! modfiy this path if necessary

parser = OptionParser()
parser.add_option("--directory", "--dir", "-d", type="str",
                  help="Specify the full path to the directory of the MULTIPLE simulation sets.")
parser.add_option("--file", "-f", type="str",
                  help="Specify the full path to the SINGLE simulation set you want to analyze.")
(options, args) = parser.parse_args()


# # Create a temporary directory
temp_dir = tempfile.mkdtemp() # "/pbs/home/j/jpeterei/temp_processed/"
out_dir = "/sps/grand/jelena/stshp+GP13/GRANDroot_format/"
print("Created temp directory", temp_dir)

if __name__ == '__main__':
    # Check that the user has specified a directory or a single file.
    if options.directory:
        input_directory = options.directory
        for filename in os.listdir(input_directory):
            if filename.endswith('.tar.gz'):
                print(f"file {filename} unzipped to {temp_dir}")
                file_path = os.path.join(input_directory, filename)

                # Extract the .tar.gz file into the temporary directory
                with tarfile.open(file_path, 'r:gz') as tar:
                    tar.extractall(path=temp_dir)
    elif options.file:
        file_path = options.file
        input_directory = os.path.dirname(file_path)
        if file_path.endswith('.tar.gz'):
                print(f"file {file_path} unzipped to {temp_dir}")
                # Extract the .tar.gz file into the temporary directory
                with tarfile.open(file_path, 'r:gz') as tar:
                    tar.extractall(path=temp_dir)
        else:
            print(f"ERROR: {filename} is not a .tar.gz file")
            exit()
    else:
        parser.print_help()
    
    
    # Perform the analysis on the contents of the temporary directory.
    print("Converting to GRANDroot format...")
    coreas_pipeline = [
                'python3', f'{path_to_grandlib}sim2root/CoREASRawRoot/coreas_pipeline.py', '-d', temp_dir,\
                'o', '/sps/grand/jelena/stshp+GP13/root/'
            ]
    subprocess.run(coreas_pipeline, check=True)
    print(f"Coreas simulations in GRANDroot format saved to {out_dir}")

    # Delete the temporary directory and its contents
    subprocess.run(['rm', '-r', temp_dir], check=True)
    print("Removed temp directory")
