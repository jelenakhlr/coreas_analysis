#!/bin/bash

# Function to process a single simulation directory
rawroot() {
  local dir="$1"
  local en="$2"

  # Extract the runID from the directory name itself (assuming 6 digits)
  local runid=${dir: -6}  # Extract the last 6 characters

  # Change directory to CoreasRawRoot location
  cd /pbs/home/j/jpeterei/grand/sim2root/CoREASRawRoot

  # Run CoreasToRawROOT.py with the complete directory path
  python3 CoreasToRawROOT.py -d "$dir"
}

sim2root() {
  local dir="$1"
  local en="$2"
  # Extract the runID from the directory name itself (assuming 6 digits)
  local runid=${dir: -6}  # Extr
  # Change directory to Common location
  cd /pbs/home/j/jpeterei/grand/sim2root/Common

  # Run sim2root.py with the input and output paths
  python3 sim2root.py "/sps/grand/jelena/GP300/rawroot/$en" \
                     -o "/sps/grand/jelena/GP300/root_noise/"
}

# Find all directories with the pattern (replace with your actual path)
energies=(10.0 10.2 10.4 10.6 8.0 8.2 8.4 8.6 8.8 9.0 9.2 9.4 9.6 9.8)
# for en in "${energies[@]}"; do
#   mkdir /sps/grand/jelena/GP300/rawroot/$en
#   find /sps/grand/jelena/GP300/rawsims/GP300/run01/$en/*/*/ -type d -print | while read dir; do  
#     echo ". . . . . . . . . . . . . . . . . . . . ."
#     echo ". . . . . . . . . . . . . . . . . . . . ."
#     echo "Creating rawroot for $dir"
#     rawroot "$dir" "$en"
#     echo "Moving rawroot file to /sps/grand/jelena/GP300/rawroot/$en"
#     mv /pbs/home/j/jpeterei/grand/sim2root/CoREASRawRoot/*.rawroot /sps/grand/jelena/GP300/root_nonoise/$en
#     echo ". . . . . . . . . . . . . . . . . . . . ."
#     echo ". . . . . . . . . . . . . . . . . . . . ."
#     echo ". . . . . . . . . . . . . . . . . . . . ."
#   done
# done


for en in "${energies[@]}"; do
  find /sps/grand/jelena/GP300/rawsims/GP300/run01/$en/*/*/ -type d -print | while read dir; do  
    echo "Creating sim2root for $dir"
    sim2root "$dir" "$en"
    echo ". . . . . . . . . . . . . . . . . . . . ."
    echo ". . . . . . . . . . . . . . . . . . . . ."
  done
done

echo "Finished processing all showers"


# # Function to process a single runID
# process_runid() {
#   local runid="$1"

#   # Change directory to CoreasRawRoot location
#   cd /pbs/home/j/jpeterei/grand/sim2root/CoREASRawRoot

#   # Run CoreasToRawROOT.py
#   python3 CoreasToRawROOT.py -d "/sps/grand/jelena/GP300/rawsims/GP300/run01/**/**/$runid"
#   mv Coreas_$runid.rawroot "/sps/grand/jelena/DC2_testsims/"

#   # Change directory to Common location
#   cd /pbs/home/j/jpeterei/grand/sim2root/Common

#   # Run sim2root.py
#   python3 sim2root.py "/sps/grand/jelena/DC2_testsims/$runid/Coreas_$runid.rawroot" \
#                      -o "/sps/grand/jelena/DC2_testsims/"

#   # # Change directory to scripts location
#   # cd /pbs/home/j/jpeterei/grand/scripts

#   # # Run convert_efield2voltage.py
#   # python3 convert_efield2voltage.py "/sps/grand/jelena/DC2_testsims/$runid/sim_Dunhuang_20170331_220000_RUN1_CD__0000" \
#   #                    --target_sampling_rate_mhz=500 \
#   #                    --target_duration_us=4.096 \
#   #                    -o "/sps/grand/jelena/DC2_testsims/$runid/voltage_Coreas_$runid.root"
# }

# # Loop through each runID in the list (replace with your actual way to get the list)
# for runid in {000000..999999}; do
#   process_runid "$runid"
# done

# echo "Finished processing all runIDs."




# # cd /pbs/home/j/jpeterei/grand/sim2root/CoREASRawRoot
# # python3 CoreasToRawROOT.py -d /sps/grand/jelena/DC2_testsims/003100
# # mv Coreas_003100.rawroot /sps/grand/jelena/DC2_testsims/003100

# # cd /pbs/home/j/jpeterei/grand/sim2root/Common
# # python3 sim2root.py /sps/grand/jelena/DC2_testsims/003100/Coreas_003100.rawroot -o /sps/grand/jelena/DC2_testsims/003100

# # cd /pbs/home/j/jpeterei/grand/scripts
# # python3 convert_efield2voltage.py /sps/grand/jelena/DC2_testsims/003100/sim_Dunhuang_20170331_220000_RUN1_CD__0000 --target_sampling_rate_mhz=500 --target_duration_us=4.096 -o /sps/grand/jelena/DC2_testsims/003100/voltage_Coreas_003100.root

# # python3 convert_efield2voltage.py /sps/grand/jelena/DC2_testsims/003100/sim_Dunhuang_20170331_220000_RUN1_CD__0000 --no_noise --target_sampling_rate_mhz=500 --target_duration_us=4.096 -o /sps/grand/jelena/DC2_testsims/003100/voltage_Coreas_003100_no_noise.root

# # python3 convert_efield2voltage.py /sps/grand/jelena/DC2_testsims/003100/sim_Dunhuang_20170331_220000_RUN1_CD__0000 --no_noise --no_rf_chain --target_sampling_rate_mhz=500 --target_duration_us=4.096 -o /sps/grand/jelena/DC2_testsims/003100/voltage_Coreas_003100_no_noise_no_rfchain.root

# # python3 convert_efield2voltage.py /sps/grand/jelena/DC2_testsims/003100/sim_Dunhuang_20170331_220000_RUN1_CD__0000 --no_rf_chain --target_sampling_rate_mhz=500 --target_duration_us=4.096 -o /sps/grand/jelena/DC2_testsims/003100/voltage_Coreas_003100_no_rfchain.root 
