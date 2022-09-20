#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 16:11:42
 # @LastEditors: xichaoli xichao@sina.cn
 # @LastEditTime: 2022-09-14 10:06:04
# @FilePath: /hatf/tests/function/test_005_beep.sh
# @Description: 测试蜂鸣器是否正常(目前只支持申威平台)
###

test_beep_on() {
    local title="beep_on"
    local case_id="0051"

    ((RUN_NUM += 1))
    i2cset -f -y 2 0x64 0x8 0xf9 1> /dev/null 2>&1
    if (whiptail --title "test beep on" --yesno "是否听到了蜂鸣音？" 10 50 3>&1 1>&2 2>&3); then
        ((PASS_NUM += 1))
        log_info "可以控制蜂鸣器开启"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "不能听到蜂鸣音，请做进一步检查"
    fi
}

test_beep_off() {
    local title="beep_off"
    local case_id="0052"

    ((RUN_NUM += 1))
    i2cset -f -y 2 0x64 0x8 0xf8 1> /dev/null 2>&1
    if (whiptail --title "test beep off" --yesno "蜂鸣音是否停止？" 10 50 3>&1 1>&2 2>&3); then
        ((PASS_NUM += 1))
        log_info "可以控制蜂鸣器关闭"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "不能听关闭鸣音，请做进一步检查"
    fi
}

test_beep() {
    log_info "Start to test the beep ..."
    # TODO: 飞腾平台的判断
    test_beep_on
    test_beep_off
    log_info "Stop testing the beep ..."
}
