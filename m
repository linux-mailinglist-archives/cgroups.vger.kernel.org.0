Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB23E263D2E
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 08:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgIJGWm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 02:22:42 -0400
Received: from smtp.h3c.com ([60.191.123.56]:42091 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgIJGWh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 10 Sep 2020 02:22:37 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 08A6Lve4044174
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 14:21:57 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Sep 2020 14:21:59 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <tj@kernel.org>, <axboe@kernel.dk>
CC:     <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] [v2] blkcg: add plugging support for punt bio
Date:   Thu, 10 Sep 2020 14:15:06 +0800
Message-ID: <20200910061506.45704-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 08A6Lve4044174
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The test and the explaination of the patch as bellow.

Before test we added more debug code in blkg_async_bio_workfn():
	int count = 0
	if (bios.head && bios.head->bi_next) {
		need_plug = true;
		blk_start_plug(&plug);
	}
	while ((bio = bio_list_pop(&bios))) {
		/*io_punt is a sysctl user interface to control the print*/
		if(io_punt) {
			printk("[%s:%d] bio start,size:%llu,%d count=%d plug?%d\n",
				current->comm, current->pid, bio->bi_iter.bi_sector,
				(bio->bi_iter.bi_size)>>9, count++, need_plug);
		}
		submit_bio(bio);
	}
	if (need_plug)
		blk_finish_plug(&plug);

Steps that need to be set to trigger *PUNT* io before testing:
	mount -t btrfs -o compress=lzo /dev/sda6 /btrfs
	mount -t cgroup2 nodev /cgroup2
	mkdir /cgroup2/cg3
	echo "+io" > /cgroup2/cgroup.subtree_control
	echo "8:0 wbps=1048576000" > /cgroup2/cg3/io.max #1000M/s
	echo $$ > /cgroup2/cg3/cgroup.procs

Then use dd command to test btrfs PUNT io in current shell:
	dd if=/dev/zero of=/btrfs/file bs=64K count=100000

Test hardware environment as below:
	[root@localhost btrfs]# lscpu
	Architecture:          x86_64
	CPU op-mode(s):        32-bit, 64-bit
	Byte Order:            Little Endian
	CPU(s):                32
	On-line CPU(s) list:   0-31
	Thread(s) per core:    2
	Core(s) per socket:    8
	Socket(s):             2
	NUMA node(s):          2
	Vendor ID:             GenuineIntel

With above debug code, test command and test environment, I did the
tests under 3 different system loads, which are triggered by stress:
1, Run 64 threads by command "stress -c 64 &"
	[53615.975974] [kworker/u66:18:1490] bio start,size:45583056,8 count=0 plug?1
	[53615.975980] [kworker/u66:18:1490] bio start,size:45583064,8 count=1 plug?1
	[53615.975984] [kworker/u66:18:1490] bio start,size:45583072,8 count=2 plug?1
	[53615.975987] [kworker/u66:18:1490] bio start,size:45583080,8 count=3 plug?1
	[53615.975990] [kworker/u66:18:1490] bio start,size:45583088,8 count=4 plug?1
	[53615.975993] [kworker/u66:18:1490] bio start,size:45583096,8 count=5 plug?1
	... ...
	[53615.977041] [kworker/u66:18:1490] bio start,size:45585480,8 count=303 plug?1
	[53615.977044] [kworker/u66:18:1490] bio start,size:45585488,8 count=304 plug?1
	[53615.977047] [kworker/u66:18:1490] bio start,size:45585496,8 count=305 plug?1
	[53615.977050] [kworker/u66:18:1490] bio start,size:45585504,8 count=306 plug?1
	[53615.977053] [kworker/u66:18:1490] bio start,size:45585512,8 count=307 plug?1
	[53615.977056] [kworker/u66:18:1490] bio start,size:45585520,8 count=308 plug?1
	[53615.977058] [kworker/u66:18:1490] bio start,size:45585528,8 count=309 plug?1

2, Run 32 threads by command "stress -c 32 &"
	[50586.290521] [kworker/u66:6:32351] bio start,size:45806496,8 count=0 plug?1
	[50586.290526] [kworker/u66:6:32351] bio start,size:45806504,8 count=1 plug?1
	[50586.290529] [kworker/u66:6:32351] bio start,size:45806512,8 count=2 plug?1
	[50586.290531] [kworker/u66:6:32351] bio start,size:45806520,8 count=3 plug?1
	[50586.290533] [kworker/u66:6:32351] bio start,size:45806528,8 count=4 plug?1
	[50586.290535] [kworker/u66:6:32351] bio start,size:45806536,8 count=5 plug?1
	... ...
	[50586.299640] [kworker/u66:5:32350] bio start,size:45808576,8 count=252 plug?1
	[50586.299643] [kworker/u66:5:32350] bio start,size:45808584,8 count=253 plug?1
	[50586.299646] [kworker/u66:5:32350] bio start,size:45808592,8 count=254 plug?1
	[50586.299649] [kworker/u66:5:32350] bio start,size:45808600,8 count=255 plug?1
	[50586.299652] [kworker/u66:5:32350] bio start,size:45808608,8 count=256 plug?1
	[50586.299663] [kworker/u66:5:32350] bio start,size:45808616,8 count=257 plug?1
	[50586.299665] [kworker/u66:5:32350] bio start,size:45808624,8 count=258 plug?1
	[50586.299668] [kworker/u66:5:32350] bio start,size:45808632,8 count=259 plug?1

3, Don't run thread by stress
	[50861.355246] [kworker/u66:19:32376] bio start,size:13544504,8 count=0 plug?0
	[50861.355288] [kworker/u66:19:32376] bio start,size:13544512,8 count=0 plug?0
	[50861.355322] [kworker/u66:19:32376] bio start,size:13544520,8 count=0 plug?0
	[50861.355353] [kworker/u66:19:32376] bio start,size:13544528,8 count=0 plug?0
	[50861.355392] [kworker/u66:19:32376] bio start,size:13544536,8 count=0 plug?0
	[50861.355431] [kworker/u66:19:32376] bio start,size:13544544,8 count=0 plug?0
	[50861.355468] [kworker/u66:19:32376] bio start,size:13544552,8 count=0 plug?0
	[50861.355499] [kworker/u66:19:32376] bio start,size:13544560,8 count=0 plug?0
	[50861.355532] [kworker/u66:19:32376] bio start,size:13544568,8 count=0 plug?0
	[50861.355575] [kworker/u66:19:32376] bio start,size:13544576,8 count=0 plug?0
	[50861.355618] [kworker/u66:19:32376] bio start,size:13544584,8 count=0 plug?0
	[50861.355659] [kworker/u66:19:32376] bio start,size:13544592,8 count=0 plug?0
	[50861.355740] [kworker/u66:0:32346] bio start,size:13544600,8 count=0 plug?1
	[50861.355748] [kworker/u66:0:32346] bio start,size:13544608,8 count=1 plug?1
	[50861.355962] [kworker/u66:2:32347] bio start,size:13544616,8 count=0 plug?0
	[50861.356272] [kworker/u66:7:31962] bio start,size:13544624,8 count=0 plug?0
	[50861.356446] [kworker/u66:7:31962] bio start,size:13544632,8 count=0 plug?0
	[50861.356567] [kworker/u66:7:31962] bio start,size:13544640,8 count=0 plug?0
	[50861.356707] [kworker/u66:19:32376] bio start,size:13544648,8 count=0 plug?0
	[50861.356748] [kworker/u66:15:32355] bio start,size:13544656,8 count=0 plug?0
	[50861.356825] [kworker/u66:17:31970] bio start,size:13544664,8 count=0 plug?0

Analysis of above 3 test results with different system load:
From above test, we can see more and more continuous bios can be plugged
with system load increasing. When run "stress -c 64 &", 310 continuous
bios are plugged; When run "stress -c 32 &", 260 continuous bios are
plugged; When don't run stress, at most only 2 continuous bios are
plugged, in most cases, bio_list only contains one single bio.

How to explain above phenomenon:
We know, in submit_bio(), if the bio is a REQ_CGROUP_PUNT io, it will
queue a work to workqueue blkcg_punt_bio_wq. But when the workqueue is
scheduled, it depends on the system load.  When system load is low, the
workqueue will be quickly scheduled, and the bio in bio_list will be
quickly processed in blkg_async_bio_workfn(), so there is less chance
that the same io submit thread can add multiple continuous bios to
bio_list before workqueue is scheduled to run. The analysis aligned with
above test "3".
When system load is high, there is some delay before the workqueue can
be scheduled to run, the higher the system load the greater the delay.
So there is more chance that the same io submit thread can add multiple
continuous bios to bio_list. Then when the workqueue is scheduled to run,
there are more continuous bios in bio_list, which will be processed in
blkg_async_bio_workfn(). The analysis aligned with above test "1" and "2".

According to test, we can get io performance improved with the patch,
especially when system load is higher. Another optimazition is to use
the plug only when bio_list contains at least 2 bios.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-cgroup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c195365c9..f35a205d5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -119,6 +119,8 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 					     async_bio_work);
 	struct bio_list bios = BIO_EMPTY_LIST;
 	struct bio *bio;
+	struct blk_plug plug;
+	bool need_plug = false;
 
 	/* as long as there are pending bios, @blkg can't go away */
 	spin_lock_bh(&blkg->async_bio_lock);
@@ -126,8 +128,15 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 	bio_list_init(&blkg->async_bios);
 	spin_unlock_bh(&blkg->async_bio_lock);
 
+	/* start plug only when bio_list contains at least 2 bios */
+	if (bios.head && bios.head->bi_next) {
+		need_plug = true;
+		blk_start_plug(&plug);
+	}
 	while ((bio = bio_list_pop(&bios)))
 		submit_bio(bio);
+	if (need_plug)
+		blk_finish_plug(&plug);
 }
 
 /**
-- 
2.17.1

