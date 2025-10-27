Return-Path: <cgroups+bounces-11223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABFAC1207B
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430B656814A
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6648337689;
	Mon, 27 Oct 2025 23:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CYv0nBng"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C033033E
	for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607384; cv=none; b=q/1Yn1012dW3YTWRzZ2236fZVAHf64jtQMRfqniHedR0Y2I1YGrjcea6qtTVU8cxsBerrSZhN3mfBZRhkiYxf5eKkZOZsbQTXic3wTWq7FkjnxN9GMnbQ4PUzqHMh9wv8ttt4V6v179rG/18mkslwrT+IRUWQgebSKtjM6PCPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607384; c=relaxed/simple;
	bh=HUio66TT7nDKsR250tORuJy9QWI9jSxJRJ9SxkBO5jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZMcMQPDf/AXPi6xWPW1JS07OYn0k7rvgpjSMxDxtPPmaB3fBWC+HkbAScSCsW1/PDklLGvJuuO9D50kQUgKx9CDFhmuhDb5oElQ3RkcCnKO7+UjKFuRzo5AtiTEeXNk1944qsffFryf6y1kEVZnizY7ukSzo59vwkYWkGVeRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CYv0nBng; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xkRFUnfJK3RilKr2WpTSfrNF5cDwB+gJb6qAIcfaX8=;
	b=CYv0nBngUlIE7VqJTMpfgNQ047eESqyrt4/trxdctM2sEDxUdHsr8C0cqE2TaZkHHWmiTQ
	LWD0dNUhrHmI+utUcMRHQTZ0u5V9CVgVMcchoKc7n77n8E9qrv4Hqucza5nCsoq/KfkN1t
	74khqGacpomZArwqvsY6PPElMpRqTe0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 20/23] sched: psi: implement bpf_psi struct ops
Date: Mon, 27 Oct 2025 16:22:03 -0700
Message-ID: <20251027232206.473085-10-roman.gushchin@linux.dev>
In-Reply-To: <20251027232206.473085-1-roman.gushchin@linux.dev>
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch implements a BPF struct ops-based mechanism to create
PSI triggers, attach them to cgroups or system wide and handle
PSI events in BPF.

The struct ops provides 3 callbacks:
  - init() called once at load, handy for creating PSI triggers
  - handle_psi_event() called every time a PSI trigger fires
  - handle_cgroup_online() called when a new cgroup is created
  - handle_cgroup_offline() called if a cgroup with an attached
    trigger is deleted

A single struct ops can create a number of PSI triggers, both
cgroup-scoped and system-wide.

All 4 struct ops callbacks can be sleepable. handle_psi_event()
handlers are executed using a separate workqueue, so it won't
affect the latency of other PSI triggers.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf_psi.h      |  87 ++++++++++
 include/linux/psi_types.h    |  43 ++++-
 kernel/bpf/cgroup.c          |   3 +
 kernel/sched/bpf_psi.c       | 302 +++++++++++++++++++++++++++++++++++
 kernel/sched/build_utility.c |   4 +
 kernel/sched/psi.c           |  48 ++++--
 mm/oom_kill.c                |   3 +
 7 files changed, 478 insertions(+), 12 deletions(-)
 create mode 100644 include/linux/bpf_psi.h
 create mode 100644 kernel/sched/bpf_psi.c

diff --git a/include/linux/bpf_psi.h b/include/linux/bpf_psi.h
new file mode 100644
index 000000000000..023bef0595ee
--- /dev/null
+++ b/include/linux/bpf_psi.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __BPF_PSI_H
+#define __BPF_PSI_H
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/srcu.h>
+#include <linux/psi_types.h>
+
+struct cgroup;
+struct bpf_psi;
+struct psi_trigger;
+struct psi_trigger_params;
+
+#define BPF_PSI_FULL 0x80000000
+
+struct bpf_psi_ops {
+	/**
+	 * @init: Initialization callback, suited for creating psi triggers.
+	 * @bpf_psi: bpf_psi pointer, can be passed to bpf_psi_create_trigger().
+	 *
+	 * A non-0 return value means the initialization has been failed.
+	 */
+	int (*init)(struct bpf_psi *bpf_psi);
+
+	/**
+	 * @handle_psi_event: PSI event callback
+	 * @t: psi_trigger pointer
+	 */
+	void (*handle_psi_event)(struct bpf_psi *bpf_psi, struct psi_trigger *t);
+
+	/**
+	 * @handle_cgroup_online: Cgroup online callback
+	 * @cgroup_id: Id of the new cgroup
+	 *
+	 * Called every time a new cgroup is created. Can be used
+	 * to create new psi triggers.
+	 */
+	void (*handle_cgroup_online)(struct bpf_psi *bpf_psi, u64 cgroup_id);
+
+	/**
+	 * @handle_cgroup_offline: Cgroup offline callback
+	 * @cgroup_id: Id of offlined cgroup
+	 *
+	 * Called every time a cgroup with an attached bpf psi trigger is
+	 * offlined.
+	 */
+	void (*handle_cgroup_offline)(struct bpf_psi *bpf_psi, u64 cgroup_id);
+
+	/* private */
+	struct bpf_psi *bpf_psi;
+};
+
+struct bpf_psi {
+	spinlock_t lock;
+	struct list_head triggers;
+	struct bpf_psi_ops *ops;
+	struct srcu_struct srcu;
+	struct list_head node; /* Protected by bpf_psi_lock */
+};
+
+#ifdef CONFIG_BPF_SYSCALL
+void bpf_psi_add_trigger(struct psi_trigger *t,
+			 const struct psi_trigger_params *params);
+void bpf_psi_remove_trigger(struct psi_trigger *t);
+void bpf_psi_handle_event(struct psi_trigger *t);
+
+#else /* CONFIG_BPF_SYSCALL */
+static inline void bpf_psi_add_trigger(struct psi_trigger *t,
+			const struct psi_trigger_params *params) {}
+static inline void bpf_psi_remove_trigger(struct psi_trigger *t) {}
+static inline void bpf_psi_handle_event(struct psi_trigger *t) {}
+
+#endif /* CONFIG_BPF_SYSCALL */
+
+#if (defined(CONFIG_CGROUPS) && defined(CONFIG_PSI) && defined(CONFIG_BPF_SYSCALL))
+void bpf_psi_cgroup_online(struct cgroup *cgroup);
+void bpf_psi_cgroup_offline(struct cgroup *cgroup);
+
+#else /* CONFIG_CGROUPS && CONFIG_PSI && CONFIG_BPF_SYSCALL */
+static inline void bpf_psi_cgroup_online(struct cgroup *cgroup) {}
+static inline void bpf_psi_cgroup_offline(struct cgroup *cgroup) {}
+
+#endif /* CONFIG_CGROUPS && CONFIG_PSI && CONFIG_BPF_SYSCALL */
+
+#endif /* __BPF_PSI_H */
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index aa5ed39592cb..e551df9d6336 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -122,6 +122,7 @@ struct psi_window {
 enum psi_trigger_type {
 	PSI_SYSTEM,
 	PSI_CGROUP,
+	PSI_BPF,
 };
 
 struct psi_trigger_params {
@@ -143,8 +144,15 @@ struct psi_trigger_params {
 	/* Privileged triggers are treated differently */
 	bool privileged;
 
-	/* Link to kernfs open file, only for PSI_CGROUP */
-	struct kernfs_open_file *of;
+	union {
+		/* Link to kernfs open file, only for PSI_CGROUP */
+		struct kernfs_open_file *of;
+
+#ifdef CONFIG_BPF_SYSCALL
+		/* Link to bpf_psi structure, only for BPF_PSI */
+		struct bpf_psi *bpf_psi;
+#endif
+	};
 };
 
 struct psi_trigger {
@@ -186,6 +194,31 @@ struct psi_trigger {
 
 	/* Trigger type - PSI_AVGS for unprivileged, PSI_POLL for RT */
 	enum psi_aggregators aggregator;
+
+#ifdef CONFIG_BPF_SYSCALL
+	/* Fields specific to PSI_BPF triggers */
+
+	/* Bpf psi structure for events handling */
+	struct bpf_psi *bpf_psi;
+
+	/* List node inside bpf_psi->triggers list */
+	struct list_head bpf_psi_node;
+
+	/* List node inside group->bpf_triggers list */
+	struct list_head bpf_group_node;
+
+	/* Work structure, used to execute event handlers */
+	struct work_struct bpf_work;
+
+	/*
+	 * Whether the trigger is being pinned in memory.
+	 * Protected by group->bpf_triggers_lock.
+	 */
+	bool pinned;
+
+	/* Cgroup Id */
+	u64 cgroup_id;
+#endif
 };
 
 struct psi_group {
@@ -234,6 +267,12 @@ struct psi_group {
 	u64 rtpoll_total[NR_PSI_STATES - 1];
 	u64 rtpoll_next_update;
 	u64 rtpoll_until;
+
+#ifdef CONFIG_BPF_SYSCALL
+	/* List of triggers owned by bpf and corresponding lock */
+	spinlock_t bpf_triggers_lock;
+	struct list_head bpf_triggers;
+#endif
 };
 
 #else /* CONFIG_PSI */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 248f517d66d0..4df4c49ba179 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -15,6 +15,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf-cgroup.h>
 #include <linux/bpf_lsm.h>
+#include <linux/bpf_psi.h>
 #include <linux/bpf_verifier.h>
 #include <net/sock.h>
 #include <net/bpf_sk_storage.h>
@@ -557,9 +558,11 @@ static int cgroup_bpf_lifetime_notify(struct notifier_block *nb,
 
 	switch (action) {
 	case CGROUP_LIFETIME_ONLINE:
+		bpf_psi_cgroup_online(cgrp);
 		ret = cgroup_bpf_inherit(cgrp);
 		break;
 	case CGROUP_LIFETIME_OFFLINE:
+		bpf_psi_cgroup_offline(cgrp);
 		cgroup_bpf_offline(cgrp);
 		break;
 	}
diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
new file mode 100644
index 000000000000..c383a20119a6
--- /dev/null
+++ b/kernel/sched/bpf_psi.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * BPF PSI event handlers
+ *
+ * Author: Roman Gushchin <roman.gushchin@linux.dev>
+ */
+
+#include <linux/bpf_psi.h>
+#include <linux/cgroup-defs.h>
+
+static struct workqueue_struct *bpf_psi_wq;
+
+static DEFINE_MUTEX(bpf_psi_lock);
+static LIST_HEAD(bpf_psi_notify_list);
+static DEFINE_STATIC_KEY_FALSE(bpf_psi_notify_key);
+
+static struct bpf_psi *bpf_psi_create(struct bpf_psi_ops *ops)
+{
+	struct bpf_psi *bpf_psi;
+
+	bpf_psi = kzalloc(sizeof(*bpf_psi), GFP_KERNEL);
+	if (!bpf_psi)
+		return NULL;
+
+	if (init_srcu_struct(&bpf_psi->srcu)) {
+		kfree(bpf_psi);
+		return NULL;
+	}
+
+	spin_lock_init(&bpf_psi->lock);
+	bpf_psi->ops = ops;
+	INIT_LIST_HEAD(&bpf_psi->triggers);
+	ops->bpf_psi = bpf_psi;
+
+	if (ops->handle_cgroup_online) {
+		mutex_lock(&bpf_psi_lock);
+		list_add(&bpf_psi->node, &bpf_psi_notify_list);
+		mutex_unlock(&bpf_psi_lock);
+		static_branch_inc(&bpf_psi_notify_key);
+	} else {
+		INIT_LIST_HEAD(&bpf_psi->node);
+	}
+
+	return bpf_psi;
+}
+
+static void bpf_psi_handle_event_fn(struct work_struct *work)
+{
+	struct psi_trigger *t;
+	struct bpf_psi *bpf_psi;
+	int idx;
+
+	t = container_of(work, struct psi_trigger, bpf_work);
+	bpf_psi = READ_ONCE(t->bpf_psi);
+
+	if (likely(bpf_psi)) {
+		idx = srcu_read_lock(&bpf_psi->srcu);
+		bpf_psi->ops->handle_psi_event(bpf_psi, t);
+		srcu_read_unlock(&bpf_psi->srcu, idx);
+	}
+}
+
+void bpf_psi_add_trigger(struct psi_trigger *t,
+			 const struct psi_trigger_params *params)
+{
+	t->bpf_psi = params->bpf_psi;
+	t->pinned = false;
+	INIT_WORK(&t->bpf_work, bpf_psi_handle_event_fn);
+
+	spin_lock(&t->bpf_psi->lock);
+	list_add(&t->bpf_psi_node, &t->bpf_psi->triggers);
+	spin_unlock(&t->bpf_psi->lock);
+
+	spin_lock(&t->group->bpf_triggers_lock);
+	list_add(&t->bpf_group_node, &t->group->bpf_triggers);
+	spin_unlock(&t->group->bpf_triggers_lock);
+}
+
+void bpf_psi_remove_trigger(struct psi_trigger *t)
+{
+	spin_lock(&t->group->bpf_triggers_lock);
+	list_del(&t->bpf_group_node);
+	spin_unlock(&t->group->bpf_triggers_lock);
+
+	spin_lock(&t->bpf_psi->lock);
+	list_del(&t->bpf_psi_node);
+	spin_unlock(&t->bpf_psi->lock);
+}
+
+#ifdef CONFIG_CGROUPS
+void bpf_psi_cgroup_online(struct cgroup *cgroup)
+{
+	struct bpf_psi *bpf_psi;
+	int idx;
+
+	if (!static_branch_likely(&bpf_psi_notify_key))
+		return;
+
+	mutex_lock(&bpf_psi_lock);
+	list_for_each_entry(bpf_psi, &bpf_psi_notify_list, node) {
+		idx = srcu_read_lock(&bpf_psi->srcu);
+		if (bpf_psi->ops->handle_cgroup_online)
+			bpf_psi->ops->handle_cgroup_online(bpf_psi,
+						cgroup_id(cgroup));
+		srcu_read_unlock(&bpf_psi->srcu, idx);
+	}
+	mutex_unlock(&bpf_psi_lock);
+}
+
+void bpf_psi_cgroup_offline(struct cgroup *cgroup)
+{
+	struct psi_group *group = cgroup->psi;
+	u64 cgrp_id = cgroup_id(cgroup);
+	struct psi_trigger *t, *p;
+	struct bpf_psi *bpf_psi;
+	LIST_HEAD(to_destroy);
+	int idx;
+
+	if (!group)
+		return;
+
+	spin_lock(&group->bpf_triggers_lock);
+	list_for_each_entry_safe(t, p, &group->bpf_triggers, bpf_group_node) {
+		if (!t->pinned) {
+			t->pinned = true;
+			list_move(&t->bpf_group_node, &to_destroy);
+		}
+	}
+	spin_unlock(&group->bpf_triggers_lock);
+
+	list_for_each_entry_safe(t, p, &to_destroy, bpf_group_node) {
+		bpf_psi = READ_ONCE(t->bpf_psi);
+
+		idx = srcu_read_lock(&bpf_psi->srcu);
+		if (bpf_psi->ops->handle_cgroup_offline)
+			bpf_psi->ops->handle_cgroup_offline(bpf_psi, cgrp_id);
+		srcu_read_unlock(&bpf_psi->srcu, idx);
+
+		spin_lock(&bpf_psi->lock);
+		list_del(&t->bpf_psi_node);
+		spin_unlock(&bpf_psi->lock);
+
+		WRITE_ONCE(t->bpf_psi, NULL);
+		flush_workqueue(bpf_psi_wq);
+		synchronize_srcu(&bpf_psi->srcu);
+		psi_trigger_destroy(t);
+	}
+}
+#endif
+
+void bpf_psi_handle_event(struct psi_trigger *t)
+{
+	queue_work(bpf_psi_wq, &t->bpf_work);
+}
+
+/* BPF struct ops */
+
+static int __bpf_psi_init(struct bpf_psi *bpf_psi) { return 0; }
+static void __bpf_psi_handle_psi_event(struct bpf_psi *bpf_psi, struct psi_trigger *t) {}
+static void __bpf_psi_handle_cgroup_online(struct bpf_psi *bpf_psi, u64 cgroup_id) {}
+static void __bpf_psi_handle_cgroup_offline(struct bpf_psi *bpf_psi, u64 cgroup_id) {}
+
+static struct bpf_psi_ops __bpf_psi_ops = {
+	.init = __bpf_psi_init,
+	.handle_psi_event = __bpf_psi_handle_psi_event,
+	.handle_cgroup_online = __bpf_psi_handle_cgroup_online,
+	.handle_cgroup_offline = __bpf_psi_handle_cgroup_offline,
+};
+
+static const struct bpf_func_proto *
+bpf_psi_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	return tracing_prog_func_proto(func_id, prog);
+}
+
+static bool bpf_psi_ops_is_valid_access(int off, int size,
+					enum bpf_access_type type,
+					const struct bpf_prog *prog,
+					struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+static const struct bpf_verifier_ops bpf_psi_verifier_ops = {
+	.get_func_proto = bpf_psi_func_proto,
+	.is_valid_access = bpf_psi_ops_is_valid_access,
+};
+
+static int bpf_psi_ops_reg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_psi_ops *ops = kdata;
+	struct bpf_psi *bpf_psi;
+
+	bpf_psi = bpf_psi_create(ops);
+	if (!bpf_psi)
+		return -ENOMEM;
+
+	return ops->init(bpf_psi);
+}
+
+static void bpf_psi_ops_unreg(void *kdata, struct bpf_link *link)
+{
+	struct bpf_psi_ops *ops = kdata;
+	struct bpf_psi *bpf_psi = ops->bpf_psi;
+	struct psi_trigger *t, *p;
+	LIST_HEAD(to_destroy);
+
+	spin_lock(&bpf_psi->lock);
+	list_for_each_entry_safe(t, p, &bpf_psi->triggers, bpf_psi_node) {
+		spin_lock(&t->group->bpf_triggers_lock);
+		if (!t->pinned) {
+			t->pinned = true;
+			list_move(&t->bpf_group_node, &to_destroy);
+			list_del(&t->bpf_psi_node);
+
+			WRITE_ONCE(t->bpf_psi, NULL);
+		}
+		spin_unlock(&t->group->bpf_triggers_lock);
+	}
+	spin_unlock(&bpf_psi->lock);
+
+	flush_workqueue(bpf_psi_wq);
+	synchronize_srcu(&bpf_psi->srcu);
+
+	list_for_each_entry_safe(t, p, &to_destroy, bpf_group_node)
+		psi_trigger_destroy(t);
+
+	if (!list_empty(&bpf_psi->node)) {
+		mutex_lock(&bpf_psi_lock);
+		list_del(&bpf_psi->node);
+		mutex_unlock(&bpf_psi_lock);
+		static_branch_dec(&bpf_psi_notify_key);
+	}
+
+	cleanup_srcu_struct(&bpf_psi->srcu);
+	kfree(bpf_psi);
+}
+
+static int bpf_psi_ops_check_member(const struct btf_type *t,
+				    const struct btf_member *member,
+				    const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct bpf_psi_ops, init):
+		fallthrough;
+	case offsetof(struct bpf_psi_ops, handle_psi_event):
+		if (!prog)
+			return -EINVAL;
+		break;
+	}
+
+	return 0;
+}
+
+static int bpf_psi_ops_init_member(const struct btf_type *t,
+				   const struct btf_member *member,
+				   void *kdata, const void *udata)
+{
+	return 0;
+}
+
+static int bpf_psi_ops_init(struct btf *btf)
+{
+	return 0;
+}
+
+struct bpf_struct_ops bpf_psi_bpf_ops = {
+	.verifier_ops = &bpf_psi_verifier_ops,
+	.reg = bpf_psi_ops_reg,
+	.unreg = bpf_psi_ops_unreg,
+	.check_member = bpf_psi_ops_check_member,
+	.init_member = bpf_psi_ops_init_member,
+	.init = bpf_psi_ops_init,
+	.name = "bpf_psi_ops",
+	.owner = THIS_MODULE,
+	.cfi_stubs = &__bpf_psi_ops
+};
+
+static int __init bpf_psi_struct_ops_init(void)
+{
+	int wq_flags = WQ_MEM_RECLAIM | WQ_UNBOUND | WQ_HIGHPRI;
+	int err;
+
+	bpf_psi_wq = alloc_workqueue("bpf_psi_wq", wq_flags, 0);
+	if (!bpf_psi_wq)
+		return -ENOMEM;
+
+	err = register_bpf_struct_ops(&bpf_psi_bpf_ops, bpf_psi_ops);
+	if (err) {
+		pr_warn("error while registering bpf psi struct ops: %d", err);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	destroy_workqueue(bpf_psi_wq);
+	return err;
+}
+late_initcall(bpf_psi_struct_ops_init);
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index e2cf3b08d4e9..1f90781781a1 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -19,6 +19,7 @@
 #include <linux/sched/rseq_api.h>
 #include <linux/sched/task_stack.h>
 
+#include <linux/bpf_psi.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask_api.h>
 #include <linux/cpuset.h>
@@ -91,6 +92,9 @@
 
 #ifdef CONFIG_PSI
 # include "psi.c"
+# ifdef CONFIG_BPF_SYSCALL
+#  include "bpf_psi.c"
+# endif
 #endif
 
 #ifdef CONFIG_MEMBARRIER
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 73fdc79b5602..26de772750e8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -223,6 +223,10 @@ static void group_init(struct psi_group *group)
 	init_waitqueue_head(&group->rtpoll_wait);
 	timer_setup(&group->rtpoll_timer, poll_timer_fn, 0);
 	rcu_assign_pointer(group->rtpoll_task, NULL);
+#ifdef CONFIG_BPF_SYSCALL
+	spin_lock_init(&group->bpf_triggers_lock);
+	INIT_LIST_HEAD(&group->bpf_triggers);
+#endif
 }
 
 void __init psi_init(void)
@@ -511,10 +515,17 @@ static void update_triggers(struct psi_group *group, u64 now,
 
 		/* Generate an event */
 		if (cmpxchg(&t->event, 0, 1) == 0) {
-			if (t->type == PSI_CGROUP)
-				kernfs_notify(t->of->kn);
-			else
+			switch (t->type) {
+			case PSI_SYSTEM:
 				wake_up_interruptible(&t->event_wait);
+				break;
+			case PSI_CGROUP:
+				kernfs_notify(t->of->kn);
+				break;
+			case PSI_BPF:
+				bpf_psi_handle_event(t);
+				break;
+			}
 		}
 		t->last_event_time = now;
 		/* Reset threshold breach flag once event got generated */
@@ -1368,6 +1379,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	case PSI_CGROUP:
 		t->of = params->of;
 		break;
+	case PSI_BPF:
+		bpf_psi_add_trigger(t, params);
+		break;
 	}
 
 	t->pending_event = false;
@@ -1381,8 +1395,10 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 
 			task = kthread_create(psi_rtpoll_worker, group, "psimon");
 			if (IS_ERR(task)) {
-				kfree(t);
 				mutex_unlock(&group->rtpoll_trigger_lock);
+				if (t->type == PSI_BPF)
+					bpf_psi_remove_trigger(t);
+				kfree(t);
 				return ERR_CAST(task);
 			}
 			atomic_set(&group->rtpoll_wakeup, 0);
@@ -1426,10 +1442,16 @@ void psi_trigger_destroy(struct psi_trigger *t)
 	 * being accessed later. Can happen if cgroup is deleted from under a
 	 * polling process.
 	 */
-	if (t->type == PSI_CGROUP)
-		kernfs_notify(t->of->kn);
-	else
+	switch (t->type) {
+	case PSI_SYSTEM:
 		wake_up_interruptible(&t->event_wait);
+		break;
+	case PSI_CGROUP:
+		kernfs_notify(t->of->kn);
+		break;
+	case PSI_BPF:
+		break;
+	}
 
 	if (t->aggregator == PSI_AVGS) {
 		mutex_lock(&group->avgs_lock);
@@ -1506,10 +1528,16 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
-	if (t->type == PSI_CGROUP)
-		kernfs_generic_poll(t->of, wait);
-	else
+	switch (t->type) {
+	case PSI_SYSTEM:
 		poll_wait(file, &t->event_wait, wait);
+		break;
+	case PSI_CGROUP:
+		kernfs_generic_poll(t->of, wait);
+		break;
+	case PSI_BPF:
+		break;
+	}
 
 	if (cmpxchg(&t->event, 1, 0) == 1)
 		ret |= EPOLLPRI;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 90bb86dee3cf..65a3b4c1fc72 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1429,6 +1429,9 @@ static int bpf_oom_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
 	if (!btf_id_set_contains(&bpf_oom_declare_oom_kfuncs, kfunc_id))
 		return 0;
 
+	if (IS_ENABLED(CONFIG_PSI) && prog->aux->st_ops == &bpf_psi_bpf_ops)
+		return 0;
+
 	return -EACCES;
 }
 
-- 
2.51.0


