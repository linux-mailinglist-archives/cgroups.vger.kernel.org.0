Return-Path: <cgroups+bounces-16694-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qRT/HGc8JmomTwIAu9opvQ
	(envelope-from <cgroups+bounces-16694-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 05:52:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C428E652843
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 05:52:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BGykHSqt;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16694-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16694-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEDA93037E47
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 03:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEC034CFC2;
	Mon,  8 Jun 2026 03:43:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ACD34B682;
	Mon,  8 Jun 2026 03:43:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890192; cv=none; b=h3X0bFY0GDYLTyk62lWsdfMvYKCGgiUaTjnNuxOrOeL2G0ro8n4W4AllOxqsDqJlWkRKW7Fj6ybImxsduzvlEm44sVKcpAjckLZr1td0HgaV/G4quNq1WGUIJcSYh05LJKilIitO3o++IGSqHeyv4wYcWifAgSLOwYdhgUAWIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890192; c=relaxed/simple;
	bh=FQcqdrQZfclPcwWJBU8oI/aYpBgYQZcEyQff4f2MG4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8jTGya8aEQnkWty3vpSdkMhWP/qnAfnk+mm7J/ujPAZUnhHSDSn+1y79Hg7JuTCv5UcdWb00731cYZa2oJHoBZPP9GmlUht4mKcVaptSBjMZ6z4b5LZE0bF9dvV9nIwhhQ6RINRBp5x+5+cZlHenu6Qi0JL+a9Nns3KgEEe/pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGykHSqt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF0C1F00893;
	Mon,  8 Jun 2026 03:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780890190;
	bh=Boc58LQ8eways719MPbdaMHI7qUS76tyUmczFyDCIns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGykHSqt6dcfNwZflW5GcYVWGTiKqD1A/i3JQJExaYJ2SKcKI6C9rkv81jJjuZf1x
	 gEcvN2f0iyk2SeyNnKus8r/dD7dZMjmA4kqN7hz3diXu3aA5ZLe9ATXPCGChp76SZV
	 e3F7LUMbCCy9+qcJyc5EZe+0sFyfNIME2oPXWm4O1H1lyIQTzEcW6IsLYGGpjVqnFt
	 3BtBYulFD/DoKo3JKb5JbKjcaSuy4y0TteaHXo96iVNlmf2n8P5GL/aUaQ+hRbMncz
	 9bQyEx7P4o7XTs1dPVSTmp78zNVuoRfeks8KXVO6qhXfvD2qDAO2In/6x+9O9hYBa0
	 HLfCIHUPPsiTg==
From: Yu Kuai <yukuai@kernel.org>
To: nilay@linux.ibm.com,
	tom.leiming@gmail.com,
	bvanassche@acm.org,
	tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	yukuai@fygo.io
Cc: akpm@linux-foundation.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()
Date: Mon,  8 Jun 2026 11:42:44 +0800
Message-ID: <db7633d5e263dd1c2bf9b901762545a84b7d714e.1780621988.git.yukuai@fygo.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780621988.git.yukuai@fygo.io>
References: <cover.1780621988.git.yukuai@fygo.io>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[fygo.io:mid,fygo.io:email];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16694-lists,cgroups=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20260515];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:nilay@linux.ibm.com,m:tom.leiming@gmail.com,m:bvanassche@acm.org,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,m:yukuai@fygo.io,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:baohua@kernel.org,m:youngjun.park@lge.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:tomleiming@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,gmail.com,acm.org,kernel.org,toxicpanda.com,kernel.dk,fygo.io];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@kernel.org,cgroups@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fygo.io:mid,fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C428E652843
X-Spam: Yes

From: Yu Kuai <yukuai@fygo.io>

With previous modification to delay freeing policy data after an RCU grace
period, prfill() can run under RCU instead of taking queue_lock. However,
policy teardown can still clear blkg->pd[plid] after blkcg_print_blkgs()
observes the policy enabled bit.

Load policy data once with READ_ONCE() and skip the blkg if teardown
already cleared it. Do the same in recursive stat walks for descendant
blkgs. Remove the stale BFQ debug queue_lock assertion because
blkcg_print_blkgs() no longer calls prfill() with queue_lock held. This
also lets ioc_qos_prfill() and ioc_cost_model_prfill() use IRQ-safe
ioc->lock locking without re-enabling IRQs while queue_lock is still held.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bfq-cgroup.c        |  8 +++++---
 block/blk-cgroup-rwstat.c | 15 +++++++++------
 block/blk-cgroup.c        | 22 +++++++++++++---------
 block/blk-cgroup.h        |  6 +++---
 block/blk-iocost.c        |  8 ++++----
 5 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 56f60e36c799..904d9e0d9029 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1146,20 +1146,22 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 	struct blkcg_gq *blkg = pd_to_blkg(pd);
 	struct blkcg_gq *pos_blkg;
 	struct cgroup_subsys_state *pos_css;
 	u64 sum = 0;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
-
 	rcu_read_lock();
 	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
+		struct blkg_policy_data *pd;
 		struct bfq_stat *stat;
 
 		if (!pos_blkg->online)
 			continue;
 
-		stat = (void *)blkg_to_pd(pos_blkg, &blkcg_policy_bfq) + off;
+		pd = blkg_to_pd(pos_blkg, &blkcg_policy_bfq);
+		if (!pd)
+			continue;
+		stat = (void *)pd + off;
 		sum += bfq_stat_read(stat) + atomic64_read(&stat->aux_cnt);
 	}
 	rcu_read_unlock();
 
 	return __blkg_prfill_u64(sf, pd, sum);
diff --git a/block/blk-cgroup-rwstat.c b/block/blk-cgroup-rwstat.c
index a55fb0c53558..aae910713814 100644
--- a/block/blk-cgroup-rwstat.c
+++ b/block/blk-cgroup-rwstat.c
@@ -99,26 +99,29 @@ void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
 {
 	struct blkcg_gq *pos_blkg;
 	struct cgroup_subsys_state *pos_css;
 	unsigned int i;
 
-	lockdep_assert_held(&blkg->q->queue_lock);
+	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	memset(sum, 0, sizeof(*sum));
-	rcu_read_lock();
 	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
 		struct blkg_rwstat *rwstat;
 
 		if (!pos_blkg->online)
 			continue;
 
-		if (pol)
-			rwstat = (void *)blkg_to_pd(pos_blkg, pol) + off;
-		else
+		if (pol) {
+			struct blkg_policy_data *pd = blkg_to_pd(pos_blkg, pol);
+
+			if (!pd)
+				continue;
+			rwstat = (void *)pd + off;
+		} else {
 			rwstat = (void *)pos_blkg + off;
+		}
 
 		for (i = 0; i < BLKG_RWSTAT_NR; i++)
 			sum->cnt[i] += blkg_rwstat_read_counter(rwstat, i);
 	}
-	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blkg_rwstat_recursive_sum);
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b55c43f72bcb..46fc65050c38 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -699,13 +699,13 @@ const char *blkg_dev_name(struct blkcg_gq *blkg)
  * @data: data to be passed to @prfill
  * @show_total: to print out sum of prfill return values or not
  *
  * This function invokes @prfill on each blkg of @blkcg if pd for the
  * policy specified by @pol exists.  @prfill is invoked with @sf, the
- * policy data and @data and the matching queue lock held.  If @show_total
- * is %true, the sum of the return values from @prfill is printed with
- * "Total" label at the end.
+ * policy data and @data under RCU read lock.  If @show_total is %true, the
+ * sum of the return values from @prfill is printed with "Total" label at the
+ * end.
  *
  * This is to be used to construct print functions for
  * cftype->read_seq_string method.
  */
 void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
@@ -717,14 +717,18 @@ void blkcg_print_blkgs(struct seq_file *sf, struct blkcg *blkcg,
 	struct blkcg_gq *blkg;
 	u64 total = 0;
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
-		spin_lock_irq(&blkg->q->queue_lock);
-		if (blkcg_policy_enabled(blkg->q, pol))
-			total += prfill(sf, blkg->pd[pol->plid], data);
-		spin_unlock_irq(&blkg->q->queue_lock);
+		struct blkg_policy_data *pd;
+
+		if (!blkcg_policy_enabled(blkg->q, pol))
+			continue;
+
+		pd = blkg_to_pd(blkg, pol);
+		if (pd)
+			total += prfill(sf, pd, data);
 	}
 	rcu_read_unlock();
 
 	if (show_total)
 		seq_printf(sf, "Total %llu\n", (unsigned long long)total);
@@ -1591,11 +1595,11 @@ static void blkcg_policy_teardown_pds(struct request_queue *q,
 		if (pd) {
 			if (pd->online && pol->pd_offline_fn)
 				pol->pd_offline_fn(pd);
 			pd->online = false;
 			pol->pd_free_fn(pd);
-			blkg->pd[pol->plid] = NULL;
+			WRITE_ONCE(blkg->pd[pol->plid], NULL);
 		}
 		spin_unlock(&blkcg->lock);
 	}
 }
 
@@ -1683,11 +1687,11 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 
 		spin_lock(&blkg->blkcg->lock);
 
 		pd->blkg = blkg;
 		pd->plid = pol->plid;
-		blkg->pd[pol->plid] = pd;
+		WRITE_ONCE(blkg->pd[pol->plid], pd);
 
 		if (pol->pd_init_fn)
 			pol->pd_init_fn(pd);
 
 		if (pol->pd_online_fn)
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index fd206d1fa3c9..5402b4ff6f3f 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -279,13 +279,13 @@ static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg,
  * @pol: policy of interest
  *
  * Return pointer to private data associated with the @blkg-@pol pair.
  */
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
-						  struct blkcg_policy *pol)
+						  const struct blkcg_policy *pol)
 {
-	return blkg ? blkg->pd[pol->plid] : NULL;
+	return blkg ? READ_ONCE(blkg->pd[pol->plid]) : NULL;
 }
 
 static inline struct blkcg_policy_data *blkcg_to_cpd(struct blkcg *blkcg,
 						     struct blkcg_policy *pol)
 {
@@ -488,11 +488,11 @@ static inline int blkcg_activate_policy(struct gendisk *disk,
 					const struct blkcg_policy *pol) { return 0; }
 static inline void blkcg_deactivate_policy(struct gendisk *disk,
 					   const struct blkcg_policy *pol) { }
 
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
-						  struct blkcg_policy *pol) { return NULL; }
+						  const struct blkcg_policy *pol) { return NULL; }
 static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
 static inline void blkg_get(struct blkcg_gq *blkg) { }
 static inline void blkg_put(struct blkcg_gq *blkg) { }
 static inline void blk_cgroup_bio_start(struct bio *bio) { }
 static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { return true; }
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index c136b1f46fcc..1f3f6e0f8901 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3188,11 +3188,11 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct ioc *ioc = pd_to_iocg(pd)->ioc;
 
 	if (!dname)
 		return 0;
 
-	spin_lock(&ioc->lock);
+	spin_lock_irq(&ioc->lock);
 	seq_printf(sf, "%s enable=%d ctrl=%s rpct=%u.%02u rlat=%u wpct=%u.%02u wlat=%u min=%u.%02u max=%u.%02u\n",
 		   dname, ioc->enabled, ioc->user_qos_params ? "user" : "auto",
 		   ioc->params.qos[QOS_RPPM] / 10000,
 		   ioc->params.qos[QOS_RPPM] % 10000 / 100,
 		   ioc->params.qos[QOS_RLAT],
@@ -3201,11 +3201,11 @@ static u64 ioc_qos_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 		   ioc->params.qos[QOS_WLAT],
 		   ioc->params.qos[QOS_MIN] / 10000,
 		   ioc->params.qos[QOS_MIN] % 10000 / 100,
 		   ioc->params.qos[QOS_MAX] / 10000,
 		   ioc->params.qos[QOS_MAX] % 10000 / 100);
-	spin_unlock(&ioc->lock);
+	spin_unlock_irq(&ioc->lock);
 	return 0;
 }
 
 static int ioc_qos_show(struct seq_file *sf, void *v)
 {
@@ -3386,18 +3386,18 @@ static u64 ioc_cost_model_prfill(struct seq_file *sf,
 	u64 *u = ioc->params.i_lcoefs;
 
 	if (!dname)
 		return 0;
 
-	spin_lock(&ioc->lock);
+	spin_lock_irq(&ioc->lock);
 	seq_printf(sf, "%s ctrl=%s model=linear "
 		   "rbps=%llu rseqiops=%llu rrandiops=%llu "
 		   "wbps=%llu wseqiops=%llu wrandiops=%llu\n",
 		   dname, ioc->user_cost_model ? "user" : "auto",
 		   u[I_LCOEF_RBPS], u[I_LCOEF_RSEQIOPS], u[I_LCOEF_RRANDIOPS],
 		   u[I_LCOEF_WBPS], u[I_LCOEF_WSEQIOPS], u[I_LCOEF_WRANDIOPS]);
-	spin_unlock(&ioc->lock);
+	spin_unlock_irq(&ioc->lock);
 	return 0;
 }
 
 static int ioc_cost_model_show(struct seq_file *sf, void *v)
 {
-- 
2.51.0


