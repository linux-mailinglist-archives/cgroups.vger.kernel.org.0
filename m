Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7679E5DD
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbjIMLKz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbjIMLKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:10:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FD1726;
        Wed, 13 Sep 2023 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lFN9YgcL4jF9M8y38RT8vgKJ5Uff5/jFhXEUgu10px4=; b=afZ4SOl3iLBIdn7xexEr8bO6HE
        EzSc4FAIcIGS+0rGFQe/IOIMts7MfkoT2sX+bb6edTrlGUz9JqzD1/bvhKBCYXjEsx6hAhXmc2ubw
        wVBNxffbYUJh6RmTU6c2jWW4C2he4lGGStqYa/H1h+woVStgY0giJlVcbWx20pS+usQJFV07p4940
        YDriSSSF63rxg8uvYoepp/TnQvZJ2lFcjeqxBOm+wEJRXaYAA4tDoRCTmyDZPv69DOFTkbF4d0CX0
        YPlg6Ez4Oas4wWm5inDdI4iyQSF79HWCj01ed1ego43n2UZ1tRYmFxJDvLA5hY+5W0Wzf2hvSho9f
        VSJpn71Q==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlY-005hxI-0t;
        Wed, 13 Sep 2023 11:10:40 +0000
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
Subject: [PATCH 05/19] fs: assign an anon dev_t in common code
Date:   Wed, 13 Sep 2023 08:09:59 -0300
Message-Id: <20230913111013.77623-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

All super_blocks need to have a valid dev_t, and except for block
based file systems that tends to be an anonymouns dev_t.  Instead of
leaving that work to the file systems, assign the anonymous dev_t in
the core sget_fc and sget routines unless the file systems already
assigned on in the set callback.  Note that this now makes the
set callback optional as a lot of file systems don't need it any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/9p/vfs_super.c      |  2 +-
 fs/afs/super.c         | 12 +++-----
 fs/btrfs/super.c       |  6 ++--
 fs/ceph/super.c        |  7 +----
 fs/ecryptfs/main.c     |  2 +-
 fs/fuse/inode.c        |  2 +-
 fs/fuse/virtio_fs.c    |  2 +-
 fs/kernfs/mount.c      |  2 +-
 fs/nfs/super.c         |  2 +-
 fs/orangefs/super.c    |  2 +-
 fs/smb/client/cifsfs.c |  3 +-
 fs/super.c             | 68 +++++++++++++++++++++++++-----------------
 fs/ubifs/super.c       |  2 +-
 include/linux/fs.h     |  2 --
 14 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 9e60eddf5179ed..e8b3641c98f886 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -40,7 +40,7 @@ static const struct super_operations v9fs_super_ops, v9fs_super_ops_dotl;
 static int v9fs_set_super(struct super_block *s, void *data)
 {
 	s->s_fs_info = data;
-	return set_anon_super(s, data);
+	return 0;
 }
 
 /**
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 754b9828233497..84b135ad3496b1 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -435,11 +435,6 @@ static int afs_dynroot_test_super(struct super_block *sb, struct fs_context *fc)
 		as->dyn_root);
 }
 
-static int afs_set_super(struct super_block *sb, struct fs_context *fc)
-{
-	return set_anon_super(sb, NULL);
-}
-
 /*
  * fill in the superblock
  */
@@ -574,9 +569,10 @@ static int afs_get_tree(struct fs_context *fc)
 	fc->s_fs_info = as;
 
 	/* allocate a deviceless superblock */
-	sb = sget_fc(fc,
-		     as->dyn_root ? afs_dynroot_test_super : afs_test_super,
-		     afs_set_super);
+	if (as->dyn_root)
+		sb = sget_fc(fc, afs_dynroot_test_super, NULL);
+	else
+		sb = sget_fc(fc, afs_test_super, NULL);
 	if (IS_ERR(sb)) {
 		ret = PTR_ERR(sb);
 		goto error;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 01b86bd4eae8dc..063b9aa313c227 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1350,10 +1350,8 @@ static int btrfs_test_super(struct super_block *s, void *data)
 
 static int btrfs_set_super(struct super_block *s, void *data)
 {
-	int err = set_anon_super(s, data);
-	if (!err)
-		s->s_fs_info = data;
-	return err;
+	s->s_fs_info = data;
+	return 0;
 }
 
 /*
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 7feef0b35b97b5..cbeaab8c21d8e6 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1191,7 +1191,6 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc,
 static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 {
 	struct ceph_fs_client *fsc = s->s_fs_info;
-	int ret;
 
 	dout("set_super %p\n", s);
 
@@ -1211,11 +1210,7 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_flags |= SB_NODIRATIME | SB_NOATIME;
 
 	ceph_fscrypt_set_ops(s);
-
-	ret = set_anon_super_fc(s, fc);
-	if (ret != 0)
-		fsc->sb = NULL;
-	return ret;
+	return 0;
 }
 
 /*
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index d99b2311759166..3ed91537a3991a 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -505,7 +505,7 @@ static struct dentry *ecryptfs_mount(struct file_system_type *fs_type, int flags
 	}
 	mount_crypt_stat = &sbi->mount_crypt_stat;
 
-	s = sget(fs_type, NULL, set_anon_super, flags, NULL);
+	s = sget(fs_type, NULL, NULL, flags, NULL);
 	if (IS_ERR(s)) {
 		rc = PTR_ERR(s);
 		goto out;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 42523edb32fd53..5731003b56a9c9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1511,7 +1511,7 @@ static int fuse_get_tree_submount(struct fs_context *fsc)
 
 	fm->fc = fuse_conn_get(fc);
 	fsc->s_fs_info = fm;
-	sb = sget_fc(fsc, NULL, set_anon_super_fc);
+	sb = sget_fc(fsc, NULL, NULL);
 	if (fsc->s_fs_info)
 		fuse_mount_destroy(fm);
 	if (IS_ERR(sb))
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 0a0d593e5a9c79..a52957df956394 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1454,7 +1454,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 				    virtqueue_size - FUSE_HEADER_OVERHEAD);
 
 	fsc->s_fs_info = fm;
-	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
+	sb = sget_fc(fsc, virtio_fs_test_super, NULL);
 	if (fsc->s_fs_info)
 		fuse_mount_destroy(fm);
 	if (IS_ERR(sb))
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 772d059d4054ec..d6d3cba669dbdd 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -300,7 +300,7 @@ static int kernfs_set_super(struct super_block *sb, struct fs_context *fc)
 	struct kernfs_fs_context *kfc = fc->fs_private;
 
 	kfc->ns_tag = NULL;
-	return set_anon_super_fc(sb, fc);
+	return 0;
 }
 
 /**
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 561221a87b02a6..89131e855e1393 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1132,7 +1132,7 @@ static int nfs_set_super(struct super_block *s, struct fs_context *fc)
 	struct nfs_server *server = fc->s_fs_info;
 
 	s->s_d_op = server->nfs_client->rpc_ops->dentry_ops;
-	return set_anon_super(s, server);
+	return 0;
 }
 
 static int nfs_compare_super_address(struct nfs_server *server1,
diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 42cb3e9b1effee..bf3a834ad15033 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -514,7 +514,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 		goto free_op;
 	}
 
-	sb = sget(fst, NULL, set_anon_super, flags, NULL);
+	sb = sget(fst, NULL, NULL, flags, NULL);
 
 	if (IS_ERR(sb)) {
 		d = ERR_CAST(sb);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index fb792acffeca37..5700f1065af756 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -884,8 +884,9 @@ cifs_get_root(struct smb3_fs_context *ctx, struct super_block *sb)
 static int cifs_set_super(struct super_block *sb, void *data)
 {
 	struct cifs_mnt_data *mnt_data = data;
+
 	sb->s_fs_info = mnt_data->cifs_sb;
-	return set_anon_super(sb, NULL);
+	return 0;
 }
 
 struct dentry *
diff --git a/fs/super.c b/fs/super.c
index bbe55f0651cca4..5c685b4944c2d6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -787,7 +787,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	struct super_block *s = NULL;
 	struct super_block *old;
 	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
-	int err;
+	int err = 0;
 
 retry:
 	spin_lock(&sb_lock);
@@ -806,14 +806,26 @@ struct super_block *sget_fc(struct fs_context *fc,
 	}
 
 	s->s_fs_info = fc->s_fs_info;
-	err = set(s, fc);
-	if (err) {
-		s->s_fs_info = NULL;
-		spin_unlock(&sb_lock);
-		destroy_unused_super(s);
-		return ERR_PTR(err);
+	if (set) {
+		err = set(s, fc);
+		if (err) {
+			s->s_fs_info = NULL;
+			goto unlock_and_destroy;
+		}
 	}
 	fc->s_fs_info = NULL;
+
+	if (!s->s_dev) {
+		/*
+		 * If the file system didn't set a s_dev (which is usually only
+		 * done for block based file systems), set an anonymous dev_t
+		 * here now so that we always have a valid ->s_dev.
+		 */
+		err = get_anon_bdev(&s->s_dev);
+		if (err)
+			goto unlock_and_destroy;
+	}
+
 	s->s_type = fc->fs_type;
 	s->s_iflags |= fc->s_iflags;
 	strscpy(s->s_id, s->s_type->name, sizeof(s->s_id));
@@ -843,6 +855,10 @@ struct super_block *sget_fc(struct fs_context *fc,
 		goto retry;
 	destroy_unused_super(s);
 	return old;
+unlock_and_destroy:
+	spin_unlock(&sb_lock);
+	destroy_unused_super(s);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(sget_fc);
 
@@ -897,12 +913,18 @@ struct super_block *sget(struct file_system_type *type,
 		goto retry;
 	}
 
-	err = set(s, data);
-	if (err) {
-		spin_unlock(&sb_lock);
-		destroy_unused_super(s);
-		return ERR_PTR(err);
+	if (set) {
+		err = set(s, data);
+		if (err)
+			goto unlock_and_destroy;
 	}
+
+	if (!s->s_dev) {
+		err = get_anon_bdev(&s->s_dev);
+		if (err)
+			goto unlock_and_destroy;
+	}
+
 	s->s_type = type;
 	strscpy(s->s_id, type->name, sizeof(s->s_id));
 	list_add_tail(&s->s_list, &super_blocks);
@@ -911,6 +933,10 @@ struct super_block *sget(struct file_system_type *type,
 	get_filesystem(type);
 	register_shrinker_prepared(&s->s_shrink);
 	return s;
+unlock_and_destroy:
+	spin_unlock(&sb_lock);
+	destroy_unused_super(s);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL(sget);
 
@@ -1288,12 +1314,6 @@ void free_anon_bdev(dev_t dev)
 }
 EXPORT_SYMBOL(free_anon_bdev);
 
-int set_anon_super(struct super_block *s, void *data)
-{
-	return get_anon_bdev(&s->s_dev);
-}
-EXPORT_SYMBOL(set_anon_super);
-
 void kill_litter_super(struct super_block *sb)
 {
 	if (sb->s_root)
@@ -1302,12 +1322,6 @@ void kill_litter_super(struct super_block *sb)
 }
 EXPORT_SYMBOL(kill_litter_super);
 
-int set_anon_super_fc(struct super_block *sb, struct fs_context *fc)
-{
-	return set_anon_super(sb, NULL);
-}
-EXPORT_SYMBOL(set_anon_super_fc);
-
 static int test_keyed_super(struct super_block *sb, struct fs_context *fc)
 {
 	return sb->s_fs_info == fc->s_fs_info;
@@ -1326,7 +1340,7 @@ static int vfs_get_super(struct fs_context *fc,
 	struct super_block *sb;
 	int err;
 
-	sb = sget_fc(fc, test, set_anon_super_fc);
+	sb = sget_fc(fc, test, NULL);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
@@ -1657,7 +1671,7 @@ struct dentry *mount_nodev(struct file_system_type *fs_type,
 	int (*fill_super)(struct super_block *, void *, int))
 {
 	int error;
-	struct super_block *s = sget(fs_type, NULL, set_anon_super, flags, NULL);
+	struct super_block *s = sget(fs_type, NULL, NULL, flags, NULL);
 
 	if (IS_ERR(s))
 		return ERR_CAST(s);
@@ -1709,7 +1723,7 @@ struct dentry *mount_single(struct file_system_type *fs_type,
 	struct super_block *s;
 	int error;
 
-	s = sget(fs_type, compare_single, set_anon_super, flags, NULL);
+	s = sget(fs_type, compare_single, NULL, flags, NULL);
 	if (IS_ERR(s))
 		return ERR_CAST(s);
 	if (!s->s_root) {
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 6527175591a729..b9d1ab63e3c87e 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2273,7 +2273,7 @@ static int sb_test(struct super_block *sb, void *data)
 static int sb_set(struct super_block *sb, void *data)
 {
 	sb->s_fs_info = data;
-	return set_anon_super(sb, NULL);
+	return 0;
 }
 
 static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 129b8c0c83960b..31b6b235b36efa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2385,8 +2385,6 @@ void kill_block_super(struct super_block *sb);
 void kill_litter_super(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
 void deactivate_locked_super(struct super_block *sb);
-int set_anon_super(struct super_block *s, void *data);
-int set_anon_super_fc(struct super_block *s, struct fs_context *fc);
 int get_anon_bdev(dev_t *);
 void free_anon_bdev(dev_t);
 struct super_block *sget_fc(struct fs_context *fc,
-- 
2.39.2

