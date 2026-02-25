Return-Path: <cgroups+bounces-14278-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDjeAyGGnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14278-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:18:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6875191EDB
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A2E54313CF7B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D22E92BA;
	Wed, 25 Feb 2026 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb3OCeVF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A134A766;
	Wed, 25 Feb 2026 05:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995717; cv=none; b=FdTXnBrb5Cqwo2oj2Wnvs/4yg8shwOkxnypoxQqTS7KYS8bZRSsduYWLmuyYkoJ9Jssdc6lfwIjg+hOypbxC24qJTNBvUeZ9TFtnwK7Jo04oJbpvzD9I1QFXIgJ7Ym2tH1fMsW5SeVwM3oDgyIWQ9av7OEEguobJM2Z+HbE0uPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995717; c=relaxed/simple;
	bh=yblRm6xwBzfYaU2Wg6j52ugSks8xIvh79tCIiDwMNCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGxA7qG6J/kKEMddpshBHJY4BBYEkjheX/su5Q+jZCezIGGXwqmd/4o39KAVF4LJ/mzVtja683HcsP/GuvywVAA2He03cwFhr40eB1Kab+XPPc3/2Qt4UQR5UekUlWtdyYmrsWedEd7N0dxqdGjhNBpg8eyBrTHrd/0vUgaIpO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb3OCeVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB1CC116D0;
	Wed, 25 Feb 2026 05:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995717;
	bh=yblRm6xwBzfYaU2Wg6j52ugSks8xIvh79tCIiDwMNCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sb3OCeVFPYy6jdx/tv59sE0J7JRlCCNSWf79PG4P2sz0idLiTnzQL0vTb4VYSWFab
	 ed+BW2gz20acf6cDpoNRgMx9ph2Wo3t9BwcsABfBJb9rIRL3lvsyaZSpnW6GdKrUNJ
	 cwLIkLiQ+Mup2AascHXUfiMEkyvsSDqL2apb6EErJyTkz51JMqL0XkL5usPdSKVXZn
	 vEZo+aJd1ZrgfKai/lWD5aDVOmJqa9rrQ1cFq0+owKh1y/NwlsrOoHVqH+QYXTU/Aw
	 TRc1Sulzjm65n/ZHkMVRExZp39q9PkmJup3BBD/ann2513mLv5iN65iR6uVJRXluLv
	 bO7AbSAB7u1lw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 04/34] cgroup: Expose some cgroup helpers
Date: Tue, 24 Feb 2026 19:01:22 -1000
Message-ID: <20260225050152.1070601-5-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050152.1070601-1-tj@kernel.org>
References: <20260225050152.1070601-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14278-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6875191EDB
X-Rspamd-Action: no action

Expose the following through cgroup.h:

- cgroup_on_dfl()
- cgroup_is_dead()
- cgroup_for_each_live_child()
- cgroup_for_each_live_descendant_pre()
- cgroup_for_each_live_descendant_post()

Until now, these didn't need to be exposed because controllers only cared
about the css hierarchy. The planned sched_ext hierarchical scheduler
support will be based on the default cgroup hierarchy, which is in line
with the existing BPF cgroup support, and thus needs these exposed.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h          | 65 ++++++++++++++++++++++++++++++++-
 kernel/cgroup/cgroup-internal.h |  6 ---
 kernel/cgroup/cgroup.c          | 55 ----------------------------
 3 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index bc892e3b37ee..e52160e85af4 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -42,6 +42,14 @@ struct kernel_clone_args;
 
 #ifdef CONFIG_CGROUPS
 
+/*
+ * To avoid confusing the compiler (and generating warnings) with code
+ * that attempts to access what would be a 0-element array (i.e. sized
+ * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
+ * constant expression can be added.
+ */
+#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
+
 enum css_task_iter_flags {
 	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
 	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
@@ -76,6 +84,7 @@ enum cgroup_lifetime_events {
 extern struct file_system_type cgroup_fs_type;
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 extern struct blocking_notifier_head cgroup_lifetime_notifier;
 
@@ -103,6 +112,8 @@ extern struct blocking_notifier_head cgroup_lifetime_notifier;
 #define cgroup_subsys_on_dfl(ss)						\
 	static_branch_likely(&ss ## _on_dfl_key)
 
+bool cgroup_on_dfl(const struct cgroup *cgrp);
+
 bool css_has_online_children(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *css_from_id(int id, struct cgroup_subsys *ss);
 struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgroup,
@@ -274,6 +285,32 @@ void css_task_iter_end(struct css_task_iter *it);
 	for ((pos) = css_next_descendant_post(NULL, (css)); (pos);	\
 	     (pos) = css_next_descendant_post((pos), (css)))
 
+/* iterate over child cgrps, lock should be held throughout iteration */
+#define cgroup_for_each_live_child(child, cgrp)				\
+	list_for_each_entry((child), &(cgrp)->self.children, self.sibling) \
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       cgroup_is_dead(child); }))			\
+			;						\
+		else
+
+/* walk live descendants in pre order */
+#define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
+	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       (dsct) = (d_css)->cgroup;			\
+		       cgroup_is_dead(dsct); }))			\
+			;						\
+		else
+
+/* walk live descendants in postorder */
+#define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
+	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
+		if (({ lockdep_assert_held(&cgroup_mutex);		\
+		       (dsct) = (d_css)->cgroup;			\
+		       cgroup_is_dead(dsct); }))			\
+			;						\
+		else
+
 /**
  * cgroup_taskset_for_each - iterate cgroup_taskset
  * @task: the loop cursor
@@ -336,6 +373,27 @@ static inline u64 cgroup_id(const struct cgroup *cgrp)
 	return cgrp->kn->id;
 }
 
+/**
+ * cgroup_css - obtain a cgroup's css for the specified subsystem
+ * @cgrp: the cgroup of interest
+ * @ss: the subsystem of interest (%NULL returns @cgrp->self)
+ *
+ * Return @cgrp's css (cgroup_subsys_state) associated with @ss.  This
+ * function must be called either under cgroup_mutex or rcu_read_lock() and
+ * the caller is responsible for pinning the returned css if it wants to
+ * keep accessing it outside the said locks.  This function may return
+ * %NULL if @cgrp doesn't have @subsys_id enabled.
+ */
+static inline struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
+						     struct cgroup_subsys *ss)
+{
+	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
+		return rcu_dereference_check(cgrp->subsys[ss->id],
+					lockdep_is_held(&cgroup_mutex));
+	else
+		return &cgrp->self;
+}
+
 /**
  * css_is_dying - test whether the specified css is dying
  * @css: target css
@@ -372,6 +430,11 @@ static inline bool css_is_self(struct cgroup_subsys_state *css)
 	return false;
 }
 
+static inline bool cgroup_is_dead(const struct cgroup *cgrp)
+{
+	return !(cgrp->self.flags & CSS_ONLINE);
+}
+
 static inline void cgroup_get(struct cgroup *cgrp)
 {
 	css_get(&cgrp->self);
@@ -387,8 +450,6 @@ static inline void cgroup_put(struct cgroup *cgrp)
 	css_put(&cgrp->self);
 }
 
-extern struct mutex cgroup_mutex;
-
 static inline void cgroup_lock(void)
 {
 	mutex_lock(&cgroup_mutex);
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 3bfe37693d68..58797123b752 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -184,11 +184,6 @@ extern bool cgrp_dfl_visible;
 	for ((ssid) = 0; (ssid) < CGROUP_SUBSYS_COUNT &&		\
 	     (((ss) = cgroup_subsys[ssid]) || true); (ssid)++)
 
-static inline bool cgroup_is_dead(const struct cgroup *cgrp)
-{
-	return !(cgrp->self.flags & CSS_ONLINE);
-}
-
 static inline bool notify_on_release(const struct cgroup *cgrp)
 {
 	return test_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
@@ -222,7 +217,6 @@ static inline void get_css_set(struct css_set *cset)
 }
 
 bool cgroup_ssid_enabled(int ssid);
-bool cgroup_on_dfl(const struct cgroup *cgrp);
 
 struct cgroup_root *cgroup_root_from_kf(struct kernfs_root *kf_root);
 struct cgroup *task_cgroup_from_root(struct task_struct *task,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c22cda7766d8..056cb6a2498b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -68,14 +68,6 @@
 /* let's not notify more than 100 times per second */
 #define CGROUP_FILE_NOTIFY_MIN_INTV	DIV_ROUND_UP(HZ, 100)
 
-/*
- * To avoid confusing the compiler (and generating warnings) with code
- * that attempts to access what would be a 0-element array (i.e. sized
- * to a potentially empty array when CGROUP_SUBSYS_COUNT == 0), this
- * constant expression can be added.
- */
-#define CGROUP_HAS_SUBSYS_CONFIG	(CGROUP_SUBSYS_COUNT > 0)
-
 /*
  * cgroup_mutex is the master lock.  Any modification to cgroup or its
  * hierarchy must be performed while holding it.
@@ -509,27 +501,6 @@ static u32 cgroup_ss_mask(struct cgroup *cgrp)
 	return cgrp->root->subsys_mask;
 }
 
-/**
- * cgroup_css - obtain a cgroup's css for the specified subsystem
- * @cgrp: the cgroup of interest
- * @ss: the subsystem of interest (%NULL returns @cgrp->self)
- *
- * Return @cgrp's css (cgroup_subsys_state) associated with @ss.  This
- * function must be called either under cgroup_mutex or rcu_read_lock() and
- * the caller is responsible for pinning the returned css if it wants to
- * keep accessing it outside the said locks.  This function may return
- * %NULL if @cgrp doesn't have @subsys_id enabled.
- */
-static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
-					      struct cgroup_subsys *ss)
-{
-	if (CGROUP_HAS_SUBSYS_CONFIG && ss)
-		return rcu_dereference_check(cgrp->subsys[ss->id],
-					lockdep_is_held(&cgroup_mutex));
-	else
-		return &cgrp->self;
-}
-
 /**
  * cgroup_e_css_by_mask - obtain a cgroup's effective css for the specified ss
  * @cgrp: the cgroup of interest
@@ -741,32 +712,6 @@ EXPORT_SYMBOL_GPL(of_css);
 	}								\
 } while (false)
 
-/* iterate over child cgrps, lock should be held throughout iteration */
-#define cgroup_for_each_live_child(child, cgrp)				\
-	list_for_each_entry((child), &(cgrp)->self.children, self.sibling) \
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       cgroup_is_dead(child); }))			\
-			;						\
-		else
-
-/* walk live descendants in pre order */
-#define cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp)		\
-	css_for_each_descendant_pre((d_css), cgroup_css((cgrp), NULL))	\
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       (dsct) = (d_css)->cgroup;			\
-		       cgroup_is_dead(dsct); }))			\
-			;						\
-		else
-
-/* walk live descendants in postorder */
-#define cgroup_for_each_live_descendant_post(dsct, d_css, cgrp)		\
-	css_for_each_descendant_post((d_css), cgroup_css((cgrp), NULL))	\
-		if (({ lockdep_assert_held(&cgroup_mutex);		\
-		       (dsct) = (d_css)->cgroup;			\
-		       cgroup_is_dead(dsct); }))			\
-			;						\
-		else
-
 /*
  * The default css_set - used by init and its children prior to any
  * hierarchies being mounted. It contains a pointer to the root state
-- 
2.53.0


