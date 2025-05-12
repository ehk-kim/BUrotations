#!/bin/bash -l
#$ -P perturb-fish
#$ -N MERFISH_matlab
#$ -m beas
#$ -M yourEmailHere@bu.edu
#$ -j y
#$ -pe omp 8
#$ -l h_rt=24:00:00
#$ -o /path/to/MERFISH_analysis/qlog/merfish_analysis.log

module purge

directory="./qlog/"
if [ ! -d "$directory" ]; then
	mkdir qlog
fi

echo ""
echo "======================= NEW RUN ======================="
start_date_time="`date "+%Y-%m-%d %H:%M:%S"`"
echo "Started at $start_date_time"
echo ""

# change this to your directory with the MERFISH_analysis program
# and your data. The script should also be in this directory.
cd /path/to/MERFISH_analysis
module load matlab

matlab -batch "library_design_example; exit"
#matlab -batch "library_design_exampleClusterWithoutByteStream; exit"

end_date_time="`date "+%Y-%m-%d %H:%M:%S"`"
echo "Ended at $end_date_time"
echo ""