#
# Linux Shell Scripting Task #1
#

# Functions
#
# Number of Packages Installed
# List of Installed Packages
function packages {
  util=$1
  echo -e "Number of Packages: \c"
  $util 2> /dev/null | wc -l

  echo -e "\nList of Installed Packages:"
  $util 2> /dev/null

  return
}

# Title
echo -e "\nLinux Shell Scipting Task 1\n"


# Number of CPU(s)
echo -e "Number of CPU(s): \c"
grep -c ^processor /proc/cpuinfo


# Total Memory
# Total Available Memory
echo -e "\nMemory:"
free -hw | grep ^Mem | awk '{print "Total: "$2"\nAvailable: "$4}'


# OS Name and its version
osname=$(cat /etc/*-release | grep ^NAME= | cut -d'"' -f2)
osver=$(cat /etc/*-release | grep ^VERSION= | cut -d'"' -f2)

echo -e "\nOS Name: $osname\nOS Ver: $osver\n"

# Disk information
echo "Disk Information:"
lsblk


# Partition wise free space available
echo -e "\nDisk Partitions & Free Space:"
df -h | grep ^/dev


# IP Address Information
echo -e "\nIPv4 Addressing:"
ip -4 address show


# Packages
echo -e "\nOS: \c"
case "$osname"
  in
  CentOS)
    echo $osname 
    packages "yum list"
  ;;
  Red*Hat*)
    echo $osname
    packages "yum list"
  ;;
  Fedora)
    echo $osname
    packages "yum list"
  ;;
  Ubuntu)
    echo $osname
    packages "dpkg-query -l"
  ;;
  Debian)
    echo $osname
    packages "dpkg-query -l"
  ;;
  Mint)
    echo $osname
    packages "dpkg-query -l"
  ;;
esac


# List the ongoing process on the machine
echo -e "\nCurrent processes:"
ps -ef

