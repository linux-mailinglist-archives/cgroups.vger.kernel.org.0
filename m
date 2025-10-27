Return-Path: <cgroups+bounces-11224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B041BC1204A
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 00:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CA7D50423D
	for <lists+cgroups@lfdr.de>; Mon, 27 Oct 2025 23:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D30330B26;
	Mon, 27 Oct 2025 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p/Lu2sXE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646233376A0
	for <cgroups@vger.kernel.org>; Mon, 27 Oct 2025 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607389; cv=none; b=KgJhSN+UEw4BDySJnu10hjE/ZfymqOkzdu4NPXcUlD5ermrFkxKN/L5JcuQHBCpwwVvTO9NhDYiEc4jcwKvJ1opdrMAmEPRN9LRWWcHmnmNGY/q9tuL+lAgWmfzb6Ri0Z8uZz9hal+BvjM6+6BhC2UerI+saGZebxgVR0Tccv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607389; c=relaxed/simple;
	bh=V+BqBuUhZU6LUTQXUF+N282bMniIh55u7L7hWZCeWIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k945DvB3vXtKljNqEojZWXC+jSIJL2ACl/7OwuK4whWNSQWOF0haLubiyCqoPDHR1XaLcMSRnF8fkua9wx/L2QruNz7Rz8M4afh2hKOaziB3p3bvzMMCe+chzYdI4MbjC/3NLE0ESe9G4LV5WzSmcq7pdXrYgJZDXcoZDvdGKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p/Lu2sXE; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lcUERGoKvh9PFKX2k3uR30HfIjjPLoVT2q61yUz9W4I=;
	b=p/Lu2sXEzfGcwOwxRnjlbNY/BKvyTqMTn7GHro+sqQK/vlPBmQsMlshpqc6W7BmNZmBdcR
	dr23gqS9XD5tk1Q+L+Gw+49EkBUFtQTBT92t7vRp4B+D0c2gxVuTOdYxyIjPa7LlTz6tQg
	ONwaXmOaO8N6uUSuW4ZNW2yY/X6uoP4=
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
Subject: [PATCH v2 21/23] sched: psi: implement bpf_psi_create_trigger() kfunc
Date: Mon, 27 Oct 2025 16:22:04 -0700
Message-ID: <20251027232206.473085-11-roman.gushchin@linux.dev>
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

Implement a new bpf_psi_create_trigger() BPF kfunc, which allows
to create new PSI triggers and attach them to cgroups or be
system-wide.

Created triggers will exist until the struct ops is loaded and
if they are attached to a cgroup until the cgroup exists.

Due to a limitation of 5 arguments, the resource type and the "full"
bit are squeezed into a single u32.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/cgroup.h |  4 ++
 include/linux/psi.h    |  6 +++
 kernel/sched/bpf_psi.c | 94 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 6ed477338b16..1a99da44999e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -707,6 +707,10 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 
 static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 {}
+static inline struct cgroup *cgroup_get_from_id(u64 id)
+{
+	return NULL;
+}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
diff --git a/include/linux/psi.h b/include/linux/psi.h
index 8178e998d94b..8ffe84cd8571 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -50,6 +50,12 @@ int psi_cgroup_alloc(struct cgroup *cgrp);
 void psi_cgroup_free(struct cgroup *cgrp);
 void cgroup_move_task(struct task_struct *p, struct css_set *to);
 void psi_cgroup_restart(struct psi_group *group);
+
+#else
+static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
+{
+	return &psi_system;
+}
 #endif
 
 #else /* CONFIG_PSI */
diff --git a/kernel/sched/bpf_psi.c b/kernel/sched/bpf_psi.c
index c383a20119a6..7974de56594f 100644
--- a/kernel/sched/bpf_psi.c
+++ b/kernel/sched/bpf_psi.c
@@ -8,6 +8,7 @@
 #include <linux/bpf_psi.h>
 #include <linux/cgroup-defs.h>
 
+struct bpf_struct_ops bpf_psi_bpf_ops;
 static struct workqueue_struct *bpf_psi_wq;
 
 static DEFINE_MUTEX(bpf_psi_lock);
@@ -186,6 +187,92 @@ static const struct bpf_verifier_ops bpf_psi_verifier_ops = {
 	.is_valid_access = bpf_psi_ops_is_valid_access,
 };
 
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_psi_create_trigger - Create a PSI trigger
+ * @bpf_psi: bpf_psi struct to attach the trigger to
+ * @cgroup_id: cgroup Id to attach the trigger; 0 for system-wide scope
+ * @resource: resource to monitor (PSI_MEM, PSI_IO, etc) and the full bit.
+ * @threshold_us: threshold in us
+ * @window_us: window in us
+ *
+ * Creates a PSI trigger and attached is to bpf_psi. The trigger will be
+ * active unless bpf struct ops is unloaded or the corresponding cgroup
+ * is deleted.
+ *
+ * Resource's most significant bit encodes whether "some" or "full"
+ * PSI state should be tracked.
+ *
+ * Returns 0 on success and the error code on failure.
+ */
+__bpf_kfunc int bpf_psi_create_trigger(struct bpf_psi *bpf_psi,
+				       u64 cgroup_id, u32 resource,
+				       u32 threshold_us, u32 window_us)
+{
+	enum psi_res res = resource & ~BPF_PSI_FULL;
+	bool full = resource & BPF_PSI_FULL;
+	struct psi_trigger_params params;
+	struct cgroup *cgroup __maybe_unused = NULL;
+	struct psi_group *group;
+	struct psi_trigger *t;
+	int ret = 0;
+
+	if (res >= NR_PSI_RESOURCES)
+		return -EINVAL;
+
+	if (IS_ENABLED(CONFIG_CGROUPS) && cgroup_id) {
+		cgroup = cgroup_get_from_id(cgroup_id);
+		if (IS_ERR_OR_NULL(cgroup))
+			return PTR_ERR(cgroup);
+
+		group = cgroup_psi(cgroup);
+	} else {
+		group = &psi_system;
+	}
+
+	params.type = PSI_BPF;
+	params.bpf_psi = bpf_psi;
+	params.privileged = capable(CAP_SYS_RESOURCE);
+	params.res = res;
+	params.full = full;
+	params.threshold_us = threshold_us;
+	params.window_us = window_us;
+
+	t = psi_trigger_create(group, &params);
+	if (IS_ERR(t))
+		ret = PTR_ERR(t);
+	else
+		t->cgroup_id = cgroup_id;
+
+#ifdef CONFIG_CGROUPS
+	if (cgroup)
+		cgroup_put(cgroup);
+#endif
+
+	return ret;
+}
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_psi_kfuncs)
+BTF_ID_FLAGS(func, bpf_psi_create_trigger, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_psi_kfuncs)
+
+static int bpf_psi_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (btf_id_set8_contains(&bpf_psi_kfuncs, kfunc_id) &&
+	    prog->aux->st_ops != &bpf_psi_bpf_ops)
+		return -EACCES;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_psi_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_psi_kfuncs,
+	.filter         = bpf_psi_kfunc_filter,
+};
+
 static int bpf_psi_ops_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_psi_ops *ops = kdata;
@@ -287,6 +374,13 @@ static int __init bpf_psi_struct_ops_init(void)
 	if (!bpf_psi_wq)
 		return -ENOMEM;
 
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_psi_kfunc_set);
+	if (err) {
+		pr_warn("error while registering bpf psi kfuncs: %d", err);
+		goto err;
+	}
+
 	err = register_bpf_struct_ops(&bpf_psi_bpf_ops, bpf_psi_ops);
 	if (err) {
 		pr_warn("error while registering bpf psi struct ops: %d", err);
-- 
2.51.0


