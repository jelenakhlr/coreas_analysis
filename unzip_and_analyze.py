# author: @jelenakhlr
import os
import tarfile
import tempfile
import subprocess
from optparse import OptionParser

parser = OptionParser()
parser.add_option("--directory", "--dir", "-d", type="str",
                  help="Specify the full path to the directory of the MULTIPLE simulation sets.")
parser.add_option("--file", "-f", type="str",
                  help="Specify the full path to the SINGLE simulation set you want to analyze.")
(options, args) = parser.parse_args()


# Create a temporary directory
temp_dir = tempfile.mkdtemp()

if __name__ == '__main__':
    # Check that the user has specified a directory or a single file.
    if options.directory:
        input_directory = options.directory
    elif options.file:
        input_directory = options.file
    else:
        parser.print_help()
        exit()
    
    for filename in os.listdir(input_directory):
        if filename.endswith('.tar.gz'):
            file_path = os.path.join(input_directory, filename)

            # Extract the .tar.gz file into the temporary directory
            with tarfile.open(file_path, 'r:gz') as tar:
                tar.extractall(path=temp_dir)

    # Perform the analysis on the contents of the temporary directory.
    

    # Delete the temporary directory and its contents
    subprocess.run(['rm', '-r', temp_dir], check=True)
