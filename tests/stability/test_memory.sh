#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-19 16:22:53
# @LastEditors: xichaoli xichaoli@sina.cn
# @LastEditTime: 2022-08-19 17:26:40
# @FilePath: /hatf/tests/stability/test_memory
# @Description: 使用 memtester 测试内存稳定性
###

test_memtester() {
    log_info "Start memtester ..."
    MEMORY_AVAILABLE=$(grep MemTotal: /proc/meminfo | awk '{print $2}')

    MEMORY_RATE=$(
        whiptail --title "Memory rate to be tested" --inputbox \
            "The recommended setting is above 0.9\n" 10 50 0.9 3>&1 1>&2 2>&3
    )

    MEMORY_SIZE=$(echo "${MEMORY_AVAILABLE}*${MEMORY_RATE}/1" | bc)

    ROUND_NUMBER=$(
        whiptail --title "Round number to be tested" --inputbox \
            "The recommended setting is 3\n" 10 50 3 3>&1 1>&2 2>&3
    )

    memtester "${MEMORY_SIZE}"K "${ROUND_NUMBER}" 2>&1 | tee -a "${LOG_FILE}"

    if (whiptail --title "test result" --yesno "所有测试项结果都是 yes ?" 10 50); then
        log_info "Memtester 测试通过 ..."
    else
        log_err "Memtester 测试不通过 ..."
    fi
    log_info "End memtester ..."
}
