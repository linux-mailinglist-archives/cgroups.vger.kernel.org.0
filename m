Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0894879E634
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjIMLMN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240191AbjIMLLx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB302712;
        Wed, 13 Sep 2023 04:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=uLf6h1RfKslNP20U1IGrQ445JsmzxP5A7l/7KbuT/rI=; b=jv3yC3+tBEO2gEO8hI8aiTv3mm
        C4RIrY6VwCIz+0Kd8HLQh0zUXapoHexrxrsQcpmK0edlC0uwqv6xRJMamtim2fxT0yCH0LdJ9gBrQ
        J93a1HenbqTLi2h0MAndK/r51S78zkIX89N5rrF/UEH5rU97J3g6oW/jig2X7WzEwTLFoBSPMMJXG
        +DyzLXFhchmuRLnOF4kJA9SpMGR7ZzWCefk5x52awHnBs0GgmjqVUh4fv+FKIALK2M0srMPen9L38
        O6MequqmNpU1rb2i3bikKfRqEoLW8mu85hD7Mdr01uEfOQMdqn21zw3hqR99nuSg5OOW53ykwaIwp
        bP2wyvIg==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNmE-005iAs-0B;
        Wed, 13 Sep 2023 11:11:22 +0000
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
Subject: [PATCH 17/19] NFS: move nfs_kill_super to fs_context.c
Date:   Wed, 13 Sep 2023 08:10:11 -0300
Message-Id: <20230913111013.77623-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

nfs_kill_super is only used in fs_context, so move it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/fs_context.c | 13 +++++++++++++
 fs/nfs/internal.h   |  1 -
 fs/nfs/super.c      | 16 ----------------
 fs/nfs/sysfs.h      |  2 ++
 4 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 853e8d609bb3bc..ee82e4cfb38bb5 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -21,8 +21,10 @@
 
 #include <net/handshake.h>
 
+#include "fscache.h"
 #include "nfs.h"
 #include "internal.h"
+#include "sysfs.h"
 
 #include "nfstrace.h"
 
@@ -1644,6 +1646,17 @@ static int nfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void nfs_kill_super(struct super_block *s)
+{
+	struct nfs_server *server = NFS_SB(s);
+
+	nfs_sysfs_move_sb_to_server(server);
+	generic_shutdown_super(s);
+
+	nfs_fscache_release_super_cookie(s);
+	nfs_free_server(server);
+}
+
 struct file_system_type nfs_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "nfs",
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9c9cf764f6000d..49d5b03176c02d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -447,7 +447,6 @@ extern const struct super_operations nfs_sops;
 bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
 int nfs_try_get_tree(struct fs_context *);
 int nfs_get_tree_common(struct fs_context *);
-void nfs_kill_super(struct super_block *);
 
 extern struct rpc_stat nfs_rpcstat;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 89131e855e1393..5ba793e7f262d4 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1329,22 +1329,6 @@ int nfs_get_tree_common(struct fs_context *fc)
 	goto out;
 }
 
-/*
- * Destroy an NFS superblock
- */
-void nfs_kill_super(struct super_block *s)
-{
-	struct nfs_server *server = NFS_SB(s);
-
-	nfs_sysfs_move_sb_to_server(server);
-	generic_shutdown_super(s);
-
-	nfs_fscache_release_super_cookie(s);
-
-	nfs_free_server(server);
-}
-EXPORT_SYMBOL_GPL(nfs_kill_super);
-
 #if IS_ENABLED(CONFIG_NFS_V4)
 
 /*
diff --git a/fs/nfs/sysfs.h b/fs/nfs/sysfs.h
index c5d1990cade50a..44c8a1712149c2 100644
--- a/fs/nfs/sysfs.h
+++ b/fs/nfs/sysfs.h
@@ -8,6 +8,8 @@
 
 #define CONTAINER_ID_MAXLEN (64)
 
+struct nfs_net;
+
 struct nfs_netns_client {
 	struct kobject kobject;
 	struct kobject nfs_net_kobj;
-- 
2.39.2

