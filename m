Return-Path: <cgroups+bounces-7155-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3C7A68A18
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 11:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625823BFCB1
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 10:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E6254876;
	Wed, 19 Mar 2025 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gX0zyT6h"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A580325485C;
	Wed, 19 Mar 2025 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381743; cv=none; b=Wzo0jMg/ANA0dzqpqhs6cB8Qa5fMFELM5whkY0Jcksqy7fIMTWkJLA+NKikJ1ikjWDfkWiQBWjM/oY9M7T/Hk/HA9uFntsz0NjfNPKMG1NPZyeHHgxgPxP6UMxbRx108D4S7H1s9oxm1ViUs5HONJGm0wtUmntjFPU2Z1XuPXN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381743; c=relaxed/simple;
	bh=eydk5g3QWlAk/hshQ6bt4mWfsHXa35zDq+zCFViDCIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jN6vtgX9QJ4nHzvqWV9Oi095gcBFi67oZQYkKCTgfJVTbpOWhx9BZgJ5s7NC6QmmeKrIdBX4o2dJ8mDeyKOF4ldPb0qH9dbob4Do4A32eYXcPXj9wUk51ACJbH5IUXf9XAj9Q0zF1TncGs+ZdWbtbvF91u30vfw7c9Rf8P1hkZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gX0zyT6h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8I1OW004186;
	Wed, 19 Mar 2025 10:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fm3PIA
	FPW+03C0V0KjiRcMbzgRGNscims+t42kVqU3U=; b=gX0zyT6hQnQDTim8n1Kzvq
	jgqb9DolsuFgmDba5MMxCFY8bt2PZ7XC789WI/dwjcXnZxNSN/nw2aCQ/ioY+s9R
	ZFcvtp1mg2ak49YUQkTuIRSVtNIi9bo5vHrHzeRUQKY7fLp0RuVYtUDU3D8NyE9J
	Ou7ioShckGLGsmBowQpdA2FH6+q+5Jf3ZdQIZrbEUHeFmB4Cji6BfXYjWYNbRV9t
	knhlWSaukgU6cre/SGvl739uAYxWfIeD0MSCfoAisHChm7F2o3iKYPOOxa1+VzkT
	aDyEwZduUNiH6C5mQgyGhbpoGEgkPnl8BlLOJWIsKk8qbdOcmuo83zvJmAqqX8BQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ft9vrpwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:55:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JAnHJo023211;
	Wed, 19 Mar 2025 10:55:31 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3krvvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 10:55:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JAtT6o53215490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 10:55:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4196120040;
	Wed, 19 Mar 2025 10:55:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60A1C20043;
	Wed, 19 Mar 2025 10:55:26 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.185])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 10:55:26 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org, cgroups@vger.kernel.org
Cc: hch@lst.de, hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com, gjoyce@ibm.com,
        lkp@intel.com, oliver.sang@intel.com
Subject: [PATCH 2/2] block: correct locking order for protecting blk-wbt parameters
Date: Wed, 19 Mar 2025 16:23:46 +0530
Message-ID: <20250319105518.468941-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319105518.468941-1-nilay@linux.ibm.com>
References: <20250319105518.468941-1-nilay@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RKBPcDOz7dR0-kHs673tNbgfRH0mwgyp
X-Proofpoint-GUID: RKBPcDOz7dR0-kHs673tNbgfRH0mwgyp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190072

The commit '245618f8e45f ("block: protect wbt_lat_usec using q->
elevator_lock")' introduced q->elevator_lock to protect updates
to blk-wbt parameters when writing to the sysfs attribute wbt_
lat_usec and the cgroup attribute io.cost.qos.  However, both
these attributes also acquire q->rq_qos_mutex, leading to the
following lockdep warning:

======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc5+ #138 Not tainted
------------------------------------------------------
bash/5902 is trying to acquire lock:
c000000085d495a0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: wbt_init+0x164/0x238

but task is already holding lock:
c000000085d498c8 (&q->elevator_lock){+.+.}-{4:4}, at: queue_wb_lat_store+0xb0/0x20c

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&q->elevator_lock){+.+.}-{4:4}:
        __mutex_lock+0xf0/0xa58
        ioc_qos_write+0x16c/0x85c
        cgroup_file_write+0xc4/0x32c
        kernfs_fop_write_iter+0x1b8/0x29c
        vfs_write+0x410/0x584
        ksys_write+0x84/0x140
        system_call_exception+0x134/0x360
        system_call_vectored_common+0x15c/0x2ec

-> #0 (&q->rq_qos_mutex){+.+.}-{4:4}:
        __lock_acquire+0x1b6c/0x2ae0
        lock_acquire+0x140/0x430
        __mutex_lock+0xf0/0xa58
        wbt_init+0x164/0x238
        queue_wb_lat_store+0x1dc/0x20c
        queue_attr_store+0x12c/0x164
        sysfs_kf_write+0x6c/0xb0
        kernfs_fop_write_iter+0x1b8/0x29c
        vfs_write+0x410/0x584
        ksys_write+0x84/0x140
        system_call_exception+0x134/0x360
        system_call_vectored_common+0x15c/0x2ec

other info that might help us debug this:

    Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
    lock(&q->elevator_lock);
                                lock(&q->rq_qos_mutex);
                                lock(&q->elevator_lock);
    lock(&q->rq_qos_mutex);

    *** DEADLOCK ***

6 locks held by bash/5902:
    #0: c000000051122400 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0x84/0x140
    #1: c00000007383f088 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x174/0x29c
    #2: c000000008550428 (kn->active#182){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x180/0x29c
    #3: c000000085d493a8 (&q->q_usage_counter(io)#5){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40
    #4: c000000085d493e0 (&q->q_usage_counter(queue)#5){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave+0x28/0x40
    #5: c000000085d498c8 (&q->elevator_lock){+.+.}-{4:4}, at: queue_wb_lat_store+0xb0/0x20c

stack backtrace:
CPU: 17 UID: 0 PID: 5902 Comm: bash Kdump: loaded Not tainted 6.14.0-rc5+ #138
Hardware name: IBM,9043-MRX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_028) hv:phyp pSeries
Call Trace:
[c0000000721ef590] [c00000000118f8a8] dump_stack_lvl+0x108/0x18c (unreliable)
[c0000000721ef5c0] [c00000000022563c] print_circular_bug+0x448/0x604
[c0000000721ef670] [c000000000225a44] check_noncircular+0x24c/0x26c
[c0000000721ef740] [c00000000022bf28] __lock_acquire+0x1b6c/0x2ae0
[c0000000721ef870] [c000000000229240] lock_acquire+0x140/0x430
[c0000000721ef970] [c0000000011cfbec] __mutex_lock+0xf0/0xa58
[c0000000721efaa0] [c00000000096c46c] wbt_init+0x164/0x238
[c0000000721efaf0] [c0000000008f8cd8] queue_wb_lat_store+0x1dc/0x20c
[c0000000721efb50] [c0000000008f8fa0] queue_attr_store+0x12c/0x164
[c0000000721efc60] [c0000000007c11cc] sysfs_kf_write+0x6c/0xb0
[c0000000721efca0] [c0000000007bfa4c] kernfs_fop_write_iter+0x1b8/0x29c
[c0000000721efcf0] [c0000000006a281c] vfs_write+0x410/0x584
[c0000000721efdc0] [c0000000006a2cc8] ksys_write+0x84/0x140
[c0000000721efe10] [c000000000031b64] system_call_exception+0x134/0x360
[c0000000721efe50] [c00000000000cedc] system_call_vectored_common+0x15c/0x2ec

From the above log it's apparent that method which writes to sysfs attr
wbt_lat_usec acquires q->elevator_lock first, and then acquires q->rq_
qos_mutex. However the another method which writes to io.cost.qos,
acquires q->rq_qos_mutex first, and then acquires q->rq_qos_mutex. So
this could potentially cause the deadlock.

A closer look at ioc_qos_write shows that correcting the lock order is
non-trivial because q->rq_qos_mutex is acquired in blkg_conf_open_bdev
and released in blkg_conf_exit. The function blkg_conf_open_bdev is
responsible for parsing user input and finding the corresponding block
device (bdev) from the user provided major:minor number.

Since we do not know the bdev until blkg_conf_open_bdev completes, we
cannot simply move q->elevator_lock acquisition before blkg_conf_open_
bdev. So to address this, we intoduce new helpers blkg_conf_open_bdev_
frozen and blkg_conf_exit_frozen which are just wrappers around blkg_
conf_open_bdev and blkg_conf_exit respectively. The helper blkg_conf_
open_bdev_frozen is similar to blkg_conf_open_bdev, but additionally
freezes the queue, acquires q->elevator_lock and ensures the correct
locking order is followed between q->elevator_lock and q->rq_qos_mutex.
Similarly another helper blkg_conf_exit_frozen in addition to unfreezing
the queue ensures that we release the locks in correct order.

By using these helpers, now we maintain the same locking order in all
code paths where we update blk-wbt parameters.

Fixes: 245618f8e45f ("block: protect wbt_lat_usec using q->elevator_lock")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202503171650.cc082b66-lkp@intel.com
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/blk-cgroup.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk-cgroup.h |  2 ++
 block/blk-iocost.c | 18 +++++-----------
 3 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 9ed93d91d754..31d40879c346 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -815,6 +815,41 @@ int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx)
 	ctx->bdev = bdev;
 	return 0;
 }
+/*
+ * Similar to blkg_conf_open_bdev, but additionally freezes the queue,
+ * acquires q->elevator_lock, and ensures the correct locking order
+ * between q->elevator_lock and q->rq_qos_mutex.
+ *
+ * This function returns negative error on failure. On success it returns
+ * memflags which must be saved and later passed to blkg_conf_exit_frozen
+ * for restoring the memalloc scope.
+ */
+unsigned long __must_check blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx)
+{
+	int ret;
+	unsigned long memflags;
+
+	if (ctx->bdev)
+		return -EINVAL;
+
+	ret = blkg_conf_open_bdev(ctx);
+	if (ret < 0)
+		return ret;
+	/*
+	 * At this point, we haven’t started protecting anything related to QoS,
+	 * so we release q->rq_qos_mutex here, which was first acquired in blkg_
+	 * conf_open_bdev. Later, we re-acquire q->rq_qos_mutex after freezing
+	 * the queue and acquiring q->elevator_lock to maintain the correct
+	 * locking order.
+	 */
+	mutex_unlock(&ctx->bdev->bd_queue->rq_qos_mutex);
+
+	memflags = blk_mq_freeze_queue(ctx->bdev->bd_queue);
+	mutex_lock(&ctx->bdev->bd_queue->elevator_lock);
+	mutex_lock(&ctx->bdev->bd_queue->rq_qos_mutex);
+
+	return memflags;
+}
 
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
@@ -971,6 +1006,22 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_exit);
 
+/*
+ * Similar to blkg_conf_exit, but also unfreezes the queue and releases
+ * q->elevator_lock. Should be used when blkg_conf_open_bdev_frozen
+ * is used to open the bdev.
+ */
+void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags)
+{
+	if (ctx->bdev) {
+		struct request_queue *q = ctx->bdev->bd_queue;
+
+		blkg_conf_exit(ctx);
+		mutex_unlock(&q->elevator_lock);
+		blk_mq_unfreeze_queue(q, memflags);
+	}
+}
+
 static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
 {
 	int i;
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 2c4663bd993a..81868ad86330 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -219,9 +219,11 @@ struct blkg_conf_ctx {
 
 void blkg_conf_init(struct blkg_conf_ctx *ctx, char *input);
 int blkg_conf_open_bdev(struct blkg_conf_ctx *ctx);
+unsigned long blkg_conf_open_bdev_frozen(struct blkg_conf_ctx *ctx);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   struct blkg_conf_ctx *ctx);
 void blkg_conf_exit(struct blkg_conf_ctx *ctx);
+void blkg_conf_exit_frozen(struct blkg_conf_ctx *ctx, unsigned long memflags);
 
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 56e6fb51316d..3724b0308cd8 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3223,13 +3223,13 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
 	char *body, *p;
-	unsigned int memflags;
+	unsigned long memflags;
 	int ret;
 
 	blkg_conf_init(&ctx, input);
 
-	ret = blkg_conf_open_bdev(&ctx);
-	if (ret)
+	memflags = blkg_conf_open_bdev_frozen(&ctx);
+	if (IS_ERR_VALUE(memflags))
 		goto err;
 
 	body = ctx.body;
@@ -3247,8 +3247,6 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(disk->queue);
 	}
 
-	memflags = blk_mq_freeze_queue(disk->queue);
-	mutex_lock(&disk->queue->elevator_lock);
 	blk_mq_quiesce_queue(disk->queue);
 
 	spin_lock_irq(&ioc->lock);
@@ -3348,21 +3346,15 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 		wbt_enable_default(disk);
 
 	blk_mq_unquiesce_queue(disk->queue);
-	mutex_unlock(&disk->queue->elevator_lock);
-	blk_mq_unfreeze_queue(disk->queue, memflags);
 
-	blkg_conf_exit(&ctx);
+	blkg_conf_exit_frozen(&ctx, memflags);
 	return nbytes;
 einval:
 	spin_unlock_irq(&ioc->lock);
-
 	blk_mq_unquiesce_queue(disk->queue);
-	mutex_unlock(&disk->queue->elevator_lock);
-	blk_mq_unfreeze_queue(disk->queue, memflags);
-
 	ret = -EINVAL;
 err:
-	blkg_conf_exit(&ctx);
+	blkg_conf_exit_frozen(&ctx, memflags);
 	return ret;
 }
 
-- 
2.47.1


