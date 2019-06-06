Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64FA0371A4
	for <lists+cgroups@lfdr.de>; Thu,  6 Jun 2019 12:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfFFK0o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Jun 2019 06:26:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbfFFK0n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Jun 2019 06:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=snpoRl7iULYknlRMrBJ/Xj27IRdTPg5MkNii+aHCjMs=; b=PX51QO9O7v3j7YEmbSkn107SZy
        uvjqu20hguplO5FfYxZHIWAFqIBWlEshf4IRQIqZnjlQCREPaDbStHSfHppBgS03Ld4JINH0845M3
        WGVktG+JI3C4GM1+tWuIcXcUD2Z1OdsGlhJrjgyraWLDzExZBC0l9xoqkZYkgDuzINgfhdkJRqMMN
        UiuX0UE4vNXx1INgynkLDtoZ/3VjLNeMdSyLK/8vlsDCvdcDmmVcyPufAbiUwoctA3yHAyL37Enkw
        2E9zEtnnzlcTSfSxRQ5BA99zcwZz2xYvrbs/TPtlE/FFcejy5p5cooFvZ0GA1Rn9T3HavUGBXcww1
        IZjY6yEw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpbW-0007iG-EJ; Thu, 06 Jun 2019 10:26:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] bfq-iosched: move bfq_stat_recursive_sum into the only caller
Date:   Thu,  6 Jun 2019 12:26:23 +0200
Message-Id: <20190606102624.3847-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606102624.3847-1-hch@lst.de>
References: <20190606102624.3847-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This function was moved from core block code and is way to generic.
Fold it into the only caller and simplify it based on the actually
passed arguments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bfq-cgroup.c | 62 ++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 43 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index a691dca7e966..d84302445e30 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -80,47 +80,6 @@ static inline void bfq_stat_add_aux(struct bfq_stat *to,
 		     &to->aux_cnt);
 }
 
-/**
- * bfq_stat_recursive_sum - collect hierarchical bfq_stat
- * @blkg: blkg of interest
- * @pol: blkcg_policy which contains the bfq_stat
- * @off: offset to the bfq_stat in blkg_policy_data or @blkg
- *
- * Collect the bfq_stat specified by @blkg, @pol and @off and all its
- * online descendants and their aux counts.  The caller must be holding the
- * queue lock for online tests.
- *
- * If @pol is NULL, bfq_stat is at @off bytes into @blkg; otherwise, it is
- * at @off bytes into @blkg's blkg_policy_data of the policy.
- */
-static u64 bfq_stat_recursive_sum(struct blkcg_gq *blkg,
-			    struct blkcg_policy *pol, int off)
-{
-	struct blkcg_gq *pos_blkg;
-	struct cgroup_subsys_state *pos_css;
-	u64 sum = 0;
-
-	lockdep_assert_held(&blkg->q->queue_lock);
-
-	rcu_read_lock();
-	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
-		struct bfq_stat *stat;
-
-		if (!pos_blkg->online)
-			continue;
-
-		if (pol)
-			stat = (void *)blkg_to_pd(pos_blkg, pol) + off;
-		else
-			stat = (void *)blkg + off;
-
-		sum += bfq_stat_read(stat) + atomic64_read(&stat->aux_cnt);
-	}
-	rcu_read_unlock();
-
-	return sum;
-}
-
 /**
  * blkg_prfill_stat - prfill callback for bfq_stat
  * @sf: seq_file to print to
@@ -1045,8 +1004,25 @@ static int bfqg_print_rwstat(struct seq_file *sf, void *v)
 static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 				      struct blkg_policy_data *pd, int off)
 {
-	u64 sum = bfq_stat_recursive_sum(pd_to_blkg(pd),
-					  &blkcg_policy_bfq, off);
+	struct blkcg_gq *blkg = pd_to_blkg(pd);
+	struct blkcg_gq *pos_blkg;
+	struct cgroup_subsys_state *pos_css;
+	u64 sum = 0;
+
+	lockdep_assert_held(&blkg->q->queue_lock);
+
+	rcu_read_lock();
+	blkg_for_each_descendant_pre(pos_blkg, pos_css, blkg) {
+		struct bfq_stat *stat;
+
+		if (!pos_blkg->online)
+			continue;
+
+		stat = (void *)blkg_to_pd(pos_blkg, &blkcg_policy_bfq) + off;
+		sum += bfq_stat_read(stat) + atomic64_read(&stat->aux_cnt);
+	}
+	rcu_read_unlock();
+
 	return __blkg_prfill_u64(sf, pd, sum);
 }
 
-- 
2.20.1

