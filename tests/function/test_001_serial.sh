#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 11:03:30
 # @LastEditors: xichaoli xichao@sina.cn
 # @LastEditTime: 2022-09-14 09:56:22
# @FilePath: /hatf/tests/function/test_001_start.sh
# @Description: 确认操作系统串口输入输出功能正常
###

test_serial_output() {
    local title="serial_output"
    local case_id="0012"

    ((RUN_NUM += 1))

    if (whiptail --title "serial output" --yesno "请查看串口终端输出，确认系统是否启动成功" 10 50 3>&1 1>&2 2>&3); then
        ((PASS_NUM += 1))
        log_info "串口终端输出正常"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "串口终端输出不正常！请确认系统是否已正常启动！"
    fi
}

test_serial_input() {
    local title="serial_input"
    local case_id="0011"

    ((RUN_NUM += 1))

    if (whiptail --title "serial input" --yesno "请在串口终端确认是否可以正确输入字符" 10 50 3>&1 1>&2 2>&3); then
        ((PASS_NUM += 1))
        log_info "串口终端输入功能正常"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "串口终端输入功能不正常！"
    fi
}

test_serial() {
    log_info "Start to test the serial status ..."
    whiptail --title "Tips" --msgbox "请正确连接串口线,并将串口终端波特率设置为115200." 10 50
    test_serial_output
    test_serial_input
    log_info "Stop testing the serial status ..."
}
