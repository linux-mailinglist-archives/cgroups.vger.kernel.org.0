Return-Path: <cgroups+bounces-8258-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA83ABB52C
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 08:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A29175A09
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 06:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB54246790;
	Mon, 19 May 2025 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rCAZNv3l"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA3C2459E3
	for <cgroups@vger.kernel.org>; Mon, 19 May 2025 06:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747636359; cv=none; b=sXIizbRjR86IR7gkt5xNVaLjMZbbQPF559SYz0RvJuOUjLXWzKTbSFkH0NVb/3AXadm/M9KuoaYh6mroeInrR/a6GsEPYW94R2yCDWJaTBz5/Bne080cnlZgiloSQ/MdFD1mEQ58q0UyefyVa56p1/TtMNVGd5SASWWKGoOmb9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747636359; c=relaxed/simple;
	bh=r/vkKd/MD7gaCtcAfWWH+KiwcjV0Vf9OQp7SY6e55AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hY30ourwCNNlb2mnnZwkkQpp/8zLRD0kzsJaIkKZ3XxvMtacB8tQW7/fNt+kEAkb1aZJbrC4GQHZSLNmV53yMBf1X6QLUGdcQM6D6eTlo56810rQAvUkUEzWOecg5SwVmF12+5VEfvyb65TZOIzwxmiNcVZ7KagZsFrPb5R94Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rCAZNv3l; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747636354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Od6jpJx5ju28vO8pb8BvctqBPHbdQyPY9KteJgMsPTU=;
	b=rCAZNv3lb86WB2sJte64QzU22RTWO0EiLbDEDaeowpcnJK04XQNUyQ8m+R9sW3L1hM15nr
	NZA3z1Gs1gUwxxrV51Wt9oANofyW/qcDbIBdpdo7/AuRhc/g/2yGB39d149Cdt0ElSVSnI
	CIE5eI+vEQs1vAeZpDeHilI4S6suu9o=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v4 4/5] memcg: nmi-safe slab stats updates
Date: Sun, 18 May 2025 23:31:41 -0700
Message-ID: <20250519063142.111219-5-shakeel.butt@linux.dev>
In-Reply-To: <20250519063142.111219-1-shakeel.butt@linux.dev>
References: <20250519063142.111219-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The objcg based kmem [un]charging can be called in nmi context and it
may need to update NR_SLAB_[UN]RECLAIMABLE_B stats. So, let's correctly
handle the updates of these stats in the nmi context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 62d7997640db..f1a46c29dde8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2517,17 +2517,47 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
+#ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
+static inline void account_slab_nmi_safe(struct mem_cgroup *memcg,
+					 struct pglist_data *pgdat,
+					 enum node_stat_item idx, int nr)
+{
+	struct lruvec *lruvec;
+
+	if (likely(!in_nmi())) {
+		lruvec = mem_cgroup_lruvec(memcg, pgdat);
+		mod_memcg_lruvec_state(lruvec, idx, nr);
+	} else {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
+
+		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		if (idx == NR_SLAB_RECLAIMABLE_B)
+			atomic_add(nr, &pn->slab_reclaimable);
+		else
+			atomic_add(nr, &pn->slab_unreclaimable);
+	}
+}
+#else
+static inline void account_slab_nmi_safe(struct mem_cgroup *memcg,
+					 struct pglist_data *pgdat,
+					 enum node_stat_item idx, int nr)
+{
+	struct lruvec *lruvec;
+
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+	mod_memcg_lruvec_state(lruvec, idx, nr);
+}
+#endif
+
 static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
 				       struct pglist_data *pgdat,
 				       enum node_stat_item idx, int nr)
 {
 	struct mem_cgroup *memcg;
-	struct lruvec *lruvec;
 
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_memcg_lruvec_state(lruvec, idx, nr);
+	account_slab_nmi_safe(memcg, pgdat, idx, nr);
 	rcu_read_unlock();
 }
 
-- 
2.47.1


