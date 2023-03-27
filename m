Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF756C991F
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 02:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjC0At7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Mar 2023 20:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjC0At6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Mar 2023 20:49:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDBD30C0;
        Sun, 26 Mar 2023 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=s56AsIYlw5q14zHr9Gzs0WZIFhX1rh7X7dJ8YVLzjck=; b=osaR8wPjMXD5wK8oFuegBQydlT
        invB/3B/4gcOvmAjjqU3q+bMd4kHMkxNQR+nkpaz1ydBWTsFJ8egQ2UtHZgJYTCHXyiRmMXbRcT92
        kMXpdyD20pAnO7e03Vx6I7WZw31bNb7/BexopC/81XGrKsRp4TSwsfjuvNN2IasoUDR9oXhh3J1WO
        C0g7DIt3KeUJ6LpPyZUEqFg8qgX019WO/Ayhnbh4tJXCYoXm/KJg91x1/OA/di8pRCzzaRlYqxlFp
        N6xlw6JvdVqnZRFTo3fFLm7C/HdjLeFFW8SA+LINMmA4LVtI/FvbvfgSbXSsXQvZAgD11pg8CcJWG
        7qcEW5uw==;
Received: from i114-182-241-148.s41.a014.ap.plala.or.jp ([114.182.241.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgb3Y-009Qsd-2f;
        Mon, 27 Mar 2023 00:49:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs: also use kthread_associate_blkcg for uncompressible ranges
Date:   Mon, 27 Mar 2023 09:49:49 +0900
Message-Id: <20230327004954.728797-4-hch@lst.de>
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

submit_one_async_extent needs to use submit_one_async_extent no matter
if the range it handles ends up beeing compressed or not as the deadlock
risk due to cgroup thottling is the same.  Call kthread_associate_blkcg
earlier to cover submit_uncompressed_range case as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7a1bfce9532fe9..713b47792b9b7e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -982,6 +982,9 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	u64 start = async_extent->start;
 	u64 end = async_extent->start + async_extent->ram_size - 1;
 
+	if (async_chunk->blkcg_css)
+		kthread_associate_blkcg(async_chunk->blkcg_css);
+
 	/*
 	 * If async_chunk->locked_page is in the async_extent range, we need to
 	 * handle it.
@@ -1052,8 +1055,6 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
 
-	if (async_chunk->blkcg_css)
-		kthread_associate_blkcg(async_chunk->blkcg_css);
 	btrfs_submit_compressed_write(inode, start,	/* file_offset */
 			    async_extent->ram_size,	/* num_bytes */
 			    ins.objectid,		/* disk_bytenr */
@@ -1061,10 +1062,10 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 			    async_extent->pages,	/* compressed_pages */
 			    async_extent->nr_pages,
 			    async_chunk->write_flags, true);
-	if (async_chunk->blkcg_css)
-		kthread_associate_blkcg(NULL);
 	*alloc_hint = ins.objectid + ins.offset;
 done:
+	if (async_chunk->blkcg_css)
+		kthread_associate_blkcg(NULL);
 	kfree(async_extent);
 	return ret;
 
-- 
2.39.2

