#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-22 14:03:50
# @LastEditors: xichaoli xichao@sina.cn
# @LastEditTime: 2022-09-14 10:03:44
# @FilePath: /hatf/tests/function/test_003_memory.sh
# @Description: 确认内存参数是否正确
###
test_memory_rank() {
    local title="memory_rank"
    local case_id="0031"
    local MEMORY_RANKS
    MEMORY_RANKS=$(dmidecode -t memory | grep -c "Rank:")

    ((RUN_NUM += 1))

    if (whiptail --title "rank number of memory" --yesno "设备插有 ${MEMORY_RANKS} 根内存条？" 10 50); then
        ((PASS_NUM += 1))
        log_info "内存条数正确"
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "所插内存条数不正确"
    fi
}

test_memory_single_size() {
    local title="single_size"
    local case_id="0032"
    local SINGLE_MEMORY_SIZE
    SINGLE_MEMORY_SIZE=$(dmidecode -t memory | grep -E "(^\s*)Size: (.+)(MB$)" | uniq | awk '{print$2}')

    ((RUN_NUM += 1))

    if (whiptail --title "single size of memory" --yesno "每根内存条容量是 ${SINGLE_MEMORY_SIZE} MB?" 10 50); then
        ((PASS_NUM += 1))
        log_info "内存条容量正确"
    else
        fail_id[${title}]=${case_id}
        log_err "所插内存条数不正确"
        log_err "所插内存容量不正确"
    fi
}

test_memory() {
    log_info "Start to test the memory status ..."

    whiptail --title "Tips" --msgbox "开始内存状态测试，请确保所有内存型号、容量相同！" 10 50

    test_memory_rank
    test_memory_single_size

    log_info "Stop testing the memory status ..."
}
