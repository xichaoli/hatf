#!/bin/bash
###
 # @Author: xichaoli xichaoli@sina.cn
 # @Date: 2022-08-19 14:56:03
 # @LastEditors: xichaoli xichaoli@sina.cn
 # @LastEditTime: 2022-08-19 16:01:15
 # @FilePath: /hatf/libs/log
 # @Description: 日志模块，同时输出到stdout和文件。
### 

#日志级别 debug-1, info-2, warn-3, error-4, always-5
LOG_LEVEL=2

#日志文件
LOG_FILE=${PROJECT_TOP}/logs/${DUT_MODEL}-${UNIT_SELECTED}-${TIME_STR}.log
export LOG_FILE
touch "${LOG_FILE}"

#调试日志
function log_debug(){
  content="[DEBUG] $(date '+%Y-%m-%d %H:%M:%S') $*"
  [ $LOG_LEVEL -le 1  ] && echo "$content" >> "$LOG_FILE" && echo -e "\033[32m"  "${content}"  "\033[0m"
}
#信息日志
function log_info(){
  content="[INFO] $(date '+%Y-%m-%d %H:%M:%S') $*"
  [ $LOG_LEVEL -le 2  ] && echo "$content" >> "$LOG_FILE" && echo -e "\033[32m"  "${content}" "\033[0m"
}
#警告日志
function log_warn(){
  content="[WARN] $(date '+%Y-%m-%d %H:%M:%S') $*"
  [ $LOG_LEVEL -le 3  ] && echo "$content" >> "$LOG_FILE" && echo -e "\033[33m" "${content}" "\033[0m"
}
#错误日志
function log_err(){
  content="[ERROR] $(date '+%Y-%m-%d %H:%M:%S') $*"
  [ $LOG_LEVEL -le 4  ] && echo "$content" >> "$LOG_FILE" && echo -e "\033[31m" "${content}" "\033[0m"
}
#一直都会打印的日志
function log_always(){
   content="[ALWAYS] $(date '+%Y-%m-%d %H:%M:%S') $*"
   [ $LOG_LEVEL -le 5  ] && echo "$content" >> "$LOG_FILE" && echo -e  "\033[32m" "${content}" "\033[0m"
}
