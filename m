Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A05508012
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiDTEat (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355273AbiDTEar (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F643BF69;
        Tue, 19 Apr 2022 21:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lCOBvABRVXqvoK7YjkTVz0nyOLl8eIMjcntmO1hcFBU=; b=GZMUjFSY7N17YDxVy5vCXFC8DI
        iO7ufwCQBhEzzmAA16IH5fKaUdj7MzC9pssyigjBN6zc4QeGjVp2cC0+oKW0ngBKJUmwwfrnOJLez
        kVwFW6riBd2KDqqmrn5na8NftMQ8V/aDFJoDGmQ8oaQImJcCqC9IpvsmBzVRcif6mj9jDEyJR6Dnr
        8ZETYU53611Z2h3wRXH7LsIwvn+BakoMFNb6O20luyRapaDtDEe4qaVIGZkY1Fm9rnk9gwEQU4mTv
        3wrFnLN1cVNUrZWxDHVu3EjRcUgZVbJJcIk15tAQwR7nv+O2jxOZzcO0PDV91hcb+vRgppcqEKbM2
        qqVUXUsA==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wc-007FVC-8s; Wed, 20 Apr 2022 04:27:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 10/15] blk-cgroup: remove pointless CONFIG_BLOCK ifdefs
Date:   Wed, 20 Apr 2022 06:27:18 +0200
Message-Id: <20220420042723.1010598-11-hch@lst.de>
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

No need to make BLK_CGROUP stubs conditional on CONFIG_BLOCK as they
can't be used without that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.h         | 3 ---
 include/linux/blk-cgroup.h | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 03405ddf2a7ba..a948f4eb0bff8 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -525,8 +525,6 @@ struct blkcg_policy {
 struct blkcg {
 };
 
-#ifdef CONFIG_BLOCK
-
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
 static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
 { return NULL; }
@@ -554,7 +552,6 @@ static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { r
 #define blk_queue_for_each_rl(rl, q)	\
 	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
 
-#endif	/* CONFIG_BLOCK */
 #endif	/* CONFIG_BLK_CGROUP */
 
 #endif /* _BLK_CGROUP_PRIVATE_H */
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 97c7968e32040..abbfa97d6d46f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -44,15 +44,11 @@ struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio);
 
 static inline void blkcg_maybe_throttle_current(void) { }
 static inline bool blk_cgroup_congested(void) { return false; }
-
-#ifdef CONFIG_BLOCK
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
 static inline struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio)
 {
 	return NULL;
 }
-#endif /* CONFIG_BLOCK */
-
 #endif	/* CONFIG_BLK_CGROUP */
 
 int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
-- 
2.30.2

