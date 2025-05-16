Return-Path: <cgroups+bounces-8224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34810AB9644
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 08:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532215003E1
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB22224B05;
	Fri, 16 May 2025 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YmY1dR1Q"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424722332E
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 06:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378212; cv=none; b=pGrtLXH5gmJEuh2/vBVOVNr3xpXK+TRNLm1u3UxbpdakMYsL4+LlXvpyNeHjz9dY4SYBPPcgiAPeXmyXZN79/1lRzK4KINOcg2hrNh7eJb8adl91TxNUVo0lB0kXA6zrKf7mKH2x/VXQ6qwSCpj1HUwy818NBg8LSRC8nEmQSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378212; c=relaxed/simple;
	bh=6rsRUJUmm+2rmMLShujDbilkS0Q6IW2UZei1tehxkH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N22y5/Ezpz6NMX7wUbNZtdqk6HC86HJ4ENtJoPxy62FaaaTfJKZOyjup5i/4DdA0VPGXPxweMEQs0nYhKPwHZP7sWIbYjPXq6niDovb+Qd8xfgPS8yXOTSh6rIsAlBceG8DdoPlgM7mEVCmQSb+O8WX3f9gAwys1er5/4C3fLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YmY1dR1Q; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747378208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVWd6gOAyWb026W16IrpTsGOo2lVltd8hq2g+0iLsvs=;
	b=YmY1dR1QPKkAid5qt778SbUFTBoxhhl1j871LE9ZdYQj2beQaEombFog1irFez8NJxEOC8
	hkryeE7Epcg0y8rxeMYkxetCKfXska0Q9ms78R7EgFhGlaXpNtWBnBj9aZs+jNo4KKEBPO
	cOEtRs6Rqdh/mwvxQxR/Fc16uABoLeo=
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
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 4/5] memcg: nmi-safe slab stats updates
Date: Thu, 15 May 2025 23:49:11 -0700
Message-ID: <20250516064912.1515065-5-shakeel.butt@linux.dev>
In-Reply-To: <20250516064912.1515065-1-shakeel.butt@linux.dev>
References: <20250516064912.1515065-1-shakeel.butt@linux.dev>
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
---
 mm/memcontrol.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 899a31e6b087..85519ce37f18 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2517,17 +2517,47 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
+#ifdef MEMCG_NMI_NEED_ATOMIC
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


