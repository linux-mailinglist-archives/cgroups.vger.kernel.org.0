Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3E8850DF3
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2019 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfFXO2j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Jun 2019 10:28:39 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:26543 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726749AbfFXO2j (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Jun 2019 10:28:39 -0400
X-ASG-Debug-ID: 1561386513-0e40886efa18f2f0001-hhPYk8
Received: from BJEXCAS01.didichuxing.com (bogon [172.20.36.235]) by bsf01.didichuxing.com with ESMTP id 38F0UmLad1gVDosh; Mon, 24 Jun 2019 22:28:33 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Jun
 2019 22:28:33 +0800
Date:   Mon, 24 Jun 2019 22:28:32 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>, <keith.busch@intel.com>,
        <minwoo.im.dev@gmail.com>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 0/5] Add support Weighted Round Robin for blkcg and nvme
Message-ID: <cover.1561381826.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 0/5] Add support Weighted Round Robin for blkcg and nvme
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, keith.busch@intel.com, minwoo.im.dev@gmail.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.235]
X-Barracuda-Start-Time: 1561386513
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 5318
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0008 1.0000 -2.0158
X-Barracuda-Spam-Score: -0.92
X-Barracuda-Spam-Status: No, SCORE=-0.92 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FB_GET_MEDS, FB_GET_MEDS_2
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.73067
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

rwtest=randread
fio --bs=4k --ioengine=libaio --iodepth=32 --filename=/dev/nvme0n1 --direct=1 --runtime=60 --numjobs=8 --rw=$rwtest --name=test$1 --group_reporting

Randread 4K	RR		WRR
-------------------------------------------------------
fio-1:		220 k		395 k
fio-2:		220 k		197 k
fio-3:		220 k		66  k

rwtest=randwrite
fio --bs=4k --ioengine=libaio --iodepth=32 --filename=/dev/nvme0n1 --direct=1 --runtime=60 --numjobs=8 --rw=$rwtest --name=test$1 --group_reporting

Randwrite 4K	RR		WRR
-------------------------------------------------------
fio-1:		150 k		295 k
fio-2:		150 k		148 k
fio-3:		150 k		51  k

rwtest=read
fio --bs=512k --ioengine=libaio --iodepth=32 --filename=/dev/nvme0n1 --direct=1 --runtime=60 --numjobs=8 --rw=$rwtest --name=test$1 --group_reporting

read 512K	RR		WRR
-------------------------------------------------------
fio-1:		963 MiB/s	1704 MiB/s
fio-2:		950 MiB/s	850  MiB/s
fio-3:		961 MiB/s	284  MiB/s

rwtest=read
fio --bs=512k --ioengine=libaio --iodepth=32 --filename=/dev/nvme0n1 --direct=1 --runtime=60 --numjobs=8 --rw=$rwtest --name=test$1 --group_reporting

write 512K	RR		WRR
-------------------------------------------------------
fio-1:		890 MiB/s	1150 MiB/s
fio-2:		871 MiB/s	595  MiB/s
fio-3:		895 MiB/s	188  MiB/s


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

 block/blk-cgroup.c         |  89 ++++++++++++++++
 block/blk-mq-debugfs.c     |   4 +
 block/blk-mq-sched.c       |   6 +-
 block/blk-mq-tag.c         |   4 +-
 block/blk-mq-tag.h         |   2 +-
 block/blk-mq.c             |  12 ++-
 block/blk-mq.h             |  20 +++-
 block/blk.h                |   2 +-
 drivers/nvme/host/core.c   |   9 +-
 drivers/nvme/host/nvme.h   |   2 +
 drivers/nvme/host/pci.c    | 246 ++++++++++++++++++++++++++++++++++++---------
 include/linux/blk-cgroup.h |   2 +
 include/linux/blk-mq.h     |  14 +++
 include/linux/interrupt.h  |   2 +-
 include/linux/nvme.h       |   3 +
 kernel/irq/affinity.c      |   4 +
 16 files changed, 362 insertions(+), 59 deletions(-)

-- 
2.14.1

