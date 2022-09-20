#!/bin/bash
#bashsupport disable=BP2001
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-23 11:38:42
 # @LastEditors: xichaoli xichao@sina.cn
 # @LastEditTime: 2022-09-14 10:09:20
# @FilePath: /hatf/tests/function/test_007_USB.sh
# @Description: 插拔 usb 设备，测试 usb 接口能否正常识别
###

test_usb() {
    log_info "Start to test USB ports ..."

    local title="usb"
    local case_id="0071"

    while (whiptail --yesno "Are there any untested USB ports?" 10 50 3>&1 1>&2 2>&3); do
        lsusb > old_usb_info
        whiptail --msgbox "Please plug in a USB device. Then wait for a while." 10 60
        lsusb > new_usb_info
        local NEW_USB
        NEW_USB=$(diff old_usb_info new_usb_info | grep "^>" | cut -d ' ' -f2-)

        ((RUN_NUM += 1))

        if (whiptail --yesno "Found new USB device ${NEW_USB}, is it?" 10 60 3>&1 1>&2 2>&3); then
            ((PASS_NUM += 1))
            log_info "USB端口功能正常"
        else
            ((FAIL_NUM += 1))
            fail_id[${title}]=${case_id}
            log_err "USB端口功能不正常"
        fi
        whiptail --msgbox "Please unplug the USB device you plugged in just now." 10 60
    done
    
    rm -f old_usb_info new_usb_info    log_info "Stop testing USB ports ..."
}
