Return-Path: <cgroups+bounces-7880-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E16DAA02BB
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 08:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52D31B63AF7
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 06:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06D8276038;
	Tue, 29 Apr 2025 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kUP0FEeY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907182750F1
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907171; cv=none; b=vEB5w6P5VrplX7C4p26uNTEj24jHB1ghcLJzWCBdArVX4Sffr/LDjBLsgPtg7XAUkhpjwLXq655LdDl3g1D2GpRUhLpEiW+WkLcTRl+FxIVPXmsF/kPnim5xF79qydy/i1qVQpQAbfY0HMlAMFiXWZ69+UpkjPngX8dWdGv20sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907171; c=relaxed/simple;
	bh=rfMQNARM+fqOmLxr2kkIJNGzTqYTIAIzHRWESWoi988=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z1+qjvBCnhDt+jnSwEHq/oOdYTt8+axOb73nDrKCLqOdGt3hiQpgaVgvIUh/mEQTY19SaUALsMN+hNp6DZkOn73CgFB/unBJqPfWtNfCdAep0YObdRr1alGa1HUjzL0PTHe2BognObnAdJzPl7uPTsT2xb72KFVxufse9gAxl5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kUP0FEeY; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745907167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pg3Smiuwje0/RTT5Q+S0BzKIdA3RdCTOLfpJO4h8ixE=;
	b=kUP0FEeYUvU+JxCiLGd/dlh+iU8tqDznw0ETGbp/E29HWv5bRwsmEEAKMneXxpnpPeUhGg
	p93vTnCI7eVJDuOaXpOFHjtXufQ+ZvRyx4lAmIUSJFznRpuX/hwFd77HSLlAl2qT2pDIWM
	G0qwvMpA+/51AI0epgL6067yCI1jtWU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	JP Kobryn <inwardvessel@gmail.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 2/3] cgroup: support to enable nmi-safe css_rstat_updated
Date: Mon, 28 Apr 2025 23:12:08 -0700
Message-ID: <20250429061211.1295443-3-shakeel.butt@linux.dev>
In-Reply-To: <20250429061211.1295443-1-shakeel.butt@linux.dev>
References: <20250429061211.1295443-1-shakeel.butt@linux.dev>
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
replace spinning on the raw spinlock with the trylock and on failure,
add the given css to the per-cpu backlog which will be processed when
the context that can spin on raw spinlock can run.

For now, this patch just adds necessary data structures in the css and
ss structures.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/cgroup-defs.h |  4 ++++
 kernel/cgroup/rstat.c       | 13 +++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 560582c4dbeb..f7b680f853ea 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -370,6 +370,9 @@ struct css_rstat_cpu {
 	 */
 	struct cgroup_subsys_state *updated_children;	/* terminated by self cgroup */
 	struct cgroup_subsys_state *updated_next;	/* NULL iff not on the list */
+
+	struct llist_node lnode;			/* lockless backlog node */
+	struct cgroup_subsys_state *owner;		/* back pointer */
 };
 
 /*
@@ -800,6 +803,7 @@ struct cgroup_subsys {
 
 	spinlock_t rstat_ss_lock;
 	raw_spinlock_t __percpu *rstat_ss_cpu_lock;
+	struct llist_head __percpu *lhead; /* lockless backlog list */
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a30bcc4d4f48..d3092b4c85d7 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -419,7 +419,8 @@ int css_rstat_init(struct cgroup_subsys_state *css)
 	for_each_possible_cpu(cpu) {
 		struct css_rstat_cpu *rstatc = css_rstat_cpu(css, cpu);
 
-		rstatc->updated_children = css;
+		rstatc->owner = rstatc->updated_children = css;
+		init_llist_node(&rstatc->lnode);
 
 		if (css_is_cgroup(css)) {
 			struct cgroup_rstat_base_cpu *rstatbc;
@@ -484,8 +485,16 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
 	if (!ss->rstat_ss_cpu_lock)
 		return -ENOMEM;
 
-	for_each_possible_cpu(cpu)
+	ss->lhead = alloc_percpu(struct llist_head);
+	if (!ss->lhead) {
+		free_percpu(ss->rstat_ss_cpu_lock);
+		return -ENOMEM;
+	}
+
+	for_each_possible_cpu(cpu) {
 		raw_spin_lock_init(per_cpu_ptr(ss->rstat_ss_cpu_lock, cpu));
+		init_llist_head(per_cpu_ptr(ss->lhead, cpu));
+	}
 
 	return 0;
 }
-- 
2.47.1


