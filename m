Return-Path: <cgroups+bounces-6579-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA9CA3912E
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFF93A66C1
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73914AD02;
	Tue, 18 Feb 2025 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WW6UUlSa"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DF5158553
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848510; cv=none; b=VQRAWTJAJqS2o/4I54rQlhnkoHbVS7xW0BezH2STxIMB8RNuI1AFqR9+L8Wk7xEmD2Z5bB9V7NMjLIOqRuGt6yJOHW/8RO4k3/HVuueud/SpzWuvd9Xk7s59FZul2nz9NgsePLI78QA6lxtkqklFaVRCI60H3xjwgD+o+19qOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848510; c=relaxed/simple;
	bh=tyefrFzoBlWE6pQWIjtdYiIs22cMgtRWoIIVqP6g0AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8n8MdNrfR8Td8Hqdkm8OXB4wJLchd8DMebkuBsv3jF9BPBeDoAYRd0K9LgqVkaGUviB7abjSr2p41sK8OG6bm30mTaICkpPNaOeHLHaQxzMYyi53IEqmar0hJYlYOtybcNijppJ3xt6BqpOrwFWEf8iBlSEa0EK1nw9TU3QUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WW6UUlSa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e6028214so81504915ad.0
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848508; x=1740453308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOkghzrE1OsBJ+MkQl3TgUWPiNlLeJUW6eoVzOAbjEY=;
        b=WW6UUlSaKu4GuWkEgjHWdp+TE+/ByfrtlDyrKz/PQqwGWoLDRgr00ssewnji/hVyid
         hNvWT07Y9ie0vXUt6p2rdHLgJuFx5Hyu7b/hykOTY38OhnW1UrUYXTyU/AKuEet6kX/C
         0lQll4xBC8aiimyQAE/bJDujEMEfQfvXWX/zrnsJ7cEJ3vGTdj7Skm63n9jTaax6iL+H
         L9BrLr5pWaWVyPlYpxeArG1Lflba+b4hSkp3rpvfTiiW5K8GzoMSClKeciw3NLLi95BD
         lbAB37VzlxYakjuCn2jLCrBjrsw+P+WKzqwmKy06Ba+F7lpKJLms8uU8lnPR7UagJsYY
         y2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848508; x=1740453308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOkghzrE1OsBJ+MkQl3TgUWPiNlLeJUW6eoVzOAbjEY=;
        b=wtHq+wxlFjlmFuwY094VuLk36bU/HoVV5CHTGpobOn92ouEibsDwuH0GlF9mIO4cn5
         EL89jVC11/IBZpGLrnTIPVh7yLXOL9Ab5IP8dJl1RvJ/YzLLaUOWzRpKKMtJNUUpccSU
         bkKjGaTowC7c0uugzG9Y32k8E6vnJPK3AwRvz0Iu7d6dIT/f5KHThgLZAXI+6NJzA3ob
         KGvSYaddq6wLnkqo1xrW0D5fyAB9XcZ+NODmL4FfcQJIJq+X4X+Cuw5dJyOcbx0Ta5ft
         YijzEftecMe6kaFfdt/qz9wZSKfYATrjitrSYt0GQXR+tfeCzkJS/IPDvIuyEgFD4A62
         uWAw==
X-Forwarded-Encrypted: i=1; AJvYcCXLhbrKt087+VcfkVsNaf4kSQlP7ruNkKFL8koTmkhvkDcCyLCd7adEiLYSLDu2jwKRN87hZnw3@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6IL9MfLEu0pqtsDtUwXJ7RBMFtW2JlLum/8YhvOmmu+496mF
	Ly8uua5bl/i7GHT1kmn7CUMVgfDlD4Q8TTGufL13aDlGFpaX9Jrh
X-Gm-Gg: ASbGncvDZliETbNHeoIgtD14EoO7c2nJe/bgVlc2le5ZjGjn6hTuifM0RJpS7iV2aR6
	mLhP0GUDx0yjdQDpA+dSNFgVMvpIIezAn4swvleTUPpyfroMs5vdtV2BoMJR1qp1jbNWJnHsS4/
	M+RWXxBwv+WR2U9eDS01zkOhNoSMKVvMj23QUzO/utw2gnfjCKnX9LBLy60M7Vp2Q9/PlRhtTxF
	zPcAYAefO5pLxiPiL0dyxYSR5wtxjfr/jsF7hqJJrBUFqf43Pxq3TVHJgMeHqn4sPJVo/D+cEPl
	MERYVlvhRheYGvDoLJLJyFtFpIOcneK1DI3uSt61Dlry1UBcihfk
X-Google-Smtp-Source: AGHT+IGyYGmJDhosxecR54xtKwc083QS170NIxJt7j0joSa3t2yuUZP3qQKRf4iiTOCbXpwa78B98A==
X-Received: by 2002:a05:6a21:3995:b0:1ee:c390:58a4 with SMTP id adf61e73a8af0-1eec3905ce7mr4547041637.2.1739848508183;
        Mon, 17 Feb 2025 19:15:08 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:07 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	tj@kernel.org,
	mhocko@kernel.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 05/11] cgroup: separate rstat for bpf cgroups
Date: Mon, 17 Feb 2025 19:14:42 -0800
Message-ID: <20250218031448.46951-6-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218031448.46951-1-inwardvessel@gmail.com>
References: <20250218031448.46951-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The processing of bpf cgroup stats is tied to the rstat actions of other
subsystems. Make changes to have them updated/flushed independently.
Give the cgroup_bpf struct its own cgroup_rstat instance and define a
new cgroup_rstat_ops instance specifically for the cgroup_bpf. Then
replace the kfunc status of the existing updated/flush api calls with
non-kfunc status. As an alternative, create new updated/flush kfuncs
specifically for bpf cgroups. In these new kfuncs, make use of the
bpf-specific rstat ops to plumb back in to the existing rstat routines.
Where applicable, use pre-processor conditionals to define bpf rstat
related stuff.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/bpf-cgroup-defs.h               |  3 +
 include/linux/cgroup.h                        |  3 +
 kernel/bpf/cgroup.c                           |  6 ++
 kernel/cgroup/cgroup-internal.h               |  5 +
 kernel/cgroup/rstat.c                         | 95 ++++++++++++++++---
 .../selftests/bpf/progs/btf_type_tag_percpu.c |  4 +-
 .../bpf/progs/cgroup_hierarchical_stats.c     |  8 +-
 7 files changed, 107 insertions(+), 17 deletions(-)

diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
index 0985221d5478..e68359f861fb 100644
--- a/include/linux/bpf-cgroup-defs.h
+++ b/include/linux/bpf-cgroup-defs.h
@@ -75,6 +75,9 @@ struct cgroup_bpf {
 
 	/* cgroup_bpf is released using a work queue */
 	struct work_struct release_work;
+
+	/* per-cpu recursive resource statistics */
+	struct cgroup_rstat rstat;
 };
 
 #else /* CONFIG_CGROUP_BPF */
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index eec970622419..253ce4bff576 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -836,6 +836,9 @@ static inline bool cgroup_task_frozen(struct task_struct *task)
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUP_BPF
+void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
+void bpf_cgroup_rstat_flush(struct cgroup *cgrp);
+
 static inline void cgroup_bpf_get(struct cgroup *cgrp)
 {
 	percpu_ref_get(&cgrp->bpf.refcnt);
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 46e5db65dbc8..72bcfdbda6b1 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -210,6 +210,7 @@ void cgroup_bpf_offline(struct cgroup *cgrp)
 {
 	cgroup_get(cgrp);
 	percpu_ref_kill(&cgrp->bpf.refcnt);
+	bpf_cgroup_rstat_exit(&cgrp->bpf);
 }
 
 static void bpf_cgroup_storages_free(struct bpf_cgroup_storage *storages[])
@@ -490,6 +491,10 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	if (ret)
 		return ret;
 
+	ret = bpf_cgroup_rstat_init(&cgrp->bpf);
+	if (ret)
+		goto cleanup_ref;
+
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_get(p);
 
@@ -513,6 +518,7 @@ int cgroup_bpf_inherit(struct cgroup *cgrp)
 	for (p = cgroup_parent(cgrp); p; p = cgroup_parent(p))
 		cgroup_bpf_put(p);
 
+cleanup_ref:
 	percpu_ref_exit(&cgrp->bpf.refcnt);
 
 	return -ENOMEM;
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 87d062baff90..bba1a1794de2 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -274,6 +274,11 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css);
 void cgroup_rstat_boot(void);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
+#ifdef CONFIG_CGROUP_BPF
+int bpf_cgroup_rstat_init(struct cgroup_bpf *bpf);
+void bpf_cgroup_rstat_exit(struct cgroup_bpf *bpf);
+#endif /* CONFIG_CGROUP_BPF */
+
 /*
  * namespace.c
  */
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a8bb304e49c4..14dd8217db64 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -73,6 +73,47 @@ static struct cgroup_rstat_ops rstat_css_ops = {
 	.flush_fn = rstat_flush_via_css,
 };
 
+#ifdef CONFIG_CGROUP_BPF
+__weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
+				     struct cgroup *parent, int cpu);
+
+static struct cgroup *rstat_cgroup_via_bpf(struct cgroup_rstat *rstat)
+{
+	struct cgroup_bpf *bpf = container_of(rstat, typeof(*bpf), rstat);
+	struct cgroup *cgrp = container_of(bpf, typeof(*cgrp), bpf);
+
+	return cgrp;
+}
+
+static struct cgroup_rstat *rstat_parent_via_bpf(
+		struct cgroup_rstat *rstat)
+{
+	struct cgroup *cgrp, *cgrp_parent;
+
+	cgrp = rstat_cgroup_via_bpf(rstat);
+	cgrp_parent = cgroup_parent(cgrp);
+	if (!cgrp_parent)
+		return NULL;
+
+	return &(cgrp_parent->bpf.rstat);
+}
+
+static void rstat_flush_via_bpf(struct cgroup_rstat *rstat, int cpu)
+{
+	struct cgroup *cgrp, *cgrp_parent;
+
+	cgrp = rstat_cgroup_via_bpf(rstat);
+	cgrp_parent = cgroup_parent(cgrp);
+	bpf_rstat_flush(cgrp, cgrp_parent, cpu);
+}
+
+static struct cgroup_rstat_ops rstat_bpf_ops = {
+	.parent_fn = rstat_parent_via_bpf,
+	.cgroup_fn = rstat_cgroup_via_bpf,
+	.flush_fn = rstat_flush_via_bpf,
+};
+#endif /* CONFIG_CGROUP_BPF */
+
 /*
  * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
  *
@@ -187,11 +228,18 @@ static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu,
  * rstat_cpu->updated_children list.  See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
-__bpf_kfunc void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
+void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 {
 	__cgroup_rstat_updated(&css->rstat, cpu, &rstat_css_ops);
 }
 
+#ifdef CONFIG_CGROUP_BPF
+__bpf_kfunc void bpf_cgroup_rstat_updated(struct cgroup *cgroup, int cpu)
+{
+	__cgroup_rstat_updated(&(cgroup->bpf.rstat), cpu, &rstat_bpf_ops);
+}
+#endif /* CONFIG_CGROUP_BPF */
+
 /**
  * cgroup_rstat_push_children - push children cgroups into the given list
  * @head: current head of the list (= subtree root)
@@ -330,8 +378,7 @@ static struct cgroup_rstat *cgroup_rstat_updated_list(
 
 __bpf_hook_start();
 
-__weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
-				     struct cgroup *parent, int cpu)
+void bpf_rstat_flush(struct cgroup *cgrp, struct cgroup *parent, int cpu)
 {
 }
 
@@ -379,12 +426,8 @@ static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat,
 		struct cgroup_rstat *pos = cgroup_rstat_updated_list(
 				rstat, cpu, ops);
 
-		for (; pos; pos = pos->rstat_flush_next) {
-			struct cgroup *pos_cgroup = ops->cgroup_fn(pos);
-
+		for (; pos; pos = pos->rstat_flush_next)
 			ops->flush_fn(pos, cpu);
-			bpf_rstat_flush(pos_cgroup, cgroup_parent(pos_cgroup), cpu);
-		}
 
 		/* play nice and yield if necessary */
 		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
@@ -424,11 +467,18 @@ static void __cgroup_rstat_flush(struct cgroup_rstat *rstat,
  *
  * This function may block.
  */
-__bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
+void cgroup_rstat_flush(struct cgroup_subsys_state *css)
 {
 	__cgroup_rstat_flush(&css->rstat, &rstat_css_ops);
 }
 
+#ifdef CONFIG_CGROUP_BPF
+__bpf_kfunc void bpf_cgroup_rstat_flush(struct cgroup *cgroup)
+{
+	__cgroup_rstat_flush(&(cgroup->bpf.rstat), &rstat_bpf_ops);
+}
+#endif /* CONFIG_CGROUP_BPF */
+
 static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat,
 		struct cgroup_rstat_ops *ops)
 	__acquires(&cgroup_rstat_lock)
@@ -532,6 +582,27 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css)
 	__cgroup_rstat_exit(rstat);
 }
 
+#ifdef CONFIG_CGROUP_BPF
+int bpf_cgroup_rstat_init(struct cgroup_bpf *bpf)
+{
+	struct cgroup_rstat *rstat = &bpf->rstat;
+
+	rstat->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+	if (!rstat->rstat_cpu)
+		return -ENOMEM;
+
+	__cgroup_rstat_init(rstat);
+
+	return 0;
+}
+
+void bpf_cgroup_rstat_exit(struct cgroup_bpf *bpf)
+{
+	__cgroup_rstat_flush(&bpf->rstat, &rstat_bpf_ops);
+	__cgroup_rstat_exit(&bpf->rstat);
+}
+#endif /* CONFIG_CGROUP_BPF */
+
 void __init cgroup_rstat_boot(void)
 {
 	int cpu;
@@ -754,10 +825,11 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	cgroup_force_idle_show(seq, &cgrp->bstat);
 }
 
+#ifdef CONFIG_CGROUP_BPF
 /* Add bpf kfuncs for cgroup_rstat_updated() and cgroup_rstat_flush() */
 BTF_KFUNCS_START(bpf_rstat_kfunc_ids)
-BTF_ID_FLAGS(func, cgroup_rstat_updated)
-BTF_ID_FLAGS(func, cgroup_rstat_flush, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_cgroup_rstat_updated)
+BTF_ID_FLAGS(func, bpf_cgroup_rstat_flush, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_rstat_kfunc_ids)
 
 static const struct btf_kfunc_id_set bpf_rstat_kfunc_set = {
@@ -771,3 +843,4 @@ static int __init bpf_rstat_kfunc_init(void)
 					 &bpf_rstat_kfunc_set);
 }
 late_initcall(bpf_rstat_kfunc_init);
+#endif /* CONFIG_CGROUP_BPF */
diff --git a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
index 310cd51e12e8..da15ada56218 100644
--- a/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
+++ b/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c
@@ -45,7 +45,7 @@ int BPF_PROG(test_percpu2, struct bpf_testmod_btf_type_tag_2 *arg)
 SEC("tp_btf/cgroup_mkdir")
 int BPF_PROG(test_percpu_load, struct cgroup *cgrp, const char *path)
 {
-	g = (__u64)cgrp->self.rstat.rstat_cpu->updated_children;
+	g = (__u64)cgrp->bpf.rstat.rstat_cpu->updated_children;
 	return 0;
 }
 
@@ -57,7 +57,7 @@ int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
 
 	cpu = bpf_get_smp_processor_id();
 	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(
-			cgrp->self.rstat.rstat_cpu, cpu);
+			cgrp->bpf.rstat.rstat_cpu, cpu);
 	if (rstat) {
 		/* READ_ONCE */
 		*(volatile int *)rstat;
diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
index 10c803c8dc70..24450dd4d3f3 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -37,8 +37,8 @@ struct {
 	__type(value, struct attach_counter);
 } attach_counters SEC(".maps");
 
-extern void cgroup_rstat_updated(struct cgroup_subsys_state *css, int cpu) __ksym;
-extern void cgroup_rstat_flush(struct cgroup_subsys_state *css) __ksym;
+extern void bpf_cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __ksym;
+extern void bpf_cgroup_rstat_flush(struct cgroup *cgrp) __ksym;
 
 static uint64_t cgroup_id(struct cgroup *cgrp)
 {
@@ -75,7 +75,7 @@ int BPF_PROG(counter, struct cgroup *dst_cgrp, struct task_struct *leader,
 	else if (create_percpu_attach_counter(cg_id, 1))
 		return 0;
 
-	cgroup_rstat_updated(&dst_cgrp->self, bpf_get_smp_processor_id());
+	bpf_cgroup_rstat_updated(dst_cgrp, bpf_get_smp_processor_id());
 	return 0;
 }
 
@@ -141,7 +141,7 @@ int BPF_PROG(dumper, struct bpf_iter_meta *meta, struct cgroup *cgrp)
 		return 1;
 
 	/* Flush the stats to make sure we get the most updated numbers */
-	cgroup_rstat_flush(&cgrp->self);
+	bpf_cgroup_rstat_flush(cgrp);
 
 	total_counter = bpf_map_lookup_elem(&attach_counters, &cg_id);
 	if (!total_counter) {
-- 
2.48.1


