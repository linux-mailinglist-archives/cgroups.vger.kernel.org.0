Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84479E617
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbjIMLLM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240007AbjIMLLK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4C31BCE;
        Wed, 13 Sep 2023 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3avJL3u53FV6NqWfVNR/cHfMXbZSKZNFLdERG/9TrPo=; b=AHb5SmSeP1rGpHmMiLyXBAyBuz
        NjiS5PHlRkymtdfwux/qZCDQDIhM1N03z03eV/bhcgSRfsq1UoeSHVegcNUcwLYyYpypbVAoBw5+Y
        7jrfAvyWIAwP9VDwES3HzHe7vUZ4D2v65qMImxcaTZkLU59GQG5cgWK4BG0rNV3hcWeLjgCrY53Kd
        y4AUawhEdkcUbSAxYjMGh9hxwzKpgPcnF/+a7grduzv0tLcl64dckW5I/thHtke5Pmn8d0yK5Ma/B
        2kJitaOaVl4nuKta7Dg1FYZf+Ce2rkVt3h+ihx6AJyaeunVkBysmTk9TCJE4jZCzYV3+ZnRahYlvR
        hzrcqXfw==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlR-005hvq-2K;
        Wed, 13 Sep 2023 11:10:34 +0000
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
Subject: [PATCH 03/19] fs: release anon dev_t in deactivate_locked_super
Date:   Wed, 13 Sep 2023 08:09:57 -0300
Message-Id: <20230913111013.77623-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Releasing an anon dev_t is a very common thing when freeing a
super_block, as that's done for basically any not block based file
system (modulo the odd mtd special case).  So instead of requiring
a special ->kill_sb helper and a lot of boilerplate in more complicated
file systems, just release the anon dev_t in deactivate_locked_super if
the super_block was using one.

As the freeing is done after the main call to kill_super_notify, this
removes the need for having two slightly different call sites for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bdev.c                    |  1 -
 drivers/dax/super.c             |  1 -
 drivers/dma-buf/dma-buf.c       |  1 -
 drivers/gpu/drm/drm_drv.c       |  1 -
 drivers/misc/cxl/api.c          |  1 -
 drivers/scsi/cxlflash/ocxl_hw.c |  1 -
 fs/9p/vfs_super.c               |  2 +-
 fs/afs/super.c                  |  2 +-
 fs/aio.c                        |  1 -
 fs/anon_inodes.c                |  1 -
 fs/autofs/inode.c               |  4 ++--
 fs/btrfs/super.c                |  3 ++-
 fs/btrfs/tests/btrfs-tests.c    |  1 -
 fs/ceph/super.c                 |  2 +-
 fs/coda/inode.c                 |  1 -
 fs/ecryptfs/main.c              |  3 ++-
 fs/erofs/super.c                |  4 ++--
 fs/fuse/inode.c                 |  2 +-
 fs/fuse/virtio_fs.c             |  2 +-
 fs/hostfs/hostfs_kern.c         |  2 +-
 fs/kernfs/mount.c               |  2 +-
 fs/nfs/super.c                  |  2 +-
 fs/nsfs.c                       |  1 -
 fs/openpromfs/inode.c           |  1 -
 fs/orangefs/super.c             |  2 +-
 fs/overlayfs/super.c            |  1 -
 fs/pipe.c                       |  1 -
 fs/proc/root.c                  |  4 ++--
 fs/smb/client/cifsfs.c          |  2 +-
 fs/super.c                      | 22 ++++++++--------------
 fs/ubifs/super.c                |  3 ++-
 fs/vboxsf/super.c               |  1 -
 include/linux/fs.h              |  1 -
 kernel/resource.c               |  1 -
 mm/secretmem.c                  |  1 -
 net/socket.c                    |  1 -
 security/apparmor/apparmorfs.c  |  1 -
 37 files changed, 30 insertions(+), 53 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f3b13aa1b7d428..9db691401497bb 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -358,7 +358,6 @@ static int bd_init_fs_context(struct fs_context *fc)
 static struct file_system_type bd_type = {
 	.name		= "bdev",
 	.init_fs_context = bd_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 struct super_block *blockdev_superblock __read_mostly;
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0da9232ea1754b..a9315b7396e68a 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -397,7 +397,6 @@ static int dax_init_fs_context(struct fs_context *fc)
 static struct file_system_type dax_fs_type = {
 	.name		= "dax",
 	.init_fs_context = dax_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 static int dax_test(struct inode *inode, void *data)
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 21916bba77d58b..7313e99f6e8ea5 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -125,7 +125,6 @@ static int dma_buf_fs_init_context(struct fs_context *fc)
 static struct file_system_type dma_buf_fs_type = {
 	.name = "dmabuf",
 	.init_fs_context = dma_buf_fs_init_context,
-	.kill_sb = kill_anon_super,
 };
 
 static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 3eda026ffac6a9..83676229cbe233 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -530,7 +530,6 @@ static struct file_system_type drm_fs_type = {
 	.name		= "drm",
 	.owner		= THIS_MODULE,
 	.init_fs_context = drm_fs_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 static struct inode *drm_fs_inode_new(void)
diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index d85c5653086357..05b40076a0b481 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -44,7 +44,6 @@ static struct file_system_type cxl_fs_type = {
 	.name		= "cxl",
 	.owner		= THIS_MODULE,
 	.init_fs_context = cxl_fs_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 6542818e595a64..20f22610b104df 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -43,7 +43,6 @@ static struct file_system_type ocxlflash_fs_type = {
 	.name		= "ocxlflash",
 	.owner		= THIS_MODULE,
 	.init_fs_context = ocxlflash_fs_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 /*
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 73db55c050bf10..9e60eddf5179ed 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -217,7 +217,7 @@ static void v9fs_kill_super(struct super_block *s)
 
 	p9_debug(P9_DEBUG_VFS, " %p\n", s);
 
-	kill_anon_super(s);
+	generic_shutdown_super(s);
 
 	v9fs_session_cancel(v9ses);
 	v9fs_session_close(v9ses);
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 95d713074dc813..754b9828233497 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -544,7 +544,7 @@ static void afs_kill_super(struct super_block *sb)
 	 */
 	if (as->volume)
 		rcu_assign_pointer(as->volume->sb, NULL);
-	kill_anon_super(sb);
+	generic_shutdown_super(sb);
 	if (as->volume)
 		afs_deactivate_volume(as->volume);
 	afs_destroy_sbi(as);
diff --git a/fs/aio.c b/fs/aio.c
index a4c2a6bac72ce9..de56e4a880debe 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -293,7 +293,6 @@ static int __init aio_setup(void)
 	static struct file_system_type aio_fs = {
 		.name		= "aio",
 		.init_fs_context = aio_init_fs_context,
-		.kill_sb	= kill_anon_super,
 	};
 	aio_mnt = kern_mount(&aio_fs);
 	if (IS_ERR(aio_mnt))
diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 24192a7667edf7..9c670bbe0f62ce 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -52,7 +52,6 @@ static int anon_inodefs_init_fs_context(struct fs_context *fc)
 static struct file_system_type anon_inode_fs_type = {
 	.name		= "anon_inodefs",
 	.init_fs_context = anon_inodefs_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 static struct inode *anon_inode_make_secure_inode(
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 2b49662ed237de..c3b64799155840 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -44,7 +44,7 @@ void autofs_kill_sb(struct super_block *sb)
 	/*
 	 * In the event of a failure in get_sb_nodev the superblock
 	 * info is not present so nothing else has been setup, so
-	 * just call kill_anon_super when we are called from
+	 * just call generic_shutdown_super when we are called from
 	 * deactivate_super.
 	 */
 	if (sbi) {
@@ -54,7 +54,7 @@ void autofs_kill_sb(struct super_block *sb)
 	}
 
 	pr_debug("shutting down\n");
-	kill_litter_super(sb);
+	generic_shutdown_super(sb);
 	if (sbi)
 		kfree_rcu(sbi, rcu);
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 09bfe68d2ea3fc..01b86bd4eae8dc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2141,7 +2141,8 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 static void btrfs_kill_super(struct super_block *sb)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-	kill_anon_super(sb);
+
+	generic_shutdown_super(sb);
 	btrfs_free_fs_info(fs_info);
 }
 
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index ca09cf9afce800..c30280376fc32e 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -48,7 +48,6 @@ static int btrfs_test_init_fs_context(struct fs_context *fc)
 static struct file_system_type test_type = {
 	.name		= "btrfs_test_fs",
 	.init_fs_context = btrfs_test_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 struct inode *btrfs_new_test_inode(void)
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 2d7f5a8d4a9260..7feef0b35b97b5 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1557,7 +1557,7 @@ static void ceph_kill_sb(struct super_block *s)
 	}
 
 	mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHED;
-	kill_anon_super(s);
+	generic_shutdown_super(s);
 
 	fsc->client->extra_mon_dispatch = NULL;
 	ceph_fs_debugfs_cleanup(fsc);
diff --git a/fs/coda/inode.c b/fs/coda/inode.c
index 0c7c2528791ebc..2d4ee3c7e8654b 100644
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -325,7 +325,6 @@ struct file_system_type coda_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "coda",
 	.mount		= coda_mount,
-	.kill_sb	= kill_anon_super,
 	.fs_flags	= FS_BINARY_MOUNTDATA,
 };
 MODULE_ALIAS_FS("coda");
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dc927ba067fec..d99b2311759166 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -625,7 +625,8 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 static void ecryptfs_kill_block_super(struct super_block *sb)
 {
 	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(sb);
-	kill_anon_super(sb);
+
+	generic_shutdown_super(sb);
 	if (!sb_info)
 		return;
 	ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 44a24d573f1fd3..07c36ccf454e53 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -878,12 +878,12 @@ static void erofs_kill_sb(struct super_block *sb)
 
 	/* pseudo mount for anon inodes */
 	if (sb->s_flags & SB_KERNMOUNT) {
-		kill_anon_super(sb);
+		generic_shutdown_super(sb);
 		return;
 	}
 
 	if (erofs_is_fscache_mode(sb))
-		kill_anon_super(sb);
+		generic_shutdown_super(sb);
 	else
 		kill_block_super(sb);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2e4eb7cf26fb33..42523edb32fd53 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1840,7 +1840,7 @@ EXPORT_SYMBOL(fuse_mount_destroy);
 static void fuse_kill_sb_anon(struct super_block *sb)
 {
 	fuse_sb_destroy(sb);
-	kill_anon_super(sb);
+	generic_shutdown_super(sb);
 	fuse_mount_destroy(get_fuse_mount_super(sb));
 }
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 5f1be1da92ce94..0a0d593e5a9c79 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1398,7 +1398,7 @@ static void virtio_kill_sb(struct super_block *sb)
 		if (last)
 			virtio_fs_conn_destroy(fm);
 	}
-	kill_anon_super(sb);
+	generic_shutdown_super(sb);
 	fuse_mount_destroy(fm);
 }
 
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index dc5a5cea5fae41..97f3c9709418c9 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -981,7 +981,7 @@ static struct dentry *hostfs_read_sb(struct file_system_type *type,
 
 static void hostfs_kill_sb(struct super_block *s)
 {
-	kill_anon_super(s);
+	generic_shutdown_super(s);
 	kfree(s->s_fs_info);
 }
 
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index c4bf26142eec9b..772d059d4054ec 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -399,7 +399,7 @@ void kernfs_kill_sb(struct super_block *sb)
 	 * Remove the superblock from fs_supers/s_instances
 	 * so we can't find it, before freeing kernfs_super_info.
 	 */
-	kill_anon_super(sb);
+	generic_shutdown_super(sb);
 	kfree(info);
 }
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 0d6473cb00cb3e..29d6a55b9d400d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1341,7 +1341,7 @@ void nfs_kill_super(struct super_block *s)
 	struct nfs_server *server = NFS_SB(s);
 
 	nfs_sysfs_move_sb_to_server(server);
-	kill_anon_super(s);
+	generic_shutdown_super(s);
 
 	nfs_fscache_release_super_cookie(s);
 
diff --git a/fs/nsfs.c b/fs/nsfs.c
index 647a22433bd8a9..d5fb7c00fe21f1 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -277,7 +277,6 @@ static int nsfs_init_fs_context(struct fs_context *fc)
 static struct file_system_type nsfs = {
 	.name = "nsfs",
 	.init_fs_context = nsfs_init_fs_context,
-	.kill_sb = kill_anon_super,
 };
 
 void __init nsfs_init(void)
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index b2457cb97fa008..3b51dd926d11c8 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -427,7 +427,6 @@ static struct file_system_type openprom_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "openpromfs",
 	.init_fs_context = openpromfs_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 MODULE_ALIAS_FS("openpromfs");
 
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 5254256a224d7a..42cb3e9b1effee 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -602,7 +602,7 @@ void orangefs_kill_sb(struct super_block *sb)
 	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_kill_sb: called\n");
 
 	/* provided sb cleanup */
-	kill_anon_super(sb);
+	generic_shutdown_super(sb);
 
 	if (!ORANGEFS_SB(sb)) {
 		mutex_lock(&orangefs_request_mutex);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index def266b5e2a33b..194cf18787496d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1507,7 +1507,6 @@ struct file_system_type ovl_fs_type = {
 	.init_fs_context	= ovl_init_fs_context,
 	.parameters		= ovl_parameter_spec,
 	.fs_flags		= FS_USERNS_MOUNT,
-	.kill_sb		= kill_anon_super,
 };
 MODULE_ALIAS_FS("overlay");
 
diff --git a/fs/pipe.c b/fs/pipe.c
index 6c1a9b1db9076c..858e8b19d78527 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1439,7 +1439,6 @@ static int pipefs_init_fs_context(struct fs_context *fc)
 static struct file_system_type pipe_fs_type = {
 	.name		= "pipefs",
 	.init_fs_context = pipefs_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 #ifdef CONFIG_SYSCTL
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 9191248f2dacb4..2282366449ac0b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -262,14 +262,14 @@ static void proc_kill_sb(struct super_block *sb)
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
 	if (!fs_info) {
-		kill_anon_super(sb);
+		generic_shutdown_super(sb);
 		return;
 	}
 
 	dput(fs_info->proc_self);
 	dput(fs_info->proc_thread_self);
 
-	kill_anon_super(sb);
+	generic_shutdown_super(sb);
 	put_pid_ns(fs_info->pid_ns);
 	kfree(fs_info);
 }
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 22869cda13565e..fb792acffeca37 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -302,7 +302,7 @@ static void cifs_kill_sb(struct super_block *sb)
 		cifs_sb->root = NULL;
 	}
 
-	kill_anon_super(sb);
+	generic_shutdown_super(sb);
 	cifs_umount(cifs_sb);
 }
 
diff --git a/fs/super.c b/fs/super.c
index ab234e6af48605..bbe55f0651cca4 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -438,10 +438,6 @@ static void kill_super_notify(struct super_block *sb)
 {
 	lockdep_assert_not_held(&sb->s_umount);
 
-	/* already notified earlier */
-	if (sb->s_flags & SB_DEAD)
-		return;
-
 	/*
 	 * Remove it from @fs_supers so it isn't found by new
 	 * sget{_fc}() walkers anymore. Any concurrent mounter still
@@ -491,6 +487,13 @@ void deactivate_locked_super(struct super_block *s)
 
 	kill_super_notify(s);
 
+	/*
+	 * If the super_block was using an anon dev_t, release it now that we've
+	 * notified everyone that the super_block is going away.
+	 */
+	if (s->s_dev && MAJOR(s->s_dev) == 0)
+		free_anon_bdev(s->s_dev);
+
 	/*
 	 * Since list_lru_destroy() may sleep, we cannot call it from
 	 * put_super(), where we hold the sb_lock. Therefore we destroy
@@ -1291,20 +1294,11 @@ int set_anon_super(struct super_block *s, void *data)
 }
 EXPORT_SYMBOL(set_anon_super);
 
-void kill_anon_super(struct super_block *sb)
-{
-	dev_t dev = sb->s_dev;
-	generic_shutdown_super(sb);
-	kill_super_notify(sb);
-	free_anon_bdev(dev);
-}
-EXPORT_SYMBOL(kill_anon_super);
-
 void kill_litter_super(struct super_block *sb)
 {
 	if (sb->s_root)
 		d_genocide(sb->s_root);
-	kill_anon_super(sb);
+	generic_shutdown_super(sb);
 }
 EXPORT_SYMBOL(kill_litter_super);
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b08fb28d16b55b..6527175591a729 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2350,7 +2350,8 @@ static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
 static void kill_ubifs_super(struct super_block *s)
 {
 	struct ubifs_info *c = s->s_fs_info;
-	kill_anon_super(s);
+
+	generic_shutdown_super(s);
 	kfree(c);
 }
 
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 1fb8f4df60cbb3..aa7e627bf9bd4b 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -450,7 +450,6 @@ static struct file_system_type vboxsf_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "vboxsf",
 	.init_fs_context	= vboxsf_init_fs_context,
-	.kill_sb		= kill_anon_super
 };
 
 /* Module initialization/finalization handlers */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4aeb3fa1192771..129b8c0c83960b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2382,7 +2382,6 @@ extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
 void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
-void kill_anon_super(struct super_block *sb);
 void kill_litter_super(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
 void deactivate_locked_super(struct super_block *sb);
diff --git a/kernel/resource.c b/kernel/resource.c
index b1763b2fd7ef3e..fde412517ef0cc 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1979,7 +1979,6 @@ static struct file_system_type iomem_fs_type = {
 	.name		= "iomem",
 	.owner		= THIS_MODULE,
 	.init_fs_context = iomem_fs_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 static int __init iomem_init_inode(void)
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 3afb5ad701e14a..74e1cdb1317cd7 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -275,7 +275,6 @@ static int secretmem_init_fs_context(struct fs_context *fc)
 static struct file_system_type secretmem_fs = {
 	.name		= "secretmem",
 	.init_fs_context = secretmem_init_fs_context,
-	.kill_sb	= kill_anon_super,
 };
 
 static int __init secretmem_init(void)
diff --git a/net/socket.c b/net/socket.c
index c8b08b32f097ec..a137b08a7d94d1 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -425,7 +425,6 @@ static struct vfsmount *sock_mnt __read_mostly;
 static struct file_system_type sock_fs_type = {
 	.name =		"sockfs",
 	.init_fs_context = sockfs_init_fs_context,
-	.kill_sb =	kill_anon_super,
 };
 
 /*
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index bd6a910f65282a..eceb5443842cdf 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -198,7 +198,6 @@ static struct file_system_type aafs_ops = {
 	.owner = THIS_MODULE,
 	.name = AAFS_NAME,
 	.init_fs_context = apparmorfs_init_fs_context,
-	.kill_sb = kill_anon_super,
 };
 
 /**
-- 
2.39.2

