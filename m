Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE7B508017
	for <lists+cgroups@lfdr.de>; Wed, 20 Apr 2022 06:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356385AbiDTEaz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Apr 2022 00:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245608AbiDTEay (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Apr 2022 00:30:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194F82DE0;
        Tue, 19 Apr 2022 21:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uBBj2AcJgfyLk5vl6yMy/ZDB6vllaI3H675K6PqOsyQ=; b=1xpyMniEM6uPddNapXYQH3lsrf
        uQ8FHVFU6epKCrJesM60funTdloGK4Lj38f/1YUlrZYg1jcRYwOcfVvnVra47GgmXLwc2yJk2ngzo
        7fJbpKKhqynluq/Slayaraw9Iwdze8UspPcSpx/gp8bI8fxHd5F8lv8cjRkEhk3LOfYjm6nx5PVuv
        LSHK8XBCCW/amMP33ATMlPAmcUbCCSvbjTf1/GEd44sgb7cEIB30+xzYXKMXnx0t4EL5LheapE++M
        hbdBeIY3+sWmqLofRleMX/lXHREVYIG3BUXceGwIrzaCOXUAiECsotMux/PsxSxLm4yH3OxIBv5IT
        TaoAFc3w==;
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nh1wl-007Fcr-4z; Wed, 20 Apr 2022 04:28:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 13/15] blk-cgroup: cleanup blk_cgroup_congested
Date:   Wed, 20 Apr 2022 06:27:21 +0200
Message-Id: <20220420042723.1010598-14-hch@lst.de>
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

Use blkcg_css instead of open coding it, and switch to a slightly
more natural for loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8da00ddc1766e..5684a8ce1f755 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2038,15 +2038,11 @@ bool blk_cgroup_congested(void)
 	bool ret = false;
 
 	rcu_read_lock();
-	css = kthread_blkcg();
-	if (!css)
-		css = task_css(current, io_cgrp_id);
-	while (css) {
+	for (css = blkcg_css(); css; css = css->parent) {
 		if (atomic_read(&css->cgroup->congestion_count)) {
 			ret = true;
 			break;
 		}
-		css = css->parent;
 	}
 	rcu_read_unlock();
 	return ret;
-- 
2.30.2

