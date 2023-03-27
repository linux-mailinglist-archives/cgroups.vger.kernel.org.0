Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7DF6C992A
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 02:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjC0AuA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Mar 2023 20:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjC0At7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Mar 2023 20:49:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC72723;
        Sun, 26 Mar 2023 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5ZhM6Yw/R1sd+MpvSA0gat2A40x7C/0Xx6SF3r7hQHg=; b=1Vta+wtQ4nJq8eCftRdshEH7bm
        7P0fxfEiDSEXzllKTLvvoAQNLnQo1MEAQyarGNLZo2HtgnVinDCvCYQFf2Yh9yuX+TEO7SSK29P3C
        p6XtrJeZfxO0kxks9laeZlcoJDKZU547niU6M9QOE6RXY/DZOfmsA150H4cMzGmob0jx9twN7admS
        hZ3/kdPhzkZJGqWNVQ9Q3U3rMAI2hVvYfaPCo8UiGzCxX+6RjujT7kMlXMEbV8afHehM/M7Jd8KL3
        gKAe7kL7PuWrW2ksiX9BcRweU0M1XpbDbK3+K8NZn7dpsYtmhThUzCo15jExkbWx4F+KjOq6JhTZz
        e2tVuKZw==;
Received: from i114-182-241-148.s41.a014.ap.plala.or.jp ([114.182.241.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgb3a-009Qsw-2q;
        Mon, 27 Mar 2023 00:49:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs, mm: remove the punt_to_cgroup field in struct writeback_control
Date:   Mon, 27 Mar 2023 09:49:50 +0900
Message-Id: <20230327004954.728797-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327004954.728797-1-hch@lst.de>
References: <20230327004954.728797-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

punt_to_cgroup is only used by extent_write_locked_range, but that
function also directly controls the bio flags for the actual submission.
Remove th punt_to_cgroup field, and just set REQ_CGROUP_PUNT directly
in extent_write_locked_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c      | 6 +++---
 include/linux/writeback.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1221f699ffc596..f5702b1e2b86b0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2533,13 +2533,13 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end)
 		.sync_mode	= WB_SYNC_ALL,
 		.range_start	= start,
 		.range_end	= end + 1,
-		/* We're called from an async helper function */
-		.punt_to_cgroup	= 1,
 		.no_cgroup_owner = 1,
 	};
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.wbc = &wbc_writepages,
-		.opf = REQ_OP_WRITE | wbc_to_write_flags(&wbc_writepages),
+		/* We're called from an async helper function */
+		.opf = REQ_OP_WRITE | REQ_CGROUP_PUNT |
+			wbc_to_write_flags(&wbc_writepages),
 		.extent_locked = 1,
 	};
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 46020373e155be..fba937999fbfd3 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -70,8 +70,6 @@ struct writeback_control {
 	 */
 	unsigned no_cgroup_owner:1;
 
-	unsigned punt_to_cgroup:1;	/* cgrp punting, see __REQ_CGROUP_PUNT */
-
 	/* To enable batching of swap writes to non-block-device backends,
 	 * "plug" can be set point to a 'struct swap_iocb *'.  When all swap
 	 * writes have been submitted, if with swap_iocb is not NULL,
@@ -97,9 +95,6 @@ static inline blk_opf_t wbc_to_write_flags(struct writeback_control *wbc)
 {
 	blk_opf_t flags = 0;
 
-	if (wbc->punt_to_cgroup)
-		flags = REQ_CGROUP_PUNT;
-
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		flags |= REQ_SYNC;
 	else if (wbc->for_kupdate || wbc->for_background)
-- 
2.39.2

