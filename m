Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670E467916F
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 07:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjAXG55 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 01:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjAXG5y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 01:57:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D557D89;
        Mon, 23 Jan 2023 22:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uWkrArfjuUhlfffQ0P1IPKAit66kvvYiFVr/571osGw=; b=A63/5NNpZ/L5wVObUfVISsvHZh
        O/U3iJpwGbYKBVSQI8/ucy0rRMNxwWJnVfzam/NhaQ3y3+zjUCtPkk73Jk5ZxBsV2/vZvs8sOL/dy
        lUopbiEDFnhSzwxehhhQMM1xbVEBZ8vsWq38D+ycqrn7HvUY1m+cPTkwwsarTVvOYbUZfV/e67qZY
        pgz8JUEz8ulV3oCnty/BCprhlAVf0uLoQwuxtc5mN5fBEO2BDsuPLtGuwBp7Qm9H7seEW30Je+drD
        d6BNg8lMSo/LkE6L7GAryUGdg0dD1rq9zl63udHnjoDRFQOeTSU7g39IfwfKVSfSn6p2stZL2rKQt
        IPSM0gWg==;
Received: from [2001:4bb8:19a:27af:ea4c:1aa8:8f64:2866] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKDFe-002aTK-Ag; Tue, 24 Jan 2023 06:57:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 08/15] blk-wbt: open code wbt_queue_depth_changed in wbt_update_limits
Date:   Tue, 24 Jan 2023 07:57:08 +0100
Message-Id: <20230124065716.152286-9-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124065716.152286-1-hch@lst.de>
References: <20230124065716.152286-1-hch@lst.de>
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

No real need to all the method here, so open code to it to prepare
for some paramter passing changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 542271fa99e8f7..473ae72befaf1a 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -863,9 +863,9 @@ int wbt_init(struct gendisk *disk)
 	rwb->enable_state = WBT_STATE_ON_DEFAULT;
 	rwb->wc = test_bit(QUEUE_FLAG_WC, &q->queue_flags);
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
+	rwb->rq_depth.queue_depth = blk_queue_depth(q);
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
-
-	wbt_queue_depth_changed(&rwb->rqos);
+	wbt_update_limits(rwb);
 
 	/*
 	 * Assign rwb and add the stats callback.
-- 
2.39.0

