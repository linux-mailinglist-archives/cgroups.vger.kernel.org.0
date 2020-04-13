Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCA1A69F2
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbgDMQ2P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 12:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731549AbgDMQ2N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 12:28:13 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC12CC0A3BDC;
        Mon, 13 Apr 2020 09:28:12 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id q73so4661432qvq.2;
        Mon, 13 Apr 2020 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Bb68KuCtf8ropkgUO+IBtBH+v6R3qhUQPcdqIOx+rM=;
        b=Idl9GkA9HQvbQPkneNaD4EDbW0bbJidNvjTkeHuZJlearodmyrz5gMnAaz9cbsn1+m
         JJKck5eqtqcbU8gqlEca7iGKJciIDnwAfeAGlakOewAWipjb3jmIzgSfB4cdRANrawlR
         AFAHwo4g06P0mR1tXN8woUHz0Nl59+rctt0x1vqF2dQyjeErhwo893sWLcsvsOAnUf5T
         1SnYPx0wckshu0C3LKxJbUnkVabws9/qG/EXnDQa5GJHREc27A20KSQ3CSB7nFMlnijM
         thsAARnQIQXzS0KnRWd3YixU1fP5+jDhzEu7X5vUIFZXPUuP12elzWok7mVt6petTW37
         amOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6Bb68KuCtf8ropkgUO+IBtBH+v6R3qhUQPcdqIOx+rM=;
        b=pFLM8uDb443heOmHntvEtqKhOy8HwDPwsnZ1G1qH4Ute3fRH+D6n+ML5bARpzWrNdu
         H4iu17QG2v0/GqwU1ZJWzYs8Q+sz25ZvJffW5hRxyl7GYCYv/eN7vELcgvJrrSITEu9S
         uHoFtyWI1gYcjrvl4DgbNp1fsawSxvWGRh6sAb8kJGpHq8uxfnQ71uH4bs7y2IQZWjXE
         vEr1c4jVIfNfkVdf1imDblZpu7/Cf+a1+ix++g9GPTSwmEOFQ3iNhIcCwGVkEGZeBbnP
         qP3wyTi4w8Ov9FLFOy8KdYcoSki6pm+OMwZ59l0ligfTEfEy5392p2Jdjntd1/HtMMdQ
         osXA==
X-Gm-Message-State: AGi0PuY5pAFKQ24cNk2xs/x86dm2iMzz0zsCLOKRcO1hPmZLnyrpFYEG
        DyKLIk8soOx8uOsBsRLrKsk=
X-Google-Smtp-Source: APiQypIqvHOIbF8qJrplLBlIquVlJaDJ5Qa54tzuYPVVsfGx4+1Y0Jb0vancrL/OpLiKaR1ct97oOQ==
X-Received: by 2002:a0c:e848:: with SMTP id l8mr18138070qvo.82.1586795290230;
        Mon, 13 Apr 2020 09:28:10 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id j2sm4872937qtp.5.2020.04.13.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:28:06 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, newella@fb.com,
        josef@toxicpanda.com, asml.silence@gmail.com, ming.lei@redhat.com,
        bvanassche@acm.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] blk-iocost: account for IO size when testing latencies
Date:   Mon, 13 Apr 2020 12:27:56 -0400
Message-Id: <20200413162758.97252-3-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413162758.97252-1-tj@kernel.org>
References: <20200413162758.97252-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On each IO completion, iocost decides whether the IO met or missed its latency
target. Currently, the targets are fixed numbers per IO type. While this can be
good enough for loose latency targets way higher than typical completion
latencies, the effect of IO size makes it difficult to tighten the latency
target - a target adequate for 4k IOs might be too tight for 512k IOs and
vice-versa.

iocost already has all the necessary information to account for different IO
sizes when testing whether the latency target is met as iocost can calculate the
size vtime cost of a given IO. This patch updates the completion path to
calculate the size vtime cost of the IO, deduct the nsec equivalent from the
observed latency and use the adjusted value to decide whether the target is met.

This makes latency targets independent from IO size and enables determining
adequate latency targets with fixed size fio runs.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Andy Newell <newella@fb.com>
---
 block/Kconfig      |  1 +
 block/blk-iocost.c | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 3bc76bb113a0..41cb34b0fcd1 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -146,6 +146,7 @@ config BLK_CGROUP_IOLATENCY
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP=y
+	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	---help---
 	Enabling this option enables the .weight interface for cost
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a8e99ef76a08..9a667dd75eef 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -260,6 +260,7 @@ enum {
 	VTIME_PER_SEC_SHIFT	= 37,
 	VTIME_PER_SEC		= 1LLU << VTIME_PER_SEC_SHIFT,
 	VTIME_PER_USEC		= VTIME_PER_SEC / USEC_PER_SEC,
+	VTIME_PER_NSEC		= VTIME_PER_SEC / NSEC_PER_SEC,
 
 	/* bound vrate adjustments within two orders of magnitude */
 	VRATE_MIN_PPM		= 10000,	/* 1% */
@@ -1668,6 +1669,31 @@ static u64 calc_vtime_cost(struct bio *bio, struct ioc_gq *iocg, bool is_merge)
 	return cost;
 }
 
+static void calc_size_vtime_cost_builtin(struct request *rq, struct ioc *ioc,
+					 u64 *costp)
+{
+	unsigned int pages = blk_rq_stats_sectors(rq) >> IOC_SECT_TO_PAGE_SHIFT;
+
+	switch (req_op(rq)) {
+	case REQ_OP_READ:
+		*costp = pages * ioc->params.lcoefs[LCOEF_RPAGE];
+		break;
+	case REQ_OP_WRITE:
+		*costp = pages * ioc->params.lcoefs[LCOEF_WPAGE];
+		break;
+	default:
+		*costp = 0;
+	}
+}
+
+static u64 calc_size_vtime_cost(struct request *rq, struct ioc *ioc)
+{
+	u64 cost;
+
+	calc_size_vtime_cost_builtin(rq, ioc, &cost);
+	return cost;
+}
+
 static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 {
 	struct blkcg_gq *blkg = bio->bi_blkg;
@@ -1837,7 +1863,7 @@ static void ioc_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
 static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
-	u64 on_q_ns, rq_wait_ns;
+	u64 on_q_ns, rq_wait_ns, size_nsec;
 	int pidx, rw;
 
 	if (!ioc->enabled || !rq->alloc_time_ns || !rq->start_time_ns)
@@ -1858,8 +1884,10 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 
 	on_q_ns = ktime_get_ns() - rq->alloc_time_ns;
 	rq_wait_ns = rq->start_time_ns - rq->alloc_time_ns;
+	size_nsec = div64_u64(calc_size_vtime_cost(rq, ioc), VTIME_PER_NSEC);
 
-	if (on_q_ns <= ioc->params.qos[pidx] * NSEC_PER_USEC)
+	if (on_q_ns <= size_nsec ||
+	    on_q_ns - size_nsec <= ioc->params.qos[pidx] * NSEC_PER_USEC)
 		this_cpu_inc(ioc->pcpu_stat->missed[rw].nr_met);
 	else
 		this_cpu_inc(ioc->pcpu_stat->missed[rw].nr_missed);
@@ -2267,6 +2295,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	spin_lock_irq(&ioc->lock);
 
 	if (enable) {
+		blk_stat_enable_accounting(ioc->rqos.q);
 		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
 		ioc->enabled = true;
 	} else {
-- 
2.25.2

