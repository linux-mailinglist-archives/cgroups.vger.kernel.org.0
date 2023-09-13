Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46479E5DA
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbjIMLKy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbjIMLKx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:10:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B606B19A6;
        Wed, 13 Sep 2023 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OvdbcAa8gNPLTScw30C0haUonfkOP4Sq+9lSIjPBcA4=; b=BepW6GlQfs7UxJI49kYyTOBmOn
        io8rCiqoTN82fVhijBrxmh9o1TdkMXRsiAIwB5vFZMJHLLxr+CTkE5IT0bezBvw5XQkYmxJamyO7r
        VERBZCQvvADhWdAfiqojvZf61y+XfcgyFv5rOelIFAgst08ZgJMWU4IlV3C9vz/DA8lzKsDDcCi4x
        nTdjEjDz27Hb9ZI3K+FLVKG+rRX6BnVjvMb0SMmENeAYOBDB/ReOHHJhruLn67W3hQYc9BTZSJA4k
        vinBnybR1nUaX6WOMp85Fn/1tILifgOb74k8iOy2N+OpXTds6npnQN1TjbBmF5AD+WCPStHhmQgb2
        vXoPOUQw==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNlN-005hvc-2f;
        Wed, 13 Sep 2023 11:10:30 +0000
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
Subject: [PATCH 02/19] fs: make ->kill_sb optional
Date:   Wed, 13 Sep 2023 08:09:56 -0300
Message-Id: <20230913111013.77623-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Call generic_shutdown_super if ->kill_sb is not provided by the file
system.  This can't currently happen but will become common soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 127a17d958a482..ab234e6af48605 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -483,7 +483,11 @@ void deactivate_locked_super(struct super_block *s)
 	}
 
 	unregister_shrinker(&s->s_shrink);
-	fs->kill_sb(s);
+
+	if (fs->kill_sb)
+		fs->kill_sb(s);
+	else
+		generic_shutdown_super(s);
 
 	kill_super_notify(s);
 
-- 
2.39.2

