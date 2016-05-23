#!/bin/bash

device_id=$1

#Setup enviroment to perform adb commands. Check if pc has ADB installed, if not, 
#ask te user to set up ADB
setup()
{
    adb wait-for-device

    if adb version; then
        echo "ADB installed, proceeding to testing adb generic test cases"
    else
        print "ADB not installed, please install ADB"
    fi
    echo "Setting up testing environment"

   # adb connect localhost:5558
    adb root

    adb wait-for-device

    adb shell input tap 100 100
    adb shell input tap 620 100
    adb shell input tap 620 1132
    adb shell input tap 100 1132

    adb wait-for-device
}

pre_information()
{

    echo "--------------------------------------------"
    echo "Getting standard information."
    echo "--------------------------------------------"

    adb shell getprop | grep ro.build.fingerprint > pre_info.txt
    adb shell getprop | grep sys.ia32.version >> pre_info.txt
    adb shell getprop | grep sys.kernel.version >> pre_info.txt
    adb shell cat /proc/version >> pre_info.txt
}

#Determine the device id to use, still in progress.
determine()
{
    counter=0
    if [[ ! $device_id ]]; then
        echo "No device id inputted, testing the first device that shows up on adb devices"
        var=$(adb devices)
        for devices in $var; do
            counter=$((counter+1))
            if [ $counter = "5" ]; then
                device_id=$devices
                echo "Bat testing on device $device_id"
            fi
        done
    fi
 
}



#main entry point for BAT testing 
main()
{   
   setup
   pre_information
   bash generic_case.sh
   bash bt.sh
   bash audio_case.sh
}

main





