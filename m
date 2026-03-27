Return-Path: <cgroups+bounces-15080-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LELMVPYxmkoPQUAu9opvQ
	(envelope-from <cgroups+bounces-15080-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 20:19:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 950B634A058
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 20:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC76230224F1
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2026 19:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBB737AA97;
	Fri, 27 Mar 2026 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpzc+MGj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D012BE031
	for <cgroups@vger.kernel.org>; Fri, 27 Mar 2026 19:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639181; cv=none; b=DShO20rPtoWbTzqpvIVuU8hPRA9+1OuoWhE//Vl4hixMnuhYiYMDDzXdRXR+x5nniFuzgigSICGJW++He1CAhCSImefqeNU1M5eiol2CuaMK9q+dMbF/bhtygWylgXhdIplIyt0f8MVu7HjZj2kUqb4z9SmBG5ZjCuhSd6weL5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639181; c=relaxed/simple;
	bh=mHiZ1XBdo4Ah4SJDDYH+/xbdYWRu1m/OZcr1uMyQ5Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELKKIGm2d2yhlj0sbdkVsKwere6I2c65EFOX0c1EnBN+ykaE4j2k5uZc2QXIftkPKKVn6thddauxAXMYGKS4MOHPEbfeKn8pcJTSTeDoOa35iahUZ2buYUKpuiSW3ZqyzCwo88kYD2st/IfDwyMQ5Sx9RmuKD3JFrhfk+1dOJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpzc+MGj; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-467161c4a1cso859179b6e.3
        for <cgroups@vger.kernel.org>; Fri, 27 Mar 2026 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639177; x=1775243977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g36eDtHxaYoJojvs9L9tY/Cu0/ANeoyQ3rXoQcxOHvE=;
        b=hpzc+MGjaXS9gyOd1MzCgbdbOEOp5azwCY6SoQQY5yrTLrcGwdmoWO135Ce5ACh6V8
         /YSDt3yLKHPZhepexbeSOybrW3SXxJvrW9NIny4+WrokVLnP1ZD12TvGnMNz6TB60sCW
         P17/UwKkFJbqoNGHbSvg4IKM3xTI5b5vs4/kGYjRICisEgx5Q2qT2nLpOYpe5QTuVE6n
         FQFrQ6b3MsE6Nu52RDokmbSjoubm9A/Z94NFuV1EpjkSSAu/4D6ZM+RrA0O7UJcPzqeV
         TaW/cQ4PLvhsZl4iVYuWWDtAGmJKZ7Kbpx2/gTH1hSpHtW7pilRbQrGSar1TkNXgZhrR
         Ap3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639177; x=1775243977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g36eDtHxaYoJojvs9L9tY/Cu0/ANeoyQ3rXoQcxOHvE=;
        b=Tur6aK56yiFWlGqgi1pXfPfUwpVGvEvjPJ2V54vlRQC+9/SZqm7W0J/NT95/DdlXfE
         nFRyA3k0tEe9cKOBI10YEsC/XaTLAY8V7O5ABXJG4XA3T09EUG/BLteP9wpl4QCMSWJM
         7/ex9e3t4TWjgfCUvX0VdCJ9qNPCo7pt5PuGbkV9amZ4QWjqilhgiMQZ9UplCxzToksa
         zMuQ6aTaCUeUneXfLiz421VkhbEmoJrjN0fbn1CWfS0ral2m+1CFwSjQzGA4aYFDTf+i
         N+sVCVHKXr7GMzm8lwJwA3v7W+wN3txHtlPjOiBI7gj+BaRoniZEvSnpSTtkU66oH9ph
         xMzw==
X-Forwarded-Encrypted: i=1; AJvYcCXW3wjA6CMb1DFWQ7XQJuGu6b4exwJ/9Tw1pHBFxkf8JeiqEyg0jvslMjGKP/+1H7IDapK3qfmQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwkAdA3Wm0/SzkN/ByQ7tsO64XaYqZg/DtFg2wJc8HTuxsRUdUi
	TXqtJlLCbKod+WK3VVJqie2gWw9pXEagztjEl7peufsjMdy5BumNS4Bb
X-Gm-Gg: ATEYQzw4mGOY0STGktNRrEpmdbu5n427sJm0IG3+ROMz1U/s8ZjLaPhmO1FhOA4kLuw
	AOGw+bRwKLNLV5iNS9GCBGg+42gdIKfJv20KxiWBJ6mZtBhg12XxcX2YqhsBVY7hu6lJm/uRj0X
	LA9UKuNMNYJ+O/B/Aw9rlv4GgrkRWwtwRavY6kk+Tas8nzFUHVW0EKpROLVXkkXnq5t4akoexbP
	Av4r6uPv5OJCuFvl5IZCWFJszAO5X8zh1lbWtcCXyRu8qnpKi2JHalQ0vkGrWXsy2QI9bE0Wnxs
	taeHQkqvYd/VGc5j4gPy4865aoa8eMN3XsG3NEPro8viWvqd321ydYmJygsNSdwi6x/uCxnmmWG
	a/FI/VCmJXej+2pmgI2TooSte8jZoWa+HwPE7ssZWvVjU/34XSBDp9BuuGGjAbGDYipyhMaM8PV
	5KyCP4JBYg8l0Yl69n/A==
X-Received: by 2002:a05:6808:894c:b0:467:2be4:9e39 with SMTP id 5614622812f47-46a8a5a37a8mr1494347b6e.39.1774639177209;
        Fri, 27 Mar 2026 12:19:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04cf9ceesm138877fac.15.2026.03.27.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:19:36 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
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
Subject: [PATCH] mm/percpu, memcontrol: Per-memcg-lruvec percpu accounting
Date: Fri, 27 Mar 2026 12:19:35 -0700
Message-ID: <20260327191936.1980054-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15080-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 950B634A058
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert MEMCG_PERCPU_B from a memcg_stat_item to a memcg_node_stat_item
to give visibility into per-node breakdowns for percpu allocations and
turn it into NR_PERCPU_B.

Because percpu memory is accounted at a sub-PAGE_SIZE level, we must
account node level statistics (accounted in PAGE_SIZE units) and
memcg-lruvec statistics separately. Account node statistics when the pcpu
pages are allocated, and account memcg-lruvec statistics when pcpu
objects are handed out.

To do account these separately, expose mod_memcg_lruvec_state to be
used outside of memcontrol.

One functional change is that we do not account the 8 byte objcg
pointer per-memcg-lruvec. Since the objcg membership is tracked
per-memcg and not percpu, there is no appropriate lruvec to charge this
memory to (see pcpu_obj_full_size). Instead of adding additional
mechanisms to detect which lruvec the 8 byte pointer belongs to, let's
just simplify and account the pcpu objects' size.

Limit-checking is still done with the additional 8 bytes.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h |  4 +++-
 include/linux/mmzone.h     |  4 +++-
 mm/memcontrol.c            | 12 ++++++------
 mm/percpu-vm.c             | 14 ++++++++++++--
 mm/percpu.c                | 24 ++++++++++++++++++++----
 mm/vmstat.c                |  1 +
 6 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 086158969529..96dae769c60d 100644
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
index 7bd0134c241c..e38d8fe8552b 100644
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
index a47fb68dd65f..b320b6a42696 100644
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
index 4f5937090590..e36b639f521d 100644
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
index b0676b8054ed..4ad3b9739eb9 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1632,6 +1632,24 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 	return true;
 }
 
+static void pcpu_mod_memcg_lruvec(struct obj_cgroup *objcg, int charge)
+{
+	struct mem_cgroup *memcg;
+	int nid;
+
+	memcg = obj_cgroup_memcg(objcg);
+	for_each_node(nid) {
+		struct lruvec *lruvec;
+		unsigned int nr_cpus = nr_cpus_node(nid);
+
+		if (!nr_cpus)
+			continue;
+
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+		mod_memcg_lruvec_state(lruvec, NR_PERCPU_B, nr_cpus * charge);
+	}
+}
+
 static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 				       struct pcpu_chunk *chunk, int off,
 				       size_t size)
@@ -1644,8 +1662,7 @@ static void pcpu_memcg_post_alloc_hook(struct obj_cgroup *objcg,
 		chunk->obj_exts[off >> PCPU_MIN_ALLOC_SHIFT].cgroup = objcg;
 
 		rcu_read_lock();
-		mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-				pcpu_obj_full_size(size));
+		pcpu_mod_memcg_lruvec(objcg, size);
 		rcu_read_unlock();
 	} else {
 		obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
@@ -1667,8 +1684,7 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
 	obj_cgroup_uncharge(objcg, pcpu_obj_full_size(size));
 
 	rcu_read_lock();
-	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
-			-pcpu_obj_full_size(size));
+	pcpu_mod_memcg_lruvec(objcg, -size);
 	rcu_read_unlock();
 
 	obj_cgroup_put(objcg);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b33097ab9bc8..d73c3355be71 100644
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


