Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A935E50800B
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354186AbiDTEai (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiDTEah (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651802DE0;
        Tue, 19 Apr 2022 21:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5PXSyJAzHV7uFeiLXgGgxqQZ/k9tTTZACI9OTb/gOAo=; b=OzsqHfRQK4fDQDHvwoJbWuZi9w
        DuS3GcTpseVpiS4yvDKe48F1r9RretxcSrbG+Ll/gfD2O3c3H+C4VKmmeFpXqubITFZOABIIAoknv
        qRSWDtGDcZEFwBNxPHw8IftQ3tTfEWg4XIwFQouLks47devgW0bb4gyajHtJNkWiD+MzFvf3hKGOX
        oDVe6WJnOqiZghtl/gPwAQYtcthC5MNyAuZzoPJOOUOI8pMa99NZHi+X8Jfi7/Ko8004XiAllEYkA
        9U1DgvHpib+NeP3D58w6YiaKAU4ygrPP5zQqEFaLFq4cti14ArQmUVE9QXMlpsqSJmyYyYDdCF9GT
        70SWmpfw==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wT-007FN9-Jl; Wed, 20 Apr 2022 04:27:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 07/15] blk-cgroup: move struct blkcg to block/blk-cgroup.h
Date:   Wed, 20 Apr 2022 06:27:15 +0200
Message-Id: <20220420042723.1010598-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There is no real need to expose the blkcg structure to the whole kernel.
Move it to the private header an expose a helper to let the writeback
code access the cgwb_list member.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c          |  9 ++++++++-
 block/blk-cgroup.h          | 28 ++++++++++++++++++++++++++++
 include/linux/backing-dev.h |  6 ++----
 include/linux/blk-cgroup.h  | 32 +-------------------------------
 mm/backing-dev.c            | 13 ++++++-------
 5 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3af0d4a619550..bb52797c02bd7 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1005,6 +1005,13 @@ static struct cftype blkcg_legacy_files[] = {
 	{ }	/* terminate */
 };
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css)
+{
+	return &css_to_blkcg(css)->cgwb_list;
+}
+#endif
+
 /*
  * blkcg destruction is a three-stage process.
  *
@@ -1112,7 +1119,7 @@ void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css)
 static void blkcg_css_offline(struct cgroup_subsys_state *css)
 {
 	/* this prevents anyone from attaching or migrating to this blkcg */
-	wb_blkcg_offline(css_to_blkcg(css));
+	wb_blkcg_offline(css);
 
 	/* put the base online pin allowing step 2 to be triggered */
 	blkcg_unpin_online(css);
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 49e88fc9cc391..b00fb1169e7ce 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -17,10 +17,38 @@
 #include <linux/blk-cgroup.h>
 #include <linux/blk-mq.h>
 
+struct blkcg_gq;
+struct blkg_policy_data;
+
+
 /* percpu_counter batch for blkg_[rw]stats, per-cpu drift doesn't matter */
 #define BLKG_STAT_CPU_BATCH	(INT_MAX / 2)
 
 #ifdef CONFIG_BLK_CGROUP
+struct blkcg {
+	struct cgroup_subsys_state	css;
+	spinlock_t			lock;
+	refcount_t			online_pin;
+
+	struct radix_tree_root		blkg_tree;
+	struct blkcg_gq	__rcu		*blkg_hint;
+	struct hlist_head		blkg_list;
+
+	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
+
+	struct list_head		all_blkcgs_node;
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
+	char                            fc_app_id[FC_APPID_LEN];
+#endif
+#ifdef CONFIG_CGROUP_WRITEBACK
+	struct list_head		cgwb_list;
+#endif
+};
+
+static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct blkcg, css) : NULL;
+}
 
 /*
  * A blkcg_gq (blkg) is association between a block cgroup (blkcg) and a
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 87ce24d238f34..2bd073fa6bb53 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -17,8 +17,6 @@
 #include <linux/backing-dev-defs.h>
 #include <linux/slab.h>
 
-struct blkcg;
-
 static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 {
 	kref_get(&bdi->refcnt);
@@ -154,7 +152,7 @@ struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp);
 void wb_memcg_offline(struct mem_cgroup *memcg);
-void wb_blkcg_offline(struct blkcg *blkcg);
+void wb_blkcg_offline(struct cgroup_subsys_state *css);
 
 /**
  * inode_cgwb_enabled - test whether cgroup writeback is enabled on an inode
@@ -378,7 +376,7 @@ static inline void wb_memcg_offline(struct mem_cgroup *memcg)
 {
 }
 
-static inline void wb_blkcg_offline(struct blkcg *blkcg)
+static inline void wb_blkcg_offline(struct cgroup_subsys_state *css)
 {
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 0fb7459096e9f..d7b1880950402 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -37,29 +37,6 @@ enum blkg_iostat_type {
 	BLKG_IOSTAT_NR,
 };
 
-struct blkcg_gq;
-struct blkg_policy_data;
-
-struct blkcg {
-	struct cgroup_subsys_state	css;
-	spinlock_t			lock;
-	refcount_t			online_pin;
-
-	struct radix_tree_root		blkg_tree;
-	struct blkcg_gq	__rcu		*blkg_hint;
-	struct hlist_head		blkg_list;
-
-	struct blkcg_policy_data	*cpd[BLKCG_MAX_POLS];
-
-	struct list_head		all_blkcgs_node;
-#ifdef CONFIG_BLK_CGROUP_FC_APPID
-	char                            fc_app_id[FC_APPID_LEN];
-#endif
-#ifdef CONFIG_CGROUP_WRITEBACK
-	struct list_head		cgwb_list;
-#endif
-};
-
 struct blkg_iostat {
 	u64				bytes[BLKG_IOSTAT_NR];
 	u64				ios[BLKG_IOSTAT_NR];
@@ -114,11 +91,6 @@ extern struct cgroup_subsys_state * const blkcg_root_css;
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
 
-static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct blkcg, css) : NULL;
-}
-
 /**
  * bio_blkcg - grab the blkcg associated with a bio
  * @bio: target bio
@@ -137,12 +109,10 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 bool blk_cgroup_congested(void);
 void blkcg_pin_online(struct cgroup_subsys_state *blkcg_css);
 void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css);
+struct list_head *blkcg_get_cgwb_list(struct cgroup_subsys_state *css);
 
 #else	/* CONFIG_BLK_CGROUP */
 
-struct blkcg {
-};
-
 struct blkcg_gq {
 };
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 93cddbcd4eb83..98f8f62e52ca5 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -445,7 +445,6 @@ static int cgwb_create(struct backing_dev_info *bdi,
 {
 	struct mem_cgroup *memcg;
 	struct cgroup_subsys_state *blkcg_css;
-	struct blkcg *blkcg;
 	struct list_head *memcg_cgwb_list, *blkcg_cgwb_list;
 	struct bdi_writeback *wb;
 	unsigned long flags;
@@ -453,9 +452,8 @@ static int cgwb_create(struct backing_dev_info *bdi,
 
 	memcg = mem_cgroup_from_css(memcg_css);
 	blkcg_css = cgroup_get_e_css(memcg_css->cgroup, &io_cgrp_subsys);
-	blkcg = css_to_blkcg(blkcg_css);
 	memcg_cgwb_list = &memcg->cgwb_list;
-	blkcg_cgwb_list = &blkcg->cgwb_list;
+	blkcg_cgwb_list = blkcg_get_cgwb_list(blkcg_css);
 
 	/* look up again under lock and discard on blkcg mismatch */
 	spin_lock_irqsave(&cgwb_lock, flags);
@@ -723,18 +721,19 @@ void wb_memcg_offline(struct mem_cgroup *memcg)
 
 /**
  * wb_blkcg_offline - kill all wb's associated with a blkcg being offlined
- * @blkcg: blkcg being offlined
+ * @css: blkcg being offlined
  *
  * Also prevents creation of any new wb's associated with @blkcg.
  */
-void wb_blkcg_offline(struct blkcg *blkcg)
+void wb_blkcg_offline(struct cgroup_subsys_state *css)
 {
 	struct bdi_writeback *wb, *next;
+	struct list_head *list = blkcg_get_cgwb_list(css);
 
 	spin_lock_irq(&cgwb_lock);
-	list_for_each_entry_safe(wb, next, &blkcg->cgwb_list, blkcg_node)
+	list_for_each_entry_safe(wb, next, list, blkcg_node)
 		cgwb_kill(wb);
-	blkcg->cgwb_list.next = NULL;	/* prevent new wb's */
+	list->next = NULL;	/* prevent new wb's */
 	spin_unlock_irq(&cgwb_lock);
 }
 
-- 
2.30.2

