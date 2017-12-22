#!/bin/bash

#
# Linux Shell Scripting Task #2
# Limitations: Ubuntu Only
# John Thomason
#

# Trap Ctrl-C
trap abort SIGINT

# Vars
pkg_search="x"
file_search="x"
username="x"
groupname="x"
pid="x"

# Functions
function abort {

  echo -e "\nBaBye!\n"
  exit 0

}

function usage {
  echo -e "\nUsage: $0 [-L <pkg_to_search>] [-S <file_path>] [-U <username>] [-G <groupname>] [-P <pid_to_kill>]"
  abort
}

# verify passed arguments
[ $# -lt 2 ] && usage

# Parse CLI
while [ "${1}x" != "x" ]; do
  case $1
    in
    --help|-h)
      usage
    ;;
    -L|-l)
      shift
      pkg_search=$1
    ;;
    -S|-s)
      shift
      file_search=$1
    ;;
    -U|-u)
      shift
      username=$1
    ;;
    -G|-g)
      shift
      groupname=$1
    ;;
    -P|-p)
      shift
      pid=$1
    ;;
    *)
      echo -e "\nERROR: \"$1\" is an invalid option"
      usage
    ;;
  esac
  shift
done

# Title
echo -e "\nLinux Shell Scripting Task #2"

#Please verify the below items based on input:
#
# List the files installed by specific package
[ $pkg_search == "x" ] || dpkg-query -L $pkg_search

# Identify the package which installed the specific file in system
[ $file_search == "x" ] || dpkg-query -S $file_search

# If user/group name provided, please check the user or group exist

# Got User???
if [ $username  != "x" ]; then
  grep $username /etc/passwd &> /dev/null
  if [ $? -eq 0 ]; then
    echo -e "\nUser \"$username\" Exists on this system!"
  else
    echo -e "\nUser \"$username\" Does Not Exist on this system :-{"
  fi
fi

# Got Group???
if [ $groupname != "x" ]; then
  grep $groupname /etc/group &> /dev/null
  if [ $? -eq 0 ]; then
    echo -e "\nGroup \"$groupname\" Exists on this system!"
  else
    echo -e "\nGroup \"$groupname\" Does Not Exist on this system :-{"
  fi
fi

# Kill any user provided process if it exists
if [ $pid != "x" ]; then
  ps -eo pid | grep "${pid}$"
  if [ $? -eq 0 ]; then
    echo -e "\nKilling PID: ${pid}...\c"
    kill $pid &> /dev/null
    if [ $? -eq 0 ]; then
      echo -e "Success!"
    else
      echo -e "Failed!"
    fi
  else
    echo -e "\nPID: $pid is Not Valid :-{"
  fi
fi

# Create cron job using shell script
(crontab -l ; echo "0 0 * * * /bin/df -ah > /tmp/diskfree.txt") | sort - | uniq - | crontab -

abort

