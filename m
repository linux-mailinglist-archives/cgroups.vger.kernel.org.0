Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A1D79E5E7
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbjIMLK6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbjIMLK4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:10:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B460F19AF;
        Wed, 13 Sep 2023 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b6JdnhwIl1taCSuc4/dqYhKrJWm6XSMnTzKFUhXDk90=; b=EAZIGMEQGDmVc5b4HFMpBvbTk1
        a87xB+v+1aNqp3SxQeGpV9pGzF8zADYqluGyqlFQa8NzUIiR/aTufGkixUmKR0TmyhHOKTVIssNrI
        oOFCpHLiXMlmAN3iof2pWDUzqstnEJxit+dtb2dVuyYZxuftmoWr5Wuyb6w7M1b9q23kwkDHhoToo
        1htP/cypd4seEz9gHuu1jV1u0S7HxglRFy5nb0rOrPWEZZMb1lIVKnbtY/e3M85d25kUSW3oQL2RU
        laGeZfjve9WXYmBB4d0uFgGBFR8aDayeP5agpFwnAbORmgapveVNx3bXY8WLLNsnARaFCeGJDPCln
        /4p8NMPw==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlK-005hvJ-0S;
        Wed, 13 Sep 2023 11:10:26 +0000
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
Subject: [PATCH 01/19] fs: reflow deactivate_locked_super
Date:   Wed, 13 Sep 2023 08:09:55 -0300
Message-Id: <20230913111013.77623-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Return early for the case where the super block isn't cleaned up to
reduce level of indentation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 2d762ce67f6e6c..127a17d958a482 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -476,27 +476,28 @@ static void kill_super_notify(struct super_block *sb)
 void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
-	if (atomic_dec_and_test(&s->s_active)) {
-		unregister_shrinker(&s->s_shrink);
-		fs->kill_sb(s);
 
-		kill_super_notify(s);
-
-		/*
-		 * Since list_lru_destroy() may sleep, we cannot call it from
-		 * put_super(), where we hold the sb_lock. Therefore we destroy
-		 * the lru lists right now.
-		 */
-		list_lru_destroy(&s->s_dentry_lru);
-		list_lru_destroy(&s->s_inode_lru);
-
-		put_filesystem(fs);
-		put_super(s);
-	} else {
+	if (!atomic_dec_and_test(&s->s_active)) {
 		super_unlock_excl(s);
+		return;
 	}
-}
 
+	unregister_shrinker(&s->s_shrink);
+	fs->kill_sb(s);
+
+	kill_super_notify(s);
+
+	/*
+	 * Since list_lru_destroy() may sleep, we cannot call it from
+	 * put_super(), where we hold the sb_lock. Therefore we destroy
+	 * the lru lists right now.
+	 */
+	list_lru_destroy(&s->s_dentry_lru);
+	list_lru_destroy(&s->s_inode_lru);
+
+	put_filesystem(fs);
+	put_super(s);
+}
 EXPORT_SYMBOL(deactivate_locked_super);
 
 /**
-- 
2.39.2

