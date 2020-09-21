Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2507B271D68
	for <lists+cgroups@lfdr.de>; Mon, 21 Sep 2020 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgIUII5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 04:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgIUIH4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 04:07:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7C5C0613D0;
        Mon, 21 Sep 2020 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2dn2WwQmBPla+cC5mdzZ9FtMRqmgiouknKd2IiWUlyU=; b=NeJW9M4CIQPJA6yyQgcqUdQ/+N
        t2kozRZN0x9z8AA5cvCclaX70/BBkShs2jrGMSMTi65UQCY0HNs7jBS1UM9vTmRrwo7O13e8ftGul
        P1Y/2Q6SAeeKuBrU8aYUjznF92yFWkRHzlSLkwsHnK+fBcj63Nk02oFPqEn64thwfaoOitScqZ/0W
        PrksHXyEMc4sd7Je4gyHQuuEOkQLIlHan53CIg1zKzbCrSZEGA+vvfoFrnoNUgVOn+AL3EpL2mkJm
        ZgpiiH4qULhSkyEuz80KikZ7lTo716+6Xhcjk9QtyMWiISoqpAQaneT0twkTT9Tq7uxdGWJ9qRhSy
        teRvG4Sg==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKGrJ-0006X4-Kr; Mon, 21 Sep 2020 08:07:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Coly Li <colyli@suse.de>, Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Justin Sanders <justin@coraid.com>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 05/13] bdi: initialize ->ra_pages and ->io_pages in bdi_init
Date:   Mon, 21 Sep 2020 10:07:26 +0200
Message-Id: <20200921080734.452759-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921080734.452759-1-hch@lst.de>
References: <20200921080734.452759-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Set up a readahead size by default, as very few users have a good
reason to change it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Sterba <dsterba@suse.com> [btrfs]
Acked-by: Richard Weinberger <richard@nod.at> [ubifs, mtd]
---
 block/blk-core.c      | 2 --
 drivers/mtd/mtdcore.c | 2 ++
 fs/9p/vfs_super.c     | 6 ++++--
 fs/afs/super.c        | 1 -
 fs/btrfs/disk-io.c    | 1 -
 fs/fuse/inode.c       | 1 -
 fs/nfs/super.c        | 9 +--------
 fs/ubifs/super.c      | 2 ++
 fs/vboxsf/super.c     | 2 ++
 mm/backing-dev.c      | 2 ++
 10 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ca3f0f00c9435f..865d39e5be2b28 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -538,8 +538,6 @@ struct request_queue *blk_alloc_queue(int node_id)
 	if (!q->stats)
 		goto fail_stats;
 
-	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
-	q->backing_dev_info->io_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->node = node_id;
 
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 7d930569a7dfb7..b5e5d3140f578e 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -2196,6 +2196,8 @@ static struct backing_dev_info * __init mtd_bdi_init(char *name)
 	bdi = bdi_alloc(NUMA_NO_NODE);
 	if (!bdi)
 		return ERR_PTR(-ENOMEM);
+	bdi->ra_pages = 0;
+	bdi->io_pages = 0;
 
 	/*
 	 * We put '-0' suffix to the name to get the same name format as we
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 74df32be4c6a52..e34fa20acf612e 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -80,8 +80,10 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 	if (ret)
 		return ret;
 
-	if (v9ses->cache)
-		sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
+	if (!v9ses->cache) {
+		sb->s_bdi->ra_pages = 0;
+		sb->s_bdi->io_pages = 0;
+	}
 
 	sb->s_flags |= SB_ACTIVE | SB_DIRSYNC;
 	if (!v9ses->cache)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index b552357b1d1379..3a40ee752c1e3f 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -456,7 +456,6 @@ static int afs_fill_super(struct super_block *sb, struct afs_fs_context *ctx)
 	ret = super_setup_bdi(sb);
 	if (ret)
 		return ret;
-	sb->s_bdi->ra_pages	= VM_READAHEAD_PAGES;
 
 	/* allocate the root inode and dentry */
 	if (as->dyn_root) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f6bba7eb1fa171..047934cea25efa 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3092,7 +3092,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	}
 
 	sb->s_bdi->capabilities |= BDI_CAP_CGROUP_WRITEBACK;
-	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
 	sb->s_bdi->ra_pages *= btrfs_super_num_devices(disk_super);
 	sb->s_bdi->ra_pages = max(sb->s_bdi->ra_pages, SZ_4M / PAGE_SIZE);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bba747520e9b08..17b00670fb539e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1049,7 +1049,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	if (err)
 		return err;
 
-	sb->s_bdi->ra_pages = VM_READAHEAD_PAGES;
 	/* fuse does it's own writeback accounting */
 	sb->s_bdi->capabilities = BDI_CAP_NO_ACCT_WB | BDI_CAP_STRICTLIMIT;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7a70287f21a2c1..f943e37853fa25 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1200,13 +1200,6 @@ static void nfs_get_cache_cookie(struct super_block *sb,
 }
 #endif
 
-static void nfs_set_readahead(struct backing_dev_info *bdi,
-			      unsigned long iomax_pages)
-{
-	bdi->ra_pages = VM_READAHEAD_PAGES;
-	bdi->io_pages = iomax_pages;
-}
-
 int nfs_get_tree_common(struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
@@ -1251,7 +1244,7 @@ int nfs_get_tree_common(struct fs_context *fc)
 					     MINOR(server->s_dev));
 		if (error)
 			goto error_splat_super;
-		nfs_set_readahead(s->s_bdi, server->rpages);
+		s->s_bdi->io_pages = server->rpages;
 		server->super = s;
 	}
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index a2420c900275a8..fbddb2a1c03f5e 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2177,6 +2177,8 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
 				   c->vi.vol_id);
 	if (err)
 		goto out_close;
+	sb->s_bdi->ra_pages = 0;
+	sb->s_bdi->io_pages = 0;
 
 	sb->s_fs_info = c;
 	sb->s_magic = UBIFS_SUPER_MAGIC;
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 8fe03b4a0d2b03..8e3792177a8523 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -167,6 +167,8 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	err = super_setup_bdi_name(sb, "vboxsf-%d", sbi->bdi_id);
 	if (err)
 		goto fail_free;
+	sb->s_bdi->ra_pages = 0;
+	sb->s_bdi->io_pages = 0;
 
 	/* Turn source into a shfl_string and map the folder */
 	size = strlen(fc->source) + 1;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 8e8b00627bb2d8..2dac3be6127127 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -746,6 +746,8 @@ struct backing_dev_info *bdi_alloc(int node_id)
 		kfree(bdi);
 		return NULL;
 	}
+	bdi->ra_pages = VM_READAHEAD_PAGES;
+	bdi->io_pages = VM_READAHEAD_PAGES;
 	return bdi;
 }
 EXPORT_SYMBOL(bdi_alloc);
-- 
2.28.0

