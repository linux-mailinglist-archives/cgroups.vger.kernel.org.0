Return-Path: <cgroups+bounces-16693-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BvK2Lks8JmoSTwIAu9opvQ
	(envelope-from <cgroups+bounces-16693-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 05:51:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCBB652816
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 05:51:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YLcEnJ6r;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16693-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16693-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30E2C302F38C
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 03:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793F834CFA7;
	Mon,  8 Jun 2026 03:43:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6602820AC;
	Mon,  8 Jun 2026 03:43:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780890187; cv=none; b=gOfkT/16lR5yw/qeBcR62IyFMkRsB/w0WGsdF34TYXJl0cYRdEAc22eWVAQMbB1IcEmr903Cha6Aw1/guWGnxc0mLIMV+vwJhhJPKM5r8fMk5kEXLCDvZQ0I0IwTgkflTs9/CGnnMIKyRG7l0ciD4kNyIn0YgXks7ELO8dym6ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780890187; c=relaxed/simple;
	bh=hso4sb8tKMPjNJgEnRdos9bv8OkUqSV9NUmFYCarf+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRcegFlOWwkUjr8xyWDg5WYKkvTn2HwKI3xAykN8OCQ8inEFW3jW3bzh/lbD6gPqy1LGalUCZZ+ZVRsIwMFH43A3rX1x7LK5DbmNyDJEAsiBz87OoUk//GcCn7JSkpJfZm8nUAvzGIQAONDexl8O5g+mjm1w/mbTKUxnGnbCStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLcEnJ6r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EE71F00899;
	Mon,  8 Jun 2026 03:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780890185;
	bh=1hTBs93fx+NbCSeVyVNxz5n85uGxtYn/Sbx45vo9Kgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YLcEnJ6rbEwe6kb0bDhr5znxOm3FiQdH0IHu3VNVC3u4JtQExIVMbN5gDnLN6+88y
	 TbAKMqqoFHpPmdkivLGrmrSFciAXauyxsUswFMrtauGKTSqTrianUeyRrjDFnIBrFg
	 LkT6tXcA+d1jXzBX7cZxzrvjeuoeN62S6mORmgUJxS2Vga5BpxNle0wQ28pmjISLRM
	 rrGPSkZqDtesR5xfyQvmIqcbV991IafyL9bXzRCUE3ahdQfNm+JaJQJy/iqn7c5HTD
	 rOFEl887SMJDZhkIDG+0IN/DoXFJQJ27ZzYLr1dmDgMLuOvxii2EJWT+Wi3H30HqQ7
	 o6LnuxYqWR5pQ==
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
Subject: [PATCH 2/8] blk-cgroup: delay freeing policy data after rcu grace period
Date: Mon,  8 Jun 2026 11:42:43 +0800
Message-ID: <e20e5d984b41a026d61851966bed35eb094c4bff.1780621988.git.yukuai@fygo.io>
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
	TAGGED_FROM(0.00)[bounces-16693-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 2BCBB652816
X-Spam: Yes

From: Yu Kuai <yukuai@fygo.io>

Currently blkcg_print_blkgs() must hold RCU to iterate blkgs from a
blkcg, and prfill() must hold queue_lock to prevent policy data from
being freed by policy deactivation. As a consequence, queue_lock has to
be nested under RCU from blkcg_print_blkgs().

Delay freeing policy data until after an RCU grace period so prfill() can
be protected by RCU alone.

Signed-off-by: Yu Kuai <yukuai@fygo.io>
---
 block/bfq-cgroup.c    |  9 ++++++++-
 block/blk-cgroup.h    |  2 ++
 block/blk-iocost.c    | 14 ++++++++++++--
 block/blk-iolatency.c | 10 +++++++++-
 block/blk-throttle.c  | 13 +++++++++++--
 5 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index f765e767d36a..56f60e36c799 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -548,17 +548,24 @@ static void bfq_pd_init(struct blkg_policy_data *pd)
 	bfqg->active_entities = 0;
 	bfqg->num_queues_with_pending_reqs = 0;
 	bfqg->rq_pos_tree = RB_ROOT;
 }
 
-static void bfq_pd_free(struct blkg_policy_data *pd)
+static void bfqg_release(struct rcu_head *rcu)
 {
+	struct blkg_policy_data *pd =
+		container_of(rcu, struct blkg_policy_data, rcu_head);
 	struct bfq_group *bfqg = pd_to_bfqg(pd);
 
 	bfqg_put(bfqg);
 }
 
+static void bfq_pd_free(struct blkg_policy_data *pd)
+{
+	call_rcu(&pd->rcu_head, bfqg_release);
+}
+
 static void bfq_pd_reset_stats(struct blkg_policy_data *pd)
 {
 	struct bfq_group *bfqg = pd_to_bfqg(pd);
 
 	bfqg_stats_reset(&bfqg->stats);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 1cce3294634d..fd206d1fa3c9 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -138,10 +138,12 @@ static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
 struct blkg_policy_data {
 	/* the blkg and policy id this per-policy data belongs to */
 	struct blkcg_gq			*blkg;
 	int				plid;
 	bool				online;
+
+	struct rcu_head			rcu_head;
 };
 
 /*
  * Policies that need to keep per-blkcg data which is independent from any
  * request_queue associated to it should implement cpd_alloc/free_fn()
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 0cca88a366dc..c136b1f46fcc 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3024,10 +3024,20 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	spin_lock_irqsave(&ioc->lock, flags);
 	weight_updated(iocg, &now);
 	spin_unlock_irqrestore(&ioc->lock, flags);
 }
 
+static void iocg_release(struct rcu_head *rcu)
+{
+	struct blkg_policy_data *pd =
+		container_of(rcu, struct blkg_policy_data, rcu_head);
+	struct ioc_gq *iocg = pd_to_iocg(pd);
+
+	free_percpu(iocg->pcpu_stat);
+	kfree(iocg);
+}
+
 static void ioc_pd_free(struct blkg_policy_data *pd)
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 	struct ioc *ioc = iocg->ioc;
 	unsigned long flags;
@@ -3048,12 +3058,12 @@ static void ioc_pd_free(struct blkg_policy_data *pd)
 
 		spin_unlock_irqrestore(&ioc->lock, flags);
 
 		hrtimer_cancel(&iocg->waitq_timer);
 	}
-	free_percpu(iocg->pcpu_stat);
-	kfree(iocg);
+
+	call_rcu(&pd->rcu_head, iocg_release);
 }
 
 static void ioc_pd_stat(struct blkg_policy_data *pd, struct seq_file *s)
 {
 	struct ioc_gq *iocg = pd_to_iocg(pd);
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 53e8dd2dfa8a..c79056410cd9 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -1026,17 +1026,25 @@ static void iolatency_pd_offline(struct blkg_policy_data *pd)
 
 	iolatency_set_min_lat_nsec(blkg, 0);
 	iolatency_clear_scaling(blkg);
 }
 
-static void iolatency_pd_free(struct blkg_policy_data *pd)
+static void iolat_release(struct rcu_head *rcu)
 {
+	struct blkg_policy_data *pd =
+		container_of(rcu, struct blkg_policy_data, rcu_head);
 	struct iolatency_grp *iolat = pd_to_lat(pd);
+
 	free_percpu(iolat->stats);
 	kfree(iolat);
 }
 
+static void iolatency_pd_free(struct blkg_policy_data *pd)
+{
+	call_rcu(&pd->rcu_head, iolat_release);
+}
+
 static struct cftype iolatency_files[] = {
 	{
 		.name = "latency",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.seq_show = iolatency_print_limit,
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index cabf91f0d0dc..0f89fb03cdb6 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -351,20 +351,29 @@ static void throtl_pd_online(struct blkg_policy_data *pd)
 	 * Update has_rules[] after a new group is brought online.
 	 */
 	tg_update_has_rules(tg);
 }
 
-static void throtl_pd_free(struct blkg_policy_data *pd)
+static void tg_release(struct rcu_head *rcu)
 {
+	struct blkg_policy_data *pd =
+		container_of(rcu, struct blkg_policy_data, rcu_head);
 	struct throtl_grp *tg = pd_to_tg(pd);
 
-	timer_delete_sync(&tg->service_queue.pending_timer);
 	blkg_rwstat_exit(&tg->stat_bytes);
 	blkg_rwstat_exit(&tg->stat_ios);
 	kfree(tg);
 }
 
+static void throtl_pd_free(struct blkg_policy_data *pd)
+{
+	struct throtl_grp *tg = pd_to_tg(pd);
+
+	timer_delete_sync(&tg->service_queue.pending_timer);
+	call_rcu(&pd->rcu_head, tg_release);
+}
+
 static struct throtl_grp *
 throtl_rb_first(struct throtl_service_queue *parent_sq)
 {
 	struct rb_node *n;
 
-- 
2.51.0

