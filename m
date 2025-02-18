Return-Path: <cgroups+bounces-6576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCACA3912D
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 04:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DAD07A2811
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 03:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89018132A;
	Tue, 18 Feb 2025 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOA5gLh4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4165189B8D
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739848506; cv=none; b=COwmombMWLQkd2o1UxbxmJuhl9jiPYvl4qxfPTj3fiqRDZ3f+rXcdZy1I4y8En11DlZbCzsTVseovMJN0piX8AdsRCrDulJ46kktlkaiD6nnbKXiENea+SG/vjhrmk+nV16s6wuwPS2A54J/0RQTYjBPi8QH0RxEmmq8bV8+Su4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739848506; c=relaxed/simple;
	bh=wFzVj7n6W2Mj/deCRgM+GXzAttor0YiKyTfBx1xCFco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwGOMw1X9sudQWKs6FV8mKE2LDwMOorxCJEDyoUvI3yyOQPamZxlDbPh3v/Hak0CnEU6w9tdmjBHpJPyudIqsKpaej/pG9wO9mSoBK0xgK9cxbrZStvNSMi0ZIOpAh4EaqHHlQ69u6+5g/73CiKFqzyOoKP1cU4WBF6dZHjcM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOA5gLh4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220dc3831e3so71140775ad.0
        for <cgroups@vger.kernel.org>; Mon, 17 Feb 2025 19:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739848504; x=1740453304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgpO8b1EeRoUbQ9L53xVbhgb2e+wvzP8W/zHZ0N0bI0=;
        b=nOA5gLh4/QCUC0kAPROXNeIl50YmXgMPFOyg1plNVnI3/fGVCWBGGLz2a7BiXOD/bv
         4ie6BCsyXVEB/Pjjvu3XAy/q4aT+RBvsO4BlyGXfoAJ4jzTug9GJVOEku5tLloi4Shiw
         eUc+Vlr0Hn4Sxb4uw5s/LpKbCz5ITTxO7rdZ7avk3DBzUlx8FYlKWoyFS6Atn0BxDLCu
         MxVdIjEhCF4cNYdLN6M6XrhVE2ECm8QgUxQqE04KvlOXlbs+/WQ347KZ3MIO8GOTpAoL
         cTABwvxnS3ytCPcjRo3Fr/OdVbepyQ6+EBUQ96YxTDeIh0AC1vU6GXPNb675DvTXxoiw
         NmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739848504; x=1740453304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgpO8b1EeRoUbQ9L53xVbhgb2e+wvzP8W/zHZ0N0bI0=;
        b=p/qiWQb3tdoVodsJZCdV/YUqG/MDgvB01UTcQ7+rTari6du45XVWlxci815sW/ZnoD
         0rk+4rLDNhRzaNfHKYrv2aCa2pdbW3KpaoNSzqew919yQKqrhuD4+QNtxEXNKPXGGh/j
         C+pbC3aP28iXtSgYTav06dVXkW8s4X+KPNvNQVbJVxX7PyTxNORB5irpe5rIPaTBsY9p
         ZcGwpPhM2ytjs29bTjN9YJhJK9LBGhyQAVXiVJdvkCrML+QfTGiSpjH4s07brVaASWW+
         e0mSxbJmqcf8PgjxMnwwWm6PYFOWvUUNob/pGadQKO3SBNBK2ZObxVRStbRAqNzOIA7S
         Okfg==
X-Forwarded-Encrypted: i=1; AJvYcCWpm9eo+q9zCJmMoI67a9Rtc1/PDDtqWtDCa85v4hcIUlj+oiHn2ZzMz7Rlh9kNc1bPAMNy3aL0@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUzwfQ7GrCEI8yfNPPMWKBJopNXqvCWztMzT8/rSeb6wUmC5c
	1gTQVwPJK7AbeJ9gh7NBN8gP4f5xiwAorPerei+FuDgjUQT0B16j
X-Gm-Gg: ASbGncsCh4KaLBgAbYoo9l02H74zDJjUxcHNAJYz+BaThvvN8UM6dwudc/1aUsNMIZu
	XyFSe4J6QXG6Bu6Dhbyvg8f1KdI/R8heiMSR8Gh6At0W43cWt0KJwtbBGtRivAiB77wNyFLPlyM
	3ngJY1stvvKfmkqYnFnQfZ2401XqrJ6eIFk/6/WBjVarWZWIgY6hxhPxXPk2O3TL2PUgUTtHXoA
	CRtQvRHGtkPqdVni+lOZ+Lhj6IW0lmEEUnK6kPd1Yp/ZLrrNrsblijnqSrnXOPtbdY/04LEazw9
	Dg6zmEB/VHEA5rvx7WTLWD0touRcRt0R68XbmQPwfJ9T3LbVvEsB
X-Google-Smtp-Source: AGHT+IGvVJgmZUZLNteiLjqooGGcN/Vh5bbt2bNgloW1Ge4ngfDQUgubE+o3sAAi/KBVt1FkRsrBsw==
X-Received: by 2002:aa7:9912:0:b0:732:5875:eb95 with SMTP id d2e1a72fcca58-7325875ee4fmr19388335b3a.4.1739848503581;
        Mon, 17 Feb 2025 19:15:03 -0800 (PST)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732425466besm8763451b3a.9.2025.02.17.19.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 19:15:02 -0800 (PST)
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
Subject: [PATCH 02/11] cgroup: add level of indirection for cgroup_rstat struct
Date: Mon, 17 Feb 2025 19:14:39 -0800
Message-ID: <20250218031448.46951-3-inwardvessel@gmail.com>
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

Change the type of rstat node from cgroup to the new cgroup_rstat
struct. Then for the rstat updated/flush api calls, add double under
versions that accept references to the cgroup_rstat struct. This new
level of indirection will allow for extending the public api further.
i.e. the cgroup_rstat struct can be embedded in a new type of object and
a public api can be added for that new type.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 include/linux/cgroup_rstat.h    |   6 +-
 kernel/cgroup/cgroup-internal.h |   4 +-
 kernel/cgroup/cgroup.c          |  12 +-
 kernel/cgroup/rstat.c           | 204 ++++++++++++++++++++------------
 4 files changed, 141 insertions(+), 85 deletions(-)

diff --git a/include/linux/cgroup_rstat.h b/include/linux/cgroup_rstat.h
index f95474d6f8ab..780b826ea364 100644
--- a/include/linux/cgroup_rstat.h
+++ b/include/linux/cgroup_rstat.h
@@ -36,7 +36,7 @@ struct cgroup_rstat {
 	 * frequent updates.
 	 */
 	CACHELINE_PADDING(_pad_);
-	struct cgroup *rstat_flush_next;
+	struct cgroup_rstat *rstat_flush_next;
 };
 
 struct cgroup_base_stat {
@@ -58,8 +58,8 @@ struct cgroup_rstat_cpu {
 	 * to the cgroup makes it unnecessary for each per-cpu struct to
 	 * point back to the associated cgroup.
 	 */
-	struct cgroup *updated_children;	/* terminated by self */
-	struct cgroup *updated_next;		/* NULL if not on the list */
+	struct cgroup_rstat *updated_children;	/* terminated by self */
+	struct cgroup_rstat *updated_next;		/* NULL if not on the list */
 
 	/*
 	 * ->bsync protects ->bstat.  These are the only fields which get
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c964dd7ff967..03139018da43 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -269,8 +269,8 @@ int cgroup_task_count(const struct cgroup *cgrp);
 /*
  * rstat.c
  */
-int cgroup_rstat_init(struct cgroup *cgrp);
-void cgroup_rstat_exit(struct cgroup *cgrp);
+int cgroup_rstat_init(struct cgroup_rstat *rstat);
+void cgroup_rstat_exit(struct cgroup_rstat *rstat);
 void cgroup_rstat_boot(void);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 03a3a4da49f1..02d6c11ccccb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1359,7 +1359,7 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 
 	cgroup_unlock();
 
-	cgroup_rstat_exit(cgrp);
+	cgroup_rstat_exit(&cgrp->rstat);
 	kernfs_destroy_root(root->kf_root);
 	cgroup_free_root(root);
 }
@@ -2133,7 +2133,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	if (ret)
 		goto destroy_root;
 
-	ret = cgroup_rstat_init(root_cgrp);
+	ret = cgroup_rstat_init(&root_cgrp->rstat);
 	if (ret)
 		goto destroy_root;
 
@@ -2175,7 +2175,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	goto out;
 
 exit_stats:
-	cgroup_rstat_exit(root_cgrp);
+	cgroup_rstat_exit(&root_cgrp->rstat);
 destroy_root:
 	kernfs_destroy_root(root->kf_root);
 	root->kf_root = NULL;
@@ -5436,7 +5436,7 @@ static void css_free_rwork_fn(struct work_struct *work)
 			cgroup_put(cgroup_parent(cgrp));
 			kernfs_put(cgrp->kn);
 			psi_cgroup_free(cgrp);
-			cgroup_rstat_exit(cgrp);
+			cgroup_rstat_exit(&cgrp->rstat);
 			kfree(cgrp);
 		} else {
 			/*
@@ -5687,7 +5687,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	if (ret)
 		goto out_free_cgrp;
 
-	ret = cgroup_rstat_init(cgrp);
+	ret = cgroup_rstat_init(&cgrp->rstat);
 	if (ret)
 		goto out_cancel_ref;
 
@@ -5780,7 +5780,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 out_kernfs_remove:
 	kernfs_remove(cgrp->kn);
 out_stat_exit:
-	cgroup_rstat_exit(cgrp);
+	cgroup_rstat_exit(&cgrp->rstat);
 out_cancel_ref:
 	percpu_ref_exit(&cgrp->self.refcnt);
 out_free_cgrp:
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 7e7879d88c38..13090dda56aa 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -14,9 +14,20 @@ static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
-static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
+static struct cgroup_rstat_cpu *rstat_cpu(struct cgroup_rstat *rstat, int cpu)
 {
-	return per_cpu_ptr(cgrp->rstat.rstat_cpu, cpu);
+	return per_cpu_ptr(rstat->rstat_cpu, cpu);
+}
+
+static struct cgroup_rstat *rstat_parent(struct cgroup_rstat *rstat)
+{
+	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+	struct cgroup *parent = cgroup_parent(cgrp);
+
+	if (!parent)
+		return NULL;
+
+	return &parent->rstat;
 }
 
 /*
@@ -73,17 +84,9 @@ void _cgroup_rstat_cpu_unlock(raw_spinlock_t *cpu_lock, int cpu,
 	raw_spin_unlock_irqrestore(cpu_lock, flags);
 }
 
-/**
- * cgroup_rstat_updated - keep track of updated rstat_cpu
- * @cgrp: target cgroup
- * @cpu: cpu on which rstat_cpu was updated
- *
- * @cgrp's rstat_cpu on @cpu was updated.  Put it on the parent's matching
- * rstat_cpu->updated_children list.  See the comment on top of
- * cgroup_rstat_cpu definition for details.
- */
-__bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+static void __cgroup_rstat_updated(struct cgroup_rstat *rstat, int cpu)
 {
+	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
 
@@ -95,15 +98,15 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 	 * instead of NULL, we can tell whether @cgrp is on the list by
 	 * testing the next pointer for NULL.
 	 */
-	if (data_race(cgroup_rstat_cpu(cgrp, cpu)->updated_next))
+	if (data_race(rstat_cpu(rstat, cpu)->updated_next))
 		return;
 
 	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
 
 	/* put @cgrp and all ancestors on the corresponding updated lists */
 	while (true) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
-		struct cgroup *parent = cgroup_parent(cgrp);
+		struct cgroup_rstat_cpu *rstatc = rstat_cpu(rstat, cpu);
+		struct cgroup_rstat *parent = rstat_parent(rstat);
 		struct cgroup_rstat_cpu *prstatc;
 
 		/*
@@ -115,20 +118,34 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 
 		/* Root has no parent to link it to, but mark it busy */
 		if (!parent) {
-			rstatc->updated_next = cgrp;
+			rstatc->updated_next = rstat;
 			break;
 		}
 
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = rstat_cpu(parent, cpu);
 		rstatc->updated_next = prstatc->updated_children;
-		prstatc->updated_children = cgrp;
+		prstatc->updated_children = rstat;
 
-		cgrp = parent;
+		rstat = parent;
 	}
 
 	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, true);
 }
 
+/**
+ * cgroup_rstat_updated - keep track of updated rstat_cpu
+ * @cgrp: target cgroup
+ * @cpu: cpu on which rstat_cpu was updated
+ *
+ * @cgrp's rstat_cpu on @cpu was updated.  Put it on the parent's matching
+ * rstat_cpu->updated_children list.  See the comment on top of
+ * cgroup_rstat_cpu definition for details.
+ */
+__bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+{
+	__cgroup_rstat_updated(&cgrp->rstat, cpu);
+}
+
 /**
  * cgroup_rstat_push_children - push children cgroups into the given list
  * @head: current head of the list (= subtree root)
@@ -141,32 +158,32 @@ __bpf_kfunc void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
  * into a singly linked list built from the tail backward like "pushing"
  * cgroups into a stack. The root is pushed by the caller.
  */
-static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
-						 struct cgroup *child, int cpu)
+static struct cgroup_rstat *cgroup_rstat_push_children(
+	struct cgroup_rstat *head, struct cgroup_rstat *child, int cpu)
 {
-	struct cgroup *chead = child;	/* Head of child cgroup level */
-	struct cgroup *ghead = NULL;	/* Head of grandchild cgroup level */
-	struct cgroup *parent, *grandchild;
+	struct cgroup_rstat *chead = child;	/* Head of child cgroup level */
+	struct cgroup_rstat *ghead = NULL;	/* Head of grandchild cgroup level */
+	struct cgroup_rstat *parent, *grandchild;
 	struct cgroup_rstat_cpu *crstatc;
 
-	child->rstat.rstat_flush_next = NULL;
+	child->rstat_flush_next = NULL;
 
 next_level:
 	while (chead) {
 		child = chead;
-		chead = child->rstat.rstat_flush_next;
-		parent = cgroup_parent(child);
+		chead = child->rstat_flush_next;
+		parent = rstat_parent(child);
 
 		/* updated_next is parent cgroup terminated */
 		while (child != parent) {
-			child->rstat.rstat_flush_next = head;
+			child->rstat_flush_next = head;
 			head = child;
-			crstatc = cgroup_rstat_cpu(child, cpu);
+			crstatc = rstat_cpu(child, cpu);
 			grandchild = crstatc->updated_children;
 			if (grandchild != child) {
 				/* Push the grand child to the next level */
 				crstatc->updated_children = child;
-				grandchild->rstat.rstat_flush_next = ghead;
+				grandchild->rstat_flush_next = ghead;
 				ghead = grandchild;
 			}
 			child = crstatc->updated_next;
@@ -200,14 +217,16 @@ static struct cgroup *cgroup_rstat_push_children(struct cgroup *head,
  * within the children list and terminated by the parent cgroup. An exception
  * here is the cgroup root whose updated_next can be self terminated.
  */
-static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
+static struct cgroup_rstat *cgroup_rstat_updated_list(
+		struct cgroup_rstat *root, int cpu)
 {
+	struct cgroup *cgrp = container_of(root, typeof(*cgrp), rstat);
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
-	struct cgroup *head = NULL, *parent, *child;
+	struct cgroup_rstat_cpu *rstatc = rstat_cpu(root, cpu);
+	struct cgroup_rstat *head = NULL, *parent, *child;
 	unsigned long flags;
 
-	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, root, false);
+	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
 
 	/* Return NULL if this subtree is not on-list */
 	if (!rstatc->updated_next)
@@ -217,17 +236,17 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 	 * Unlink @root from its parent. As the updated_children list is
 	 * singly linked, we have to walk it to find the removal point.
 	 */
-	parent = cgroup_parent(root);
+	parent = rstat_parent(root);
 	if (parent) {
 		struct cgroup_rstat_cpu *prstatc;
-		struct cgroup **nextp;
+		struct cgroup_rstat **nextp;
 
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = rstat_cpu(parent, cpu);
 		nextp = &prstatc->updated_children;
 		while (*nextp != root) {
 			struct cgroup_rstat_cpu *nrstatc;
 
-			nrstatc = cgroup_rstat_cpu(*nextp, cpu);
+			nrstatc = rstat_cpu(*nextp, cpu);
 			WARN_ON_ONCE(*nextp == parent);
 			nextp = &nrstatc->updated_next;
 		}
@@ -238,13 +257,13 @@ static struct cgroup *cgroup_rstat_updated_list(struct cgroup *root, int cpu)
 
 	/* Push @root to the list first before pushing the children */
 	head = root;
-	root->rstat.rstat_flush_next = NULL;
+	root->rstat_flush_next = NULL;
 	child = rstatc->updated_children;
 	rstatc->updated_children = root;
 	if (child != root)
 		head = cgroup_rstat_push_children(head, child, cpu);
 unlock_ret:
-	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, root, flags, false);
+	_cgroup_rstat_cpu_unlock(cpu_lock, cpu, cgrp, flags, false);
 	return head;
 }
 
@@ -300,24 +319,26 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 }
 
 /* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
+static void cgroup_rstat_flush_locked(struct cgroup_rstat *rstat)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
 	int cpu;
 
 	lockdep_assert_held(&cgroup_rstat_lock);
 
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
+		struct cgroup_rstat *pos = cgroup_rstat_updated_list(rstat, cpu);
 
-		for (; pos; pos = pos->rstat.rstat_flush_next) {
+		for (; pos; pos = pos->rstat_flush_next) {
+			struct cgroup *pos_cgroup = container_of(pos, struct cgroup, rstat);
 			struct cgroup_subsys_state *css;
 
-			cgroup_base_stat_flush(pos, cpu);
-			bpf_rstat_flush(pos, cgroup_parent(pos), cpu);
+			cgroup_base_stat_flush(pos_cgroup, cpu);
+			bpf_rstat_flush(pos_cgroup, cgroup_parent(pos_cgroup), cpu);
 
 			rcu_read_lock();
-			list_for_each_entry_rcu(css, &pos->rstat_css_list,
+			list_for_each_entry_rcu(css, &pos_cgroup->rstat_css_list,
 						rstat_css_node)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
@@ -333,6 +354,17 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	}
 }
 
+static void __cgroup_rstat_flush(struct cgroup_rstat *rstat)
+{
+	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+
+	might_sleep();
+
+	__cgroup_rstat_lock(cgrp, -1);
+	cgroup_rstat_flush_locked(rstat);
+	__cgroup_rstat_unlock(cgrp, -1);
+}
+
 /**
  * cgroup_rstat_flush - flush stats in @cgrp's subtree
  * @cgrp: target cgroup
@@ -348,11 +380,17 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
-	might_sleep();
+	__cgroup_rstat_flush(&cgrp->rstat);
+}
+
+static void __cgroup_rstat_flush_hold(struct cgroup_rstat *rstat)
+	__acquires(&cgroup_rstat_lock)
+{
+	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
 
+	might_sleep();
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
+	cgroup_rstat_flush_locked(rstat);
 }
 
 /**
@@ -365,63 +403,81 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
  * This function may block.
  */
 void cgroup_rstat_flush_hold(struct cgroup *cgrp)
-	__acquires(&cgroup_rstat_lock)
 {
-	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+	__cgroup_rstat_flush_hold(&cgrp->rstat);
 }
 
 /**
  * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
  * @cgrp: cgroup used by tracepoint
  */
-void cgroup_rstat_flush_release(struct cgroup *cgrp)
+static void __cgroup_rstat_flush_release(struct cgroup_rstat *rstat)
 	__releases(&cgroup_rstat_lock)
 {
+	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
-int cgroup_rstat_init(struct cgroup *cgrp)
+/**
+ * cgroup_rstat_flush_release - release cgroup_rstat_flush_hold()
+ * @cgrp: cgroup used by tracepoint
+ */
+void cgroup_rstat_flush_release(struct cgroup *cgrp)
 {
-	int cpu;
+	__cgroup_rstat_flush_release(&cgrp->rstat);
+}
 
-	/* the root cgrp has rstat_cpu preallocated */
-	if (!cgrp->rstat.rstat_cpu) {
-		cgrp->rstat.rstat_cpu = alloc_percpu(
-				struct cgroup_rstat_cpu);
-		if (!cgrp->rstat.rstat_cpu)
-			return -ENOMEM;
-	}
+static void __cgroup_rstat_init(struct cgroup_rstat *rstat)
+{
+	int cpu;
 
 	/* ->updated_children list is self terminated */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct cgroup_rstat_cpu *rstatc = rstat_cpu(rstat, cpu);
 
-		rstatc->updated_children = cgrp;
+		rstatc->updated_children = rstat;
 		u64_stats_init(&rstatc->bsync);
 	}
+}
+
+int cgroup_rstat_init(struct cgroup_rstat *rstat)
+{
+	/* the root cgrp has rstat_cpu preallocated */
+	if (!rstat->rstat_cpu) {
+		rstat->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
+		if (!rstat->rstat_cpu)
+			return -ENOMEM;
+	}
+
+	__cgroup_rstat_init(rstat);
 
 	return 0;
 }
 
-void cgroup_rstat_exit(struct cgroup *cgrp)
+static void __cgroup_rstat_exit(struct cgroup_rstat *rstat)
 {
 	int cpu;
 
-	cgroup_rstat_flush(cgrp);
-
 	/* sanity check */
 	for_each_possible_cpu(cpu) {
-		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+		struct cgroup_rstat_cpu *rstatc = rstat_cpu(rstat, cpu);
 
-		if (WARN_ON_ONCE(rstatc->updated_children != cgrp) ||
+		if (WARN_ON_ONCE(rstatc->updated_children != rstat) ||
 		    WARN_ON_ONCE(rstatc->updated_next))
 			return;
 	}
 
-	free_percpu(cgrp->rstat.rstat_cpu);
-	cgrp->rstat.rstat_cpu = NULL;
+	free_percpu(rstat->rstat_cpu);
+	rstat->rstat_cpu = NULL;
+}
+
+void cgroup_rstat_exit(struct cgroup_rstat *rstat)
+{
+	struct cgroup *cgrp = container_of(rstat, typeof(*cgrp), rstat);
+
+	cgroup_rstat_flush(cgrp);
+	__cgroup_rstat_exit(rstat);
 }
 
 void __init cgroup_rstat_boot(void)
@@ -462,7 +518,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 {
-	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
+	struct cgroup_rstat_cpu *rstatc = rstat_cpu(&cgrp->rstat, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_rstat_cpu *prstatc;
 	struct cgroup_base_stat delta;
@@ -492,7 +548,7 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
 
 		delta = rstatc->subtree_bstat;
-		prstatc = cgroup_rstat_cpu(parent, cpu);
+		prstatc = rstat_cpu(&parent->rstat, cpu);
 		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
 		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
 		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
-- 
2.48.1


