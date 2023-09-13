Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24CE79E60C
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbjIMLLy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbjIMLLe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B901FD4;
        Wed, 13 Sep 2023 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AwVUXcoXpUXwAjgKY+YMHBurOxH8fp8xakqCS5N8QOI=; b=tQeAokJJ8m0XmksMRtptFl8ZrW
        6Nom6PA+knKc6r3zg4W2KMC61HNnxlaQel6fkB1HrrRawRzpj0M2vmMWymFHxZopL1KDQnSJ22U5A
        Ow8kmT5tnVA86aSdIOqZfLkdy4Um0mUCoNALuvG5AqbRguzFlaFgGhQhRRopr604QlKgqzQKzCW5i
        6ZPKeGOFyLSHYmNqpfo99oZf3xJs34VDYnSiA3E8zNPES+89u4ecfTrDYhf1lDxZiXSmDagrKT8Ad
        fyPmeFZghP6slRpc1RhK91m65VkoFrK8jVEe0jyJ6QJqD4oF6dovad5lpUbyEsuC1cydeEOELenjv
        u4xvPPqg==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNm2-005i7T-3B;
        Wed, 13 Sep 2023 11:11:11 +0000
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
Subject: [PATCH 14/19] jffs2: convert to ->shutdown_sb and ->free_sb
Date:   Wed, 13 Sep 2023 08:10:08 -0300
Message-Id: <20230913111013.77623-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert jffs2 from ->kill_sb to ->shutdown_sb and ->free_sb.  Drop
the otherwise unused kill_mtd_super helpers, as there is no benefit in
it over just calling put_mtd_device on sb->s_mtd.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtdsuper.c    | 12 ------------
 fs/jffs2/super.c          | 22 ++++++++++++++--------
 include/linux/mtd/super.h |  2 --
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index b7e3763c47f0cd..66da2e6f90f5f5 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -165,15 +165,3 @@ int get_tree_mtd(struct fs_context *fc,
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(get_tree_mtd);
-
-/*
- * destroy an MTD-based superblock
- */
-void kill_mtd_super(struct super_block *sb)
-{
-	generic_shutdown_super(sb);
-	put_mtd_device(sb->s_mtd);
-	sb->s_mtd = NULL;
-}
-
-EXPORT_SYMBOL_GPL(kill_mtd_super);
diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 7ea37f49f1e18e..14577368202e90 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -340,21 +340,27 @@ static void jffs2_put_super (struct super_block *sb)
 	jffs2_dbg(1, "%s(): returning\n", __func__);
 }
 
-static void jffs2_kill_sb(struct super_block *sb)
+static void jffs2_shutdown_sb(struct super_block *sb)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
+
 	if (c && !sb_rdonly(sb))
 		jffs2_stop_garbage_collect_thread(c);
-	kill_mtd_super(sb);
-	kfree(c);
+}
+
+static void jffs2_free_sb(struct super_block *sb)
+{
+	put_mtd_device(sb->s_mtd);
+	kfree(JFFS2_SB_INFO(sb));
 }
 
 static struct file_system_type jffs2_fs_type = {
-	.owner =	THIS_MODULE,
-	.name =		"jffs2",
-	.init_fs_context = jffs2_init_fs_context,
-	.parameters =	jffs2_fs_parameters,
-	.kill_sb =	jffs2_kill_sb,
+	.owner			= THIS_MODULE,
+	.name			= "jffs2",
+	.init_fs_context	= jffs2_init_fs_context,
+	.parameters		= jffs2_fs_parameters,
+	.shutdown_sb		= jffs2_shutdown_sb,
+	.free_sb		= jffs2_free_sb,
 };
 MODULE_ALIAS_FS("jffs2");
 
diff --git a/include/linux/mtd/super.h b/include/linux/mtd/super.h
index 3608a6c36faceb..f6d5c1a17eec23 100644
--- a/include/linux/mtd/super.h
+++ b/include/linux/mtd/super.h
@@ -17,8 +17,6 @@
 extern int get_tree_mtd(struct fs_context *fc,
 		     int (*fill_super)(struct super_block *sb,
 				       struct fs_context *fc));
-extern void kill_mtd_super(struct super_block *sb);
-
 
 #endif /* __KERNEL__ */
 
-- 
2.39.2

