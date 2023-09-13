Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3B79E603
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbjIMLLU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239955AbjIMLLL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A121BE4;
        Wed, 13 Sep 2023 04:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qveFDVPX/ugxM2Qs1ozl01Z3CU43frG5SeTOC5Qmlyc=; b=B11guw1T4ocUFQYK2XEc78rKRR
        4BX2AUC9ts69y4WjCdC7i+Mm0E3i7DHSevrLRJOTcT7nNMf/XDVaZyoQnVLzmJr9jF98g0s2HcjHl
        DbTo2r+XXvTFwBSBFaGG2w+1saDxkxKG4pE7gudop41xIj6mNvgGcD8UcyammKEV8uEEb97jQmtCg
        0OMJ2aYT/Hh6qc0c91wqGJGePklhQDYXL/svyeUYQnkJuqKPKQ7S3d1MKIjMUiqMU4hBhDkCQhxlA
        SVqZAVS2ZngKlTfEuQROYXaxEv0DYzfaSX02U/1nXPOTh14k4sUpvBvjSs1v//ljzSbZ6oNBJrqRI
        o6AEoW8Q==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNll-005i0b-1E;
        Wed, 13 Sep 2023 11:10:54 +0000
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
Subject: [PATCH 09/19] zonefs: remove duplicate cleanup in zonefs_fill_super
Date:   Wed, 13 Sep 2023 08:10:03 -0300
Message-Id: <20230913111013.77623-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When ->fill_super fails, ->kill_sb is called which already cleans up
the inodes and zgroups.

Drop the extra cleanup code in zonefs_fill_super.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/zonefs/super.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 9d1a9808fbbba6..35b2554ce2ac2e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1309,13 +1309,12 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	/* Initialize the zone groups */
 	ret = zonefs_init_zgroups(sb);
 	if (ret)
-		goto cleanup;
+		return ret;
 
 	/* Create the root directory inode */
-	ret = -ENOMEM;
 	inode = new_inode(sb);
 	if (!inode)
-		goto cleanup;
+		return -ENOMEM;
 
 	inode->i_ino = bdev_nr_zones(sb->s_bdev);
 	inode->i_mode = S_IFDIR | 0555;
@@ -1333,7 +1332,7 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_root = d_make_root(inode);
 	if (!sb->s_root)
-		goto cleanup;
+		return -ENOMEM;
 
 	/*
 	 * Take a reference on the zone groups directory inodes
@@ -1341,19 +1340,9 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	 */
 	ret = zonefs_get_zgroup_inodes(sb);
 	if (ret)
-		goto cleanup;
-
-	ret = zonefs_sysfs_register(sb);
-	if (ret)
-		goto cleanup;
-
-	return 0;
-
-cleanup:
-	zonefs_release_zgroup_inodes(sb);
-	zonefs_free_zgroups(sb);
+		return ret;
 
-	return ret;
+	return zonefs_sysfs_register(sb);
 }
 
 static struct dentry *zonefs_mount(struct file_system_type *fs_type,
-- 
2.39.2

