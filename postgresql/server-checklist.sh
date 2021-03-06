#!/usr/bin/env bash
# Description:	Check server system parameters

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

# Memory & Swap
echo "=== memory: free ===
$(grep -E "^(Mem|Swap)Total:" /proc/meminfo |sed -e 's/^/   /g')"

# Virtual Memory checks
echo "=== sysctl: virtual memory ===
   $(sysctl vm.dirty_background_bytes)
   $(sysctl vm.dirty_bytes)
   $(sysctl vm.dirty_background_ratio)
   $(sysctl vm.dirty_ratio)
   $(sysctl vm.swappiness)
   $(sysctl vm.overcommit_memory)
   $(sysctl vm.overcommit_ratio)"

# NUMA checks
echo "=== sysctl: numa related ===
   $(sysctl vm.zone_reclaim_mode)"

# Transparent Hugepages check
echo "=== sysfs: transparent hugepages ===
   /sys/kernel/mm/transparent_hugepage/enabled: $(cat /sys/kernel/mm/transparent_hugepage/enabled)
   /sys/kernel/mm/transparent_hugepage/defrag: $(cat /sys/kernel/mm/transparent_hugepage/defrag)"

# Ntpd or Ntpdate check
echo "=== Ntpd info ==="
if which ntpd &>/dev/null
  then 
    if [[ $(ps ho comm -C ntpd) == *ntpd* ]]
       then echo "   Ntpd found and running."
       else echo "   Ntpd found, but not running."
    fi
  else echo "   Ntpd not found."
fi
