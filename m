Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F561B8F69
	for <lists+cgroups@lfdr.de>; Sun, 26 Apr 2020 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDZLWA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Apr 2020 07:22:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2913 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726122AbgDZLWA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 26 Apr 2020 07:22:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 831E4FD2101CB4A16730;
        Sun, 26 Apr 2020 19:21:57 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.99) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 19:21:48 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
Subject: memleak in cgroup
To:     <tj@kernel.org>, <lizefan@huawei.com>, <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yangyingliang@huawei.com>, <wangkefeng.wang@huawei.com>
Message-ID: <6e4d5208-ba26-93ed-c600-4776fc620456@huawei.com>
Date:   Sun, 26 Apr 2020 19:21:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.99]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

When I doing the follow test in kernel-5.7-rc2, I found mem-free is 
decreased

#!/bin/sh
cd /sys/fs/cgroup/memory/

for((i=0;i<45;i++))
do
         for((j=0;j<60000;j++))
         do
                 mkdir /sys/fs/cgroup/memory/yyl-cg$j
         done
         sleep 1
         ls /sys/fs/cgroup/memory/ | grep yyl | xargs rmdir
done


before test the /proc/meminfo is:

MemTotal:       493554824 kB
MemFree:        491240912 kB
MemAvailable:   489424520 kB
Buffers:            4112 kB
Cached:            65400 kB
SwapCached:            0 kB
Active:           156016 kB
Inactive:          37720 kB
Active(anon):     128372 kB
Inactive(anon):     7188 kB
Active(file):      27644 kB
Inactive(file):    30532 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:               112 kB
Writeback:             0 kB
AnonPages:        124356 kB
Mapped:            53724 kB
Shmem:             11036 kB
KReclaimable:      93488 kB
Slab:             599660 kB
SReclaimable:      93488 kB
SUnreclaim:       506172 kB
KernelStack:       23008 kB
PageTables:         4340 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    250971712 kB
Committed_AS:    1834448 kB
VmallocTotal:   135290159040 kB
VmallocUsed:      229284 kB
VmallocChunk:          0 kB
Percpu:            80896 kB
HardwareCorrupted:     0 kB
AnonHugePages:     43008 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
CmaTotal:          65536 kB
CmaFree:           40480 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB

after test:
MemTotal:       493554824 kB
MemFree:        484492920 kB
MemAvailable:   482801124 kB
Buffers:           21984 kB
Cached:           151380 kB
SwapCached:            0 kB
Active:           230000 kB
Inactive:          68068 kB
Active(anon):     130108 kB
Inactive(anon):    13804 kB
Active(file):      99892 kB
Inactive(file):    54264 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:                36 kB
Writeback:             0 kB
AnonPages:        125080 kB
Mapped:            55520 kB
Shmem:             19220 kB
KReclaimable:     246696 kB
Slab:            5381572 kB
SReclaimable:     246696 kB
SUnreclaim:      5134876 kB
KernelStack:       27360 kB
PageTables:         4172 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    250971712 kB
Committed_AS:    1588600 kB
VmallocTotal:   135290159040 kB
VmallocUsed:      230836 kB
VmallocChunk:          0 kB
Percpu:          1827840 kB
HardwareCorrupted:     0 kB
AnonHugePages:     43008 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
CmaTotal:          65536 kB
CmaFree:           40480 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB

after echo 3 > /proc/sys/vm/drop_caches
MemTotal:       493554824 kB
MemFree:        485104048 kB
MemAvailable:   483358392 kB
Buffers:            6168 kB
Cached:            79904 kB
SwapCached:            0 kB
Active:           165348 kB
Inactive:          45780 kB
Active(anon):     130528 kB
Inactive(anon):    13800 kB
Active(file):      34820 kB
Inactive(file):    31980 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:       4194300 kB
SwapFree:        4194300 kB
Dirty:                 8 kB
Writeback:             0 kB
AnonPages:        125236 kB
Mapped:            55516 kB
Shmem:             19220 kB
KReclaimable:     226332 kB
Slab:            5353952 kB
SReclaimable:     226332 kB
SUnreclaim:      5127620 kB
KernelStack:       23040 kB
PageTables:         4212 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    250971712 kB
Committed_AS:    1672424 kB
VmallocTotal:   135290159040 kB
VmallocUsed:      230436 kB
VmallocChunk:          0 kB
Percpu:          1379840 kB
HardwareCorrupted:     0 kB
AnonHugePages:     43008 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
FileHugePages:         0 kB
FilePmdMapped:         0 kB
CmaTotal:          65536 kB
CmaFree:           40480 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
Hugetlb:               0 kB

after test and drop caches, the /proc/cgroups is:
#subsys_name    hierarchy       num_cgroups     enabled
cpuset  11      1       1
cpu     2       1       1
cpuacct 2       1       1
blkio   8       1       1
memory  5       83      1
devices 3       41      1
freezer 6       1       1
net_cls 9       1       1
perf_event      10      1       1
net_prio        9       1       1
hugetlb 4       1       1
pids    7       51      1
rdma    12      1       1

All the dir that created by the script is already removed, but I got:
  - MemFree is decreased about 6.7G
  - SUnreclaim is increased about 4.6G
  - Percpu is increased about 1.7G

It seems we have memory leak in cgroup ?

