Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87D979E64F
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbjIMLLm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240082AbjIMLLa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50671BE4;
        Wed, 13 Sep 2023 04:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=27oL7B8ANe/CTe/K/ONpsBSIxLWeYprJgAaIONOuIao=; b=aAKCj/v6UNy7IIZmgIaz9Eh20z
        K6Hxw0VB8ZdHs/OFD+5mIbnLGV6LRzviSNfzWfaeVEyYFeHcnx055v16NJToO8+eXCPcbyMijgadU
        IzXhiWftCjUzEm/UfGBb94Ob8tHYeQoR3cSaQ4cye/raOMJrGhTkWAXZw6+b2qKafHUAQakJham8l
        6jtw4ujuvBjX5jMeSORdAaeJo0mVTUmrctu8fGTXR/Ug/vMoriZ/14V+dYGa+RDVfSFXI38ASQy2i
        p/FXRzTyRpF6Ul50ZwSwHcDKoY33qjKybgkxuLCRbfOY3eWucNjSJWj8KShRf7uxPf/K7B7LTnkPU
        PEFRhcZg==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlv-005i5m-2f;
        Wed, 13 Sep 2023 11:11:04 +0000
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
Subject: [PATCH 12/19] fs: convert kill_litter_super to litter_shutdown_sb
Date:   Wed, 13 Sep 2023 08:10:06 -0300
Message-Id: <20230913111013.77623-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Replace kill_litter_super with litter_shutdown_sb, which is wired up to
the ->shutdown_sb method.  For file systems that wrapped
kill_litter_super, ->kill_sb is replaced with ->shutdown and ->free_sb
methods as needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 10 +++++-----
 arch/s390/hypfs/inode.c                   |  6 +++---
 drivers/android/binderfs.c                | 12 +++---------
 drivers/base/devtmpfs.c                   |  8 ++++----
 drivers/infiniband/hw/qib/qib_fs.c        |  2 +-
 drivers/misc/ibmasm/ibmasmfs.c            |  8 ++++----
 drivers/usb/gadget/function/f_fs.c        |  6 +++---
 drivers/usb/gadget/legacy/inode.c         | 12 ++++++------
 drivers/xen/xenfs/super.c                 |  8 ++++----
 fs/binfmt_misc.c                          |  8 ++++----
 fs/configfs/mount.c                       |  8 ++++----
 fs/debugfs/inode.c                        |  8 ++++----
 fs/devpts/inode.c                         |  6 +++---
 fs/efivarfs/super.c                       | 13 ++++++-------
 fs/fuse/control.c                         | 12 ++++++------
 fs/hugetlbfs/inode.c                      |  2 +-
 fs/nfsd/nfsctl.c                          | 22 ++++++++++++----------
 fs/ocfs2/dlmfs/dlmfs.c                    |  2 +-
 fs/pstore/inode.c                         |  7 +++----
 fs/ramfs/inode.c                          |  6 +++---
 fs/super.c                                | 14 +++++++++++---
 fs/tracefs/inode.c                        |  2 +-
 include/linux/fs.h                        |  2 +-
 include/linux/ramfs.h                     |  2 +-
 init/do_mounts.c                          |  6 +++---
 ipc/mqueue.c                              |  2 +-
 kernel/bpf/inode.c                        |  2 +-
 mm/shmem.c                                |  5 +++--
 net/sunrpc/rpc_pipe.c                     | 19 ++++++++++++-------
 security/inode.c                          |  8 ++++----
 security/selinux/selinuxfs.c              | 15 +++++----------
 security/smack/smackfs.c                  |  6 +++---
 32 files changed, 126 insertions(+), 123 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 38c5be34c8951f..2610a0731ea242 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -763,11 +763,11 @@ static int spufs_init_fs_context(struct fs_context *fc)
 }
 
 static struct file_system_type spufs_type = {
-	.owner = THIS_MODULE,
-	.name = "spufs",
-	.init_fs_context = spufs_init_fs_context,
-	.parameters	= spufs_fs_parameters,
-	.kill_sb = kill_litter_super,
+	.owner			= THIS_MODULE,
+	.name			= "spufs",
+	.init_fs_context	= spufs_init_fs_context,
+	.parameters		= spufs_fs_parameters,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("spufs");
 
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 3261fb9cade648..f18e3b844c5d9b 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -294,9 +294,8 @@ static int hypfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void hypfs_kill_super(struct super_block *sb)
+static void hypfs_free_sb(struct super_block *sb)
 {
-	kill_litter_super(sb);
 	kfree(sb->s_fs_info);
 }
 
@@ -417,7 +416,8 @@ static struct file_system_type hypfs_type = {
 	.name		= "s390_hypfs",
 	.init_fs_context = hypfs_init_fs_context,
 	.parameters	= hypfs_fs_parameters,
-	.kill_sb	= hypfs_kill_super
+	.shutdown_sb	= litter_shutdown_sb,
+	.free_sb	= hypfs_free_sb,
 };
 
 static const struct super_operations hypfs_s_ops = {
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 81effec17b3d63..f48196391239c0 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -771,19 +771,12 @@ static int binderfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void binderfs_kill_super(struct super_block *sb)
+static void binderfs_free_sb(struct super_block *sb)
 {
 	struct binderfs_info *info = sb->s_fs_info;
 
-	/*
-	 * During inode eviction struct binderfs_info is needed.
-	 * So first wipe the super_block then free struct binderfs_info.
-	 */
-	kill_litter_super(sb);
-
 	if (info && info->ipc_ns)
 		put_ipc_ns(info->ipc_ns);
-
 	kfree(info);
 }
 
@@ -791,7 +784,8 @@ static struct file_system_type binder_fs_type = {
 	.name			= "binder",
 	.init_fs_context	= binderfs_init_fs_context,
 	.parameters		= binderfs_fs_parameters,
-	.kill_sb		= binderfs_kill_super,
+	.shutdown_sb		= litter_shutdown_sb,
+	.free_sb		= binderfs_free_sb,
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 
diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b848764ef0187f..f5b43c7877815b 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -80,13 +80,13 @@ static struct dentry *public_dev_mount(struct file_system_type *fs_type, int fla
 }
 
 static struct file_system_type internal_fs_type = {
-	.name = "devtmpfs",
+	.name			= "devtmpfs",
 #ifdef CONFIG_TMPFS
-	.init_fs_context = shmem_init_fs_context,
+	.init_fs_context	= shmem_init_fs_context,
 #else
-	.init_fs_context = ramfs_init_fs_context,
+	.init_fs_context	= ramfs_init_fs_context,
 #endif
-	.kill_sb = kill_litter_super,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 
 static struct file_system_type dev_fs_type = {
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index c52ca34b32e67d..ea0aeade92bbd0 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -473,7 +473,7 @@ static struct file_system_type qibfs_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "ipathfs",
 	.init_fs_context	= qibfs_init_fs_context,
-	.kill_sb		= kill_litter_super,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("ipathfs");
 
diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index 5867af9f592cdb..05d03f9b600366 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -100,10 +100,10 @@ static const struct super_operations ibmasmfs_s_ops = {
 static const struct file_operations *ibmasmfs_dir_ops = &simple_dir_operations;
 
 static struct file_system_type ibmasmfs_type = {
-	.owner          = THIS_MODULE,
-	.name           = "ibmasmfs",
-	.init_fs_context = ibmasmfs_init_fs_context,
-	.kill_sb        = kill_litter_super,
+	.owner          	= THIS_MODULE,
+	.name           	= "ibmasmfs",
+	.init_fs_context	= ibmasmfs_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("ibmasmfs");
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6e9ef35a43a7ba..83eaed3f1a8e0b 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1602,9 +1602,8 @@ static int ffs_fs_init_fs_context(struct fs_context *fc)
 }
 
 static void
-ffs_fs_kill_sb(struct super_block *sb)
+ffs_fs_free_sb(struct super_block *sb)
 {
-	kill_litter_super(sb);
 	if (sb->s_fs_info)
 		ffs_data_closed(sb->s_fs_info);
 }
@@ -1614,7 +1613,8 @@ static struct file_system_type ffs_fs_type = {
 	.name		= "functionfs",
 	.init_fs_context = ffs_fs_init_fs_context,
 	.parameters	= ffs_fs_fs_parameters,
-	.kill_sb	= ffs_fs_kill_sb,
+	.shutdown_sb	= litter_shutdown_sb,
+	.free_sb	= ffs_fs_free_sb,
 };
 MODULE_ALIAS_FS("functionfs");
 
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index a203266bc0dc82..e79e907b0a065e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -2086,9 +2086,8 @@ static int gadgetfs_init_fs_context(struct fs_context *fc)
 }
 
 static void
-gadgetfs_kill_sb (struct super_block *sb)
+gadgetfs_free_sb(struct super_block *sb)
 {
-	kill_litter_super (sb);
 	if (the_device) {
 		put_dev (the_device);
 		the_device = NULL;
@@ -2100,10 +2099,11 @@ gadgetfs_kill_sb (struct super_block *sb)
 /*----------------------------------------------------------------------*/
 
 static struct file_system_type gadgetfs_type = {
-	.owner		= THIS_MODULE,
-	.name		= shortname,
-	.init_fs_context = gadgetfs_init_fs_context,
-	.kill_sb	= gadgetfs_kill_sb,
+	.owner			= THIS_MODULE,
+	.name			= shortname,
+	.init_fs_context	= gadgetfs_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
+	.free_sb		= gadgetfs_free_sb,
 };
 MODULE_ALIAS_FS("gadgetfs");
 
diff --git a/drivers/xen/xenfs/super.c b/drivers/xen/xenfs/super.c
index d7d64235010d41..ab2e3d3d05bb2e 100644
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -85,10 +85,10 @@ static int xenfs_init_fs_context(struct fs_context *fc)
 }
 
 static struct file_system_type xenfs_type = {
-	.owner =	THIS_MODULE,
-	.name =		"xenfs",
-	.init_fs_context = xenfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.owner			= THIS_MODULE,
+	.name			= "xenfs",
+	.init_fs_context	= xenfs_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("xenfs");
 
diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index e0108d17b085cf..0eb5bd91cfeafb 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -809,10 +809,10 @@ static struct linux_binfmt misc_format = {
 };
 
 static struct file_system_type bm_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "binfmt_misc",
-	.init_fs_context = bm_init_fs_context,
-	.kill_sb	= kill_litter_super,
+	.owner			= THIS_MODULE,
+	.name			= "binfmt_misc",
+	.init_fs_context	= bm_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("binfmt_misc");
 
diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
index c2d820063ec49a..87043caf048a2c 100644
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -112,10 +112,10 @@ static int configfs_init_fs_context(struct fs_context *fc)
 }
 
 static struct file_system_type configfs_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "configfs",
-	.init_fs_context = configfs_init_fs_context,
-	.kill_sb	= kill_litter_super,
+	.owner			= THIS_MODULE,
+	.name			= "configfs",
+	.init_fs_context	= configfs_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("configfs");
 
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 83e57e9f9fa037..a4955c8f6638ae 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -300,10 +300,10 @@ static struct dentry *debug_mount(struct file_system_type *fs_type,
 }
 
 static struct file_system_type debug_fs_type = {
-	.owner =	THIS_MODULE,
-	.name =		"debugfs",
-	.mount =	debug_mount,
-	.kill_sb =	kill_litter_super,
+	.owner			= THIS_MODULE,
+	.name			= "debugfs",
+	.mount			= debug_mount,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("debugfs");
 
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index d46cea36c026ad..bc7ff574dbbf90 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -487,11 +487,10 @@ static struct dentry *devpts_mount(struct file_system_type *fs_type,
 	return mount_nodev(fs_type, flags, data, devpts_fill_super);
 }
 
-static void devpts_kill_sb(struct super_block *sb)
+static void devpts_free_sb(struct super_block *sb)
 {
 	struct pts_fs_info *fsi = DEVPTS_SB(sb);
 
-	kill_litter_super(sb);
 	if (fsi)
 		ida_destroy(&fsi->allocated_ptys);
 	kfree(fsi);
@@ -500,7 +499,8 @@ static void devpts_kill_sb(struct super_block *sb)
 static struct file_system_type devpts_fs_type = {
 	.name		= "devpts",
 	.mount		= devpts_mount,
-	.kill_sb	= devpts_kill_sb,
+	.shutdown_sb	= litter_shutdown_sb,
+	.free_sb	= devpts_free_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f38c..f9e8df15c35067 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -279,10 +279,8 @@ static int efivarfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void efivarfs_kill_sb(struct super_block *sb)
+static void efivarfs_free_sb(struct super_block *sb)
 {
-	kill_litter_super(sb);
-
 	if (!efivar_is_available())
 		return;
 
@@ -291,10 +289,11 @@ static void efivarfs_kill_sb(struct super_block *sb)
 }
 
 static struct file_system_type efivarfs_type = {
-	.owner   = THIS_MODULE,
-	.name    = "efivarfs",
-	.init_fs_context = efivarfs_init_fs_context,
-	.kill_sb = efivarfs_kill_sb,
+	.owner   		= THIS_MODULE,
+	.name    		= "efivarfs",
+	.init_fs_context	= efivarfs_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
+	.free_sb		= efivarfs_free_sb,
 };
 
 static __init int efivarfs_init(void)
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index ab62e46242568a..3a24d00a165971 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -352,7 +352,7 @@ static int fuse_ctl_init_fs_context(struct fs_context *fsc)
 	return 0;
 }
 
-static void fuse_ctl_kill_sb(struct super_block *sb)
+static void fuse_ctl_shutdown_sb(struct super_block *sb)
 {
 	struct fuse_conn *fc;
 
@@ -362,14 +362,14 @@ static void fuse_ctl_kill_sb(struct super_block *sb)
 		fc->ctl_ndents = 0;
 	mutex_unlock(&fuse_mutex);
 
-	kill_litter_super(sb);
+	litter_shutdown_sb(sb);
 }
 
 static struct file_system_type fuse_ctl_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "fusectl",
-	.init_fs_context = fuse_ctl_init_fs_context,
-	.kill_sb	= fuse_ctl_kill_sb,
+	.owner			= THIS_MODULE,
+	.name			= "fusectl",
+	.init_fs_context	= fuse_ctl_init_fs_context,
+	.shutdown_sb		= fuse_ctl_shutdown_sb,
 };
 MODULE_ALIAS_FS("fusectl");
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3de..1a722aba8c6645 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1588,7 +1588,7 @@ static struct file_system_type hugetlbfs_fs_type = {
 	.name			= "hugetlbfs",
 	.init_fs_context	= hugetlbfs_init_fs_context,
 	.parameters		= hugetlb_fs_parameters,
-	.kill_sb		= kill_litter_super,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 
 static struct vfsmount *hugetlbfs_vfsmount[HUGE_MAX_HSTATE];
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7ed02fb88a362c..a2be86da4efa15 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1440,21 +1440,23 @@ static int nfsd_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void nfsd_umount(struct super_block *sb)
+static void nfsd_shutdown_sb(struct super_block *sb)
 {
-	struct net *net = sb->s_fs_info;
-
-	nfsd_shutdown_threads(net);
+	nfsd_shutdown_threads(sb->s_fs_info);
+	litter_shutdown_sb(sb);
+}
 
-	kill_litter_super(sb);
-	put_net(net);
+static void nfsd_free_sb(struct super_block *sb)
+{
+	put_net(sb->s_fs_info);
 }
 
 static struct file_system_type nfsd_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfsd",
-	.init_fs_context = nfsd_init_fs_context,
-	.kill_sb	= nfsd_umount,
+	.owner			= THIS_MODULE,
+	.name			= "nfsd",
+	.init_fs_context	= nfsd_init_fs_context,
+	.shutdown_sb		= nfsd_shutdown_sb,
+	.free_sb		= nfsd_free_sb,
 };
 MODULE_ALIAS_FS("nfsd");
 
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 81265123ce6ce5..b987653f6ec070 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -567,7 +567,7 @@ static struct file_system_type dlmfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ocfs2_dlmfs",
 	.mount		= dlmfs_mount,
-	.kill_sb	= kill_litter_super,
+	.shutdown_sb	= litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("ocfs2_dlmfs");
 
diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index fd1d24b47160d0..36635ed77b6873 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -465,10 +465,8 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
 	return mount_single(fs_type, flags, data, pstore_fill_super);
 }
 
-static void pstore_kill_sb(struct super_block *sb)
+static void pstore_free_sb(struct super_block *sb)
 {
-	kill_litter_super(sb);
-
 	mutex_lock(&pstore_sb_lock);
 	pstore_sb = NULL;
 
@@ -483,7 +481,8 @@ static struct file_system_type pstore_fs_type = {
 	.owner          = THIS_MODULE,
 	.name		= "pstore",
 	.mount		= pstore_mount,
-	.kill_sb	= pstore_kill_sb,
+	.shutdown_sb	= litter_shutdown_sb,
+	.free_sb	= pstore_free_sb,
 };
 
 int __init pstore_init_fs(void)
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 0f37ecbae59dad..51eade68ae06f8 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -278,9 +278,8 @@ int ramfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-void ramfs_kill_sb(struct super_block *sb)
+void ramfs_free_sb(struct super_block *sb)
 {
-	kill_litter_super(sb);
 	kfree(sb->s_fs_info);
 }
 
@@ -288,7 +287,8 @@ static struct file_system_type ramfs_fs_type = {
 	.name		= "ramfs",
 	.init_fs_context = ramfs_init_fs_context,
 	.parameters	= ramfs_fs_parameters,
-	.kill_sb	= ramfs_kill_sb,
+	.shutdown_sb	= litter_shutdown_sb,
+	.free_sb	= ramfs_free_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
diff --git a/fs/super.c b/fs/super.c
index 8e173eccc8c113..1173a272bd086a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1319,13 +1319,21 @@ void free_anon_bdev(dev_t dev)
 }
 EXPORT_SYMBOL(free_anon_bdev);
 
-void kill_litter_super(struct super_block *sb)
+/**
+ * litter_shutdown_sb - shut down a super_block that only has synthetic files
+ * @sb:		super_block to shut down
+ *
+ * This function is a drop in ->shutdown_sb method and calls d_genocide() to
+ * drop all entries in the dcache.  It is used for file systems that only
+ * contained synthetic, that is kernel-generated, entries created by helpers
+ * like simple_fill_super().
+ */
+void litter_shutdown_sb(struct super_block *sb)
 {
 	if (sb->s_root)
 		d_genocide(sb->s_root);
-	generic_shutdown_super(sb);
 }
-EXPORT_SYMBOL(kill_litter_super);
+EXPORT_SYMBOL(litter_shutdown_sb);
 
 static int test_keyed_super(struct super_block *sb, struct fs_context *fc)
 {
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index de5b72216b1a70..7cde49dd76c5f7 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -438,7 +438,7 @@ static struct file_system_type trace_fs_type = {
 	.owner =	THIS_MODULE,
 	.name =		"tracefs",
 	.mount =	trace_mount,
-	.kill_sb =	kill_litter_super,
+	.shutdown_sb =	litter_shutdown_sb,
 };
 MODULE_ALIAS_FS("tracefs");
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 12fff7df3cc46b..c44c6fe9fc045b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2384,7 +2384,7 @@ extern struct dentry *mount_subtree(struct vfsmount *mnt, const char *path);
 void retire_super(struct super_block *sb);
 void generic_shutdown_super(struct super_block *sb);
 void kill_block_super(struct super_block *sb);
-void kill_litter_super(struct super_block *sb);
+void litter_shutdown_sb(struct super_block *sb);
 void deactivate_super(struct super_block *sb);
 void deactivate_locked_super(struct super_block *sb);
 int get_anon_bdev(dev_t *);
diff --git a/include/linux/ramfs.h b/include/linux/ramfs.h
index d506dc63dd47c5..9065f3bc8c9e94 100644
--- a/include/linux/ramfs.h
+++ b/include/linux/ramfs.h
@@ -7,7 +7,7 @@
 struct inode *ramfs_get_inode(struct super_block *sb, const struct inode *dir,
 	 umode_t mode, dev_t dev);
 extern int ramfs_init_fs_context(struct fs_context *fc);
-extern void ramfs_kill_sb(struct super_block *sb);
+void ramfs_free_sb(struct super_block *sb);
 
 #ifdef CONFIG_MMU
 static inline int
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 5dfd30b13f4857..95f40b8784d9aa 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -503,9 +503,9 @@ static int rootfs_init_fs_context(struct fs_context *fc)
 }
 
 struct file_system_type rootfs_fs_type = {
-	.name		= "rootfs",
-	.init_fs_context = rootfs_init_fs_context,
-	.kill_sb	= kill_litter_super,
+	.name			= "rootfs",
+	.init_fs_context	= rootfs_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 
 void __init init_rootfs(void)
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index ba8215ed663a43..e2e2fa6ffb901c 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1681,7 +1681,7 @@ static const struct fs_context_operations mqueue_fs_context_ops = {
 static struct file_system_type mqueue_fs_type = {
 	.name			= "mqueue",
 	.init_fs_context	= mqueue_init_fs_context,
-	.kill_sb		= kill_litter_super,
+	.shutdown_sb		= litter_shutdown_sb,
 	.fs_flags		= FS_USERNS_MOUNT,
 };
 
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 99d0625b6c828f..877a2a6a5729ba 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -797,7 +797,7 @@ static struct file_system_type bpf_fs_type = {
 	.name		= "bpf",
 	.init_fs_context = bpf_init_fs_context,
 	.parameters	= bpf_fs_parameters,
-	.kill_sb	= kill_litter_super,
+	.shutdown_sb	= litter_shutdown_sb,
 };
 
 static int __init bpf_init(void)
diff --git a/mm/shmem.c b/mm/shmem.c
index 02e62fccc80d49..53a39134e863f3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4584,7 +4584,7 @@ static struct file_system_type shmem_fs_type = {
 #ifdef CONFIG_TMPFS
 	.parameters	= shmem_fs_parameters,
 #endif
-	.kill_sb	= kill_litter_super,
+	.shutdown_sb	= litter_shutdown_sb,
 #ifdef CONFIG_SHMEM
 	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
 #else
@@ -4709,7 +4709,8 @@ static struct file_system_type shmem_fs_type = {
 	.name		= "tmpfs",
 	.init_fs_context = ramfs_init_fs_context,
 	.parameters	= ramfs_fs_parameters,
-	.kill_sb	= ramfs_kill_sb,
+	.shutdown_sb	= litter_shutdown_sb,
+	.free_sb	= ramfs_free_sb,
 	.fs_flags	= FS_USERNS_MOUNT,
 };
 
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index f420d845734513..c285cbe1a821a8 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1441,7 +1441,7 @@ static int rpc_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void rpc_kill_sb(struct super_block *sb)
+static void rpc_shutdown_sb(struct super_block *sb)
 {
 	struct net *net = sb->s_fs_info;
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
@@ -1459,15 +1459,20 @@ static void rpc_kill_sb(struct super_block *sb)
 					   sb);
 	mutex_unlock(&sn->pipefs_sb_lock);
 out:
-	kill_litter_super(sb);
-	put_net(net);
+	litter_shutdown_sb(sb);
+}
+
+static void rpc_free_sb(struct super_block *sb)
+{
+	put_net(sb->s_fs_info);
 }
 
 static struct file_system_type rpc_pipe_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "rpc_pipefs",
-	.init_fs_context = rpc_init_fs_context,
-	.kill_sb	= rpc_kill_sb,
+	.owner			= THIS_MODULE,
+	.name			= "rpc_pipefs",
+	.init_fs_context	= rpc_init_fs_context,
+	.shutdown_sb		= rpc_shutdown_sb,
+	.free_sb		= rpc_free_sb,
 };
 MODULE_ALIAS_FS("rpc_pipefs");
 MODULE_ALIAS("rpc_pipefs");
diff --git a/security/inode.c b/security/inode.c
index 3aa75fffa8c929..84779f998e76c5 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -67,10 +67,10 @@ static int securityfs_init_fs_context(struct fs_context *fc)
 }
 
 static struct file_system_type fs_type = {
-	.owner =	THIS_MODULE,
-	.name =		"securityfs",
-	.init_fs_context = securityfs_init_fs_context,
-	.kill_sb =	kill_litter_super,
+	.owner			= THIS_MODULE,
+	.name			= "securityfs",
+	.init_fs_context	= securityfs_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 
 /**
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 08fbb0f89d2659..e619eedefca373 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -94,7 +94,7 @@ static int selinux_fs_info_create(struct super_block *sb)
 	return 0;
 }
 
-static void selinux_fs_info_free(struct super_block *sb)
+static void sel_free_sb(struct super_block *sb)
 {
 	struct selinux_fs_info *fsi = sb->s_fs_info;
 	unsigned int i;
@@ -2120,16 +2120,11 @@ static int sel_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void sel_kill_sb(struct super_block *sb)
-{
-	kill_litter_super(sb);
-	selinux_fs_info_free(sb);
-}
-
 static struct file_system_type sel_fs_type = {
-	.name		= "selinuxfs",
-	.init_fs_context = sel_init_fs_context,
-	.kill_sb	= sel_kill_sb,
+	.name			= "selinuxfs",
+	.init_fs_context	= sel_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
+	.free_sb		= sel_free_sb,
 };
 
 static struct vfsmount *selinuxfs_mount __ro_after_init;
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8ac..9e60e927d02deb 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -2979,9 +2979,9 @@ static int smk_init_fs_context(struct fs_context *fc)
 }
 
 static struct file_system_type smk_fs_type = {
-	.name		= "smackfs",
-	.init_fs_context = smk_init_fs_context,
-	.kill_sb	= kill_litter_super,
+	.name			= "smackfs",
+	.init_fs_context	= smk_init_fs_context,
+	.shutdown_sb		= litter_shutdown_sb,
 };
 
 static struct vfsmount *smackfs_mount;
-- 
2.39.2

