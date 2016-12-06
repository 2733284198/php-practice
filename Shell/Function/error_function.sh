#!/bin/bash
#
# Perform hot backups of Oracle databases
#export PATH='/usr/xpg4/bin:/usr/bin:/opt/csw/bin:/opt/goog/bin'
TIME=$(date '+%Y-%m-%d %H:%M:%S')
#######################################
# Eroor file function
# Globals:
#   BACKUP_DIR
#   ORACLE_SID
# Arguments:
#   None
# Returns:
#   None
#######################################
err() {
    echo "[${TIME}]: $@" >&2
}
#######################################
# Debug file function
# Globals:
#   BACKUP_DIR
#   ORACLE_SID
# Arguments:
#   None
# Returns:
#   None
#######################################
debug() {
    echo "[${TIME}]: $@" >&2
}

# DO use 'here document's

# Embedded newlines are ok too
long_string="I am an exceptionally
  long string."

# All fits on one line
#command1 | command2

# Long commands
#command1 \
#  | command2 \
#  | command3 \
#   | command4

# 请将 ; do , ; then 和 while , for , if 放在同一行。
#for dir in ${dirs_to_cleanup}; do
#  if [[ -d "${dir}/${ORACLE_SID}" ]]; then
#    log_date "Cleaning up old files in ${dir}/${ORACLE_SID}"
#    rm "${dir}/${ORACLE_SID}/"*
#    if [[ "$?" -ne 0 ]]; then
#      error_message
#    fi
#  else
#    mkdir -p "${dir}/${ORACLE_SID}"
#    if [[ "$?" -ne 0 ]]; then
#      error_message
#    fi
#  fi
#done

##################################
# 命名转换
##################################
###################################
# [函数名]
#	使用小写字母，并用下划线分隔单词。使用双冒号 :: 分隔库。函数名之后必须有圆括号。
#	关键词 function 是可选的，但必须在一个项目中保持一致。
# 	当函数名后存在 () 时，关键词 function 是多余的。但是其促进了函数的快速辨识。
function my_func() {
  echo 'function'
}

#################################
# [变量名]
# 循环的变量名应该和循环的任何变量同样命名。
for zone in ${zones}; do
  something_with "${zone}"
done

#################################
# [常量和环境变量名]
# 全部大写，用下划线分隔，声明在文件的顶部
# Constant
readonly PATH_TO_FILES='/some/path'

# Both constant and environment
declare -xr ORACLE_SID='PROD'

#################################
# [使用本地变量]
# 使用 local 来声明局部变量以确保其只在函数内部和子函数中可见。这避免了污染全局命名空间和不经意间设置可能具有函数之外重要性的变量。
my_func2() {
  local name="$1"

  # Separate lines for declaration and assignment:
  local my_var
  my_var="$(my_func)" || return

  # DO NOT do this: $? contains the exit code of 'local', not my_func
  local my_var="$(my_func)"
  [[ $? -eq 0 ]] || return

  ...
}




















ERROR='E_DID_NOTHING'
if [[ -z "${ALLKEY}" ]]; then
    err "Unable to do_something"
    exit 1
fi
