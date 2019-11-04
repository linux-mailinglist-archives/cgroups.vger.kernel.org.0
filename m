Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A636FEF192
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfKEAA0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 19:00:26 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44739 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfKEAAG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 19:00:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id o11so21680981qtr.11;
        Mon, 04 Nov 2019 16:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6eyC/Pr88JMkuUtE27lkcLMpRj73Ok1FRh3V2w/GO4I=;
        b=Q62vHfUhNt9gVSAnEvcyM8ffDXH8NhSIP3TqMk1IR19FwUBSa2gzv/2wfMDbMifc9H
         F+qLKdXYhgWGXSHtzTNJJwJi66burHZmdJ8PcQSmyfrLXkJp1LQ4W1+yayNvceoV5g8+
         uPW5TKW31CyyOARzDfc/1YHDXJkUQjsgSB6uf/743I3dTQXLu+3z5GTdmc0ZuNQeDuFw
         ojaHyff3gkoH3T5F0PCF1nBR68waleyWMp332PeCJmaaY5G/NNUAkzN5cLzG7G2cXTOh
         yyBke9TrRCMbslN7hYaNX4VbgPGetx5F/ZnhEbCWl/dhpZl17Rqwz2hnBeZamkvGtSz2
         uxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=6eyC/Pr88JMkuUtE27lkcLMpRj73Ok1FRh3V2w/GO4I=;
        b=fgiw5bdAhvdia/chUGerTmIV8yORsFgVTtEzUDNXt6Prlm//dGTeEJ6lq9CQ+MhrGH
         tbM/iv9PRcfcVV85x0elqhwt8vlFs9EEojhaMh+oGienwz2q3bCfcLdd6tiWTshJBoAx
         EspdoXfiyQVn1E/HsiRXOwFjkg9cNyLJKeLcaQ7NUl20V5LVAWnOlaIOlLsFVhZeUjfh
         I/+Fr7SDrsGbrgSc/Zq9gP5xwYgd0k3r8muwYNtsYYREY5ypjtFJWpQHMjnIoKGRkiZR
         TrySZZ7U7uO53Z/6ErG8T4rVftvWROv9oTz0MFUqEjwY22bwR2x2/wf0Z6t8NznCgGtk
         yg6A==
X-Gm-Message-State: APjAAAX7sAX6Y/wudC5gfkUIAt0N4K3IlvXwtaUSibC6pIfDRhFMr/Fw
        i2oADpqUSPfUigauKr8vHes=
X-Google-Smtp-Source: APXvYqwMOowYbfqcEt7HQhErzj+/VzZqJo2tdAfrBwTa7oxt4o0Ta1UOuIgqSHiYLnxxTC9T6CQ1/w==
X-Received: by 2002:ac8:698d:: with SMTP id o13mr15046753qtq.68.1572912005208;
        Mon, 04 Nov 2019 16:00:05 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id o76sm5236178qke.135.2019.11.04.16.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 16:00:04 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/10] kernfs: implement custom exportfs ops and fid type
Date:   Mon,  4 Nov 2019 15:59:42 -0800
Message-Id: <20191104235944.3470866-9-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current kernfs exportfs implementation uses the generic_fh_*()
helpers and FILEID_INO32_GEN[_PARENT] which limits ino to 32bits.
Let's implement custom exportfs operations and fid type to remove the
restriction.

* FILEID_KERNFS is a single u64 value whose content is
  kernfs_node->id.  This is the only native fid type.

* For backward compatibility with blk_log_action() path which exposes
  (ino,gen) pairs which userland assembles into FILEID_INO32_GEN keys,
  combine the generic keys into 64bit IDs in the same order.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 fs/kernfs/mount.c        | 77 +++++++++++++++++++++++++++++++---------
 include/linux/exportfs.h |  5 +++
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 8aed2cccd002..37a1e5df117a 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -53,40 +53,84 @@ const struct super_operations kernfs_sops = {
 	.show_path	= kernfs_sop_show_path,
 };
 
-static struct inode *kernfs_fh_get_inode(struct super_block *sb,
-		u64 ino, u32 generation)
+static int kernfs_encode_fh(struct inode *inode, __u32 *fh, int *max_len,
+			    struct inode *parent)
+{
+	struct kernfs_node *kn = inode->i_private;
+
+	if (*max_len < 2) {
+		*max_len = 2;
+		return FILEID_INVALID;
+	}
+
+	*max_len = 2;
+	*(u64 *)fh = kn->id;
+	return FILEID_KERNFS;
+}
+
+static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
+					    struct fid *fid, int fh_len,
+					    int fh_type, bool get_parent)
 {
 	struct kernfs_super_info *info = kernfs_info(sb);
-	struct inode *inode;
 	struct kernfs_node *kn;
+	struct inode *inode;
+	u64 id;
 
-	if (ino == 0)
-		return ERR_PTR(-ESTALE);
+	if (fh_len < 2)
+		return NULL;
+
+	switch (fh_type) {
+	case FILEID_KERNFS:
+		id = *(u64 *)fid;
+		break;
+	case FILEID_INO32_GEN:
+	case FILEID_INO32_GEN_PARENT:
+		/*
+		 * blk_log_action() exposes (ino,gen) pair without type and
+		 * userland can call us with generic fid constructed from
+		 * them.  Combine it back to ID.  See blk_log_action().
+		 */
+		id = ((u64)fid->i32.gen << 32) | fid->i32.ino;
+		break;
+	default:
+		return NULL;
+	}
 
-	kn = kernfs_find_and_get_node_by_id(info->root,
-					    ino | ((u64)generation << 32));
+	kn = kernfs_find_and_get_node_by_id(info->root, id);
 	if (!kn)
 		return ERR_PTR(-ESTALE);
+
+	if (get_parent) {
+		struct kernfs_node *parent;
+
+		parent = kernfs_get_parent(kn);
+		kernfs_put(kn);
+		kn = parent;
+		if (!kn)
+			return ERR_PTR(-ESTALE);
+	}
+
 	inode = kernfs_get_inode(sb, kn);
 	kernfs_put(kn);
 	if (!inode)
 		return ERR_PTR(-ESTALE);
 
-	return inode;
+	return d_obtain_alias(inode);
 }
 
-static struct dentry *kernfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
-		int fh_len, int fh_type)
+static struct dentry *kernfs_fh_to_dentry(struct super_block *sb,
+					  struct fid *fid, int fh_len,
+					  int fh_type)
 {
-	return generic_fh_to_dentry(sb, fid, fh_len, fh_type,
-				    kernfs_fh_get_inode);
+	return __kernfs_fh_to_dentry(sb, fid, fh_len, fh_type, false);
 }
 
-static struct dentry *kernfs_fh_to_parent(struct super_block *sb, struct fid *fid,
-		int fh_len, int fh_type)
+static struct dentry *kernfs_fh_to_parent(struct super_block *sb,
+					  struct fid *fid, int fh_len,
+					  int fh_type)
 {
-	return generic_fh_to_parent(sb, fid, fh_len, fh_type,
-				    kernfs_fh_get_inode);
+	return __kernfs_fh_to_dentry(sb, fid, fh_len, fh_type, true);
 }
 
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
@@ -97,6 +141,7 @@ static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 }
 
 static const struct export_operations kernfs_export_ops = {
+	.encode_fh	= kernfs_encode_fh,
 	.fh_to_dentry	= kernfs_fh_to_dentry,
 	.fh_to_parent	= kernfs_fh_to_parent,
 	.get_parent	= kernfs_get_parent_dentry,
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index cf6571fc9c01..d896b8657085 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -104,6 +104,11 @@ enum fid_type {
 	 */
 	FILEID_LUSTRE = 0x97,
 
+	/*
+	 * 64 bit unique kernfs id
+	 */
+	FILEID_KERNFS = 0xfe,
+
 	/*
 	 * Filesystems must not use 0xff file ID.
 	 */
-- 
2.17.1

