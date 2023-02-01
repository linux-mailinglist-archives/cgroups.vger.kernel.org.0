Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A45068671D
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 14:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjBANli (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 08:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjBANli (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 08:41:38 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D446D48;
        Wed,  1 Feb 2023 05:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mVU0LSbQrgY0kTXJqE3yzR4ugX07Xq7vcZHfeKk7dSk=; b=WgprGuRYz9uBkccKCNEFGM5hpF
        LFxBjBmW/HNeCIi1IH0BgHyVHGCmGMGHlef3BCNYKgG68AFkMTD1DJyIvm+LY3nfBny1990//qjmE
        jZWYFVQcsNu6yppLSEV8QB22wIwjyniCY6bqXaK4JOoGHjgQsldUMRQO2QOe5wHdLmcg2ldbSyCUe
        VS3Wylgv2nI+XvEHpW8/cikMLS6Os+JNVnXjnPfAEaadKCTKh8mDn2pFw4r6rD8EeG8IL5OWd0ENK
        8qjtHzCkg++FNdKVGnJ/nT2OJArw687KctRJxTkQ0Re9tXU2oCrxtmCgr+0Tv+e0Bok/qGrP0xWcY
        D9F/Nl/Q==;
Received: from [2001:4bb8:19a:272a:3635:31c6:c223:d428] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNDMk-00C7Su-Tq; Wed, 01 Feb 2023 13:41:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 03/19] blk-cgroup: improve error unwinding in blkg_alloc
Date:   Wed,  1 Feb 2023 14:41:07 +0100
Message-Id: <20230201134123.2656505-4-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230201134123.2656505-1-hch@lst.de>
References: <20230201134123.2656505-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Unwind only the previous initialization steps that happened in blkg_alloc
using goto based unwinding.  This avoids the need for the !queue special
case in blkg_free.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index cb110fc51940aa..9df02a6d04d35a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -128,22 +128,16 @@ static void blkg_free_workfn(struct work_struct *work)
 	 * blkcg_mutex is used to synchronize blkg_free_workfn() and
 	 * blkcg_deactivate_policy().
 	 */
-	if (q)
-		mutex_lock(&q->blkcg_mutex);
-
+	mutex_lock(&q->blkcg_mutex);
 	for (i = 0; i < BLKCG_MAX_POLS; i++)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
-
 	if (blkg->parent)
 		blkg_put(blkg->parent);
+	list_del_init(&blkg->q_node);
+	mutex_unlock(&q->blkcg_mutex);
 
-	if (q) {
-		list_del_init(&blkg->q_node);
-		mutex_unlock(&q->blkcg_mutex);
-		blk_put_queue(q);
-	}
-
+	blk_put_queue(q);
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
@@ -265,16 +259,13 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	blkg = kzalloc_node(sizeof(*blkg), gfp_mask, disk->queue->node);
 	if (!blkg)
 		return NULL;
-
 	if (percpu_ref_init(&blkg->refcnt, blkg_release, 0, gfp_mask))
-		goto err_free;
-
+		goto out_free_blkg;
 	blkg->iostat_cpu = alloc_percpu_gfp(struct blkg_iostat_set, gfp_mask);
 	if (!blkg->iostat_cpu)
-		goto err_free;
-
+		goto out_exit_refcnt;
 	if (!blk_get_queue(disk->queue))
-		goto err_free;
+		goto out_free_iostat;
 
 	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
@@ -299,8 +290,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 		/* alloc per-policy data and attach it to blkg */
 		pd = pol->pd_alloc_fn(gfp_mask, disk->queue, blkcg);
 		if (!pd)
-			goto err_free;
-
+			goto out_free_pds;
 		blkg->pd[i] = pd;
 		pd->blkg = blkg;
 		pd->plid = i;
@@ -309,8 +299,17 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 
 	return blkg;
 
-err_free:
-	blkg_free(blkg);
+out_free_pds:
+	while (--i >= 0)
+		if (blkg->pd[i])
+			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
+	blk_put_queue(disk->queue);
+out_free_iostat:
+	free_percpu(blkg->iostat_cpu);
+out_exit_refcnt:
+	percpu_ref_exit(&blkg->refcnt);
+out_free_blkg:
+	kfree(blkg);
 	return NULL;
 }
 
-- 
2.39.0

