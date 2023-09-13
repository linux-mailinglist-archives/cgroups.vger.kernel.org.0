Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAF779E5EF
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239979AbjIMLLB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239941AbjIMLK5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:10:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2991726;
        Wed, 13 Sep 2023 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QtxUC0PBd27k/jPmifPKRgeZeU54oAe4sU/iHRhk3us=; b=3jF8AWqft55sENPRPWk4+bWnJK
        Wny8RJRRcJOCnKQfKis+eSo5Ht8lSO5uqi8Mk14bXtPwXbtoItRQ6VHePz91Wi0ab2Mx2UFCjEuii
        Erb5f7PDwveImNZXjR7INUB/HtkqxUwJkXmozhdIefKQOvgCkbLc5ytAUJXqOiFLd7nQdZ3Ky3FK/
        ASQQsIleUTxD3RNLoemOhFq0knghz9g8cMssYrT4BoIMgtK46a+CTEWQg9aY8n9xE3pug5xOGLrCr
        BsZgMnd69QJGoyJHfXBiq2W06yYu+eBLxYYfm9Pj2TFYIpKFqdq41mYxq2Z5ClsQHnFJlVjb229Zh
        A/eAxolw==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlb-005hy2-2X;
        Wed, 13 Sep 2023 11:10:44 +0000
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
Subject: [PATCH 06/19] qibfs: use simple_release_fs
Date:   Wed, 13 Sep 2023 08:10:00 -0300
Message-Id: <20230913111013.77623-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

qibfs currently has convoluted code to allow registering HCAs while qibfs
is not mounted and vice versa.  Switch to using simple_release_fs every
time an entry is added to pin the fs instance and remove all the boiler
plate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/infiniband/hw/qib/qib.h      |   4 +-
 drivers/infiniband/hw/qib/qib_fs.c   | 105 ++++++---------------------
 drivers/infiniband/hw/qib/qib_init.c |  32 +++-----
 3 files changed, 36 insertions(+), 105 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib.h b/drivers/infiniband/hw/qib/qib.h
index 26c615772be390..f73c321d0bff88 100644
--- a/drivers/infiniband/hw/qib/qib.h
+++ b/drivers/infiniband/hw/qib/qib.h
@@ -1370,10 +1370,10 @@ void qib_device_remove(struct qib_devdata *);
 extern int qib_qsfp_dump(struct qib_pportdata *ppd, char *buf, int len);
 
 int __init qib_init_qibfs(void);
-int __exit qib_exit_qibfs(void);
+void __exit qib_exit_qibfs(void);
 
 int qibfs_add(struct qib_devdata *);
-int qibfs_remove(struct qib_devdata *);
+void qibfs_remove(struct qib_devdata *);
 
 int qib_pcie_init(struct pci_dev *, const struct pci_device_id *);
 int qib_pcie_ddinit(struct qib_devdata *, struct pci_dev *,
diff --git a/drivers/infiniband/hw/qib/qib_fs.c b/drivers/infiniband/hw/qib/qib_fs.c
index ed7d4b02f45a63..c52ca34b32e67d 100644
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -43,7 +43,9 @@
 
 #define QIBFS_MAGIC 0x726a77
 
-static struct super_block *qib_super;
+static struct file_system_type qibfs_fs_type;
+static struct vfsmount *qib_mount;
+static int qib_mnt_count;
 
 #define private2dd(file) (file_inode(file)->i_private)
 
@@ -355,15 +357,19 @@ static const struct file_operations flash_ops = {
 	.llseek = default_llseek,
 };
 
-static int add_cntr_files(struct super_block *sb, struct qib_devdata *dd)
+int qibfs_add(struct qib_devdata *dd)
 {
 	struct dentry *dir, *tmp;
 	char unit[10];
 	int ret, i;
+	
+	ret = simple_pin_fs(&qibfs_fs_type, &qib_mount, &qib_mnt_count);
+	if (ret)
+		return ret;
 
 	/* create the per-unit directory */
 	snprintf(unit, sizeof(unit), "%u", dd->unit);
-	ret = create_file(unit, S_IFDIR|S_IRUGO|S_IXUGO, sb->s_root, &dir,
+	ret = create_file(unit, S_IFDIR|S_IRUGO|S_IXUGO, qib_mount->mnt_root, &dir,
 			  &simple_dir_operations, dd);
 	if (ret) {
 		pr_err("create_file(%s) failed: %d\n", unit, ret);
@@ -422,65 +428,35 @@ static int add_cntr_files(struct super_block *sb, struct qib_devdata *dd)
 		pr_err("create_file(%s/flash) failed: %d\n",
 			unit, ret);
 bail:
+	simple_release_fs(&qib_mount, &qib_mnt_count);
 	return ret;
 }
 
-static int remove_device_files(struct super_block *sb,
-			       struct qib_devdata *dd)
+void qibfs_remove(struct qib_devdata *dd)
 {
 	struct dentry *dir;
 	char unit[10];
 
 	snprintf(unit, sizeof(unit), "%u", dd->unit);
-	dir = lookup_one_len_unlocked(unit, sb->s_root, strlen(unit));
-
-	if (IS_ERR(dir)) {
-		pr_err("Lookup of %s failed\n", unit);
-		return PTR_ERR(dir);
-	}
-	simple_recursive_removal(dir, NULL);
-	return 0;
+	dir = lookup_one_len_unlocked(unit, qib_mount->mnt_root, strlen(unit));
+	if (!IS_ERR(dir))
+		simple_recursive_removal(dir, NULL);
+	simple_release_fs(&qib_mount, &qib_mnt_count);
 }
 
-/*
- * This fills everything in when the fs is mounted, to handle umount/mount
- * after device init.  The direct add_cntr_files() call handles adding
- * them from the init code, when the fs is already mounted.
- */
 static int qibfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct qib_devdata *dd;
-	unsigned long index;
-	int ret;
-
 	static const struct tree_descr files[] = {
 		[2] = {"driver_stats", &driver_ops[0], S_IRUGO},
 		[3] = {"driver_stats_names", &driver_ops[1], S_IRUGO},
 		{""},
 	};
-
-	ret = simple_fill_super(sb, QIBFS_MAGIC, files);
-	if (ret) {
-		pr_err("simple_fill_super failed: %d\n", ret);
-		goto bail;
-	}
-
-	xa_for_each(&qib_dev_table, index, dd) {
-		ret = add_cntr_files(sb, dd);
-		if (ret)
-			goto bail;
-	}
-
-bail:
-	return ret;
+	return simple_fill_super(sb, QIBFS_MAGIC, files);
 }
 
 static int qibfs_get_tree(struct fs_context *fc)
 {
-	int ret = get_tree_single(fc, qibfs_fill_super);
-	if (ret == 0)
-		qib_super = fc->root->d_sb;
-	return ret;
+	return get_tree_single(fc, qibfs_fill_super);
 }
 
 static const struct fs_context_operations qibfs_context_ops = {
@@ -493,46 +469,11 @@ static int qibfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
-static void qibfs_kill_super(struct super_block *s)
-{
-	kill_litter_super(s);
-	qib_super = NULL;
-}
-
-int qibfs_add(struct qib_devdata *dd)
-{
-	int ret;
-
-	/*
-	 * On first unit initialized, qib_super will not yet exist
-	 * because nobody has yet tried to mount the filesystem, so
-	 * we can't consider that to be an error; if an error occurs
-	 * during the mount, that will get a complaint, so this is OK.
-	 * add_cntr_files() for all units is done at mount from
-	 * qibfs_fill_super(), so one way or another, everything works.
-	 */
-	if (qib_super == NULL)
-		ret = 0;
-	else
-		ret = add_cntr_files(qib_super, dd);
-	return ret;
-}
-
-int qibfs_remove(struct qib_devdata *dd)
-{
-	int ret = 0;
-
-	if (qib_super)
-		ret = remove_device_files(qib_super, dd);
-
-	return ret;
-}
-
 static struct file_system_type qibfs_fs_type = {
-	.owner =        THIS_MODULE,
-	.name =         "ipathfs",
-	.init_fs_context = qibfs_init_fs_context,
-	.kill_sb =      qibfs_kill_super,
+	.owner			= THIS_MODULE,
+	.name			= "ipathfs",
+	.init_fs_context	= qibfs_init_fs_context,
+	.kill_sb		= kill_litter_super,
 };
 MODULE_ALIAS_FS("ipathfs");
 
@@ -541,7 +482,7 @@ int __init qib_init_qibfs(void)
 	return register_filesystem(&qibfs_fs_type);
 }
 
-int __exit qib_exit_qibfs(void)
+void __exit qib_exit_qibfs(void)
 {
-	return unregister_filesystem(&qibfs_fs_type);
+	unregister_filesystem(&qibfs_fs_type);
 }
diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
index 33667becd52b04..46306573a37a7d 100644
--- a/drivers/infiniband/hw/qib/qib_init.c
+++ b/drivers/infiniband/hw/qib/qib_init.c
@@ -1217,9 +1217,13 @@ static int __init qib_ib_init(void)
 {
 	int ret;
 
+	ret = qib_init_qibfs();
+	if (ret)
+		return ret;
+
 	ret = qib_dev_init();
 	if (ret)
-		goto bail;
+		goto bail_fs;
 
 	/*
 	 * These must be called before the driver is registered with
@@ -1237,10 +1241,7 @@ static int __init qib_ib_init(void)
 		goto bail_dev;
 	}
 
-	/* not fatal if it doesn't work */
-	if (qib_init_qibfs())
-		pr_err("Unable to register ipathfs\n");
-	goto bail; /* all OK */
+	return ret;
 
 bail_dev:
 #ifdef CONFIG_INFINIBAND_QIB_DCA
@@ -1250,7 +1251,8 @@ static int __init qib_ib_init(void)
 	qib_dbg_exit();
 #endif
 	qib_dev_cleanup();
-bail:
+bail_fs:
+	qib_exit_qibfs();
 	return ret;
 }
 
@@ -1261,14 +1263,6 @@ module_init(qib_ib_init);
  */
 static void __exit qib_ib_cleanup(void)
 {
-	int ret;
-
-	ret = qib_exit_qibfs();
-	if (ret)
-		pr_err(
-			"Unable to cleanup counter filesystem: error %d\n",
-			-ret);
-
 #ifdef CONFIG_INFINIBAND_QIB_DCA
 	dca_unregister_notify(&dca_notifier);
 #endif
@@ -1282,6 +1276,7 @@ static void __exit qib_ib_cleanup(void)
 
 	WARN_ON(!xa_empty(&qib_dev_table));
 	qib_dev_cleanup();
+	qib_exit_qibfs();
 }
 
 module_exit(qib_ib_cleanup);
@@ -1469,7 +1464,7 @@ static int qib_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (qib_mini_init)
 			goto bail;
 		if (!j) {
-			(void) qibfs_remove(dd);
+			qibfs_remove(dd);
 			qib_device_remove(dd);
 		}
 		if (!ret)
@@ -1496,7 +1491,6 @@ static int qib_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 static void qib_remove_one(struct pci_dev *pdev)
 {
 	struct qib_devdata *dd = pci_get_drvdata(pdev);
-	int ret;
 
 	/* unregister from IB core */
 	qib_unregister_ib_device(dd);
@@ -1513,11 +1507,7 @@ static void qib_remove_one(struct pci_dev *pdev)
 	/* wait until all of our (qsfp) queue_work() calls complete */
 	flush_workqueue(ib_wq);
 
-	ret = qibfs_remove(dd);
-	if (ret)
-		qib_dev_err(dd, "Failed counters filesystem cleanup: %d\n",
-			    -ret);
-
+	qibfs_remove(dd);
 	qib_device_remove(dd);
 
 	qib_postinit_cleanup(dd);
-- 
2.39.2

