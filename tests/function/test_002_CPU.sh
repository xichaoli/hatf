#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 12:06:04
 # @LastEditors: xichaoli xichao@sina.cn
 # @LastEditTime: 2022-09-14 10:02:41
# @FilePath: /hatf/tests/function/test_002_CPU.sh
# @Description: 确认CPU参数是否正确
###

test_cpu_core_num() {
    local title="cpu_num"
    local case_id="0021"

    ((RUN_NUM += 1))

    local CORE_NUM
    CORE_NUM=$(lscpu | grep "^CPU(s):" | awk '{print$NF}')

    if [ "${CORE_NUM}" = "${SHOULD_CPU_NUM}" ]; then
        ((PASS_NUM += 1))
        log_info "CPU核心数量正确"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "CPU核心数量不正确!"
    fi
}

test_cpu_core_offline() {
    local title="cpu_offline"
    local case_id="0022"

    ((RUN_NUM += 1))

    local CPU_OFFLINE
    CPU_OFFLINE=$(lscpu | grep "Off-line" | awk '{print$NF}')

    if [ -z "${CPU_OFFLINE}" ]; then
        ((PASS_NUM += 1))
        log_info "没有离线状态的CPU核心"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "有CPU核心离线,请使用 lscpu -e -c 做进一步检测"
    fi
}

test_cpu_core() {
    test_cpu_core_num
    test_cpu_core_offline
}

test_cpu_freq() {
    local title="cpu_freq"
    local case_id="0023"
    local CPU_FREQ
    CPU_FREQ=$(lscpu | grep "CPU MHz:" | awk '{print$NF}')

    ((RUN_NUM += 1))

    if [ "${CPU_FREQ}" = "${SHOULD_CPU_FREQ}" ]; then
        ((PASS_NUM += 1))
        log_info "CPU主频正确"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "CPU主频不正确"
    fi
}

test_cpu() {
    log_info "Start to test the CPU status ..."

    if [[ "${DUT_MODEL}" =~ S90[0-9]0 ]]; then
        SHOULD_CPU_NUM=32
        SHOULD_CPU_FREQ=2400.00
    elif [[ "${DUT_MODEL}" =~ S60[0-9]{2} ]]; then
        SHOULD_CPU_NUM=8
        SHOULD_CPU_FREQ=2400.00
    else # F60xx
        SHOULD_CPU_NUM=8
        SHOULD_CPU_FREQ=2300.00
    fi

    test_cpu_core
    test_cpu_freq    log_info "Stop testing the CPU status ..."
}
