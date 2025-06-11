Return-Path: <cgroups+bounces-8490-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D8AD6240
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 00:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902B8189F569
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4124A058;
	Wed, 11 Jun 2025 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lmvnBckx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5622CBD5
	for <cgroups@vger.kernel.org>; Wed, 11 Jun 2025 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680168; cv=none; b=f1ft4+CLV+TEeO4Y0xlgOnyE/CscFEcgj3TFHSecX5XRPYFraZ/jWUzb4ghiAzyH18njSfEApJqsWeUSzyaV5iC8SyTCNUK+jHmFYGZqMz/+lc600mdCD6KFMEcKD1Ls2sCvwO1Q5cNB7/BQmHLEYHveZkaLVoCNiw2lC9fxURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680168; c=relaxed/simple;
	bh=6g6iPNuguanRU8zfDKFIKWAIyMllrkBDSKchTQLvrFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7C+FELNUHMkg+Zv6yOF43j6mXCtnwSzwsq7S3QsQ/EJhWaU3mSi8+eI079SQnJM6KPKazHfNfHEdwpUWIhk9Z9yJujCTRQXCu2+mYWISoVcfvSFihXu2+0u8MALNWjnB0x2WBiabV9jcmfW0UBsbFkEDR3Lpp6ADhu/n0lGjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lmvnBckx; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749680160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vjwAclPLPNB0cOL9u2mwbYWPRL/XnTNpPecdd20u+W8=;
	b=lmvnBckx5QukiFLgXOXw6Ddt0Ee9rJzer/x35eKhcwsjY3akw+jLLRISXc5Go7csrKE2hJ
	Gv2I3QBXukt/xjHNHnTa2/tAbrQMv5cQVeENziG39GtwDnLti7Wdgb2hvQ0n7dWUxxznN/
	iNIh7XjN2aO+x7TaKCMu/LqerSxxep8=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: JP Kobryn <inwardvessel@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 1/4] cgroup: support to enable nmi-safe css_rstat_updated
Date: Wed, 11 Jun 2025 15:15:29 -0700
Message-ID: <20250611221532.2513772-2-shakeel.butt@linux.dev>
In-Reply-To: <20250611221532.2513772-1-shakeel.butt@linux.dev>
References: <20250611221532.2513772-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add necessary infrastructure to enable the nmi-safe execution of
css_rstat_updated(). Currently css_rstat_updated() takes a per-cpu
per-css raw spinlock to add the given css in the per-cpu per-css update
tree. However the kernel can not spin in nmi context, so we need to
remove the spinning on the raw spinlock in css_rstat_updated().

To support lockless css_rstat_updated(), let's add necessary data
structures in the css and ss structures.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/cgroup-defs.h |  4 ++++
 kernel/cgroup/rstat.c       | 23 +++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index e61687d5e496..45860fe5dd0c 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -384,6 +384,9 @@ struct css_rstat_cpu {
 	 */
 	struct cgroup_subsys_state *updated_children;
 	struct cgroup_subsys_state *updated_next;	/* NULL if not on the list */
+
+	struct llist_node lnode;		/* lockless list for update */
+	struct cgroup_subsys_state *owner;	/* back pointer */
 };
 
 /*
@@ -822,6 +825,7 @@ struct cgroup_subsys {
 
 	spinlock_t rstat_ss_lock;
 	raw_spinlock_t __percpu *rstat_ss_cpu_lock;
+	struct llist_head __percpu *lhead; /* lockless update list head */
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index cbeaa499a96a..a5608ae2be27 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -11,6 +11,7 @@
 
 static DEFINE_SPINLOCK(rstat_base_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);
+static DEFINE_PER_CPU(struct llist_head, rstat_backlog_list);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -45,6 +46,13 @@ static spinlock_t *ss_rstat_lock(struct cgroup_subsys *ss)
 	return &rstat_base_lock;
 }
 
+static inline struct llist_head *ss_lhead_cpu(struct cgroup_subsys *ss, int cpu)
+{
+	if (ss)
+		return per_cpu_ptr(ss->lhead, cpu);
+	return per_cpu_ptr(&rstat_backlog_list, cpu);
+}
+
 static raw_spinlock_t *ss_rstat_cpu_lock(struct cgroup_subsys *ss, int cpu)
 {
 	if (ss) {
@@ -468,7 +476,8 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 	for_each_possible_cpu(cpu) {
 		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
-		rstatc->updated_children = css;
+		rstatc->owner = rstatc->updated_children = css;
+		init_llist_node(&rstatc->lnode);
 
 		if (is_self) {
 			struct cgroup_rstat_base_cpu *rstatbc;
@@ -532,9 +541,19 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 			return -ENOMEM;
 	}
 
+	if (ss) {
+		ss->lhead = alloc_percpu(struct llist_head);
+		if (!ss->lhead) {
+			free_percpu(ss->rstat_ss_cpu_lock);
+			return -ENOMEM;
+		}
+	}
+
 	spin_lock_init(ss_rstat_lock(ss));
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		raw_spin_lock_init(ss_rstat_cpu_lock(ss, cpu));
+		init_llist_head(ss_lhead_cpu(ss, cpu));
+	}
 
 	return 0;
 }
-- 
2.47.1


