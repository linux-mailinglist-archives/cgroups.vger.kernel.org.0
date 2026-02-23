Return-Path: <cgroups+bounces-14173-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMbFAxfXnGkJLAQAu9opvQ
	(envelope-from <cgroups+bounces-14173-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:39:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A38717E734
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 23:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C41CF30AD481
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A737B40E;
	Mon, 23 Feb 2026 22:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD6o+4Yg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE237B41A
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886321; cv=none; b=OV2mJVrs+8LdZhS4EN73O5t17VpmGtABP5dHSQ54mcuLN2nEqTYK9lQK7aiE2J91dmnSvzeh2GXJZuvy650xwA2+EHTTA7QKG6/tZDKQcrxE+IqlQ553S2VgiLJ4fRatgzqNZT0C2wAlyoheCU2A17hfBVJ02MOHH9RaETRbs3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886321; c=relaxed/simple;
	bh=T4vB2DOedOT6i9IF/jBh4raYemILf9XeHoYu3yDDtnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z81DV7xWfA3kWb94eEzjSB5JdiVzgRCaV9i3tl509YP7PZGeSrhzye6R4C2nP0G1/jLTMyUZf74iMFaFDDj9AU53aP3V8a9p2nKFmlR/KS5d6VPVcIlheXtTLvdB4IMcO75Ap/PzHqBCPM+05F+gWO2zpDmvN7fVtajDtTHqoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iD6o+4Yg; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4639279c7a6so1822136b6e.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 14:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771886319; x=1772491119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYuk97hSinOTQ/m7mlOvoqja3g8YulhySTVwuiXXVKY=;
        b=iD6o+4YgNTdGualUDzzIUgocUSIG8bLvnOFIzheZuNSghQngRcyGS9aG2WskobwNvw
         8D9I3dHCC4uBpMFfu3wL7XJYGtdXtA3lXfDuz+9QOWlRHL+pbXku//vgzCTG0hgGHclW
         Mscd1XV+BKeBPHHG2Ojvztglu7aC7ARsGYISt5UjOOXWT/lN5iJmvDNLH24+DCSNImv+
         OFndZz9mDLEc2oQtHWfG8sLrijCEHOJ61BSdZLJFTZvd2C/kPpDK467O487G44QyNuHC
         QgT+MZIjcdrTDg0Zuhfpz6yHdnFIpllGMS3ak8diPGDo1uJrPr+CAMOC2QJFeO0wkSPs
         heeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771886319; x=1772491119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYuk97hSinOTQ/m7mlOvoqja3g8YulhySTVwuiXXVKY=;
        b=BCtBpE3gnMXkUCBpV/wfhKIUpMecGIiBFTXqErobiLWRekjoMdx4ORQWS1VZ7STaBc
         kwvEfmM0LoSQtPmtODdFRxuTQF0wM6GxdWlaTavZO/7WDZg60SRZvhG2rFCloJNewMsj
         aaQz3AgKz6oWBYo3wAzXtvR8ZDKoVihCWzXeKvNZkEflSOsdAEx6I5lMUKOBcdGBoWPK
         tL0CcXcWIUOXzQTc8IfiXbmqeDF8P5kSSsD+AnhrwNPCuM7s8HLYvXsnwEn5YdVQ2nh2
         nsOzWL3fiNTym3VPp/dZacS1xD22trHUBBshezvduSFH6I+Tv1Rwt5URHohM18YQche0
         fRPg==
X-Forwarded-Encrypted: i=1; AJvYcCVCWSiqIL8wBFzs6aB7Afk0usstYaQQd1FuRANzfkrQmY6vPOSM8YBrD7z1LJqPsNrhycaGfehk@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5y70CQtf9DIq53R7k5CyulnKZAeSanXg4EWfH9K3nhDD4p3z
	L1uDKgiSPZtCpBf9YLoQVyHqaN+rzatpaiVToy4rM4Zj79rb48UvP4tY
X-Gm-Gg: AZuq6aL9RiJC3ZthF9VLPRFkv/WLePKrw98oB8EmH3v98pwLLOwED2VI7GRPP4wf5hS
	E0a+2w5sqZO7UO3qrEJWkUG79Kz6JVBCeybOJUXm8kXG1sGuY6sFU4xdEteprjwdJc45s56DHn7
	QqVf59RLHNAIKt9ucYNHPMTlmh97fp7ABsF1MMczxcVzNVwSygvid0IEna9O/ryExk3OMrHFQ+i
	p9r7qme5H3tKgCQQyidUs336isuq4gkQ8QALUrATc8Q46L1wihGlHI+09XnqYDRXyDZbgv4zyCW
	gDu/aRsTwoz6iVcbptzARyf5c0GLoQ6zpQO4vHSf7q7yJFSNti5GuARZkEIIO1TltCWSIPLF7Kr
	trWmQTmIJJZlHZLSJ2dKtmpJ7CiHNg7qKLctmp4dDXDU8kHCTKCbDzJvcUIBWcv38+RdJOIZqB0
	alvDmf+tqz/362U7barULhbA==
X-Received: by 2002:a05:6808:1481:b0:45f:727:8fd7 with SMTP id 5614622812f47-4644638ee8bmr5488352b6e.46.1771886318987;
        Mon, 23 Feb 2026 14:38:38 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d2d7826sm8635887fac.10.2026.02.23.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:38:38 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH 3/6] mm/memory-tiers, memcontrol: Introduce toptier capacity updates
Date: Mon, 23 Feb 2026 14:38:26 -0800
Message-ID: <20260223223830.586018-4-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
References: <20260223223830.586018-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14173-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A38717E734
X-Rspamd-Action: no action

What a memcg considers to be a valid toptier node is defined by three
criteria: (1) The node has CPUs, (2) The node has online memory,
and (3) The node is within the cgroup's cpuset.mems.

Of the three, the second and third criteria are the only ones that can
change dynamically during runtime, via memory hotplug events and
cpuset.mems changes, respectively.

Introduce functions to calculate and update toptier capacity, and call
them during cpuset.mems changes and memory hotplug events.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h   |  6 ++++++
 include/linux/memory-tiers.h | 29 +++++++++++++++++++++++++
 include/linux/page_counter.h |  2 ++
 kernel/cgroup/cpuset.c       |  2 +-
 mm/memcontrol.c              | 17 +++++++++++++++
 mm/memory-tiers.c            | 41 ++++++++++++++++++++++++++++++++++++
 mm/page_counter.c            |  8 +++++++
 7 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5173a9f16721..900a36112b62 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -608,6 +608,8 @@ static inline void mem_cgroup_protection(struct mem_cgroup *root,
 void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 				     struct mem_cgroup *memcg);
 
+void update_memcg_toptier_capacity(void);
+
 static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 					  struct mem_cgroup *memcg)
 {
@@ -1116,6 +1118,10 @@ static inline void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 {
 }
 
+static inline void update_memcg_toptier_capacity(void)
+{
+}
+
 static inline bool mem_cgroup_unprotected(struct mem_cgroup *target,
 					  struct mem_cgroup *memcg)
 {
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 85440473effb..cf616885e0db 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -53,6 +53,9 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
 struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 						  struct list_head *memory_types);
 void mt_put_memory_types(struct list_head *memory_types);
+void mt_get_toptier_nodemask(nodemask_t *mask, const nodemask_t *allowed);
+unsigned long mt_get_toptier_capacity(const nodemask_t *allowed);
+unsigned long mt_get_total_capacity(const nodemask_t *allowed);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node, const nodemask_t *allowed_mask);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
@@ -152,5 +155,31 @@ static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 static inline void mt_put_memory_types(struct list_head *memory_types)
 {
 }
+
+static inline void mt_get_toptier_nodemask(nodemask_t *mask,
+					   const nodemask_t *allowed)
+{
+	*mask = node_states[N_MEMORY];
+	if (allowed)
+		nodes_and(*mask, *mask, *allowed);
+}
+
+static inline unsigned long mt_get_toptier_capacity(const nodemask_t *allowed)
+{
+	int nid;
+	unsigned long capacity = 0;
+
+	for_each_node_state(nid, N_MEMORY) {
+		if (allowed && !node_isset(nid, *allowed))
+			continue;
+		capacity += NODE_DATA(nid)->node_present_pages;
+	}
+	return capacity;
+}
+
+static inline unsigned long mt_get_total_capacity(const nodemask_t *allowed)
+{
+	return mt_get_toptier_capacity(allowed);
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 128c1272c88c..ada5f1dd75d4 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -121,6 +121,8 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
 				       bool recursive_protection);
+void page_counter_update_toptier_capacity(struct page_counter *counter,
+					  const nodemask_t *allowed);
 unsigned long page_counter_toptier_high(struct page_counter *counter);
 unsigned long page_counter_toptier_low(struct page_counter *counter);
 #else
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7607dfe516e6..e5641dc1af88 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2620,7 +2620,6 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 	rcu_read_lock();
 	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
 		struct cpuset *parent = parent_cs(cp);
-
 		bool has_mems = nodes_and(*new_mems, cp->mems_allowed, parent->effective_mems);
 
 		/*
@@ -2701,6 +2700,7 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 
 	/* use trialcs->mems_allowed as a temp variable */
 	update_nodemasks_hier(cs, &trialcs->mems_allowed);
+	update_memcg_toptier_capacity();
 	return 0;
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0be1e823d813..f3e4a6ce7181 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -54,6 +54,7 @@
 #include <linux/seq_file.h>
 #include <linux/vmpressure.h>
 #include <linux/memremap.h>
+#include <linux/memory-tiers.h>
 #include <linux/mm_inline.h>
 #include <linux/swap_cgroup.h>
 #include <linux/cpu.h>
@@ -3906,6 +3907,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 		page_counter_init(&memcg->memory, &parent->memory, memcg_on_dfl);
 		page_counter_init(&memcg->swap, &parent->swap, false);
+		page_counter_update_toptier_capacity(&memcg->memory, NULL);
 #ifdef CONFIG_MEMCG_V1
 		memcg->memory.track_failcnt = !memcg_on_dfl;
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
@@ -3917,6 +3919,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		init_memcg_events();
 		page_counter_init(&memcg->memory, NULL, true);
 		page_counter_init(&memcg->swap, NULL, false);
+		page_counter_update_toptier_capacity(&memcg->memory, NULL);
 #ifdef CONFIG_MEMCG_V1
 		page_counter_init(&memcg->kmem, NULL, false);
 		page_counter_init(&memcg->tcpmem, NULL, false);
@@ -4804,6 +4807,20 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 	page_counter_calculate_protection(&root->memory, &memcg->memory, recursive_protection);
 }
 
+void update_memcg_toptier_capacity(void)
+{
+	struct mem_cgroup *memcg;
+	nodemask_t allowed;
+
+	for_each_mem_cgroup(memcg) {
+		if (memcg == root_mem_cgroup)
+			continue;
+
+		cpuset_nodes_allowed(memcg->css.cgroup, &allowed);
+		page_counter_update_toptier_capacity(&memcg->memory, &allowed);
+	}
+}
+
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index a88256381519..259caaf4be8f 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -889,6 +889,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 		mutex_lock(&memory_tier_lock);
 		if (clear_node_memory_tier(nn->nid))
 			establish_demotion_targets();
+		update_memcg_toptier_capacity();
 		mutex_unlock(&memory_tier_lock);
 		break;
 	case NODE_ADDED_FIRST_MEMORY:
@@ -896,6 +897,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 		memtier = set_node_memory_tier(nn->nid);
 		if (!IS_ERR(memtier))
 			establish_demotion_targets();
+		update_memcg_toptier_capacity();
 		mutex_unlock(&memory_tier_lock);
 		break;
 	}
@@ -941,6 +943,45 @@ bool numa_demotion_enabled = false;
 
 bool tier_aware_memcg_limits;
 
+void mt_get_toptier_nodemask(nodemask_t *mask, const nodemask_t *allowed)
+{
+	int nid;
+
+	*mask = NODE_MASK_NONE;
+	for_each_node_state(nid, N_MEMORY) {
+		if (node_is_toptier(nid))
+			node_set(nid, *mask);
+	}
+	if (allowed)
+		nodes_and(*mask, *mask, *allowed);
+}
+
+unsigned long mt_get_toptier_capacity(const nodemask_t *allowed)
+{
+	int nid;
+	unsigned long capacity = 0;
+	nodemask_t mask;
+
+	mt_get_toptier_nodemask(&mask, allowed);
+	for_each_node_mask(nid, mask)
+		capacity += NODE_DATA(nid)->node_present_pages;
+
+	return capacity;
+}
+
+unsigned long mt_get_total_capacity(const nodemask_t *allowed)
+{
+	int nid;
+	unsigned long capacity = 0;
+
+	for_each_node_state(nid, N_MEMORY) {
+		if (allowed && !node_isset(nid, *allowed))
+			continue;
+		capacity += NODE_DATA(nid)->node_present_pages;
+	}
+	return capacity;
+}
+
 #ifdef CONFIG_MIGRATION
 #ifdef CONFIG_SYSFS
 static ssize_t demotion_enabled_show(struct kobject *kobj,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 5ec97811c418..cf21c72bfd4e 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -11,6 +11,7 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/bug.h>
+#include <linux/memory-tiers.h>
 #include <asm/page.h>
 
 static bool track_protection(struct page_counter *c)
@@ -463,6 +464,13 @@ void page_counter_calculate_protection(struct page_counter *root,
 			recursive_protection));
 }
 
+void page_counter_update_toptier_capacity(struct page_counter *counter,
+					  const nodemask_t *allowed)
+{
+	counter->toptier_capacity = mt_get_toptier_capacity(allowed);
+	counter->total_capacity = mt_get_total_capacity(allowed);
+}
+
 unsigned long page_counter_toptier_high(struct page_counter *counter)
 {
 	unsigned long high = READ_ONCE(counter->high);
-- 
2.47.3


