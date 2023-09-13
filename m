Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE7479E5FC
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbjIMLLz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240131AbjIMLLe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19D213F;
        Wed, 13 Sep 2023 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YeFdg8Rdc0HiwQgEVpym3VutxNJbCKOKOSLKAqhIbZ8=; b=TmeYN7Id3ID2srZ59tdlQLtHw+
        +O+Na/9hAX8+1ouEAgfUTovguJ90skM7nau9iObUbsZ/gMJq+1JQ9cb8Tmjz5hqTxAVBNyMwqBoSb
        8dxWRX5frIREnp+T0NI1WbgH96CqX3mxoZkUMDRzGGQR3R5ot016Hgp0+72WtoRz6O+7ltEr9YV/l
        sg5dkEyhsFd3V2BXe9nnkZaLwi4eC6YhjK8jC4pNUEldpUjs8/6/euwL/2DV2oaJaNiU9soL6cDYp
        VAVXSRqZy1366S+LPce4LkGtxLz52/qsFiw5RGjFvwHEFEmaY7xICAo8/aXDRClpEGNJ6BN4x6uQw
        E9EvuE5g==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlz-005i6m-1T;
        Wed, 13 Sep 2023 11:11:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Tejun Heo <tj@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 13/19] fs: convert kill_block_super to block_free_sb
Date:   Wed, 13 Sep 2023 08:10:07 -0300
Message-Id: <20230913111013.77623-14-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace kill_block_super with block_free_sb, which is wired up to
the ->free_sb method.  For file systems that wrapped kill_block_super,
->kill_sb is replaced with ->shutdown and ->free_sb methods as needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/adfs/super.c          |  2 +-
 fs/affs/super.c          |  7 ++++---
 fs/befs/linuxvfs.c       |  2 +-
 fs/bfs/inode.c           |  2 +-
 fs/efs/super.c           |  7 ++++---
 fs/erofs/super.c         | 25 ++++++++++---------------
 fs/exfat/super.c         |  6 +++---
 fs/ext2/super.c          |  2 +-
 fs/ext4/super.c          | 12 ++++++------
 fs/f2fs/super.c          |  6 +++---
 fs/fat/namei_msdos.c     |  2 +-
 fs/fat/namei_vfat.c      |  2 +-
 fs/freevxfs/vxfs_super.c |  2 +-
 fs/fuse/inode.c          | 12 ++++++------
 fs/gfs2/ops_fstype.c     | 11 ++++-------
 fs/hfs/super.c           |  2 +-
 fs/hfsplus/super.c       |  2 +-
 fs/hpfs/super.c          |  2 +-
 fs/isofs/inode.c         |  2 +-
 fs/jfs/super.c           |  2 +-
 fs/minix/inode.c         |  2 +-
 fs/nilfs2/super.c        |  2 +-
 fs/ntfs/super.c          |  2 +-
 fs/ntfs3/super.c         |  6 +++---
 fs/ocfs2/super.c         |  2 +-
 fs/omfs/inode.c          |  2 +-
 fs/qnx4/inode.c          |  7 ++++---
 fs/qnx6/inode.c          |  2 +-
 fs/reiserfs/super.c      |  7 +++----
 fs/squashfs/super.c      |  2 +-
 fs/super.c               |  6 ++----
 fs/sysv/super.c          |  4 ++--
 fs/udf/super.c           |  2 +-
 fs/ufs/super.c           |  2 +-
 fs/xfs/xfs_buf.c         |  2 +-
 fs/xfs/xfs_super.c       |  6 +++---
 fs/zonefs/super.c        | 13 ++++++-------
 include/linux/fs.h       |  2 +-
 38 files changed, 86 insertions(+), 95 deletions(-)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index e8bfc38239cd59..22f0137f485e5f 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -463,7 +463,7 @@ static struct file_system_type adfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "adfs",
 	.mount		= adfs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("adfs");
diff --git a/fs/affs/super.c b/fs/affs/super.c
index 58b391446ae1fd..775e878797f9fc 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -631,10 +631,11 @@ static struct dentry *affs_mount(struct file_system_type *fs_type,
 	return mount_bdev(fs_type, flags, dev_name, data, affs_fill_super);
 }
 
-static void affs_kill_sb(struct super_block *sb)
+static void affs_free_sb(struct super_block *sb)
 {
 	struct affs_sb_info *sbi = AFFS_SB(sb);
-	kill_block_super(sb);
+
+	block_free_sb(sb);
 	if (sbi) {
 		affs_free_bitmap(sb);
 		affs_brelse(sbi->s_root_bh);
@@ -648,7 +649,7 @@ static struct file_system_type affs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "affs",
 	.mount		= affs_mount,
-	.kill_sb	= affs_kill_sb,
+	.free_sb	= affs_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("affs");
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 9a16a51fbb88d4..7682c027d44782 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -981,7 +981,7 @@ static struct file_system_type befs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "befs",
 	.mount		= befs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("befs");
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index e6a76ae9eb4442..4d894d5dd07074 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -458,7 +458,7 @@ static struct file_system_type bfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "bfs",
 	.mount		= bfs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("bfs");
diff --git a/fs/efs/super.c b/fs/efs/super.c
index b287f47c165ba8..1f808a455e7e87 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -28,10 +28,11 @@ static struct dentry *efs_mount(struct file_system_type *fs_type,
 	return mount_bdev(fs_type, flags, dev_name, data, efs_fill_super);
 }
 
-static void efs_kill_sb(struct super_block *s)
+static void efs_free_sb(struct super_block *s)
 {
 	struct efs_sb_info *sbi = SUPER_INFO(s);
-	kill_block_super(s);
+
+	block_free_sb(s);
 	kfree(sbi);
 }
 
@@ -39,7 +40,7 @@ static struct file_system_type efs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "efs",
 	.mount		= efs_mount,
-	.kill_sb	= efs_kill_sb,
+	.free_sb	= efs_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("efs");
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 07c36ccf454e53..29b87bb35b1ddc 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -872,22 +872,17 @@ static int erofs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void erofs_kill_sb(struct super_block *sb)
+static void erofs_free_sb(struct super_block *sb)
 {
-	struct erofs_sb_info *sbi;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	/* pseudo mount for anon inodes */
-	if (sb->s_flags & SB_KERNMOUNT) {
-		generic_shutdown_super(sb);
+	if (sb->s_flags & SB_KERNMOUNT)
 		return;
-	}
 
-	if (erofs_is_fscache_mode(sb))
-		generic_shutdown_super(sb);
-	else
-		kill_block_super(sb);
+	if (!erofs_is_fscache_mode(sb))
+		block_free_sb(sb);
 
-	sbi = EROFS_SB(sb);
 	if (!sbi)
 		return;
 
@@ -921,11 +916,11 @@ static void erofs_put_super(struct super_block *sb)
 }
 
 struct file_system_type erofs_fs_type = {
-	.owner          = THIS_MODULE,
-	.name           = "erofs",
-	.init_fs_context = erofs_init_fs_context,
-	.kill_sb        = erofs_kill_sb,
-	.fs_flags       = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
+	.owner          	= THIS_MODULE,
+	.name           	= "erofs",
+	.init_fs_context	= erofs_init_fs_context,
+	.free_sb		= erofs_free_sb,
+	.fs_flags       	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("erofs");
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 2778bd9b631e72..c040f964f3ca75 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -764,11 +764,11 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void exfat_kill_sb(struct super_block *sb)
+static void exfat_free_sb(struct super_block *sb)
 {
 	struct exfat_sb_info *sbi = sb->s_fs_info;
 
-	kill_block_super(sb);
+	block_free_sb(sb);
 	if (sbi)
 		exfat_free_sbi(sbi);
 }
@@ -778,7 +778,7 @@ static struct file_system_type exfat_fs_type = {
 	.name			= "exfat",
 	.init_fs_context	= exfat_init_fs_context,
 	.parameters		= exfat_parameters,
-	.kill_sb		= exfat_kill_sb,
+	.free_sb		= exfat_free_sb,
 	.fs_flags		= FS_REQUIRES_DEV,
 };
 
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index aaf3e3e88cb218..80bbf5b9009732 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1628,7 +1628,7 @@ static struct file_system_type ext2_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ext2",
 	.mount		= ext2_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext2");
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 38217422f93883..24e125e2da19ca 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -93,7 +93,7 @@ static int ext4_get_tree(struct fs_context *fc);
 static int ext4_reconfigure(struct fs_context *fc);
 static void ext4_fc_free(struct fs_context *fc);
 static int ext4_init_fs_context(struct fs_context *fc);
-static void ext4_kill_sb(struct super_block *sb);
+static void ext4_free_sb(struct super_block *sb);
 static const struct fs_parameter_spec ext4_param_specs[];
 
 /*
@@ -136,7 +136,7 @@ static struct file_system_type ext2_fs_type = {
 	.name			= "ext2",
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
-	.kill_sb		= ext4_kill_sb,
+	.free_sb		= ext4_free_sb,
 	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext2");
@@ -152,7 +152,7 @@ static struct file_system_type ext3_fs_type = {
 	.name			= "ext3",
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
-	.kill_sb		= ext4_kill_sb,
+	.free_sb		= ext4_free_sb,
 	.fs_flags		= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ext3");
@@ -7297,12 +7297,12 @@ static inline int ext3_feature_set_ok(struct super_block *sb)
 	return 1;
 }
 
-static void ext4_kill_sb(struct super_block *sb)
+static void ext4_free_sb(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct block_device *journal_bdev = sbi ? sbi->s_journal_bdev : NULL;
 
-	kill_block_super(sb);
+	block_free_sb(sb);
 
 	if (journal_bdev)
 		blkdev_put(journal_bdev, sb);
@@ -7313,7 +7313,7 @@ static struct file_system_type ext4_fs_type = {
 	.name			= "ext4",
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
-	.kill_sb		= ext4_kill_sb,
+	.free_sb		= ext4_free_sb,
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("ext4");
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a8c8232852bb18..571eb08683d0ea 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4850,7 +4850,7 @@ static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
 	return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
 }
 
-static void kill_f2fs_super(struct super_block *sb)
+static void f2fs_shutdown_sb(struct super_block *sb)
 {
 	if (sb->s_root) {
 		struct f2fs_sb_info *sbi = F2FS_SB(sb);
@@ -4880,14 +4880,14 @@ static void kill_f2fs_super(struct super_block *sb)
 		if (is_sbi_flag_set(sbi, SBI_IS_RECOVERED) && f2fs_readonly(sb))
 			sb->s_flags &= ~SB_RDONLY;
 	}
-	kill_block_super(sb);
 }
 
 static struct file_system_type f2fs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "f2fs",
 	.mount		= f2fs_mount,
-	.kill_sb	= kill_f2fs_super,
+	.shutdown_sb	= f2fs_shutdown_sb,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("f2fs");
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 2116c486843b7d..429e417c964a7a 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -666,7 +666,7 @@ static struct file_system_type msdos_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "msdos",
 	.mount		= msdos_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("msdos");
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index c4d00999a43300..4b0500c4d4c554 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -1211,7 +1211,7 @@ static struct file_system_type vfat_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "vfat",
 	.mount		= vfat_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("vfat");
diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index 310d73e254df2c..d33f3dae0663ff 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -292,7 +292,7 @@ static struct file_system_type vxfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "vxfs",
 	.mount		= vxfs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("vxfs"); /* makes mount -t vxfs autoload the module */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 5731003b56a9c9..d9981532530702 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1818,7 +1818,7 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 }
 EXPORT_SYMBOL_GPL(fuse_conn_destroy);
 
-static void fuse_sb_destroy(struct super_block *sb)
+static void fuse_shutdown_sb(struct super_block *sb)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	bool last;
@@ -1839,7 +1839,7 @@ EXPORT_SYMBOL(fuse_mount_destroy);
 
 static void fuse_kill_sb_anon(struct super_block *sb)
 {
-	fuse_sb_destroy(sb);
+	fuse_shutdown_sb(sb);
 	generic_shutdown_super(sb);
 	fuse_mount_destroy(get_fuse_mount_super(sb));
 }
@@ -1855,10 +1855,9 @@ static struct file_system_type fuse_fs_type = {
 MODULE_ALIAS_FS("fuse");
 
 #ifdef CONFIG_BLOCK
-static void fuse_kill_sb_blk(struct super_block *sb)
+static void fuseblk_free_sb(struct super_block *sb)
 {
-	fuse_sb_destroy(sb);
-	kill_block_super(sb);
+	block_free_sb(sb);
 	fuse_mount_destroy(get_fuse_mount_super(sb));
 }
 
@@ -1867,7 +1866,8 @@ static struct file_system_type fuseblk_fs_type = {
 	.name		= "fuseblk",
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
-	.kill_sb	= fuse_kill_sb_blk,
+	.shutdown_sb	= fuse_shutdown_sb,
+	.free_sb	= fuseblk_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
 };
 MODULE_ALIAS_FS("fuseblk");
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 33ca04733e933e..2c84ec7dd5b3d5 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1781,14 +1781,12 @@ static void gfs2_evict_inodes(struct super_block *sb)
 	iput(toput_inode);
 }
 
-static void gfs2_kill_sb(struct super_block *sb)
+static void gfs2_shutdown_sb(struct super_block *sb)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
-	if (sdp == NULL) {
-		kill_block_super(sb);
+	if (!sdp)
 		return;
-	}
 
 	gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_SYNC | GFS2_LFC_KILL_SB);
 	dput(sdp->sd_root_dir);
@@ -1807,8 +1805,6 @@ static void gfs2_kill_sb(struct super_block *sb)
 	set_bit(SDF_KILL, &sdp->sd_flags);
 	gfs2_flush_delete_work(sdp);
 	destroy_workqueue(sdp->sd_delete_wq);
-
-	kill_block_super(sb);
 }
 
 struct file_system_type gfs2_fs_type = {
@@ -1816,7 +1812,8 @@ struct file_system_type gfs2_fs_type = {
 	.fs_flags = FS_REQUIRES_DEV,
 	.init_fs_context = gfs2_init_fs_context,
 	.parameters = gfs2_fs_parameters,
-	.kill_sb = gfs2_kill_sb,
+	.shutdown_sb = gfs2_shutdown_sb,
+	.free_sb = block_free_sb,
 	.owner = THIS_MODULE,
 };
 MODULE_ALIAS_FS("gfs2");
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 6764afa98a6ff1..56dbce9d4daa3d 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -460,7 +460,7 @@ static struct file_system_type hfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfs",
 	.mount		= hfs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("hfs");
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 1986b4f18a9013..d0994cdeafdb17 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -645,7 +645,7 @@ static struct file_system_type hfsplus_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfsplus",
 	.mount		= hfsplus_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("hfsplus");
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 758a51564124dc..df8a641fe71657 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -763,7 +763,7 @@ static struct file_system_type hpfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hpfs",
 	.mount		= hpfs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("hpfs");
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 2ee21286ac8f07..524fae2ff0d9bf 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1563,7 +1563,7 @@ static struct file_system_type iso9660_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "iso9660",
 	.mount		= isofs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("iso9660");
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 2e2f7f6d36a09d..6a44da0c652194 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -905,7 +905,7 @@ static struct file_system_type jfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "jfs",
 	.mount		= jfs_do_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("jfs");
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index df575473c1cc0b..9e812e0882bbb1 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -688,7 +688,7 @@ static struct file_system_type minix_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "minix",
 	.mount		= minix_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("minix");
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index a5d1fa4e7552f6..95b0e33a665d8c 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1370,7 +1370,7 @@ struct file_system_type nilfs_fs_type = {
 	.owner    = THIS_MODULE,
 	.name     = "nilfs2",
 	.mount    = nilfs_mount,
-	.kill_sb  = kill_block_super,
+	.free_sb  = block_free_sb,
 	.fs_flags = FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("nilfs2");
diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 56a7d5bd33e4e2..811283d709faeb 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -3061,7 +3061,7 @@ static struct file_system_type ntfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ntfs",
 	.mount		= ntfs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ntfs");
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cfec5e0c7f66ae..8e8b614773e071 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1720,11 +1720,11 @@ static int ntfs_init_fs_context(struct fs_context *fc)
 	return -ENOMEM;
 }
 
-static void ntfs3_kill_sb(struct super_block *sb)
+static void ntfs3_free_sb(struct super_block *sb)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 
-	kill_block_super(sb);
+	block_free_sb(sb);
 
 	if (sbi->options)
 		put_mount_options(sbi->options);
@@ -1737,7 +1737,7 @@ static struct file_system_type ntfs_fs_type = {
 	.name			= "ntfs3",
 	.init_fs_context	= ntfs_init_fs_context,
 	.parameters		= ntfs_fs_parameters,
-	.kill_sb		= ntfs3_kill_sb,
+	.free_sb		= ntfs3_free_sb,
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 // clang-format on
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 6b906424902b46..fc63858a6744af 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1190,7 +1190,7 @@ static struct file_system_type ocfs2_fs_type = {
 	.owner          = THIS_MODULE,
 	.name           = "ocfs2",
 	.mount          = ocfs2_mount,
-	.kill_sb        = kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags       = FS_REQUIRES_DEV|FS_RENAME_DOES_D_MOVE,
 	.next           = NULL
 };
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 2f8c1882f45c85..7bb65fccc7a6b0 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -606,7 +606,7 @@ static struct file_system_type omfs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "omfs",
 	.mount = omfs_mount,
-	.kill_sb = kill_block_super,
+	.free_sb = block_free_sb,
 	.fs_flags = FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("omfs");
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index a7171f5532a1f8..56825072ac90da 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -235,10 +235,11 @@ static int qnx4_fill_super(struct super_block *s, void *data, int silent)
 	return 0;
 }
 
-static void qnx4_kill_sb(struct super_block *sb)
+static void qnx4_free_sb(struct super_block *sb)
 {
 	struct qnx4_sb_info *qs = qnx4_sb(sb);
-	kill_block_super(sb);
+
+	block_free_sb(sb);
 	if (qs) {
 		kfree(qs->BitMap);
 		kfree(qs);
@@ -388,7 +389,7 @@ static struct file_system_type qnx4_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "qnx4",
 	.mount		= qnx4_mount,
-	.kill_sb	= qnx4_kill_sb,
+	.free_sb	= qnx4_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("qnx4");
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 21f90d519f1a16..1ac37a6bdec7dc 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -644,7 +644,7 @@ static struct file_system_type qnx6_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "qnx6",
 	.mount		= qnx6_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("qnx6");
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 7eaf36b3de12b4..e9633533d20261 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -547,7 +547,7 @@ int remove_save_link(struct inode *inode, int truncate)
 	return journal_end(&th);
 }
 
-static void reiserfs_kill_sb(struct super_block *s)
+static void reiserfs_shutdown_sb(struct super_block *s)
 {
 	if (REISERFS_SB(s)) {
 		reiserfs_proc_info_done(s);
@@ -566,8 +566,6 @@ static void reiserfs_kill_sb(struct super_block *s)
 		dput(REISERFS_SB(s)->priv_root);
 		REISERFS_SB(s)->priv_root = NULL;
 	}
-
-	kill_block_super(s);
 }
 
 #ifdef CONFIG_QUOTA
@@ -2634,7 +2632,8 @@ struct file_system_type reiserfs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "reiserfs",
 	.mount = get_super_block,
-	.kill_sb = reiserfs_kill_sb,
+	.shutdown_sb = reiserfs_shutdown_sb,
+	.free_sb = block_free_sb,
 	.fs_flags = FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("reiserfs");
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 22e812808e5cf9..ecb9d3a22a859c 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -678,7 +678,7 @@ static struct file_system_type squashfs_fs_type = {
 	.name = "squashfs",
 	.init_fs_context = squashfs_init_fs_context,
 	.parameters = squashfs_fs_parameters,
-	.kill_sb = kill_block_super,
+	.free_sb = block_free_sb,
 	.fs_flags = FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("squashfs");
diff --git a/fs/super.c b/fs/super.c
index 1173a272bd086a..805ca1dd1e23f2 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1665,18 +1665,16 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 }
 EXPORT_SYMBOL(mount_bdev);
 
-void kill_block_super(struct super_block *sb)
+void block_free_sb(struct super_block *sb)
 {
 	struct block_device *bdev = sb->s_bdev;
 
-	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
 		blkdev_put(bdev, sb);
 	}
 }
-
-EXPORT_SYMBOL(kill_block_super);
+EXPORT_SYMBOL(block_free_sb);
 #endif
 
 struct dentry *mount_nodev(struct file_system_type *fs_type,
diff --git a/fs/sysv/super.c b/fs/sysv/super.c
index 3365a30dc1e0cd..028a813af3a520 100644
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -544,7 +544,7 @@ static struct file_system_type sysv_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "sysv",
 	.mount		= sysv_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("sysv");
@@ -553,7 +553,7 @@ static struct file_system_type v7_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "v7",
 	.mount		= v7_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("v7");
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 928a04d9d9e0ad..c610cf41e4efae 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -129,7 +129,7 @@ static struct file_system_type udf_fstype = {
 	.owner		= THIS_MODULE,
 	.name		= "udf",
 	.mount		= udf_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("udf");
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 23377c1baed9e0..ab3e9f4b657824 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1512,7 +1512,7 @@ static struct file_system_type ufs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ufs",
 	.mount		= ufs_mount,
-	.kill_sb	= kill_block_super,
+	.free_sb	= block_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("ufs");
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index c1ece4a08ff446..bf2e43d6885bfc 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1953,7 +1953,7 @@ xfs_free_buftarg(
 	list_lru_destroy(&btp->bt_lru);
 
 	fs_put_dax(btp->bt_daxdev, btp->bt_mount);
-	/* the main block device is closed by kill_block_super */
+	/* the main block device is closed by block_free_sb */
 	if (bdev != btp->bt_mount->m_super->s_bdev)
 		blkdev_put(bdev, btp->bt_mount->m_super);
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 1f77014c6e1abd..a3c07ca4e648c2 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2052,10 +2052,10 @@ static int xfs_init_fs_context(
 }
 
 static void
-xfs_kill_sb(
+xfs_free_sb(
 	struct super_block		*sb)
 {
-	kill_block_super(sb);
+	block_free_sb(sb);
 	xfs_mount_free(XFS_M(sb));
 }
 
@@ -2064,7 +2064,7 @@ static struct file_system_type xfs_fs_type = {
 	.name			= "xfs",
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
-	.kill_sb		= xfs_kill_sb,
+	.free_sb		= xfs_free_sb,
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
 };
 MODULE_ALIAS_FS("xfs");
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 35b2554ce2ac2e..0406e0e33ebdbc 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1221,7 +1221,7 @@ static int zonefs_get_zgroup_inodes(struct super_block *sb)
 	return 0;
 }
 
-static void zonefs_release_zgroup_inodes(struct super_block *sb)
+static void zonefs_shutdown_sb(struct super_block *sb)
 {
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	enum zonefs_ztype ztype;
@@ -1229,6 +1229,7 @@ static void zonefs_release_zgroup_inodes(struct super_block *sb)
 	if (!sbi)
 		return;
 
+	/* Release the reference on the zone group directory inodes */
 	for (ztype = 0; ztype < ZONEFS_ZTYPE_MAX; ztype++) {
 		if (sbi->s_zgroup[ztype].g_inode) {
 			iput(sbi->s_zgroup[ztype].g_inode);
@@ -1351,14 +1352,11 @@ static struct dentry *zonefs_mount(struct file_system_type *fs_type,
 	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
 }
 
-static void zonefs_kill_super(struct super_block *sb)
+static void zonefs_free_sb(struct super_block *sb)
 {
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 
-	/* Release the reference on the zone group directory inodes */
-	zonefs_release_zgroup_inodes(sb);
-
-	kill_block_super(sb);
+	block_free_sb(sb);
 
 	zonefs_sysfs_unregister(sb);
 	zonefs_free_zgroups(sb);
@@ -1372,7 +1370,8 @@ static struct file_system_type zonefs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "zonefs",
 	.mount		= zonefs_mount,
-	.kill_sb	= zonefs_kill_super,
+	.shutdown_sb	= zonefs_shutdown_sb,
+	.free_sb	= zonefs_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c44c6fe9fc045b..302be5dfc1a04a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2383,7 +2383,7 @@ extern struct dentry *mount_nodev(struct file_system_type *fs_type,
 extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
 void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
-void kill_block_super(struct super_block *sb);
+void block_free_sb(struct super_block *sb);
 void litter_shutdown_sb(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
 void deactivate_locked_super(struct super_block *sb);
-- 
2.39.2

