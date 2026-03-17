Return-Path: <cgroups+bounces-14834-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMXlH6rhuGlukwEAu9opvQ
	(envelope-from <cgroups+bounces-14834-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 06:07:54 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5522A3E53
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 06:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 099EB3026596
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 05:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7723385A7;
	Tue, 17 Mar 2026 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kq8XzDBT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E56334C17
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773724058; cv=none; b=Li/+RO4/oKggZQ/8NZlgbSVK9GJN9erII+dqCAgYitPYihJoQ5wBnDlL+XhvvuosT0T7xkdZTODhDjpzSmq8/86/CvlyldB5DqnkTl4JAhMyK/BPDEvDNTUDb5pTAr5d6Xz8OVwyTeOTTHPJZAXOje9gUlGDV5+uwh7aW+d2rKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773724058; c=relaxed/simple;
	bh=ttY9j/UpN4+sijyePIBHa17EDf5VtnfJ+i7huWAIl9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtS6dJNTMIGAz965tMSQAFs5fjCjFUcrckUgp/+bglEm/O8fpZjZ6wAiWZ2Mz7JF115Hp4GYrBIKUmH6o4bn+W7CQ15Szao3S2jrr+XSiunvuEqle/rCy0YD+USv77APmixIknZkXRBJAncXvbRvFE5ivlcbMlVjsmWxkI/frew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kq8XzDBT; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773724045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jvrzqhBOTMeu5FRh46JduvKJCMGJbDc0HHQDFMieGFg=;
	b=kq8XzDBTIQsxWSNBDIDdDU3wpU2A9uAaKLj7F9RRgUTdEKLh/aUKY096/XXdbF1cfVia0G
	UuxREMFrxr3Gnv+Z8n/bBMoN3+lBsu+rPARb1wyLivp3zdOxajcPEPmzxts+MYlwKHRhra
	ybVR7w+A29IdIhXoL6edmwz2nJTjky4=
From: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	vbabka@suse.cz,
	ying.huang@linux.alibaba.com
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
	yuanchu@google.com,
	ziy@nvidia.com,
	kernel-team@meta.com
Subject: [PATCH v3] mm/mempolicy: track user-defined mempolicy allocations
Date: Mon, 16 Mar 2026 22:06:57 -0700
Message-ID: <20260317050657.47494-1-jp.kobryn@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14834-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[33];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC5522A3E53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When investigating pressure on a NUMA node, there is no straightforward way
to determine which user-defined policies are driving allocations to it.

Add NUMA mempolicy allocation counters as new node stat items. These
counters track allocations to nodes and also whether the allocations were
intentional or fallbacks.

The new stats follow the existing numa hit/miss/foreign style and have the
following meanings:

  hit
    - for nodemask-based policies, allocation succeeded within nodemask
    - for other policies, allocation succeeded on intended node
    - counted on the node of the allocation
  miss
    - allocation intended for other node, but happened on this one
    - counted on other node
  foreign
    - allocation intended on this node, but happened on other node
    - counted on this node

The existing numa_* counters cannot be adjusted to fill this role because
they are incremented in zone_statistics(), which also covers non-policy
allocations such as alloc_pages_node(). The mempolicy context is not
applicable at that level since in-kernel callers may make their own node
decisions independent of any task policy.

Allocations where task mempolicy is NULL are excluded since they do not
reflect a user designation and are already accounted for in the existing
numa_* stats.

Counters are exposed per-node in nodeN/vmstat and globally in /proc/vmstat.
They provide the information needed in step 3 of the investigation workflow
below:

1) Pressure/OOMs reported while system-wide memory is free.
2) Check /proc/zoneinfo or per-node stats in .../nodeN/vmstat to narrow
   down node(s) under pressure.
3) Check numa_mpol_{hit,miss,foreign} counters (added by this patch) on
   node(s) to see what policy is driving allocations there (and whether
   they are intentional vs fallback).
     - If active: a user-defined policy is driving allocations to the
       node. Proceed to step 4.
     - If inactive: pressure is from allocations without a user-defined
       policy. Stop and investigate task placement or node capacity
       instead.
4) Use /proc/*/numa_maps to identify tasks using the policy.

Signed-off-by: JP Kobryn (Meta) <jp.kobryn@linux.dev>
---
v3:
  - Moved stats off of memcg
  - Switched from per-policy to aggregated counters (18 -> 3)
  - Filter allocations with no user-specified policy

v2: https://lore.kernel.org/linux-mm/20260307045520.247998-1-jp.kobryn@linux.dev/
  - Replaced single per-policy total counter (PGALLOC_MPOL_*) with
    hit/miss/foreign triplet per policy
  - Changed from global node stats to per-memcg per-node tracking

v1: https://lore.kernel.org/linux-mm/20260212045109.255391-2-inwardvessel@gmail.com/

 include/linux/mmzone.h |  5 ++++
 mm/mempolicy.c         | 53 +++++++++++++++++++++++++++++++++++++++---
 mm/vmstat.c            |  5 ++++
 3 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7bd0134c241c..a9407a3b4c8a 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -323,6 +323,11 @@ enum node_stat_item {
 	PGSCAN_ANON,
 	PGSCAN_FILE,
 	PGREFILL,
+#ifdef CONFIG_NUMA
+	NUMA_MPOL_HIT,
+	NUMA_MPOL_MISS,
+	NUMA_MPOL_FOREIGN,
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e5528c35bbb8..c3bacc927a21 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2426,6 +2426,47 @@ static struct page *alloc_pages_preferred_many(gfp_t gfp, unsigned int order,
 	return page;
 }
 
+/*
+ * Count a user-defined mempolicy allocation. Stats are tracked per-node.
+ * The following numa_mpol_{hit/miss/foreign} pattern is used:
+ *
+ *   hit
+ *     - for nodemask-based policies, allocation succeeded within nodemask
+ *     - for other policies, allocation succeeded on intended node
+ *     - counted on the node of the allocation
+ *   miss
+ *     - allocation intended for other node, but happened on this one
+ *     - counted on other node
+ *   foreign
+ *     - allocation intended for this node, but happened on other node
+ *     - counted on this node
+ */
+static void mpol_count_numa_alloc(struct mempolicy *pol, int intended_nid,
+				  struct page *page, unsigned int order)
+{
+	int actual_nid = page_to_nid(page);
+	long nr_pages = 1L << order;
+	bool is_hit;
+
+	if (!current->mempolicy)
+		return;
+
+	if (pol->mode == MPOL_BIND || pol->mode == MPOL_PREFERRED_MANY)
+		is_hit = node_isset(actual_nid, pol->nodes);
+	else
+		is_hit = (actual_nid == intended_nid);
+
+	if (is_hit) {
+		mod_node_page_state(NODE_DATA(actual_nid), NUMA_MPOL_HIT, nr_pages);
+	} else {
+		/* account for miss on the fallback node */
+		mod_node_page_state(NODE_DATA(actual_nid), NUMA_MPOL_MISS, nr_pages);
+
+		/* account for foreign on the intended node */
+		mod_node_page_state(NODE_DATA(intended_nid), NUMA_MPOL_FOREIGN, nr_pages);
+	}
+}
+
 /**
  * alloc_pages_mpol - Allocate pages according to NUMA mempolicy.
  * @gfp: GFP flags.
@@ -2444,8 +2485,10 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 
 	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 
-	if (pol->mode == MPOL_PREFERRED_MANY)
-		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
+	if (pol->mode == MPOL_PREFERRED_MANY) {
+		page = alloc_pages_preferred_many(gfp, order, nid, nodemask);
+		goto out;
+	}
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    /* filter "hugepage" allocation, unless from alloc_pages() */
@@ -2471,7 +2514,7 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
 				nid, NULL);
 			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
-				return page;
+				goto out;
 			/*
 			 * If hugepage allocations are configured to always
 			 * synchronous compact or the vma has been madvised
@@ -2494,6 +2537,10 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		}
 	}
 
+out:
+	if (page)
+		mpol_count_numa_alloc(pol, nid, page, order);
+
 	return page;
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b33097ab9bc8..4a8384441870 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1291,6 +1291,11 @@ const char * const vmstat_text[] = {
 	[I(PGSCAN_ANON)]			= "pgscan_anon",
 	[I(PGSCAN_FILE)]			= "pgscan_file",
 	[I(PGREFILL)]				= "pgrefill",
+#ifdef CONFIG_NUMA
+	[I(NUMA_MPOL_HIT)]			= "numa_mpol_hit",
+	[I(NUMA_MPOL_MISS)]			= "numa_mpol_miss",
+	[I(NUMA_MPOL_FOREIGN)]			= "numa_mpol_foreign",
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
-- 
2.52.0


