Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C779E631
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbjIMLLN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbjIMLLJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5491BC3;
        Wed, 13 Sep 2023 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Xklao4KHcROHR/8WDTUTeOE5QrsYvb1TOynYxxAM1IY=; b=0av/5m717cplc+QOcwl88ZZhkv
        YQM9yzvQDx1wwNM1F4FN/+TZdcZakCPUB9tpX7qIKXviEYJGNiKL7nM6wzdoFpXYUwE8dRlxYP85n
        AheRdG3C68ZFMu0glT+SSrQiXRTWdZz1OA6HzM3aCxLykdLie2/UAUNYXAUOU8LULnl7dF85H1y3I
        bfHoOdc64/KYRLDOL+/ElcKMIOyRVN8LF7dTQpsazJCGbzefGXOUpSfMlN8KQMxT5w6XrbKzELime
        Ut1U2f7WzU7RHmh/n7g+ZCkfXpAq547wD8l7r+0tUECJw5acUGSocQEMGdzdnjGO/bAAnIc7s4T9b
        hrVh7h5Q==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNli-005hzf-03;
        Wed, 13 Sep 2023 11:10:50 +0000
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
Subject: [PATCH 08/19] pstore: shrink the pstore_sb_lock critical section in pstore_kill_sb
Date:   Wed, 13 Sep 2023 08:10:02 -0300
Message-Id: <20230913111013.77623-9-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

->kill_sb can't race with creating ->fill_super because pstore is a
_single file system that only ever has a single sb instance, and we wait
for the previous one to go away before creating a new one.  Reduce
the critical section so that is is not held over generic_shutdown_super.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/pstore/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 585360706b335f..fd1d24b47160d0 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -467,10 +467,9 @@ static struct dentry *pstore_mount(struct file_system_type *fs_type,
 
 static void pstore_kill_sb(struct super_block *sb)
 {
-	mutex_lock(&pstore_sb_lock);
-	WARN_ON(pstore_sb && pstore_sb != sb);
-
 	kill_litter_super(sb);
+
+	mutex_lock(&pstore_sb_lock);
 	pstore_sb = NULL;
 
 	mutex_lock(&records_list_lock);
-- 
2.39.2

