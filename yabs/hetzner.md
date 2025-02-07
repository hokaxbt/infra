```
curl -sL https://raw.githubusercontent.com/masonr/yet-another-bench-script/refs/heads/master/yabs.sh | bash -s -- -g
```

```
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #
#              Yet-Another-Bench-Script              #
#                     v2025-01-01                    #
# https://github.com/masonr/yet-another-bench-script #
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #

Fri Feb  7 02:09:59 PM CET 2025

Basic System Information:
---------------------------------
Uptime     : 0 days, 3 hours, 58 minutes
Processor  : Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz
CPU cores  : 8 @ 4092.767 MHz
AES-NI     : ✔ Enabled
VM-x/AMD-V : ✔ Enabled
RAM        : 62.6 GiB
Swap       : 0.0 KiB
Disk       : 468.2 GiB
Distro     : Ubuntu 24.04.1 LTS
Kernel     : 6.8.0-52-generic
VM Type    : NONE
IPv4/IPv6  : ✔ Online / ✔ Online

IPv6 Network Information:
---------------------------------
ISP        : Hetzner Online GmbH
ASN        : AS24940 Hetzner Online GmbH
Host       : Hetzner
Location   : Nuremberg, Bavaria (BY)
Country    : Germany

fio Disk Speed Tests (Mixed R/W 50/50) (Partition /dev/mapper/ubuntu--vg-root):
---------------------------------
Block Size | 4k            (IOPS) | 64k           (IOPS)
  ------   | ---            ----  | ----           ----
Read       | 391.32 MB/s  (97.8k) | 869.70 MB/s  (13.5k)
Write      | 392.36 MB/s  (98.0k) | 874.28 MB/s  (13.6k)
Total      | 783.68 MB/s (195.9k) | 1.74 GB/s    (27.2k)
           |                      |
Block Size | 512k          (IOPS) | 1m            (IOPS)
  ------   | ---            ----  | ----           ----
Read       | 456.30 MB/s    (891) | 508.15 MB/s    (496)
Write      | 480.55 MB/s    (938) | 541.99 MB/s    (529)
Total      | 936.85 MB/s   (1.8k) | 1.05 GB/s     (1.0k)

iperf3 Network Speed Tests (IPv4):
---------------------------------
Provider        | Location (Link)           | Send Speed      | Recv Speed      | Ping
-----           | -----                     | ----            | ----            | ----
Clouvider       | London, UK (10G)          | 815 Mbits/sec   | 928 Mbits/sec   | 19.3 ms
Eranium         | Amsterdam, NL (100G)      | 825 Mbits/sec   | 937 Mbits/sec   | 10.2 ms
Uztelecom       | Tashkent, UZ (10G)        | 778 Mbits/sec   | 580 Mbits/sec   | 104 ms
Leaseweb        | Singapore, SG (10G)       | 704 Mbits/sec   | 578 Mbits/sec   | 166 ms
Clouvider       | Los Angeles, CA, US (10G) | 715 Mbits/sec   | 306 Mbits/sec   | 162 ms
Leaseweb        | NYC, NY, US (10G)         | 769 Mbits/sec   | 696 Mbits/sec   | 92.9 ms
Edgoo           | Sao Paulo, BR (1G)        | 649 Mbits/sec   | 268 Mbits/sec   | 195 ms

iperf3 Network Speed Tests (IPv6):
---------------------------------
Provider        | Location (Link)           | Send Speed      | Recv Speed      | Ping
-----           | -----                     | ----            | ----            | ----
Clouvider       | London, UK (10G)          | 810 Mbits/sec   | 911 Mbits/sec   | 19.3 ms
Eranium         | Amsterdam, NL (100G)      | 815 Mbits/sec   | 924 Mbits/sec   | 10.2 ms
Uztelecom       | Tashkent, UZ (10G)        | 765 Mbits/sec   | 623 Mbits/sec   | 104 ms
Leaseweb        | Singapore, SG (10G)       | 695 Mbits/sec   | 573 Mbits/sec   | 166 ms
Clouvider       | Los Angeles, CA, US (10G) | 699 Mbits/sec   | 551 Mbits/sec   | 161 ms
Leaseweb        | NYC, NY, US (10G)         | 760 Mbits/sec   | 632 Mbits/sec   | 93.0 ms
Edgoo           | Sao Paulo, BR (1G)        | 644 Mbits/sec   | 379 Mbits/sec   | 195 ms
```
