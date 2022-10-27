# README

This repository contains the new slow start algorithm that: 1) uses
ack-pairs to estimate the bandwidth, and 2) correspondingly sets the
ssthresh based on the bandwidth estimate and the round-trip time.

## Dependency 

To build the Linux kernel source installed.

Ubuntu:

1. sudo apt-get install linux-source

Raspberry Pi:

1a. Run rpi-update (https://github.com/Hexxeh/rpi-update)

1b. Install and run rpi-source (https://github.com/RPi-Distro/rpi-source)

The kernel needs to be recompiled with a larger `ICSK_CA_PRIV_SIZE`.
Edit:

`include/net/inet_connection_sock.h`

and for these lines:

````
  u64                       icsk_ca_priv[104 / sizeof(u64)];
  
  #define ICSK_CA_PRIV_SIZE      (13 * sizeof(u64))
````

change the number `104` to `2800` and `13` to `350`.  Then rebuild and reboot the kernel normally.



## Build

1. Test modules work via the Hello World kernel module
(https://github.com/RPi-Distro/rpi-source#hello-world-example).

2. Then, type 'make'


## Helpful Commands

Check available congestion control algs:

    sysctl net.ipv4.tcp_available_congestion_control

Check current congestion control alg:

    cat /proc/sys/net/ipv4/tcp_congestion_control

Set current congestion control alg:

    sudo sh -c "echo 'cubic_bw' > /proc/sys/net/ipv4/tcp_congestion_control"

Load a module:

    sudo insmod tcp_cubic_bw.ko

Load a module (here, setting the `debug` parameter):

    sudo insmod tcp_cubic_bw.ko debug=1

Unload a module:

    sudo rmmod tcp_cubic_bw
	
Disable hystart:

    sudo sh -c "echo 0 > /sys/module/tcp_cubic/parameters/hystart"

See also `bin/` directory for utilities.

----------------

