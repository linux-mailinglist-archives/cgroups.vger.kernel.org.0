Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132ED53AB5B
	for <lists+cgroups@lfdr.de>; Wed,  1 Jun 2022 18:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353744AbiFAQxp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 12:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353699AbiFAQxo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 12:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AF8C65D36
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 09:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654102422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYJ4Au8LKvlxbIQX28uISQmDIvtY4t/cHh1fBYMvRCE=;
        b=C8wCHy1vQzhfxzq1iBK5YZ5gRyzoMve9I2s/pdhqyHNYabGHLQGM3Yi5ny34kUQ4P3FXBH
        wShy8ZYenViOMP3rlfNQjlmAvESsnUg3ExOanpArd2ZRMa5rXik6fZOxAIPg/fgLAFOjWP
        fCXphHSm2HodIJXFh/0CDBsd6tqWi8A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-5qLThSp6O4CJHxO64PblTA-1; Wed, 01 Jun 2022 12:53:39 -0400
X-MC-Unique: 5qLThSp6O4CJHxO64PblTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15DAE3801141;
        Wed,  1 Jun 2022 16:53:39 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4B7E82882;
        Wed,  1 Jun 2022 16:53:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] blk-cgroup: Optimize blkcg_rstat_flush()
Date:   Wed,  1 Jun 2022 12:53:24 -0400
Message-Id: <20220601165324.60892-2-longman@redhat.com>
In-Reply-To: <20220601165324.60892-1-longman@redhat.com>
References: <20220601165324.60892-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For a system with many CPUs and block devices, the time to do
blkcg_rstat_flush() from cgroup_rstat_flush() can be rather long. It
can be especially problematic as interrupt is disabled during the flush.
It was reported that it might take seconds to complete in some extreme
cases leading to hard lockup messages.

As it is likely that not all the percpu blkg_iostat_set's has been
updated since the last flush, those stale blkg_iostat_set's don't need
to be flushed in this case. This patch optimizes blkcg_rstat_flush()
by keeping a lockless list of recently updated blkg_iostat_set's in a
newly added percpu blkcg->lhead pointer.

The blkg_iostat_set is added to the lockless list on the update side
in blk_cgroup_bio_start(). It is removed from the lockless list when
flushed in blkcg_rstat_flush(). Due to racing, it is possible that
blk_iostat_set's in the lockless list may have no new iostat's to
be flushed.

A blkg_iostat_set can determine if it is in a lockless list by checking
the content of its lnode.next pointer which will be non-NULL when in
a lockless list. This requires the presence of a special llist_last
sentinel to be put at the end of the lockless list.

When booting up an instrumented test kernel with this patch on a
2-socket 96-thread system with cgroup v2, out of the 2051 calls to
cgroup_rstat_flush() after bootup, 1788 of the calls were exited
immediately because of empty lockless list. After an all-cpu kernel
build, the ratio became 6295424/6340513. That was more than 99%.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-cgroup.c | 74 ++++++++++++++++++++++++++++++++++++++++------
 block/blk-cgroup.h |  9 ++++++
 2 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index acd9b0aa8dc8..fcdac724970c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -59,6 +59,40 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
 
 #define BLKG_DESTROY_BATCH_SIZE  64
 
+static struct llist_node llist_last;	/* Last sentinel node of llist */
+
+static inline bool blkcg_llist_empty(struct llist_head *lhead)
+{
+	return lhead->first == &llist_last;
+}
+
+static inline void init_blkcg_llists(struct blkcg *blkcg)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		per_cpu_ptr(blkcg->lhead, cpu)->first = &llist_last;
+}
+
+static inline struct llist_node *
+fetch_delete_blkcg_llist(struct llist_head *lhead)
+{
+	return xchg(&lhead->first, &llist_last);
+}
+
+/*
+ * The retrieved blkg_iostat_set is immediately marked as not in the
+ * lockless list by clearing its node->next pointer. It could be put
+ * back into the list by a parallel update before the iostat's are
+ * finally flushed. So being in the list doesn't always mean it has new
+ * iostat's to be flushed.
+ */
+#define blkcg_llist_for_each_entry_safe(pos, node, nxt)			\
+	for (; (node != &llist_last) &&					\
+	       (pos = llist_entry(node, struct blkg_iostat_set, lnode),	\
+		nxt = node->next, node->next = NULL, true);		\
+		node = nxt)
+
 /**
  * blkcg_css - find the current css
  *
@@ -236,8 +270,10 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	blkg->blkcg = blkcg;
 
 	u64_stats_init(&blkg->iostat.sync);
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
+		per_cpu_ptr(blkg->iostat_cpu, cpu)->blkg = blkg;
+	}
 
 	for (i = 0; i < BLKCG_MAX_POLS; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
@@ -852,17 +888,26 @@ static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
 static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg_gq *blkg;
+	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
+	struct llist_node *lnode, *lnext;
+	struct blkg_iostat_set *bisc;
 
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(css->cgroup))
 		return;
 
-	rcu_read_lock();
+	if (blkcg_llist_empty(lhead))
+		return;
 
-	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
+	lnode = fetch_delete_blkcg_llist(lhead);
+
+	/*
+	 * No RCU protection is needed as it is assumed that blkg_iostat_set's
+	 * in the percpu lockless list won't go away until the flush is done.
+	 */
+	blkcg_llist_for_each_entry_safe(bisc, lnode, lnext) {
+		struct blkcg_gq *blkg = bisc->blkg;
 		struct blkcg_gq *parent = blkg->parent;
-		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
 		struct blkg_iostat cur, delta;
 		unsigned long flags;
 		unsigned int seq;
@@ -891,8 +936,6 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			u64_stats_update_end_irqrestore(&parent->iostat.sync, flags);
 		}
 	}
-
-	rcu_read_unlock();
 }
 
 /*
@@ -1192,6 +1235,11 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 		}
 	}
 
+	blkcg->lhead = alloc_percpu_gfp(struct llist_head, GFP_KERNEL);
+	if (!blkcg->lhead)
+		goto free_blkcg;
+	init_blkcg_llists(blkcg);
+
 	for (i = 0; i < BLKCG_MAX_POLS ; i++) {
 		struct blkcg_policy *pol = blkcg_policy[i];
 		struct blkcg_policy_data *cpd;
@@ -1233,7 +1281,8 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 	for (i--; i >= 0; i--)
 		if (blkcg->cpd[i])
 			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
-
+	free_percpu(blkcg->lhead);
+free_blkcg:
 	if (blkcg != &blkcg_root)
 		kfree(blkcg);
 unlock:
@@ -1997,6 +2046,7 @@ static int blk_cgroup_io_type(struct bio *bio)
 
 void blk_cgroup_bio_start(struct bio *bio)
 {
+	struct blkcg *blkcg = bio->bi_blkg->blkcg;
 	int rwd = blk_cgroup_io_type(bio), cpu;
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
@@ -2015,9 +2065,15 @@ void blk_cgroup_bio_start(struct bio *bio)
 	}
 	bis->cur.ios[rwd]++;
 
+	if (!bis->lnode.next) {
+		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
+
+		llist_add(&bis->lnode, lhead);
+	}
+
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
-		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
+		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
 	put_cpu();
 }
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d4de0a35e066..65ac38e0708a 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -18,6 +18,7 @@
 #include <linux/cgroup.h>
 #include <linux/kthread.h>
 #include <linux/blk-mq.h>
+#include <linux/llist.h>
 
 struct blkcg_gq;
 struct blkg_policy_data;
@@ -43,8 +44,10 @@ struct blkg_iostat {
 
 struct blkg_iostat_set {
 	struct u64_stats_sync		sync;
+	struct llist_node		lnode;
 	struct blkg_iostat		cur;
 	struct blkg_iostat		last;
+	struct blkcg_gq		       *blkg;
 };
 
 /* association between a blk cgroup and a request queue */
@@ -97,6 +100,12 @@ struct blkcg {
 	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
 
 	struct list_head		all_blkcgs_node;
+
+	/*
+	 * List of updated percpu blkg_iostat_set's since the last flush.
+	 */
+	struct llist_head __percpu	*lhead;
+
 #ifdef CONFIG_BLK_CGROUP_FC_APPID
 	char                            fc_app_id[FC_APPID_LEN];
 #endif
-- 
2.31.1

