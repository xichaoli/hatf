###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 11:03:30
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-23 10:05:53
# @FilePath: /hatf/tests/function/test_001_start.sh
# @Description: 确认操作系统串口输入输出功能正常
###

test_serial_output() {
    if (whiptail --title "serial output" --yesno "请查看串口终端输出，确认系统是否启动成功" 10 50 3>&1 1>&2 2>&3); then
        log_info "串口终端输出正常"
    else
        log_err "串口终端输出不正常！请确认系统是否已正常启动！"
    fi
}

test_serial_input() {
    if (whiptail --title "serial input" --yesno "请在串口终端确认是否可以正确输入字符" 10 50 3>&1 1>&2 2>&3); then
        log_info "串口终端输入功能正常"
    else
        log_err "串口终端输入功能不正常！"
    fi
}

test_serial() {
    log_info "Start to test the serial status ..."
    whiptail --title "Tips" --msgbox "请正确连接串口线，并将串口终端波特率设置为115200." 10 50
    test_serial_output
    test_serial_input
    log_info "Stop testing the serial status ..."
}
