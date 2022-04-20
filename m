Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F9C508003
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349365AbiDTEaZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiDTEaY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063D2DE0;
        Tue, 19 Apr 2022 21:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=y/ovE2zEN2kLE1A2FRhhKOcbowUkSDsa75PAEbmLpG0=; b=DOLgdQusEBimK3YMZin66R/BjH
        KIRbmuSDM431VciG1e+sHRmUmEJugXKLLuYU0opQ6vCOSlhXMD61pZTijh1pLp2D6HqCYHj4dOoVA
        1aSheLwYo2wRPaY7OoXnoXSvxO+f+8BaosjWBlbP2S/I9iIbRmm8BYezQCvXuutIxIvA+TnsrRVCG
        ErhmbmsIu0ylBSu6HsHJkDbf/VkBmNN3fGWgy1ycMqiil+m2ICbNMhlgUcElPyS9085V54ijOiU1J
        uVzgoOvSXJMRoLHMkkMM6lLG7F8SFLajpZZyyamt4pij31J78UapbHHe+WJOueO34ANbLEvC76q4E
        BI4fq2xg==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wH-007FFj-Jr; Wed, 20 Apr 2022 04:27:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 03/15] nvme-fc: fold t fc_update_appid into fc_appid_store
Date:   Wed, 20 Apr 2022 06:27:11 +0200
Message-Id: <20220420042723.1010598-4-hch@lst.de>
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

No need for this wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index caa0fff7bf1f5..7ae72c7a211b9 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3857,12 +3857,10 @@ static int fc_parse_cgrpid(const char *buf, u64 *id)
 }
 
 /*
- * fc_update_appid: Parse and update the appid in the blkcg associated with
- * cgroupid.
- * @buf: buf contains both cgrpid and appid info
- * @count: size of the buffer
+ * Parse and update the appid in the blkcg associated with the cgroupid.
  */
-static int fc_update_appid(const char *buf, size_t count)
+static ssize_t fc_appid_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
 {
 	u64 cgrp_id;
 	int appid_len = 0;
@@ -3890,17 +3888,6 @@ static int fc_update_appid(const char *buf, size_t count)
 		return ret;
 	return count;
 }
-
-static ssize_t fc_appid_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
-{
-	int ret  = 0;
-
-	ret = fc_update_appid(buf, count);
-	if (ret < 0)
-		return -EINVAL;
-	return count;
-}
 static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
 #endif /* CONFIG_BLK_CGROUP_FC_APPID */
 
-- 
2.30.2

