Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083661A2A2D
	for <lists+cgroups@lfdr.de>; Wed,  8 Apr 2020 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgDHUPO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Apr 2020 16:15:14 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45567 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbgDHUPC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Apr 2020 16:15:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id m67so1624862qke.12;
        Wed, 08 Apr 2020 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdXZ3lJLN6mj2DFzKWWl+veWK2Db945pbS3QdWvrLY0=;
        b=vSHKOPOY1fZ0RWyLB4sv9rKbE91lJyvINDh9HA66upkxrCZCsFqamFz/DYSOhOgdYg
         rhxi9bNKEd+fNPZK7od8vDCK/+vuOvEozB6DDyDXPKN3i9608HYrOHwc9TS5SYRR+l3d
         ErVkebnrtKaYJY5OOYkBmWrYSxBv2fa1p+zB8dGYc77HKNJ23/vu5Miief6DgyIlWk1c
         Dteif6bDq7sYypOvnwPEX+FdMG/0OayCjgzzePAgz3Bi6wXWO6CBuPeAOQWTOqyQm2AZ
         l7AmSsojdFv3eC7jugIOdcAItndujAc3JMFc19DwwdGI6D3ZC1lI8HliuiuKc+UY7W2q
         LoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JdXZ3lJLN6mj2DFzKWWl+veWK2Db945pbS3QdWvrLY0=;
        b=ZMIdiRDhVlVhdl1keSalvdCKGlKuUE+oXG1lvPH3cN+YKhR1NgDtOvFLRn7TaYprQA
         5a1RzB+Bk1kHc+C0d41sigQnRNtNPhOFPQ40G4ojuCp5ESsj0v+uNIaaA4PIzDpmUgwn
         l6HmdnmelO0u5xkA86JxCHfPdtOk2axG2nswZDO8JZldqKmvDGS+5ZXxEvqJ4ojI7j6P
         lYqDfjAph6N3GjNexfIfSZVjIdFcgF5ScZTETmQarGDzA9h/CZ3z/UZ0Orzhg4soL6/a
         QvHkMEevY3Tnlm64Bi5/JqUq71q0LceBXgNSBbtduDNurUjOmYsx9T28ef2m2K+pnweF
         r1MQ==
X-Gm-Message-State: AGi0PuZjoyY2XuXoKImdqI7CKZ7MWx91qJiiM2G1vJwjdQ79Seg+sXmd
        ZsiBT6/AsK3aR8fLKWNLtrrAc1qO9BI=
X-Google-Smtp-Source: APiQypJ/jtm3TeWXnX5UBgw/Ym2V/O1SmHKO9XstdQMbbCDR0m1fA2SbLHvoG/TnqtB90OV+DDwCNw==
X-Received: by 2002:a37:a4c3:: with SMTP id n186mr1612922qke.62.1586376901312;
        Wed, 08 Apr 2020 13:15:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::36b2])
        by smtp.gmail.com with ESMTPSA id z11sm19391343qti.23.2020.04.08.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:15:00 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, josef@toxicpanda.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] blk-iocost: account for IO size when testing latencies
Date:   Wed,  8 Apr 2020 16:14:48 -0400
Message-Id: <20200408201450.3959560-4-tj@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200408201450.3959560-1-tj@kernel.org>
References: <20200408201450.3959560-1-tj@kernel.org>
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
 block/blk-iocost.c | 31 +++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 48308e600dc8..3b0b698ca254 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -149,6 +149,7 @@ config BLK_CGROUP_IOLATENCY
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
 	depends on BLK_CGROUP=y
+	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	---help---
 	Enabling this option enables the .weight interface for cost
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a8e99ef76a08..76e8738f7bb5 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -260,6 +260,7 @@ enum {
 	VTIME_PER_SEC_SHIFT	= 37,
 	VTIME_PER_SEC		= 1LLU << VTIME_PER_SEC_SHIFT,
 	VTIME_PER_USEC		= VTIME_PER_SEC / USEC_PER_SEC,
+	VTIME_PER_NSEC		= VTIME_PER_SEC / NSEC_PER_SEC,
 
 	/* bound vrate adjustments within two orders of magnitude */
 	VRATE_MIN_PPM		= 10000,	/* 1% */
@@ -1668,6 +1669,30 @@ static u64 calc_vtime_cost(struct bio *bio, struct ioc_gq *iocg, bool is_merge)
 	return cost;
 }
 
+static void calc_size_vtime_cost_builtin(struct request *rq, struct ioc *ioc, u64 *costp)
+{
+	u64 pages = max_t(u64, rq->io_data_len >> IOC_PAGE_SHIFT, 1);
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
@@ -1837,7 +1862,7 @@ static void ioc_rqos_done_bio(struct rq_qos *rqos, struct bio *bio)
 static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 {
 	struct ioc *ioc = rqos_to_ioc(rqos);
-	u64 on_q_ns, rq_wait_ns;
+	u64 on_q_ns, rq_wait_ns, size_nsec;
 	int pidx, rw;
 
 	if (!ioc->enabled || !rq->alloc_time_ns || !rq->start_time_ns)
@@ -1858,8 +1883,10 @@ static void ioc_rqos_done(struct rq_qos *rqos, struct request *rq)
 
 	on_q_ns = ktime_get_ns() - rq->alloc_time_ns;
 	rq_wait_ns = rq->start_time_ns - rq->alloc_time_ns;
+	size_nsec = div64_u64(calc_size_vtime_cost(rq, ioc), VTIME_PER_NSEC);
 
-	if (on_q_ns <= ioc->params.qos[pidx] * NSEC_PER_USEC)
+	if (on_q_ns <= size_nsec ||
+	    on_q_ns - size_nsec <= ioc->params.qos[pidx] * NSEC_PER_USEC)
 		this_cpu_inc(ioc->pcpu_stat->missed[rw].nr_met);
 	else
 		this_cpu_inc(ioc->pcpu_stat->missed[rw].nr_missed);
-- 
2.25.1

