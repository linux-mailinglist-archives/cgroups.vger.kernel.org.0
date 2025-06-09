Return-Path: <cgroups+bounces-8468-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B410EAD2A0B
	for <lists+cgroups@lfdr.de>; Tue, 10 Jun 2025 00:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D29E171246
	for <lists+cgroups@lfdr.de>; Mon,  9 Jun 2025 22:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECDB227BB6;
	Mon,  9 Jun 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UexM/xxs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3672226520
	for <cgroups@vger.kernel.org>; Mon,  9 Jun 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749509794; cv=none; b=PaDztVtJUJ6TyzJbA5kiTlwiza+G8wRXdoMJRJQbqIPscwde2Cql8Rb126CmVrO9qQpi+JBC44lNNa79qQJp3Cbs4j3cZm/50/jA2i1N1m1bvJu3fa5I6piP0YEL7yO4vnzga/S3mdpOasQ2v65g4R6dx0FavzrLyIJG2sZeB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749509794; c=relaxed/simple;
	bh=oXikNS+kgN+2w3qPcZgZY0QITtEf/BerEbAt8eoZsE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6P9O68W8gRgi8Mi8siULnOy0TB24tmy4cgtw5PJ7HXObH6g7AiZdRH4HCawB2hgMjqLcGIcRo8xMV7kt0/JRp+gDZr83bfDhQghrqolKyF0TLhcxboVDKFv2lCGYLBdkn7apuyQuGe8G6JnEkIFat2l12lwxxSxvgHyXfgbp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UexM/xxs; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749509791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffjH9W3JevRTfPRrE/1Jq8fYf5w4/j5rXWB6dZVk6cA=;
	b=UexM/xxstuk7PO7WmNao3E6L5a2hvVZU3noOUdaCSK3vBl6w4LkpusCz4PyJwsMfLacYe6
	c8w4nELwZor22Ckt10ptR/Q3VtHD9SZHcunTB+jqRx0Z6SEcQh8guT7Xn8VIJbglgM6A6/
	fZhsbNRWvYFQuIOtue0oDlEmeuuDChI=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: [PATCH 3/3] memcg: cgroup: call memcg_rstat_updated irrespective of in_nmi()
Date: Mon,  9 Jun 2025 15:56:11 -0700
Message-ID: <20250609225611.3967338-4-shakeel.butt@linux.dev>
In-Reply-To: <20250609225611.3967338-1-shakeel.butt@linux.dev>
References: <20250609225611.3967338-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

css_rstat_updated() is nmi safe, so there is no need to avoid it in
in_nmi(), so remove the check.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 902da8a9c643..d122bfe33e98 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -573,9 +573,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
 	if (!val)
 		return;
 
-	/* TODO: add to cgroup update tree once it is nmi-safe. */
-	if (!in_nmi())
-		css_rstat_updated(&memcg->css, cpu);
+	css_rstat_updated(&memcg->css, cpu);
 	statc_pcpu = memcg->vmstats_percpu;
 	for (; statc_pcpu; statc_pcpu = statc->parent_pcpu) {
 		statc = this_cpu_ptr(statc_pcpu);
@@ -2530,7 +2528,8 @@ static inline void account_slab_nmi_safe(struct mem_cgroup *memcg,
 	} else {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
 
-		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		/* preemption is disabled in_nmi(). */
+		css_rstat_updated(&memcg->css, smp_processor_id());
 		if (idx == NR_SLAB_RECLAIMABLE_B)
 			atomic_add(nr, &pn->slab_reclaimable);
 		else
@@ -2753,7 +2752,8 @@ static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
 	if (likely(!in_nmi())) {
 		mod_memcg_state(memcg, MEMCG_KMEM, val);
 	} else {
-		/* TODO: add to cgroup update tree once it is nmi-safe. */
+		/* preemption is disabled in_nmi(). */
+		css_rstat_updated(&memcg->css, smp_processor_id());
 		atomic_add(val, &memcg->kmem_stat);
 	}
 }
-- 
2.47.1


