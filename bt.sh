#!/bin/bash

# Bluetooth Bat Test

#Running bt BAT commands
adb_cmd_bluetooth()
{
    echo "--------------------------------------------"
    echo "Running BT test cases"
    echo "--------------------------------------------"

    mkdir -p logs_bt_test

    adb shell find /sys -iname "*bt*"| grep driver
    tty_dev_workaround
    adb shell find /sys -iname "*rfkill*"

    #adb shell /system/bin/net_bdtool --up --time 5
    #adb shell /system/bin/net_bdtool --discover --time 20
}

#running adb shell ls -l /dev/ | grep bluetooth results in an
#error: service name too long, but running in the shell, it works fine.
#A work around is to push a .sh script with that command, outputting the results to
#a text file, then pulling that pull and storing it as a log 
tty_dev_workaround()
{
    adb push bt_tty_dev_workaround.sh /sdcard/
    adb shell sh /sdcard/bt_tty_dev_workaround.sh
    adb pull /sdcard/bt_tty_dev.txt
    cat bt_tty_dev.txt
    mv bt_tty_dev.txt ./logs_bt_test
    cat bt_tty_dev.txt
}

run_test_cases()
{
    adb_cmd_bluetooth
}

run_test_cases
