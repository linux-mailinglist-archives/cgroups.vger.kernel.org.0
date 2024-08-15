Return-Path: <cgroups+bounces-4295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F579528B9
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 07:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A8A1C21FF5
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 05:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB8855C0A;
	Thu, 15 Aug 2024 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y3kcxohf"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FD954FAD
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 05:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698325; cv=none; b=Va3YmjkmX+YhwsMh9xJcRg42UMDygzyOa02L7Vhq7Sbuee1HYmAvINkClHNrTDpIOPQlyCL9/yVesXxyUJmcL5t3R8kw4fYMX9UexTzq3IQrp7gbRoWG/NFNDJXHpzeYIk9WxustmOhYqmB2iiw199WrMBVTzEKeVyEH/DhjJAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698325; c=relaxed/simple;
	bh=UVmqQ1oGDT3e/HqJgpapWhchFXaCkW8MWjzFgukqmGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq4jFC6uW1ToErqJ09GuarHNLFUSO/85OltzgPtHa3BO6OZAdIoDDwhKBcDM9xU9ohiFpiX/akC+cAmFj3XA4/Q9GyVxc1VPqmq97KSPyRN5guzM4shv1c1+wbyF8tyyxOm6+vKCqyxCZMko7oVfgDIRQYvqfMW9nUXyE2vN1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y3kcxohf; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSO/XXBnC6h5HUDwl//DSPS7ZBS0AJFyTcAs4FnSlKM=;
	b=Y3kcxohfENTdgij0QcKxQZsWg+v9DKuVZAQt+WIo6/kh+sJq5aMjVvqJzasgusRpF9OpZT
	gARH4N24V2jEu6GDgdAkIZdC6QiYtivkRDstetOViqplsW/rx1LIKf6Mil+1gj881wDMvS
	zRrXs9GfToHXTJpGDkYSVVyes7vMhXo=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 1/7] memcg: move v1 only percpu stats in separate struct
Date: Wed, 14 Aug 2024 22:04:47 -0700
Message-ID: <20240815050453.1298138-2-shakeel.butt@linux.dev>
In-Reply-To: <20240815050453.1298138-1-shakeel.butt@linux.dev>
References: <20240815050453.1298138-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment struct memcg_vmstats_percpu contains two v1 only fields
which consumes memory even when CONFIG_MEMCG_V1 is not enabled. In
addition there are v1 only functions accessing them and are in the main
memcontrol source file and can not be moved to v1 only source file due
to these fields. Let's move these fields into their own struct. Later
patches will move the functions accessing them to v1 source file and
only allocate these fields when CONFIG_MEMCG_V1 is enabled.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h |  2 ++
 mm/memcontrol-v1.h         | 19 +++++++++++++++++++
 mm/memcontrol.c            | 18 +++++++++---------
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 90ecd2dbca06..e21a1541adeb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -70,6 +70,7 @@ struct mem_cgroup_id {
 };
 
 struct memcg_vmstats_percpu;
+struct memcg1_events_percpu;
 struct memcg_vmstats;
 struct lruvec_stats_percpu;
 struct lruvec_stats;
@@ -254,6 +255,7 @@ struct mem_cgroup {
 	struct list_head objcg_list;
 
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
+	struct memcg1_events_percpu __percpu *events_percpu;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head cgwb_list;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 56d7eaa98274..8feccecf8e2a 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -56,6 +56,12 @@ enum mem_cgroup_events_target {
 	MEM_CGROUP_NTARGETS,
 };
 
+/* Cgroup1: threshold notifications & softlimit tree updates */
+struct memcg1_events_percpu {
+	unsigned long nr_page_events;
+	unsigned long targets[MEM_CGROUP_NTARGETS];
+};
+
 bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				enum mem_cgroup_events_target target);
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
@@ -69,6 +75,19 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
+static inline bool memcg1_alloc_events(struct mem_cgroup *memcg)
+{
+	memcg->events_percpu = alloc_percpu_gfp(struct memcg1_events_percpu,
+						GFP_KERNEL_ACCOUNT);
+	return !!memcg->events_percpu;
+}
+
+static inline void memcg1_free_events(struct mem_cgroup *memcg)
+{
+	if (memcg->events_percpu)
+		free_percpu(memcg->events_percpu);
+}
+
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
 void memcg1_memcg_init(struct mem_cgroup *memcg);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dacf4fec4541..66d60bb56f91 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -485,10 +485,6 @@ struct memcg_vmstats_percpu {
 	/* Delta calculation for lockless upward propagation */
 	long			state_prev[MEMCG_VMSTAT_SIZE];
 	unsigned long		events_prev[NR_MEMCG_EVENTS];
-
-	/* Cgroup1: threshold notifications & softlimit tree updates */
-	unsigned long		nr_page_events;
-	unsigned long		targets[MEM_CGROUP_NTARGETS];
 } ____cacheline_aligned;
 
 struct memcg_vmstats {
@@ -865,7 +861,7 @@ void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
 		nr_pages = -nr_pages; /* for event */
 	}
 
-	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
+	__this_cpu_add(memcg->events_percpu->nr_page_events, nr_pages);
 }
 
 bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
@@ -873,8 +869,8 @@ bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 {
 	unsigned long val, next;
 
-	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
-	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
+	val = __this_cpu_read(memcg->events_percpu->nr_page_events);
+	next = __this_cpu_read(memcg->events_percpu->targets[target]);
 	/* from time_after() in jiffies.h */
 	if ((long)(next - val) < 0) {
 		switch (target) {
@@ -887,7 +883,7 @@ bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 		default:
 			break;
 		}
-		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
+		__this_cpu_write(memcg->events_percpu->targets[target], next);
 		return true;
 	}
 	return false;
@@ -3510,6 +3506,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
+	memcg1_free_events(memcg);
 	kfree(memcg->vmstats);
 	free_percpu(memcg->vmstats_percpu);
 	kfree(memcg);
@@ -3549,6 +3546,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	if (!memcg->vmstats_percpu)
 		goto fail;
 
+	if (!memcg1_alloc_events(memcg))
+		goto fail;
+
 	for_each_possible_cpu(cpu) {
 		if (parent)
 			pstatc = per_cpu_ptr(parent->vmstats_percpu, cpu);
@@ -4664,7 +4664,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 
 	local_irq_save(flags);
 	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+	__this_cpu_add(ug->memcg->events_percpu->nr_page_events, ug->nr_memory);
 	memcg1_check_events(ug->memcg, ug->nid);
 	local_irq_restore(flags);
 
-- 
2.43.5


