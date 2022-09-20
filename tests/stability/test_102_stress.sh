#!/bin/bash
###
# @Author: xichaoli xichaoli@sina.cn
# @Date: 2022-08-19 17:12:32
 # @LastEditors: xichaoli xichao@sina.cn
 # @LastEditTime: 2022-09-14 10:12:27
# @FilePath: /hatf/tests/stability/test_memory
# @Description: 使用 stress 系统稳定性压力测试
###

test_stress() {
    log_info "Start stress test ..."

    local title="stress"
    local case_id="1021"

    local CPU_PROCESSES
    CPU_PROCESSES=$(
        whiptail --title "Number of processes used when testing CPU" --inputbox \
            "The recommended setting is the number of cpus\n" 10 50 8 3>&1 1>&2 2>&3
    )

    local MEMORY_PROCESSES
    MEMORY_PROCESSES=$(
        whiptail --title "Number of processes used when testing memory" --inputbox \
            "Use memory size require multiply 256MB\n" 10 50 8 3>&1 1>&2 2>&3
    )

    local DISK_PROCESSES
    DISK_PROCESSES=$(
        whiptail --title "Number of processes used when testing disk" --inputbox \
            "Use disk size require multiply 1G\n" 10 50 10 3>&1 1>&2 2>&3
    )

    local IO_PROCESSES
    IO_PROCESSES=$(
        whiptail --title "Number of processes used when testing IO" --inputbox \
            "The recommended setting is the number of cpus\n" 10 50 8 3>&1 1>&2 2>&3
    )

    local TEST_TIME
    TEST_TIME=$(
        whiptail --title "Test duration" --inputbox \
            "The recommended setting is 8h\n" 10 50 8h 3>&1 1>&2 2>&3
    )

    stress --cpu "${CPU_PROCESSES}" --io "${IO_PROCESSES}" --vm "${MEMORY_PROCESSES}" --hdd "${DISK_PROCESSES}" \
        --timeout "${TEST_TIME}" 2>&1 | tee -a "${LOG_FILE}"

    ((RUN_NUM += 1))

    if (whiptail --title "test result" --yesno "测试完成后系统状态是否正常(可用dmesg命令查看)?" 10 50); then
        ((PASS_NUM += 1))
        log_info "stress 测试通过 ..."
    else
        ((FAIL_NUM += 1))
        fail_id[${title}]=${case_id}
        log_err "stress 测试不通过 ..."
    fi
    log_info "End stress test ..."
}
