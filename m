Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91AF79E646
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240006AbjIMLLb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240016AbjIMLLO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889702105;
        Wed, 13 Sep 2023 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jhauY3/jneyf5WN9+Nuds+kBzVHdIqfAGUjcFJu8Bb0=; b=fUrXbSzYYwvk+a7iZ04b7uqo6O
        yMFzj0Gftg1cPI8xK6HOS5/2t5pgeno2tGYPOgwsJz/081bsx4S+hNeEiOj/9JPYM9Yjh8pEPvIg2
        Wrp5GU4bcSIB4btcue4uQ/lOMQxCDrtTXQFGbsyz+e+Q/sq/NLIyVUnKS5kh30g1tvkUo+WWLbVI6
        iV88O2PyuhopSrHum84IdH5rZrmRR5W3S1uhaN1V/StJdm9zQvhM3SCODI7SYCP057DWJJXxpllGa
        KmxajivmHPrvJKEQo0Mi/kfLGWHMHeQkzHNpZklea/6faKeUB06rySel8D+8dQfJ9GqlEYiIOG6Bi
        iwOUmqVA==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlp-005i2V-0E;
        Wed, 13 Sep 2023 11:10:57 +0000
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
Subject: [PATCH 10/19] USB: gadget/legacy: remove sb_mutex
Date:   Wed, 13 Sep 2023 08:10:04 -0300
Message-Id: <20230913111013.77623-11-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Creating new a new super_block vs freeing the old one for single instance
file systems is serialized by the wait for SB_DEAD.

Remove the superfluous sb_mutex.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/usb/gadget/legacy/inode.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index ce9e31f3d26bcc..a203266bc0dc82 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -229,7 +229,6 @@ static void put_ep (struct ep_data *data)
  */
 
 static const char *CHIP;
-static DEFINE_MUTEX(sb_mutex);		/* Serialize superblock operations */
 
 /*----------------------------------------------------------------------*/
 
@@ -2012,8 +2011,6 @@ gadgetfs_fill_super (struct super_block *sb, struct fs_context *fc)
 	struct dev_data	*dev;
 	int		rc;
 
-	mutex_lock(&sb_mutex);
-
 	if (the_device) {
 		rc = -ESRCH;
 		goto Done;
@@ -2069,7 +2066,6 @@ gadgetfs_fill_super (struct super_block *sb, struct fs_context *fc)
 	rc = -ENOMEM;
 
  Done:
-	mutex_unlock(&sb_mutex);
 	return rc;
 }
 
@@ -2092,7 +2088,6 @@ static int gadgetfs_init_fs_context(struct fs_context *fc)
 static void
 gadgetfs_kill_sb (struct super_block *sb)
 {
-	mutex_lock(&sb_mutex);
 	kill_litter_super (sb);
 	if (the_device) {
 		put_dev (the_device);
@@ -2100,7 +2095,6 @@ gadgetfs_kill_sb (struct super_block *sb)
 	}
 	kfree(CHIP);
 	CHIP = NULL;
-	mutex_unlock(&sb_mutex);
 }
 
 /*----------------------------------------------------------------------*/
-- 
2.39.2

