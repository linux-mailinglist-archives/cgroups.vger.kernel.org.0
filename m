Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FAC18DD7C
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2020 02:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCUBiR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Mar 2020 21:38:17 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:2086 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726897AbgCUBiQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Mar 2020 21:38:16 -0400
X-ASG-Debug-ID: 1584753637-0e408861fc67e960001-hhPYk8
Received: from mail.didiglobal.com (localhost [172.20.36.175]) by bsf01.didichuxing.com with ESMTP id wO9k7EimjL3IGaj3; Sat, 21 Mar 2020 09:20:37 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 21 Mar
 2020 09:20:37 +0800
Date:   Sat, 21 Mar 2020 09:20:36 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [RFC 0/3] blkcg: add blk-iotrack
Message-ID: <cover.1584728740.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RFC 0/3] blkcg: add blk-iotrack
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS04.didichuxing.com (172.20.36.192) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.175]
X-Barracuda-Start-Time: 1584753637
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3665
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80738
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

This patchset try to add a monitor-only module blk-iotrack for block
cgroup.

It contains kernel space blk-iotrack and user space tools iotrack, and
you can also write your own tool to do more data analysis.

blk-iotrack was designed to track various io statistic of block cgroup,
it is based on rq_qos framework. It only tracks io and does not do any
throttlling.

Compare to blk-iolatency, it provides 8 configurable latency buckets,
/sys/fs/cgroup/io.iotrack.lat_thresh, blk-iotrack will account the
number of IOs whose latency less than corresponding threshold. In this
way we can get the cgroup's latency distribution. The default latency
bucket is 50us, 100us, 200us, 400us, 1ms, 2ms, 4ms, 8ms.

Compare to io.stat.{rbytes,wbytes,rios,wios,dbytes,dios}, it account
IOs when IO completed, instead of submited. If IO was throttled by
io scheduler or other throttle policy, then there is a gap, these
IOs have not been completed yet.

The previous patch has record the timestamp for each bio, when it
was issued to the disk driver. Then we can get the disk latency in
rq_qos_done_bio, this is also be called D2C time. In rq_qos_done_bio,
blk-iotrack also record total latency(now - bio_issue_time), actually
it can be treated as the Q2C time. In this way, we can get the percentile
%d2c=D2C/Q2C for each cgroup. It's very useful to detect the main latency
is from disk or software e.g. io scheduler or other block cgroup throttle
policy.

The user space tool, which called iotrack, used to collect these basic
io statistics and then generate more valuable metrics at cgroup level.
From iotrack, you can get a cgroup's percentile for io, bytes,
total_time and disk_time of the whole disk. It can easily to evaluate
the real weight of the weight based policy(bfq, blk-iocost).
There are lots of metrics for read and write generate by iotrack,
for more details, please visit: https://github.com/dublio/iotrack.

Test result for two fio with randread 4K,
test1 cgroup bfq weight = 800
test2 cgroup bfq weight = 100

Device      io/s   MB/s    %io    %MB    %tm   %dtm  %d2c %hit0 %hit1 %hit2 %hit3 %hit4 %hit5  %hit6  %hit7 cgroup
nvme1n1 44588.00 174.17 100.00 100.00 100.00 100.00 38.46  0.25 45.27 95.90 98.33 99.47 99.85  99.92  99.95 /
nvme1n1 30206.00 117.99  67.74  67.74  29.44  67.29 87.90  0.35 47.82 99.22 99.98 99.99 99.99 100.00 100.00 /test1
nvme1n1 14370.00  56.13  32.23  32.23  70.55  32.69 17.82  0.03 39.89 88.92 94.88 98.37 99.53  99.77  99.85 /test2

* The root block cgroup "/" shows the io statistics for whole ssd disk.

* test1 use disk's %67 iops and bps.

* %dtm stands for the on disk time, test1 cgroup get 67% of whole disk,
	that means test1 gets more disk time than test2.

* For test's %d2c, there is only 17% latency cost at hardware disk,
	that means the main latency cames from software, it was
	throttled by softwre.


The patch1 and patch2 are preapre patch.
The last patch implement blk-iotrack.

Weiping Zhang (3):
  update the real issue size when bio_split
  bio: track timestamp of submitting bio the disk driver
  blkcg: add blk-iotrack

 block/Kconfig              |   6 +
 block/Makefile             |   1 +
 block/bio.c                |  13 ++
 block/blk-cgroup.c         |   4 +
 block/blk-iotrack.c        | 436 +++++++++++++++++++++++++++++++++++++
 block/blk-mq.c             |   3 +
 block/blk-rq-qos.h         |   3 +
 block/blk.h                |   7 +
 include/linux/blk-cgroup.h |   6 +
 include/linux/blk_types.h  |  38 ++++
 10 files changed, 517 insertions(+)
 create mode 100644 block/blk-iotrack.c

-- 
2.18.1

