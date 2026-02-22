Return-Path: <cgroups+bounces-14115-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMeOBGjEmmlHiQMAu9opvQ
	(envelope-from <cgroups+bounces-14115-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:55:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BF16EB7A
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 09:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7524A3095F4E
	for <lists+cgroups@lfdr.de>; Sun, 22 Feb 2026 08:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F632405EB;
	Sun, 22 Feb 2026 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Y7PC0kP6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8323D7C7
	for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771750190; cv=none; b=gXGtESOPqgYZtLOvaO6FHdJA8+9nDSn5R5HFCiLR1TbWrGykbn1IC6j+4S9zEYUuy6eRh3QLUjvVXG4vzuRjLO2ytEh1dfSYLZNTWTpKM0XLMmmdZ+hSpoU8XL+qhWezAPEoPRJNyrIphiKIGBYUUdsPkuccrX/yHzJWZdwznTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771750190; c=relaxed/simple;
	bh=/y1pXR/Qusp3ewwrpz/oUGt/NfC5qFdnwSmdDbLTy8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5Z8zCVNfcbzFI2qD3mKs/J4vIo0UpAtvZpP2ZLZ0jEj6dtXveeIQGTV7eOFqEU06Q4fnC6hxwhzV+98ucotD3dRjmc0fkvUBPuurmgAO4PHEAKCKnCFzPKptTMQsqwY0Jih6SIaveEHTAsQjl84b0KHzg7XMb3a52H5JtWS+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Y7PC0kP6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a7bbe9d0so29134961cf.0
        for <cgroups@vger.kernel.org>; Sun, 22 Feb 2026 00:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1771750188; x=1772354988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zm28kvmD9iuWWLwvtJBamWBricaC3Bz050FlGsgvxtM=;
        b=Y7PC0kP6SAKKh0UkPXB69xmbfbcVtmAOvC67tuKDhFrkkgNQSotHgyFI7VPWDDdXlm
         nniZ/HIdbZl5MXo0VVkWS6YYO4gjsVYa/Xjh0gKumfnUqKkA0wSjTcNdWVsF4I6tl4Az
         0l+PHbo/DwZkpGiZLiUfNVgb1kTTslgr8h7xSSE2KHz46bUUQ70RWw12MJjm2as+ubOF
         0MWuQZ7n6Ix7k++H1roofzOJGnIXbMJIIC7XRvxp3jLNsdsmV0Nkc6GsTz1CZySBuIDM
         Bm8Km23rYiuTvuEdFUA892nTMc/ZMDvQA2mQyfuVjJyd4Cn0/1PlRhh60vudYkFK9Mwc
         RoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771750188; x=1772354988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zm28kvmD9iuWWLwvtJBamWBricaC3Bz050FlGsgvxtM=;
        b=NpxeqA54aMIfb3rsiDQfqIacJ70nzK7VfdZiGy1H6QLfw0L3o6k80WepvbeP5hmiq6
         aZrraRTJlAJ59YfiEg2NLKeoCYfqWPnObh+TPSXcr83wxFBh9SZoRUJjG8wVWO0du2z3
         c6cid2vVjba5vwxU5gjTgKW4cd78dBQlQN7OpRI/3wpOKNC6UAy86mQ+HFh2cTvlLGuh
         Rr9NJXWDpbM1+yG4aI74iujsSFPBX1GMbmaef6Cpykcd2QDsEwH1rDQ1FXfCuuo1Jr55
         mRdkGluv5IChYWoyYljT488MKZhkvmBLPn6MhaLdK8O5uJW/nco5+8nn7b64hnoZ3jhm
         12Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUM9FnqvmsxANCZ85rwTnmW/p0OoYl2XEiSM6c1LTGEkX6zza1wFkIFlQN5ww8iuA85pDTDy+OV@vger.kernel.org
X-Gm-Message-State: AOJu0Yw76yJo/ifQc6UQZhM37qknR5vu1XBJy0G0YnXASae48UvIqYR6
	XVmBrjNjmAhu/S8Sl5iseRpV6OPRKYLTZKyavmEnBt8Gs7/CjA0KaClhHwfqUtorv0w=
X-Gm-Gg: AZuq6aLujwOWh60pdpYVIXvn6D665xdDkAQRLCSrylasUKtz13oldtVYHOKTyL3jSxy
	FKmkztpZbxpIA5uSvK8uk0GiJUIySwvmBBXWYAxsMb7PBoiM3GvqrKhtrVgqfeHOT6IfYp2qmLW
	6zdv028MJSa0Tk/LVla/6eStQImQEb8+8IUe+2N0w2u4jFqBxvATT44JH+AIAZnXwOzdKJp5Ka0
	NtLssRfjqAsf7FYYKtB61wL30a2Vchv8P2JAcBjpoqQ9bMDzP723mwloXVc8KIBe6Iy1ZygdAfk
	iZFLSw/Cwcshqir0T9wroCqQgY9fxeJAePO0EvVrJ5jD3Qn3poJTo2sLvJ1JOOsktvZ1ZghN/y0
	tgy1vOFzy2A+7vD/xeX+W2halRjL/dDroJr7LfARyL3W8zCH3LKdrD+zxbOzCiSvPWRD/9ZlRtO
	BbmN0o2sJfs6DcnplZJv2+QZ8WYdXPb1F+y75SMqE0jzX6dv2gV1glHW2BTE9mWtPZT6UZv1am5
	4DqBlljdi6KQPzvIyBVRtMZHw==
X-Received: by 2002:ac8:5d43:0:b0:4ee:24e8:c9a1 with SMTP id d75a77b69052e-5070bc4bb77mr73824241cf.44.1771750187486;
        Sun, 22 Feb 2026 00:49:47 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d53f0fcsm38640631cf.9.2026.02.22.00.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 00:49:46 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	jackmanb@google.com,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	muchun.song@linux.dev,
	xu.xin16@zte.com.cn,
	chengming.zhou@linux.dev,
	jannh@google.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	pfalcato@suse.de,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	riel@surriel.com,
	harry.yoo@oracle.com,
	cl@gentwo.org,
	roman.gushchin@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	zhengqi.arch@bytedance.com,
	terry.bowman@amd.com
Subject: [RFC PATCH v4 14/27] mm/memory-tiers: NP_OPS_DEMOTION - support private node demotion
Date: Sun, 22 Feb 2026 03:48:29 -0500
Message-ID: <20260222084842.1824063-15-gourry@gourry.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
References: <20260222084842.1824063-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gourry.net:+];
	TAGGED_FROM(0.00)[bounces-14115-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[gourry.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[74];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gourry.net:mid,gourry.net:dkim,gourry.net:email]
X-Rspamd-Queue-Id: 7F8BF16EB7A
X-Rspamd-Action: no action

The memory-tier subsystem needs to know which private nodes should
appear as demotion targets.

Add NP_OPS_DEMOTION (BIT(2)):
   Node can be added as a demotion target by memory-tiers.

Add demotion backpressure support so private nodes can reject
new demotions cleanly, allowing vmscan to fall back to swap.

In the demotion path, try demotion to private nodes invididually,
then clear private nodes from the demotion target mask until a
non-private node is found, then fall back to the remaining mask.
This prevents LRU inversion while still allowing forward progress.

This is the closest match to the current behavior without making
private nodes inaccessible or preventing forward progress. We
should probably completely re-do the demotion logic to allow less
fallback and kick kswapd instead - right now we induce LRU
inversions by simply falling back to any node in the demotion list.

Add memory_tier_refresh_demotion() export for services to trigger
re-evaluation of demotion targets after changing their flags.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory-tiers.h |  9 +++++++
 include/linux/node_private.h | 22 +++++++++++++++++
 mm/internal.h                |  7 ++++++
 mm/memory-tiers.c            | 46 ++++++++++++++++++++++++++++++++----
 mm/page_alloc.c              | 12 +++++++---
 mm/vmscan.c                  | 30 ++++++++++++++++++++++-
 6 files changed, 117 insertions(+), 9 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 3e1159f6762c..e1476432e359 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -58,6 +58,7 @@ struct memory_dev_type *mt_get_memory_type(int adist);
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 bool node_is_toptier(int node);
+void memory_tier_refresh_demotion(void);
 #else
 static inline int next_demotion_node(int node)
 {
@@ -73,6 +74,10 @@ static inline bool node_is_toptier(int node)
 {
 	return true;
 }
+
+static inline void memory_tier_refresh_demotion(void)
+{
+}
 #endif
 
 #else
@@ -106,6 +111,10 @@ static inline bool node_is_toptier(int node)
 	return true;
 }
 
+static inline void memory_tier_refresh_demotion(void)
+{
+}
+
 static inline int register_mt_adistance_algorithm(struct notifier_block *nb)
 {
 	return 0;
diff --git a/include/linux/node_private.h b/include/linux/node_private.h
index e9b58afa366b..e254e36056cd 100644
--- a/include/linux/node_private.h
+++ b/include/linux/node_private.h
@@ -88,6 +88,8 @@ struct node_private_ops {
 #define NP_OPS_MIGRATION		BIT(0)
 /* Allow mempolicy-directed allocation and mbind migration to this node */
 #define NP_OPS_MEMPOLICY		BIT(1)
+/* Node participates as a demotion target in memory-tiers */
+#define NP_OPS_DEMOTION			BIT(2)
 
 /**
  * struct node_private - Per-node container for N_MEMORY_PRIVATE nodes
@@ -101,12 +103,14 @@ struct node_private_ops {
  *		callbacks that may sleep; 0 = fully released)
  * @released: Signaled when refcount drops to 0; unregister waits on this
  * @ops: Service callbacks and exclusion flags (NULL until service registers)
+ * @migration_blocked: Service signals migrations should pause
  */
 struct node_private {
 	void *owner;
 	refcount_t refcount;
 	struct completion released;
 	const struct node_private_ops *ops;
+	bool migration_blocked;
 };
 
 #ifdef CONFIG_NUMA
@@ -306,6 +310,19 @@ static inline bool nodes_private_mpol_allowed(const nodemask_t *nodes)
 	}
 	return eligible;
 }
+
+static inline bool node_private_migration_blocked(int nid)
+{
+	struct node_private *np;
+	bool blocked;
+
+	rcu_read_lock();
+	np = rcu_dereference(NODE_DATA(nid)->node_private);
+	blocked = np && READ_ONCE(np->migration_blocked);
+	rcu_read_unlock();
+
+	return blocked;
+}
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #else /* !CONFIG_NUMA */
@@ -404,6 +421,11 @@ static inline bool nodes_private_mpol_allowed(const nodemask_t *nodes)
 	return false;
 }
 
+static inline bool node_private_migration_blocked(int nid)
+{
+	return false;
+}
+
 static inline int node_private_register(int nid, struct node_private *np)
 {
 	return -ENODEV;
diff --git a/mm/internal.h b/mm/internal.h
index 6ab4679fe943..5950e20d4023 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1206,6 +1206,8 @@ extern int node_reclaim_mode;
 
 extern int node_reclaim(struct pglist_data *, gfp_t, unsigned int);
 extern int find_next_best_node(int node, nodemask_t *used_node_mask);
+extern int find_next_best_node_in(int node, nodemask_t *used_node_mask,
+				  const nodemask_t *candidates);
 extern bool numa_zone_alloc_allowed(int alloc_flags, struct zone *zone,
 			      gfp_t gfp_mask);
 #else
@@ -1220,6 +1222,11 @@ static inline int find_next_best_node(int node, nodemask_t *used_node_mask)
 {
 	return NUMA_NO_NODE;
 }
+static inline int find_next_best_node_in(int node, nodemask_t *used_node_mask,
+					 const nodemask_t *candidates)
+{
+	return NUMA_NO_NODE;
+}
 static inline bool numa_zone_alloc_allowed(int alloc_flags, struct zone *zone,
 				     gfp_t gfp_mask)
 {
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 9c742e18e48f..434190fdc078 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -3,6 +3,7 @@
 #include <linux/lockdep.h>
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
+#include <linux/node_private.h>
 #include <linux/memory.h>
 #include <linux/memory-tiers.h>
 #include <linux/notifier.h>
@@ -380,6 +381,8 @@ static void disable_all_demotion_targets(void)
 		if (memtier)
 			memtier->lower_tier_mask = NODE_MASK_NONE;
 	}
+	for_each_node_state(node, N_MEMORY_PRIVATE)
+		node_demotion[node].preferred = NODE_MASK_NONE;
 	/*
 	 * Ensure that the "disable" is visible across the system.
 	 * Readers will see either a combination of before+disable
@@ -421,6 +424,7 @@ static void establish_demotion_targets(void)
 	int target = NUMA_NO_NODE, node;
 	int distance, best_distance;
 	nodemask_t tier_nodes, lower_tier;
+	nodemask_t all_memory;
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
@@ -429,6 +433,13 @@ static void establish_demotion_targets(void)
 
 	disable_all_demotion_targets();
 
+	/* Include private nodes that have opted in to demotion. */
+	all_memory = node_states[N_MEMORY];
+	for_each_node_state(node, N_MEMORY_PRIVATE) {
+		if (node_private_has_flag(node, NP_OPS_DEMOTION))
+			node_set(node, all_memory);
+	}
+
 	for_each_node_state(node, N_MEMORY) {
 		best_distance = -1;
 		nd = &node_demotion[node];
@@ -442,12 +453,12 @@ static void establish_demotion_targets(void)
 		memtier = list_next_entry(memtier, list);
 		tier_nodes = get_memtier_nodemask(memtier);
 		/*
-		 * find_next_best_node, use 'used' nodemask as a skip list.
+		 * find_next_best_node_in, use 'used' nodemask as a skip list.
 		 * Add all memory nodes except the selected memory tier
 		 * nodelist to skip list so that we find the best node from the
 		 * memtier nodelist.
 		 */
-		nodes_andnot(tier_nodes, node_states[N_MEMORY], tier_nodes);
+		nodes_andnot(tier_nodes, all_memory, tier_nodes);
 
 		/*
 		 * Find all the nodes in the memory tier node list of same best distance.
@@ -455,7 +466,8 @@ static void establish_demotion_targets(void)
 		 * in the preferred mask when allocating pages during demotion.
 		 */
 		do {
-			target = find_next_best_node(node, &tier_nodes);
+			target = find_next_best_node_in(node, &tier_nodes,
+							&all_memory);
 			if (target == NUMA_NO_NODE)
 				break;
 
@@ -495,7 +507,7 @@ static void establish_demotion_targets(void)
 	 * allocation to a set of nodes that is closer the above selected
 	 * preferred node.
 	 */
-	lower_tier = node_states[N_MEMORY];
+	lower_tier = all_memory;
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		/*
 		 * Keep removing current tier from lower_tier nodes,
@@ -542,7 +554,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
-	if (!node_state(node, N_MEMORY))
+	if (!node_state(node, N_MEMORY) && !node_state(node, N_MEMORY_PRIVATE))
 		return ERR_PTR(-EINVAL);
 
 	mt_calc_adistance(node, &adist);
@@ -865,6 +877,30 @@ int mt_calc_adistance(int node, int *adist)
 }
 EXPORT_SYMBOL_GPL(mt_calc_adistance);
 
+/**
+ * memory_tier_refresh_demotion() - Re-establish demotion targets
+ *
+ * Called by services after registering or unregistering ops->migrate_to on
+ * a private node, so that establish_demotion_targets() picks up the change.
+ */
+void memory_tier_refresh_demotion(void)
+{
+	int nid;
+
+	mutex_lock(&memory_tier_lock);
+	/*
+	 * Ensure private nodes are registered with a tier, otherwise
+	 * they won't show up in any node's demotion targets nodemask.
+	 */
+	for_each_node_state(nid, N_MEMORY_PRIVATE) {
+		if (!__node_get_memory_tier(nid))
+			set_node_memory_tier(nid);
+	}
+	establish_demotion_targets();
+	mutex_unlock(&memory_tier_lock);
+}
+EXPORT_SYMBOL_GPL(memory_tier_refresh_demotion);
+
 static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 					      unsigned long action, void *_arg)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ec6c1f8e85d8..e272dfdc6b00 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5589,7 +5589,8 @@ static int node_load[MAX_NUMNODES];
  *
  * Return: node id of the found node or %NUMA_NO_NODE if no node is found.
  */
-int find_next_best_node(int node, nodemask_t *used_node_mask)
+int find_next_best_node_in(int node, nodemask_t *used_node_mask,
+			   const nodemask_t *candidates)
 {
 	int n, val;
 	int min_val = INT_MAX;
@@ -5599,12 +5600,12 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
 	 * Use the local node if we haven't already, but for memoryless local
 	 * node, we should skip it and fall back to other nodes.
 	 */
-	if (!node_isset(node, *used_node_mask) && node_state(node, N_MEMORY)) {
+	if (!node_isset(node, *used_node_mask) && node_isset(node, *candidates)) {
 		node_set(node, *used_node_mask);
 		return node;
 	}
 
-	for_each_node_state(n, N_MEMORY) {
+	for_each_node_mask(n, *candidates) {
 
 		/* Don't want a node to appear more than once */
 		if (node_isset(n, *used_node_mask))
@@ -5636,6 +5637,11 @@ int find_next_best_node(int node, nodemask_t *used_node_mask)
 	return best_node;
 }
 
+int find_next_best_node(int node, nodemask_t *used_node_mask)
+{
+	return find_next_best_node_in(node, used_node_mask,
+				      &node_states[N_MEMORY]);
+}
 
 /*
  * Build zonelists ordered by node and zones within node.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6113be4d3519..0f534428ea88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -58,6 +58,7 @@
 #include <linux/random.h>
 #include <linux/mmu_notifier.h>
 #include <linux/parser.h>
+#include <linux/node_private.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -355,6 +356,10 @@ static bool can_demote(int nid, struct scan_control *sc,
 	if (demotion_nid == NUMA_NO_NODE)
 		return false;
 
+	/* Don't demote when the target's service signals backpressure */
+	if (node_private_migration_blocked(demotion_nid))
+		return false;
+
 	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
 	return mem_cgroup_node_allowed(memcg, demotion_nid);
 }
@@ -1022,8 +1027,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 				     struct pglist_data *pgdat)
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
-	unsigned int nr_succeeded;
+	int first_nid = target_nid;
+	unsigned int nr_succeeded = 0;
 	nodemask_t allowed_mask;
+	int ret;
 
 	struct migration_target_control mtc = {
 		/*
@@ -1046,6 +1053,27 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 
 	node_get_allowed_targets(pgdat, &allowed_mask);
 
+	/* Try private node targets until we find non-private node */
+	while (node_state(target_nid, N_MEMORY_PRIVATE)) {
+		unsigned int nr = 0;
+
+		ret = node_private_migrate_to(demote_folios, target_nid,
+					      MIGRATE_ASYNC, MR_DEMOTION,
+					      &nr);
+		nr_succeeded += nr;
+		if (ret == 0 || list_empty(demote_folios))
+			return nr_succeeded;
+
+		target_nid = next_node_in(target_nid, allowed_mask);
+		if (target_nid == first_nid)
+			return nr_succeeded;
+		if (!node_state(target_nid, N_MEMORY_PRIVATE))
+			break;
+	}
+
+	/* target_nid is a non-private node; use standard migration */
+	mtc.nid = target_nid;
+
 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
-- 
2.53.0


