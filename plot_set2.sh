#!/bin/bash
grandlib="/pbs/home/j/jpeterei/grand/"

subdirs=(
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0000
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0001
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0002
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0003
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0004
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0005
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0006
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0007
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0008
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0009
sim_Dunhuang_20170331_220000_RUN1_CD_Coreas_0010
)

base_path="/sps/grand/DC2_Coreas/COREAS-NJ/"
for subdir in "${subdirs[@]}"; do
  python3 $grandlib/sim2root/Common/IllustrateSimPipe.py $base_path/$subdir --savefig --sim Coreas
done

echo "Finished processing all simulations."
