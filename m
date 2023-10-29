Return-Path: <cgroups+bounces-106-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B847DAB15
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 07:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC7C9B20E20
	for <lists+cgroups@lfdr.de>; Sun, 29 Oct 2023 06:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08DE63C3;
	Sun, 29 Oct 2023 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2RhI2hv"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A48A6112;
	Sun, 29 Oct 2023 06:14:52 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE02E4;
	Sat, 28 Oct 2023 23:14:49 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2e73a17a0so2239432b6e.3;
        Sat, 28 Oct 2023 23:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560089; x=1699164889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCchiRA8pA+IFVpZf4nT3Gq5eOjm8JawUtfCWTnKHFA=;
        b=e2RhI2hvM1O4ZSD2mnJOKrmhnT+InAELxFucoO7SJQVPT7HcBPFpiilJgwLq1QKB5u
         ZZ41fzqx337Gat+b3VEiu+e5yi9ilfYlVeHPthqqVwIXNLo+gitFUAeVAKX6WptUlJX2
         vdVZMkd9lg5diaY6gZv0Bm933Zb8A66d6RC3eRv/iLa4TKKDGDeD+sCfeP9YOvLApCyy
         RzVt+JYPm3kmyFV2ffTW1WqRTF2JyMCIUkT552vlI7tSHv6bnr8UJxZa5eYOigQXNsr2
         sq30SvmXVP7yQA/Jz0nTB6HtgH9mWAxn754ya+/m02I2DgBNO+DnTKvX7JZyxpEr3bE4
         KoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560089; x=1699164889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCchiRA8pA+IFVpZf4nT3Gq5eOjm8JawUtfCWTnKHFA=;
        b=phOHhg289cEi9lugFQeo2pa2YUWcXzbKT6O86RJyi0mQFZeyamCG4+xrOyZDpKFYMn
         YFIOpgOlIuImypM/Gjj4QXlHqtv8d7s7RkAFGQ/PQ45Z4EvpsyXs1uIpDLarfg+1IXBB
         qCirGByCpqfglTCByCUP8wapVU2zADS0rMrKMnvP4Akw1DUtXiZ8mPLz0v/6BwjbZTj9
         h8i68wWgxDNsOys5vYZJKCW2Tpu7hGmqcyqDR23bLU939kJzVLmNrDoMHTg2zvXpkFp+
         KgTjwokXAzE1e6d6NXN2acFMwoLHYm4Mah3V9g3aGKWW6s6B+bDgFvbgMiJXZHn7pIB8
         IDCw==
X-Gm-Message-State: AOJu0YxJf70xF7xSXflj8xQj+VHGq+ZX26Gnq+OjBz1uV86Q7GxGCg8J
	RSen6VDdqTUFT1ZobjUu9Cf/J5wpMjEP79/X
X-Google-Smtp-Source: AGHT+IGGVDeUR8CbYEFV0N7JMgUXsZnbaWsAbygNQ5Jt830Y4DuVPIEIZY8zK1qEB1l356Aub7xpAw==
X-Received: by 2002:a05:6808:152c:b0:3a7:4987:d44 with SMTP id u44-20020a056808152c00b003a749870d44mr8017774oiw.20.1698560088966;
        Sat, 28 Oct 2023 23:14:48 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:2b5:5400:4ff:fea0:d066])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b006b225011ee5sm3775106pfo.6.2023.10.28.23.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 23:14:48 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	mkoutny@suse.com,
	sinquersw@gmail.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	oliver.sang@intel.com,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v3 bpf-next 02/11] cgroup: Make operations on the cgroup root_list RCU safe
Date: Sun, 29 Oct 2023 06:14:29 +0000
Message-Id: <20231029061438.4215-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231029061438.4215-1-laoar.shao@gmail.com>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At present, when we perform operations on the cgroup root_list, we must
hold the cgroup_mutex, which is a relatively heavyweight lock. In reality,
we can make operations on this list RCU-safe, eliminating the need to hold
the cgroup_mutex during traversal. Modifications to the list only occur in
the cgroup root setup and destroy paths, which should be infrequent in a
production environment. In contrast, traversal may occur frequently.
Therefore, making it RCU-safe would be beneficial.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/cgroup-defs.h     |  1 +
 kernel/cgroup/cgroup-internal.h |  3 ++-
 kernel/cgroup/cgroup.c          | 23 ++++++++++++++++-------
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index f1b3151..8505eea 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -558,6 +558,7 @@ struct cgroup_root {
 
 	/* A list running through the active hierarchies */
 	struct list_head root_list;
+	struct rcu_head rcu;
 
 	/* Hierarchy-specific flags */
 	unsigned int flags;
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c56071f..5e17f01 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -170,7 +170,8 @@ struct cgroup_mgctx {
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
-	list_for_each_entry((root), &cgroup_roots, root_list)
+	list_for_each_entry_rcu((root), &cgroup_roots, root_list,	\
+				lockdep_is_held(&cgroup_mutex))
 
 /**
  * for_each_subsys - iterate all enabled cgroup subsystems
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 3053d42..28b8ccc 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1313,7 +1313,7 @@ static void cgroup_exit_root_id(struct cgroup_root *root)
 
 void cgroup_free_root(struct cgroup_root *root)
 {
-	kfree(root);
+	kfree_rcu(root, rcu);
 }
 
 static void cgroup_destroy_root(struct cgroup_root *root)
@@ -1346,7 +1346,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	spin_unlock_irq(&css_set_lock);
 
 	WARN_ON_ONCE(list_empty(&root->root_list));
-	list_del(&root->root_list);
+	list_del_rcu(&root->root_list);
 	cgroup_root_count--;
 
 	cgroup_favor_dynmods(root, false);
@@ -1385,7 +1385,15 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 		}
 	}
 
-	BUG_ON(!res_cgroup);
+	/*
+	 * If cgroup_mutex is not held, the cgrp_cset_link will be freed
+	 * before we remove the cgroup root from the root_list. Consequently,
+	 * when accessing a cgroup root, the cset_link may have already been
+	 * freed, resulting in a NULL res_cgroup. However, by holding the
+	 * cgroup_mutex, we ensure that res_cgroup can't be NULL.
+	 * If we don't hold cgroup_mutex in the caller, we must do the NULL
+	 * check.
+	 */
 	return res_cgroup;
 }
 
@@ -1444,7 +1452,6 @@ static struct cgroup *current_cgns_cgroup_dfl(void)
 static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 					    struct cgroup_root *root)
 {
-	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
 	return __cset_cgroup_from_root(cset, root);
@@ -1452,7 +1459,9 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 
 /*
  * Return the cgroup for "task" from the given hierarchy. Must be
- * called with cgroup_mutex and css_set_lock held.
+ * called with css_set_lock held to prevent task's groups from being modified.
+ * Must be called with either cgroup_mutex or rcu read lock to prevent the
+ * cgroup root from being destroyed.
  */
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
 				     struct cgroup_root *root)
@@ -2013,7 +2022,7 @@ void init_cgroup_root(struct cgroup_fs_context *ctx)
 	struct cgroup_root *root = ctx->root;
 	struct cgroup *cgrp = &root->cgrp;
 
-	INIT_LIST_HEAD(&root->root_list);
+	INIT_LIST_HEAD_RCU(&root->root_list);
 	atomic_set(&root->nr_cgrps, 1);
 	cgrp->root = root;
 	init_cgroup_housekeeping(cgrp);
@@ -2096,7 +2105,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * care of subsystems' refcounts, which are explicitly dropped in
 	 * the failure exit path.
 	 */
-	list_add(&root->root_list, &cgroup_roots);
+	list_add_rcu(&root->root_list, &cgroup_roots);
 	cgroup_root_count++;
 
 	/*
-- 
1.8.3.1


