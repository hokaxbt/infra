```
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #
#              Yet-Another-Bench-Script              #
#                     v2025-01-01                    #
# https://github.com/masonr/yet-another-bench-script #
# ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## #

Fri Feb  7 02:06:16 PM CET 2025

Basic System Information:
---------------------------------
Uptime     : 0 days, 0 hours, 17 minutes
Processor  : AMD EPYC 9634 84-Core Processor
CPU cores  : 4 @ 2246.624 MHz
AES-NI     : ✔ Enabled
VM-x/AMD-V : ❌ Disabled
RAM        : 7.7 GiB
Swap       : 0.0 KiB
Disk       : 9.7 GiB
Distro     : Ubuntu 24.04.1 LTS
Kernel     : 6.8.0-52-generic
VM Type    : KVM
IPv4/IPv6  : ✔ Online / ✔ Online

IPv6 Network Information:
---------------------------------
ISP        : netcup GmbH
ASN        : AS214996 netcup GmbH
Host       : Netcup KVM MNZ
Location   : Manassas, Virginia (VA)
Country    : United States

fio Disk Speed Tests (Mixed R/W 50/50) (Partition /dev/vda3):
---------------------------------
Block Size | 4k            (IOPS) | 64k           (IOPS)
  ------   | ---            ----  | ----           ----
Read       | 225.59 MB/s  (56.3k) | 486.42 MB/s   (7.6k)
Write      | 226.18 MB/s  (56.5k) | 488.98 MB/s   (7.6k)
Total      | 451.77 MB/s (112.9k) | 975.41 MB/s  (15.2k)
           |                      |
Block Size | 512k          (IOPS) | 1m            (IOPS)
  ------   | ---            ----  | ----           ----
Read       | 534.50 MB/s   (1.0k) | 706.42 MB/s    (689)
Write      | 562.90 MB/s   (1.0k) | 753.47 MB/s    (735)
Total      | 1.09 GB/s     (2.1k) | 1.45 GB/s     (1.4k)

iperf3 Network Speed Tests (IPv4):
---------------------------------
Provider        | Location (Link)           | Send Speed      | Recv Speed      | Ping
-----           | -----                     | ----            | ----            | ----
Clouvider       | London, UK (10G)          | 1.96 Gbits/sec  | 1.07 Gbits/sec  | 75.3 ms
Eranium         | Amsterdam, NL (100G)      | 2.38 Gbits/sec  | 2.19 Gbits/sec  | 91.0 ms
Uztelecom       | Tashkent, UZ (10G)        | 1.29 Gbits/sec  | 1.00 Gbits/sec  | 169 ms
Leaseweb        | Singapore, SG (10G)       | busy            | 1.21 Gbits/sec  | 229 ms
Clouvider       | Los Angeles, CA, US (10G) | 1.09 Gbits/sec  | 1.75 Gbits/sec  | 61.3 ms
Leaseweb        | NYC, NY, US (10G)         | 2.70 Gbits/sec  | 2.38 Gbits/sec  | 7.43 ms
Edgoo           | Sao Paulo, BR (1G)        | 1.30 Gbits/sec  | 1.60 Gbits/sec  | 133 ms

iperf3 Network Speed Tests (IPv6):
---------------------------------
Provider        | Location (Link)           | Send Speed      | Recv Speed      | Ping
-----           | -----                     | ----            | ----            | ----
Clouvider       | London, UK (10G)          | 1.54 Gbits/sec  | 983 Mbits/sec   | 75.7 ms
Eranium         | Amsterdam, NL (100G)      | 800 Mbits/sec   | 2.19 Gbits/sec  | 91.1 ms
Uztelecom       | Tashkent, UZ (10G)        | 1.05 Gbits/sec  | 711 Mbits/sec   | 168 ms
Leaseweb        | Singapore, SG (10G)       | 980 Mbits/sec   | 1.81 Gbits/sec  | --
Clouvider       | Los Angeles, CA, US (10G) | 1.80 Gbits/sec  | 1.77 Gbits/sec  | 61.1 ms
Leaseweb        | NYC, NY, US (10G)         | 2.59 Gbits/sec  | 2.34 Gbits/sec  | --
Edgoo           | Sao Paulo, BR (1G)        | 1.10 Gbits/sec  | 1.03 Gbits/sec  | 133 ms
```
