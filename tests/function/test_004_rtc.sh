###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 15:54:55
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-22 17:31:59
# @FilePath: /hatf/tests/function/test_005_rtc.sh
# @Description: 测试 RTC 时钟功能
###

test_rtc_write() {
    if hwclock -w 1>/dev/null 2>&1; then
        log_info "设置 RTC 时间 成功"
    else
        log_err "设置 RTC 失败！"
    fi
}

test_rtc_read() {
    if hwclock -r 1>/dev/null 2>&1; then
        log_info "读取 RTC 时间成功"
    else
        log_err "读取 RTC 时间失败！"
    fi
}

test_rtc() {
    log_info "Start to test RTC time ..."
    test_rtc_write
    test_rtc_read
    log_info "Stop testing RTC time ..."
}
