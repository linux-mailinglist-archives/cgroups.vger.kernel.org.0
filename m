Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91D5B14B3F9
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2020 13:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgA1MIP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Jan 2020 07:08:15 -0500
Received: from mx1.didichuxing.com ([111.202.154.82]:27626 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726034AbgA1MIP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Jan 2020 07:08:15 -0500
X-ASG-Debug-ID: 1580212307-0e40884f7114c6b60001-hhPYk8
Received: from mail.didiglobal.com (localhost [172.20.36.211]) by bsf01.didichuxing.com with ESMTP id R9yMF6uTCF5epFXQ; Tue, 28 Jan 2020 19:51:47 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 19:51:47 +0800
Date:   Tue, 28 Jan 2020 19:51:42 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <keith.busch@intel.com>,
        <minwoo.im.dev@gmail.com>, <tglx@linutronix.de>,
        <edmund.nadolski@intel.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: [PATCH v4 0/5] Add support Weighted Round Robin for blkcg and nvme
Message-ID: <cover.1580211965.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v4 0/5] Add support Weighted Round Robin for blkcg and nvme
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, keith.busch@intel.com, minwoo.im.dev@gmail.com,
        tglx@linutronix.de, edmund.nadolski@intel.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS01.didichuxing.com (172.20.36.235) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.211]
X-Barracuda-Start-Time: 1580212307
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 5838
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -0.92
X-Barracuda-Spam-Status: No, SCORE=-0.92 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FB_GET_MEDS, FB_GET_MEDS_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.79617
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 FB_GET_MEDS            BODY: Looks like trying to sell meds
        1.10 FB_GET_MEDS_2          Looks like trying to sell meds
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

This series try to add Weighted Round Robin for block cgroup and nvme
driver. When multiple containers share a single nvme device, we want
to protect IO critical container from not be interfernced by other
containers. We add blkio.wrr interface to user to control their IO
priority. The blkio.wrr accept five level priorities, which contains
"urgent", "high", "medium", "low" and "none", the "none" is used for
disable WRR for this cgroup.

The first patch add an WRR infrastucture for block cgroup.

We add extra four hareware contexts at blk-mq layer,
HCTX_TYPE_WRR_URGETN/HIGH/MEDIUM/LOW to allow device driver maps
different hardsware queues to dirrenct hardware context.

The second patch add a nvme_ctrl_ops named get_ams to get the expect
Arbitration Mechanism Selected, now this series only support nvme-pci.
This operations will check both CAP.AMS and nvme-pci wrr queue count,
to decide enable WRR or RR.

The third patch rename write_queues module parameter to read_queues,
that can simplify the calculation the number of defaut,read,poll,wrr
queue.

The fourth patch skip the empty affinity set, because nvme may have
7 affinity sets, and some affinity set may be empty.

The last patch add support nvme-pci Weighted Round Robin with Urgent
Priority Class, we add four module paranmeters as follow:
	wrr_urgent_queues
	wrr_high_queues
	wrr_medium_queues
	wrr_low_queues
nvme-pci will set CC.AMS=001b, if CAP.AMS[17]=1 and wrr_xxx_queues
larger than 0. nvme driver will split hardware queues base on the
read/pool/wrr_xxx_queues, then set proper value for Queue Priority
(QPRIO) in DWORD11.

fio test:

CPU:	Intel(R) Xeon(R) Platinum 8160 CPU @ 2.10GHz
NVME:	Intel SSDPE2KX020T8 P4510 2TB

[root@tmp-201812-d1802-818396173 low]# nvme show-regs /dev/nvme0n1
cap     : 2078030fff
version : 10200
intms   : 0
intmc   : 0
cc      : 460801
csts    : 1
nssr    : 0
aqa     : 1f001f
asq     : 5f7cc08000
acq     : 5f5ac23000
cmbloc  : 0
cmbsz   : 0

Run fio-1, fio-2, fio-3 in parallel, 

For RR(round robin) these three fio nearly get same iops or bps,
if we set blkio.wrr for different priority, the WRR "high" will
get more iops/bps than "medium" and "low".

RR:
fio-1: echo "259:0 none" > /sys/fs/cgroup/blkio/high/blkio.wrr
fio-2: echo "259:0 none" > /sys/fs/cgroup/blkio/medium/blkio.wrr
fio-3: echo "259:0 none" > /sys/fs/cgroup/blkio/low/blkio.wrr

WRR:
fio-1: echo "259:0 high" > /sys/fs/cgroup/blkio/high/blkio.wrr
fio-2: echo "259:0 medium" > /sys/fs/cgroup/blkio/medium/blkio.wrr
fio-3: echo "259:0 low" > /sys/fs/cgroup/blkio/low/blkio.wrr

Test script:
https://github.com/dublio/nvme-wrr/blob/master/test_wrr.sh

Test result:
randread             (RR)IOPS        (RR)latency     (WRR)IOPS       (WRR)latency
--------------------------------------------------------------------------------
randread_high        217474          3528.49         404451          1897.17
randread_medium      217473          3528.56         202349          3793.54
randread_low         217978          3520.98         67419           11386.43

randwrite            (RR)IOPS        (RR)latency     (WRR)IOPS       (WRR)latency
--------------------------------------------------------------------------------
randwrite_high       144946          5295.34         277401          2766.66
randwrite_medium     144861          5296.85         138710          5532.28
randwrite_low        145105          5289.36         46316           16569.54

read                 (RR)BW          (RR)latency     (WRR)BW         (WRR)latency
--------------------------------------------------------------------------------
read_high            956191          410823.48       1790273         219427.11
read_medium          920096          426887.25       897644          437760.17
read_low             928076          423248.05       302899          1297195.34

write                (RR)BW          (RR)latency     (WRR)BW         (WRR)latency
--------------------------------------------------------------------------------
write_high           737211          532359.31       1194013         328970.70
write_medium         759052          516902.66       600626          653876.69
write_low            782348          501309.47       203754          1928779.39

Changes since V3:
 * only show blkio.wrr in non-root cgroups.
 * give bs/iops and latency in test result.

Changes since V2:
 * drop null_blk related patch, which adds a new NULL_Q_IRQ_WRR to
	simulte nvme wrr policy
 * add urgent tagset map for nvme driver
 * fix some problem in V2, suggested by Minwoo

Changes since V1:
 * reorder HCTX_TYPE_POLL to the last one to adopt nvme driver easily.
 * add support WRR(Weighted Round Robin) for nvme driver


Weiping Zhang (5):
  block: add weighted round robin for blkcgroup
  nvme: add get_ams for nvme_ctrl_ops
  nvme-pci: rename module parameter write_queues to read_queues
  genirq/affinity: allow driver's discontigous affinity set
  nvme: add support weighted round robin queue

 block/blk-cgroup.c         |  91 +++++++++++++++++
 block/blk-mq-debugfs.c     |   4 +
 block/blk-mq-sched.c       |   5 +-
 block/blk-mq-tag.c         |   4 +-
 block/blk-mq-tag.h         |   2 +-
 block/blk-mq.c             |  12 ++-
 block/blk-mq.h             |  20 +++-
 block/blk.h                |   2 +-
 drivers/nvme/host/core.c   |   9 +-
 drivers/nvme/host/nvme.h   |   2 +
 drivers/nvme/host/pci.c    | 250 ++++++++++++++++++++++++++++++++++++---------
 include/linux/blk-cgroup.h |   2 +
 include/linux/blk-mq.h     |  18 ++++
 include/linux/interrupt.h  |   2 +-
 include/linux/nvme.h       |   3 +
 kernel/irq/affinity.c      |   4 +
 16 files changed, 369 insertions(+), 61 deletions(-)

-- 
2.14.1

