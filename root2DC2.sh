#!/bin/bash

# Function to process a single simulation directory
process_sim_dir() {
  subdir="$1"
  echo $subdir
  # Change directory to scripts location
  cd /pbs/home/j/jpeterei/grand/scripts

  echo "efield2voltage"
  # 1: produce voltage with noise
  echo convert_efield2voltage.py $subdir
  python3 convert_efield2voltage.py $subdir \
                                  --seed=$RANDOM\
                                  --add_jitter_ns=5\
                                  --calibration_smearing_sigma=0.075

  echo "efield2voltage no noise"
  # 2: produce voltage without noise
  echo python3 convert_efield2voltage.py $subdir
  python3 convert_efield2voltage.py $subdir \
                                  --seed=$RANDOM \
                                  --no_noise\
                                  -o nonoise.root

  echo "ADC"
  # 3: produce ADC
  echo python3 convert_voltage2adc.py $subdir
  python3 convert_voltage2adc.py $subdir

  echo "DC2"
  # 4: produce DC2 efield
  echo python3 convert_efield2efield.py $subdir
  python3 convert_efield2efield.py $subdir\
                                 --target_duration_us=4.096 \
                                 --target_sampling_rate_mhz=500


}
subdirs=(
# "/sps/grand/jelena/GP300/sim2root/10.0/sim_Dunhuang_20170331_220000_RUN1_CD__0000"
# "/sps/grand/jelena/GP300/sim2root/10.2/sim_Dunhuang_20170331_220000_RUN1_CD__0000"
/sps/grand/jelena/GP300/sim2root/10.4/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/10.6/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/8.0/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/8.2/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/8.4/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/8.6/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/8.8/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/9.0/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/9.2/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/9.4/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/9.6/sim_Dunhuang_20170331_220000_RUN1_CD__0000
/sps/grand/jelena/GP300/sim2root/9.8/sim_Dunhuang_20170331_220000_RUN1_CD__0000
)
for subdir in $subdirs; do
  process_sim_dir "$subdir"
done

echo "Finished processing all simulations."
