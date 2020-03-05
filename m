Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD617B07A
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 22:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgCEVR0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 16:17:26 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42803 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgCEVQx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 16:16:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 643AF21EAE;
        Thu,  5 Mar 2020 16:16:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 05 Mar 2020 16:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=lc0QBU1yCIerk
        rnOWmO0QlaRB2GRt3K2i1+d3aZJ1TU=; b=sicxL9wmiwBe+sqV6OzjfsxNNC5cM
        OL8PUiuU4z/6bW8GeMnHQ881pNYEpwWhe6Z2c/OYYqPR3PZWsVNl0oUaN53IDV3O
        A+mfezR7QYu0HhReZMgm7PGJxJ5NnYVah2p831BCR5a5ATs8BS7s7nZzM+B9CwOs
        ulNzOkjcCEmr63Z3X/RerQPlwjzAz1PZYZKeWeUfepgzJGxvCu+g4dvWTVwjMAPM
        NJxiVXHOXmmNTBspWj33i53TEVIzm8dtBMMcfzseaWOoh5xBJXgT6xEm2xK7D44a
        8H13tZs0Bb9Mr4AVvc70fq7ocNcLO8V/clPfDm1WJ49Pne0mCS+kjLMbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=lc0QBU1yCIerkrnOWmO0QlaRB2GRt3K2i1+d3aZJ1TU=; b=wGSyBhJA
        WCUrhe9ttgzuIakkGKdTbreNT5uDRVozrEM1batQ7GkcHOOuiVhQ/pKv+8lm6odO
        rsFJNNWTbLCzzfo1fHvIQHsnfGh7PeX6qpir4OY08eJuSt17JQWFSFwSny6Id5pY
        HNclTdYTv+a9PCotBMcYd5bbKckjRr1zL65Pe/2l3tIoAwXZ6qooZGA9XehG9dEQ
        L53ZIeKEnuI6YN4/qW0lDef3FGbIZJpEIYLBizeWp7LA63GI5X+VfRDpEyJEydPw
        drkKoP1uuRlFBVGzGhTUk5/FG0ShrAWL66tgirjaV2AV1o7iHLHmJUWeF4NDMF0o
        jMMPKK8K5uELUQ==
X-ME-Sender: <xms:RGxhXgr7MyroLKM9OUGEBBtgHWgng1RBbtar144XYVALMkErcCSWzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddutddgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrddunecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:RGxhXhKfFQjn00ut7aGJSBO8GtdC2sn-z0uWrICXjZ8kC49XIkAulg>
    <xmx:RGxhXjBqvaDKJekByjba6cT9pKxzBz_nzavNypIku07oFBz3k4E0Gg>
    <xmx:RGxhXk7t1Tov8ZbDhqfqRePsYvhQ5f2OhkaoLbpLGyekhGl0aIitOQ>
    <xmx:RGxhXpp3kOE_cT3ImiSmz0agYXAHDAjDh2DcpezUvRMkpO5wzLPa7Q>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id 38F9D3060BD1;
        Thu,  5 Mar 2020 16:16:51 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        kernel-team@fb.com
Subject: [PATCH v2 2/4] kernfs: Add removed_size out param for simple_xattr_set
Date:   Thu,  5 Mar 2020 13:16:30 -0800
Message-Id: <20200305211632.15369-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200305211632.15369-1-dxu@dxuuu.xyz>
References: <20200305211632.15369-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This helps set up size accounting in the next commit. Without this out
param, it's difficult to find out the removed xattr size without taking
a lock for longer and walking the xattr linked list twice.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/kernfs/inode.c     |  2 +-
 fs/xattr.c            | 11 ++++++++++-
 include/linux/xattr.h |  3 ++-
 mm/shmem.c            |  2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index d0f7a5abd9a9..5f10ae95fbfa 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -303,7 +303,7 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_set(&attrs->xattrs, name, value, size, flags);
+	return simple_xattr_set(&attrs->xattrs, name, value, size, flags, NULL);
 }
 
 static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
diff --git a/fs/xattr.c b/fs/xattr.c
index 0d3c9b4d1914..e13265e65871 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -860,6 +860,7 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
  * @value: value of the xattr. If %NULL, will remove the attribute.
  * @size: size of the new xattr
  * @flags: %XATTR_{CREATE|REPLACE}
+ * @removed_size: returns size of the removed xattr, -1 if none removed
  *
  * %XATTR_CREATE is set, the xattr shouldn't exist already; otherwise fails
  * with -EEXIST.  If %XATTR_REPLACE is set, the xattr should exist;
@@ -868,7 +869,8 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
  * Returns 0 on success, -errno on failure.
  */
 int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
-		     const void *value, size_t size, int flags)
+		     const void *value, size_t size, int flags,
+		     ssize_t *removed_size)
 {
 	struct simple_xattr *xattr;
 	struct simple_xattr *new_xattr = NULL;
@@ -895,8 +897,12 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 				err = -EEXIST;
 			} else if (new_xattr) {
 				list_replace(&xattr->list, &new_xattr->list);
+				if (removed_size)
+					*removed_size = xattr->size;
 			} else {
 				list_del(&xattr->list);
+				if (removed_size)
+					*removed_size = xattr->size;
 			}
 			goto out;
 		}
@@ -908,6 +914,9 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		list_add(&new_xattr->list, &xattrs->head);
 		xattr = NULL;
 	}
+
+	if (removed_size)
+		*removed_size = -1;
 out:
 	spin_unlock(&xattrs->lock);
 	if (xattr) {
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 6dad031be3c2..4cf6e11f4a3c 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -102,7 +102,8 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
 int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		     void *buffer, size_t size);
 int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
-		     const void *value, size_t size, int flags);
+		     const void *value, size_t size, int flags,
+		     ssize_t *removed_size);
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs, char *buffer,
 			  size_t size);
 void simple_xattr_list_add(struct simple_xattrs *xattrs,
diff --git a/mm/shmem.c b/mm/shmem.c
index aad3ba74b0e9..f47347cb30f6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3243,7 +3243,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
 	name = xattr_full_name(handler, name);
-	return simple_xattr_set(&info->xattrs, name, value, size, flags);
+	return simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
 }
 
 static const struct xattr_handler shmem_security_xattr_handler = {
-- 
2.21.1

