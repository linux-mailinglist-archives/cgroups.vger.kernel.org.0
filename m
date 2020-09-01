Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC41B259E7D
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbgIASyC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731659AbgIASxr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:47 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57961C061244;
        Tue,  1 Sep 2020 11:53:45 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g3so1671946qtq.10;
        Tue, 01 Sep 2020 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXJRMse9QXXNenk8cfC4gak0dCsZiFe6e3X+8Ji4w3Q=;
        b=BXXoYe01DDRCKvgaScU83wvwf7XD6KQVVomVyvl/vLID4xi+n/8BW2jZ5Cs+A7gx8u
         got81U9z9RBnWefFOopQpK6tm83wPUkY2xAILDa9falioSlOflC/7VQalLdG1wo+1HX7
         t16rxbYltdCLJI5j0zNQ3994PoCumMxjBpfo1So1B/pGpDOmiuSLOgDMcRw7zUPaMAnZ
         L0TusRziIeUhjWEpsQ7vNdAGAvQguj9Ff+27M2zjTj6Rx64EzT9ik8NkXA1RnzSXYJ3f
         8f8gf55MH2UepPZ5V6VSWLqGZ92ltx0/obz7AHiJ/EyY1AG+HIkq59tQdwQBIdwSL6LA
         4b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cXJRMse9QXXNenk8cfC4gak0dCsZiFe6e3X+8Ji4w3Q=;
        b=KamioAxU5DdhQrSlzCUJVnU30FuSYFF2oVgoihyyJ6Z+vpURD3gN8l1zyXt7ihlxqS
         BMZWvSxjzOKkSLMfICrfVFmLtwo/0FOqhGJe9TondKONbKiIaDZ9aLAdfJ3oRH1MWIN5
         sliw7IcMofgP4fPo+aA0OzmUL9reUWcs6G5AP+3Sh/7ythBuMf2uBx/CWaTJY0tEtrKG
         EjDGzJ8KCVqvSDFYxr70llWm8NvVz8AeS+nDWIEka5BBoz/f1h69R9Ygmv1DVNb62jSo
         egA94/l5H7qMuziRCaU6hLaVMOZDYjI9lQNNUzR+dE+bpIbC8iEfxRBdpSCL+XnxwUJJ
         PueQ==
X-Gm-Message-State: AOAM531Rx6iKUiSxIpKUO+XymhnPhO5wLEzi65xnBrHPlNJdN+5eLUSW
        n95CMRQKT8UbSrv8Mn6WY4aYnkSM3jE/oQ==
X-Google-Smtp-Source: ABdhPJwhvNbbui/Tjp10Qa2r+WKKg7c5TccEjTh7jZV3A81MbS296RdvBjjJVsgaGC20qYmp87lbIQ==
X-Received: by 2002:ac8:4cc2:: with SMTP id l2mr3256408qtv.130.1598986424410;
        Tue, 01 Sep 2020 11:53:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id v28sm2639011qtk.28.2020.09.01.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:43 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/27] blk-iocost: add absolute usage stat
Date:   Tue,  1 Sep 2020 14:52:43 -0400
Message-Id: <20200901185257.645114-14-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, iocost doesn't collect or expose any statistics punting off all
monitoring duties to drgn based iocost_monitor.py. While it works for some
scenarios, there are some usability and data availability challenges. For
example, accurate per-cgroup usage information can't be tracked by vtime
progression at all and the number available in iocg->usages[] are really
short-term snapshots used for control heuristics with possibly significant
errors.

This patch implements per-cgroup absolute usage stat counter and exposes it
through io.stat along with the current vrate. Usage stat collection and
flushing employ the same method as cgroup rstat on the active iocg's and the
only hot path overhead is preemption toggling and adding to a percpu
counter.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 155 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 23b173e34591..f30f9b37fcf0 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -431,6 +431,14 @@ struct ioc {
 	bool				user_cost_model:1;
 };
 
+struct iocg_pcpu_stat {
+	local64_t			abs_vusage;
+};
+
+struct iocg_stat {
+	u64				usage_us;
+};
+
 /* per device-cgroup pair */
 struct ioc_gq {
 	struct blkg_policy_data		pd;
@@ -492,10 +500,19 @@ struct ioc_gq {
 	u32				hweight_inuse;
 	bool				has_surplus;
 
+	struct list_head		walk_list;
+
 	struct wait_queue_head		waitq;
 	struct hrtimer			waitq_timer;
 	struct hrtimer			delay_timer;
 
+	/* statistics */
+	struct iocg_pcpu_stat __percpu	*pcpu_stat;
+	struct iocg_stat		local_stat;
+	struct iocg_stat		desc_stat;
+	struct iocg_stat		last_stat;
+	u64				last_stat_abs_vusage;
+
 	/* usage is recorded as fractions of WEIGHT_ONE */
 	int				usage_idx;
 	u32				usages[NR_USAGE_SLOTS];
@@ -674,10 +691,17 @@ static u64 cost_to_abs_cost(u64 cost, u32 hw_inuse)
 	return DIV64_U64_ROUND_UP(cost * hw_inuse, WEIGHT_ONE);
 }
 
-static void iocg_commit_bio(struct ioc_gq *iocg, struct bio *bio, u64 cost)
+static void iocg_commit_bio(struct ioc_gq *iocg, struct bio *bio,
+			    u64 abs_cost, u64 cost)
 {
+	struct iocg_pcpu_stat *gcs;
+
 	bio->bi_iocost_cost = cost;
 	atomic64_add(cost, &iocg->vtime);
+
+	gcs = get_cpu_ptr(iocg->pcpu_stat);
+	local64_add(abs_cost, &gcs->abs_vusage);
+	put_cpu_ptr(gcs);
 }
 
 static void iocg_lock(struct ioc_gq *iocg, bool lock_ioc, unsigned long *flags)
@@ -1221,7 +1245,7 @@ static int iocg_wake_fn(struct wait_queue_entry *wq_entry, unsigned mode,
 	if (ctx->vbudget < 0)
 		return -1;
 
-	iocg_commit_bio(ctx->iocg, wait->bio, cost);
+	iocg_commit_bio(ctx->iocg, wait->bio, wait->abs_cost, cost);
 
 	/*
 	 * autoremove_wake_function() removes the wait entry only when it
@@ -1382,6 +1406,87 @@ static bool iocg_is_idle(struct ioc_gq *iocg)
 	return true;
 }
 
+/*
+ * Call this function on the target leaf @iocg's to build pre-order traversal
+ * list of all the ancestors in @inner_walk. The inner nodes are linked through
+ * ->walk_list and the caller is responsible for dissolving the list after use.
+ */
+static void iocg_build_inner_walk(struct ioc_gq *iocg,
+				  struct list_head *inner_walk)
+{
+	int lvl;
+
+	WARN_ON_ONCE(!list_empty(&iocg->walk_list));
+
+	/* find the first ancestor which hasn't been visited yet */
+	for (lvl = iocg->level - 1; lvl >= 0; lvl--) {
+		if (!list_empty(&iocg->ancestors[lvl]->walk_list))
+			break;
+	}
+
+	/* walk down and visit the inner nodes to get pre-order traversal */
+	while (++lvl <= iocg->level - 1) {
+		struct ioc_gq *inner = iocg->ancestors[lvl];
+
+		/* record traversal order */
+		list_add_tail(&inner->walk_list, inner_walk);
+	}
+}
+
+/* collect per-cpu counters and propagate the deltas to the parent */
+static void iocg_flush_stat_one(struct ioc_gq *iocg, struct ioc_now *now)
+{
+	struct iocg_stat new_stat;
+	u64 abs_vusage = 0;
+	u64 vusage_delta;
+	int cpu;
+
+	lockdep_assert_held(&iocg->ioc->lock);
+
+	/* collect per-cpu counters */
+	for_each_possible_cpu(cpu) {
+		abs_vusage += local64_read(
+				per_cpu_ptr(&iocg->pcpu_stat->abs_vusage, cpu));
+	}
+	vusage_delta = abs_vusage - iocg->last_stat_abs_vusage;
+	iocg->last_stat_abs_vusage = abs_vusage;
+
+	iocg->local_stat.usage_us += div64_u64(vusage_delta, now->vrate);
+
+	new_stat.usage_us =
+		iocg->local_stat.usage_us + iocg->desc_stat.usage_us;
+
+	/* propagate the deltas to the parent */
+	if (iocg->level > 0) {
+		struct iocg_stat *parent_stat =
+			&iocg->ancestors[iocg->level - 1]->desc_stat;
+
+		parent_stat->usage_us +=
+			new_stat.usage_us - iocg->last_stat.usage_us;
+	}
+
+	iocg->last_stat = new_stat;
+}
+
+/* get stat counters ready for reading on all active iocgs */
+static void iocg_flush_stat(struct list_head *target_iocgs, struct ioc_now *now)
+{
+	LIST_HEAD(inner_walk);
+	struct ioc_gq *iocg, *tiocg;
+
+	/* flush leaves and build inner node walk list */
+	list_for_each_entry(iocg, target_iocgs, active_list) {
+		iocg_flush_stat_one(iocg, now);
+		iocg_build_inner_walk(iocg, &inner_walk);
+	}
+
+	/* keep flushing upwards by walking the inner list backwards */
+	list_for_each_entry_safe_reverse(iocg, tiocg, &inner_walk, walk_list) {
+		iocg_flush_stat_one(iocg, now);
+		list_del_init(&iocg->walk_list);
+	}
+}
+
 /* returns usage with margin added if surplus is large enough */
 static u32 surplus_adjusted_hweight_inuse(u32 usage, u32 hw_inuse)
 {
@@ -1422,6 +1527,8 @@ static void ioc_timer_fn(struct timer_list *timer)
 		return;
 	}
 
+	iocg_flush_stat(&ioc->active_iocgs, &now);
+
 	/*
 	 * Waiters determine the sleep durations based on the vrate they
 	 * saw at the time of sleep.  If vrate has increased, some waiters
@@ -1824,7 +1931,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	 */
 	if (!waitqueue_active(&iocg->waitq) && !iocg->abs_vdebt &&
 	    time_before_eq64(vtime + cost, now.vnow)) {
-		iocg_commit_bio(iocg, bio, cost);
+		iocg_commit_bio(iocg, bio, abs_cost, cost);
 		return;
 	}
 
@@ -1849,7 +1956,7 @@ static void ioc_rqos_throttle(struct rq_qos *rqos, struct bio *bio)
 	 */
 	if (unlikely(list_empty(&iocg->active_list))) {
 		iocg_unlock(iocg, ioc_locked, &flags);
-		iocg_commit_bio(iocg, bio, cost);
+		iocg_commit_bio(iocg, bio, abs_cost, cost);
 		return;
 	}
 
@@ -1948,7 +2055,7 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 	 */
 	if (rq->bio && rq->bio->bi_iocost_cost &&
 	    time_before_eq64(atomic64_read(&iocg->vtime) + cost, now.vnow)) {
-		iocg_commit_bio(iocg, bio, cost);
+		iocg_commit_bio(iocg, bio, abs_cost, cost);
 		return;
 	}
 
@@ -1962,7 +2069,7 @@ static void ioc_rqos_merge(struct rq_qos *rqos, struct request *rq,
 		iocg->abs_vdebt += abs_cost;
 		iocg_kick_delay(iocg, &now);
 	} else {
-		iocg_commit_bio(iocg, bio, cost);
+		iocg_commit_bio(iocg, bio, abs_cost, cost);
 	}
 	spin_unlock_irqrestore(&iocg->waitq.lock, flags);
 }
@@ -2133,6 +2240,12 @@ static struct blkg_policy_data *ioc_pd_alloc(gfp_t gfp, struct request_queue *q,
 	if (!iocg)
 		return NULL;
 
+	iocg->pcpu_stat = alloc_percpu_gfp(struct iocg_pcpu_stat, gfp);
+	if (!iocg->pcpu_stat) {
+		kfree(iocg);
+		return NULL;
+	}
+
 	return &iocg->pd;
 }
 
@@ -2152,6 +2265,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	atomic64_set(&iocg->done_vtime, now.vnow);
 	atomic64_set(&iocg->active_period, atomic64_read(&ioc->cur_period));
 	INIT_LIST_HEAD(&iocg->active_list);
+	INIT_LIST_HEAD(&iocg->walk_list);
 	iocg->hweight_active = WEIGHT_ONE;
 	iocg->hweight_inuse = WEIGHT_ONE;
 
@@ -2181,18 +2295,46 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 
 	if (ioc) {
 		spin_lock_irqsave(&ioc->lock, flags);
+
 		if (!list_empty(&iocg->active_list)) {
 			propagate_weights(iocg, 0, 0);
 			list_del_init(&iocg->active_list);
 		}
+
+		WARN_ON_ONCE(!list_empty(&iocg->walk_list));
+
 		spin_unlock_irqrestore(&ioc->lock, flags);
 
 		hrtimer_cancel(&iocg->waitq_timer);
 		hrtimer_cancel(&iocg->delay_timer);
 	}
+	free_percpu(iocg->pcpu_stat);
 	kfree(iocg);
 }
 
+static size_t ioc_pd_stat(struct blkg_policy_data *pd, char *buf, size_t size)
+{
+	struct ioc_gq *iocg = pd_to_iocg(pd);
+	struct ioc *ioc = iocg->ioc;
+	size_t pos = 0;
+
+	if (!ioc->enabled)
+		return 0;
+
+	if (iocg->level == 0) {
+		unsigned vp10k = DIV64_U64_ROUND_CLOSEST(
+			atomic64_read(&ioc->vtime_rate) * 10000,
+			VTIME_PER_USEC);
+		pos += scnprintf(buf + pos, size - pos, " cost.vrate=%u.%02u",
+				  vp10k / 100, vp10k % 100);
+	}
+
+	pos += scnprintf(buf + pos, size - pos, " cost.usage=%llu",
+			 iocg->last_stat.usage_us);
+
+	return pos;
+}
+
 static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 			     int off)
 {
@@ -2606,6 +2748,7 @@ static struct blkcg_policy blkcg_policy_iocost = {
 	.pd_alloc_fn	= ioc_pd_alloc,
 	.pd_init_fn	= ioc_pd_init,
 	.pd_free_fn	= ioc_pd_free,
+	.pd_stat_fn	= ioc_pd_stat,
 };
 
 static int __init ioc_init(void)
-- 
2.26.2

