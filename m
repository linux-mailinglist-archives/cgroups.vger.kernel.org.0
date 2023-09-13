Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D079E63D
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbjIMLLK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239956AbjIMLK5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:10:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965C919AD;
        Wed, 13 Sep 2023 04:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4K7Zh6fs7L+RUXwEY56nuj8NrK8ZqJ3CZpGE4GdIplk=; b=0vjrb7/vV79SKhobktbmGhno7R
        uQUJDhbbppkzC/Mc8r3UT+FaZA1YB0Xfua6N1gf6iSPDvl8kslZB8TM8gHszsDPkxTrY7YUbuLOJO
        VRAXB8ljZ5udf6WgXlBV1DuASXDj/g8Gzaifk258EQPoQoZ/brf1erqpgdtR0+99/dUG5f67aKUeL
        6ZQjDJvQQy/1jSsX+qIgytJOkm+ExaLq70Xfvz5qTpfMeX2q2M2A8G2Oe8QwtufoNB+BPVid6toXr
        xidizbu5Jx0RIsBKv8xRBtURVuHrgwtPCKr1fFH/VCA7sH0xw8Te1AVNN9NAIbMBc3VHFMHlIGoH8
        8cZz1mZg==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNle-005hz8-2Y;
        Wed, 13 Sep 2023 11:10:47 +0000
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
Subject: [PATCH 07/19] hypfs: use d_genocide to kill fs entries
Date:   Wed, 13 Sep 2023 08:10:01 -0300
Message-Id: <20230913111013.77623-8-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

hypfs is entirely synthetic and doesn't care about i_nlink when dropping
entries from the cache.  Switch to d_genocide instead of a home grown
file remove loop for unmount and write (yes, really!).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/hypfs/inode.c | 37 ++-----------------------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index dbe8a7dcafa922..3261fb9cade648 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -64,33 +64,6 @@ static void hypfs_add_dentry(struct dentry *dentry)
 	hypfs_last_dentry = dentry;
 }
 
-static void hypfs_remove(struct dentry *dentry)
-{
-	struct dentry *parent;
-
-	parent = dentry->d_parent;
-	inode_lock(d_inode(parent));
-	if (simple_positive(dentry)) {
-		if (d_is_dir(dentry))
-			simple_rmdir(d_inode(parent), dentry);
-		else
-			simple_unlink(d_inode(parent), dentry);
-	}
-	d_drop(dentry);
-	dput(dentry);
-	inode_unlock(d_inode(parent));
-}
-
-static void hypfs_delete_tree(struct dentry *root)
-{
-	while (hypfs_last_dentry) {
-		struct dentry *next_dentry;
-		next_dentry = hypfs_last_dentry->d_fsdata;
-		hypfs_remove(hypfs_last_dentry);
-		hypfs_last_dentry = next_dentry;
-	}
-}
-
 static struct inode *hypfs_make_inode(struct super_block *sb, umode_t mode)
 {
 	struct inode *ret = new_inode(sb);
@@ -183,14 +156,14 @@ static ssize_t hypfs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		rc = -EBUSY;
 		goto out;
 	}
-	hypfs_delete_tree(sb->s_root);
+	d_genocide(sb->s_root);
 	if (MACHINE_IS_VM)
 		rc = hypfs_vm_create_files(sb->s_root);
 	else
 		rc = hypfs_diag_create_files(sb->s_root);
 	if (rc) {
 		pr_err("Updating the hypfs tree failed\n");
-		hypfs_delete_tree(sb->s_root);
+		d_genocide(sb->s_root);
 		goto out;
 	}
 	hypfs_update_update(sb);
@@ -323,12 +296,6 @@ static int hypfs_init_fs_context(struct fs_context *fc)
 
 static void hypfs_kill_super(struct super_block *sb)
 {
-	struct hypfs_sb_info *sb_info = sb->s_fs_info;
-
-	if (sb->s_root)
-		hypfs_delete_tree(sb->s_root);
-	if (sb_info && sb_info->update_file)
-		hypfs_remove(sb_info->update_file);
 	kill_litter_super(sb);
 	kfree(sb->s_fs_info);
 }
-- 
2.39.2

