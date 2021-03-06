#!/bin/bash

#####Set Scheduler Configuration Directives#####
#Set the name of the job. This will be the first part of the error/output filename.
#$ -N train_lstm

#Set the current working directory as the location for the error and output files.
#(Will show up as .e and .o files)
#$ -cwd

#Send e-mail at beginning/end/suspension of job
##$ -m bes

#E-mail address to send to
##$ -M abdalrhman-mohamed@uiowa.edu
#####End Set Scheduler Configuration Directives#####


#####Resource Selection Directives#####
#See the HPC wiki for complete resource information: https://wiki.uiowa.edu/display/hpcdocs/Argon+Cluster
#Select the queue to run in
#$ -q CLAS-INSTR-GPU,UI-GPU,all.q

#Select the number of slots the job will use
#$ -pe smp 4

#Indicate that the job requires a GPU
#$ -l gpu=true

#Sets the number of requested GPUs to 1

#Indicate that the job requires a mid-memory (currently 256GB node)
#$ -l mem_64G=true

#Indicate the CPU architecture the job requires

#Specify a data center for to run the job in

#Specify the high speed network fabric required to run the job
##$ -l fabric=omnipath
#####End Resource Selection Directives#####


#####Begin Compute Work#####
#Print information from the job into the output file
/bin/echo Running on compute node: `hostname`.
/bin/echo In directory: `pwd`
/bin/echo Starting on: `date`

module load stack/2020.1
module load py-tensorflow/1.14.0_gcc-8.3.0

python train.py --frame_features --model=LstmModel --feature_names='rgb,audio' --feature_sizes='1024,128' --train_data_pattern=/nfsscratch/yt8m/frame/train*.tfrecord --train_dir models/frame/lstm_model --start_new_model

#Print the end date of the job before exiting
echo Now it is: `date`
#####End Compute Work#####
