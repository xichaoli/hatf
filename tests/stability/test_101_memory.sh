#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-19 16:22:53
 # @LastEditors: xichaoli xichao@sina.cn
 # @LastEditTime: 2022-09-14 10:12:00
# @FilePath: /hatf/tests/stability/test_memory
# @Description: 使用 memtester 测试内存稳定性
###

test_memtester() {
    log_info "Start memtester ..."

    local title="memtester"
    local case_id="1011"

    local MEMORY_AVAILABLE
    MEMORY_AVAILABLE=$(grep MemTotal: /proc/meminfo | awk '{print $2}')

    local MEMORY_RATE
    MEMORY_RATE=$(
        whiptail --title "Memory rate to be tested" --inputbox \
            "The recommended setting is above 0.9\n" 10 50 0.9 3>&1 1>&2 2>&3
    )

    local MEMORY_SIZE
    MEMORY_SIZE=$(echo "${MEMORY_AVAILABLE}*${MEMORY_RATE}/1" | bc)

    local ROUND_NUMBER
    ROUND_NUMBER=$(
        whiptail --title "Round number to be tested" --inputbox \
            "The recommended setting is 3\n" 10 50 3 3>&1 1>&2 2>&3
    )

    memtester "${MEMORY_SIZE}"K "${ROUND_NUMBER}" 2>&1 | tee -a "${LOG_FILE}"

    ((RUN_NUM += 1))

    if (whiptail --title "test result" --yesno "所有测试项结果都是 ok ?" 10 50); then
        ((PASS_NUM += 1))
        log_info "Memtester 测试通过 ..."
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "Memtester 测试不通过 ..."
    fi
    log_info "End memtester ..."
}
