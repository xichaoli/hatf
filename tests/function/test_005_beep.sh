###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 16:11:42
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-23 10:06:39
# @FilePath: /hatf/tests/function/test_005_beep.sh
# @Description: 测试蜂鸣器是否正常
###

test_beep_on() {
    i2cset -f -y 2 0x64 0x8 0xf9 1>/dev/null 2>&1
    if (whiptail --title "test beep on" --yesno "是否听到了蜂鸣音？" 10 50 3>&1 1>&2 2>&3); then
        log_info "可以控制蜂鸣器开启"
    else
        log_err "不能听到蜂鸣音，请做进一步检查"
    fi
}

test_beep_off() {
    i2cset -f -y 2 0x64 0x8 0xf8 1>/dev/null 2>&1
    if (whiptail --title "test beep off" --yesno "蜂鸣音是否停止？" 10 50 3>&1 1>&2 2>&3); then
        log_info "可以控制蜂鸣器关闭"
    else
        log_err "不能听关闭鸣音，请做进一步检查"
    fi
}

test_beep() {
    log_info "Start to test the beep ..."
    test_beep_on
    test_beep_off
    log_info "Stop testing the beep ..."
}
