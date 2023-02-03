Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396A0689CB3
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 16:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjBCPGq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 10:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjBCPEq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 10:04:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F9A56CC;
        Fri,  3 Feb 2023 07:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dueVlTMBYMpU6WhcVEk2hjJcCiKSsyRkz1adFsMrdaI=; b=SyYJJQO5gZWmnrdw9pEuZOssZp
        X2kKoQvA70cOOjINeHRQOtnTdb0zhgWY5joVEmXYYZTpJxkN6Rq3sUpN8bsjhT6SkpHYY/d345Amj
        +BxIUvW3zt05MFCRt8Go1Xumr40ZOgMSbiHzMBzCnNKaMT42tH0m5oGHHC2QbOfh0hpEGEG3u4cQP
        jW/drz399Vx2rp5RHRfAdpXSddaJS7WR84pSiI/l5QblXoFQdjxOhUyWAh6oy0mN/b3geUDYKEexg
        KJVlrMIxPeU/saeRkYH6aqTL/h0ojeF4fp3lvchQbhz8Lprbtf37p72HJD1BxQDlJ6o5WRHPMsr86
        KeW5G2jA==;
Received: from [2001:4bb8:19a:272a:910:bb67:7287:f956] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNxcG-002aBZ-AQ; Fri, 03 Feb 2023 15:04:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH 11/19] blk-wbt: open code wbt_queue_depth_changed in wbt_init
Date:   Fri,  3 Feb 2023 16:03:52 +0100
Message-Id: <20230203150400.3199230-12-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230203150400.3199230-1-hch@lst.de>
References: <20230203150400.3199230-1-hch@lst.de>
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

wbt_queue_depth_changed just updates a field and calls another function.
Open code it in wbt_init, so that the local queue variable can be used
instead of the one stored in the rq_qos.  This will allow delaying that
rq_qos->queue assignment in a subsequent patch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-wbt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 58f41a98fda911..119a43671089ea 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -941,8 +941,8 @@ int wbt_init(struct gendisk *disk)
 	rwb->wc = test_bit(QUEUE_FLAG_WC, &q->queue_flags);
 	rwb->rq_depth.default_depth = RWB_DEF_DEPTH;
 	rwb->min_lat_nsec = wbt_default_latency_nsec(q);
-
-	wbt_queue_depth_changed(&rwb->rqos);
+	rwb->rq_depth.queue_depth = blk_queue_depth(q);
+	wbt_update_limits(rwb);
 
 	/*
 	 * Assign rwb and add the stats callback.
-- 
2.39.0

