Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43028EF18D
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbfKEAAK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 19:00:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45760 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbfKEAAK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 19:00:10 -0500
Received: by mail-qt1-f195.google.com with SMTP id x21so26706500qto.12;
        Mon, 04 Nov 2019 16:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XPYZ0mNyZl/fqJ5vfJ4SvDbyeARU8d5elmgmMrOSfQs=;
        b=uze77c+vUcDhal08F365Cm+p3myJXZkEyPekY30oC7aqdckrGtICcZdRi/0/YnfE2G
         go0wZwIcR+cfxwK4LYloyBtOU9sswaaMgOI8/LNAeanVMacr/O5skNHbgS1bTsUMOZeb
         +xkbvqHIZpybie4LnWukW5oNjZBc9kfKFt6wguJRRrBCBFGOvnfclZUnkfC2/3uBr/8z
         wUPEl9R7Q5Cz0T8lFwwFEh2JhJuzAAoZyEVN1AY6ibGYbLcQMxvFKuBWEMxHOSnFyVPZ
         AFnPHxTLc3ryT0EOgAG5gaYsUcmCIEuBQ6b4RAUI3CQ+Prsd5NtKq3ymncMRUdLlKfMp
         QCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XPYZ0mNyZl/fqJ5vfJ4SvDbyeARU8d5elmgmMrOSfQs=;
        b=BbfRhIzPbzplWLZTDI5t5ny7nPqFUyQO5xAENmkF+V+KWAFXJYpIFkIqB3b1eyzM8q
         cuyORwLQocS4UY4qP/s930Jd3pUH/1vQSLcJDsPDF0dunCQd5jBVML980T/wIXxzqo2d
         8mNWW45EWuh2bCCglYOr5w6zV53mSHQDchqkMwAlgxEzFOYWxjVZ6zYPkifEztXgbDl0
         2UG4EwuAQj6d9KxEQEcrO2uDTTlf0yGZjOANO9OgQ9c0iY3teX95d2eEGNK4zOI9FYRb
         MMGmrz0Xi70J2c/1cb8HVRW1xOlKKKaM2NC/U8YPyskuvhwcEsc1JJXJmUIB/x/Rk3jd
         lStg==
X-Gm-Message-State: APjAAAVb2jxZE34oVZ8BmqsZ9fa0YvUSVIBVJu+hC9zZdktlap89sg1Q
        TSY3kre9gPX72SfFQpSHVbo=
X-Google-Smtp-Source: APXvYqysVA+xQBxKCfj8E513JJdaKFFORgiKplkIO6jFzJm8SknfTQkbBe4ImdefEPl6WiVkZ6cyrg==
X-Received: by 2002:aed:33c2:: with SMTP id v60mr11955633qtd.168.1572912007267;
        Mon, 04 Nov 2019 16:00:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id j4sm8766949qkf.116.2019.11.04.16.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 16:00:06 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/10] kernfs: use 64bit inos if ino_t is 64bit
Date:   Mon,  4 Nov 2019 15:59:43 -0800
Message-Id: <20191104235944.3470866-10-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Each kernfs_node is identified with a 64bit ID.  The low 32bit is
exposed as ino and the high gen.  While this already allows using inos
as keys by looking up with wildcard generation number of 0, it's
adding unnecessary complications for 64bit ino archs which can
directly use kernfs_node IDs as inos to uniquely identify each cgroup
instance.

This patch exposes IDs directly as inos on 64bit ino archs.  The
conversion is mostly straight-forward.

* 32bit ino archs behave the same as before.  64bit ino archs now use
  the whole 64bit ID as ino and the generation number is fixed at 1.

* 64bit inos still use the same idr allocator which gurantees that the
  lower 32bits identify the current live instance uniquely and the
  high 32bits are incremented whenever the low bits wrap.  As the
  upper 32bits are no longer used as gen and we don't wanna start ino
  allocation with 33rd bit set, the initial value for highbits
  allocation is changed to 0 on 64bit ino archs.

* blktrace exposes two 32bit numbers - (INO,GEN) pair - to identify
  the issuing cgroup.  Userland builds FILEID_INO32_GEN fids from
  these numbers to look up the cgroups.  To remain compatible with the
  behavior, always output (LOW32,HIGH32) which will be constructed
  back to the original 64bit ID by __kernfs_fh_to_dentry().

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 fs/kernfs/dir.c         | 42 ++++++++++++++++++++++++++++-------------
 fs/kernfs/mount.c       |  7 ++++---
 include/linux/kernfs.h  | 20 ++++++++++++++------
 kernel/trace/blktrace.c | 21 +++++++++++++++++----
 4 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5dcf19d4adbc..b2d9f79c4a7c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -532,7 +532,7 @@ void kernfs_put(struct kernfs_node *kn)
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
 	spin_lock(&kernfs_idr_lock);
-	idr_remove(&root->ino_idr, kernfs_ino(kn));
+	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
 	spin_unlock(&kernfs_idr_lock);
 	kmem_cache_free(kernfs_node_cache, kn);
 
@@ -617,7 +617,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 					     unsigned flags)
 {
 	struct kernfs_node *kn;
-	u32 gen;
+	u32 id_highbits;
 	int ret;
 
 	name = kstrdup_const(name, GFP_KERNEL);
@@ -631,16 +631,16 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&kernfs_idr_lock);
 	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
-	if (ret >= 0 && ret < root->last_ino)
-		root->next_generation++;
-	gen = root->next_generation;
-	root->last_ino = ret;
+	if (ret >= 0 && ret < root->last_id_lowbits)
+		root->id_highbits++;
+	id_highbits = root->id_highbits;
+	root->last_id_lowbits = ret;
 	spin_unlock(&kernfs_idr_lock);
 	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
 
-	kn->id = (u64)gen << 32 | ret;
+	kn->id = (u64)id_highbits << 32 | ret;
 
 	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
@@ -671,7 +671,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	return kn;
 
  err_out3:
-	idr_remove(&root->ino_idr, kernfs_ino(kn));
+	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
  err_out2:
 	kmem_cache_free(kernfs_node_cache, kn);
  err_out1:
@@ -715,13 +715,19 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 
 	spin_lock(&kernfs_idr_lock);
 
-	kn = idr_find(&root->ino_idr, ino);
+	kn = idr_find(&root->ino_idr, (u32)ino);
 	if (!kn)
 		goto err_unlock;
 
-	/* 0 matches all generations */
-	if (unlikely(gen && kernfs_gen(kn) != gen))
-		goto err_unlock;
+	if (sizeof(ino_t) >= sizeof(u64)) {
+		/* we looked up with the low 32bits, compare the whole */
+		if (kernfs_ino(kn) != ino)
+			goto err_unlock;
+	} else {
+		/* 0 matches all generations */
+		if (unlikely(gen && kernfs_gen(kn) != gen))
+			goto err_unlock;
+	}
 
 	/*
 	 * ACTIVATED is protected with kernfs_mutex but it was clear when
@@ -949,7 +955,17 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 
 	idr_init(&root->ino_idr);
 	INIT_LIST_HEAD(&root->supers);
-	root->next_generation = 1;
+
+	/*
+	 * On 64bit ino setups, id is ino.  On 32bit, low 32bits are ino.
+	 * High bits generation.  The starting value for both ino and
+	 * genenration is 1.  Initialize upper 32bit allocation
+	 * accordingly.
+	 */
+	if (sizeof(ino_t) >= sizeof(u64))
+		root->id_highbits = 0;
+	else
+		root->id_highbits = 1;
 
 	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
 			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 37a1e5df117a..4d31503abaee 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -87,9 +87,10 @@ static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
 	case FILEID_INO32_GEN:
 	case FILEID_INO32_GEN_PARENT:
 		/*
-		 * blk_log_action() exposes (ino,gen) pair without type and
-		 * userland can call us with generic fid constructed from
-		 * them.  Combine it back to ID.  See blk_log_action().
+		 * blk_log_action() exposes "LOW32,HIGH32" pair without
+		 * type and userland can call us with generic fid
+		 * constructed from them.  Combine it back to ID.  See
+		 * blk_log_action().
 		 */
 		id = ((u64)fid->i32.gen << 32) | fid->i32.ino;
 		break;
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 38267cc9420c..dded2e5a9f42 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -141,8 +141,8 @@ struct kernfs_node {
 	void			*priv;
 
 	/*
-	 * 64bit unique ID.  Lower 32bits carry the inode number and lower
-	 * generation.
+	 * 64bit unique ID.  On 64bit ino setups, id is the ino.  On 32bit,
+	 * the low 32bits are ino and upper generation.
 	 */
 	u64			id;
 
@@ -177,8 +177,8 @@ struct kernfs_root {
 
 	/* private fields, do not use outside kernfs proper */
 	struct idr		ino_idr;
-	u32			last_ino;
-	u32			next_generation;
+	u32			last_id_lowbits;
+	u32			id_highbits;
 	struct kernfs_syscall_ops *syscall_ops;
 
 	/* list of kernfs_super_info of this root, protected by kernfs_mutex */
@@ -284,12 +284,20 @@ static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
 
 static inline ino_t kernfs_id_ino(u64 id)
 {
-	return (u32)id;
+	/* id is ino if ino_t is 64bit; otherwise, low 32bits */
+	if (sizeof(ino_t) >= sizeof(u64))
+		return id;
+	else
+		return (u32)id;
 }
 
 static inline u32 kernfs_id_gen(u64 id)
 {
-	return id >> 32;
+	/* gen is fixed at 1 if ino_t is 64bit; otherwise, high 32bits */
+	if (sizeof(ino_t) >= sizeof(u64))
+		return 1;
+	else
+		return id >> 32;
 }
 
 static inline ino_t kernfs_ino(struct kernfs_node *kn)
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a986d2e74ca2..a7dac5b63f3f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1261,12 +1261,25 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 			trace_seq_printf(&iter->seq, "%3d,%-3d %s %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device),
 				 blkcg_name_buf, act, rwbs);
-		} else
+		} else {
+			/*
+			 * The cgid portion used to be "INO,GEN".  Userland
+			 * builds a FILEID_INO32_GEN fid out of them and
+			 * opens the cgroup using open_by_handle_at(2).
+			 * While 32bit ino setups are still the same, 64bit
+			 * ones now use the 64bit ino as the whole ID and
+			 * no longer use generation.
+			 *
+			 * Regarldess of the content, always output
+			 * "LOW32,HIGH32" so that FILEID_INO32_GEN fid can
+			 * be mapped back to @id on both 64 and 32bit ino
+			 * setups.  See __kernfs_fh_to_dentry().
+			 */
 			trace_seq_printf(&iter->seq,
-				 "%3d,%-3d %lx,%-x %2s %3s ",
+				 "%3d,%-3d %llx,%-llx %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device),
-				 kernfs_id_ino(id), kernfs_id_gen(id),
-				 act, rwbs);
+				 id & U32_MAX, id >> 32, act, rwbs);
+		}
 	} else
 		trace_seq_printf(&iter->seq, "%3d,%-3d %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device), act, rwbs);
-- 
2.17.1

