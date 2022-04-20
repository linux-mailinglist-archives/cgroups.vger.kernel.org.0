Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE45508002
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348678AbiDTEaW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiDTEaW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22722DE0;
        Tue, 19 Apr 2022 21:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IQ4ESgW0h9CMQrcwqxrNIrPn85MSIrk1H7//P0ImuCw=; b=PrEScC5s/tQxuu9heXFJwXhG7S
        NFpHoR4XLzL55dkcu7UMwI50gBtpf4k1P+uL5GaW6+9bwzG3j4zq1Y8/IQ/Ks6SK5ZFzcHxgVwdj5
        YQAH55VNCPdQ23V7w22PRIEL7sAXbRX9ENM57nJM/wBu5e9v5hqVNVp1Ed5P7q7NUYQGM3agmcnEj
        h8CIC4zC8nGgaf523aGgGuvEjzqzCGKzTT1dqAIt528WMiH93lmROrfiBcg9Eomeq/wqYni3EEoxY
        t1rC1wGpHQZAfAHMFjgzT1MurdfwOLKFX7+dKVrTjlvlJszZtYT4+wNeFXwZ5Go5Qsos2KlexkEyO
        cpxOH61A==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wE-007FCk-RA; Wed, 20 Apr 2022 04:27:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 02/15] nvme-fc: don't support the appid attribute without CONFIG_BLK_CGROUP_FC_APPID
Date:   Wed, 20 Apr 2022 06:27:10 +0200
Message-Id: <20220420042723.1010598-3-hch@lst.de>
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

nvme-fc appid support needs CONFIG_BLK_CGROUP_FC_APPID to work, so disable
the whole code if the option is not set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/fc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 080f85f4105f3..caa0fff7bf1f5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3831,6 +3831,9 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
 	return count;
 }
 
+static DEVICE_ATTR(nvme_discovery, 0200, NULL, nvme_fc_nvme_discovery_store);
+
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
 /* Parse the cgroup id from a buf and return the length of cgrpid */
 static int fc_parse_cgrpid(const char *buf, u64 *id)
 {
@@ -3898,12 +3901,14 @@ static ssize_t fc_appid_store(struct device *dev,
 		return -EINVAL;
 	return count;
 }
-static DEVICE_ATTR(nvme_discovery, 0200, NULL, nvme_fc_nvme_discovery_store);
 static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
+#endif /* CONFIG_BLK_CGROUP_FC_APPID */
 
 static struct attribute *nvme_fc_attrs[] = {
 	&dev_attr_nvme_discovery.attr,
+#ifdef CONFIG_BLK_CGROUP_FC_APPID
 	&dev_attr_appid_store.attr,
+#endif
 	NULL
 };
 
-- 
2.30.2

