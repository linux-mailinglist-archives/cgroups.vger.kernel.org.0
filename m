Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4499B6C992C
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 02:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjC0AuG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Mar 2023 20:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjC0AuF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Mar 2023 20:50:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF5C49C4;
        Sun, 26 Mar 2023 17:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TPw9qrw+C0d4LOLpjPe9aVmo+/5e3HxItkaDq8wloFA=; b=4vrmrwRpsZO8U0EKNDKDMw5zwh
        fi5ZJAzbcBpFqwrFAB7R7lp2nm5oBSbzX4GHd6gZqDz/l/2niTJkc+XSaWj3aUZDH1vMu83I9jR65
        h6cOAokyHsmXa+5SICeJV3lpGKwf/DzlOZU7y6z3SNXiz929Q51mpkg6cRy4KSGW2uudozCFNi9m2
        5q7f+YRCE4wQdMJaO12lnR+qWpnoU2CS5ds4J21WkhczLbiO0l3/ZqPkOQ0Wvx7+zLvvck7pYoq8k
        6PdwWaVi+mpOL6j02yB8VvDS3n+wwV7LKS74C/Q2bJjHLE/MnGRGHQ2aWT3Qhx063QZyV5TYJO9k9
        U9/IkFqw==;
Received: from i114-182-241-148.s41.a014.ap.plala.or.jp ([114.182.241.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgb3h-009QuY-0Z;
        Mon, 27 Mar 2023 00:50:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] block: make blkcg_punt_bio_submit optional
Date:   Mon, 27 Mar 2023 09:49:53 +0900
Message-Id: <20230327004954.728797-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327004954.728797-1-hch@lst.de>
References: <20230327004954.728797-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Guard all the code to punt bios to a per-cgroup submission helper by a
new CONFIG_BLK_CGROUP_PUNT_BIO symbol that is selected by btrfs.
This way non-btrfs kernel builds don't need to have this code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig      |  3 ++
 block/blk-cgroup.c | 77 +++++++++++++++++++++++++---------------------
 block/blk-cgroup.h |  3 +-
 fs/btrfs/Kconfig   |  1 +
 4 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 941b2dca70db73..69ccf7457ae110 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -41,6 +41,9 @@ config BLK_RQ_ALLOC_TIME
 config BLK_CGROUP_RWSTAT
 	bool
 
+config BLK_CGROUP_PUNT_BIO
+	bool
+
 config BLK_DEV_BSG_COMMON
 	tristate
 
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c524ecab440b8f..18c922579719b5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -56,7 +56,6 @@ static struct blkcg_policy *blkcg_policy[BLKCG_MAX_POLS];
 static LIST_HEAD(all_blkcgs);		/* protected by blkcg_pol_mutex */
 
 bool blkcg_debug_stats = false;
-static struct workqueue_struct *blkcg_punt_bio_wq;
 
 #define BLKG_DESTROY_BATCH_SIZE  64
 
@@ -166,7 +165,9 @@ static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
 
+#ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	WARN_ON(!bio_list_empty(&blkg->async_bios));
+#endif
 
 	/* release the blkcg and parent blkg refs this blkg has been holding */
 	css_put(&blkg->blkcg->css);
@@ -188,6 +189,9 @@ static void blkg_release(struct percpu_ref *ref)
 	call_rcu(&blkg->rcu_head, __blkg_release);
 }
 
+#ifdef CONFIG_BLK_CGROUP_PUNT_BIO
+static struct workqueue_struct *blkcg_punt_bio_wq;
+
 static void blkg_async_bio_workfn(struct work_struct *work)
 {
 	struct blkcg_gq *blkg = container_of(work, struct blkcg_gq,
@@ -214,6 +218,40 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 		blk_finish_plug(&plug);
 }
 
+/*
+ * When a shared kthread issues a bio for a cgroup, doing so synchronously can
+ * lead to priority inversions as the kthread can be trapped waiting for that
+ * cgroup.  Use this helper instead of submit_bio to punt the actual issuing to
+ * a dedicated per-blkcg work item to avoid such priority inversions.
+ */
+void blkcg_punt_bio_submit(struct bio *bio)
+{
+	struct blkcg_gq *blkg = bio->bi_blkg;
+
+	if (blkg->parent) {
+		spin_lock(&blkg->async_bio_lock);
+		bio_list_add(&blkg->async_bios, bio);
+		spin_unlock(&blkg->async_bio_lock);
+		queue_work(blkcg_punt_bio_wq, &blkg->async_bio_work);
+	} else {
+		/* never bounce for the root cgroup */
+		submit_bio(bio);
+	}
+}
+EXPORT_SYMBOL_GPL(blkcg_punt_bio_submit);
+
+static int __init blkcg_punt_bio_init(void)
+{
+	blkcg_punt_bio_wq = alloc_workqueue("blkcg_punt_bio",
+					    WQ_MEM_RECLAIM | WQ_FREEZABLE |
+					    WQ_UNBOUND | WQ_SYSFS, 0);
+	if (!blkcg_punt_bio_wq)
+		return -ENOMEM;
+	return 0;
+}
+subsys_initcall(blkcg_punt_bio_init);
+#endif /* CONFIG_BLK_CGROUP_PUNT_BIO */
+
 /**
  * bio_blkcg_css - return the blkcg CSS associated with a bio
  * @bio: target bio
@@ -269,10 +307,12 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 
 	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
+	blkg->blkcg = blkcg;
+#ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	spin_lock_init(&blkg->async_bio_lock);
 	bio_list_init(&blkg->async_bios);
 	INIT_WORK(&blkg->async_bio_work, blkg_async_bio_workfn);
-	blkg->blkcg = blkcg;
+#endif
 
 	u64_stats_init(&blkg->iostat.sync);
 	for_each_possible_cpu(cpu) {
@@ -1688,28 +1728,6 @@ void blkcg_policy_unregister(struct blkcg_policy *pol)
 }
 EXPORT_SYMBOL_GPL(blkcg_policy_unregister);
 
-/*
- * When a shared kthread issues a bio for a cgroup, doing so synchronously can
- * lead to priority inversions as the kthread can be trapped waiting for that
- * cgroup.  Use this helper instead of submit_bio to punt the actual issuing to
- * a dedicated per-blkcg work item to avoid such priority inversions.
- */
-void blkcg_punt_bio_submit(struct bio *bio)
-{
-	struct blkcg_gq *blkg = bio->bi_blkg;
-
-	if (blkg->parent) {
-		spin_lock(&blkg->async_bio_lock);
-		bio_list_add(&blkg->async_bios, bio);
-		spin_unlock(&blkg->async_bio_lock);
-		queue_work(blkcg_punt_bio_wq, &blkg->async_bio_work);
-	} else {
-		/* never bounce for the root cgroup */
-		submit_bio(bio);
-	}
-}
-EXPORT_SYMBOL_GPL(blkcg_punt_bio_submit);
-
 /*
  * Scale the accumulated delay based on how long it has been since we updated
  * the delay.  We only call this when we are adding delay, in case it's been a
@@ -2088,16 +2106,5 @@ bool blk_cgroup_congested(void)
 	return ret;
 }
 
-static int __init blkcg_init(void)
-{
-	blkcg_punt_bio_wq = alloc_workqueue("blkcg_punt_bio",
-					    WQ_MEM_RECLAIM | WQ_FREEZABLE |
-					    WQ_UNBOUND | WQ_SYSFS, 0);
-	if (!blkcg_punt_bio_wq)
-		return -ENOMEM;
-	return 0;
-}
-subsys_initcall(blkcg_init);
-
 module_param(blkcg_debug_stats, bool, 0644);
 MODULE_PARM_DESC(blkcg_debug_stats, "True if you want debug stats, false if not");
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 64758ab9f1f134..e98d2c1be35415 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -72,9 +72,10 @@ struct blkcg_gq {
 	struct blkg_iostat_set		iostat;
 
 	struct blkg_policy_data		*pd[BLKCG_MAX_POLS];
-
+#ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	spinlock_t			async_bio_lock;
 	struct bio_list			async_bios;
+#endif
 	union {
 		struct work_struct	async_bio_work;
 		struct work_struct	free_work;
diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 37b6bab90c835e..66fa9ab2c04629 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -2,6 +2,7 @@
 
 config BTRFS_FS
 	tristate "Btrfs filesystem support"
+	select BLK_CGROUP_PUNT_BIO
 	select CRYPTO
 	select CRYPTO_CRC32C
 	select LIBCRC32C
-- 
2.39.2

