Return-Path: <cgroups+bounces-8493-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1729CAD624A
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 00:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F71A1BC07CE
	for <lists+cgroups@lfdr.de>; Wed, 11 Jun 2025 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE525291F;
	Wed, 11 Jun 2025 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lSQxI91H"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786BD24EAAF
	for <cgroups@vger.kernel.org>; Wed, 11 Jun 2025 22:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749680184; cv=none; b=GnCmaDG4rBve1gM3zu6pZwOqJeYAHQFioaXytvKPWsyIZ4MvwFKzmQdIaSvAEwb7CMfQv88ulQy6Iw+A7f/r7gDS+RotfOrG8wV+fekMogVX7Ae1xe/uFMoyYCChAMSPaPlvr/JQhmEzJR4l1p1M/DlreK2+lVY4yZ0eS3nNFA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749680184; c=relaxed/simple;
	bh=oXikNS+kgN+2w3qPcZgZY0QITtEf/BerEbAt8eoZsE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CA5xksxetJrzH886OFP59GZwX5AG79M063OGcZbK331wIawpD0jBALLmx+hbHCUVca6Vqg38x24X6XKF7yS0S3OZJPq0t/evO3JDgnjhSySg3QmTNVzTzpWYupuHnsUesEFq6wHPP3iyaLKGalKEwBhjm+SdjyYfh4TEuBXEPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lSQxI91H; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749680180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffjH9W3JevRTfPRrE/1Jq8fYf5w4/j5rXWB6dZVk6cA=;
	b=lSQxI91H5F+GlORNGReJtTn3xZcEGrrYKuBeb06a7HDXF5w6tidwKZRbwdRJGnI89e63/1
	BY2mTqISo55dehhlwbfxDRY528tYIJ9xWj1x4rhM5/wHJr/3Zjvk97PkNmeT0/v/u3WBtd
	aKleVI3TXZiaCC0I4+dc0EulIJrxb4k=
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
Subject: [PATCH v2 4/4] memcg: cgroup: call css_rstat_updated irrespective of in_nmi()
Date: Wed, 11 Jun 2025 15:15:32 -0700
Message-ID: <20250611221532.2513772-5-shakeel.butt@linux.dev>
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


