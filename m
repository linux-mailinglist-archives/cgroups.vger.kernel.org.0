Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2E32336C0
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2019 19:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfFCRam (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 13:30:42 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:20529 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1727754AbfFCRal (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 13:30:41 -0400
X-Greylist: delayed 638 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 13:30:31 EDT
X-ASG-Debug-ID: 1559582378-0e410856621d6970001-hhPYk8
Received: from BJEXMBX012.didichuxing.com (bjexmbx012.didichuxing.com [172.20.2.191]) by bsf02.didichuxing.com with ESMTP id bQFo5yPVVShGxBFW; Tue, 04 Jun 2019 01:19:38 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Tue, 4 Jun
 2019 01:19:37 +0800
Date:   Tue, 4 Jun 2019 01:19:36 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [RFC PATCH 0/2] blkcg: add support weighted round robin tagset map
Message-ID: <cover.1559579964.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RFC PATCH 0/2] blkcg: add support weighted round robin tagset map
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexmbx012.didichuxing.com[172.20.2.191]
X-Barracuda-Start-Time: 1559582378
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3114
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0003 1.0000 -2.0191
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.72199
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hi, 

This patchset try to add new tagset map for WRR(weighted round robin),
like what nvme spec dose.

The first patch add three new HCTX_TYPE_WRR_LOW/MEDIUM/HIGH, and
a attribute blkio.wrr to enable different blkcg use different tag map.
If the hardware queue support different priority, the driver can
map high priority hardware queue to HCTX_TYPE_WRR_HIGH.

For high io priority block cgroup, we should change its blio.wrr to high,
echo "major:minor high" > blkio.wrr, that its io can be servied more
quickly. This is useful for different containers share same nvme device,
for important containers use high prioriity hw queue, others use medium
or low priority hw queue.

The second patch, add a WRR for null_blk to simulate what nvme does,
we add a new irqmode=3 to enable NULL_IRQ_WRR, a kernel thread
will processing all haredware queue's io in WRR fasion.

A simpel test result:

we add 32 hw queue in total:
defaut: 8
read: 0
poll: 0
wrr_low: 8
wrr_medium: 8
wrr_high: 8

insmod drivers/block/null_blk.ko irqmode=3 \
	submit_queues=32 submit_queues_wrr_high=8 \
	submit_queues_wrr_medium=8 submit_queues_wrr_low=8
fio --bs=4k --ioengine=libaio --iodepth=16 --filename=/dev/nullb0 --direct=1 --runtime=60 --numjobs=16 --rw=randread --name=test$1 --group_reporting --gtod_reduce=1

check hardware context type:
cat /sys/kernel/debug/block/nullb0/hctx*/type

default
wrr_low
wrr_low
wrr_low
wrr_low
wrr_low
wrr_low
wrr_medium
wrr_medium
wrr_medium
wrr_medium
default
wrr_medium
wrr_medium
wrr_medium
wrr_medium
wrr_high
wrr_high
wrr_high
wrr_high
wrr_high
wrr_high
default
wrr_high
wrr_high
default
default
default
default
default
wrr_low
wrr_low


1. run 3 fio in default hw queue
fio1: 130K
fio2: 130K
fio3: 130K

2. use different hw queue
mkdir /sys/fs/cgroup/blkio/{low,medium, high}
echo "251:0 high" > /sys/fs/cgroup/blkio/high/blkio.wrr
echo "251:0 medium" > /sys/fs/cgroup/blkio/medium/blkio.wrr
echo "251:0 low" > /sys/fs/cgroup/blkio/low/blkio.wrr

echo `pidof fio1` > /sys/fs/cgroup/blkio/high/cgroup.procs
echo `pidof fio2` > /sys/fs/cgroup/blkio/medium/cgroup.procs
echo `pidof fio3` > /sys/fs/cgroup/blkio/low/cgroup.procs

fio1: 260K
fio2: 160K
fio3: 60K

we dispatch 8(high), 4(medium), 1(low) ios at time, to simulate
weighted round robin policy.

Weiping Zhang (2):
  block: add weighted round robin for blkcgroup
  null_blk: add support weighted round robin submition queue

 block/blk-cgroup.c            |  88 +++++++++++++
 block/blk-mq-debugfs.c        |   3 +
 block/blk-mq-sched.c          |   6 +-
 block/blk-mq-tag.c            |   4 +-
 block/blk-mq-tag.h            |   2 +-
 block/blk-mq.c                |  12 +-
 block/blk-mq.h                |  17 ++-
 block/blk.h                   |   2 +-
 drivers/block/null_blk.h      |   7 +
 drivers/block/null_blk_main.c | 294 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/blk-cgroup.h    |   2 +
 include/linux/blk-mq.h        |  12 ++
 12 files changed, 426 insertions(+), 23 deletions(-)

-- 
2.14.1

