Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC0679E62E
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240240AbjIMLLo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbjIMLLb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 07:11:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F70212C;
        Wed, 13 Sep 2023 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gAQpn3abjr3bCkTLiF8aPyoqkxGk9OOm0IM5g63D6eE=; b=NdBTKNAaKwHERWBpvD3UHGHfWf
        zb1yuh/XGcMfDzj1uLx+u6lD7qnepKXrpO/pZmptTHoHtwVpXIcZshX4OUVEMjv7TFo69PbppmJ2S
        rlnKrkO75331r1G0LrzPr74Ld8r5vKU+AwChAsIjk83zQKmZMBIc84YOIDUSjkv5ZJvuC/IOK+E12
        WpSRWG3djGVWDuKbehP3xIldJ/rcOSFsLliI85QDerGS8G2MUpKUaT8chV07JMkBU1+2CEJsmDyZe
        wUX0ytw7XTGMjsPQ73ZLJ7fI2JwOsX3VvP93iP4mMmit4r7MmaYr4cQY0nPPcL0S7f0OQ64t+qePR
        HbqcSKpA==;
Received: from [190.210.221.22] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgNls-005i4Y-1y;
        Wed, 13 Sep 2023 11:11:01 +0000
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
Subject: [PATCH 11/19] fs: add new shutdown_sb and free_sb methods
Date:   Wed, 13 Sep 2023 08:10:05 -0300
Message-Id: <20230913111013.77623-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913111013.77623-1-hch@lst.de>
References: <20230913111013.77623-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently super_blocks are shut down using the ->kill_sb method, which
must call generic_shutdown_super, but allows the file system to
add extra work before or after the call to generic_shutdown_super.

File systems tend to get rather confused by this, so add an alternative
shutdown sequence where generic_shutdown_super is called by the core
code, and there are extra ->shutdown_sb and ->free_sb hooks before and
after it.  To remove the amount of boilerplate code ->shutdown_sb is only
called if the super has finished initialization and ->d_root is set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/locking.rst |  4 ++++
 Documentation/filesystems/vfs.rst     | 12 ++++++++++++
 fs/super.c                            |  9 +++++++--
 include/linux/fs.h                    |  2 ++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 7be2900806c853..c33e2f03ed1f69 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -220,7 +220,9 @@ prototypes::
 
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
+	void (*shutdown_sb) (struct super_block *);
 	void (*kill_sb) (struct super_block *);
+	void (*free_sb) (struct super_block *);
 
 locking rules:
 
@@ -228,7 +230,9 @@ locking rules:
 ops		may block
 =======		=========
 mount		yes
+shutdown_sb	yes
 kill_sb		yes
+free_sb		yes
 =======		=========
 
 ->mount() returns ERR_PTR or the root dentry; its superblock should be locked
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 99acc2e9867391..1a7c6926c31f34 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -119,7 +119,9 @@ members are defined:
 		const struct fs_parameter_spec *parameters;
 		struct dentry *(*mount) (struct file_system_type *, int,
 			const char *, void *);
+		void (*shutdown_sb) (struct super_block *);
 		void (*kill_sb) (struct super_block *);
+		void (*free_sb) (struct super_block *);
 		struct module *owner;
 		struct file_system_type * next;
 		struct hlist_head fs_supers;
@@ -155,10 +157,20 @@ members are defined:
 	the method to call when a new instance of this filesystem should
 	be mounted
 
+``shutdown_sb``
+	Cleanup after a super_block has reached a zero active count, and before
+	the VFS level cleanup happens.  Typical picks all fs-specific objects
+	(if any) that need destruction out of superblock and releases them.
+	Note: dentries and inodes are normally taken care of and do not need
+	specific handling unless they are pinned by kernel users.
+
 ``kill_sb``
 	the method to call when an instance of this filesystem should be
 	shut down
 
+``free_sb``
+	Free file system specific resources like sb->s_fs_info that are
+	still needed while inodes are freed during umount.
 
 ``owner``
 	for internal VFS use: you should initialize this to THIS_MODULE
diff --git a/fs/super.c b/fs/super.c
index 5c685b4944c2d6..8e173eccc8c113 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -480,10 +480,15 @@ void deactivate_locked_super(struct super_block *s)
 
 	unregister_shrinker(&s->s_shrink);
 
-	if (fs->kill_sb)
+	if (fs->kill_sb) {
 		fs->kill_sb(s);
-	else
+	} else {
+		if (fs->shutdown_sb)
+			fs->shutdown_sb(s);
 		generic_shutdown_super(s);
+		if (fs->free_sb)
+			fs->free_sb(s);
+	}
 
 	kill_super_notify(s);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 31b6b235b36efa..12fff7df3cc46b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2341,6 +2341,8 @@ struct file_system_type {
 	struct dentry *(*mount) (struct file_system_type *, int,
 		       const char *, void *);
 	void (*kill_sb) (struct super_block *);
+	void (*shutdown_sb)(struct super_block *sb);
+	void (*free_sb)(struct super_block *sb);
 	struct module *owner;
 	struct file_system_type * next;
 	struct hlist_head fs_supers;
-- 
2.39.2

