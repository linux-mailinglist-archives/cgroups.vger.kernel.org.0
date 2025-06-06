Return-Path: <cgroups+bounces-8455-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F536AD0680
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 18:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB993B1FF1
	for <lists+cgroups@lfdr.de>; Fri,  6 Jun 2025 16:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4E289E2D;
	Fri,  6 Jun 2025 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC11wwJK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D1B289E05;
	Fri,  6 Jun 2025 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749226735; cv=none; b=Blh0JsjdMCrxblE4soSAkQ3/Mz/VyFHM6bpTa8tfUmAVE5MJpbqZhWhtPQr7KFrGHFRaCjKE5oe1fDIxDb3l6++gneuZrF6v/d36hxZyWieTydREFv7N3ZZQSR3KIhFogfm3OC4tzy1oo7XIqXrKRHQoGLovB6WH4ukTCVABbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749226735; c=relaxed/simple;
	bh=Ys6phxAi1yCzadfLuMIMyyXTOESVHhFvpOJF7AGYjSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vr7ifI0g1gYu1FGQfmIuwo5aewNPg0kjVZSVMz+b2+zSvWOZ1u2YknH6hwrDMn7a2ziYR1sCB8bL0LqsxbrKxB1aG7XrLBQUEBn8TizTsz4baAC4CD2l0GWSQ/ody8UzIOlEcS6zaehrJpXvaHeP3Ubd1S9qsl1Ogl++v5fn788=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC11wwJK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-747fc7506d4so2370869b3a.0;
        Fri, 06 Jun 2025 09:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749226733; x=1749831533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1D/UwBfO9rb1qi8d6FbfGYivA4b5vNq0TisU6WUgjI=;
        b=NC11wwJK+oN7ZRJ6VurdDcWObuKIGMy8+yg86LRol7Tto12d+bFTeiLT83iU5vQLcH
         TEC28Bw6WIBUNpz+IMuH/a9rptnDxsMcI2ZBnS33fNkbMIEt5l48Xage3Tjk8T15iQb7
         ngKe2FK8S32Ln3utrPnCGrrgJhcNqwveFvxVz2J+B7/rWxQa6ruGLwlMhumqNeisvPUA
         SYmErGR5SwjFt7F176jMaLLZg/ZWnmEeXc5McMR0CcG485T6LbMet2cSgz+PfEp+w/2Y
         ApBcF50OkKyDaW8fJJMwyRM+XYcRj9EKPl9XgiH9Uf4m3g78mLZ5P9ri3cR9f5K4nmF6
         QgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749226733; x=1749831533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1D/UwBfO9rb1qi8d6FbfGYivA4b5vNq0TisU6WUgjI=;
        b=ZBHBkm+/zcpfRhJXXnU5P+d+ZUU1KuDjWrqMoGe8GX0ADqVHQdmVLEIDEx32M11mAb
         EW4r8dQbP/Yi45k0S5P5UXNflhB45dOkttGGi+dEe0BI4RxWOhUgApTEJhzpPJARF0U4
         9+rJdZF8QyxJS4ePJIqF+NEeUKvwMO1bd5+Tdi3+qdf3dZTa7D0dA6GKyA7c/KnhAV+t
         FHuBnSpbk/InyqqlUZHZILZnQNO7W4wBuel6NkTIUKoTogXaSSUVze97Re/F+2ZH+MOb
         k1lnIObrl2ons5iGMd5lL4nnEZiIUXs65kdcRI94rgP+SSfoxgMpwFmas1auqlPPk4BK
         ad3A==
X-Forwarded-Encrypted: i=1; AJvYcCVl+3JrhTz3SOB4XJrdoI0rYvPpTex0HTE1WVLmXu3zBia7eiWOBWPWWeWdBPakRNDy0AbTUHEa@vger.kernel.org, AJvYcCX/s9Ae70YhE+OxO6qcybbLPwMvW179772Hy/CY29AMO5+yavJfUMvKeJBl/DleXg2WdPCk90dXdi8/Sp9C@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZxWKFfbsuLfCv0+mHyh68P4npQWdJCa2+trm5UryOXdOy8EL
	S8INQJKmVYuq9NZ2ntneDHXyJnfEay8fGytj3KeUa4WPQACWxoJPBJBkuk4hJpnwGuE=
X-Gm-Gg: ASbGnctHUhDbTdy+H4sP7oLDyXmRG1g42dLAiOywH0wxbMul5FWtYGioXjis1XCsbrd
	HgClQ7bLAeY9JjP8P6/PvWqFRW6u52E/2k0GGfsgRyBW41c1zWE4e2dfvw3vBgu3RtUDC8lognL
	TYFg4bXi1hpkEEJu69dPRpizLwq4HYvdjl1DcKc89Gu6i1CrMW8QNo83vIZpYvGXmh8R1EFuJWD
	qQeyS+D4JYA1UQ0ahZQgPAWr7JOuJS6xkZKcK3Aue9ICSaG7zooQr44Vj6Ln5dasLa1P5tWMvXL
	sG0oInFl3AUMR8tLND+xRzxISipMq0Dd4VNG05UpNQajTQUUSrw=
X-Google-Smtp-Source: AGHT+IFAIDJwYl1tg2vjnywkbJPdZQ9Xx5bwB7Cih6rVhVZKDzc36c6HegpZFRbjInSIIK5CEsY+FA==
X-Received: by 2002:a05:6a20:db0c:b0:215:e818:9fe5 with SMTP id adf61e73a8af0-21ee2500408mr5198758637.18.1749226733054;
        Fri, 06 Jun 2025 09:18:53 -0700 (PDT)
Received: from jemmy.. ([180.172.46.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482af38353sm1518675b3a.10.2025.06.06.09.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 09:18:52 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] cgroup: add lock guard support for cgroup_muetx
Date: Sat,  7 Jun 2025 00:18:39 +0800
Message-ID: <20250606161841.44354-2-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606161841.44354-1-jemmywong512@gmail.com>
References: <20250606161841.44354-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>

---
 include/linux/cgroup.h    |  7 ++++
 kernel/cgroup/cgroup-v1.c | 16 ++++----
 kernel/cgroup/cgroup.c    | 81 +++++++++++++++++++--------------------
 3 files changed, 54 insertions(+), 50 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..979f827452ad 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -382,6 +382,10 @@ static inline void cgroup_put(struct cgroup *cgrp)
 
 extern struct mutex cgroup_mutex;
 
+DEFINE_LOCK_GUARD_0(cgroup_mutex,
+	mutex_lock(&cgroup_mutex),
+	mutex_unlock(&cgroup_mutex))
+
 static inline void cgroup_lock(void)
 {
 	mutex_lock(&cgroup_mutex);
@@ -656,6 +660,9 @@ struct cgroup *cgroup_get_from_id(u64 id);
 struct cgroup_subsys_state;
 struct cgroup;
 
+extern struct mutex cgroup_mutex;
+DEFINE_LOCK_GUARD_0(cgroup_mutex, , ,)
+
 static inline u64 cgroup_id(const struct cgroup *cgrp) { return 1; }
 static inline void css_get(struct cgroup_subsys_state *css) {}
 static inline void css_put(struct cgroup_subsys_state *css) {}
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6f..f4658eda4445 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -64,7 +64,8 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	struct cgroup_root *root;
 	int retval = 0;
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
+
 	cgroup_attach_lock(true);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
@@ -78,7 +79,6 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 			break;
 	}
 	cgroup_attach_unlock(true);
-	cgroup_unlock();
 
 	return retval;
 }
@@ -862,13 +862,11 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
 	kernfs_break_active_protection(new_parent);
 	kernfs_break_active_protection(kn);
 
-	cgroup_lock();
-
-	ret = kernfs_rename(kn, new_parent, new_name_str);
-	if (!ret)
-		TRACE_CGROUP_PATH(rename, cgrp);
-
-	cgroup_unlock();
+	scoped_guard(cgroup_mutex) {
+		ret = kernfs_rename(kn, new_parent, new_name_str);
+		if (!ret)
+			TRACE_CGROUP_PATH(rename, cgrp);
+	}
 
 	kernfs_unbreak_active_protection(kn);
 	kernfs_unbreak_active_protection(new_parent);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..54f80afe4f65 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2224,13 +2224,13 @@ int cgroup_do_get_tree(struct fs_context *fc)
 		struct super_block *sb = fc->root->d_sb;
 		struct cgroup *cgrp;
 
-		cgroup_lock();
-		spin_lock_irq(&css_set_lock);
+		scoped_guard(cgroup_mutex) {
+			spin_lock_irq(&css_set_lock);
 
-		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
+			cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
 
-		spin_unlock_irq(&css_set_lock);
-		cgroup_unlock();
+			spin_unlock_irq(&css_set_lock);
+		}
 
 		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
 		dput(fc->root);
@@ -2440,13 +2440,12 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 {
 	int ret;
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 	spin_lock_irq(&css_set_lock);
 
 	ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
 
 	spin_unlock_irq(&css_set_lock);
-	cgroup_unlock();
 
 	return ret;
 }
@@ -4472,9 +4471,10 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 	if (!(cfts[0].flags & __CFTYPE_ADDED))
 		return -ENOENT;
 
-	cgroup_lock();
-	cgroup_rm_cftypes_locked(cfts);
-	cgroup_unlock();
+	scoped_guard(cgroup_mutex) {
+		cgroup_rm_cftypes_locked(cfts);
+	}
+
 	return 0;
 }
 
@@ -4506,14 +4506,13 @@ int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 	if (ret)
 		return ret;
 
-	cgroup_lock();
-
-	list_add_tail(&cfts->node, &ss->cfts);
-	ret = cgroup_apply_cftypes(cfts, true);
-	if (ret)
-		cgroup_rm_cftypes_locked(cfts);
+	scoped_guard(cgroup_mutex) {
+		list_add_tail(&cfts->node, &ss->cfts);
+		ret = cgroup_apply_cftypes(cfts, true);
+		if (ret)
+			cgroup_rm_cftypes_locked(cfts);
+	}
 
-	cgroup_unlock();
 	return ret;
 }
 
@@ -5489,14 +5488,14 @@ static void css_free_rwork_fn(struct work_struct *work)
 	}
 }
 
-static void css_release_work_fn(struct work_struct *work)
+static inline void css_release_work_fn_locked(struct work_struct *work)
 {
 	struct cgroup_subsys_state *css =
 		container_of(work, struct cgroup_subsys_state, destroy_work);
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 
 	css->flags |= CSS_RELEASED;
 	list_del_rcu(&css->sibling);
@@ -5550,8 +5549,14 @@ static void css_release_work_fn(struct work_struct *work)
 					 NULL);
 	}
 
-	cgroup_unlock();
+}
+
+static void css_release_work_fn(struct work_struct *work)
+{
+	struct cgroup_subsys_state *css =
+		container_of(work, struct cgroup_subsys_state, destroy_work);
 
+	css_release_work_fn_locked(work);
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 }
@@ -5914,7 +5919,7 @@ static void css_killed_work_fn(struct work_struct *work)
 	struct cgroup_subsys_state *css =
 		container_of(work, struct cgroup_subsys_state, destroy_work);
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 
 	do {
 		offline_css(css);
@@ -5922,8 +5927,6 @@ static void css_killed_work_fn(struct work_struct *work)
 		/* @css can't go away while we're holding cgroup_mutex */
 		css = css->parent;
 	} while (css && atomic_dec_and_test(&css->online_cnt));
-
-	cgroup_unlock();
 }
 
 /* css kill confirmation processing requires process context, bounce */
@@ -6115,7 +6118,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	pr_debug("Initializing cgroup subsys %s\n", ss->name);
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 
 	idr_init(&ss->css_idr);
 	INIT_LIST_HEAD(&ss->cfts);
@@ -6161,8 +6164,6 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	BUG_ON(!list_empty(&init_task.tasks));
 
 	BUG_ON(online_css(css));
-
-	cgroup_unlock();
 }
 
 /**
@@ -6224,20 +6225,18 @@ int __init cgroup_init(void)
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
-	cgroup_lock();
-
-	/*
-	 * Add init_css_set to the hash table so that dfl_root can link to
-	 * it during init.
-	 */
-	hash_add(css_set_table, &init_css_set.hlist,
-		 css_set_hash(init_css_set.subsys));
-
-	cgroup_bpf_lifetime_notifier_init();
+	scoped_guard(cgroup_mutex) {
+		/*
+		 * Add init_css_set to the hash table so that dfl_root can link to
+		 * it during init.
+		 */
+		hash_add(css_set_table, &init_css_set.hlist,
+			css_set_hash(init_css_set.subsys));
 
-	BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
+		cgroup_bpf_lifetime_notifier_init();
 
-	cgroup_unlock();
+		BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
+	}
 
 	for_each_subsys(ss, ssid) {
 		if (ss->early_init) {
@@ -6289,9 +6288,9 @@ int __init cgroup_init(void)
 		if (ss->bind)
 			ss->bind(init_css_set.subsys[ssid]);
 
-		cgroup_lock();
-		css_populate_dir(init_css_set.subsys[ssid]);
-		cgroup_unlock();
+		scoped_guard(cgroup_mutex) {
+			css_populate_dir(init_css_set.subsys[ssid]);
+		}
 	}
 
 	/* init_css_set.subsys[] has been updated, re-hash */
-- 
2.43.0


