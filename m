Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0190F14572
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 09:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfEFHlF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 03:41:05 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58265 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725851AbfEFHlF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 03:41:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TR.iKh7_1557128462;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TR.iKh7_1557128462)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 06 May 2019 15:41:02 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     cgroups@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc:     miklos@szeredi.hu, amir73il@gmail.com, joseph.qi@linux.alibaba.com
Subject: [PATCH] overlayfs: check the capability before cred overridden
Date:   Mon,  6 May 2019 15:41:02 +0800
Message-Id: <20190506074102.87444-1-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We found that it return success when we set IMMUTABLE_FL flag to a
file in docker even though the docker didn't have the capability
CAP_LINUX_IMMUTABLE.

The commit d1d04ef8572b ("ovl: stack file ops") and
dab5ca8fd9dd ("ovl: add lsattr/chattr support") implemented chattr
operations on a regular overlay file. ovl_real_ioctl() overridden the
current process's subjective credentials with ofs->creator_cred which
have the capability CAP_LINUX_IMMUTABLE so that it will return success
in vfs_ioctl()->cap_capable().

Fix this by checking the capability before cred overriden. And here we
only care about APPEND_FL and IMMUTABLE_FL, so get these information from
inode.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 fs/overlayfs/file.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 84dd957efa24..fecf1b43b6fe 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -11,6 +11,7 @@
 #include <linux/mount.h>
 #include <linux/xattr.h>
 #include <linux/uio.h>
+#include <linux/uaccess.h>
 #include "overlayfs.h"
 
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
@@ -372,10 +373,30 @@ static long ovl_real_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
+static unsigned int ovl_get_inode_flags(struct inode *inode)
+{
+	unsigned int flags = READ_ONCE(inode->i_flags);
+	unsigned int ovl_iflags = 0;
+
+	if (flags & S_SYNC)
+		ovl_iflags |= FS_SYNC_FL;
+	if (flags & S_APPEND)
+		ovl_iflags |= FS_APPEND_FL;
+	if (flags & S_IMMUTABLE)
+		ovl_iflags |= FS_IMMUTABLE_FL;
+	if (flags & S_NOATIME)
+		ovl_iflags |= FS_NOATIME_FL;
+	if (flags & S_DIRSYNC)
+		ovl_iflags |= FS_DIRSYNC_FL;
+
+	return ovl_iflags;
+}
+
 static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	long ret;
 	struct inode *inode = file_inode(file);
+	unsigned int flags;
 
 	switch (cmd) {
 	case FS_IOC_GETFLAGS:
@@ -386,6 +407,15 @@ static long ovl_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (!inode_owner_or_capable(inode))
 			return -EACCES;
 
+		if (get_user(flags, (int __user *) arg))
+			return -EFAULT;
+
+		/* Check the capability before cred overridden */
+		if ((flags ^ ovl_get_inode_flags(inode)) & (FS_APPEND_FL | FS_IMMUTABLE_FL)) {
+			if (!capable(CAP_LINUX_IMMUTABLE))
+				return -EPERM;
+		}
+
 		ret = mnt_want_write_file(file);
 		if (ret)
 			return ret;
-- 
2.19.1.856.g8858448bb

