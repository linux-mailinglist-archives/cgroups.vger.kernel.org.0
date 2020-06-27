Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB920BFB1
	for <lists+cgroups@lfdr.de>; Sat, 27 Jun 2020 09:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgF0Hcp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 27 Jun 2020 03:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgF0Hco (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 27 Jun 2020 03:32:44 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DE9C03E979;
        Sat, 27 Jun 2020 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=LREORKkL9EawusRPfY+RfGgkga9SJryaB1y7sBbv+3c=; b=Y+/+SN3Nj38jfxO2i3lNtkEEEh
        p5PU9kxKUEStA039sBaU80FUIIvTpcHFt36RI1FknpmJhMWGKFgiwg7s+Ms4DQI1MtXDPeUM0wIlV
        38tOKbh9wlcT5Kj6Ny5CNIX5um8hs4EbmbRw5gwgMH3tffQVM7ubNGIG8NC+S/yEQMYZDHuLWxqmi
        9IPc4iePF4IzCvsADXfxFap/nSeBhF4g2Upoi5yYBu1877xEsCRJU4tl1kUnbUmTivqgDceaxmw7y
        X4I/EqORE71u36SwJMR6c7nexLlV+8Lg6IfBUPe9FwHt6SC1jFfbKqSNrFRrIuHZR74kmPbEayDff
        UkYW2/YQ==;
Received: from [2001:4bb8:184:76e3:595:ba65:ae56:65a6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jp5Jt-0006mN-VO; Sat, 27 Jun 2020 07:32:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 04/14] block: merge __bio_associate_blkg into bio_associate_blkg_from_css
Date:   Sat, 27 Jun 2020 09:31:49 +0200
Message-Id: <20200627073159.2447325-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627073159.2447325-1-hch@lst.de>
References: <20200627073159.2447325-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Merge __bio_associate_blkg into the only caller, which allows to slightly
reduce the RCU crticial section and better explain the code flow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio.c | 45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index e1d01acce8070c..bc8de2432e3645 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1628,52 +1628,33 @@ int bioset_init_from_src(struct bio_set *bs, struct bio_set *src)
 EXPORT_SYMBOL(bioset_init_from_src);
 
 #ifdef CONFIG_BLK_CGROUP
-
-/**
- * __bio_associate_blkg - associate a bio with the a blkg
- * @bio: target bio
- * @blkg: the blkg to associate
- *
- * This tries to associate @bio with the specified @blkg.  Association failure
- * is handled by walking up the blkg tree.  Therefore, the blkg associated can
- * be anything between @blkg and the root_blkg.  This situation only happens
- * when a cgroup is dying and then the remaining bios will spill to the closest
- * alive blkg.
- *
- * A reference will be taken on the @blkg and will be released when @bio is
- * freed.
- */
-static void __bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg)
-{
-	if (bio->bi_blkg)
-		blkg_put(bio->bi_blkg);
-	bio->bi_blkg = blkg_tryget_closest(blkg);
-}
-
 /**
  * bio_associate_blkg_from_css - associate a bio with a specified css
  * @bio: target bio
  * @css: target css
  *
  * Associate @bio with the blkg found by combining the css's blkg and the
- * request_queue of the @bio.  This falls back to the queue's root_blkg if
- * the association fails with the css.
+ * request_queue of the @bio.  An association failure is handled by walking up
+ * the blkg tree.  Therefore, the blkg associated can be anything between @blkg
+ * and q->root_blkg.  This situation only happens when a cgroup is dying and
+ * then the remaining bios will spill to the closest alive blkg.
+ *
+ * A reference will be taken on the blkg and will be released when @bio is
+ * freed.
  */
 void bio_associate_blkg_from_css(struct bio *bio,
 				 struct cgroup_subsys_state *css)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	struct blkcg_gq *blkg;
+	struct blkcg_gq *blkg = q->root_blkg;
 
-	rcu_read_lock();
+	if (bio->bi_blkg)
+		blkg_put(bio->bi_blkg);
 
-	if (!css || !css->parent)
-		blkg = q->root_blkg;
-	else
+	rcu_read_lock();
+	if (css && css->parent)
 		blkg = blkg_lookup_create(css_to_blkcg(css), q);
-
-	__bio_associate_blkg(bio, blkg);
-
+	bio->bi_blkg = blkg_tryget_closest(blkg);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
-- 
2.26.2

