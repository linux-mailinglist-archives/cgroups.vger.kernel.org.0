Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95008EF183
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfKDX77 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 18:59:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42208 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730163AbfKDX76 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 18:59:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id t20so11110873qtn.9;
        Mon, 04 Nov 2019 15:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XdS82XwKAJYAYf10xCxmrjEq7ZEr5zc2RbCuNFEXBSg=;
        b=W5IM6QSOl7ZvVzqGEhgoW0e6Bac4W/+Jhu72ASMECsFDNyiqxQgjYKeKHpAN6z3YRd
         Z53IOJvoECiXq6AxjGYouP+1aU+1zIQ4VEEtCPCcaOrCzEfk9qRvQZgEsih90dM5IRkS
         bSN3zMvYleoXtt+ASxJx+21/R6kJI7wd+pxAMd+DhS1a3+PrGVzGvlYxwU9ZhqI4rfRO
         AJ0Q/xdIOcOGarTYPzAA+JhVnn9wnzVOyLlfoRwoE40UQs79un8RObydw/yYnlW1Ux3I
         005AGNJKIfFwHfTbIh69ymRRLwHxS3RHgWLea7GOs7nJFk2jnOAieNAltI6yqNmr6q95
         jK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XdS82XwKAJYAYf10xCxmrjEq7ZEr5zc2RbCuNFEXBSg=;
        b=m2x3p8ZXZjND8qGpidkxJu+QLLmAy0/iBbVI1eF95I2cuSnPO+OQLTYUapInrZBCE6
         h1EFDRoZdAh4gc/VjbhtuftJKJ7Ru6Di9wwfuZO+1DY53jHJiQXAuYM1zAFJ61fXFPsC
         WgTNSSymKwgoCOiUnLX2T3iKVnMiad04/4WTTbZiXhRdpCas0qR0oEOZFPrFW3NX8jY5
         i/OmzW1G6Hcxr3JjYfYosygn/xfF53W3O4AojQFPqltE+MRUvcbVoTAuYTEzogZAgUID
         9PE9AUBl6RYlmtX8F1ioOiEHdjjcOBn5L5TIiq3rFlE/uvvaOXGm8zm6dBezoorU9vbf
         +JeA==
X-Gm-Message-State: APjAAAUY4UORdpElGppxyU2rz4S6zrcGlVaTiE33dJrC+0Ph/Mj/yPk4
        OJhVOzsgIgZfI+u2pmggmGY=
X-Google-Smtp-Source: APXvYqxEuQg3E3Db0k2idBpbHi+8qlgkCkrUKbEx3H+nko2pBZNw6WPFnEY7mKjBy1Qvo0jehOZNvA==
X-Received: by 2002:ac8:424d:: with SMTP id r13mr15370286qtm.111.1572911997060;
        Mon, 04 Nov 2019 15:59:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id o195sm9509979qke.35.2019.11.04.15.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 15:59:56 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/10] kernfs: use dumber locking for kernfs_find_and_get_node_by_ino()
Date:   Mon,  4 Nov 2019 15:59:38 -0800
Message-Id: <20191104235944.3470866-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

kernfs_find_and_get_node_by_ino() uses RCU protection.  It's currently
a bit buggy because it can look up a node which hasn't been activated
yet and thus may end up exposing a node that the kernfs user is still
prepping.

While it can be fixed by pushing it further in the current direction,
it's already complicated and isn't clear whether the complexity is
justified.  The main use of kernfs_find_and_get_node_by_ino() is for
exportfs operations.  They aren't super hot and all the follow-up
operations (e.g. mapping to path) use normal locking anyway.

Let's switch to a dumber locking scheme and protect the lookup with
kernfs_idr_lock.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
---
 fs/kernfs/dir.c   | 45 +++++++++------------------------------------
 fs/kernfs/mount.c | 11 +----------
 2 files changed, 10 insertions(+), 46 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 7d4af6cea2a6..798f0f03b62b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -508,10 +508,6 @@ void kernfs_put(struct kernfs_node *kn)
 	struct kernfs_node *parent;
 	struct kernfs_root *root;
 
-	/*
-	 * kernfs_node is freed with ->count 0, kernfs_find_and_get_node_by_ino
-	 * depends on this to filter reused stale node
-	 */
 	if (!kn || !atomic_dec_and_test(&kn->count))
 		return;
 	root = kernfs_root(kn);
@@ -646,11 +642,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn->id.ino = ret;
 	kn->id.generation = gen;
 
-	/*
-	 * set ino first. This RELEASE is paired with atomic_inc_not_zero in
-	 * kernfs_find_and_get_node_by_ino
-	 */
-	atomic_set_release(&kn->count, 1);
+	atomic_set(&kn->count, 1);
 	atomic_set(&kn->active, KN_DEACTIVATED_BIAS);
 	RB_CLEAR_NODE(&kn->rb);
 
@@ -716,38 +708,19 @@ struct kernfs_node *kernfs_find_and_get_node_by_ino(struct kernfs_root *root,
 {
 	struct kernfs_node *kn;
 
-	rcu_read_lock();
+	spin_lock(&kernfs_idr_lock);
+
 	kn = idr_find(&root->ino_idr, ino);
 	if (!kn)
-		goto out;
+		goto err_unlock;
 
-	/*
-	 * Since kernfs_node is freed in RCU, it's possible an old node for ino
-	 * is freed, but reused before RCU grace period. But a freed node (see
-	 * kernfs_put) or an incompletedly initialized node (see
-	 * __kernfs_new_node) should have 'count' 0. We can use this fact to
-	 * filter out such node.
-	 */
-	if (!atomic_inc_not_zero(&kn->count)) {
-		kn = NULL;
-		goto out;
-	}
-
-	/*
-	 * The node could be a new node or a reused node. If it's a new node,
-	 * we are ok. If it's reused because of RCU (because of
-	 * SLAB_TYPESAFE_BY_RCU), the __kernfs_new_node always sets its 'ino'
-	 * before 'count'. So if 'count' is uptodate, 'ino' should be uptodate,
-	 * hence we can use 'ino' to filter stale node.
-	 */
-	if (kn->id.ino != ino)
-		goto out;
-	rcu_read_unlock();
+	if (unlikely(!atomic_inc_not_zero(&kn->count)))
+		goto err_unlock;
 
+	spin_unlock(&kernfs_idr_lock);
 	return kn;
-out:
-	rcu_read_unlock();
-	kernfs_put(kn);
+err_unlock:
+	spin_unlock(&kernfs_idr_lock);
 	return NULL;
 }
 
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 6c12fac2c287..067b7c380056 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -363,18 +363,9 @@ void kernfs_kill_sb(struct super_block *sb)
 
 void __init kernfs_init(void)
 {
-
-	/*
-	 * the slab is freed in RCU context, so kernfs_find_and_get_node_by_ino
-	 * can access the slab lock free. This could introduce stale nodes,
-	 * please see how kernfs_find_and_get_node_by_ino filters out stale
-	 * nodes.
-	 */
 	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
 					      sizeof(struct kernfs_node),
-					      0,
-					      SLAB_PANIC | SLAB_TYPESAFE_BY_RCU,
-					      NULL);
+					      0, SLAB_PANIC, NULL);
 
 	/* Creates slab cache for kernfs inode attributes */
 	kernfs_iattrs_cache  = kmem_cache_create("kernfs_iattrs_cache",
-- 
2.17.1

