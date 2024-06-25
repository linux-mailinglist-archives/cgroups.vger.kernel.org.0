Return-Path: <cgroups+bounces-3328-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70CB915B5B
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24A301C218EA
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4CB3BBCC;
	Tue, 25 Jun 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zz5Mz7eu"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41353168B7
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277184; cv=none; b=Po/oRPICsJ++e3ZjmRksYuzdER4+H3esRcH4O6/j4N4YUGbFw+iRpUUsGHQfWMB3RoZEsbbok0h9zqgDg68bf/iVwu0Di37XG/jq9sGLSLwZkouq6qmSXCmioMgFc62lGIljf0gVtPlVxZ4elKSACVuGxKKjyB7mvTQoCCbEPMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277184; c=relaxed/simple;
	bh=IQzyzCkRP8i6jF7uCdjgsanqWmOgB62q7c74jVt/VK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7YADS80LxavuPgbQ13AbYHme8r1jVknU6PjWTpAFCz4fOJ00rLLmcTlfKqnJcih1thyaHdz2s9uUxUFyuzJTOqUKOKIPbv9AK+wbGfwciFre39hz6FWVpi8uBvuCRoQUPWNFYK2nEaPmP0+ZgHAWH24ZJwmO6FbUFu1Tn5su/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zz5Mz7eu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnnziElivuQ/LCoNmnyRRYzwKafGd1VzRo+k4WxWNEA=;
	b=Zz5Mz7euqVmt7XORkaBlHGPy1k/atuJWJKdYE/ol1NG1b2dsF0yeJlI/cbm0Uxkz0ZqpZn
	pLewHnkD7xPEgvO0eWlj+ZwU0Gqm2DsLuhAD54EVH+gmRtJ+lvmB6Qm5PKalMHH1WgMkBw
	5Z2h3LBBZWTLBVkhIT9tXB/VOGV2AtU=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 07/14] mm: memcg: rename memcg_check_events()
Date: Mon, 24 Jun 2024 17:58:59 -0700
Message-ID: <20240625005906.106920-8-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename memcg_check_events() into memcg1_check_events() for
consistency with other cgroup v1-specific functions.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 6 +++---
 mm/memcontrol-v1.h | 2 +-
 mm/memcontrol.c    | 8 ++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4b2290ceace6..d7b5c4c14732 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -835,9 +835,9 @@ static int mem_cgroup_move_account(struct folio *folio,
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(to, nr_pages);
-	memcg_check_events(to, nid);
+	memcg1_check_events(to, nid);
 	mem_cgroup_charge_statistics(from, -nr_pages);
-	memcg_check_events(from, nid);
+	memcg1_check_events(from, nid);
 	local_irq_enable();
 out:
 	return ret;
@@ -1424,7 +1424,7 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
  * Check events in order.
  *
  */
-void memcg_check_events(struct mem_cgroup *memcg, int nid)
+void memcg1_check_events(struct mem_cgroup *memcg, int nid)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		return;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 524a2c76ffc9..ef1b7037cbdc 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -12,7 +12,7 @@ static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
 }
 
 void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
-void memcg_check_events(struct mem_cgroup *memcg, int nid);
+void memcg1_check_events(struct mem_cgroup *memcg, int nid);
 void memcg_oom_recover(struct mem_cgroup *memcg);
 int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		     unsigned int nr_pages);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bd4b26a73596..92fb72bbd494 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2632,7 +2632,7 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 
 	local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, folio_nr_pages(folio));
-	memcg_check_events(memcg, folio_nid(folio));
+	memcg1_check_events(memcg, folio_nid(folio));
 	local_irq_enable();
 }
 
@@ -5697,7 +5697,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	local_irq_save(flags);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->nid);
+	memcg1_check_events(ug->memcg, ug->nid);
 	local_irq_restore(flags);
 
 	/* drop reference from uncharge_folio */
@@ -5836,7 +5836,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 
 	local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
-	memcg_check_events(memcg, folio_nid(new));
+	memcg1_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
 }
 
@@ -6104,7 +6104,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	memcg_stats_lock();
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_stats_unlock();
-	memcg_check_events(memcg, folio_nid(folio));
+	memcg1_check_events(memcg, folio_nid(folio));
 
 	css_put(&memcg->css);
 }
-- 
2.45.2


