#!/bin/bash
#BSUB -J "convert[1-1]"
#BSUB -oo Logs/convert/stdout.%I.log
#BSUB -eo Logs/convert/stderr.%I.log
#BSUB -o output
#BSUB -e error
#BSUB -R "span[hosts=1]"
#BSUB -q Z-LU
#BSUB -n 1

print_prolog(){
    date_str=`date`
    echo "--------------------------------------------------------"
    echo "[$date_str] LSF job started. Job ID: $LSB_JOBID, task ID: $LSB_JOBINDEX"
    echo "--------------------------------------------------------"
}
print_epilog(){
    date_str=`date`
    echo "========================================================"
    echo "[$date_str] LSF job finished. Job ID: $LSB_JOBID, task ID: $LSB_JOBINDEX"
    echo "========================================================"
}
# print message about the start of the job
print_prolog
print_prolog >&2

# get number of tasks and task rank
export LSB_JOBINDEX_END=${LSB_JOBINDEX_END:=1}
export LSB_JOBINDEX=${LSB_JOBINDEX:=1}
NUM_TASKS=$LSB_JOBINDEX_END
RANK=$LSB_JOBINDEX

# run commands from a command list file
# only commands that belongs to the task will be run
run_tasks(){
    sed '/^\s*$/ d' $1 | sed "$RANK~$NUM_TASKS !d" \
        | xargs -d '\n' -l -I '{}' /bin/bash -c '{}'
}

# main script
run_tasks Jobs/convert1.txt


# print message about the end of the job
print_epilog
print_epilog >&2

