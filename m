Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B273508007
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351015AbiDTEab (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiDTEab (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498932DE0;
        Tue, 19 Apr 2022 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SNly7Jwe/4q/B3a1kzOX1/36o22AU8SRE+zg1tBGQ9U=; b=cOFOqCrQxfWWZaKuWhtRafckeu
        P+Yum7mHcbB5K/oV23eYNqeC3183rPrqIqW55KINjYuXL5CG9Og5n9Me4So6eoT2Ry+83vwH93DDG
        +Pwh+AXHhrOAg0FzZ4KdQJJlb1eouiTz5swUSW+9JsCYduE3jPo0UqBkF/XWIKHcUDBbCUIIx5Tev
        vmfeY3THFOpNEoKVk7mCrh9wYq04q0sWjxqyDmV6ncvHs/4KGkdHhPPMZ5+PG9d53LxMFvTb2w9u0
        yWU2ENPumNaX0M+7j4BtfDrl3VxPhOp/31nmimkL+kkBa6AzNQjiIGi56i8yYj+EDm2AJLGIcOBAW
        Wt2H7B/g==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wN-007FII-G2; Wed, 20 Apr 2022 04:27:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 05/15] blk-cgroup: move blk_cgroup_congested out line
Date:   Wed, 20 Apr 2022 06:27:13 +0200
Message-Id: <20220420042723.1010598-6-hch@lst.de>
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

There is no urgent need to inline this function, so move it out of line.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         | 20 ++++++++++++++++++++
 include/linux/blk-cgroup.h | 20 +-------------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8dfe62786cd5f..97266ebde975b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1950,6 +1950,26 @@ void blk_cgroup_bio_start(struct bio *bio)
 	put_cpu();
 }
 
+bool blk_cgroup_congested(void)
+{
+	struct cgroup_subsys_state *css;
+	bool ret = false;
+
+	rcu_read_lock();
+	css = kthread_blkcg();
+	if (!css)
+		css = task_css(current, io_cgrp_id);
+	while (css) {
+		if (atomic_read(&css->cgroup->congestion_count)) {
+			ret = true;
+			break;
+		}
+		css = css->parent;
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 static int __init blkcg_init(void)
 {
 	blkcg_punt_bio_wq = alloc_workqueue("blkcg_punt_bio",
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 7a2f7de30173c..988965c1c27b8 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -135,25 +135,7 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return NULL;
 }
 
-static inline bool blk_cgroup_congested(void)
-{
-	struct cgroup_subsys_state *css;
-	bool ret = false;
-
-	rcu_read_lock();
-	css = kthread_blkcg();
-	if (!css)
-		css = task_css(current, io_cgrp_id);
-	while (css) {
-		if (atomic_read(&css->cgroup->congestion_count)) {
-			ret = true;
-			break;
-		}
-		css = css->parent;
-	}
-	rcu_read_unlock();
-	return ret;
-}
+bool blk_cgroup_congested(void);
 
 /**
  * blkcg_parent - get the parent of a blkcg
-- 
2.30.2

