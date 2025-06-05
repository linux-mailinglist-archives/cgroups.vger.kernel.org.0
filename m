Return-Path: <cgroups+bounces-8445-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B6ACF922
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D835189C19B
	for <lists+cgroups@lfdr.de>; Thu,  5 Jun 2025 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B027AC30;
	Thu,  5 Jun 2025 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYpPgmxW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C620330;
	Thu,  5 Jun 2025 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749157874; cv=none; b=hFhmeFOtk2iBDa/mai8+8XxorvfT1UlyKnDukDreP3W6OoEZCWlWFlv4fQPSie64EdVnLl1Qfpn5s+OTrVKm2xOOtZ043PyBrGl+5CRjpy9I9Y8OcdRQ2G8j92DKX+YwVFEUHJxZWAfKwGQONWfWGkxvKQJ8wCDlPPo5bMLC5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749157874; c=relaxed/simple;
	bh=uiXFwBQJAHmCW1kcW0ypDs/JQJuVXrne1pmbczIlem4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tq4AWNpSTl8W9O3MqncD0FNfmzJGXh0zhyIvLqgBmmC6titIcXUroJvotwwHyXkxdDNIM6uX7lapOffyazQecWxA+02+jhr+cc6tbbQDY/Yw5gtFbocY7E0KA3UlA20EnypGD1dP4Avt0FPs/dZOria4MA+FcnxE66rMgd5hW+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYpPgmxW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e09f57ed4so24288395ad.0;
        Thu, 05 Jun 2025 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749157870; x=1749762670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbl36MDXlFZKZ1KgkQuHrXs7wMdowxp/Dz8o1C/uwGk=;
        b=MYpPgmxWAJuWtFNCPm3irgafIP/zQZCUyp3qMkTbfuHKwU/HeinRkFzJdBWsG5fUGc
         cvIKP05wykzs5DpANX2y4LTyUXbJpMTdeC0CTJK8YCHWNGm5RekshKCybaHCGWL3trsG
         dtiqHoXk3141xG+53E6HluJS7sAJ/mOz2PdgAamTPGN2MUwDLEFWUEF+MdiCTvJHR6Hn
         qpPoiPyDE92CD3xefAchC8J9pNy6LEApaAdHNYg2OGwhqSeQHUyfV/5f499QYY/Z+sK6
         GJj72XCKJJSmZO8GDZtLOYSHAMkfQFsteHfP+PUf26elB1fbV3OBHvprWeqoYkuxMJLa
         X1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749157870; x=1749762670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wbl36MDXlFZKZ1KgkQuHrXs7wMdowxp/Dz8o1C/uwGk=;
        b=alE7X+54AMPnZRnFKlbp+L29ko/g8UnLXc5xNIaiUgxhewCIyVxwngKalpgDA3Uu/L
         jXbpsxce186WsbZ49LqicWlKXvExRNoY7GwoRbpPLr3mZwPhKDoQUyGw7kjtR+ufQiaB
         VlGBA9oukAIaUslVdZ+0IErxOPh8I7Bxl0uTfAIIFb9DJHnrBAw/FO4U706YqowqJRxg
         mkL1yxgpbtnYa01TVm/gVJd7W7NFNobzojXw/iuEUHLX4nyQW2J+CoDsPfQ4heAppl0Z
         Lf/jzwmqUUyRQh/mX6uIAzC+fRgx4uJ8LefHfU9y8JN6D5AXZ+Ghu76ehDfoCNpUrKC8
         denQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdLzEvTya5zpXmUdxCJ0uOnzRBnS7JlsVQP+kSpDA2HJ2KzaJmd5/H2O9rgpPABs4T8cFIKK7TgeXbEJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXEe8wHTAzY0PDrZmoCMxJSW3jnDXhL3nwEarM1m4wWCtSFPE
	ZpDsvfU2sxuALNH9VWy2ZNANZp9tdwTLpvmK6Rzdw4pXPCtF67WO5hVZ
X-Gm-Gg: ASbGncuXXz5/oK2JCin3zl9S41yfwR7qsAWKf0zAsg/1rspFdHQD2rbQDTEBE8hlHQd
	hLCqbSXlstvkuU7ugyqf69917MN6qAEJVOcLEH27nqVUqPTqzoXtcwWGS2h+by1ILCnX1GLIwmw
	iAaCSNUjcJ1OoFVXXGrZOTyKcCPllGeRGadKggPWKVowstIAy4qZp7Wp83ALBbxWzuMTwzvPE9H
	tsrs8n6IwRu1fTW7WVkOkwWbz1bXoYn4e0IY7bpdF5pX8GOBdtZVQU0TFFzqvUDaYsf4dVqnYrS
	ItLfsrJU0YpACvn4SFkxH0H733X79XtDQv83gUEYKjDaQsBmmAFJa3HieRELlTlGk5/ssdj9
X-Google-Smtp-Source: AGHT+IH8B/UkE18BqKXivgO3bGraGHDvONuWUG6vLr2FU1lN1eQwOwuo/UEnyL/B/a+2aWiDOM1+8g==
X-Received: by 2002:a17:902:cece:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-2360207d144mr10007385ad.15.1749157869683;
        Thu, 05 Jun 2025 14:11:09 -0700 (PDT)
Received: from jemmy.. ([180.172.46.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2360340fe9fsm481955ad.205.2025.06.05.14.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 14:11:09 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jemmywong512@gmail.com
Subject: [PATCH v0] cgroup: Add lock guard support
Date: Fri,  6 Jun 2025 05:10:53 +0800
Message-ID: <20250605211053.19200-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change replaces manual lock acquisition and release with lock guards
to improve code robustness and reduce the risk of lock mismanagement.
No functional changes to the cgroup logic are introduced.

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>

---
 include/linux/cgroup.h     |   7 +
 kernel/bpf/cgroup.c        |  96 +++---
 kernel/bpf/local_storage.c |  12 +-
 kernel/cgroup/cgroup-v1.c  | 121 ++++---
 kernel/cgroup/cgroup.c     | 639 +++++++++++++++++--------------------
 5 files changed, 408 insertions(+), 467 deletions(-)

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
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 9122c39870bf..d7a3fed7858c 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -203,11 +203,10 @@ void bpf_cgroup_atype_put(int cgroup_atype)
 {
 	int i = cgroup_atype - CGROUP_LSM_START;
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 	if (--cgroup_lsm_atype[i].refcnt <= 0)
 		cgroup_lsm_atype[i].attach_btf_id = 0;
 	WARN_ON_ONCE(cgroup_lsm_atype[i].refcnt < 0);
-	cgroup_unlock();
 }
 #else
 static enum cgroup_bpf_attach_type
@@ -302,17 +301,17 @@ static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
  *                        release all cgroup bpf data
  * @work: work structure embedded into the cgroup to modify
  */
-static void cgroup_bpf_release(struct work_struct *work)
+static inline void cgroup_bpf_release_locked(struct work_struct *work)
 {
-	struct cgroup *p, *cgrp = container_of(work, struct cgroup,
-					       bpf.release_work);
+	struct cgroup *cgrp =
+		container_of(work, struct cgroup, bpf.release_work);
 	struct bpf_prog_array *old_array;
 	struct list_head *storages = &cgrp->bpf.storages;
 	struct bpf_cgroup_storage *storage, *stmp;
 
 	unsigned int atype;
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 
 	for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
 		struct hlist_head *progs = &cgrp->bpf.progs[atype];
@@ -344,8 +343,14 @@ static void cgroup_bpf_release(struct work_struct *work)
 		bpf_cgroup_storage_unlink(storage);
 		bpf_cgroup_storage_free(storage);
 	}
+}
+
+static void cgroup_bpf_release(struct work_struct *work)
+{
+	struct cgroup *p, *cgrp =
+		container_of(work, struct cgroup, bpf.release_work);
 
-	cgroup_unlock();
+	cgroup_bpf_release_locked(work);
 
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
@@ -795,12 +800,8 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
 			     enum bpf_attach_type type,
 			     u32 flags)
 {
-	int ret;
-
-	cgroup_lock();
-	ret = __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags);
-	cgroup_unlock();
-	return ret;
+	guard(cgroup_mutex)();
+	return __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags);
 }
 
 /* Swap updated BPF program for given link in effective program arrays across
@@ -900,19 +901,16 @@ static int cgroup_bpf_replace(struct bpf_link *link, struct bpf_prog *new_prog,
 
 	cg_link = container_of(link, struct bpf_cgroup_link, link);
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 	/* link might have been auto-released by dying cgroup, so fail */
 	if (!cg_link->cgroup) {
-		ret = -ENOLINK;
-		goto out_unlock;
+		return -ENOLINK;
 	}
 	if (old_prog && link->prog != old_prog) {
-		ret = -EPERM;
-		goto out_unlock;
+		return -EPERM;
 	}
 	ret = __cgroup_bpf_replace(cg_link->cgroup, cg_link, new_prog);
-out_unlock:
-	cgroup_unlock();
+
 	return ret;
 }
 
@@ -1076,12 +1074,8 @@ static int __cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 static int cgroup_bpf_detach(struct cgroup *cgrp, struct bpf_prog *prog,
 			     enum bpf_attach_type type)
 {
-	int ret;
-
-	cgroup_lock();
-	ret = __cgroup_bpf_detach(cgrp, prog, NULL, type);
-	cgroup_unlock();
-	return ret;
+	guard(cgroup_mutex)();
+	return __cgroup_bpf_detach(cgrp, prog, NULL, type);
 }
 
 /* Must be called with cgroup_mutex held to avoid races. */
@@ -1187,12 +1181,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 static int cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 			    union bpf_attr __user *uattr)
 {
-	int ret;
-
-	cgroup_lock();
-	ret = __cgroup_bpf_query(cgrp, attr, uattr);
-	cgroup_unlock();
-	return ret;
+	guard(cgroup_mutex)();
+	return __cgroup_bpf_query(cgrp, attr, uattr);
 }
 
 int cgroup_bpf_prog_attach(const union bpf_attr *attr,
@@ -1258,23 +1248,19 @@ static void bpf_cgroup_link_release(struct bpf_link *link)
 	if (!cg_link->cgroup)
 		return;
 
-	cgroup_lock();
-
-	/* re-check cgroup under lock again */
-	if (!cg_link->cgroup) {
-		cgroup_unlock();
-		return;
-	}
-
-	WARN_ON(__cgroup_bpf_detach(cg_link->cgroup, NULL, cg_link,
-				    cg_link->type));
-	if (cg_link->type == BPF_LSM_CGROUP)
-		bpf_trampoline_unlink_cgroup_shim(cg_link->link.prog);
+	scoped_guard(cgroup_mutex) {
+		/* re-check cgroup under lock again */
+		if (!cg_link->cgroup)
+			return;
 
-	cg = cg_link->cgroup;
-	cg_link->cgroup = NULL;
+		WARN_ON(__cgroup_bpf_detach(cg_link->cgroup, NULL, cg_link,
+					    cg_link->type));
+		if (cg_link->type == BPF_LSM_CGROUP)
+			bpf_trampoline_unlink_cgroup_shim(cg_link->link.prog);
 
-	cgroup_unlock();
+		cg = cg_link->cgroup;
+		cg_link->cgroup = NULL;
+	}
 
 	cgroup_put(cg);
 }
@@ -1301,10 +1287,10 @@ static void bpf_cgroup_link_show_fdinfo(const struct bpf_link *link,
 		container_of(link, struct bpf_cgroup_link, link);
 	u64 cg_id = 0;
 
-	cgroup_lock();
-	if (cg_link->cgroup)
-		cg_id = cgroup_id(cg_link->cgroup);
-	cgroup_unlock();
+	scoped_guard(cgroup_mutex) {
+		if (cg_link->cgroup)
+			cg_id = cgroup_id(cg_link->cgroup);
+	}
 
 	seq_printf(seq,
 		   "cgroup_id:\t%llu\n"
@@ -1320,10 +1306,10 @@ static int bpf_cgroup_link_fill_link_info(const struct bpf_link *link,
 		container_of(link, struct bpf_cgroup_link, link);
 	u64 cg_id = 0;
 
-	cgroup_lock();
-	if (cg_link->cgroup)
-		cg_id = cgroup_id(cg_link->cgroup);
-	cgroup_unlock();
+	scoped_guard(cgroup_mutex) {
+		if (cg_link->cgroup)
+			cg_id = cgroup_id(cg_link->cgroup);
+	}
 
 	info->cgroup.cgroup_id = cg_id;
 	info->cgroup.attach_type = cg_link->type;
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 3969eb0382af..2a37be009e6e 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -333,15 +333,13 @@ static void cgroup_storage_map_free(struct bpf_map *_map)
 	struct list_head *storages = &map->list;
 	struct bpf_cgroup_storage *storage, *stmp;
 
-	cgroup_lock();
-
-	list_for_each_entry_safe(storage, stmp, storages, list_map) {
-		bpf_cgroup_storage_unlink(storage);
-		bpf_cgroup_storage_free(storage);
+	scoped_guard(cgroup_mutex) {
+		list_for_each_entry_safe(storage, stmp, storages, list_map) {
+			bpf_cgroup_storage_unlink(storage);
+			bpf_cgroup_storage_free(storage);
+		}
 	}
 
-	cgroup_unlock();
-
 	WARN_ON(!RB_EMPTY_ROOT(&map->root));
 	WARN_ON(!list_empty(&map->list));
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index fa24c032ed6f..83f8ea74366d 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -64,21 +64,20 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	struct cgroup_root *root;
 	int retval = 0;
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 	cgroup_attach_lock(true);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
-		spin_lock_irq(&css_set_lock);
-		from_cgrp = task_cgroup_from_root(from, root);
-		spin_unlock_irq(&css_set_lock);
+		scoped_guard(spinlock_irq, &css_set_lock) {
+			from_cgrp = task_cgroup_from_root(from, root);
+		}
 
 		retval = cgroup_attach_task(from_cgrp, tsk, false);
 		if (retval)
 			break;
 	}
 	cgroup_attach_unlock(true);
-	cgroup_unlock();
 
 	return retval;
 }
@@ -117,10 +116,10 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	cgroup_attach_lock(true);
 
 	/* all tasks in @from are being moved, all csets are source */
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &from->cset_links, cset_link)
-		cgroup_migrate_add_src(link->cset, to, &mgctx);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry(link, &from->cset_links, cset_link)
+			cgroup_migrate_add_src(link->cset, to, &mgctx);
+	}
 
 	ret = cgroup_migrate_prepare_dst(&mgctx);
 	if (ret)
@@ -203,10 +202,10 @@ void cgroup1_pidlist_destroy_all(struct cgroup *cgrp)
 {
 	struct cgroup_pidlist *l, *tmp_l;
 
-	mutex_lock(&cgrp->pidlist_mutex);
-	list_for_each_entry_safe(l, tmp_l, &cgrp->pidlists, links)
-		mod_delayed_work(cgroup_pidlist_destroy_wq, &l->destroy_dwork, 0);
-	mutex_unlock(&cgrp->pidlist_mutex);
+	scoped_guard(mutex, &cgrp->pidlist_mutex) {
+		list_for_each_entry_safe(l, tmp_l, &cgrp->pidlists, links)
+			mod_delayed_work(cgroup_pidlist_destroy_wq, &l->destroy_dwork, 0);
+	}
 
 	flush_workqueue(cgroup_pidlist_destroy_wq);
 	BUG_ON(!list_empty(&cgrp->pidlists));
@@ -219,20 +218,19 @@ static void cgroup_pidlist_destroy_work_fn(struct work_struct *work)
 						destroy_dwork);
 	struct cgroup_pidlist *tofree = NULL;
 
-	mutex_lock(&l->owner->pidlist_mutex);
-
-	/*
-	 * Destroy iff we didn't get queued again.  The state won't change
-	 * as destroy_dwork can only be queued while locked.
-	 */
-	if (!delayed_work_pending(dwork)) {
-		list_del(&l->links);
-		kvfree(l->list);
-		put_pid_ns(l->key.ns);
-		tofree = l;
+	scoped_guard(mutex, &l->owner->pidlist_mutex) {
+		/*
+		 * Destroy iff we didn't get queued again.  The state won't change
+		 * as destroy_dwork can only be queued while locked.
+		 */
+		if (!delayed_work_pending(dwork)) {
+			list_del(&l->links);
+			kvfree(l->list);
+			put_pid_ns(l->key.ns);
+			tofree = l;
+		}
 	}
 
-	mutex_unlock(&l->owner->pidlist_mutex);
 	kfree(tofree);
 }
 
@@ -567,11 +565,12 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
 		return -ENODEV;
-	spin_lock(&release_agent_path_lock);
-	strscpy(cgrp->root->release_agent_path, strstrip(buf),
-		sizeof(cgrp->root->release_agent_path));
-	spin_unlock(&release_agent_path_lock);
+	scoped_guard(spinlock, &release_agent_path_lock) {
+		strscpy(cgrp->root->release_agent_path, strstrip(buf),
+			sizeof(cgrp->root->release_agent_path));
+	}
 	cgroup_kn_unlock(of->kn);
+
 	return nbytes;
 }
 
@@ -579,10 +578,11 @@ static int cgroup_release_agent_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
 
-	spin_lock(&release_agent_path_lock);
-	seq_puts(seq, cgrp->root->release_agent_path);
-	spin_unlock(&release_agent_path_lock);
+	scoped_guard(spinlock, &release_agent_path_lock) {
+		seq_puts(seq, cgrp->root->release_agent_path);
+	}
 	seq_putc(seq, '\n');
+
 	return 0;
 }
 
@@ -728,13 +728,11 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 	 * @kn->priv's validity.  For this and css_tryget_online_from_dir(),
 	 * @kn->priv is RCU safe.  Let's do the RCU dancing.
 	 */
-	rcu_read_lock();
-	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
-	if (!cgrp || !cgroup_tryget(cgrp)) {
-		rcu_read_unlock();
-		return -ENOENT;
+	scoped_guard(rcu) {
+		cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
+		if (!cgrp || !cgroup_tryget(cgrp))
+			return -ENOENT;
 	}
-	rcu_read_unlock();
 
 	css_task_iter_start(&cgrp->self, 0, &it);
 	while ((tsk = css_task_iter_next(&it))) {
@@ -811,9 +809,9 @@ void cgroup1_release_agent(struct work_struct *work)
 	if (!pathbuf || !agentbuf)
 		goto out_free;
 
-	spin_lock(&release_agent_path_lock);
-	strscpy(agentbuf, cgrp->root->release_agent_path, PATH_MAX);
-	spin_unlock(&release_agent_path_lock);
+	scoped_guard(spinlock, &release_agent_path_lock) {
+		strscpy(agentbuf, cgrp->root->release_agent_path, PATH_MAX);
+	}
 	if (!agentbuf[0])
 		goto out_free;
 
@@ -862,13 +860,11 @@ static int cgroup1_rename(struct kernfs_node *kn, struct kernfs_node *new_parent
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
@@ -893,11 +889,11 @@ static int cgroup1_show_options(struct seq_file *seq, struct kernfs_root *kf_roo
 	if (root->flags & CGRP_ROOT_FAVOR_DYNMODS)
 		seq_puts(seq, ",favordynmods");
 
-	spin_lock(&release_agent_path_lock);
-	if (strlen(root->release_agent_path))
-		seq_show_option(seq, "release_agent",
-				root->release_agent_path);
-	spin_unlock(&release_agent_path_lock);
+	scoped_guard(spinlock, &release_agent_path_lock) {
+		if (strlen(root->release_agent_path))
+			seq_show_option(seq, "release_agent",
+					root->release_agent_path);
+	}
 
 	if (test_bit(CGRP_CPUSET_CLONE_CHILDREN, &root->cgrp.flags))
 		seq_puts(seq, ",clone_children");
@@ -1128,9 +1124,8 @@ int cgroup1_reconfigure(struct fs_context *fc)
 	WARN_ON(rebind_subsystems(&cgrp_dfl_root, removed_mask));
 
 	if (ctx->release_agent) {
-		spin_lock(&release_agent_path_lock);
+		guard(spinlock)(&release_agent_path_lock);
 		strcpy(root->release_agent_path, ctx->release_agent);
-		spin_unlock(&release_agent_path_lock);
 	}
 
 	trace_cgroup_remount(root);
@@ -1294,23 +1289,23 @@ struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy_id)
 {
 	struct cgroup *cgrp = ERR_PTR(-ENOENT);
 	struct cgroup_root *root;
-	unsigned long flags;
 
-	rcu_read_lock();
+	guard(rcu)();
+
 	for_each_root(root) {
 		/* cgroup1 only*/
 		if (root == &cgrp_dfl_root)
 			continue;
 		if (root->hierarchy_id != hierarchy_id)
 			continue;
-		spin_lock_irqsave(&css_set_lock, flags);
-		cgrp = task_cgroup_from_root(tsk, root);
-		if (!cgrp || !cgroup_tryget(cgrp))
-			cgrp = ERR_PTR(-ENOENT);
-		spin_unlock_irqrestore(&css_set_lock, flags);
+		scoped_guard(spinlock_irqsave, &css_set_lock) {
+			cgrp = task_cgroup_from_root(tsk, root);
+			if (!cgrp || !cgroup_tryget(cgrp))
+				cgrp = ERR_PTR(-ENOENT);
+		}
 		break;
 	}
-	rcu_read_unlock();
+
 	return cgrp;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a723b7dc6e4e..0bd2e3f0b02b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -335,9 +335,9 @@ static int cgroup_idr_alloc(struct idr *idr, void *ptr, int start, int end,
 	int ret;
 
 	idr_preload(gfp_mask);
-	spin_lock_bh(&cgroup_idr_lock);
-	ret = idr_alloc(idr, ptr, start, end, gfp_mask & ~__GFP_DIRECT_RECLAIM);
-	spin_unlock_bh(&cgroup_idr_lock);
+	scoped_guard(spinlock_bh, &cgroup_idr_lock) {
+		ret = idr_alloc(idr, ptr, start, end, gfp_mask & ~__GFP_DIRECT_RECLAIM);
+	}
 	idr_preload_end();
 	return ret;
 }
@@ -346,17 +346,16 @@ static void *cgroup_idr_replace(struct idr *idr, void *ptr, int id)
 {
 	void *ret;
 
-	spin_lock_bh(&cgroup_idr_lock);
+	guard(spinlock_bh)(&cgroup_idr_lock);
 	ret = idr_replace(idr, ptr, id);
-	spin_unlock_bh(&cgroup_idr_lock);
+
 	return ret;
 }
 
 static void cgroup_idr_remove(struct idr *idr, int id)
 {
-	spin_lock_bh(&cgroup_idr_lock);
+	guard(spinlock_bh)(&cgroup_idr_lock);
 	idr_remove(idr, id);
-	spin_unlock_bh(&cgroup_idr_lock);
 }
 
 static bool cgroup_has_tasks(struct cgroup *cgrp)
@@ -583,20 +582,19 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 	if (!CGROUP_HAS_SUBSYS_CONFIG)
 		return NULL;
 
-	rcu_read_lock();
+	guard(rcu)();
 
 	do {
 		css = cgroup_css(cgrp, ss);
 
 		if (css && css_tryget_online(css))
-			goto out_unlock;
+			return css;
 		cgrp = cgroup_parent(cgrp);
 	} while (cgrp);
 
 	css = init_css_set.subsys[ss->id];
 	css_get(css);
-out_unlock:
-	rcu_read_unlock();
+
 	return css;
 }
 EXPORT_SYMBOL_GPL(cgroup_get_e_css);
@@ -633,9 +631,8 @@ int cgroup_task_count(const struct cgroup *cgrp)
 {
 	int count;
 
-	spin_lock_irq(&css_set_lock);
+	guard(spinlock_irq)(&css_set_lock);
 	count = __cgroup_task_count(cgrp);
-	spin_unlock_irq(&css_set_lock);
 
 	return count;
 }
@@ -1202,11 +1199,11 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 
 	/* First see if we already have a cgroup group that matches
 	 * the desired set */
-	spin_lock_irq(&css_set_lock);
-	cset = find_existing_css_set(old_cset, cgrp, template);
-	if (cset)
-		get_css_set(cset);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		cset = find_existing_css_set(old_cset, cgrp, template);
+		if (cset)
+			get_css_set(cset);
+	}
 
 	if (cset)
 		return cset;
@@ -1238,34 +1235,33 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 	 * find_existing_css_set() */
 	memcpy(cset->subsys, template, sizeof(cset->subsys));
 
-	spin_lock_irq(&css_set_lock);
-	/* Add reference counts and links from the new css_set. */
-	list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
-		struct cgroup *c = link->cgrp;
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		/* Add reference counts and links from the new css_set. */
+		list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
+			struct cgroup *c = link->cgrp;
 
-		if (c->root == cgrp->root)
-			c = cgrp;
-		link_css_set(&tmp_links, cset, c);
-	}
+			if (c->root == cgrp->root)
+				c = cgrp;
+			link_css_set(&tmp_links, cset, c);
+		}
 
-	BUG_ON(!list_empty(&tmp_links));
+		BUG_ON(!list_empty(&tmp_links));
 
-	css_set_count++;
+		css_set_count++;
 
-	/* Add @cset to the hash table */
-	key = css_set_hash(cset->subsys);
-	hash_add(css_set_table, &cset->hlist, key);
+		/* Add @cset to the hash table */
+		key = css_set_hash(cset->subsys);
+		hash_add(css_set_table, &cset->hlist, key);
 
-	for_each_subsys(ss, ssid) {
-		struct cgroup_subsys_state *css = cset->subsys[ssid];
+		for_each_subsys(ss, ssid) {
+			struct cgroup_subsys_state *css = cset->subsys[ssid];
 
-		list_add_tail(&cset->e_cset_node[ssid],
-			      &css->cgroup->e_csets[ssid]);
-		css_get(css);
+			list_add_tail(&cset->e_cset_node[ssid],
+				&css->cgroup->e_csets[ssid]);
+			css_get(css);
+		}
 	}
 
-	spin_unlock_irq(&css_set_lock);
-
 	/*
 	 * If @cset should be threaded, look up the matching dom_cset and
 	 * link them up.  We first fully initialize @cset then look for the
@@ -1281,11 +1277,10 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 			return NULL;
 		}
 
-		spin_lock_irq(&css_set_lock);
+		guard(spinlock_irq)(&css_set_lock);
 		cset->dom_cset = dcset;
 		list_add_tail(&cset->threaded_csets_node,
 			      &dcset->threaded_csets);
-		spin_unlock_irq(&css_set_lock);
 	}
 
 	return cset;
@@ -1362,16 +1357,14 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	 * Release all the links from cset_links to this hierarchy's
 	 * root cgroup
 	 */
-	spin_lock_irq(&css_set_lock);
-
-	list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
-		list_del(&link->cset_link);
-		list_del(&link->cgrp_link);
-		kfree(link);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
+			list_del(&link->cset_link);
+			list_del(&link->cgrp_link);
+			kfree(link);
+		}
 	}
 
-	spin_unlock_irq(&css_set_lock);
-
 	WARN_ON_ONCE(list_empty(&root->root_list));
 	list_del_rcu(&root->root_list);
 	cgroup_root_count--;
@@ -1437,12 +1430,10 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 
 	lockdep_assert_held(&css_set_lock);
 
-	rcu_read_lock();
-
-	cset = current->nsproxy->cgroup_ns->root_cset;
-	res = __cset_cgroup_from_root(cset, root);
-
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		cset = current->nsproxy->cgroup_ns->root_cset;
+		res = __cset_cgroup_from_root(cset, root);
+	}
 
 	/*
 	 * The namespace_sem is held by current, so the root cgroup can't
@@ -1702,9 +1693,9 @@ static void cgroup_rm_file(struct cgroup *cgrp, const struct cftype *cft)
 		struct cgroup_subsys_state *css = cgroup_css(cgrp, cft->ss);
 		struct cgroup_file *cfile = (void *)css + cft->file_offset;
 
-		spin_lock_irq(&cgroup_file_kn_lock);
-		cfile->kn = NULL;
-		spin_unlock_irq(&cgroup_file_kn_lock);
+		scoped_guard(spinlock_irq, &css_set_lock) {
+			cfile->kn = NULL;
+		}
 
 		timer_delete_sync(&cfile->notify_timer);
 	}
@@ -1867,25 +1858,25 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
 
-		spin_lock_irq(&css_set_lock);
-		css->cgroup = dcgrp;
-		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
-		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
-					 e_cset_node[ss->id]) {
-			list_move_tail(&cset->e_cset_node[ss->id],
-				       &dcgrp->e_csets[ss->id]);
-			/*
-			 * all css_sets of scgrp together in same order to dcgrp,
-			 * patch in-flight iterators to preserve correct iteration.
-			 * since the iterator is always advanced right away and
-			 * finished when it->cset_pos meets it->cset_head, so only
-			 * update it->cset_head is enough here.
-			 */
-			list_for_each_entry(it, &cset->task_iters, iters_node)
-				if (it->cset_head == &scgrp->e_csets[ss->id])
-					it->cset_head = &dcgrp->e_csets[ss->id];
+		scoped_guard(spinlock_irq, &css_set_lock) {
+			css->cgroup = dcgrp;
+			WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+			list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+						e_cset_node[ss->id]) {
+				list_move_tail(&cset->e_cset_node[ss->id],
+					&dcgrp->e_csets[ss->id]);
+				/*
+				 * all css_sets of scgrp together in same order to dcgrp,
+				 * patch in-flight iterators to preserve correct iteration.
+				 * since the iterator is always advanced right away and
+				 * finished when it->cset_pos meets it->cset_head, so only
+				 * update it->cset_head is enough here.
+				 */
+				list_for_each_entry(it, &cset->task_iters, iters_node)
+					if (it->cset_head == &scgrp->e_csets[ss->id])
+						it->cset_head = &dcgrp->e_csets[ss->id];
+			}
 		}
-		spin_unlock_irq(&css_set_lock);
 
 		/* default hierarchy doesn't enable controllers by default */
 		dst_root->subsys_mask |= 1 << ssid;
@@ -1921,10 +1912,10 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 	if (!buf)
 		return -ENOMEM;
 
-	spin_lock_irq(&css_set_lock);
-	ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
-	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
+		len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
+	}
 
 	if (len == -E2BIG)
 		len = -ERANGE;
@@ -2175,13 +2166,13 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	 * Link the root cgroup in this hierarchy into all the css_set
 	 * objects.
 	 */
-	spin_lock_irq(&css_set_lock);
-	hash_for_each(css_set_table, i, cset, hlist) {
-		link_css_set(&tmp_links, cset, root_cgrp);
-		if (css_set_populated(cset))
-			cgroup_update_populated(root_cgrp, true);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		hash_for_each(css_set_table, i, cset, hlist) {
+			link_css_set(&tmp_links, cset, root_cgrp);
+			if (css_set_populated(cset))
+				cgroup_update_populated(root_cgrp, true);
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	BUG_ON(!list_empty(&root_cgrp->self.children));
 	BUG_ON(atomic_read(&root->nr_cgrps) != 1);
@@ -2224,13 +2215,10 @@ int cgroup_do_get_tree(struct fs_context *fc)
 		struct super_block *sb = fc->root->d_sb;
 		struct cgroup *cgrp;
 
-		cgroup_lock();
-		spin_lock_irq(&css_set_lock);
-
-		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
-
-		spin_unlock_irq(&css_set_lock);
-		cgroup_unlock();
+		scoped_guard(cgroup_mutex) {
+			guard(spinlock_irq)(&css_set_lock);
+			cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
+		}
 
 		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
 		dput(fc->root);
@@ -2440,14 +2428,10 @@ int cgroup_path_ns(struct cgroup *cgrp, char *buf, size_t buflen,
 {
 	int ret;
 
-	cgroup_lock();
-	spin_lock_irq(&css_set_lock);
-
+	guard(cgroup_mutex)();
+	guard(spinlock_irq)(&css_set_lock);
 	ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
 
-	spin_unlock_irq(&css_set_lock);
-	cgroup_unlock();
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cgroup_path_ns);
@@ -2630,27 +2614,26 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 	 * the new cgroup.  There are no failure cases after here, so this
 	 * is the commit point.
 	 */
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(cset, &tset->src_csets, mg_node) {
-		list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
-			struct css_set *from_cset = task_css_set(task);
-			struct css_set *to_cset = cset->mg_dst_cset;
-
-			get_css_set(to_cset);
-			to_cset->nr_tasks++;
-			css_set_move_task(task, from_cset, to_cset, true);
-			from_cset->nr_tasks--;
-			/*
-			 * If the source or destination cgroup is frozen,
-			 * the task might require to change its state.
-			 */
-			cgroup_freezer_migrate_task(task, from_cset->dfl_cgrp,
-						    to_cset->dfl_cgrp);
-			put_css_set_locked(from_cset);
-
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry(cset, &tset->src_csets, mg_node) {
+			list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
+				struct css_set *from_cset = task_css_set(task);
+				struct css_set *to_cset = cset->mg_dst_cset;
+
+				get_css_set(to_cset);
+				to_cset->nr_tasks++;
+				css_set_move_task(task, from_cset, to_cset, true);
+				from_cset->nr_tasks--;
+				/*
+				 * If the source or destination cgroup is frozen,
+				 * the task might require to change its state.
+				 */
+				cgroup_freezer_migrate_task(task, from_cset->dfl_cgrp,
+							    to_cset->dfl_cgrp);
+				put_css_set_locked(from_cset);
+			}
 		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * Migration is committed, all target tasks are now on dst_csets.
@@ -2683,13 +2666,13 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 		} while_each_subsys_mask();
 	}
 out_release_tset:
-	spin_lock_irq(&css_set_lock);
-	list_splice_init(&tset->dst_csets, &tset->src_csets);
-	list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
-		list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
-		list_del_init(&cset->mg_node);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_splice_init(&tset->dst_csets, &tset->src_csets);
+		list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
+			list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
+			list_del_init(&cset->mg_node);
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * Re-initialize the cgroup_taskset structure in case it is reused
@@ -2747,7 +2730,7 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	spin_lock_irq(&css_set_lock);
+	guard(spinlock_irq)(&css_set_lock);
 
 	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_src_csets,
 				 mg_src_preload_node) {
@@ -2766,8 +2749,6 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
 		list_del_init(&cset->mg_dst_preload_node);
 		put_css_set_locked(cset);
 	}
-
-	spin_unlock_irq(&css_set_lock);
 }
 
 /**
@@ -2910,14 +2891,14 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 	 * section to prevent tasks from being freed while taking the snapshot.
 	 * spin_lock_irq() implies RCU critical section here.
 	 */
-	spin_lock_irq(&css_set_lock);
-	task = leader;
-	do {
-		cgroup_migrate_add_task(task, mgctx);
-		if (!threadgroup)
-			break;
-	} while_each_thread(leader, task);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		task = leader;
+		do {
+			cgroup_migrate_add_task(task, mgctx);
+			if (!threadgroup)
+				break;
+		} while_each_thread(leader, task);
+	}
 
 	return cgroup_migrate_execute(mgctx);
 }
@@ -2938,16 +2919,15 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 	int ret = 0;
 
 	/* look up all src csets */
-	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
-	task = leader;
-	do {
-		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
-		if (!threadgroup)
-			break;
-	} while_each_thread(leader, task);
-	rcu_read_unlock();
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		guard(rcu)();
+		task = leader;
+		do {
+			cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
+			if (!threadgroup)
+				break;
+		} while_each_thread(leader, task);
+	}
 
 	/* prepare dst csets and commit */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3089,23 +3069,23 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_mutex);
 
 	/* look up all csses currently attached to @cgrp's subtree */
-	spin_lock_irq(&css_set_lock);
-	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
-		struct cgrp_cset_link *link;
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
+			struct cgrp_cset_link *link;
 
-		/*
-		 * As cgroup_update_dfl_csses() is only called by
-		 * cgroup_apply_control(). The csses associated with the
-		 * given cgrp will not be affected by changes made to
-		 * its subtree_control file. We can skip them.
-		 */
-		if (dsct == cgrp)
-			continue;
+			/*
+			 * As cgroup_update_dfl_csses() is only called by
+			 * cgroup_apply_control(). The csses associated with the
+			 * given cgrp will not be affected by changes made to
+			 * its subtree_control file. We can skip them.
+			 */
+			if (dsct == cgrp)
+				continue;
 
-		list_for_each_entry(link, &dsct->cset_links, cset_link)
-			cgroup_migrate_add_src(link->cset, dsct, &mgctx);
+			list_for_each_entry(link, &dsct->cset_links, cset_link)
+				cgroup_migrate_add_src(link->cset, dsct, &mgctx);
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	/*
 	 * We need to write-lock threadgroup_rwsem while migrating tasks.
@@ -3121,16 +3101,16 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	if (ret)
 		goto out_finish;
 
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
-			    mg_src_preload_node) {
-		struct task_struct *task, *ntask;
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
+				mg_src_preload_node) {
+			struct task_struct *task, *ntask;
 
-		/* all tasks in src_csets need to be migrated */
-		list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
-			cgroup_migrate_add_task(task, &mgctx);
+			/* all tasks in src_csets need to be migrated */
+			list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
+				cgroup_migrate_add_task(task, &mgctx);
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
@@ -3735,7 +3715,8 @@ static int cgroup_stat_show(struct seq_file *seq, void *v)
 	 * Without proper lock protection, racing is possible. So the
 	 * numbers may not be consistent when that happens.
 	 */
-	rcu_read_lock();
+	guard(rcu)();
+
 	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
 		dying_cnt[ssid] = -1;
 		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
@@ -3754,7 +3735,7 @@ static int cgroup_stat_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "nr_dying_subsys_%s %d\n",
 				   cgroup_subsys[ssid]->name, dying_cnt[ssid]);
 	}
-	rcu_read_unlock();
+
 	return 0;
 }
 
@@ -3772,11 +3753,10 @@ static struct cgroup_subsys_state *cgroup_tryget_css(struct cgroup *cgrp,
 {
 	struct cgroup_subsys_state *css;
 
-	rcu_read_lock();
+	guard(rcu)();
 	css = cgroup_css(cgrp, ss);
 	if (css && !css_tryget_online(css))
 		css = NULL;
-	rcu_read_unlock();
 
 	return css;
 }
@@ -4057,9 +4037,9 @@ static void __cgroup_kill(struct cgroup *cgrp)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	spin_lock_irq(&css_set_lock);
-	cgrp->kill_seq++;
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		cgrp->kill_seq++;
+	}
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
 	while ((task = css_task_iter_next(&it))) {
@@ -4188,9 +4168,9 @@ static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
 	 * doesn't need to be pinned.  The RCU locking is not necessary
 	 * either.  It's just for the convenience of using cgroup_css().
 	 */
-	rcu_read_lock();
-	css = cgroup_css(cgrp, cft->ss);
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		css = cgroup_css(cgrp, cft->ss);
+	}
 
 	if (cft->write_u64) {
 		unsigned long long v;
@@ -4302,9 +4282,8 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 
 		timer_setup(&cfile->notify_timer, cgroup_file_notify_timer, 0);
 
-		spin_lock_irq(&cgroup_file_kn_lock);
+		guard(spinlock_irq)(&css_set_lock);
 		cfile->kn = kn;
-		spin_unlock_irq(&cgroup_file_kn_lock);
 	}
 
 	return 0;
@@ -4472,9 +4451,9 @@ int cgroup_rm_cftypes(struct cftype *cfts)
 	if (!(cfts[0].flags & __CFTYPE_ADDED))
 		return -ENOENT;
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 	cgroup_rm_cftypes_locked(cfts);
-	cgroup_unlock();
+
 	return 0;
 }
 
@@ -4506,14 +4485,13 @@ int cgroup_add_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 	if (ret)
 		return ret;
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 
 	list_add_tail(&cfts->node, &ss->cfts);
 	ret = cgroup_apply_cftypes(cfts, true);
 	if (ret)
 		cgroup_rm_cftypes_locked(cfts);
 
-	cgroup_unlock();
 	return ret;
 }
 
@@ -4559,9 +4537,7 @@ int cgroup_add_legacy_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
  */
 void cgroup_file_notify(struct cgroup_file *cfile)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&cgroup_file_kn_lock, flags);
+	guard(spinlock_irqsave)(&cgroup_file_kn_lock);
 	if (cfile->kn) {
 		unsigned long last = cfile->notified_at;
 		unsigned long next = last + CGROUP_FILE_NOTIFY_MIN_INTV;
@@ -4573,7 +4549,6 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 			cfile->notified_at = jiffies;
 		}
 	}
-	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
 
 /**
@@ -4585,10 +4560,10 @@ void cgroup_file_show(struct cgroup_file *cfile, bool show)
 {
 	struct kernfs_node *kn;
 
-	spin_lock_irq(&cgroup_file_kn_lock);
-	kn = cfile->kn;
-	kernfs_get(kn);
-	spin_unlock_irq(&cgroup_file_kn_lock);
+	scoped_guard(spinlock_irq, &cgroup_file_kn_lock) {
+		kn = cfile->kn;
+		kernfs_get(kn);
+	}
 
 	if (kn)
 		kernfs_show(kn, show);
@@ -4816,14 +4791,14 @@ bool css_has_online_children(struct cgroup_subsys_state *css)
 	struct cgroup_subsys_state *child;
 	bool ret = false;
 
-	rcu_read_lock();
+	guard(rcu)();
 	css_for_each_child(child, css) {
 		if (child->flags & CSS_ONLINE) {
 			ret = true;
 			break;
 		}
 	}
-	rcu_read_unlock();
+
 	return ret;
 }
 
@@ -5012,11 +4987,9 @@ static void css_task_iter_advance(struct css_task_iter *it)
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it)
 {
-	unsigned long irqflags;
-
 	memset(it, 0, sizeof(*it));
 
-	spin_lock_irqsave(&css_set_lock, irqflags);
+	guard(spinlock_irqsave)(&css_set_lock);
 
 	it->ss = css->ss;
 	it->flags = flags;
@@ -5029,8 +5002,6 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 	it->cset_head = it->cset_pos;
 
 	css_task_iter_advance(it);
-
-	spin_unlock_irqrestore(&css_set_lock, irqflags);
 }
 
 /**
@@ -5043,14 +5014,12 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
  */
 struct task_struct *css_task_iter_next(struct css_task_iter *it)
 {
-	unsigned long irqflags;
-
 	if (it->cur_task) {
 		put_task_struct(it->cur_task);
 		it->cur_task = NULL;
 	}
 
-	spin_lock_irqsave(&css_set_lock, irqflags);
+	guard(spinlock_irqsave)(&css_set_lock);
 
 	/* @it may be half-advanced by skips, finish advancing */
 	if (it->flags & CSS_TASK_ITER_SKIPPED)
@@ -5063,8 +5032,6 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
 		css_task_iter_advance(it);
 	}
 
-	spin_unlock_irqrestore(&css_set_lock, irqflags);
-
 	return it->cur_task;
 }
 
@@ -5076,13 +5043,10 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
  */
 void css_task_iter_end(struct css_task_iter *it)
 {
-	unsigned long irqflags;
-
 	if (it->cur_cset) {
-		spin_lock_irqsave(&css_set_lock, irqflags);
+		guard(spinlock_irqsave)(&css_set_lock);
 		list_del(&it->iters_node);
 		put_css_set_locked(it->cur_cset);
-		spin_unlock_irqrestore(&css_set_lock, irqflags);
 	}
 
 	if (it->cur_dcset)
@@ -5248,9 +5212,9 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 		goto out_unlock;
 
 	/* find the source cgroup */
-	spin_lock_irq(&css_set_lock);
-	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
+	}
 
 	/*
 	 * Process and thread migrations follow same delegation rule. Check
@@ -5489,14 +5453,14 @@ static void css_free_rwork_fn(struct work_struct *work)
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
@@ -5532,11 +5496,11 @@ static void css_release_work_fn(struct work_struct *work)
 
 		css_rstat_flush(&cgrp->self);
 
-		spin_lock_irq(&css_set_lock);
-		for (tcgrp = cgroup_parent(cgrp); tcgrp;
-		     tcgrp = cgroup_parent(tcgrp))
-			tcgrp->nr_dying_descendants--;
-		spin_unlock_irq(&css_set_lock);
+		scoped_guard(spinlock_irq, &css_set_lock) {
+			for (tcgrp = cgroup_parent(cgrp); tcgrp;
+			     tcgrp = cgroup_parent(tcgrp))
+				tcgrp->nr_dying_descendants--;
+		}
 
 		/*
 		 * There are two control paths which try to determine
@@ -5549,8 +5513,14 @@ static void css_release_work_fn(struct work_struct *work)
 			RCU_INIT_POINTER(*(void __rcu __force **)&cgrp->kn->priv,
 					 NULL);
 	}
+}
 
-	cgroup_unlock();
+static void css_release_work_fn(struct work_struct *work)
+{
+	struct cgroup_subsys_state *css =
+		container_of(work, struct cgroup_subsys_state, destroy_work);
+
+	css_release_work_fn_locked(work);
 
 	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
 	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
@@ -5785,20 +5755,20 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 		goto out_psi_free;
 
 	/* allocation complete, commit to creation */
-	spin_lock_irq(&css_set_lock);
-	for (i = 0; i < level; i++) {
-		tcgrp = cgrp->ancestors[i];
-		tcgrp->nr_descendants++;
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		for (i = 0; i < level; i++) {
+			tcgrp = cgrp->ancestors[i];
+			tcgrp->nr_descendants++;
 
-		/*
-		 * If the new cgroup is frozen, all ancestor cgroups get a new
-		 * frozen descendant, but their state can't change because of
-		 * this.
-		 */
-		if (cgrp->freezer.e_freeze)
-			tcgrp->freezer.nr_frozen_descendants++;
+			/*
+			 * If the new cgroup is frozen, all ancestor cgroups get a new
+			 * frozen descendant, but their state can't change because of
+			 * this.
+			 */
+			if (cgrp->freezer.e_freeze)
+				tcgrp->freezer.nr_frozen_descendants++;
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
 	atomic_inc(&root->nr_cgrps);
@@ -5914,7 +5884,7 @@ static void css_killed_work_fn(struct work_struct *work)
 	struct cgroup_subsys_state *css =
 		container_of(work, struct cgroup_subsys_state, destroy_work);
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 
 	do {
 		offline_css(css);
@@ -5922,8 +5892,6 @@ static void css_killed_work_fn(struct work_struct *work)
 		/* @css can't go away while we're holding cgroup_mutex */
 		css = css->parent;
 	} while (css && atomic_dec_and_test(&css->online_cnt));
-
-	cgroup_unlock();
 }
 
 /* css kill confirmation processing requires process context, bounce */
@@ -6044,10 +6012,10 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	 */
 	cgrp->self.flags &= ~CSS_ONLINE;
 
-	spin_lock_irq(&css_set_lock);
-	list_for_each_entry(link, &cgrp->cset_links, cset_link)
-		link->cset->dead = true;
-	spin_unlock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		list_for_each_entry(link, &cgrp->cset_links, cset_link)
+			link->cset->dead = true;
+	}
 
 	/* initiate massacre of all css's */
 	for_each_css(css, ssid, cgrp)
@@ -6060,18 +6028,18 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	if (cgroup_is_threaded(cgrp))
 		parent->nr_threaded_children--;
 
-	spin_lock_irq(&css_set_lock);
-	for (tcgrp = parent; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
-		tcgrp->nr_descendants--;
-		tcgrp->nr_dying_descendants++;
-		/*
-		 * If the dying cgroup is frozen, decrease frozen descendants
-		 * counters of ancestor cgroups.
-		 */
-		if (test_bit(CGRP_FROZEN, &cgrp->flags))
-			tcgrp->freezer.nr_frozen_descendants--;
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		for (tcgrp = parent; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
+			tcgrp->nr_descendants--;
+			tcgrp->nr_dying_descendants++;
+			/*
+			 * If the dying cgroup is frozen, decrease frozen descendants
+			 * counters of ancestor cgroups.
+			 */
+			if (test_bit(CGRP_FROZEN, &cgrp->flags))
+				tcgrp->freezer.nr_frozen_descendants--;
+		}
 	}
-	spin_unlock_irq(&css_set_lock);
 
 	cgroup1_check_for_release(parent);
 
@@ -6115,7 +6083,7 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 
 	pr_debug("Initializing cgroup subsys %s\n", ss->name);
 
-	cgroup_lock();
+	guard(cgroup_mutex)();
 
 	idr_init(&ss->css_idr);
 	INIT_LIST_HEAD(&ss->cfts);
@@ -6161,8 +6129,6 @@ static void __init cgroup_init_subsys(struct cgroup_subsys *ss, bool early)
 	BUG_ON(!list_empty(&init_task.tasks));
 
 	BUG_ON(online_css(css));
-
-	cgroup_unlock();
 }
 
 /**
@@ -6224,20 +6190,18 @@ int __init cgroup_init(void)
 
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
+				css_set_hash(init_css_set.subsys));
 
-	BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
+		cgroup_bpf_lifetime_notifier_init();
 
-	cgroup_unlock();
+		BUG_ON(cgroup_setup_root(&cgrp_dfl_root, 0));
+	}
 
 	for_each_subsys(ss, ssid) {
 		if (ss->early_init) {
@@ -6289,9 +6253,9 @@ int __init cgroup_init(void)
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
@@ -6357,13 +6321,12 @@ struct cgroup *cgroup_get_from_id(u64 id)
 		return ERR_PTR(-ENOENT);
 	}
 
-	rcu_read_lock();
-
-	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
-	if (cgrp && !cgroup_tryget(cgrp))
-		cgrp = NULL;
+	scoped_guard(rcu) {
+		cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
+		if (cgrp && !cgroup_tryget(cgrp))
+			cgrp = NULL;
+	}
 
-	rcu_read_unlock();
 	kernfs_put(kn);
 
 	if (!cgrp)
@@ -6540,15 +6503,14 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 
 	cgroup_threadgroup_change_begin(current);
 
-	spin_lock_irq(&css_set_lock);
-	cset = task_css_set(current);
-	get_css_set(cset);
-	if (kargs->cgrp)
-		kargs->kill_seq = kargs->cgrp->kill_seq;
-	else
-		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
-	spin_unlock_irq(&css_set_lock);
-
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		cset = task_css_set(current);
+		get_css_set(cset);
+		if (kargs->cgrp)
+			kargs->kill_seq = kargs->cgrp->kill_seq;
+		else
+			kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+	}
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
 		kargs->cset = cset;
 		return 0;
@@ -6737,56 +6699,54 @@ void cgroup_post_fork(struct task_struct *child,
 	cset = kargs->cset;
 	kargs->cset = NULL;
 
-	spin_lock_irq(&css_set_lock);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		/* init tasks are special, only link regular threads */
+		if (likely(child->pid)) {
+			if (kargs->cgrp) {
+				cgrp_flags = kargs->cgrp->flags;
+				cgrp_kill_seq = kargs->cgrp->kill_seq;
+			} else {
+				cgrp_flags = cset->dfl_cgrp->flags;
+				cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
+			}
 
-	/* init tasks are special, only link regular threads */
-	if (likely(child->pid)) {
-		if (kargs->cgrp) {
-			cgrp_flags = kargs->cgrp->flags;
-			cgrp_kill_seq = kargs->cgrp->kill_seq;
+			WARN_ON_ONCE(!list_empty(&child->cg_list));
+			cset->nr_tasks++;
+			css_set_move_task(child, NULL, cset, false);
 		} else {
-			cgrp_flags = cset->dfl_cgrp->flags;
-			cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
+			put_css_set(cset);
+			cset = NULL;
 		}
 
-		WARN_ON_ONCE(!list_empty(&child->cg_list));
-		cset->nr_tasks++;
-		css_set_move_task(child, NULL, cset, false);
-	} else {
-		put_css_set(cset);
-		cset = NULL;
-	}
-
-	if (!(child->flags & PF_KTHREAD)) {
-		if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
-			/*
-			 * If the cgroup has to be frozen, the new task has
-			 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
-			 * get the task into the frozen state.
-			 */
-			spin_lock(&child->sighand->siglock);
-			WARN_ON_ONCE(child->frozen);
-			child->jobctl |= JOBCTL_TRAP_FREEZE;
-			spin_unlock(&child->sighand->siglock);
+		if (!(child->flags & PF_KTHREAD)) {
+			if (unlikely(test_bit(CGRP_FREEZE, &cgrp_flags))) {
+				/*
+				 * If the cgroup has to be frozen, the new task has
+				 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
+				 * get the task into the frozen state.
+				 */
+				spin_lock(&child->sighand->siglock);
+				WARN_ON_ONCE(child->frozen);
+				child->jobctl |= JOBCTL_TRAP_FREEZE;
+				spin_unlock(&child->sighand->siglock);
+
+				/*
+				 * Calling cgroup_update_frozen() isn't required here,
+				 * because it will be called anyway a bit later from
+				 * do_freezer_trap(). So we avoid cgroup's transient
+				 * switch from the frozen state and back.
+				 */
+			}
 
 			/*
-			 * Calling cgroup_update_frozen() isn't required here,
-			 * because it will be called anyway a bit later from
-			 * do_freezer_trap(). So we avoid cgroup's transient
-			 * switch from the frozen state and back.
+			 * If the cgroup is to be killed notice it now and take the
+			 * child down right after we finished preparing it for
+			 * userspace.
 			 */
+			kill = kargs->kill_seq != cgrp_kill_seq;
 		}
-
-		/*
-		 * If the cgroup is to be killed notice it now and take the
-		 * child down right after we finished preparing it for
-		 * userspace.
-		 */
-		kill = kargs->kill_seq != cgrp_kill_seq;
 	}
 
-	spin_unlock_irq(&css_set_lock);
-
 	/*
 	 * Call ss->fork().  This must happen after @child is linked on
 	 * css_set; otherwise, @child might change state between ->fork()
@@ -6825,26 +6785,23 @@ void cgroup_exit(struct task_struct *tsk)
 	struct css_set *cset;
 	int i;
 
-	spin_lock_irq(&css_set_lock);
-
-	WARN_ON_ONCE(list_empty(&tsk->cg_list));
-	cset = task_css_set(tsk);
-	css_set_move_task(tsk, cset, NULL, false);
-	cset->nr_tasks--;
-	/* matches the signal->live check in css_task_iter_advance() */
-	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
-		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
+	scoped_guard(spinlock_irq, &css_set_lock) {
+		WARN_ON_ONCE(list_empty(&tsk->cg_list));
+		cset = task_css_set(tsk);
+		css_set_move_task(tsk, cset, NULL, false);
+		cset->nr_tasks--;
+		/* matches the signal->live check in css_task_iter_advance() */
+		if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
+			list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 
-	if (dl_task(tsk))
-		dec_dl_tasks_cs(tsk);
-
-	WARN_ON_ONCE(cgroup_task_frozen(tsk));
-	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
-		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
-		cgroup_update_frozen(task_dfl_cgroup(tsk));
-
-	spin_unlock_irq(&css_set_lock);
+		if (dl_task(tsk))
+			dec_dl_tasks_cs(tsk);
 
+		WARN_ON_ONCE(cgroup_task_frozen(tsk));
+		if (unlikely(!(tsk->flags & PF_KTHREAD) &&
+			test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
+			cgroup_update_frozen(task_dfl_cgroup(tsk));
+	}
 	/* see cgroup_post_fork() for details */
 	do_each_subsys_mask(ss, i, have_exit_callback) {
 		ss->exit(tsk);
@@ -6861,10 +6818,9 @@ void cgroup_release(struct task_struct *task)
 	} while_each_subsys_mask();
 
 	if (!list_empty(&task->cg_list)) {
-		spin_lock_irq(&css_set_lock);
+		guard(spinlock_irq)(&css_set_lock);
 		css_set_skip_task_iters(task_css_set(task), task);
 		list_del_init(&task->cg_list);
-		spin_unlock_irq(&css_set_lock);
 	}
 }
 
@@ -6945,7 +6901,7 @@ struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
 	    !kn || kernfs_type(kn) != KERNFS_DIR)
 		return ERR_PTR(-EBADF);
 
-	rcu_read_lock();
+	guard(rcu)();
 
 	/*
 	 * This path doesn't originate from kernfs and @kn could already
@@ -6959,7 +6915,6 @@ struct cgroup_subsys_state *css_tryget_online_from_dir(struct dentry *dentry,
 	if (!css || !css_tryget_online(css))
 		css = ERR_PTR(-ENOENT);
 
-	rcu_read_unlock();
 	return css;
 }
 
-- 
2.43.0


