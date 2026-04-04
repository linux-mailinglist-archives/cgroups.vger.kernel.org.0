Return-Path: <cgroups+bounces-15174-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP52H82H0GmY8gYAu9opvQ
	(envelope-from <cgroups+bounces-15174-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Apr 2026 05:38:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CE7399C34
	for <lists+cgroups@lfdr.de>; Sat, 04 Apr 2026 05:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A563020A7A
	for <lists+cgroups@lfdr.de>; Sat,  4 Apr 2026 03:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61A92F8BC3;
	Sat,  4 Apr 2026 03:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUOIvCwc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270E7081A
	for <cgroups@vger.kernel.org>; Sat,  4 Apr 2026 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775273930; cv=none; b=tCRILhuFpE+8nb06s13tVl84OxF42mC+Cp5DHyj86Acthtk5dnvON+inI5iZKNIGndUxVhp0VI2Li6Ol36YnYwyovkS+Cb5LKH7R7oOlqhywUhlhlvEWu8Un9bfyV1uudXFFhWwB1uB0529Ee4IvJGjZucl1WE8DewfzVXvC1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775273930; c=relaxed/simple;
	bh=mL+c6eCZedn3xRYfM+0CLBd8b2ah649HOnkrhFPfDxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWHX968kn19PG7vqMApIUiMAYrUSm3LzkYVjXRaO6BvDdqs7hybl+B9ZLjNQUNa2FhuFkwQjwDO5MtPt8KSgVQqvlXd16qTv3OMgyaBcC3yfypBgAUzDTQZeDw5binE3uaITlYNEN17lw7pVzmNtDgCv/ssapBoZ34Y6OribYHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUOIvCwc; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbba5076c8so548063a34.0
        for <cgroups@vger.kernel.org>; Fri, 03 Apr 2026 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775273928; x=1775878728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnK6OH8b4keQaVFK/5OEkwznTAbTC+vEuBT5MrB5GfA=;
        b=VUOIvCwc14mpX0UYEsJsKmgowx3r4TLWR5pluSgTj/mkCToA15hXzfypkgdxvlx7Cf
         zj2YTEMoWULkkJzG59wHhFFW9MBa9KM9mWFvHudfayS4l5eWsPwSJVExuoJxD7sHi6OO
         Oa26XTE8zb7QSz5fWIvGbzecCiA37VVqxLDHeySiCxUiWuExNeClyfFOXzTv9XnEgMfu
         njOSsjwXmJVt/B9dpxSmAOrezF6Oc139qg4vPkCp0tuJ4P7qCZ+9QUzbVS8D+QnIx7tW
         EpruqROj2ykfcioyY2KFuVlrAB/3H0Oy650wOQWm5UKZ/Ax1pKxr4R0hvpE10TZbeoz9
         mSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775273928; x=1775878728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnK6OH8b4keQaVFK/5OEkwznTAbTC+vEuBT5MrB5GfA=;
        b=ktB1kQf/zzxQPGQ/FVfv5OvE2xCaz2l+4Ze4s1T1v3N3HPUJnhhg6gFtBa2hYimL/s
         8fEipEGe5eiBZ9W5ZKK1cYbcYyW25KWRKIDGgNttGZcTWxLZ6UtGG1Qd8zZoQ5w0CJbm
         wKXxMgjsn+U9ZB5MyJQs3cIN6nhBskb4CQFjUET2ZNja31jyvoiqa0UGwb0UdEnctZ9s
         ECy/Vyoymrkzlr/Kgsr5P8QYWz1+P3k5BKcSk1ytgbkVFBN0GuNu2oHEgVtkDmBg0G4v
         l2iJymn1784GnvN6GoxyWw6qGj5Uu6Y8FBUPg1s53T854P2uauxHQfuP4BZuuO5VtqB5
         sWdQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+QFl7Alxc3ul5AqSPOPgTYHMkrQ4nkQL/uyjcGPPZn0Q9yG3LYoBj6qBXIB1MvRvGBgylDhCa@vger.kernel.org
X-Gm-Message-State: AOJu0YzueWMFtaQeW1vNl4NexH9Dwj1oY0gt9MFeWW5dh+7O3A4YiNK6
	LHUWqCOKaoeygcEPB0Kxdo/TicW5rsO+i1Co1EObwg335wqHyflqtCUJ
X-Gm-Gg: ATEYQzyCcgzfnnDzI06jsCWtv2hgHIoOYNCulFJTE6AYYDNrPKVGkhlncCeCb1I48r0
	snTrHJbpLjXHWV0WYcIBDDDhjKGp+s5sXCluOBy5aLiB33+LktfnVvmMHg9V/rxLGpHaqhU+9y0
	6Il7AmBgbvSY4EaF8C3hB8RamNLa75f+8RYJvhxGtKeTJmdxYU1LfDKMP7J+Xjj4k4nrxNrG8J3
	ZINfRQrvLvN1ohnXwK/S+5qGmWLqKeJ271ckpVyeZWNZ//6tUdWaOLd08mKc4VMS2ShC5jfoKcb
	jrTIURJULXlShtBEsbpSpEkFqUE3EOHksPsBoLkQzbBhn+qdarSTMgCOjmx7aFsmMuldQxemPAH
	LCIZ+Im0g+59WK10YnZDbrBAUEzKKdPwpRa5rfczVMI0CR3/AgUnVSec3EKGTckafR0EOhs4jNv
	FqHsnnIy4MRcJ9hcOD4phh
X-Received: by 2002:a05:6808:6f91:b0:467:2652:b29d with SMTP id 5614622812f47-46ef5001816mr2779936b6e.8.1775273927383;
        Fri, 03 Apr 2026 20:38:47 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d8f9609bfsm4224118b6e.3.2026.04.03.20.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 20:38:45 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Date: Fri,  3 Apr 2026 20:38:43 -0700
Message-ID: <20260404033844.1892595-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15174-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5CE7399C34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

enum memcg_stat_item includes memory that is tracked on a per-memcg
level, but not at a per-node (and per-lruvec) level. Diagnosing
memory pressure for memcgs in multi-NUMA systems can be difficult,
since not all of the memory accounted in memcg can be traced back
to a node. In scenarios where numa nodes in an memcg are asymmetrically
stressed, this difference can be invisible to the user.

Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
to give visibility into per-node breakdowns for percpu allocations.

This will get us closer to being able to know the memcg and physical
association of all memory on the system. Specifically for percpu, this
granularity will help demonstrate footprint differences on systems with
asymmetric NUMA nodes.

Because percpu memory is accounted at a sub-PAGE_SIZE level, we must
account node level statistics (accounted in PAGE_SIZE units) and
memcg-lruvec statistics separately. Account node statistics when the pcpu
pages are allocated, and account memcg-lruvec statistics when pcpu
objects are handed out.

To do account these separately, expose mod_memcg_lruvec_state to be
used outside of memcontrol.

The memory overhead of this patch is small; it adds 16 bytes
per-cgroup-node-cpu. For an example machine with 200 CPUs split across
2 nodes and 50 cgroups in the system, we see a 312.5 kB increase. Note
that this is the same cost as any other item in memcg_node_stat_item.

Performance impact is also negligible. These are results from a kernel
module which performs 100k percpu allocations via __alloc_percpu_gfp
with GFP_KERNEL | __GFP_ACCOUNT in a cgroup, across 20 trials.
Batched performs 100k allocations followed by 100k frees, while
interleaved performs allocation --> free --> allocation ...

+-------------+----------------+--------------+--------------+
|    Test     | linus-upstream |    patch     |     diff     |
+-------------+----------------+--------------+--------------+
| Batched     | 6586 +/- 51    | 6595 +/- 35  | +9 (0.13%)   |
| Interleaved | 1053 +/- 126   | 1085 +/- 113 | +32 (+0.85%) |
+-------------+----------------+--------------+--------------+

One functional change is that there can be a tiny inconsistency between
the size of the allocation used for memcg limit checking and what is
charged to each lruvec due to dropping fractional charges when rounding.
In reality this value is very very small and always lies on the side of
memory checking at a higher threshold, so there is no behavioral change
from userspace.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
v1 --> v2:
- Updated commit message to be more explicit about motivation, suggested
  by Michal Hocko.
- Added performance and memory impacts, suggested by Michal Hocko and
  Yosry Ahmed.
- Instead of completely dropping the "extra" overhead of obj_cgroup
  pointers, they are now distributed among the nodes, proportional to
  the number of CPU each node has.
---
 include/linux/memcontrol.h |  4 +++-
 include/linux/mmzone.h     |  4 +++-
 mm/memcontrol.c            | 12 +++++-----
 mm/percpu-vm.c             | 14 ++++++++++--
 mm/percpu.c                | 45 ++++++++++++++++++++++++++++++++++----
 mm/vmstat.c                |  1 +
 6 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0861589695298..96dae769c60d6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -34,7 +34,6 @@ struct kmem_cache;
 enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SOCK,
-	MEMCG_PERCPU_B,
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
@@ -909,6 +908,9 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
+void mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			    int val);
+
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 void mod_memcg_state(struct mem_cgroup *memcg,
 		     enum memcg_stat_item idx, int val);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7bd0134c241ce..e38d8fe8552b1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -328,6 +328,7 @@ enum node_stat_item {
 #endif
 	NR_BALLOON_PAGES,
 	NR_KERNEL_FILE_PAGES,
+	NR_PERCPU_B,
 	NR_VM_NODE_STAT_ITEMS
 };
 
@@ -365,7 +366,8 @@ static __always_inline bool vmstat_item_in_bytes(int idx)
 	 * byte-precise.
 	 */
 	return (idx == NR_SLAB_RECLAIMABLE_B ||
-		idx == NR_SLAB_UNRECLAIMABLE_B);
+		idx == NR_SLAB_UNRECLAIMABLE_B ||
+		idx == NR_PERCPU_B);
 }
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a47fb68dd65f1..b320b6a426966 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -377,6 +377,7 @@ static const unsigned int memcg_node_stat_items[] = {
 	NR_UNEVICTABLE,
 	NR_SLAB_RECLAIMABLE_B,
 	NR_SLAB_UNRECLAIMABLE_B,
+	NR_PERCPU_B,
 	WORKINGSET_REFAULT_ANON,
 	WORKINGSET_REFAULT_FILE,
 	WORKINGSET_ACTIVATE_ANON,
@@ -428,7 +429,6 @@ static const unsigned int memcg_node_stat_items[] = {
 static const unsigned int memcg_stat_items[] = {
 	MEMCG_SWAP,
 	MEMCG_SOCK,
-	MEMCG_PERCPU_B,
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
@@ -920,9 +920,8 @@ static void __mod_memcg_lruvec_state(struct mem_cgroup_per_node *pn,
 	put_cpu();
 }
 
-static void mod_memcg_lruvec_state(struct lruvec *lruvec,
-				     enum node_stat_item idx,
-				     int val)
+void mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			    int val)
 {
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
@@ -936,6 +935,7 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 
 	get_non_dying_memcg_end();
 }
+EXPORT_SYMBOL(mod_memcg_lruvec_state);
 
 /**
  * mod_lruvec_state - update lruvec memory statistics
@@ -1535,7 +1535,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "kernel_stack",		NR_KERNEL_STACK_KB		},
 	{ "pagetables",			NR_PAGETABLE			},
 	{ "sec_pagetables",		NR_SECONDARY_PAGETABLE		},
-	{ "percpu",			MEMCG_PERCPU_B			},
+	{ "percpu",			NR_PERCPU_B			},
 	{ "sock",			MEMCG_SOCK			},
 	{ "vmalloc",			NR_VMALLOC			},
 	{ "shmem",			NR_SHMEM			},
@@ -1597,7 +1597,7 @@ static const struct memory_stat memory_stats[] = {
 static int memcg_page_state_unit(int item)
 {
 	switch (item) {
-	case MEMCG_PERCPU_B:
+	case NR_PERCPU_B:
 	case MEMCG_ZSWAP_B:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
index 4f5937090590d..e36b639f521dd 100644
--- a/mm/percpu-vm.c
+++ b/mm/percpu-vm.c
@@ -55,7 +55,8 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
 			    struct page **pages, int page_start, int page_end)
 {
 	unsigned int cpu;
-	int i;
+	int nr_pages = page_end - page_start;
+	int i, nid;
 
 	for_each_possible_cpu(cpu) {
 		for (i = page_start; i < page_end; i++) {
@@ -65,6 +66,10 @@ static void pcpu_free_pages(struct pcpu_chunk *chunk,
 				__free_page(page);
 		}
 	}
+
+	for_each_node(nid)
+		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
+				-1L * nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
 }
 
 /**
@@ -84,7 +89,8 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
 			    gfp_t gfp)
 {
 	unsigned int cpu, tcpu;
-	int i;
+	int nr_pages = page_end - page_start;
+	int i, nid;
 
 	gfp |= __GFP_HIGHMEM;
 
@@ -97,6 +103,10 @@ static int pcpu_alloc_pages(struct pcpu_chunk *chunk,
 				goto err;
 		}
 	}
+
+	for_each_node(nid)
+		mod_node_page_state(NODE_DATA(nid), NR_PERCPU_B,
+				    nr_pages * nr_cpus_node(nid) * PAGE_SIZE);
 	return 0;
 
 err:
diff --git a/mm/percpu.c b/mm/percpu.c
index b0676b8054ed0..51c160deca01a 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1632,6 +1632,45 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 	return true;
 }
 
+/*
+ * pcpu_mod_memcg_lruvec - update per-node memcg percpu stats
+ * @objcg: object cgroup to charge
+ * @size: size of pcpu allocation
+ * @sign: 1 for charge, -1 for uncharge
+ *
+ * Charge percpu memory across NUMA nodes proportional to per-node CPU count.
+ * Includes the obj_cgroup pointer overhead (see pcpu_obj_full_size) from the
+ * chunk's obj_exts array, but spreads proportionally across all nodes to
+ * avoid attributing it to a single node.
+ *
+ * The "extra" size calculation is best-effort but deterministic.
+ * Charges will equal uncharges, although there may be small discrepancies
+ * due to rounding up/down.
+ */
+static void pcpu_mod_memcg_lruvec(struct obj_cgroup *objcg, size_t size,
+				  int sign)
+{
+	struct mem_cgroup *memcg;
+	size_t extra = size / PCPU_MIN_ALLOC_SIZE * sizeof(struct obj_cgroup *);
+	int nid;
+
+	memcg = obj_cgroup_memcg(objcg);
+	for_each_node(nid) {
+		struct lruvec *lruvec;
+		unsigned int nr_cpus = nr_cpus_node(nid);
+		long charge;
+
+		if (!nr_cpus)
+			continue;
+
+		charge = nr_cpus * size +
+			 mult_frac(extra, nr_cpus, num_possible_cpus());
+
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+		mod_memcg_lruvec_state(lruvec, NR_PERCPU_B, sign * charge);
+	}
+}
+
 static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 				       struct pcpu_chunk *chunk, int off,
 				       size_t size)
@@ -1644,8 +1683,7 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 		chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = objcg;
 
 		rcu_read_lock();
-		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-				pcpu_obj_full_size(size));
+		pcpu_mod_memcg_lruvec(objcg, size, 1);
 		rcu_read_unlock();
 	} else {
 		obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
@@ -1667,8 +1705,7 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 	obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
 
 	rcu_read_lock();
-	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-			-pcpu_obj_full_size(size));
+	pcpu_mod_memcg_lruvec(objcg, size, -1);
 	rcu_read_unlock();
 
 	obj_cgroup_put(objcg);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b33097ab9bc81..d73c3355be715 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1296,6 +1296,7 @@ const char * const vmstat_text[] = {
 #endif
 	[I(NR_BALLOON_PAGES)]			= "nr_balloon_pages",
 	[I(NR_KERNEL_FILE_PAGES)]		= "nr_kernel_file_pages",
+	[I(NR_PERCPU_B)]			= "nr_percpu",
 #undef I
 
 	/* system-wide enum vm_stat_item counters */
-- 
2.52.0


