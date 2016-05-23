#!/usr/bin/bash

#needs to be tested, not able to push due to verity, couldnt disable verity.

adb_cmd_audio()
{
    
    echo "--------------------------------------------"
    echo "Running audio test ADB commands"
    echo "--------------------------------------------"

    mkdir -p logs_audio_test

    adb shell cat /proc/asound/version >> ./logs_audio_test/audio_test.txt
    adb shell cat /proc/asound/pcm > ./longs_audio_test/audio_test.txt



}

push_alsa_audio()
{
    adb root
    #adb disable-verity
    adb shell mount -o remount,rw /system
    adb shell mount -o remount,rw /

    adb shell mkdir -p /data/modules
    adb shell mkdir -p /system/usr/share/alsa
    adb push alsa.conf /system/usr/share/alsa
    adb push alsa_amixer /system/bin/
    adb push alsa_aplay /system/bin/
    adb push alsa_arecord /system/bin
    adb push libasound.so /system/lib/
    adb shell chmod 777 /system/bin/alsa_*

}



run_test_cases()
{
    adb_cmd_audio
    push_alsa_audio
}

run_test_cases
