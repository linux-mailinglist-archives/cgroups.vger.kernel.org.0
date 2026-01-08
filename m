Return-Path: <cgroups+bounces-12995-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D195D0620B
	for <lists+cgroups@lfdr.de>; Thu, 08 Jan 2026 21:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67579301C39F
	for <lists+cgroups@lfdr.de>; Thu,  8 Jan 2026 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8DE33122D;
	Thu,  8 Jan 2026 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="puL5YAtZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73A330D22
	for <cgroups@vger.kernel.org>; Thu,  8 Jan 2026 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904733; cv=none; b=uudkTcvGwbOYZ1XHhAa2PL9YKiQCZkP3qnNTcTW4EG5qZQJPDRSixi/I8sQLKtJ/sijNUD1U8LlGWywxyeAdtTKeFau8SIkeIVZ9oF1z6mav/dX4AU0D3ZdpR24nsgiju0oNgAhJYEMK5cSYZJKJtuigS7oBBy8JEHkdpIPGR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904733; c=relaxed/simple;
	bh=NC/62yOtZDEWDFQWBLBYdje42g/fgNjMQjSNsPds1BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjHXn7AqobYCBRtN8e94rsyHrPG7pjVj1/GmjR+Qd32hQb9PZKarDGB3cGsnp4FcM1ghBmKDdGSi27MvMaev0OTD3moN58SezBvavLxQMPfQ9lhKwieDDU8yQO7OSq8H92dTfX1Amr/g3Rpix49A1RBoIzE1/+ZXrhgifWmMpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=puL5YAtZ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8888a444300so31574936d6.1
        for <cgroups@vger.kernel.org>; Thu, 08 Jan 2026 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1767904730; x=1768509530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzEtunsMdBn4IQoHvFlHCM71GQRUPpw4LtA2vMizqz0=;
        b=puL5YAtZgxEuvAG04IYeir0DuN8twNxXu56/AVFQJ6lluJwVZBG+zhIpiua1FRe3OL
         0OtoJTrWYGJHAs1L0yke7BMnbAVPyMeXpxS7tICNUqOpzln7BtRoF7dMdQ6pdMpy2UwT
         ko+louZGFVbgcQQTFsdmO4RSDTv5FgGzF8c6A+aixQ1RJPhUZrcIJpRhddZDsFRPzBP8
         +he//p+vj8YeSB2Vog5DV8dVNGCmqPrRrPWoTDAXdnv/+VZI6SpIubKnGZOwi7sAqPJc
         MZrKNk3u/EsuybgdpJEYc5OuucQa8kxxS8bCtoMDAF9jo/XJjqR1HtgtDLkrmCX01SL5
         f0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767904730; x=1768509530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HzEtunsMdBn4IQoHvFlHCM71GQRUPpw4LtA2vMizqz0=;
        b=u4IgWJpyeN8fKzxMEHux+k9PofAbXprmrWcA5YvsBz/UrqjPgWp7JMcRz1/mQIP90W
         QzJ30gdZusd4FAj5JBfywcXcOZ4mhdPmivBVhg2oBNd7v8YuYHkYnINDLeaKj8xoapyo
         RMccwF8X1dBGTxbcppHARhl8Eee+bRdN1uRyETW3GCPFCSc+TFigsa2cauEmSKGSrfdf
         qhthivpwJ7Kx2ka/ODdHKysKWSNyifzXu0T+7fV2pT50yw2LfMFYoXWieSVhuXXBG+oL
         lEcNNCi2rmgDRvDGAHgsKrnce0fVgeTjHxM4SEbx1Um7HlCEa4n5KwwQZ0M088m1Y6e6
         L3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCXJ2JB4Opf0uS1kMN5wWPI0wG6X1im3SLpruuO5MRTHoHAtutVXuB8pnuyv7Ip7fNBqywm8Xuvd@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77DHJAqAaGnu8erkZOB4/dlZvJbO+0h4bQff7/nCSsfQecK8i
	AShgSvS3IqAPoEMCRhwZyP4dcYGSq9KPS7f3/siHuHWsTAstP8eUIm0hy+VO8QKwvZE=
X-Gm-Gg: AY/fxX5V2mG+sZ4/G7E0GqyekpNbHqI+NMOUQ2dQJ4O6oCxs62r7H0Jf5NpAM99Aq+r
	tZAWWm0MKORaMAgknQSnnogUcFd1jFIi8Uh79yVQ2EPR4Ygwhxnu6sLs8M3dV5hH5qR6odxnOxJ
	w80rqXsDjSw6+VQd0z1CQY+bMDJLodDTGKdmZtX7r7TAL7zDfDCeCSP5OyQ49YhVv1M4nbmqhst
	yQevBiUKfJztYI5JnL3aMcvxas2B4NhB8y4a72IQ6LR/+IAdaSUf3EUzx4+IqV7fSBCa3xAHfq5
	DHzCMGKK5qBU4HufSqnUDhtyyp5xMWhhe223ChNV2TOUylf3cb4qDZpvXnfppBuyXj2yiNmt6fl
	3za6AcO5u4ZjKff0QwOb3QVQ017mYgqKa4Wzl95/XHpRgKB9mLuuu9kBmL6BpOgqobYmu90ZEx8
	hPI/jdY96O0x5VNZ2kHnXXSnm7I3HjCTB/poE52VyptDn6gKfoB8Jq2Bc2RPMWkno6kbBziJMAG
	2c=
X-Google-Smtp-Source: AGHT+IF3fWiGbPzGJ2jrA579ah6au0pY7RZhvW9wnxA0yziJvwGxMvsH3haaiag/Ap3aYN6F9CC0+g==
X-Received: by 2002:a05:6214:29c1:b0:890:19d1:532c with SMTP id 6a1803df08f44-890842311f3mr108761396d6.34.1767904730313;
        Thu, 08 Jan 2026 12:38:50 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e472csm60483886d6.23.2026.01.08.12.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 12:38:49 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	corbet@lwn.net,
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
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	ziy@nvidia.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	osalvador@suse.de,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	zhengqi.arch@bytedance.com
Subject: [RFC PATCH v3 3/8] mm: restrict slub, compaction, and page_alloc to sysram
Date: Thu,  8 Jan 2026 15:37:50 -0500
Message-ID: <20260108203755.1163107-4-gourry@gourry.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108203755.1163107-1-gourry@gourry.net>
References: <20260108203755.1163107-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restrict page allocation and zone iteration to N_MEMORY nodes via
cpusets - or node_states[N_MEMORY] when cpusets is disabled.

__GFP_THISNODE allows N_PRIVATE nodes to be used explicitly (all
nodes become valid targets with __GFP_THISNODE).

This constrains core users of nodemasks to the node_states[N_MEMORY],
which is guaranteed to at least contain the set of nodes with sysram
memory blocks present at boot.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/gfp.h |  6 ++++++
 mm/compaction.c     |  6 ++----
 mm/page_alloc.c     | 27 ++++++++++++++++-----------
 mm/slub.c           |  8 ++++++--
 4 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b155929af5b1..0b6cdef7a232 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -321,6 +321,7 @@ struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int order,
 		struct mempolicy *mpol, pgoff_t ilx, int nid);
 struct folio *vma_alloc_folio_noprof(gfp_t gfp, int order, struct vm_area_struct *vma,
 		unsigned long addr);
+bool numa_zone_allowed(int alloc_flags, struct zone *zone, gfp_t gfp_mask);
 #else
 static inline struct page *alloc_pages_noprof(gfp_t gfp_mask, unsigned int order)
 {
@@ -337,6 +338,11 @@ static inline struct folio *folio_alloc_mpol_noprof(gfp_t gfp, unsigned int orde
 }
 #define vma_alloc_folio_noprof(gfp, order, vma, addr)		\
 	folio_alloc_noprof(gfp, order)
+static inline bool numa_zone_allowed(int alloc_flags, struct zone *zone,
+				     gfp_t gfp_mask)
+{
+	return true;
+}
 #endif
 
 #define alloc_pages(...)			alloc_hooks(alloc_pages_noprof(__VA_ARGS__))
diff --git a/mm/compaction.c b/mm/compaction.c
index 1e8f8eca318c..63ef9803607f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2829,10 +2829,8 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 					ac->highest_zoneidx, ac->nodemask) {
 		enum compact_result status;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_allowed(alloc_flags, zone, gfp_mask))
+			continue;
 
 		if (prio > MIN_COMPACT_PRIORITY
 					&& compaction_deferred(zone, order)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bb89d81aa68c..76b12cef7dfc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3723,6 +3723,16 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <=
 				node_reclaim_distance;
 }
+bool numa_zone_allowed(int alloc_flags, struct zone *zone, gfp_t gfp_mask)
+{
+	/* If cpusets is being used, check mems_allowed or sysram_nodes */
+	if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET))
+		return cpuset_zone_allowed(zone, gfp_mask);
+
+	/* Otherwise only allow N_PRIVATE if __GFP_THISNODE is present */
+	return (gfp_mask & __GFP_THISNODE) ||
+		node_isset(zone_to_nid(zone), node_states[N_MEMORY]);
+}
 #else	/* CONFIG_NUMA */
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 {
@@ -3814,10 +3824,9 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		struct page *page;
 		unsigned long mark;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_allowed(alloc_flags, zone, gfp_mask))
+			continue;
+
 		/*
 		 * When allocating a page cache page for writing, we
 		 * want to get it from a node that is within its dirty
@@ -4618,10 +4627,8 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		unsigned long min_wmark = min_wmark_pages(zone);
 		bool wmark;
 
-		if (cpusets_enabled() &&
-			(alloc_flags & ALLOC_CPUSET) &&
-			!__cpuset_zone_allowed(zone, gfp_mask))
-				continue;
+		if (!numa_zone_allowed(alloc_flags, zone, gfp_mask))
+			continue;
 
 		available = reclaimable = zone_reclaimable_pages(zone);
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
@@ -5131,10 +5138,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
 		unsigned long mark;
 
-		if (cpusets_enabled() && (alloc_flags & ALLOC_CPUSET) &&
-		    !__cpuset_zone_allowed(zone, gfp)) {
+		if (!numa_zone_allowed(alloc_flags, zone, gfp))
 			continue;
-		}
 
 		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
 		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
diff --git a/mm/slub.c b/mm/slub.c
index 861592ac5425..adebbddc48f6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3594,9 +3594,13 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 			struct kmem_cache_node *n;
 
 			n = get_node(s, zone_to_nid(zone));
+			if (!n)
+				continue;
+
+			if (!numa_zone_allowed(ALLOC_CPUSET, zone, pc->flags))
+				continue;
 
-			if (n && cpuset_zone_allowed(zone, pc->flags) &&
-					n->nr_partial > s->min_partial) {
+			if (n->nr_partial > s->min_partial) {
 				slab = get_partial_node(s, n, pc);
 				if (slab) {
 					/*
-- 
2.52.0


