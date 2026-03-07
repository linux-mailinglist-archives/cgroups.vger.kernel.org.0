Return-Path: <cgroups+bounces-14691-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHuxMe+vq2lCfgEAu9opvQ
	(envelope-from <cgroups+bounces-14691-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 05:56:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4743C22A2B7
	for <lists+cgroups@lfdr.de>; Sat, 07 Mar 2026 05:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2842130813D9
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2026 04:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F5C35DA52;
	Sat,  7 Mar 2026 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AD62MGvs"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A763636896D
	for <cgroups@vger.kernel.org>; Sat,  7 Mar 2026 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772859363; cv=none; b=odof0lQyBvqUhvnkQr47q9HGAIwDdBX4oojOENm+xW6HeBzvZYCC3asKaEtTcRrF7mI+QcqN0T2NNIT57R8WWf86Lp98gCsrP7pO8fkIlOGlDbX/vTn6sVhrNHp9zVFgwZPjSl7WUVfxz859/WfijTa/FpOTBofGi0V4AQ5cjUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772859363; c=relaxed/simple;
	bh=9utGfdH/DDTB5YslWGLkSxO3qF5pTouxRoJycyBsiV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkbsRA7K5xhHaASc8gLnt3gPCPR5PJ81m96WpNNyQtoSA6i2lBK7piN0/nQBXJYtsDO9mRs7MLrziO2iG5q+RT6F7qHvOXicizBYDRMVA5NsJ1LZx7U/s7D+h2hD1OBquO5zWtw2uaesPUJHOV2jiyuAM2rH00u5+kWMmHzppqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AD62MGvs; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772859340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qslBai9ysHE9ew/L17AVF59o+oz2ik2mT2v5csquk7k=;
	b=AD62MGvsgH5UsbaKcQmRpgY543m3jajlSbPMoIzoG1ox73ZbOLGlu5RHggz9CLInOOhWlh
	K7PziIlMA4BR/cAYNrbQYv4+yPPWBBijyp9pYVeyGAuY3uYXXSIWgSSdeoStPKb9hJ6dNK
	bPxwLiR1vUs8Ih4vjMA0pYjqY7x8evs=
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	vbabka@suse.cz
Cc: apopple@nvidia.com,
	axelrasmussen@google.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	david@kernel.org,
	eperezma@redhat.com,
	gourry@gourry.net,
	jasowang@redhat.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mst@redhat.com,
	rppt@kernel.org,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	surenb@google.com,
	virtualization@lists.linux.dev,
	weixugc@google.com,
	xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com,
	yuanchu@google.com,
	ziy@nvidia.com,
	kernel-team@meta.com
Subject: [PATCH v2] mm/mempolicy: track page allocations per mempolicy
Date: Fri,  6 Mar 2026 20:55:20 -0800
Message-ID: <20260307045520.247998-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 4743C22A2B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14691-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jp.kobryn@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_TWELVE(0.00)[33];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

When investigating pressure on a NUMA node, there is no straightforward way
to determine which policies are driving allocations to it.

Add per-policy page allocation counters as new node stat items. These
counters track allocations to nodes and also whether the allocations were
intentional or fallbacks.

The new stats follow the existing numa hit/miss/foreign style and have the
following meanings:

  hit
    - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
    - for other policies, allocation succeeded on intended node
    - counted on the node of the allocation
  miss
    - allocation intended for other node, but happened on this one
    - counted on other node
  foreign
    - allocation intended on this node, but happened on other node
    - counted on this node

Counters are exposed per-memcg, per-node in memory.numa_stat and globally
in /proc/vmstat.

Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
---
v2:
  - Replaced single per-policy total counter (PGALLOC_MPOL_*) with
    hit/miss/foreign triplet per policy
  - Changed from global node stats to per-memcg per-node tracking

v1:
https://lore.kernel.org/linux-mm/20260212045109.255391-2-inwardvessel@gmail.com/

 include/linux/mmzone.h | 20 ++++++++++
 mm/memcontrol.c        | 60 ++++++++++++++++++++++++++++
 mm/mempolicy.c         | 90 ++++++++++++++++++++++++++++++++++++++++--
 mm/vmstat.c            | 20 ++++++++++
 4 files changed, 187 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7bd0134c241c..c0517cbcb0e2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -323,6 +323,26 @@ enum node_stat_item {
 	PGSCAN_ANON,
 	PGSCAN_FILE,
 	PGREFILL,
+#ifdef CONFIG_NUMA
+	NUMA_MPOL_LOCAL_HIT,
+	NUMA_MPOL_LOCAL_MISS,
+	NUMA_MPOL_LOCAL_FOREIGN,
+	NUMA_MPOL_PREFERRED_HIT,
+	NUMA_MPOL_PREFERRED_MISS,
+	NUMA_MPOL_PREFERRED_FOREIGN,
+	NUMA_MPOL_PREFERRED_MANY_HIT,
+	NUMA_MPOL_PREFERRED_MANY_MISS,
+	NUMA_MPOL_PREFERRED_MANY_FOREIGN,
+	NUMA_MPOL_BIND_HIT,
+	NUMA_MPOL_BIND_MISS,
+	NUMA_MPOL_BIND_FOREIGN,
+	NUMA_MPOL_INTERLEAVE_HIT,
+	NUMA_MPOL_INTERLEAVE_MISS,
+	NUMA_MPOL_INTERLEAVE_FOREIGN,
+	NUMA_MPOL_WEIGHTED_INTERLEAVE_HIT,
+	NUMA_MPOL_WEIGHTED_INTERLEAVE_MISS,
+	NUMA_MPOL_WEIGHTED_INTERLEAVE_FOREIGN,
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 982231a078f2..4d29f723a2de 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -420,6 +420,26 @@ static const unsigned int memcg_node_stat_items[] = {
 	PGSCAN_ANON,
 	PGSCAN_FILE,
 	PGREFILL,
+#ifdef CONFIG_NUMA
+	NUMA_MPOL_LOCAL_HIT,
+	NUMA_MPOL_LOCAL_MISS,
+	NUMA_MPOL_LOCAL_FOREIGN,
+	NUMA_MPOL_PREFERRED_HIT,
+	NUMA_MPOL_PREFERRED_MISS,
+	NUMA_MPOL_PREFERRED_FOREIGN,
+	NUMA_MPOL_PREFERRED_MANY_HIT,
+	NUMA_MPOL_PREFERRED_MANY_MISS,
+	NUMA_MPOL_PREFERRED_MANY_FOREIGN,
+	NUMA_MPOL_BIND_HIT,
+	NUMA_MPOL_BIND_MISS,
+	NUMA_MPOL_BIND_FOREIGN,
+	NUMA_MPOL_INTERLEAVE_HIT,
+	NUMA_MPOL_INTERLEAVE_MISS,
+	NUMA_MPOL_INTERLEAVE_FOREIGN,
+	NUMA_MPOL_WEIGHTED_INTERLEAVE_HIT,
+	NUMA_MPOL_WEIGHTED_INTERLEAVE_MISS,
+	NUMA_MPOL_WEIGHTED_INTERLEAVE_FOREIGN,
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
@@ -1591,6 +1611,26 @@ static const struct memory_stat memory_stats[] = {
 #ifdef CONFIG_NUMA_BALANCING
 	{ "pgpromote_success",		PGPROMOTE_SUCCESS	},
 #endif
+#ifdef CONFIG_NUMA
+	{ "numa_mpol_local_hit",		NUMA_MPOL_LOCAL_HIT		},
+	{ "numa_mpol_local_miss",		NUMA_MPOL_LOCAL_MISS		},
+	{ "numa_mpol_local_foreign",		NUMA_MPOL_LOCAL_FOREIGN		},
+	{ "numa_mpol_preferred_hit",		NUMA_MPOL_PREFERRED_HIT		},
+	{ "numa_mpol_preferred_miss",		NUMA_MPOL_PREFERRED_MISS	},
+	{ "numa_mpol_preferred_foreign",	NUMA_MPOL_PREFERRED_FOREIGN	},
+	{ "numa_mpol_preferred_many_hit",	NUMA_MPOL_PREFERRED_MANY_HIT	},
+	{ "numa_mpol_preferred_many_miss",	NUMA_MPOL_PREFERRED_MANY_MISS	},
+	{ "numa_mpol_preferred_many_foreign",	NUMA_MPOL_PREFERRED_MANY_FOREIGN },
+	{ "numa_mpol_bind_hit",			NUMA_MPOL_BIND_HIT		},
+	{ "numa_mpol_bind_miss",		NUMA_MPOL_BIND_MISS		},
+	{ "numa_mpol_bind_foreign",		NUMA_MPOL_BIND_FOREIGN		},
+	{ "numa_mpol_interleave_hit",		NUMA_MPOL_INTERLEAVE_HIT	},
+	{ "numa_mpol_interleave_miss",		NUMA_MPOL_INTERLEAVE_MISS	},
+	{ "numa_mpol_interleave_foreign",	NUMA_MPOL_INTERLEAVE_FOREIGN	},
+	{ "numa_mpol_weighted_interleave_hit",	NUMA_MPOL_WEIGHTED_INTERLEAVE_HIT },
+	{ "numa_mpol_weighted_interleave_miss",	NUMA_MPOL_WEIGHTED_INTERLEAVE_MISS },
+	{ "numa_mpol_weighted_interleave_foreign", NUMA_MPOL_WEIGHTED_INTERLEAVE_FOREIGN },
+#endif
 };
 
 /* The actual unit of the state item, not the same as the output unit */
@@ -1642,6 +1682,26 @@ static int memcg_page_state_output_unit(int item)
 	case PGREFILL:
 #ifdef CONFIG_NUMA_BALANCING
 	case PGPROMOTE_SUCCESS:
+#endif
+#ifdef CONFIG_NUMA
+	case NUMA_MPOL_LOCAL_HIT:
+	case NUMA_MPOL_LOCAL_MISS:
+	case NUMA_MPOL_LOCAL_FOREIGN:
+	case NUMA_MPOL_PREFERRED_HIT:
+	case NUMA_MPOL_PREFERRED_MISS:
+	case NUMA_MPOL_PREFERRED_FOREIGN:
+	case NUMA_MPOL_PREFERRED_MANY_HIT:
+	case NUMA_MPOL_PREFERRED_MANY_MISS:
+	case NUMA_MPOL_PREFERRED_MANY_FOREIGN:
+	case NUMA_MPOL_BIND_HIT:
+	case NUMA_MPOL_BIND_MISS:
+	case NUMA_MPOL_BIND_FOREIGN:
+	case NUMA_MPOL_INTERLEAVE_HIT:
+	case NUMA_MPOL_INTERLEAVE_MISS:
+	case NUMA_MPOL_INTERLEAVE_FOREIGN:
+	case NUMA_MPOL_WEIGHTED_INTERLEAVE_HIT:
+	case NUMA_MPOL_WEIGHTED_INTERLEAVE_MISS:
+	case NUMA_MPOL_WEIGHTED_INTERLEAVE_FOREIGN:
 #endif
 		return 1;
 	default:
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0e5175f1c767..2417de75098d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -117,6 +117,7 @@
 #include <asm/tlb.h>
 #include <linux/uaccess.h>
 #include <linux/memory.h>
+#include <linux/memcontrol.h>
 
 #include "internal.h"
 
@@ -2426,6 +2427,83 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 	return page;
 }
 
+/*
+ * Count a mempolicy allocation. Stats are tracked per-node and per-cgroup.
+ * The following numa_{hit/miss/foreign} pattern is used:
+ *
+ *   hit
+ *     - for BIND and PREFERRED_MANY, allocation succeeded on node in nodemask
+ *     - for other policies, allocation succeeded on intended node
+ *     - counted on the node of the allocation
+ *   miss
+ *     - allocation intended for other node, but happened on this one
+ *     - counted on other node
+ *   foreign
+ *     - allocation intended on this node, but happened on other node
+ *     - counted on this node
+ */
+static void mpol_count_numa_alloc(struct mempolicy *pol, int intended_nid,
+				  struct page *page, unsigned int order)
+{
+	int actual_nid = page_to_nid(page);
+	long nr_pages = 1L << order;
+	enum node_stat_item hit_idx;
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+	bool is_hit;
+
+	if (!root_mem_cgroup || mem_cgroup_disabled())
+		return;
+
+	/*
+	 * Start with hit then use +1 or +2 later on to change to miss or
+	 * foreign respectively if needed.
+	 */
+	switch (pol->mode) {
+	case MPOL_PREFERRED:
+		hit_idx = NUMA_MPOL_PREFERRED_HIT;
+		break;
+	case MPOL_PREFERRED_MANY:
+		hit_idx = NUMA_MPOL_PREFERRED_MANY_HIT;
+		break;
+	case MPOL_BIND:
+		hit_idx = NUMA_MPOL_BIND_HIT;
+		break;
+	case MPOL_INTERLEAVE:
+		hit_idx = NUMA_MPOL_INTERLEAVE_HIT;
+		break;
+	case MPOL_WEIGHTED_INTERLEAVE:
+		hit_idx = NUMA_MPOL_WEIGHTED_INTERLEAVE_HIT;
+		break;
+	default:
+		hit_idx = NUMA_MPOL_LOCAL_HIT;
+		break;
+	}
+
+	if (pol->mode == MPOL_BIND || pol->mode == MPOL_PREFERRED_MANY)
+		is_hit = node_isset(actual_nid, pol->nodes);
+	else
+		is_hit = (actual_nid == intended_nid);
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_task(current);
+
+	if (is_hit) {
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(actual_nid));
+		mod_lruvec_state(lruvec, hit_idx, nr_pages);
+	} else {
+		/* account for miss on the fallback node */
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(actual_nid));
+		mod_lruvec_state(lruvec, hit_idx + 1, nr_pages);
+
+		/* account for foreign on the intended node */
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(intended_nid));
+		mod_lruvec_state(lruvec, hit_idx + 2, nr_pages);
+	}
+
+	rcu_read_unlock();
+}
+
 /**
  * alloc_pages_mpol - Allocate pages according to NUMA mempolicy.
  * @gfp: GFP flags.
@@ -2444,8 +2522,10 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 
 	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 
-	if (pol->mode == MPOL_PREFERRED_MANY)
-		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
+	if (pol->mode == MPOL_PREFERRED_MANY) {
+		page = alloc_pages_preferred_many(gfp, order, nid, nodemask);
+		goto out;
+	}
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    /* filter "hugepage" allocation, unless from alloc_pages() */
@@ -2471,7 +2551,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
 				nid, NULL);
 			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
-				return page;
+				goto out;
 			/*
 			 * If hugepage allocations are configured to always
 			 * synchronous compact or the vma has been madvised
@@ -2494,6 +2574,10 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		}
 	}
 
+out:
+	if (page)
+		mpol_count_numa_alloc(pol, nid, page, order);
+
 	return page;
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b33097ab9bc8..d9f745831624 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1291,6 +1291,26 @@ const char * const vmstat_text[] = {
 	[I(PGSCAN_ANON)]			= "pgscan_anon",
 	[I(PGSCAN_FILE)]			= "pgscan_file",
 	[I(PGREFILL)]				= "pgrefill",
+#ifdef CONFIG_NUMA
+	[I(NUMA_MPOL_LOCAL_HIT)]		= "numa_mpol_local_hit",
+	[I(NUMA_MPOL_LOCAL_MISS)]		= "numa_mpol_local_miss",
+	[I(NUMA_MPOL_LOCAL_FOREIGN)]		= "numa_mpol_local_foreign",
+	[I(NUMA_MPOL_PREFERRED_HIT)]		= "numa_mpol_preferred_hit",
+	[I(NUMA_MPOL_PREFERRED_MISS)]		= "numa_mpol_preferred_miss",
+	[I(NUMA_MPOL_PREFERRED_FOREIGN)]	= "numa_mpol_preferred_foreign",
+	[I(NUMA_MPOL_PREFERRED_MANY_HIT)]	= "numa_mpol_preferred_many_hit",
+	[I(NUMA_MPOL_PREFERRED_MANY_MISS)]	= "numa_mpol_preferred_many_miss",
+	[I(NUMA_MPOL_PREFERRED_MANY_FOREIGN)]	= "numa_mpol_preferred_many_foreign",
+	[I(NUMA_MPOL_BIND_HIT)]			= "numa_mpol_bind_hit",
+	[I(NUMA_MPOL_BIND_MISS)]		= "numa_mpol_bind_miss",
+	[I(NUMA_MPOL_BIND_FOREIGN)]		= "numa_mpol_bind_foreign",
+	[I(NUMA_MPOL_INTERLEAVE_HIT)]		= "numa_mpol_interleave_hit",
+	[I(NUMA_MPOL_INTERLEAVE_MISS)]		= "numa_mpol_interleave_miss",
+	[I(NUMA_MPOL_INTERLEAVE_FOREIGN)]	= "numa_mpol_interleave_foreign",
+	[I(NUMA_MPOL_WEIGHTED_INTERLEAVE_HIT)]	= "numa_mpol_weighted_interleave_hit",
+	[I(NUMA_MPOL_WEIGHTED_INTERLEAVE_MISS)]	= "numa_mpol_weighted_interleave_miss",
+	[I(NUMA_MPOL_WEIGHTED_INTERLEAVE_FOREIGN)] = "numa_mpol_weighted_interleave_foreign",
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
-- 
2.47.3


