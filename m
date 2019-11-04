Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D36A8EF188
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfKEAAG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 19:00:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45605 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbfKEAAG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 19:00:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id q70so19451555qke.12;
        Mon, 04 Nov 2019 16:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QraoHZsGuroqETynPvsAI0rLlsKuBbiPFCIw5st0qQ=;
        b=ZiqnWjuPIAZ7ywT4Ri+4vWI657wRjpF4Ite2x+tF2eGlTdXIeeAeoBL7LgclTVB4ej
         wJGFCbzyiy77TkaCN8bzDdRAkGLlyOPv8ne/ICbMQOe6OkKLDobq1EaMy0g+yMSyafKa
         tFuz9Ll0yYJn3aME22aTzMzziXc+qN2OI0yRX8Jqee1mKzzkyH6Pcd+3xnvCznmzw3bA
         8JcKxdHgAbGrW20W74sc94jZ2PvLUVXw05Xq+bLC/cQQVTZIbTrWtCvuBJp59ZRby5Dp
         P7WUGpWi9Lq4Tc5wRGjCueRsLMDqaF4cKBRR1FTB4ZrIWafjv7+BYA67IS9URQfJzcKf
         rJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3QraoHZsGuroqETynPvsAI0rLlsKuBbiPFCIw5st0qQ=;
        b=jqN0oJK/ITLqlBM/q16kOdRAqcasmOvalukzBTrXF0s77ao+JjbhatdK7LjOGJNMbr
         f8R9zy8XdWbQsqBtz/nntale7+1saCgUAhY3oQn+0w4bG9+ncxp06qIxnlmAy20NqwRO
         iKC6lJ7ZW1+1UvWORJuItEtaK2ALdWuH0+EJIarBeuAw9EP6MenDWQnCPCc9CTkPh8hn
         iaqLB7IA0Eu6/N+dcbVxHrr72T2cdzBHXq/bgjyV7547IAPYCypOjxBljIOvD5Sde2To
         c8X9fER0KM2j2i07v9QOLuEONUsEEfCac+cJQ8kOCrHLxUzTMqrrb0R+h8yz4pQzQ06l
         K9ig==
X-Gm-Message-State: APjAAAW8685Iua1/HEmNhxCZWiwiJBNKLllSvcNH+Fa0UzisVhokuo0o
        ZrEVgFDEp3oNw19/KX0xB5bGPpxi
X-Google-Smtp-Source: APXvYqweLcU0gy5OrSdsvyXBAPEq7AWdQXpFjWYDSi1lWvgYNzt2L9FqxSnwrqHfSavYfLUtr8XPIw==
X-Received: by 2002:a05:620a:a0e:: with SMTP id i14mr1642396qka.3.1572912003066;
        Mon, 04 Nov 2019 16:00:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id a70sm6087773qkb.86.2019.11.04.16.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 16:00:02 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/10] kernfs: combine ino/id lookup functions into kernfs_find_and_get_node_by_id()
Date:   Mon,  4 Nov 2019 15:59:41 -0800
Message-Id: <20191104235944.3470866-8-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kernfs_find_and_get_node_by_ino() looks the kernfs_node matching the
specified ino.  On top of that, kernfs_get_node_by_id() and
kernfs_fh_get_inode() implement full ID matching by testing the rest
of ID.

On surface, confusingly, the two are slightly different in that the
latter uses 0 gen as wildcard while the former doesn't - does it mean
that the latter can't uniquely identify inodes w/ 0 gen?  In practice,
this is a distinction without a difference because generation number
starts at 1.  There are no actual IDs with 0 gen, so it can always
safely used as wildcard.

Let's simplify the code by renaming kernfs_find_and_get_node_by_ino()
to kernfs_find_and_get_node_by_id(), moving all lookup logics into it,
and removing now unnecessary kernfs_get_node_by_id().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/dir.c             | 17 +++++++++++++----
 fs/kernfs/kernfs-internal.h |  2 --
 fs/kernfs/mount.c           | 26 ++------------------------
 include/linux/kernfs.h      |  3 ++-
 kernel/cgroup/cgroup.c      |  2 +-
 5 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index c67afb591e5b..5dcf19d4adbc 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -696,17 +696,22 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 }
 
 /*
- * kernfs_find_and_get_node_by_ino - get kernfs_node from inode number
+ * kernfs_find_and_get_node_by_id - get kernfs_node from node id
  * @root: the kernfs root
- * @ino: inode number
+ * @id: the target node id
+ *
+ * @id's lower 32bits encode ino and upper gen.  If the gen portion is
+ * zero, all generations are matched.
  *
  * RETURNS:
  * NULL on failure. Return a kernfs node with reference counter incremented
  */
-struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
-						    unsigned int ino)
+struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
+						   u64 id)
 {
 	struct kernfs_node *kn;
+	ino_t ino = kernfs_id_ino(id);
+	u32 gen = kernfs_id_gen(id);
 
 	spin_lock(&kernfs_idr_lock);
 
@@ -714,6 +719,10 @@ struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
 	if (!kn)
 		goto err_unlock;
 
+	/* 0 matches all generations */
+	if (unlikely(gen && kernfs_gen(kn) != gen))
+		goto err_unlock;
+
 	/*
 	 * ACTIVATED is protected with kernfs_mutex but it was clear when
 	 * @kn was added to idr and we just wanna see it set.  No need to
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 02ce570a9a3c..2f3c51d55261 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -109,8 +109,6 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
 				    kuid_t uid, kgid_t gid,
 				    unsigned flags);
-struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
-						    unsigned int ino);
 
 /*
  * file.c
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index f05d5d6f926d..8aed2cccd002 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -53,24 +53,6 @@ const struct super_operations kernfs_sops = {
 	.show_path	= kernfs_sop_show_path,
 };
 
-/*
- * Similar to kernfs_fh_get_inode, this one gets kernfs node from inode
- * number and generation
- */
-struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root, u64 id)
-{
-	struct kernfs_node *kn;
-
-	kn = kernfs_find_and_get_node_by_ino(root, kernfs_id_ino(id));
-	if (!kn)
-		return NULL;
-	if (kernfs_gen(kn) != kernfs_id_gen(id)) {
-		kernfs_put(kn);
-		return NULL;
-	}
-	return kn;
-}
-
 static struct inode *kernfs_fh_get_inode(struct super_block *sb,
 		u64 ino, u32 generation)
 {
@@ -81,7 +63,8 @@ static struct inode *kernfs_fh_get_inode(struct super_block *sb,
 	if (ino == 0)
 		return ERR_PTR(-ESTALE);
 
-	kn = kernfs_find_and_get_node_by_ino(info->root, ino);
+	kn = kernfs_find_and_get_node_by_id(info->root,
+					    ino | ((u64)generation << 32));
 	if (!kn)
 		return ERR_PTR(-ESTALE);
 	inode = kernfs_get_inode(sb, kn);
@@ -89,11 +72,6 @@ static struct inode *kernfs_fh_get_inode(struct super_block *sb,
 	if (!inode)
 		return ERR_PTR(-ESTALE);
 
-	if (generation && inode->i_generation != generation) {
-		/* we didn't find the right inode.. */
-		iput(inode);
-		return ERR_PTR(-ESTALE);
-	}
 	return inode;
 }
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index b2fc5c8ef6d9..38267cc9420c 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -393,7 +393,8 @@ void kernfs_kill_sb(struct super_block *sb);
 
 void kernfs_init(void);
 
-struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root, u64 id);
+struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
+						   u64 id);
 #else	/* CONFIG_KERNFS */
 
 static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c6bd1a5a1977..b5dcbee5aa6c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5790,7 +5790,7 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 {
 	struct kernfs_node *kn;
 
-	kn = kernfs_get_node_by_id(cgrp_dfl_root.kf_root, id);
+	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
 	if (!kn)
 		return;
 	kernfs_path(kn, buf, buflen);
-- 
2.17.1

