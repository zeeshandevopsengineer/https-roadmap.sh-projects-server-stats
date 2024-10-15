#!/bin/bash

# Server performance stats script
# Save output to a file with a timestamp
output="server-stats-$(date +"%Y%m%d_%H%M%S").log"

# Collect uptime information
echo "===== UPTIME =====" >> $output
uptime >> $output
echo >> $output

# Collect CPU stats
echo "===== CPU STATISTICS =====" >> $output
echo "top output:" >> $output
top -bn1 | head -n 20 >> $output
echo >> $output

echo "mpstat (CPU usage per core):" >> $output
mpstat -P ALL 1 1 >> $output
echo >> $output

# Collect memory usage stats
echo "===== MEMORY USAGE =====" >> $output
echo "free command output:" >> $output
free -h >> $output
echo >> $output

echo "Detailed memory info (/proc/meminfo):" >> $output
cat /proc/meminfo >> $output
echo >> $output

# Collect disk I/O stats
echo "===== DISK I/O STATISTICS =====" >> $output
echo "iostat output:" >> $output
iostat -x 1 1 >> $output
echo >> $output

echo "iotop (Top I/O consuming processes):" >> $output
sudo iotop -b -n 3 | head -n 20 >> $output
echo >> $output

# Collect network usage stats
echo "===== NETWORK USAGE =====" >> $output
echo "nload output:" >> $output
nload -m | head -n 20 >> $output
echo >> $output

echo "iftop output (Top network traffic consumers):" >> $output
sudo iftop -t -s 10 | head -n 20 >> $output
echo >> $output

# Collect system load stats
echo "===== SYSTEM LOAD =====" >> $output
echo "sar output:" >> $output
sar 1 3 >> $output
echo >> $output

echo "vmstat output:" >> $output
vmstat 1 3 >> $output
echo >> $output

# Collect disk space usage stats
echo "===== DISK SPACE USAGE =====" >> $output
echo "df -h output:" >> $output
df -h >> $output
echo >> $output

echo "du -sh (disk usage in /home directory):" >> $output
du -sh /home >> $output
echo >> $output

# Collect process information
echo "===== TOP PROCESSES =====" >> $output
echo "ps aux (All running processes):" >> $output
ps aux --sort=-%cpu | head -n 20 >> $output
echo >> $output

echo "===== SERVER STATS REPORT COMPLETED =====" >> $output

# Output the location of the report
echo "Report saved to $output"
