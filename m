Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E9B6C991A
	for <lists+cgroups@lfdr.de>; Mon, 27 Mar 2023 02:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjC0Aty (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Mar 2023 20:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjC0Atw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 26 Mar 2023 20:49:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FD719A6;
        Sun, 26 Mar 2023 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Trysqpweee+qWzGHqxcE1HT8iJvrLd8NeStOiz6Nac8=; b=t9r+LtTKkT/s7bbJCYSmxTg3R2
        WB05WrX7Diii3DvJ8p7nobg4U0Ekjjn04grlgNCRIgXAFfcyPgKdDfeEQ1JVpsyvBFZ+Hbhb6CWVo
        xC0PGSQFb3i2JBt3sVySdNCCWu+kRVTbSg/o7HsjgbWyg77gzct4ykXgtzlV4SEDf1YW749Zn3og1
        Bh00PNtYT12oIwOJCmV2uu0WpAVjB/zcSbNTy8NL1wn1AURLBwhRTleD5xU2UmZNQYCYXK3dgm9mG
        RjpwfqxL+dHu8Lzu8YCXm+8ArfEfcrrS79U9i0nVlcr6fePaZwPjk3P5ZKhIO8utjuWWtmfauOnnF
        bhdZGSMg==;
Received: from i114-182-241-148.s41.a014.ap.plala.or.jp ([114.182.241.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pgb3U-009Qrx-14;
        Mon, 27 Mar 2023 00:49:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: move kthread_associate_blkcg out of btrfs_submit_compressed_write
Date:   Mon, 27 Mar 2023 09:49:47 +0900
Message-Id: <20230327004954.728797-2-hch@lst.de>
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

btrfs_submit_compressed_write should not have to care if it is called
from a helper thread or not.  Move the kthread_associate_blkcg handling
into submit_one_async_extent, as that is the one caller that needs it.
Also move the assignment of REQ_CGROUP_PUNT into cow_file_range_async,
as that is the routine that sets up the helper thread offload.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c |  8 --------
 fs/btrfs/compression.h |  1 -
 fs/btrfs/inode.c       | 12 ++++++++----
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 44c4276741ceda..d532a8c8c9d8c6 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -286,7 +286,6 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				 struct page **compressed_pages,
 				 unsigned int nr_pages,
 				 blk_opf_t write_flags,
-				 struct cgroup_subsys_state *blkcg_css,
 				 bool writeback)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
@@ -295,10 +294,6 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
 
-	if (blkcg_css) {
-		kthread_associate_blkcg(blkcg_css);
-		write_flags |= REQ_CGROUP_PUNT;
-	}
 	write_flags |= REQ_BTRFS_ONE_ORDERED;
 
 	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE | write_flags,
@@ -314,9 +309,6 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	btrfs_add_compressed_bio_pages(cb);
 
 	btrfs_submit_bio(&cb->bbio, 0);
-
-	if (blkcg_css)
-		kthread_associate_blkcg(NULL);
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 5d5146e72a860b..19ab2abeddc088 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -92,7 +92,6 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  struct page **compressed_pages,
 				  unsigned int nr_pages,
 				  blk_opf_t write_flags,
-				  struct cgroup_subsys_state *blkcg_css,
 				  bool writeback);
 void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num);
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 865d56ff2ce150..698915c032bddc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1053,14 +1053,18 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	extent_clear_unlock_delalloc(inode, start, end,
 			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
+
+	if (async_chunk->blkcg_css)
+		kthread_associate_blkcg(async_chunk->blkcg_css);
 	btrfs_submit_compressed_write(inode, start,	/* file_offset */
 			    async_extent->ram_size,	/* num_bytes */
 			    ins.objectid,		/* disk_bytenr */
 			    ins.offset,			/* compressed_len */
 			    async_extent->pages,	/* compressed_pages */
 			    async_extent->nr_pages,
-			    async_chunk->write_flags,
-			    async_chunk->blkcg_css, true);
+			    async_chunk->write_flags, true);
+	if (async_chunk->blkcg_css)
+		kthread_associate_blkcg(NULL);
 	*alloc_hint = ins.objectid + ins.offset;
 	kfree(async_extent);
 	return ret;
@@ -1612,6 +1616,7 @@ static int cow_file_range_async(struct btrfs_inode *inode,
 		if (blkcg_css != blkcg_root_css) {
 			css_get(blkcg_css);
 			async_chunk[i].blkcg_css = blkcg_css;
+			async_chunk[i].write_flags |= REQ_CGROUP_PUNT;
 		} else {
 			async_chunk[i].blkcg_css = NULL;
 		}
@@ -10374,8 +10379,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
 	btrfs_submit_compressed_write(inode, start, num_bytes, ins.objectid,
-					  ins.offset, pages, nr_pages, 0, NULL,
-					  false);
+					  ins.offset, pages, nr_pages, 0, false);
 	ret = orig_count;
 	goto out;
 
-- 
2.39.2

