#!/bin/bash

# Generic Bat Test

#Simple generic adb commands, all results are tee'd to a txt file.
#Should implement a parser in python to verify the results?
adb_cmd_generic()
{
    echo "--------------------------------------------"
    echo "Running Generic adb commands"
    echo "--------------------------------------------"

    mkdir -p logs_adb_generic_test
    adb shell ps | grep zygote > ./logs_adb_generic_test/android_processes.txt
    adb shell ps | grep system_server >> ./logs_adb_generic_test/android_processes.txt
    adb shell ps | grep surfaceflinger >> ./logs_adb_generic_test/android_processes.txt
    adb shell ps | grep mediaserver >> ./logs_adb_generic_test/android_processes.txt

    adb shell screencap -p /sdcard/test_screencap.png
    adb pull /sdcard/test_screencap.png 

    adb shell df | tee ./logs_adb_generic_test/df.txt
    adb shell mount | tee ./logs_adb_generic_test/mount.txt
    adb shell cat /proc/cpuinfo | tee ./logs_adb_generic_test/cpuinfo.txt
    
    

    #adb shell echo c > /proc/sysrq-trigger
    #adb reboot recovery 
    #adb shell input keyevent 26
    #adb shell input keyevent 82
}

#Aquire the PID of surfaceflinger, loop through the varible
#for the correct PID, then kill the process
tombstone_generic()
{
    target=2
    counter=0
    tombstones="$(adb shell ps | grep surfaceflinger)"
    echo $tombstones >> ./logs_adb_generic_test/android_processes.txt
    for word in $tombstones; do
        counter=$((counter+1));
        if [ $counter = "2" ]; then
            echo $word
            adb shell kill -3 $word
        fi
            
    done
}

run_test_cases()
{
    echo "--------------------------------------------"
    echo "Starting generic test cases"
    echo "--------------------------------------------"
    adb_cmd_generic
    tombstone_generic
}

run_test_cases
