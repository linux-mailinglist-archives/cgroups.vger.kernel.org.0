Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4E56C991E
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 02:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjC0At4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Mar 2023 20:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjC0Atz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Mar 2023 20:49:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077A8132;
        Sun, 26 Mar 2023 17:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IcR9WNRaoxss7fLW0ETcKOS8EdYmX7y+mCZKK90iRwg=; b=cJb+AO2QZ13dW24wgLGF2UtMek
        7SD74w/Ih5smi2PHCmAJhat5SLqQ82RKAl3vtbm7EkUaISCdWadxP/QrqQT8rmycE80LCi0FkLeak
        pgEDHr08kSzQr4XD6dPecVBLDxSv33f1llgQ+y96gXFp3FDhWvrvqd4WPlhbg1mid/7Kf3HsT+/8k
        Pqn+rEoDHH2+lPPFDnY6dHlXOPkDTw9P9sCuX/sqLkdqtnWy24UApdHuj6vWp5ytbQKMdzgtfj+2z
        D4ML9iZ4oTrF8ryJ7Q1cqs2WJGGZEvPz6UIFKCsl0x/M6zhmb0K3G/4vEQuOc5wOXFLsmbBiL1Pxz
        wiNHgGJA==;
Received: from i114-182-241-148.s41.a014.ap.plala.or.jp ([114.182.241.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgb3W-009Qs9-2B;
        Mon, 27 Mar 2023 00:49:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 2/7] btrfs: don't free the async_extent in submit_uncompressed_range
Date:   Mon, 27 Mar 2023 09:49:48 +0900
Message-Id: <20230327004954.728797-3-hch@lst.de>
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

Let submit_one_async_extent, which is the only caller of
submit_uncompressed_range handle freeing of the async_extent in one
central place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 698915c032bddc..7a1bfce9532fe9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -944,10 +944,9 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 	ret = cow_file_range(inode, locked_page, start, end, &page_started,
 			     &nr_written, 0, NULL);
 	/* Inline extent inserted, page gets unlocked and everything is done */
-	if (page_started) {
-		ret = 0;
-		goto out;
-	}
+	if (page_started)
+		return 0;
+
 	if (ret < 0) {
 		btrfs_cleanup_ordered_extents(inode, locked_page, start, end - start + 1);
 		if (locked_page) {
@@ -961,14 +960,11 @@ static int submit_uncompressed_range(struct btrfs_inode *inode,
 			end_extent_writepage(locked_page, ret, page_start, page_end);
 			unlock_page(locked_page);
 		}
-		goto out;
+		return ret;
 	}
 
-	ret = extent_write_locked_range(&inode->vfs_inode, start, end);
 	/* All pages will be unlocked, including @locked_page */
-out:
-	kfree(async_extent);
-	return ret;
+	return extent_write_locked_range(&inode->vfs_inode, start, end);
 }
 
 static int submit_one_async_extent(struct btrfs_inode *inode,
@@ -1000,8 +996,10 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	lock_extent(io_tree, start, end, NULL);
 
 	/* We have fall back to uncompressed write */
-	if (!async_extent->pages)
-		return submit_uncompressed_range(inode, async_extent, locked_page);
+	if (!async_extent->pages) {
+		ret = submit_uncompressed_range(inode, async_extent, locked_page);
+		goto done;
+	}
 
 	ret = btrfs_reserve_extent(root, async_extent->ram_size,
 				   async_extent->compressed_size,
@@ -1066,6 +1064,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	if (async_chunk->blkcg_css)
 		kthread_associate_blkcg(NULL);
 	*alloc_hint = ins.objectid + ins.offset;
+done:
 	kfree(async_extent);
 	return ret;
 
@@ -1080,8 +1079,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
 				     PAGE_END_WRITEBACK | PAGE_SET_ERROR);
 	free_async_extent_pages(async_extent);
-	kfree(async_extent);
-	return ret;
+	goto done;
 }
 
 /*
-- 
2.39.2

