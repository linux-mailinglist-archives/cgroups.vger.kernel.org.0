Return-Path: <cgroups+bounces-15626-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNdWJDwR+mmfIwMAu9opvQ
	(envelope-from <cgroups+bounces-15626-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:48:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E92C4D08D8
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 146293050BE1
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB4D495511;
	Tue,  5 May 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGmeBTPs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041C1492526
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995592; cv=none; b=HWmhdbxcGo+ghlz7zZqrQlRagFtraEW/18EyV6hUN+j1pidStyDqLhsn2QDxlz6q6CvF0z5PpSJLv5Hixvs5dcP0qR3Mkm6wE+y3R9XzIfHMOkUc5/Q/+B3Z7WqGukY4SbLmLMwsU5q92IHcKjWEpYKeIcGFQsGjZ5nwDm1SeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995592; c=relaxed/simple;
	bh=Hd+gorxnpksj2SeHzQNvJk6R01VLS+FyxGb3FAaP1tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDfFjm3CSr4CxuQufGhGsWxPOELdXVzVhS1rAV/WFlTRcGS/+cD/byM97kk3mdp6RihQf1b1+DFq7J4nuJADEnOmF9KwN5ELHPnGy23GVppU9LqH5iyf48EraT3ea4/IhMDcCIVbsByPXS+qSlucbdUMaJtlZTxTf5WC8z9iF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGmeBTPs; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479d593a0c3so5621b6e.0
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995586; x=1778600386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/yyOr/4pj99tbSJw4a+KNInaif0dFyRreHuOMw4Fwo=;
        b=qGmeBTPs7/1NfMIWORwmMkkfNLkaYdkfgi6w4xCxZgwP10oiKf4+DsICDzS4n+nxHP
         6s/Csu7XJ9Lu5N18W0efNz9eA6DOjisIq2GiWAsP1eXMFXtAV3BuZ5yj5R0cSsiKDemC
         D5TSLPUNooFHlapFQLVFvWqKuvbR2rtbW8cvTKtj0Yh15pCI8epliliq9HEInCURGe26
         /hw5Lhajy7x0ybxBBURNMYoiNYuhFc/GATQ/qeRT4oVNYA2Y6I/GreNkemzRP+YlV3XW
         +t4JdeGLDc+6awDqSXlWSBZzKvrJoNReYHpFFulH6ravER8gKrFS2pSVNcfkVgjkJA1n
         y0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995586; x=1778600386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/yyOr/4pj99tbSJw4a+KNInaif0dFyRreHuOMw4Fwo=;
        b=fYj7bvm0jjXiiANKdFyYwZt95HqhKbe7m8oXq0fKWnbQ0FhfLAmi43uV9hultnlJ9w
         N/72DA87AlYWKJ+J9gvKNSuTCyQM7HBXJRVUPSDAdvGJBkuQ7F7ZQa4PeswYr2DiCxEi
         yABFfmlHg0L9vKRaj1cwkJKwhgpWaEyjxxl5K/BwVYghQ6scfuAKClGJTfiiM3EAe5B9
         ethQ3IO3uthjpWudEoFs0X4B3d27sI9EqR3TkatitOCY4bEPDeKBcN3NmxYjolK7AczQ
         AxiDdJzEoX8mErG+a/LPCByKo5przt7r84cyPXqDQB238SskDzORos1OFZIE7EDRnbYA
         y6Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/B53fsa5+hdMTJFUywl9DzEmUd17WSo7SS5eoTH84HMblI8wAEY/RYc2ws3HcxwtPAu8V9zO0X@vger.kernel.org
X-Gm-Message-State: AOJu0YzQGkNnRFs6uS7IKK/itbqFb7pnsMqK2OzSJs9lYksKHq+mqmo8
	PxNnS3TfGU5BMxPPQOzGLAACbgNdcazDbMHdATQe7C4uQ5NS10rQZuAh
X-Gm-Gg: AeBDiet72J71nbTrJsPJb+9C4eyCwZTbm4C/XJTpZf13YZIjaktJCu6+1kTnvgzlnal
	fy9HwtOQkognGb4hxC1LEgKTShnWvnQ/k0UP98XBKHvNkOl6MvR3uPGL5OBqYaqaRcwGdHj1CcY
	Ijx9s1F2QfxB/EK1dLkbts1LTuoLiz378tV0/6TiPC2WPEuFGchqZMqWuQAznBfc7/PY1JiKS2G
	goMrxAoI/RVqdYAMZY9QrcblRPgHhr75WwFadD3s/vIc5y2k0wOYfFjqS90R9Y3G/Wgm8Dzo8GG
	fCuS7PZSsB7Mi4YP9z6o1ou+OpjCCKg43PrBxNzVGc/PbuKpT3sR5phD7W4rnBSmHf16nFcMC1P
	LJ7oWkulMifImyq8IpfuoOXUbHGIwSc/n3SPSw4qgh3iHb+vRn7VHPSdDeisVsiWoPz3TDwUYp1
	MGmlrxLBmMjI8lqolxAA6soADlumy5TAknsADKvgjUO6VYVpMMLbAL
X-Received: by 2002:a05:6808:e64b:b0:467:da0d:537e with SMTP id 5614622812f47-47d260dcc6cmr1641681b6e.7.1777995585821;
        Tue, 05 May 2026 08:39:45 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b33c1sm8866816b6e.1.2026.05.05.08.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:44 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [PATCH v6 21/22] vswap: batch contiguous vswap free calls
Date: Tue,  5 May 2026 08:38:50 -0700
Message-ID: <20260505153854.1612033-22-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E92C4D08D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15626-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

In vswap_free(), we release and reacquire the cluster lock for every
single entry, even for non-disk-swap backends where the lock drop is
unnecessary. Batch consecutive free operations to avoid this overhead.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/vswap.c | 97 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 36 deletions(-)

diff --git a/mm/vswap.c b/mm/vswap.c
index 3f86bbb3a5ea..f07e6d9ec1df 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -529,18 +529,18 @@ static void vswap_cluster_free(struct vswap_cluster *cluster)
 	call_rcu(&cluster->rcu, vswap_cluster_free_rcu);
 }
 
-static inline void release_vswap_slot(struct vswap_cluster *cluster,
-		unsigned long index)
+static inline void release_vswap_slot_nr(struct vswap_cluster *cluster,
+		unsigned long index, int nr)
 {
 	unsigned long slot_index = VSWAP_IDX_WITHIN_CLUSTER_VAL(index);
 
 	lockdep_assert_held(&cluster->lock);
-	cluster->count--;
+	cluster->count -= nr;
 
-	bitmap_clear(cluster->bitmap, slot_index, 1);
+	bitmap_clear(cluster->bitmap, slot_index, nr);
 
 	/* we only free uncached empty clusters */
-	if (refcount_dec_and_test(&cluster->refcnt))
+	if (refcount_sub_and_test(nr, &cluster->refcnt))
 		vswap_cluster_free(cluster);
 	else if (cluster->full && cluster_is_alloc_candidate(cluster)) {
 		cluster->full = false;
@@ -553,7 +553,7 @@ static inline void release_vswap_slot(struct vswap_cluster *cluster,
 		}
 	}
 
-	atomic_dec(&vswap_used);
+	atomic_sub(nr, &vswap_used);
 }
 
 /*
@@ -585,7 +585,7 @@ static unsigned short swp_desc_memcgid(struct swp_desc *desc);
  *
  * 1. Callers ensure no concurrent modification of the swap entry's internal
  *    state can occur. This is guaranteed by one of the following:
- *    - For vswap_free() callers: the swap entry's refcnt (swap count and
+ *    - For vswap_free_nr() callers: the swap entry's refcnt (swap count and
  *      swapcache pin) is down to 0.
  *    - For vswap_store_folio(), swap_zeromap_folio_set(), and zswap_entry_store()
  *      callers: the folio is locked and in the swap cache.
@@ -706,26 +706,17 @@ static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
 
 /*
  * Entered with the cluster locked. The cluster lock is held throughout.
- *
- * This is safe, because:
- *
- * 1. The swap entry to be freed has refcnt (swap count and swapcache pin)
- *    down to 0, so no one can change its internal state.
- *
- * 2. The swap entry to be freed still holds a refcnt to the cluster, keeping
- *    the cluster itself valid.
- *
- * 3. swap_slot_free_nr() takes the physical swap cluster lock (ci->lock),
- *    but the only vswap function called under ci->lock is vswap_rmap_set(),
- *    which uses atomic ops and does not take cluster->lock. So there is no
- *    ABBA deadlock risk.
  */
-static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
-	swp_entry_t entry)
+static void vswap_free_nr(struct vswap_cluster *cluster, swp_entry_t entry,
+		int nr)
 {
-	unsigned short id = swp_desc_memcgid(desc);
+	struct swp_desc *desc = __vswap_iter(cluster, entry.val);
+	unsigned short id;
 	struct mem_cgroup *memcg;
 
+	VM_WARN_ON(!desc);
+	id = swp_desc_memcgid(desc);
+
 	/*
 	 * The swap_cgroup id reference taken at swapout time pins this
 	 * memcg until swap_cgroup_clear() runs below, so we can resolve
@@ -733,11 +724,11 @@ static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 	 */
 	memcg = id ? mem_cgroup_from_id(id) : NULL;
 
-	release_backing(cluster, entry, 1, memcg);
-	__vswap_swap_cgroup_clear(cluster, entry, 1, memcg);
+	release_backing(cluster, entry, nr, memcg);
+	__vswap_swap_cgroup_clear(cluster, entry, nr, memcg);
 
-	/* erase forward mapping and release the virtual slot for reallocation */
-	release_vswap_slot(cluster, entry.val);
+	/* erase forward mapping and release the virtual slots for reallocation */
+	release_vswap_slot_nr(cluster, entry.val, nr);
 }
 
 
@@ -908,10 +899,18 @@ static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	bool ret = false;
-	int i;
+	swp_entry_t free_start;
+	unsigned short batch_memcgid = 0;
+	int i, free_nr = 0;
 
+	free_start.val = 0;
 	rcu_read_lock();
 	for (i = 0; i < nr; i++) {
+		/* flush pending free batch at cluster boundary */
+		if (free_nr && !VSWAP_IDX_WITHIN_CLUSTER_VAL(entry.val)) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		desc = vswap_iter(&cluster, entry.val);
 		VM_WARN_ON(!desc);
 		ret |= (desc->swap_count == 1 && desc->in_swapcache);
@@ -919,18 +918,34 @@ static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
 		if (!desc->swap_count && !desc->in_swapcache) {
 			if (xa_is_value(desc->shadow))
 				desc->shadow = NULL;
-			vswap_free(cluster, desc, entry);
-		} else if (!desc->swap_count && desc->in_swapcache &&
-			   desc->type == VSWAP_SWAPFILE) {
+			/* flush at cgroup boundary */
+			if (free_nr &&
+			    swp_desc_memcgid(desc) != batch_memcgid) {
+				vswap_free_nr(cluster, free_start, free_nr);
+				free_nr = 0;
+			}
+			if (!free_nr)
+				batch_memcgid = swp_desc_memcgid(desc);
+			if (!free_nr++)
+				free_start = entry;
+		} else {
+			if (free_nr) {
+				vswap_free_nr(cluster, free_start, free_nr);
+				free_nr = 0;
+			}
 			/*
 			 * swap_count just dropped to 0, but still in swap
 			 * cache. If backed by a physical swap slot, mark it
 			 * so the physical swap allocator can check cheaply.
 			 */
-			swap_rmap_mark_cache_only(desc->slot);
+			if (!desc->swap_count && desc->in_swapcache &&
+			    desc->type == VSWAP_SWAPFILE)
+				swap_rmap_mark_cache_only(desc->slot);
 		}
 		entry.val++;
 	}
+	if (free_nr)
+		vswap_free_nr(cluster, free_start, free_nr);
 	if (cluster)
 		spin_unlock(&cluster->lock);
 	rcu_read_unlock();
@@ -1032,8 +1047,9 @@ bool folio_free_swap(struct folio *folio)
 		VM_WARN_ON_FOLIO(!desc || desc->swap_cache != folio, folio);
 		desc->swap_cache = NULL;
 		desc->in_swapcache = false;
-		vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
 	}
+
+	vswap_free_nr(cluster, entry, nr);
 	spin_unlock_irq(&cluster->lock);
 	rcu_read_unlock();
 
@@ -1095,14 +1111,23 @@ static void __swapcache_clear(struct vswap_cluster *cluster,
 			      swp_entry_t entry, int nr)
 {
 	struct swp_desc *desc;
-	int i;
+	swp_entry_t free_start;
+	int i, free_nr = 0;
 
+	free_start = entry;
 	for (i = 0; i < nr; i++) {
 		desc = __vswap_iter(cluster, entry.val + i);
 		desc->in_swapcache = false;
-		if (!desc->swap_count)
-			vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
+		if (!desc->swap_count) {
+			if (!free_nr++)
+				free_start.val = entry.val + i;
+		} else if (free_nr) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 	}
+	if (free_nr)
+		vswap_free_nr(cluster, free_start, free_nr);
 }
 
 void swapcache_clear(swp_entry_t entry, int nr)
-- 
2.52.0


