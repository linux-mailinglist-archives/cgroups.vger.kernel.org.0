Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA7A508015
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345467AbiDTEaw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356385AbiDTEav (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4F92DE0;
        Tue, 19 Apr 2022 21:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EB24Pl6Dnuz4BZ6riMjfOVkZhFkJeCm3U5wG0haI3CE=; b=jPduuzobKlAP+uSSo+Orh9sslf
        gLWxMlEGJLet2t+xSNTBmZlUIaHZMBkInqspZD4XTswr0i8Oq74biZ6WisQJAMgRFIm8loWVZSIir
        0skh3C9AUWNqpAN28r5fJQ6gs2URKw+KVlXZGN61Rnja9IUxv7mvtwCwcwJm/Sk79GQWvT7Lwca17
        7Fyre5mcE0nBSwV70cZejcTxkjpRAIuZFJO+Nnn0OUvMOSoLoQlwNO0XT3rQmbaIWq9Tk2czVum1q
        xXqvK6Ca4IN2RMHS9nbDQJONquzAi7gaJzXzbvtJIMXwGBZGO5yA9Qo4S+u9Nlna6P3Vm3wfISRfk
        IL3CUhIQ==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wi-007FaW-7D; Wed, 20 Apr 2022 04:28:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 12/15] blk-cgroup: move blkcg_css to blk-cgroup.c
Date:   Wed, 20 Apr 2022 06:27:20 +0200
Message-Id: <20220420042723.1010598-13-hch@lst.de>
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

blkcg_css is only used in blk-cgroup.c, so move it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 17 +++++++++++++++++
 block/blk-cgroup.h | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8e32cc494808d..8da00ddc1766e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -59,6 +59,23 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
 
 #define BLKG_DESTROY_BATCH_SIZE  64
 
+/**
+ * blkcg_css - find the current css
+ *
+ * Find the css associated with either the kthread or the current task.
+ * This may return a dying css, so it is up to the caller to use tryget logic
+ * to confirm it is alive and well.
+ */
+static struct cgroup_subsys_state *blkcg_css(void)
+{
+	struct cgroup_subsys_state *css;
+
+	css = kthread_blkcg();
+	if (css)
+		return css;
+	return task_css(current, io_cgrp_id);
+}
+
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
 {
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 62ed8ed50b6e3..bb670e53a1de2 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -210,23 +210,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
 
-/**
- * blkcg_css - find the current css
- *
- * Find the css associated with either the kthread or the current task.
- * This may return a dying css, so it is up to the caller to use tryget logic
- * to confirm it is alive and well.
- */
-static inline struct cgroup_subsys_state *blkcg_css(void)
-{
-	struct cgroup_subsys_state *css;
-
-	css = kthread_blkcg();
-	if (css)
-		return css;
-	return task_css(current, io_cgrp_id);
-}
-
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
  * @return: true if this bio needs to be submitted with the root blkg context.
-- 
2.30.2

