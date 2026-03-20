Return-Path: <cgroups+bounces-14960-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GQeEwKhvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14960-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:33:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADABA2E0096
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F187430A0A76
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4043F54AF;
	Fri, 20 Mar 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kw0TM3ET"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389223F0742
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034890; cv=none; b=lHSZ+EwFqJVgLc43dOTgh6/p/lgANZok2pKhqSXrbruB2BQft/f4PMymHsHdhYVRjujyJpZPUlhcqEUKxTNYxDOethIzAUFS3QiCL/UnFC5kv5Knkq1eZZTN69EuEVufQkF3F5jxNgBLrjzKFz33g2Pk/rWJaMraS5tOSih8f+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034890; c=relaxed/simple;
	bh=6tM3YggV+QPo4Bc0AIw5AsLTHMBdvyhPywr1299vNlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rns3GWtRNB5HkQpJ95pfN7KwNB+XrYVmt0Cs3No+TA6Hes5jOhE5qEj7/E2YkUgjypfIP9JEx1cbUSYDLlJrWUc1ijH/f4INtA1FeagjYPD9R6v0VcrQtluh+iEloyx2rXxAhDPHFIxAmGx4p1I0tUf65lx34GcAkA5TpDlnj6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kw0TM3ET; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-467161c4b7aso1170260b6e.1
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034879; x=1774639679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y9sYeDkFRXTqw2dffTbd4gPkLlZAvqEb4BCG6FU9bk=;
        b=Kw0TM3ETR6dh7NDqsbJVdSaxNgaGx6s6WaFOC+J7S2mb7gJCuEH6BlvgighBzvfTJn
         k3xpqCvdqGA/fp/RMhypcWP8CZ6Zog5F6tn65vRJa2/k1tNhymc8b1sPxrWJpMPgFTV3
         PLs4UlmBCkAAsr/hQYfuuT9m8BFqFo0yckXSVRwbR0UzXYJ4vtfqWJDuvUKcmIVstyQA
         tGc8FOqeNS6Uh9rx9WO7H0z1mLZvlh62Fna1ZxWbVm29aONN3KUUnFZKrZ+QEnlX/x14
         LAIB/hrUAMfF7homVKY9bezXKIpsqf4BHLHwha4jJKVxz2w7JqEjnSJGoh7p3YSw8GCS
         wVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034879; x=1774639679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5Y9sYeDkFRXTqw2dffTbd4gPkLlZAvqEb4BCG6FU9bk=;
        b=HsOSXyxT4DhLydGAfQA/g5KEQiULEWF2/VGCoVADFZkyemBMWu8FRyzqBsCvzzRwlW
         2dsdkJ/D47uDXdIdPGRVkDIoOPY+QW3P4QpLhuFpVYCCNIlL+rlbh2V3jyUA44S+CVjO
         pnQnGj92zR07KJRiqf3IEL2aAAj8zUXbUPWCKbFCawt0CHjsyYjnvPdI/0njCOzKhp/t
         VY/s/j8r0+tyTmBXavVS8X3/lH+v8rpvxcjyskRJdxNZEPzXt1eiSC5wJZ8hojtzAHiz
         SPxKwvR+fgTk82StWI4ItUP5Lp2Q7HHW5BUmYTkLrfaX1u1MLCO+5at3GUj3D+6FTypD
         Yv4g==
X-Forwarded-Encrypted: i=1; AJvYcCXJp2T+MIc+BjD0Gbw7uxwd3JP5e6eDMEqu/LO67+QUzwm08Up9ksvxYl4C4yUS6iJ99Vu+hAuS@vger.kernel.org
X-Gm-Message-State: AOJu0YyGpw7p99QmysrEfNc2AQ1GnjmfRyb0i1EBTB2xngxFBWBK4dsn
	buKlfzpHP5jclGp0PewaZvtrzvAa2bKK4NGJvB5CYSntouc5jcFTafdc
X-Gm-Gg: ATEYQzzW48ego+BJyoHBFNcBxk3jFR82S7NAZ/uzO/EYCjMWZsinOCr4dY8nYB9Np5P
	2gtbT/9ZLrqHbC/dfB/MMECUNZdKhmk7ZM8BD9yjm2u5SdWfMkL437uXvm15wlalkhaF+97xPW1
	XixI3HtmiL2oSaP3yGZnVSnhgQfE1nCv1u5zWObfcpJwQMORbyvDbOcjvOTGCNtbGkLstT4htgS
	F15RWxUu2VKT71iaYfSa/XB7Q+cM6ynALmO5a//U7EC3fSY5kGYaIHTmioA1+VmvqvfFwKqy3Pf
	oovduPoQZ6A0nVFuOQs1Aw8cJus/e+y6UX+OYvVOIf2NrChf12w7uohFx1zeMiDAao+CEFmph8q
	V+8RwgdSC9hA+cdNqpBQiDh3I6OqevWVLJrISTXsgEor+jaFBNcUdSgEEgE5Irhop6O7M611ITn
	/OkUdm7Jz9RTCbg3VpwDJMbOFyOiS843Dc4alDXLQSitBYQA==
X-Received: by 2002:a05:6808:15a6:b0:463:c56f:a45b with SMTP id 5614622812f47-467e5ed2b5fmr2649961b6e.28.1774034878623;
        Fri, 20 Mar 2026 12:27:58 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7ecaf2esm1942707b6e.10.2026.03.20.12.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:57 -0700 (PDT)
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
	riel@surriel.com
Subject: [PATCH v5 14/21] mm: swap: decouple virtual swap slot from backing store
Date: Fri, 20 Mar 2026 12:27:28 -0700
Message-ID: <20260320192735.748051-15-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14960-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.890];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADABA2E0096
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch presents the first real use case of the new virtual swap
design. It leverages the virtualization of the swap space to decouple a
swap entry and its backing storage. A swap entry can now be backed by
one of the following options:

1. A physical swap slot (i.e on a physical swapfile/swap partition).
2. A "zero swap page", i.e the swapped out page is a zero page.
3. A compressed object in the zswap pool.
4. An in-memory page. This can happen when a page is loaded
   (exclusively) from the zswap pool, or if the page is rejected by
   zswap and zswap writeback is disabled.

This allows us to use zswap and the zero swap page optimization, without
having to reserved a slot on a swapfile, or a swapfile at all. This
translates to tens to hundreds of GBs of disk saving on hosts and
workloads that have high memory usage, as well as removes this spurious
limit on the usage of these optimizations.

One implication of this change is that we need to be much more careful
with THP swapin and batched swap free operations. The central
requirement is the range of entries we are working with must
have no mixed backing states:

1. For now, zswap-backed entries are not supported for these batched
   operations.
2. All the entries must be backed by the same type.
3. If the swap entries in the batch are backed by in-memory folio, it
   must be the same folio (i.e they correspond to the subpages of that
   folio).
4. If the swap entries in the batch are backed by slots on swapfiles, it
   must be the same swapfile, and these physical swap slots must also be
   contiguous.

For now, we still charge virtual swap slots towards the memcg's swap
usage. In a following patch, we will change this behavior and only
charge physical (i.e on swapfile) swap slots towards the memcg's swap
usage.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h  |  31 ++-
 include/linux/zswap.h |   3 +-
 mm/internal.h         |  30 +--
 mm/madvise.c          |   2 +-
 mm/memcontrol.c       |  65 +++--
 mm/memory.c           |  92 +++++--
 mm/page_io.c          |  74 ++----
 mm/shmem.c            |   6 +-
 mm/swap.h             |  32 +--
 mm/swap_state.c       |  29 ++-
 mm/swapfile.c         |   8 -
 mm/vmscan.c           |  19 +-
 mm/vswap.c            | 562 +++++++++++++++++++++++++++++++++---------
 mm/zswap.c            |  45 ++--
 14 files changed, 679 insertions(+), 319 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 17218fe917fc3..fa73696733744 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -422,7 +422,13 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
 bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si);
 void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si);
-
+bool vswap_swapfile_backed(swp_entry_t entry, int nr);
+bool vswap_folio_backed(swp_entry_t entry, int nr);
+void vswap_store_folio(swp_entry_t entry, struct folio *folio);
+void swap_zeromap_folio_set(struct folio *folio);
+void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry);
+bool vswap_can_swapin_thp(swp_entry_t entry, int nr);
+bool vswap_alloc_swap_slot(struct folio *folio);
 
 /* Lifecycle swap API (mm/swapfile.c and mm/vswap.c) */
 int folio_alloc_swap(struct folio *folio);
@@ -482,6 +488,14 @@ unsigned int count_swap_pages(int, int);
 sector_t swapdev_block(int, pgoff_t);
 struct backing_dev_info;
 struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot);
+
+static inline struct swap_info_struct *vswap_get_device(swp_entry_t entry)
+{
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+
+	return slot.val ? swap_slot_tryget_swap_info(slot) : NULL;
+}
+
 sector_t swap_folio_sector(struct folio *folio);
 
 static inline void swap_slot_put_swap_info(struct swap_info_struct *si)
@@ -601,6 +615,21 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 	return -EINVAL;
 }
 
+static inline bool vswap_swapfile_backed(swp_entry_t entry, int nr)
+{
+	return false;
+}
+
+static inline bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
+{
+	return false;
+}
+
+static inline struct swap_info_struct *vswap_get_device(swp_entry_t entry)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_SWAP */
 
 static inline void free_swap_and_cache(swp_entry_t entry)
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 07b2936c38f29..f33b4433a5ee8 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -33,9 +33,8 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
 bool zswap_never_enabled(void);
-void *zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry);
+void zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry);
 void *zswap_entry_load(swp_entry_t swpentry);
-void *zswap_entry_erase(swp_entry_t swpentry);
 bool zswap_empty(swp_entry_t swpentry);
 void zswap_entry_free(struct zswap_entry *entry);
 
diff --git a/mm/internal.h b/mm/internal.h
index 7ced0def684ca..df991f601702c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -327,20 +327,6 @@ static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
 	return (swp_entry_t) { entry.val + n };
 }
 
-/* similar to swap_nth, but check the backing physical slots as well. */
-static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry), next_slot;
-	swp_entry_t next_entry = swap_nth(entry, delta);
-
-	next_slot = swp_entry_to_swp_slot(next_entry);
-	if (swp_slot_type(slot) != swp_slot_type(next_slot) ||
-			swp_slot_offset(slot) + delta != swp_slot_offset(next_slot))
-		next_entry.val = 0;
-
-	return next_entry;
-}
-
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
  *	 forward or backward by delta
@@ -354,7 +340,7 @@ static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
 static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
 	softleaf_t entry = softleaf_from_pte(pte);
-	pte_t new = swp_entry_to_pte(swap_move(entry, delta));
+	pte_t new = swp_entry_to_pte(swap_nth(entry, delta));
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
@@ -384,6 +370,7 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  * @start_ptep: Page table pointer for the first entry.
  * @max_nr: The maximum number of table entries to consider.
  * @pte: Page table entry for the first entry.
+ * @free_batch: Whether the batch will be passed to free_swap_and_cache_nr().
  *
  * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
  * containing swap entries all with consecutive offsets and targeting the same
@@ -394,13 +381,15 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  *
  * Return: the number of table entries in the batch.
  */
-static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
+static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte,
+				 bool free_batch)
 {
 	pte_t expected_pte = pte_next_swp_offset(pte);
 	const pte_t *end_ptep = start_ptep + max_nr;
 	const softleaf_t entry = softleaf_from_pte(pte);
 	pte_t *ptep = start_ptep + 1;
 	unsigned short cgroup_id;
+	int nr;
 
 	VM_WARN_ON(max_nr < 1);
 	VM_WARN_ON(!softleaf_is_swap(entry));
@@ -420,7 +409,14 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 		ptep++;
 	}
 
-	return ptep - start_ptep;
+	nr = ptep - start_ptep;
+	/*
+	 * free_swap_and_cache_nr can handle mixed backends, as long as virtual
+	 * swap entries backing these PTEs are contiguous.
+	 */
+	if (!free_batch && !vswap_can_swapin_thp(entry, nr))
+		return 1;
+	return nr;
 }
 #endif /* CONFIG_MMU */
 
diff --git a/mm/madvise.c b/mm/madvise.c
index b617b1be0f535..441da03c5d2b9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -692,7 +692,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 
 			if (softleaf_is_swap(entry)) {
 				max_nr = (end - addr) / PAGE_SIZE;
-				nr = swap_pte_batch(pte, max_nr, ptent);
+				nr = swap_pte_batch(pte, max_nr, ptent, true);
 				nr_swap -= nr;
 				free_swap_and_cache_nr(entry, nr);
 				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 86f43b7e5f710..2ba5811e7edba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5247,10 +5247,18 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	rcu_read_unlock();
 }
 
+static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg);
+
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages = get_nr_swap_pages();
+	long nr_swap_pages, nr_zswap_pages = 0;
+
+	if (zswap_is_enabled() && (mem_cgroup_disabled() || do_memsw_account() ||
+				mem_cgroup_may_zswap(memcg))) {
+		nr_zswap_pages = PAGE_COUNTER_MAX;
+	}
 
+	nr_swap_pages = max_t(long, nr_zswap_pages, get_nr_swap_pages());
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
@@ -5419,6 +5427,29 @@ static struct cftype swap_files[] = {
 };
 
 #ifdef CONFIG_ZSWAP
+static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg)
+{
+	struct mem_cgroup *memcg;
+
+	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
+	     memcg = parent_mem_cgroup(memcg)) {
+		unsigned long max = READ_ONCE(memcg->zswap_max);
+		unsigned long pages;
+
+		if (max == PAGE_COUNTER_MAX)
+			continue;
+		if (max == 0)
+			return false;
+
+		/* Force flush to get accurate stats for charging */
+		__mem_cgroup_flush_stats(memcg, true);
+		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
+		if (pages >= max)
+			return false;
+	}
+	return true;
+}
+
 /**
  * obj_cgroup_may_zswap - check if this cgroup can zswap
  * @objcg: the object cgroup
@@ -5433,34 +5464,15 @@ static struct cftype swap_files[] = {
  */
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
-	struct mem_cgroup *memcg, *original_memcg;
+	struct mem_cgroup *memcg;
 	bool ret = true;
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return true;
 
-	original_memcg = get_mem_cgroup_from_objcg(objcg);
-	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
-	     memcg = parent_mem_cgroup(memcg)) {
-		unsigned long max = READ_ONCE(memcg->zswap_max);
-		unsigned long pages;
-
-		if (max == PAGE_COUNTER_MAX)
-			continue;
-		if (max == 0) {
-			ret = false;
-			break;
-		}
-
-		/* Force flush to get accurate stats for charging */
-		__mem_cgroup_flush_stats(memcg, true);
-		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
-		if (pages < max)
-			continue;
-		ret = false;
-		break;
-	}
-	mem_cgroup_put(original_memcg);
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	ret = mem_cgroup_may_zswap(memcg);
+	mem_cgroup_put(memcg);
 	return ret;
 }
 
@@ -5604,6 +5616,11 @@ static struct cftype zswap_files[] = {
 	},
 	{ }	/* terminate */
 };
+#else
+static inline bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg)
+{
+	return false;
+}
 #endif /* CONFIG_ZSWAP */
 
 static int __init mem_cgroup_swap_init(void)
diff --git a/mm/memory.c b/mm/memory.c
index 641e3f65edc00..5a8d7fe5f1c93 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1742,7 +1742,7 @@ static inline int zap_nonpresent_ptes(struct mmu_gather *tlb,
 		if (!should_zap_cows(details))
 			return 1;
 
-		nr = swap_pte_batch(pte, max_nr, ptent);
+		nr = swap_pte_batch(pte, max_nr, ptent, true);
 		rss[MM_SWAPENTS] -= nr;
 		free_swap_and_cache_nr(entry, nr);
 	} else if (softleaf_is_migration(entry)) {
@@ -4362,6 +4362,15 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	if (mem_cgroup_swap_full(folio) || (vma->vm_flags & VM_LOCKED) ||
 	    folio_test_mlocked(folio))
 		return true;
+
+	/*
+	 * Non-swapfile backends cannot be re-used for future swapouts anyway.
+	 * Try to free swap space unless the folio is backed by contiguous
+	 * physical swap slots.
+	 */
+	if (!vswap_swapfile_backed(folio->swap, folio_nr_pages(folio)))
+		return true;
+
 	/*
 	 * If we want to map a page that's in the swapcache writable, we
 	 * have to detect via the refcount if we're really the exclusive
@@ -4482,7 +4491,7 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
 		return false;
 	entry = softleaf_from_pte(pte);
-	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
+	if (swap_pte_batch(ptep, nr_pages, pte, false) != nr_pages)
 		return false;
 
 	/*
@@ -4623,12 +4632,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct folio *swapcache, *folio = NULL;
 	DECLARE_WAITQUEUE(wait, current);
 	struct page *page;
-	struct swap_info_struct *si = NULL;
+	struct swap_info_struct *si = NULL, *stable_si;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool need_clear_cache = false;
 	bool swapoff_locked = false;
 	bool exclusive = false;
-	softleaf_t entry;
+	softleaf_t orig_entry, entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
@@ -4641,6 +4650,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 
 	entry = softleaf_from_pte(vmf->orig_pte);
+	/*
+	 * entry might change if we get a large folio - remember the original entry
+	 * for unlocking swapoff etc.
+	 */
+	orig_entry = entry;
 	if (unlikely(!softleaf_is_swap(entry))) {
 		if (softleaf_is_migration(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
@@ -4705,7 +4719,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = folio;
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
+		if (si && data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
 			folio = alloc_swap_folio(vmf);
@@ -4736,6 +4750,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				}
 				need_clear_cache = true;
 
+				/*
+				 * Recheck to make sure the entire range is still
+				 * THP-swapin-able. Note that before we call
+				 * swapcache_prepare(), entries in the range can
+				 * still have their backing status changed.
+				 */
+				if (!vswap_can_swapin_thp(entry, nr_pages)) {
+					schedule_timeout_uninterruptible(1);
+					goto out_page;
+				}
+
 				memcg1_swapin(entry, nr_pages);
 
 				shadow = swap_cache_get_shadow(entry);
@@ -4852,7 +4877,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte_t folio_pte = ptep_get(folio_ptep);
 
 		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
-		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
+		    swap_pte_batch(folio_ptep, nr, folio_pte, false) != nr)
 			goto out_nomap;
 
 		page_idx = idx;
@@ -4881,7 +4906,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_ptep = vmf->pte - idx;
 		folio_pte = ptep_get(folio_ptep);
 		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
-		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
+		    swap_pte_batch(folio_ptep, nr, folio_pte, false) != nr)
 			goto check_folio;
 
 		page_idx = idx;
@@ -4916,27 +4941,40 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 * swapcache -> certainly exclusive.
 			 */
 			exclusive = true;
-		} else if (exclusive && folio_test_writeback(folio) &&
-			  data_race(si->flags & SWP_STABLE_WRITES)) {
+		} else if (exclusive && folio_test_writeback(folio)) {
 			/*
-			 * This is tricky: not all swap backends support
-			 * concurrent page modifications while under writeback.
-			 *
-			 * So if we stumble over such a page in the swapcache
-			 * we must not set the page exclusive, otherwise we can
-			 * map it writable without further checks and modify it
-			 * while still under writeback.
+			 * We need to look up the swap device again here, because
+			 * the si we got from tryget_swap_entry() might have changed
+			 * before we pin the backend.
 			 *
-			 * For these problematic swap backends, simply drop the
-			 * exclusive marker: this is perfectly fine as we start
-			 * writeback only if we fully unmapped the page and
-			 * there are no unexpected references on the page after
-			 * unmapping succeeded. After fully unmapped, no
-			 * further GUP references (FOLL_GET and FOLL_PIN) can
-			 * appear, so dropping the exclusive marker and mapping
-			 * it only R/O is fine.
+			 * With the folio locked and loaded into the swap cache, we can
+			 * now guarantee a stable backing state.
 			 */
-			exclusive = false;
+			stable_si = vswap_get_device(entry);
+			if (stable_si && data_race(stable_si->flags & SWP_STABLE_WRITES)) {
+				/*
+				 * This is tricky: not all swap backends support
+				 * concurrent page modifications while under writeback.
+				 *
+				 * So if we stumble over such a page in the swapcache
+				 * we must not set the page exclusive, otherwise we can
+				 * map it writable without further checks and modify it
+				 * while still under writeback.
+				 *
+				 * For these problematic swap backends, simply drop the
+				 * exclusive marker: this is perfectly fine as we start
+				 * writeback only if we fully unmapped the page and
+				 * there are no unexpected references on the page after
+				 * unmapping succeeded. After fully unmapped, no
+				 * further GUP references (FOLL_GET and FOLL_PIN) can
+				 * appear, so dropping the exclusive marker and mapping
+				 * it only R/O is fine.
+				 */
+				exclusive = false;
+			}
+
+			if (stable_si)
+				swap_slot_put_swap_info(stable_si);
 		}
 	}
 
@@ -5045,7 +5083,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			wake_up(&swapcache_wq);
 	}
 	if (swapoff_locked)
-		put_swap_entry(entry, si);
+		put_swap_entry(orig_entry, si);
 	return ret;
 out_nomap:
 	if (vmf->pte)
@@ -5064,7 +5102,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			wake_up(&swapcache_wq);
 	}
 	if (swapoff_locked)
-		put_swap_entry(entry, si);
+		put_swap_entry(orig_entry, si);
 	return ret;
 }
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 5de3705572955..675ec6445609b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -201,44 +201,6 @@ static bool is_folio_zero_filled(struct folio *folio)
 	return true;
 }
 
-static void swap_zeromap_folio_set(struct folio *folio)
-{
-	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
-	struct swap_info_struct *sis =
-		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
-	int nr_pages = folio_nr_pages(folio);
-	swp_entry_t entry;
-	swp_slot_t slot;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		slot = swp_entry_to_swp_slot(entry);
-		set_bit(swp_slot_offset(slot), sis->zeromap);
-	}
-
-	count_vm_events(SWPOUT_ZERO, nr_pages);
-	if (objcg) {
-		count_objcg_events(objcg, SWPOUT_ZERO, nr_pages);
-		obj_cgroup_put(objcg);
-	}
-}
-
-static void swap_zeromap_folio_clear(struct folio *folio)
-{
-	struct swap_info_struct *sis =
-		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
-	swp_entry_t entry;
-	swp_slot_t slot;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		slot = swp_entry_to_swp_slot(entry);
-		clear_bit(swp_slot_offset(slot), sis->zeromap);
-	}
-}
-
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -260,23 +222,22 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 		goto out_unlock;
 	}
 
-	/*
-	 * Use a bitmap (zeromap) to avoid doing IO for zero-filled pages.
-	 * The bits in zeromap are protected by the locked swapcache folio
-	 * and atomic updates are used to protect against read-modify-write
-	 * corruption due to other zero swap entries seeing concurrent updates.
-	 */
 	if (is_folio_zero_filled(folio)) {
 		swap_zeromap_folio_set(folio);
 		goto out_unlock;
 	}
 
 	/*
-	 * Clear bits this folio occupies in the zeromap to prevent zero data
-	 * being read in from any previous zero writes that occupied the same
-	 * swap entries.
+	 * Release swap backends to make sure we do not have mixed backends
+	 *
+	 * The only exception is if the folio is already backed by a
+	 * contiguous range of physical swap slots (for e.g, from a previous
+	 * swapout attempt when zswap is disabled).
+	 *
+	 * Keep that backend to avoid reallocation of physical swap slots.
 	 */
-	swap_zeromap_folio_clear(folio);
+	if (!vswap_swapfile_backed(folio->swap, folio_nr_pages(folio)))
+		vswap_store_folio(folio->swap, folio);
 
 	if (zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
@@ -287,6 +248,12 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 		return AOP_WRITEPAGE_ACTIVATE;
 	}
 
+	/* fall back to physical swap device */
+	if (!vswap_alloc_swap_slot(folio)) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	__swap_writepage(folio, swap_plug);
 	return 0;
 out_unlock:
@@ -618,14 +585,11 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 
 void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis =
-		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
-	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
-	bool workingset = folio_test_workingset(folio);
+	struct swap_info_struct *sis;
+	bool synchronous, workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
 
-	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
 
@@ -651,6 +615,10 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
 
+	sis = __swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
+	synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
+	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
+
 	if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
 	} else if (synchronous) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 780571c830e5b..3a346cca114ab 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1459,7 +1459,7 @@ static unsigned int shmem_find_swap_entries(struct address_space *mapping,
 		 * swapin error entries can be found in the mapping. But they're
 		 * deliberately ignored here as we've done everything we can do.
 		 */
-		if (swp_slot_type(slot) != type)
+		if (!slot.val || swp_slot_type(slot) != type)
 			continue;
 
 		indices[folio_batch_count(fbatch)] = xas.xa_index;
@@ -1604,7 +1604,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 	if ((info->flags & SHMEM_F_LOCKED) || sbinfo->noswap)
 		goto redirty;
 
-	if (!total_swap_pages)
+	if (!zswap_is_enabled() && !total_swap_pages)
 		goto redirty;
 
 	/*
@@ -2341,7 +2341,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap);
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+		if (si && data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			/* Direct swapin skipping swap cache & readahead */
 			folio = shmem_swap_alloc_folio(inode, vma, index,
 						       index_entry, order, gfp);
diff --git a/mm/swap.h b/mm/swap.h
index 4109b1caa59a6..d7981ec82cf49 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -311,35 +311,15 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	swp_slot_t swp_slot = swp_entry_to_swp_slot(folio->swap);
 
+	/* The folio might not be backed by any physical swap slots
+	 * (for e.g zswap-backed only).
+	 */
+	if (!swp_slot.val)
+		return 0;
 	return __swap_slot_to_info(swp_slot)->flags;
 }
 
-/*
- * Return the count of contiguous swap entries that share the same
- * zeromap status as the starting entry. If is_zeromap is not NULL,
- * it will return the zeromap status of the starting entry.
- */
-static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
-		bool *is_zeromap)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *sis = __swap_slot_to_info(slot);
-	unsigned long start = swp_slot_offset(slot);
-	unsigned long end = start + max_nr;
-	bool first_bit;
-
-	first_bit = test_bit(start, sis->zeromap);
-	if (is_zeromap)
-		*is_zeromap = first_bit;
-
-	if (max_nr <= 1)
-		return max_nr;
-	if (first_bit)
-		return find_next_zero_bit(sis->zeromap, end, start) - start;
-	else
-		return find_next_bit(sis->zeromap, end, start) - start;
-}
-
+int swap_zeromap_batch(swp_entry_t entry, int max_nr, bool *is_zeromap);
 int non_swapcache_batch(swp_entry_t entry, int max_nr);
 
 #else /* CONFIG_SWAP */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1827527e88d33..ad80bf098b63f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -179,6 +179,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	struct folio *result = NULL;
 	void *shadow = NULL;
 
+	/* we might get an unsed entry from cluster readahead - just skip */
+	if (!entry.val)
+		return NULL;
+
 	*new_page_allocated = false;
 	for (;;) {
 		int err;
@@ -213,8 +217,20 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * Swap entry may have been freed since our caller observed it.
 		 */
 		err = swapcache_prepare(entry, 1);
-		if (!err)
+		if (!err) {
+			/* This might be invoked by swap_cluster_readahead(), which can
+			 * race with shmem_swapin_folio(). The latter might have already
+			 * called swap_cache_del_folio(), allowing swapcache_prepare()
+			 * to succeed here. This can lead to reading bogus data to populate
+			 * the page. To prevent this, skip folio-backed virtual swap slots,
+			 * and let caller retry if necessary.
+			 */
+			if (vswap_folio_backed(entry, 1)) {
+				swapcache_clear(entry, 1);
+				goto put_and_return;
+			}
 			break;
+		}
 		else if (err != -EEXIST)
 			goto put_and_return;
 
@@ -391,11 +407,18 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	unsigned long offset = slot_offset;
 	unsigned long start_offset, end_offset;
 	unsigned long mask;
-	struct swap_info_struct *si = __swap_slot_to_info(slot);
+	struct swap_info_struct *si = swap_slot_tryget_swap_info(slot);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
 	bool page_allocated;
 
+	/*
+	 * The swap entry might not be backed by any physical swap slot. In that
+	 * case, just skip readahead and bring in the target entry.
+	 */
+	if (!si)
+		goto skip;
+
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
@@ -429,6 +452,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	swap_read_unplug(splug);
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
+	if (si)
+		swap_slot_put_swap_info(si);
 	/* The page was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ab1ae81b4e0cc..32aa080d96a4d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1210,14 +1210,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 {
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
-	unsigned int i;
-
-	/*
-	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
-	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
-	 */
-	for (i = 0; i < nr_entries; i++)
-		clear_bit(offset + i, si->zeromap);
 
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c9ec1a1458b4e..6b200a6bb1160 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -365,10 +365,11 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 {
 	if (memcg == NULL) {
 		/*
-		 * For non-memcg reclaim, is there
-		 * space in any swap device?
+		 * For non-memcg reclaim:
+		 *
+		 * Check if zswap is enabled or if there is space in any swap device?
 		 */
-		if (get_nr_swap_pages() > 0)
+		if (zswap_is_enabled() || get_nr_swap_pages() > 0)
 			return true;
 	} else {
 		/* Is the memcg below its swap limit? */
@@ -2640,12 +2641,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 static bool can_age_anon_pages(struct lruvec *lruvec,
 			       struct scan_control *sc)
 {
-	/* Aging the anon LRU is valuable if swap is present: */
-	if (total_swap_pages > 0)
-		return true;
-
-	/* Also valuable if anon pages can be demoted: */
-	return can_demote(lruvec_pgdat(lruvec)->node_id, sc,
+	/*
+	 * Aging the anon LRU is valuable if zswap or physical swap is available or
+	 * anon pages can be demoted
+	 */
+	return zswap_is_enabled() || total_swap_pages > 0 ||
+			can_demote(lruvec_pgdat(lruvec)->node_id, sc,
 			  lruvec_memcg(lruvec));
 }
 
diff --git a/mm/vswap.c b/mm/vswap.c
index e9db168939dce..861a504c9fbfd 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -11,6 +11,7 @@
 #include <linux/swap_cgroup.h>
 #include <linux/cpuhotplug.h>
 #include <linux/zswap.h>
+#include "internal.h"
 #include "swap.h"
 #include "swap_table.h"
 
@@ -54,22 +55,48 @@
  *
  * Note that we do not have a reference count field per se - it is derived from
  * the swap_count and the in_swapcache fields.
+ *
+ * III. Backing State
+ *
+ * Each virtual swap slot can be backed by:
+ *
+ * 1. A slot on a physical swap device (i.e a swapfile or a swap partition).
+ * 2. A swapped out zero-filled page.
+ * 3. A compressed object in zswap.
+ * 4. An in-memory folio, that is not backed by neither a physical swap device
+ *    nor zswap (i.e only in swap cache). This is used for pages that are
+ *    rejected by zswap, but not (yet) backed by a physical swap device,
+ *    (for e.g, due to zswap.writeback = 0), or for pages that were previously
+ *    stored in zswap, but has since been loaded back into memory (and has its
+ *    zswap copy invalidated).
  */
 
+/* The backing state options of a virtual swap slot */
+enum swap_type {
+	VSWAP_SWAPFILE,
+	VSWAP_ZERO,
+	VSWAP_ZSWAP,
+	VSWAP_FOLIO
+};
+
 /**
  * Swap descriptor - metadata of a swapped out page.
  *
  * @slot: The handle to the physical swap slot backing this page.
  * @zswap_entry: The zswap entry associated with this swap slot.
- * @swap_cache: The folio in swap cache.
+ * @swap_cache: The folio in swap cache. If the swap entry backing type is
+ *              VSWAP_FOLIO, the backend is also stored here.
  * @shadow: The shadow entry.
- * @memcgid: The memcg id of the owning memcg, if any.
  * @swap_count: The number of page table entries that refer to the swap entry.
+ * @memcgid: The memcg id of the owning memcg, if any.
  * @in_swapcache: Whether the swap entry is (about to be) pinned in swap cache.
+ * @type: The backing store type of the swap entry.
  */
 struct swp_desc {
-	swp_slot_t slot;
-	struct zswap_entry *zswap_entry;
+	union {
+		swp_slot_t slot;
+		struct zswap_entry *zswap_entry;
+	};
 	union {
 		struct folio *swap_cache;
 		void *shadow;
@@ -78,10 +105,10 @@ struct swp_desc {
 	unsigned int swap_count;
 
 #ifdef CONFIG_MEMCG
-	unsigned short memcgid;
+	unsigned short memcgid:16;
 #endif
-
-	bool in_swapcache;
+	bool in_swapcache:1;
+	enum swap_type type:2;
 };
 
 #define VSWAP_CLUSTER_SHIFT HPAGE_PMD_ORDER
@@ -266,15 +293,16 @@ static bool cluster_is_alloc_candidate(struct vswap_cluster *cluster)
 	return cluster->count + (1 << (cluster->order)) <= VSWAP_CLUSTER_SIZE;
 }
 
-static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start)
+static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster,
+		int start, struct folio *folio)
 {
 	int i, nr = 1 << cluster->order;
 	struct swp_desc *desc;
 
 	for (i = 0; i < nr; i++) {
 		desc = &cluster->descriptors[start + i];
-		desc->slot.val = 0;
-		desc->zswap_entry = NULL;
+		desc->type = VSWAP_FOLIO;
+		desc->swap_cache = folio;
 #ifdef CONFIG_MEMCG
 		desc->memcgid = 0;
 #endif
@@ -284,7 +312,8 @@ static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start)
 	cluster->count += nr;
 }
 
-static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster)
+static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster,
+		struct folio *folio)
 {
 	int nr = 1 << cluster->order;
 	unsigned long i = cluster->id ? 0 : nr;
@@ -303,16 +332,16 @@ static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster)
 	bitmap_set(cluster->bitmap, i, nr);
 
 	refcount_add(nr, &cluster->refcnt);
-	__vswap_alloc_from_cluster(cluster, i);
+	__vswap_alloc_from_cluster(cluster, i, folio);
 	return i + (cluster->id << VSWAP_CLUSTER_SHIFT);
 }
 
 /* Allocate a contiguous range of virtual swap slots */
-static swp_entry_t vswap_alloc(int order)
+static swp_entry_t vswap_alloc(struct folio *folio)
 {
 	struct xa_limit limit = vswap_cluster_map_limit;
 	struct vswap_cluster *local, *cluster;
-	int nr = 1 << order;
+	int order = folio_order(folio), nr = 1 << order;
 	bool need_caching = true;
 	u32 cluster_id;
 	swp_entry_t entry;
@@ -325,7 +354,7 @@ static swp_entry_t vswap_alloc(int order)
 	cluster = this_cpu_read(percpu_vswap_cluster.clusters[order]);
 	if (cluster) {
 		spin_lock(&cluster->lock);
-		entry.val = vswap_alloc_from_cluster(cluster);
+		entry.val = vswap_alloc_from_cluster(cluster, folio);
 		need_caching = !entry.val;
 
 		if (!entry.val || !cluster_is_alloc_candidate(cluster)) {
@@ -352,7 +381,7 @@ static swp_entry_t vswap_alloc(int order)
 			if (!spin_trylock(&cluster->lock))
 				continue;
 
-			entry.val = vswap_alloc_from_cluster(cluster);
+			entry.val = vswap_alloc_from_cluster(cluster, folio);
 			list_del_init(&cluster->list);
 			cluster->full = !entry.val || !cluster_is_alloc_candidate(cluster);
 			need_caching = !cluster->full;
@@ -384,7 +413,7 @@ static swp_entry_t vswap_alloc(int order)
 				if (!cluster_id)
 					entry.val += nr;
 				__vswap_alloc_from_cluster(cluster,
-					(entry.val & VSWAP_CLUSTER_MASK));
+					(entry.val & VSWAP_CLUSTER_MASK), folio);
 				/* Mark the allocated range in the bitmap */
 				bitmap_set(cluster->bitmap, (entry.val & VSWAP_CLUSTER_MASK), nr);
 				need_caching = cluster_is_alloc_candidate(cluster);
@@ -498,6 +527,84 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 		__swap_table_set(ci, ci_off + i, vswap ? vswap + i : 0);
 }
 
+/*
+ * Caller needs to handle races with other operations themselves.
+ *
+ * Specifically, this function is safe to be called in contexts where the swap
+ * entry has been added to the swap cache and the associated folio is locked.
+ * We cannot race with other accessors, and the swap entry is guaranteed to be
+ * valid the whole time (since swap cache implies one refcount).
+ *
+ * We cannot assume that the backends will be of the same type,
+ * contiguous, etc. We might have a large folio coalesced from subpages with
+ * mixed backend, which is only rectified when it is reclaimed.
+ */
+static void release_backing(swp_entry_t entry, int nr)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
+	unsigned int phys_swap_type = 0;
+	bool need_flushing_phys_swap = false;
+	swp_slot_t flush_slot;
+	int i;
+
+	VM_WARN_ON(!entry.val);
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+
+		/*
+		 * We batch contiguous physical swap slots for more efficient
+		 * freeing.
+		 */
+		if (phys_swap_start != phys_swap_end &&
+				(desc->type != VSWAP_SWAPFILE ||
+					swp_slot_type(desc->slot) != phys_swap_type ||
+					swp_slot_offset(desc->slot) != phys_swap_end)) {
+			need_flushing_phys_swap = true;
+			flush_slot = swp_slot(phys_swap_type, phys_swap_start);
+			flush_nr = phys_swap_end - phys_swap_start;
+			phys_swap_start = phys_swap_end = 0;
+		}
+
+		if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
+			zswap_entry_free(desc->zswap_entry);
+		} else if (desc->type == VSWAP_SWAPFILE) {
+			if (!phys_swap_start) {
+				/* start a new contiguous range of phys swap */
+				phys_swap_start = swp_slot_offset(desc->slot);
+				phys_swap_end = phys_swap_start + 1;
+				phys_swap_type = swp_slot_type(desc->slot);
+			} else {
+				/* extend the current contiguous range of phys swap */
+				phys_swap_end++;
+			}
+		}
+
+		desc->slot.val = 0;
+
+		if (need_flushing_phys_swap) {
+			spin_unlock(&cluster->lock);
+			cluster = NULL;
+			swap_slot_free_nr(flush_slot, flush_nr);
+			need_flushing_phys_swap = false;
+		}
+	}
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	/* Flush any remaining physical swap range */
+	if (phys_swap_start) {
+		flush_slot = swp_slot(phys_swap_type, phys_swap_start);
+		flush_nr = phys_swap_end - phys_swap_start;
+		swap_slot_free_nr(flush_slot, flush_nr);
+	}
+}
+
 /*
  * Entered with the cluster locked, but might unlock the cluster.
  * This is because several operations, such as releasing physical swap slots
@@ -517,35 +624,21 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 	swp_entry_t entry)
 {
-	struct zswap_entry *zswap_entry;
-	swp_slot_t slot;
-
 	/* Clear shadow if present */
 	if (xa_is_value(desc->shadow))
 		desc->shadow = NULL;
-
-	slot = desc->slot;
-	desc->slot.val = 0;
-
-	zswap_entry = desc->zswap_entry;
-	if (zswap_entry) {
-		desc->zswap_entry = NULL;
-		zswap_entry_free(zswap_entry);
-	}
 	spin_unlock(&cluster->lock);
 
+	release_backing(entry, 1);
 	mem_cgroup_uncharge_swap(entry, 1);
 
-	if (slot.val)
-		swap_slot_free_nr(slot, 1);
-
-	spin_lock(&cluster->lock);
 	/* erase forward mapping and release the virtual slot for reallocation */
+	spin_lock(&cluster->lock);
 	release_vswap_slot(cluster, entry.val);
 }
 
 /**
- * folio_alloc_swap - allocate swap space for a folio.
+ * folio_alloc_swap - allocate virtual swap space for a folio.
  * @folio: the folio.
  *
  * Return: 0, if the allocation succeeded, -ENOMEM, if the allocation failed.
@@ -553,43 +646,78 @@ static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 int folio_alloc_swap(struct folio *folio)
 {
 	struct vswap_cluster *cluster = NULL;
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	int i, ret, nr = folio_nr_pages(folio), order = folio_order(folio);
+	int i, nr = folio_nr_pages(folio);
 	struct swp_desc *desc;
 	swp_entry_t entry;
-	swp_slot_t slot = { 0 };
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
 
-	entry = vswap_alloc(folio_order(folio));
+	entry = vswap_alloc(folio);
 	if (!entry.val)
 		return -ENOMEM;
 
 	/*
-	 * XXX: for now, we always allocate a physical swap slot for each virtual
-	 * swap slot, and their lifetime are coupled. This will change once we
-	 * decouple virtual swap slots from their backing states, and only allocate
-	 * physical swap slots for them on demand (i.e on zswap writeback, or
-	 * fallback from zswap store failure).
+	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
+	 * swap slots allocation. This will be changed soon - we will only charge on
+	 * physical swap slots allocation.
 	 */
-	ret = swap_slot_alloc(&slot, order);
-	if (ret || !slot.val) {
-		/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
-		mem_cgroup_try_charge_swap(folio, (swp_entry_t){0});
-
+	if (mem_cgroup_try_charge_swap(folio, entry)) {
+		rcu_read_lock();
 		for (i = 0; i < nr; i++) {
 			desc = vswap_iter(&cluster, entry.val + i);
 			VM_WARN_ON(!desc);
 			vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
 		}
 		spin_unlock(&cluster->lock);
-
-		return ret ? ret : -ENOMEM;
+		rcu_read_unlock();
+		atomic_add(nr, &vswap_alloc_reject);
+		entry.val = 0;
+		return -ENOMEM;
 	}
 
-	/* establish the virtual <-> physical swap slots linkages. */
+	swap_cache_add_folio(folio, entry, NULL);
+
+	return 0;
+}
+
+/**
+ * vswap_alloc_swap_slot - allocate physical swap space for a folio that is
+ *                         already associated with virtual swap slots.
+ * @folio: folio we want to allocate physical swap space for.
+ *
+ * Note that this does NOT release existing swap backends of the folio.
+ * Callers need to handle this themselves.
+
+ * Return: true if the folio is now backed by physical swap slots, false
+ * otherwise.
+ */
+bool vswap_alloc_swap_slot(struct folio *folio)
+{
+	int i, nr = folio_nr_pages(folio);
+	struct vswap_cluster *cluster = NULL;
+	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	swp_slot_t slot = { .val = 0 };
+	swp_entry_t entry = folio->swap;
+	struct swp_desc *desc;
+	bool fallback = false;
+
+	/*
+	 * We might have already allocated a backing physical swap slot in past
+	 * attempts (for instance, when we disable zswap). If the entire range is
+	 * already swapfile-backed we can skip swapfile case.
+	 */
+	if (vswap_swapfile_backed(entry, nr))
+		return true;
+
+	if (swap_slot_alloc(&slot, folio_order(folio)))
+		return false;
+
+	if (!slot.val)
+		return false;
+
+	/* establish the vrtual <-> physical swap slots linkages. */
 	si = __swap_slot_to_info(slot);
 	ci = swap_cluster_lock(si, swp_slot_offset(slot));
 	vswap_rmap_set(ci, slot, entry.val, nr);
@@ -600,29 +728,26 @@ int folio_alloc_swap(struct folio *folio)
 		desc = vswap_iter(&cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 
+		if (desc->type == VSWAP_FOLIO) {
+			/* case 1: fallback from zswap store failure */
+			fallback = true;
+			VM_WARN_ON(folio != desc->swap_cache);
+		} else {
+			/*
+			 * Case 2: zswap writeback.
+			 *
+			 * No need to free zswap entry here - it will be freed once zswap
+			 * writeback suceeds.
+			 */
+			VM_WARN_ON(desc->type != VSWAP_ZSWAP);
+			VM_WARN_ON(fallback);
+		}
+		desc->type = VSWAP_SWAPFILE;
 		desc->slot.val = slot.val + i;
 	}
-	if (cluster)
-		spin_unlock(&cluster->lock);
+	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
-
-	/*
-	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
-	 * swap slots allocation. This is acceptable because as noted above, each
-	 * virtual swap slot corresponds to a physical swap slot. Once we have
-	 * decoupled virtual and physical swap slots, we will only charge when we
-	 * actually allocate a physical swap slot.
-	 */
-	if (mem_cgroup_try_charge_swap(folio, entry))
-		goto out_free;
-
-	swap_cache_add_folio(folio, entry, NULL);
-
-	return 0;
-
-out_free:
-	put_swap_folio(folio, entry);
-	return -ENOMEM;
+	return true;
 }
 
 /**
@@ -630,7 +755,9 @@ int folio_alloc_swap(struct folio *folio)
  *                         virtual swap slot.
  * @entry: the virtual swap slot.
  *
- * Return: the physical swap slot corresponding to the virtual swap slot.
+ * Return: the physical swap slot corresponding to the virtual swap slot, if
+ * exists, or the zero physical swap slot if the virtual swap slot is not
+ * backed by any physical slot on a swapfile.
  */
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 {
@@ -649,7 +776,10 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 		return (swp_slot_t){0};
 	}
 
-	slot = desc->slot;
+	if (desc->type != VSWAP_SWAPFILE)
+		slot.val = 0;
+	else
+		slot = desc->slot;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
 
@@ -967,6 +1097,210 @@ int non_swapcache_batch(swp_entry_t entry, int max_nr)
 	return i;
 }
 
+/**
+ * vswap_store_folio - set a folio as the backing of a range of virtual swap
+ *                     slots.
+ * @entry: the first virtual swap slot in the range.
+ * @folio: the folio.
+ */
+void vswap_store_folio(swp_entry_t entry, struct folio *folio)
+{
+	struct vswap_cluster *cluster = NULL;
+	int i, nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+
+	VM_BUG_ON(!folio_test_locked(folio));
+	VM_BUG_ON(folio->swap.val != entry.val);
+
+	release_backing(entry, nr);
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+		desc->type = VSWAP_FOLIO;
+		desc->swap_cache = folio;
+	}
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+}
+
+/**
+ * swap_zeromap_folio_set - mark a range of virtual swap slots corresponding to
+ *                          a folio as zero-filled.
+ * @folio: the folio
+ */
+void swap_zeromap_folio_set(struct folio *folio)
+{
+	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
+	struct vswap_cluster *cluster = NULL;
+	swp_entry_t entry = folio->swap;
+	int i, nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+
+	VM_BUG_ON(!folio_test_locked(folio));
+	VM_BUG_ON(!entry.val);
+
+	release_backing(entry, nr);
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+		desc->type = VSWAP_ZERO;
+	}
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	count_vm_events(SWPOUT_ZERO, nr);
+	if (objcg) {
+		count_objcg_events(objcg, SWPOUT_ZERO, nr);
+		obj_cgroup_put(objcg);
+	}
+}
+
+/*
+ * Iterate through the entire range of virtual swap slots, returning the
+ * longest contiguous range of slots starting from the first slot that satisfies:
+ *
+ * 1. If the first slot is zero-mapped, the entire range should be
+ *    zero-mapped.
+ * 2. If the first slot is backed by a swapfile, the entire range should
+ *    be backed by a range of contiguous swap slots on the same swapfile.
+ * 3. If the first slot is zswap-backed, the entire range should be
+ *    zswap-backed.
+ * 4. If the first slot is backed by a folio, the entire range should
+ *    be backed by the same folio.
+ *
+ * Note that this check is racy unless we can ensure that the entire range
+ * has their backing state stable - for instance, if the caller was the one
+ * who set the swap cache pin.
+ */
+static int vswap_check_backing(swp_entry_t entry, enum swap_type *type, int nr)
+{
+	unsigned int swapfile_type;
+	struct vswap_cluster *cluster = NULL;
+	enum swap_type first_type;
+	struct swp_desc *desc;
+	pgoff_t first_offset;
+	struct folio *folio;
+	int i = 0;
+
+	if (!entry.val)
+		return 0;
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		if (!desc)
+			goto done;
+
+		if (!i) {
+			first_type = desc->type;
+			if (first_type == VSWAP_SWAPFILE) {
+				swapfile_type = swp_slot_type(desc->slot);
+				first_offset = swp_slot_offset(desc->slot);
+			} else if (first_type == VSWAP_FOLIO) {
+				folio = desc->swap_cache;
+			}
+		} else if (desc->type != first_type) {
+			goto done;
+		} else if (first_type == VSWAP_SWAPFILE &&
+				(swp_slot_type(desc->slot) != swapfile_type ||
+					swp_slot_offset(desc->slot) != first_offset + i)) {
+			goto done;
+		} else if (first_type == VSWAP_FOLIO && desc->swap_cache != folio) {
+			goto done;
+		}
+	}
+done:
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	if (type)
+		*type = first_type;
+	return i;
+}
+
+/**
+ * vswap_swapfile_backed - check if the virtual swap slots are backed by physical
+ *                         swap slots.
+ * @entry: the first entry in the range.
+ * @nr: the number of entries in the range.
+ */
+bool vswap_swapfile_backed(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr
+				&& type == VSWAP_SWAPFILE;
+}
+
+/**
+ * vswap_folio_backed - check if the virtual swap slots are backed by in-memory
+ *                      pages.
+ * @entry: the first virtual swap slot in the range.
+ * @nr: the number of slots in the range.
+ */
+bool vswap_folio_backed(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr && type == VSWAP_FOLIO;
+}
+
+/**
+ * vswap_can_swapin_thp - check if the swap entries can be swapped in as a THP.
+ * @entry: the first virtual swap slot in the range.
+ * @nr: the number of slots in the range.
+ *
+ * For now, we can only swap in a THP if the entire range is zero-filled, or if
+ * the entire range is backed by a contiguous range of physical swap slots on a
+ * swapfile.
+ */
+bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr &&
+		(type == VSWAP_ZERO || type == VSWAP_SWAPFILE);
+}
+
+/*
+ * Return the count of contiguous swap entries that share the same
+ * VSWAP_ZERO status as the starting entry. If is_zeromap is not NULL,
+ * it will return the VSWAP_ZERO status of the starting entry.
+ */
+int swap_zeromap_batch(swp_entry_t entry, int max_nr, bool *is_zeromap)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	int i = 0;
+	bool is_zero = false;
+
+	VM_WARN_ON(!entry.val);
+
+	rcu_read_lock();
+	for (i = 0; i < max_nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		if (!desc)
+			goto done;
+
+		if (!i)
+			is_zero = (desc->type == VSWAP_ZERO);
+		else if ((desc->type == VSWAP_ZERO) != is_zero)
+			goto done;
+	}
+done:
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	if (i && is_zeromap)
+		*is_zeromap = is_zero;
+
+	return i;
+}
+
 /**
  * free_swap_and_cache_nr() - Release a swap count on range of swap entries and
  *                            reclaim their cache if no more references remain.
@@ -1033,11 +1367,6 @@ bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si)
 	struct vswap_cluster *cluster;
 	swp_slot_t slot;
 
-	slot = swp_entry_to_swp_slot(entry);
-	*si = swap_slot_tryget_swap_info(slot);
-	if (!*si)
-		return false;
-
 	/*
 	 * Ensure the cluster and its associated data structures (swap cache etc.)
 	 * remain valid.
@@ -1046,11 +1375,30 @@ bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si)
 	cluster = xa_load(&vswap_cluster_map, VSWAP_CLUSTER_IDX(entry));
 	if (!cluster || !refcount_inc_not_zero(&cluster->refcnt)) {
 		rcu_read_unlock();
-		swap_slot_put_swap_info(*si);
 		*si = NULL;
 		return false;
 	}
 	rcu_read_unlock();
+
+	slot = swp_entry_to_swp_slot(entry);
+	/*
+	 * Note that this function does not provide any guarantee that the virtual
+	 * swap slot's backing state will be stable. This has several implications:
+	 *
+	 * 1. We have to obtain a reference to the swap device itself, because we
+	 * need swap device's metadata in certain scenarios, for example when we
+	 * need to inspect the swap device flag in do_swap_page().
+	 *
+	 * 2. The swap device we are looking up here might be outdated by the time we
+	 * return to the caller. It is perfectly OK, if the swap_info_struct is only
+	 * used in a best-effort manner (i.e optimization). If we need the precise
+	 * backing state, we need to re-check after the entry is pinned in swapcache.
+	 */
+	if (slot.val)
+		*si = swap_slot_tryget_swap_info(slot);
+	else
+		*si = NULL;
+
 	return true;
 }
 
@@ -1287,7 +1635,7 @@ void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp
 		old = desc->shadow;
 
 		/* Warn if slot is already occupied by a folio */
-		VM_WARN_ON_FOLIO(old && !xa_is_value(old), folio);
+		VM_WARN_ON_FOLIO(old && !xa_is_value(old) && old != folio, folio);
 
 		/* Save shadow if found and not yet saved */
 		if (shadowp && xa_is_value(old) && !*shadowp)
@@ -1414,29 +1762,22 @@ void __swap_cache_replace_folio(struct folio *old, struct folio *new)
  * @entry: the zswap entry to store
  *
  * Stores a zswap entry in the swap descriptor for the given swap entry.
- * The cluster is locked during the store operation.
- *
- * Return: the old zswap entry if one existed, NULL otherwise
+ * Releases the old backend if one existed.
  */
-void *zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
+void zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
 {
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
-	void *old;
+
+	release_backing(swpentry, 1);
 
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, swpentry.val);
-	if (!desc) {
-		rcu_read_unlock();
-		return NULL;
-	}
-
-	old = desc->zswap_entry;
+	VM_WARN_ON(!desc);
 	desc->zswap_entry = entry;
+	desc->type = VSWAP_ZSWAP;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
-
-	return old;
 }
 
 /**
@@ -1451,6 +1792,7 @@ void *zswap_entry_load(swp_entry_t swpentry)
 {
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
+	enum swap_type type;
 	void *zswap_entry;
 
 	rcu_read_lock();
@@ -1460,41 +1802,15 @@ void *zswap_entry_load(swp_entry_t swpentry)
 		return NULL;
 	}
 
+	type = desc->type;
 	zswap_entry = desc->zswap_entry;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
 
-	return zswap_entry;
-}
-
-/**
- * zswap_entry_erase - erase a zswap entry for a swap entry
- * @swpentry: the swap entry
- *
- * Erases the zswap entry from the swap descriptor for the given swap entry.
- * The cluster is locked during the erase operation.
- *
- * Return: the zswap entry that was erased, NULL if none existed
- */
-void *zswap_entry_erase(swp_entry_t swpentry)
-{
-	struct vswap_cluster *cluster = NULL;
-	struct swp_desc *desc;
-	void *old;
-
-	rcu_read_lock();
-	desc = vswap_iter(&cluster, swpentry.val);
-	if (!desc) {
-		rcu_read_unlock();
+	if (type != VSWAP_ZSWAP)
 		return NULL;
-	}
 
-	old = desc->zswap_entry;
-	desc->zswap_entry = NULL;
-	spin_unlock(&cluster->lock);
-	rcu_read_unlock();
-
-	return old;
+	return zswap_entry;
 }
 
 bool zswap_empty(swp_entry_t swpentry)
diff --git a/mm/zswap.c b/mm/zswap.c
index e46349f9c90bb..c5e1d252cb463 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -991,8 +991,9 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 {
 	struct folio *folio;
 	struct mempolicy *mpol;
-	bool folio_was_allocated;
+	bool folio_was_allocated, phys_swap_alloced = false;
 	struct swap_info_struct *si;
+	struct zswap_entry *new_entry = NULL;
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
@@ -1027,18 +1028,23 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * old compressed data. Only when this is successful can the entry
 	 * be dereferenced.
 	 */
-	if (entry != zswap_entry_load(swpentry)) {
+	new_entry = zswap_entry_load(swpentry);
+	if (entry != new_entry) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	if (!vswap_alloc_swap_slot(folio)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	phys_swap_alloced = true;
+
 	if (!zswap_decompress(entry, folio)) {
 		ret = -EIO;
 		goto out;
 	}
 
-	zswap_entry_erase(swpentry);
-
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
 		count_objcg_events(entry->objcg, ZSWPWB, 1);
@@ -1056,6 +1062,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 out:
 	if (ret && ret != -EEXIST) {
+		if (phys_swap_alloced)
+			zswap_entry_store(swpentry, new_entry);
 		swap_cache_del_folio(folio);
 		folio_unlock(folio);
 	}
@@ -1401,7 +1409,7 @@ static bool zswap_store_page(struct page *page,
 			     struct zswap_pool *pool)
 {
 	swp_entry_t page_swpentry = page_swap_entry(page);
-	struct zswap_entry *entry, *old;
+	struct zswap_entry *entry;
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
@@ -1413,15 +1421,12 @@ static bool zswap_store_page(struct page *page,
 	if (!zswap_compress(page, entry, pool))
 		goto compress_failed;
 
-	old = zswap_entry_store(page_swpentry, entry);
-
 	/*
 	 * We may have had an existing entry that became stale when
 	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
+	 * swapped out. zswap_entry_store() will get rid of the old.
 	 */
-	if (old)
-		zswap_entry_free(old);
+	zswap_entry_store(page_swpentry, entry);
 
 	/*
 	 * The entry is successfully compressed and stored in the tree, there is
@@ -1533,18 +1538,13 @@ bool zswap_store(struct folio *folio)
 	 * the possibly stale entries which were previously stored at the
 	 * offsets corresponding to each page of the folio. Otherwise,
 	 * writeback could overwrite the new data in the swapfile.
+	 *
+	 * The only exception is if we still have a full contiguous
+	 * range of physical swap slots backing the folio. Keep them for
+	 * fallback disk swapping.
 	 */
-	if (!ret) {
-		unsigned type = swp_type(swp);
-		pgoff_t offset = swp_offset(swp);
-		struct zswap_entry *entry;
-
-		for (index = 0; index < nr_pages; ++index) {
-			entry = zswap_entry_erase(swp_entry(type, offset + index));
-			if (entry)
-				zswap_entry_free(entry);
-		}
-	}
+	if (!ret && !vswap_swapfile_backed(swp, nr_pages))
+		vswap_store_folio(swp, folio);
 
 	return ret;
 }
@@ -1619,8 +1619,7 @@ int zswap_load(struct folio *folio)
 	 */
 	if (swapcache) {
 		folio_mark_dirty(folio);
-		zswap_entry_erase(swp);
-		zswap_entry_free(entry);
+		vswap_store_folio(swp, folio);
 	}
 
 	folio_unlock(folio);
-- 
2.52.0


