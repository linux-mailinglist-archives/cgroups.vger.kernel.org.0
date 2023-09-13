Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB1479E623
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbjIMLMZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbjIMLMA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:12:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34582273F;
        Wed, 13 Sep 2023 04:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZBMAPhEvUXpzmXN5Loz0KdIG92o7mvxrs1RuIffe67w=; b=Y70fd1HOdQ7EfJgffXyvGfcZBB
        vh0XDUF2MTgu9a6JDrE53KlMRglIX6854lxOnXrjeU4u5ZinDDXWz9Z0GwFVZMzrETRB4io538jM2
        dyeEGPeCdplcm3P8clY+/qq6o3ZllAmUivx7Bc3eJ/bCplPU9dibW1VWusx5nWXpEDxxiHo9agBJp
        rqtRqtLODUy1lMZlOgP3LmkfsLMEfJipkRfy1tNo40bC0NcUGevBTyB1aNAyeNHtA3prozw4Nzpnt
        f1M+394jpgjGmNAeUESV0RDvV17gTB50edZCNnN5K4bK+qIxn0TnxMd2Gz8ZyDg6zPwemynrX5dzl
        esnQuGTw==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNmH-005iCM-23;
        Wed, 13 Sep 2023 11:11:26 +0000
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
Subject: [PATCH 18/19] fs: simple ->shutdown_sb and ->free_sb conversions
Date:   Wed, 13 Sep 2023 08:10:12 -0300
Message-Id: <20230913111013.77623-19-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert all file systems that just called generic_shutdown_super from
->kill_sb without any state kept from before the call to after it to
->shutdown_sb and ->free_sb as needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/9p/vfs_super.c             | 14 +++-----------
 fs/afs/super.c                | 15 +++++++++++----
 fs/autofs/autofs_i.h          |  3 ++-
 fs/autofs/init.c              |  3 ++-
 fs/autofs/inode.c             | 24 +++++++++++++-----------
 fs/btrfs/super.c              | 11 ++++-------
 fs/ceph/super.c               | 13 +++++++++----
 fs/cramfs/inode.c             |  6 ++----
 fs/ecryptfs/main.c            | 11 ++---------
 fs/fuse/inode.c               |  7 +++----
 fs/fuse/virtio_fs.c           | 19 +++++++++++--------
 fs/hostfs/hostfs_kern.c       |  5 ++---
 fs/nfs/fs_context.c           | 18 ++++++++++--------
 fs/orangefs/orangefs-kernel.h |  2 +-
 fs/orangefs/orangefs-mod.c    |  2 +-
 fs/orangefs/super.c           | 11 ++++-------
 fs/proc/root.c                | 16 +++++++++-------
 fs/romfs/super.c              |  6 ++----
 fs/smb/client/cifsfs.c        | 14 +++++++++-----
 fs/ubifs/super.c              |  9 +++------
 20 files changed, 103 insertions(+), 106 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index e8b3641c98f886..a238065dd8b361 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -205,25 +205,17 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	return ERR_PTR(retval);
 }
 
-/**
- * v9fs_kill_super - Kill Superblock
- * @s: superblock
- *
- */
-
-static void v9fs_kill_super(struct super_block *s)
+static void v9fs_free_sb(struct super_block *s)
 {
 	struct v9fs_session_info *v9ses = s->s_fs_info;
 
 	p9_debug(P9_DEBUG_VFS, " %p\n", s);
 
-	generic_shutdown_super(s);
-
 	v9fs_session_cancel(v9ses);
 	v9fs_session_close(v9ses);
 	kfree(v9ses);
 	s->s_fs_info = NULL;
-	p9_debug(P9_DEBUG_VFS, "exiting kill_super\n");
+	p9_debug(P9_DEBUG_VFS, "exiting free_sb\n");
 }
 
 static void
@@ -340,7 +332,7 @@ static const struct super_operations v9fs_super_ops_dotl = {
 struct file_system_type v9fs_fs_type = {
 	.name = "9p",
 	.mount = v9fs_mount,
-	.kill_sb = v9fs_kill_super,
+	.free_sb = v9fs_free_sb,
 	.owner = THIS_MODULE,
 	.fs_flags = FS_RENAME_DOES_D_MOVE,
 };
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 84b135ad3496b1..bd85554056415d 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -30,7 +30,8 @@
 #include "internal.h"
 
 static void afs_i_init_once(void *foo);
-static void afs_kill_super(struct super_block *sb);
+static void afs_shutdown_sb(struct super_block *sb);
+static void afs_free_sb(struct super_block *sb);
 static struct inode *afs_alloc_inode(struct super_block *sb);
 static void afs_destroy_inode(struct inode *inode);
 static void afs_free_inode(struct inode *inode);
@@ -45,7 +46,8 @@ struct file_system_type afs_fs_type = {
 	.name			= "afs",
 	.init_fs_context	= afs_init_fs_context,
 	.parameters		= afs_fs_parameters,
-	.kill_sb		= afs_kill_super,
+	.shutdown_sb		= afs_shutdown_sb,
+	.free_sb		= afs_free_sb,
 	.fs_flags		= FS_RENAME_DOES_D_MOVE,
 };
 MODULE_ALIAS_FS("afs");
@@ -527,7 +529,7 @@ static void afs_destroy_sbi(struct afs_super_info *as)
 	}
 }
 
-static void afs_kill_super(struct super_block *sb)
+static void afs_shutdown_sb(struct super_block *sb)
 {
 	struct afs_super_info *as = AFS_FS_S(sb);
 
@@ -539,7 +541,12 @@ static void afs_kill_super(struct super_block *sb)
 	 */
 	if (as->volume)
 		rcu_assign_pointer(as->volume->sb, NULL);
-	generic_shutdown_super(sb);
+}
+
+static void afs_free_sb(struct super_block *sb)
+{
+	struct afs_super_info *as = AFS_FS_S(sb);
+
 	if (as->volume)
 		afs_deactivate_volume(as->volume);
 	afs_destroy_sbi(as);
diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index d5a44fa88acf9a..f60f425c08b55c 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -276,4 +276,5 @@ static inline void autofs_del_expiring(struct dentry *dentry)
 	}
 }
 
-void autofs_kill_sb(struct super_block *);
+void autofs_shutdown_sb(struct super_block *sb);
+void autofs_free_sb(struct super_block *sb);
diff --git a/fs/autofs/init.c b/fs/autofs/init.c
index d3f55e87433890..1f7bed5391f822 100644
--- a/fs/autofs/init.c
+++ b/fs/autofs/init.c
@@ -17,7 +17,8 @@ struct file_system_type autofs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "autofs",
 	.mount		= autofs_mount,
-	.kill_sb	= autofs_kill_sb,
+	.shutdown_sb	= autofs_shutdown_sb,
+	.free_sb	= autofs_free_sb,
 };
 MODULE_ALIAS_FS("autofs");
 MODULE_ALIAS("autofs");
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index c3b64799155840..363c55f0ae6a6f 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -37,24 +37,26 @@ void autofs_free_ino(struct autofs_info *ino)
 	kfree_rcu(ino, rcu);
 }
 
-void autofs_kill_sb(struct super_block *sb)
+void autofs_shutdown_sb(struct super_block *sb)
 {
 	struct autofs_sb_info *sbi = autofs_sbi(sb);
 
 	/*
 	 * In the event of a failure in get_sb_nodev the superblock
-	 * info is not present so nothing else has been setup, so
-	 * just call generic_shutdown_super when we are called from
-	 * deactivate_super.
+	 * info is not present so nothing else has been setup.
 	 */
-	if (sbi) {
-		/* Free wait queues, close pipe */
-		autofs_catatonic_mode(sbi);
-		put_pid(sbi->oz_pgrp);
-	}
+	if (!sbi)
+		return;
+
+	/* Free wait queues, close pipe */
+	autofs_catatonic_mode(sbi);
+	put_pid(sbi->oz_pgrp);
+}
+
+void autofs_free_sb(struct super_block *sb)
+{
+	struct autofs_sb_info *sbi = autofs_sbi(sb);
 
-	pr_debug("shutting down\n");
-	generic_shutdown_super(sb);
 	if (sbi)
 		kfree_rcu(sbi, rcu);
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 063b9aa313c227..9205f8919faeeb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2136,19 +2136,16 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
-static void btrfs_kill_super(struct super_block *sb)
+static void btrfs_free_sb(struct super_block *sb)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
-
-	generic_shutdown_super(sb);
-	btrfs_free_fs_info(fs_info);
+	btrfs_free_fs_info(btrfs_sb(sb));
 }
 
 static struct file_system_type btrfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
-	.kill_sb	= btrfs_kill_super,
+	.free_sb	= btrfs_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_MGTIME,
 };
 
@@ -2156,7 +2153,7 @@ static struct file_system_type btrfs_root_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
-	.kill_sb	= btrfs_kill_super,
+	.free_sb	= btrfs_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
 			  FS_ALLOW_IDMAP | FS_MGTIME,
 };
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index cbeaab8c21d8e6..327180889bb6e3 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1509,13 +1509,13 @@ void ceph_dec_osd_stopping_blocker(struct ceph_mds_client *mdsc)
 	__dec_stopping_blocker(mdsc);
 }
 
-static void ceph_kill_sb(struct super_block *s)
+static void ceph_shutdown_sb(struct super_block *s)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	bool wait;
 
-	dout("kill_sb %p\n", s);
+	dout("shutdown_sb %p\n", s);
 
 	ceph_mdsc_pre_umount(mdsc);
 	flush_fs_workqueues(fsc);
@@ -1552,7 +1552,11 @@ static void ceph_kill_sb(struct super_block *s)
 	}
 
 	mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHED;
-	generic_shutdown_super(s);
+}
+
+static void ceph_free_sb(struct super_block *s)
+{
+	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
 
 	fsc->client->extra_mon_dispatch = NULL;
 	ceph_fs_debugfs_cleanup(fsc);
@@ -1566,7 +1570,8 @@ static struct file_system_type ceph_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ceph",
 	.init_fs_context = ceph_init_fs_context,
-	.kill_sb	= ceph_kill_sb,
+	.shutdown_sb	= ceph_shutdown_sb,
+	.free_sb	= ceph_free_sb,
 	.fs_flags	= FS_RENAME_DOES_D_MOVE,
 };
 MODULE_ALIAS_FS("ceph");
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 5ee7d7bbb361ce..afd05c3b1b5032 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -482,12 +482,10 @@ static const struct file_operations cramfs_physmem_fops = {
 #endif
 };
 
-static void cramfs_kill_sb(struct super_block *sb)
+static void cramfs_free_sb(struct super_block *sb)
 {
 	struct cramfs_sb_info *sbi = CRAMFS_SB(sb);
 
-	generic_shutdown_super(sb);
-
 	if (IS_ENABLED(CONFIG_CRAMFS_MTD) && sb->s_mtd) {
 		if (sbi && sbi->mtd_point_size)
 			mtd_unpoint(sb->s_mtd, 0, sbi->mtd_point_size);
@@ -977,7 +975,7 @@ static struct file_system_type cramfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "cramfs",
 	.init_fs_context = cramfs_init_fs_context,
-	.kill_sb	= cramfs_kill_sb,
+	.free_sb	= cramfs_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("cramfs");
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 3ed91537a3991a..cad39d6cc5d9d6 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -616,17 +616,10 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	return ERR_PTR(rc);
 }
 
-/**
- * ecryptfs_kill_block_super
- * @sb: The ecryptfs super block
- *
- * Used to bring the superblock down and free the private data.
- */
-static void ecryptfs_kill_block_super(struct super_block *sb)
+static void ecryptfs_free_sb(struct super_block *sb)
 {
 	struct ecryptfs_sb_info *sb_info = ecryptfs_superblock_to_private(sb);
 
-	generic_shutdown_super(sb);
 	if (!sb_info)
 		return;
 	ecryptfs_destroy_mount_crypt_stat(&sb_info->mount_crypt_stat);
@@ -637,7 +630,7 @@ static struct file_system_type ecryptfs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "ecryptfs",
 	.mount = ecryptfs_mount,
-	.kill_sb = ecryptfs_kill_block_super,
+	.free_sb = ecryptfs_free_sb,
 	.fs_flags = 0
 };
 MODULE_ALIAS_FS("ecryptfs");
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d9981532530702..08d543b88b840d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1837,10 +1837,8 @@ void fuse_mount_destroy(struct fuse_mount *fm)
 }
 EXPORT_SYMBOL(fuse_mount_destroy);
 
-static void fuse_kill_sb_anon(struct super_block *sb)
+static void fuse_free_sb_anon(struct super_block *sb)
 {
-	fuse_shutdown_sb(sb);
-	generic_shutdown_super(sb);
 	fuse_mount_destroy(get_fuse_mount_super(sb));
 }
 
@@ -1850,7 +1848,8 @@ static struct file_system_type fuse_fs_type = {
 	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
-	.kill_sb	= fuse_kill_sb_anon,
+	.shutdown_sb	= fuse_shutdown_sb,
+	.free_sb	= fuse_free_sb_anon,
 };
 MODULE_ALIAS_FS("fuse");
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index a52957df956394..8c2b0b226ddf63 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1387,19 +1387,21 @@ static void virtio_fs_conn_destroy(struct fuse_mount *fm)
 	virtio_fs_free_devs(vfs);
 }
 
-static void virtio_kill_sb(struct super_block *sb)
+static void virtio_shutdown_sb(struct super_block *sb)
 {
-	struct fuse_mount *fm = get_fuse_mount_super(sb);
-	bool last;
-
 	/* If mount failed, we can still be called without any fc */
 	if (sb->s_root) {
-		last = fuse_mount_remove(fm);
+		struct fuse_mount *fm = get_fuse_mount_super(sb);
+		bool last = fuse_mount_remove(fm);
+
 		if (last)
 			virtio_fs_conn_destroy(fm);
 	}
-	generic_shutdown_super(sb);
-	fuse_mount_destroy(fm);
+}
+
+static void virtio_free_sb(struct super_block *sb)
+{
+	fuse_mount_destroy(get_fuse_mount_super(sb));
 }
 
 static int virtio_fs_test_super(struct super_block *sb,
@@ -1507,7 +1509,8 @@ static struct file_system_type virtio_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "virtiofs",
 	.init_fs_context = virtio_fs_init_fs_context,
-	.kill_sb	= virtio_kill_sb,
+	.shutdown_sb	= virtio_shutdown_sb,
+	.free_sb	= virtio_free_sb,
 };
 
 static int __init virtio_fs_init(void)
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 97f3c9709418c9..21d57098413222 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -979,9 +979,8 @@ static struct dentry *hostfs_read_sb(struct file_system_type *type,
 	return mount_nodev(type, flags, data, hostfs_fill_sb_common);
 }
 
-static void hostfs_kill_sb(struct super_block *s)
+static void hostfs_free_sb(struct super_block *s)
 {
-	generic_shutdown_super(s);
 	kfree(s->s_fs_info);
 }
 
@@ -989,7 +988,7 @@ static struct file_system_type hostfs_type = {
 	.owner 		= THIS_MODULE,
 	.name 		= "hostfs",
 	.mount	 	= hostfs_read_sb,
-	.kill_sb	= hostfs_kill_sb,
+	.free_sb	= hostfs_free_sb,
 	.fs_flags 	= 0,
 };
 MODULE_ALIAS_FS("hostfs");
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index ee82e4cfb38bb5..4983931b5ad6e8 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1646,15 +1646,15 @@ static int nfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void nfs_kill_super(struct super_block *s)
+static void nfs_shutdown_sb(struct super_block *s)
 {
-	struct nfs_server *server = NFS_SB(s);
-
-	nfs_sysfs_move_sb_to_server(server);
-	generic_shutdown_super(s);
+	nfs_sysfs_move_sb_to_server(NFS_SB(s));
+}
 
+static void nfs_free_sb(struct super_block *s)
+{
 	nfs_fscache_release_super_cookie(s);
-	nfs_free_server(server);
+	nfs_free_server(NFS_SB(s));
 }
 
 struct file_system_type nfs_fs_type = {
@@ -1662,7 +1662,8 @@ struct file_system_type nfs_fs_type = {
 	.name			= "nfs",
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
-	.kill_sb		= nfs_kill_super,
+	.shutdown_sb		= nfs_shutdown_sb,
+	.free_sb		= nfs_free_sb,
 	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
 };
 MODULE_ALIAS_FS("nfs");
@@ -1674,7 +1675,8 @@ struct file_system_type nfs4_fs_type = {
 	.name			= "nfs4",
 	.init_fs_context	= nfs_init_fs_context,
 	.parameters		= nfs_fs_parameters,
-	.kill_sb		= nfs_kill_super,
+	.shutdown_sb		= nfs_shutdown_sb,
+	.free_sb		= nfs_free_sb,
 	.fs_flags		= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
 };
 MODULE_ALIAS_FS("nfs4");
diff --git a/fs/orangefs/orangefs-kernel.h b/fs/orangefs/orangefs-kernel.h
index b711654ca18a9c..73db7e6edb9966 100644
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -344,7 +344,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 			   const char *devname,
 			   void *data);
 
-void orangefs_kill_sb(struct super_block *sb);
+void orangefs_free_sb(struct super_block *sb);
 int orangefs_remount(struct orangefs_sb_info_s *);
 
 int fsid_key_table_initialize(void);
diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
index 5ab741c60b7e29..8b87eab0828126 100644
--- a/fs/orangefs/orangefs-mod.c
+++ b/fs/orangefs/orangefs-mod.c
@@ -47,7 +47,7 @@ MODULE_PARM_DESC(hash_table_size,
 static struct file_system_type orangefs_fs_type = {
 	.name = "pvfs2",
 	.mount = orangefs_mount,
-	.kill_sb = orangefs_kill_sb,
+	.free_sb = orangefs_free_sb,
 	.owner = THIS_MODULE,
 };
 
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index bf3a834ad15033..7c8d9a3fe34fca 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -580,9 +580,9 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	return dget(sb->s_root);
 
 free_sb_and_op:
-	/* Will call orangefs_kill_sb with sb not in list. */
+	/* Will call orangefs_free_sb with sb not in list. */
 	ORANGEFS_SB(sb)->no_list = 1;
-	/* ORANGEFS_VFS_OP_FS_UMOUNT is done by orangefs_kill_sb. */
+	/* ORANGEFS_VFS_OP_FS_UMOUNT is done by orangefs_free_sb. */
 	deactivate_locked_super(sb);
 free_op:
 	gossip_err("orangefs_mount: mount request failed with %d\n", ret);
@@ -596,13 +596,10 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	return d;
 }
 
-void orangefs_kill_sb(struct super_block *sb)
+void orangefs_free_sb(struct super_block *sb)
 {
 	int r;
-	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_kill_sb: called\n");
-
-	/* provided sb cleanup */
-	generic_shutdown_super(sb);
+	gossip_debug(GOSSIP_SUPER_DEBUG, "orangefs_free_sb: called\n");
 
 	if (!ORANGEFS_SB(sb)) {
 		mutex_lock(&orangefs_request_mutex);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 2282366449ac0b..81f6abedbd28b7 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -257,19 +257,20 @@ static int proc_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void proc_kill_sb(struct super_block *sb)
+static void proc_shutdown_sb(struct super_block *sb)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
-	if (!fs_info) {
-		generic_shutdown_super(sb);
+	if (!fs_info)
 		return;
-	}
-
 	dput(fs_info->proc_self);
 	dput(fs_info->proc_thread_self);
+}
+
+static void proc_free_sb(struct super_block *sb)
+{
+	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
-	generic_shutdown_super(sb);
 	put_pid_ns(fs_info->pid_ns);
 	kfree(fs_info);
 }
@@ -278,7 +279,8 @@ static struct file_system_type proc_fs_type = {
 	.name			= "proc",
 	.init_fs_context	= proc_init_fs_context,
 	.parameters		= proc_fs_parameters,
-	.kill_sb		= proc_kill_sb,
+	.shutdown_sb		= proc_shutdown_sb,
+	.free_sb		= proc_free_sb,
 	.fs_flags		= FS_USERNS_MOUNT | FS_DISALLOW_NOTIFY_PERM,
 };
 
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 5c35f6c760377e..d7c7e69db980e6 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -580,10 +580,8 @@ static int romfs_init_fs_context(struct fs_context *fc)
 /*
  * destroy a romfs superblock in the appropriate manner
  */
-static void romfs_kill_sb(struct super_block *sb)
+static void romfs_free_sb(struct super_block *sb)
 {
-	generic_shutdown_super(sb);
-
 #ifdef CONFIG_ROMFS_ON_MTD
 	if (sb->s_mtd) {
 		put_mtd_device(sb->s_mtd);
@@ -602,7 +600,7 @@ static struct file_system_type romfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "romfs",
 	.init_fs_context = romfs_init_fs_context,
-	.kill_sb	= romfs_kill_sb,
+	.free_sb	= romfs_free_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 MODULE_ALIAS_FS("romfs");
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 5700f1065af756..34141c80a0bbd3 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -286,7 +286,7 @@ cifs_read_super(struct super_block *sb)
 	return rc;
 }
 
-static void cifs_kill_sb(struct super_block *sb)
+static void cifs_shutdown_sb(struct super_block *sb)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 
@@ -301,9 +301,11 @@ static void cifs_kill_sb(struct super_block *sb)
 		dput(cifs_sb->root);
 		cifs_sb->root = NULL;
 	}
+}
 
-	generic_shutdown_super(sb);
-	cifs_umount(cifs_sb);
+static void cifs_free_sb(struct super_block *sb)
+{
+	cifs_umount(CIFS_SB(sb));
 }
 
 static int
@@ -1121,7 +1123,8 @@ struct file_system_type cifs_fs_type = {
 	.name = "cifs",
 	.init_fs_context = smb3_init_fs_context,
 	.parameters = smb3_fs_parameters,
-	.kill_sb = cifs_kill_sb,
+	.shutdown_sb = cifs_shutdown_sb,
+	.free_sb = cifs_free_sb,
 	.fs_flags = FS_RENAME_DOES_D_MOVE,
 };
 MODULE_ALIAS_FS("cifs");
@@ -1131,7 +1134,8 @@ struct file_system_type smb3_fs_type = {
 	.name = "smb3",
 	.init_fs_context = smb3_init_fs_context,
 	.parameters = smb3_fs_parameters,
-	.kill_sb = cifs_kill_sb,
+	.shutdown_sb = cifs_shutdown_sb,
+	.free_sb = cifs_free_sb,
 	.fs_flags = FS_RENAME_DOES_D_MOVE,
 };
 MODULE_ALIAS_FS("smb3");
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index b9d1ab63e3c87e..0bce555fd14d44 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2347,19 +2347,16 @@ static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
 	return ERR_PTR(err);
 }
 
-static void kill_ubifs_super(struct super_block *s)
+static void ubifs_free_sb(struct super_block *s)
 {
-	struct ubifs_info *c = s->s_fs_info;
-
-	generic_shutdown_super(s);
-	kfree(c);
+	kfree(s->s_fs_info);
 }
 
 static struct file_system_type ubifs_fs_type = {
 	.name    = "ubifs",
 	.owner   = THIS_MODULE,
 	.mount   = ubifs_mount,
-	.kill_sb = kill_ubifs_super,
+	.free_sb = ubifs_free_sb,
 };
 MODULE_ALIAS_FS("ubifs");
 
-- 
2.39.2

