Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E06507FFD
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiDTEaV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEaT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316B7BF69;
        Tue, 19 Apr 2022 21:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pUx9E4bSsgTtsaDMfSE5EDajyzAF5/fHK6uAh8Ed1Gg=; b=uNkgsxELSTCE2JMXfgQQtkD9MY
        B+72ptZYalj2Ob23DD2ORCU3vyCOzMbIg92e+4bEh0R4/5UFv9FTP2dMABwokzQtJIESrN/DyxAhF
        HB2rocYfwAd0fy79eQUjfVuIkodyaZdYUp+frZc1JYy+8QNxfDFTcEKX9Sc2Lp6lkTMgNGhyDsRCJ
        vGDckqqRt/ngcyFA+VKNCrK3q1PpnwLRaYy/ef9aFWeGbz4HzlU0eXswHCY91slT9vL6VZd9KCUkA
        dPwxVISwd4J/MhAXRLs9RVzSrQSQ6t4Jl7J4gWjJO8XLU+ATVcMZkxRCbh8HqRS+d7Z3wqFwTV9q/
        PZSxg22w==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wB-007FBc-Fy; Wed, 20 Apr 2022 04:27:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 01/15] blk-cgroup: remove __bio_blkcg
Date:   Wed, 20 Apr 2022 06:27:09 +0200
Message-Id: <20220420042723.1010598-2-hch@lst.de>
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

Remove the unused and deprecated __bio_blkcg helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 47e1e38390c96..49e88fc9cc391 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -139,27 +139,6 @@ static inline struct cgroup_subsys_state *blkcg_css(void)
 	return task_css(current, io_cgrp_id);
 }
 
-/**
- * __bio_blkcg - internal, inconsistent version to get blkcg
- *
- * DO NOT USE.
- * This function is inconsistent and consequently is dangerous to use.  The
- * first part of the function returns a blkcg where a reference is owned by the
- * bio.  This means it does not need to be rcu protected as it cannot go away
- * with the bio owning a reference to it.  However, the latter potentially gets
- * it from task_css().  This can race against task migration and the cgroup
- * dying.  It is also semantically different as it must be called rcu protected
- * and is susceptible to failure when trying to get a reference to it.
- * Therefore, it is not ok to assume that *_get() will always succeed on the
- * blkcg returned here.
- */
-static inline struct blkcg *__bio_blkcg(struct bio *bio)
-{
-	if (bio && bio->bi_blkg)
-		return bio->bi_blkg->blkcg;
-	return css_to_blkcg(blkcg_css());
-}
-
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
  * @return: true if this bio needs to be submitted with the root blkg context.
@@ -471,8 +450,6 @@ static inline int blkcg_activate_policy(struct request_queue *q,
 static inline void blkcg_deactivate_policy(struct request_queue *q,
 					   const struct blkcg_policy *pol) { }
 
-static inline struct blkcg *__bio_blkcg(struct bio *bio) { return NULL; }
-
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
 						  struct blkcg_policy *pol) { return NULL; }
 static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
-- 
2.30.2

