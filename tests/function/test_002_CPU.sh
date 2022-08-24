###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 12:06:04
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-22 17:31:03
# @FilePath: /hatf/tests/function/test_002_CPU.sh
# @Description: 确认CPU参数是否正确
###

test_cpu_core_num() {
    CORE_NUM=$(lscpu | grep "^CPU(s):" | awk '{print$NF}')
    if [ "${CORE_NUM}" = "${SHOULD_CPU_NUM}" ]; then
        log_info "CPU核心数量正确"
    else
        log_err "CPU核心数量不正确！"
    fi
}

test_cpu_core_offline() {
    CPU_OFFLINE=$(lscpu | grep "Off-line" | awk '{print$NF}')
    if [ -z "${CPU_OFFLINE}" ]; then
        log_info "没有离线状态的CPU核心"
    else
        log_err "有CPU核心离线，请使用 lscpu -e -c 做进一步检测"
    fi
}

test_cpu_core() {
    test_cpu_core_num
    test_cpu_core_offline
}

test_cpu_freq() {
    CPU_FREQ=$(lscpu | grep "CPU MHz:" | awk '{print$NF}')
    if [ "${CPU_FREQ}" = "${SHOULD_CPU_FREQ}" ]; then
        log_info "CPU主频正确"
    else
        log_err "CPU主频不正确"
    fi
}

test_cpu() {
    log_info "Start to test the CPU status ..."

    if [ "${DUT_MODEL}" = "S9080" ]; then
        SHOULD_CPU_NUM=32
        SHOULD_CPU_FREQ=2400.00
    elif [ "${DUT_MODEL}" = "S6040" ]; then
        SHOULD_CPU_NUM=8
        SHOULD_CPU_FREQ=2400.00
    else # F6040
        SHOULD_CPU_NUM=8
        SHOULD_CPU_FREQ=2300.00
    fi

    test_cpu_core
    test_cpu_freq
    log_info "Stop testing the CPU status ..."
}
