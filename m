Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C8508006
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349383AbiDTEa2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiDTEa2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9CF2DE0;
        Tue, 19 Apr 2022 21:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T4iywM2NxZtj81lS0JMiWG3oPa1GX0IJLJcAv71fJKM=; b=QLCJQZcoMDRS1aGaUMwtwmqIhn
        DKXuAR5FYOrO4x2683G0B1uMbZcbomrVHhB+C5if4U/U1M4r9Co6OXAC8kKnZFU7v4kQ0ZEYSK+Vd
        /PLqRS0dIdXMK8lfpDupIRNW+JH9FsX2wVjhT4LYdKE8JDZZFEZKtw9I1y2JGe8i7vBUfEqjo1kAl
        HDkHVMx7cZffH1m9DBfkdpVrS/NfNu/+6fGMMg0WG7jK3PGFnxhViSLKK/IqXbSRuWqszDa7ysclP
        E7K3kLii0goYB1lydrblufbDMSQDasuJGfF94NsFehg69HJ+Vu/Ym2bddeRs6de6Jff6LUiwJd6ws
        Zjy1PYCA==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wK-007FGp-Ja; Wed, 20 Apr 2022 04:27:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 04/15] blk-cgroup: move blkcg_{get,set}_fc_appid out of line
Date:   Wed, 20 Apr 2022 06:27:12 +0200
Message-Id: <20220420042723.1010598-5-hch@lst.de>
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

No need to have these helpers inline.  Also remove the stubs and just use
an IS_ENABLED for the get side (the set side already is only built
conditionlly).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile                |  1 +
 block/blk-cgroup-fc-appid.c   | 57 ++++++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_scsi.c |  4 ++-
 include/linux/blk-cgroup.h    | 58 ++---------------------------------
 4 files changed, 63 insertions(+), 57 deletions(-)
 create mode 100644 block/blk-cgroup-fc-appid.c

diff --git a/block/Makefile b/block/Makefile
index 3950ecbc5c263..4e01bb71ad6e0 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_BLK_DEV_BSG_COMMON) += bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
 obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
+obj-$(CONFIG_BLK_CGROUP_FC_APPID) += blk-cgroup-fc-appid.o
 obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
 obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
 obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
diff --git a/block/blk-cgroup-fc-appid.c b/block/blk-cgroup-fc-appid.c
new file mode 100644
index 0000000000000..760a2e1878dde
--- /dev/null
+++ b/block/blk-cgroup-fc-appid.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "blk-cgroup.h"
+
+/**
+ * blkcg_set_fc_appid - set the fc_app_id field associted to blkcg
+ * @app_id: application identifier
+ * @cgrp_id: cgroup id
+ * @app_id_len: size of application identifier
+ */
+int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len)
+{
+	struct cgroup *cgrp;
+	struct cgroup_subsys_state *css;
+	struct blkcg *blkcg;
+	int ret  = 0;
+
+	if (app_id_len > FC_APPID_LEN)
+		return -EINVAL;
+
+	cgrp = cgroup_get_from_id(cgrp_id);
+	if (!cgrp)
+		return -ENOENT;
+	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
+	if (!css) {
+		ret = -ENOENT;
+		goto out_cgrp_put;
+	}
+	blkcg = css_to_blkcg(css);
+	/*
+	 * There is a slight race condition on setting the appid.
+	 * Worst case an I/O may not find the right id.
+	 * This is no different from the I/O we let pass while obtaining
+	 * the vmid from the fabric.
+	 * Adding the overhead of a lock is not necessary.
+	 */
+	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
+	css_put(css);
+out_cgrp_put:
+	cgroup_put(cgrp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkcg_set_fc_appid);
+
+/**
+ * blkcg_get_fc_appid - get the fc app identifier associated with a bio
+ * @bio: target bio
+ *
+ * On success return the fc_app_id, on failure return NULL
+ */
+char *blkcg_get_fc_appid(struct bio *bio)
+{
+	if (!bio->bi_blkg || bio->bi_blkg->blkcg->fc_app_id[0] == '\0')
+		return NULL;
+	return bio->bi_blkg->blkcg->fc_app_id;
+}
+EXPORT_SYMBOL_GPL(blkcg_get_fc_appid);
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index ba9dbb51b75f0..f6b83853f7eea 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5528,7 +5528,9 @@ static char *lpfc_is_command_vm_io(struct scsi_cmnd *cmd)
 {
 	struct bio *bio = scsi_cmd_to_rq(cmd)->bio;
 
-	return bio ? blkcg_get_fc_appid(bio) : NULL;
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !bio)
+		return NULL;
+	return blkcg_get_fc_appid(bio);
 }
 
 /**
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 652cd05b0924c..7a2f7de30173c 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -218,61 +218,7 @@ static inline struct blkcg *bio_blkcg(struct bio *bio) { return NULL; }
 
 #endif	/* CONFIG_BLK_CGROUP */
 
-#ifdef CONFIG_BLK_CGROUP_FC_APPID
-/*
- * Sets the fc_app_id field associted to blkcg
- * @app_id: application identifier
- * @cgrp_id: cgroup id
- * @app_id_len: size of application identifier
- */
-static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len)
-{
-	struct cgroup *cgrp;
-	struct cgroup_subsys_state *css;
-	struct blkcg *blkcg;
-	int ret  = 0;
-
-	if (app_id_len > FC_APPID_LEN)
-		return -EINVAL;
-
-	cgrp = cgroup_get_from_id(cgrp_id);
-	if (!cgrp)
-		return -ENOENT;
-	css = cgroup_get_e_css(cgrp, &io_cgrp_subsys);
-	if (!css) {
-		ret = -ENOENT;
-		goto out_cgrp_put;
-	}
-	blkcg = css_to_blkcg(css);
-	/*
-	 * There is a slight race condition on setting the appid.
-	 * Worst case an I/O may not find the right id.
-	 * This is no different from the I/O we let pass while obtaining
-	 * the vmid from the fabric.
-	 * Adding the overhead of a lock is not necessary.
-	 */
-	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
-	css_put(css);
-out_cgrp_put:
-	cgroup_put(cgrp);
-	return ret;
-}
+int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
+char *blkcg_get_fc_appid(struct bio *bio);
 
-/**
- * blkcg_get_fc_appid - get the fc app identifier associated with a bio
- * @bio: target bio
- *
- * On success return the fc_app_id, on failure return NULL
- */
-static inline char *blkcg_get_fc_appid(struct bio *bio)
-{
-	if (bio && bio->bi_blkg &&
-		(bio->bi_blkg->blkcg->fc_app_id[0] != '\0'))
-		return bio->bi_blkg->blkcg->fc_app_id;
-	return NULL;
-}
-#else
-static inline int blkcg_set_fc_appid(char *buf, u64 id, size_t len) { return -EINVAL; }
-static inline char *blkcg_get_fc_appid(struct bio *bio) { return NULL; }
-#endif /*CONFIG_BLK_CGROUP_FC_APPID*/
 #endif	/* _BLK_CGROUP_H */
-- 
2.30.2

