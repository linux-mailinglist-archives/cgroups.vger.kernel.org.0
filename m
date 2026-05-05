Return-Path: <cgroups+bounces-15620-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPC9OJ0Q+mntIgMAu9opvQ
	(envelope-from <cgroups+bounces-15620-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:45:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3074D0781
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C1C6303EA79
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295884921BA;
	Tue,  5 May 2026 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REv9Xyfg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706B48C8BA
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995577; cv=none; b=KAiUGdFrFiTiHlp+HXpQvo4vK1iimHqBbWJQF5LOYSatJtgm409cDqs2gI7/FrVK6QBdHFUt2LEXv3fergVsrmj11zYjUAYv6c6sV1zzXrrixPo6QsVpKXglolHIDzgTgIuXeafNPa/HdtKrHw59eO6gm1U8cKkIzFiey1Y0Pg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995577; c=relaxed/simple;
	bh=Eq2dWJ1ZIBpzRVJLBCdpDj0PxNvLSSlUGw2VbrJMcsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1BApwlqw+Lc2UO1tsjNxiES2MKvP8N2dji6Qyzm31wYuPVv49pujqQYYtooHOAGrwGhhinToVn2RWnEtJbzu/nI39D69EFsqrilCXX7oQmogNQ1wT2i3RO57N1juQDZObK4jGBABsrb6EcfAQsltxLyevgXJbPddEmphX+dVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REv9Xyfg; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-47c35be031dso3205989b6e.3
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995569; x=1778600369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQUOKwx77jc0Sds9N1MuRZDCnrz5jETMgd5cg+erVU8=;
        b=REv9Xyfgc+8mCGPVDsQU2VDfQr8H6QJ7eZVZsszF6dt7CZYO9NiIxM7ZevBC/LUnIl
         L3Oq10Q0yXzlRiW17splmvhXg3e5U7a0RTSh/Q2jwLJNIbDyL2in8hniv/phpG9JngGQ
         F1AYfB5bkN9vVJsRZOfYebiHpfP9PdayvlIEC7j16fdk20PBmMdd39edwsAf/tEV+oPs
         aQrh9nYtMzWRpNLF1zD7B2L2r5UY45lhlgP7xOh7sIQSepsY2MuWtb/kkriJoo8z1Kmt
         /X1AmuUaSJeUyeEeuor0WXzn++ZcM18VZGsCXRf+ehujjBf+b1i1XMrMW3uM4waZbRZH
         Aeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995569; x=1778600369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQUOKwx77jc0Sds9N1MuRZDCnrz5jETMgd5cg+erVU8=;
        b=hE1hTIDMtbsieeoNgJpN3+Jv83+EnWqvH4OdgQsoxAuROtK8e1SAUcvoR+Hw64G7KX
         gsipxoTCQZ9Bf2XYaBhivG4VXeGNrwGPRGq33x2Dhi/g65LzirCELSNe1qQwZJuC9FGf
         MD7LAgvuwlurXvqxjkZ4cwcIZpdXxMxFouDtuByQFz8eHGRc0hUtgHntZpFU/XzBVgiI
         hq4rdpjuxRVNLpPRpwjx9SwfrSEXRjuebpgSoLzgRmjITKidPnZUhALf2fjDLTcRKO8l
         5nco1eHfj2GAmN90+PhRNW6SMzQiqGXR/lNEBiOsijMFJpD529DrVF5JNjYVzdGu/yYH
         ZKfg==
X-Forwarded-Encrypted: i=1; AFNElJ8TIV1uSfuOaXshiyhs6AKxPpgJ4ptibal5SESxc97z8A+ZfdZfl6DLAVkRKzl0Ondn9mC9Fmue@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GbhkR54+HI+QZht4HsXAZIbX7k93gXOKVXiemKBoLuBgVnk4
	9M+8U8Q7a4uol9h/A/CtrEH0Tio7nvMyR9USEHJDA8oo+W82pKFy7ks8
X-Gm-Gg: AeBDiev9GAbaXY5zt5Csizu4qDsegkNt8HPVdYTQVc8HnWFcTT7QKxkgmx5r1uwqKFq
	WtTBvKJiMciOdVP1v93KFILfgsF6mSfpm41SR0An1bVu1QysoK5ikhvT9ifwXsLopwODBmL/ZYr
	PsITMVsIXAg3cSqr+5roiggOwjC1WPVygFXWGi+csazzMl5Oa+9eX3mID4tEQD9Su7HorE21r6Y
	LhG/8xzKcUm2iaCwXDvDjxHQmvKZ7AixAdA4txKgixE+9n3yG+yGT/tVD5RJidGml6m3ZWUE7MJ
	dPlfW5rCBhLAt6gd1SGSOOYibvuKRaBUaGiup1PvbG/mYSCjOqNivQL9eljjucwkzlNwIRccKOe
	/tO4xFcB/Fb1Iss5ZKBmuTUXhv3Es3yYo78VrBOmzlvs+H3GmhYrNS+MpQOMnwi/NgTqWN5wxZ0
	OOb3+52vHU5zUlAM5+e8L8Ncu8i5SA6lYBb151bOmWj7tRzjgX6Ms/6h0=
X-Received: by 2002:a05:6808:5086:b0:47b:d07b:ec9b with SMTP id 5614622812f47-47c8925e44emr7146514b6e.24.1777995568996;
        Tue, 05 May 2026 08:39:28 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43454d324e2sm13278322fac.13.2026.05.05.08.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:27 -0700 (PDT)
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
Subject: [PATCH v6 14/22] mm: swap: decouple virtual swap slot from backing store
Date: Tue,  5 May 2026 08:38:43 -0700
Message-ID: <20260505153854.1612033-15-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BE3074D0781
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15620-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
 include/linux/swap.h  |  34 ++-
 include/linux/zswap.h |   3 +-
 mm/internal.h         |  22 +-
 mm/memcontrol.c       |  65 +++--
 mm/memory.c           |  84 ++++--
 mm/page_io.c          | 123 +++-----
 mm/shmem.c            |   6 +-
 mm/swap.h             |  35 +--
 mm/swap_state.c       |  29 +-
 mm/swapfile.c         |  11 +-
 mm/vmscan.c           |  19 +-
 mm/vswap.c            | 646 +++++++++++++++++++++++++++++++++---------
 mm/zswap.c            |  65 +++--
 13 files changed, 787 insertions(+), 355 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0ec408a6c6a2..12dd9621b637 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -422,7 +422,14 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
 bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si);
 void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si);
-
+bool vswap_swapfile_backed(swp_entry_t entry, int nr);
+bool vswap_folio_backed(swp_entry_t entry, int nr);
+void vswap_store_folio(swp_entry_t entry, struct folio *folio);
+void vswap_prepare_writeout(swp_entry_t entry, struct folio *folio);
+void swap_zeromap_folio_set(struct folio *folio);
+void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry);
+bool vswap_can_swapin_thp(swp_entry_t entry, int nr);
+swp_slot_t vswap_alloc_swap_slot(struct folio *folio);
 
 /* Lifecycle swap API (mm/swapfile.c and mm/vswap.c) */
 int folio_alloc_swap(struct folio *folio);
@@ -479,7 +486,15 @@ unsigned int count_swap_pages(int, int);
 sector_t swapdev_block(int, pgoff_t);
 struct backing_dev_info;
 struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot);
-sector_t swap_folio_sector(struct folio *folio);
+
+static inline struct swap_info_struct *vswap_get_device(swp_entry_t entry)
+{
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+
+	return slot.val ? swap_slot_tryget_swap_info(slot) : NULL;
+}
+
+sector_t swap_slot_sector(swp_slot_t slot);
 
 static inline void swap_slot_put_swap_info(struct swap_info_struct *si)
 {
@@ -598,6 +613,21 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
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
index 07b2936c38f2..f33b4433a5ee 100644
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
index 240103c8819b..df67a3c4168a 100644
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
@@ -419,6 +405,12 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte,
 	nr = ptep - start_ptep;
 	if (!free_batch)
 		nr = vswap_cgroup_batch(entry, nr);
+	/*
+	 * free_swap_and_cache_nr can handle mixed backends, as long as virtual
+	 * swap entries backing these PTEs are contiguous.
+	 */
+	if (!free_batch && !vswap_can_swapin_thp(entry, nr))
+		return 1;
 	return nr;
 }
 #endif /* CONFIG_MMU */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e237cc1e644d..4ff24bd53bd7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5276,10 +5276,18 @@ void __mem_cgroup_uncharge_swap_by_id(unsigned short id,
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
@@ -5448,6 +5456,29 @@ static struct cftype swap_files[] = {
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
@@ -5462,34 +5493,15 @@ static struct cftype swap_files[] = {
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
 
@@ -5633,6 +5645,11 @@ static struct cftype zswap_files[] = {
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
index d32d35e25738..5a8d7fe5f1c9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
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
index 5de370557295..8cfe3599f765 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
  *
- *  Swap reorganised 29.12.95, 
+ *  Swap reorganised 29.12.95,
  *  Asynchronous swapping added 30.12.95. Stephen Tweedie
  *  Removed race in async swapping. 14.4.1996. Bruno Haible
  *  Add swap of shared pages through the page cache. 20.2.1998. Stephen Tweedie
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
@@ -246,6 +208,7 @@ static void swap_zeromap_folio_clear(struct folio *folio)
 int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 {
 	int ret = 0;
+	swp_slot_t slot;
 
 	if (folio_free_swap(folio))
 		goto out_unlock;
@@ -260,23 +223,19 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
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
+	 * Release swap backends to make sure we do not have mixed backends.
+	 *
+	 * If the folio is already backed by contiguous physical swap slots
+	 * (e.g. from a previous swapout attempt when zswap is disabled),
+	 * keep that backend to avoid reallocation.
 	 */
-	swap_zeromap_folio_clear(folio);
+	vswap_prepare_writeout(folio->swap, folio);
 
 	if (zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
@@ -287,7 +246,15 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 		return AOP_WRITEPAGE_ACTIVATE;
 	}
 
-	__swap_writepage(folio, swap_plug);
+	/* fall back to physical swap device */
+	slot = vswap_alloc_swap_slot(folio);
+
+	if (!slot.val) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
+	__swap_writepage(folio, swap_plug, slot);
 	return 0;
 out_unlock:
 	folio_unlock(folio);
@@ -378,10 +345,10 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 	mempool_free(sio, sio_pool);
 }
 
-static void swap_writepage_fs(struct folio *folio, struct swap_iocb **swap_plug)
+static void swap_writepage_fs(struct folio *folio, struct swap_iocb **swap_plug,
+			     swp_slot_t slot)
 {
 	struct swap_iocb *sio = swap_plug ? *swap_plug : NULL;
-	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
 	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 	struct file *swap_file = sis->swap_file;
 	loff_t pos = swap_slot_dev_pos(slot);
@@ -416,13 +383,13 @@ static void swap_writepage_fs(struct folio *folio, struct swap_iocb **swap_plug)
 }
 
 static void swap_writepage_bdev_sync(struct folio *folio,
-		struct swap_info_struct *sis)
+		struct swap_info_struct *sis, swp_slot_t slot)
 {
 	struct bio_vec bv;
 	struct bio bio;
 
 	bio_init(&bio, sis->bdev, &bv, 1, REQ_OP_WRITE | REQ_SWAP);
-	bio.bi_iter.bi_sector = swap_folio_sector(folio);
+	bio.bi_iter.bi_sector = swap_slot_sector(slot);
 	bio_add_folio_nofail(&bio, folio, folio_size(folio), 0);
 
 	bio_associate_blkg_from_page(&bio, folio);
@@ -436,12 +403,12 @@ static void swap_writepage_bdev_sync(struct folio *folio,
 }
 
 static void swap_writepage_bdev_async(struct folio *folio,
-		struct swap_info_struct *sis)
+		struct swap_info_struct *sis, swp_slot_t slot)
 {
 	struct bio *bio;
 
 	bio = bio_alloc(sis->bdev, 1, REQ_OP_WRITE | REQ_SWAP, GFP_NOIO);
-	bio->bi_iter.bi_sector = swap_folio_sector(folio);
+	bio->bi_iter.bi_sector = swap_slot_sector(slot);
 	bio->bi_end_io = end_swap_bio_write;
 	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
 
@@ -452,10 +419,10 @@ static void swap_writepage_bdev_async(struct folio *folio,
 	submit_bio(bio);
 }
 
-void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
+void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug,
+		      swp_slot_t slot)
 {
-	struct swap_info_struct *sis =
-		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
+	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
 	/*
@@ -464,16 +431,16 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
 	 * is safe.
 	 */
 	if (data_race(sis->flags & SWP_FS_OPS))
-		swap_writepage_fs(folio, swap_plug);
+		swap_writepage_fs(folio, swap_plug, slot);
 	/*
 	 * ->flags can be updated non-atomicially (scan_swap_map_slots),
 	 * but that will never affect SWP_SYNCHRONOUS_IO, so the data_race
 	 * is safe.
 	 */
 	else if (data_race(sis->flags & SWP_SYNCHRONOUS_IO))
-		swap_writepage_bdev_sync(folio, sis);
+		swap_writepage_bdev_sync(folio, sis, slot);
 	else
-		swap_writepage_bdev_async(folio, sis);
+		swap_writepage_bdev_async(folio, sis, slot);
 }
 
 void swap_write_unplug(struct swap_iocb *sio)
@@ -544,9 +511,9 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 	return true;
 }
 
-static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
+static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug,
+			      swp_slot_t slot)
 {
-	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
 	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 	struct swap_iocb *sio = NULL;
 	loff_t pos = swap_slot_dev_pos(slot);
@@ -580,13 +547,13 @@ static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 }
 
 static void swap_read_folio_bdev_sync(struct folio *folio,
-		struct swap_info_struct *sis)
+		struct swap_info_struct *sis, swp_slot_t slot)
 {
 	struct bio_vec bv;
 	struct bio bio;
 
 	bio_init(&bio, sis->bdev, &bv, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = swap_folio_sector(folio);
+	bio.bi_iter.bi_sector = swap_slot_sector(slot);
 	bio_add_folio_nofail(&bio, folio, folio_size(folio), 0);
 	/*
 	 * Keep this task valid during swap readpage because the oom killer may
@@ -602,12 +569,12 @@ static void swap_read_folio_bdev_sync(struct folio *folio,
 }
 
 static void swap_read_folio_bdev_async(struct folio *folio,
-		struct swap_info_struct *sis)
+		struct swap_info_struct *sis, swp_slot_t slot)
 {
 	struct bio *bio;
 
 	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
-	bio->bi_iter.bi_sector = swap_folio_sector(folio);
+	bio->bi_iter.bi_sector = swap_slot_sector(slot);
 	bio->bi_end_io = end_swap_bio_read;
 	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
 	count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
@@ -618,14 +585,12 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 
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
+	swp_slot_t slot;
 
-	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
 
@@ -651,12 +616,18 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
 
+	slot = swp_entry_to_swp_slot(folio->swap);
+
+	sis = __swap_slot_to_info(slot);
+	synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
+	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
+
 	if (data_race(sis->flags & SWP_FS_OPS)) {
-		swap_read_folio_fs(folio, plug);
+		swap_read_folio_fs(folio, plug, slot);
 	} else if (synchronous) {
-		swap_read_folio_bdev_sync(folio, sis);
+		swap_read_folio_bdev_sync(folio, sis, slot);
 	} else {
-		swap_read_folio_bdev_async(folio, sis);
+		swap_read_folio_bdev_async(folio, sis, slot);
 	}
 
 finish:
diff --git a/mm/shmem.c b/mm/shmem.c
index 780571c830e5..3a346cca114a 100644
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
index 4b9005224518..d46b2f243f83 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -143,7 +143,8 @@ static inline void swap_read_unplug(struct swap_iocb *plug)
 }
 void swap_write_unplug(struct swap_iocb *sio);
 int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug);
-void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
+void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug,
+		      swp_slot_t slot);
 
 /* linux/mm/swap_state.c */
 extern struct address_space swap_space __read_mostly;
@@ -253,35 +254,15 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
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
index 235f165c7b30..7fe4d9529e4a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -179,6 +179,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	struct folio *result = NULL;
 	void *shadow = NULL;
 
+	/* we might get an unused entry from cluster readahead - just skip */
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
index 96151504a6e1..c6a91c657877 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -338,9 +338,8 @@ offset_to_swap_extent(struct swap_info_struct *sis, unsigned long offset)
 	BUG();
 }
 
-sector_t swap_folio_sector(struct folio *folio)
+sector_t swap_slot_sector(swp_slot_t slot)
 {
-	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
 	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 	struct swap_extent *se;
 	sector_t sector;
@@ -1218,14 +1217,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
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
index bd8900d7bb28..0ddf3f646645 100644
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
@@ -2637,12 +2638,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
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
index 71148323499b..01c336ae252c 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -13,6 +13,7 @@
 #include <linux/zswap.h>
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
+#include "internal.h"
 #include "swap.h"
 #include "swap_table.h"
 
@@ -56,22 +57,48 @@
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
@@ -80,10 +107,10 @@ struct swp_desc {
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
@@ -269,28 +296,27 @@ static bool cluster_is_alloc_candidate(struct vswap_cluster *cluster)
 	return cluster->count + (1 << (cluster->order)) <= VSWAP_CLUSTER_SIZE;
 }
 
-static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start,
-				       struct folio *folio)
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
 		desc->swap_count = 0;
 		desc->in_swapcache = true;
-		desc->swap_cache = folio;
 	}
 	cluster->count += nr;
 }
 
 static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster,
-					      struct folio *folio)
+		struct folio *folio)
 {
 	int nr = 1 << cluster->order;
 	unsigned long i = cluster->id ? 0 : nr;
@@ -505,24 +531,106 @@ static inline void release_vswap_slot(struct vswap_cluster *cluster,
 
 /*
  * Update the physical-to-virtual swap slot mapping.
- * Caller must ensure the physical swap slot's cluster is locked.
+ *
+ * Uses atomic_long_set which is inherently atomic, so no lock is required
+ * for the rmap update itself. Callers hold the physical swap cluster lock
+ * only if they need it for other operations (e.g. swap_slots_free).
  */
 void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 			   unsigned long vswap, int nr)
 {
-	atomic_long_t *table;
-	unsigned long slot_offset = swp_slot_offset(slot);
-	unsigned int ci_off = slot_offset % SWAPFILE_CLUSTER;
+	unsigned int ci_off = swp_cluster_offset(slot);
 	int i;
 
-	table = rcu_dereference_protected(ci->table, lockdep_is_held(&ci->lock));
-	VM_WARN_ON(!table);
 	for (i = 0; i < nr; i++)
 		__swap_table_set(ci, ci_off + i, vswap ? vswap + i : 0);
 }
 
 static unsigned short swp_desc_memcgid(struct swp_desc *desc);
 
+/*
+ * release_backing - release the backend storage for a given range of virtual
+ * swap slots.
+ *
+ * Entered with the cluster locked. The cluster lock is held throughout.
+ *
+ * This is safe, because:
+ *
+ * 1. Callers ensure no concurrent modification of the swap entry's internal
+ *    state can occur. This is guaranteed by one of the following:
+ *    - For vswap_free() callers: the swap entry's refcnt (swap count and
+ *      swapcache pin) is down to 0.
+ *    - For vswap_store_folio(), swap_zeromap_folio_set(), and zswap_entry_store()
+ *      callers: the folio is locked and in the swap cache.
+ *
+ * 2. The swap entry still holds a refcnt to the cluster, keeping the cluster
+ *    itself valid.
+ *
+ * 3. swap_slot_free_nr() takes the physical swap cluster lock (ci->lock),
+ *    but the only vswap function called under ci->lock is vswap_rmap_set(),
+ *    which uses atomic ops and does not take cluster->lock. So there is no
+ *    ABBA deadlock risk.
+ */
+static void release_backing(struct vswap_cluster *cluster, swp_entry_t entry,
+		int nr)
+{
+	struct swp_desc *desc;
+	unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
+	unsigned int phys_swap_type = 0;
+	bool need_flushing_phys_swap = false;
+	swp_slot_t flush_slot;
+	int i;
+
+	VM_WARN_ON(!entry.val);
+
+	for (i = 0; i < nr; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
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
+			swap_slot_free_nr(flush_slot, flush_nr);
+			need_flushing_phys_swap = false;
+		}
+	}
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
  * Entered with the cluster locked. The cluster lock is held throughout.
  *
@@ -543,29 +651,17 @@ static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 	swp_entry_t entry)
 {
 	unsigned short memcgid = swp_desc_memcgid(desc);
-	struct zswap_entry *zswap_entry;
-	swp_slot_t slot;
 
-	slot = desc->slot;
-	desc->slot.val = 0;
-
-	zswap_entry = desc->zswap_entry;
-	if (zswap_entry) {
-		desc->zswap_entry = NULL;
-		zswap_entry_free(zswap_entry);
-	}
+	release_backing(cluster, entry, 1);
 
 	mem_cgroup_uncharge_swap_by_id(memcgid, 1);
 
-	if (slot.val)
-		swap_slot_free_nr(slot, 1);
-
 	/* erase forward mapping and release the virtual slot for reallocation */
 	release_vswap_slot(cluster, entry.val);
 }
 
 /**
- * folio_alloc_swap - allocate swap space for a folio.
+ * folio_alloc_swap - allocate virtual swap space for a folio.
  * @folio: the folio.
  *
  * Return: 0, if the allocation succeeded, -ENOMEM, if the allocation failed.
@@ -573,12 +669,9 @@ static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
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
@@ -588,53 +681,21 @@ int folio_alloc_swap(struct folio *folio)
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
-	}
-
-	/* establish the virtual <-> physical swap slots linkages. */
-	si = __swap_slot_to_info(slot);
-	ci = swap_cluster_lock(si, swp_slot_offset(slot));
-	vswap_rmap_set(ci, slot, entry.val, nr);
-	swap_cluster_unlock(ci);
-
-	rcu_read_lock();
-	for (i = 0; i < nr; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
-		VM_WARN_ON(!desc);
-
-		desc->slot.val = slot.val + i;
-	}
-	if (cluster)
-		spin_unlock(&cluster->lock);
-	rcu_read_unlock();
-
-	/*
-	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
-	 * swap slots allocation. This is acceptable because as noted above, each
-	 * virtual swap slot corresponds to a physical swap slot. Once we have
-	 * decoupled virtual and physical swap slots, we will only charge when we
-	 * actually allocate a physical swap slot.
-	 */
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		put_swap_folio(folio, entry);
+		rcu_read_unlock();
+		atomic_add(nr, &vswap_alloc_reject);
+		entry.val = 0;
 		return -ENOMEM;
 	}
 
@@ -648,12 +709,84 @@ int folio_alloc_swap(struct folio *folio)
 	return 0;
 }
 
+/**
+ * vswap_alloc_swap_slot - allocate physical swap space for a folio that is
+ *                         already associated with virtual swap slots.
+ * @folio: folio we want to allocate physical swap space for.
+ *
+ * Note that this does NOT release existing swap backends of the folio.
+ * Callers need to handle this themselves.
+ *
+ * Return: the physical swap slot allocated, or zero swap slot on failure.
+ */
+swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
+{
+	int i, nr = folio_nr_pages(folio);
+	struct vswap_cluster *cluster = NULL;
+	swp_slot_t slot = { .val = 0 };
+	swp_entry_t entry = folio->swap;
+	struct swp_desc *desc;
+	bool fallback = false;
+
+	/*
+	 * Check if the first entry already has a physical swap slot. If so,
+	 * the entire range is contiguous (from a previous allocation).
+	 * Keep the cluster pointer around for reuse below.
+	 */
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	if (desc->type == VSWAP_SWAPFILE)
+		slot = desc->slot;
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	if (slot.val)
+		return slot;
+
+	if (swap_slot_alloc(&slot, folio_order(folio)))
+		return (swp_slot_t){ .val = 0 };
+
+	if (!slot.val)
+		return (swp_slot_t){ .val = 0 };
+
+	vswap_rmap_set(__swap_slot_to_cluster(slot), slot, entry.val, nr);
+
+	spin_lock(&cluster->lock);
+	for (i = 0; i < nr; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+
+		if (desc->type == VSWAP_FOLIO) {
+			/* case 1: fallback from zswap store failure */
+			fallback = true;
+			VM_WARN_ON(folio != desc->swap_cache);
+		} else {
+			/*
+			 * Case 2: zswap writeback.
+			 *
+			 * No need to free zswap entry here - it will be freed
+			 * once zswap writeback succeeds.
+			 */
+			VM_WARN_ON(desc->type != VSWAP_ZSWAP);
+			VM_WARN_ON(fallback);
+		}
+		desc->type = VSWAP_SWAPFILE;
+		desc->slot.val = slot.val + i;
+	}
+	spin_unlock(&cluster->lock);
+
+	return slot;
+}
+
 /**
  * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
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
@@ -672,7 +805,10 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 		return (swp_slot_t){0};
 	}
 
-	slot = desc->slot;
+	if (desc->type != VSWAP_SWAPFILE)
+		slot.val = 0;
+	else
+		slot = desc->slot;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
 
@@ -731,7 +867,7 @@ static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
 				desc->shadow = NULL;
 			vswap_free(cluster, desc, entry);
 		} else if (!desc->swap_count && desc->in_swapcache &&
-			   desc->slot.val) {
+			   desc->type == VSWAP_SWAPFILE) {
 			/*
 			 * swap_count just dropped to 0, but still in swap
 			 * cache. If backed by a physical swap slot, mark it
@@ -769,7 +905,7 @@ static int swap_duplicate_nr(swp_entry_t entry, int nr)
 		desc = vswap_iter(&cluster, entry.val + i);
 		if (!desc || (!desc->swap_count && !desc->in_swapcache))
 			goto done;
-		if (!desc->swap_count && desc->slot.val)
+		if (!desc->swap_count && desc->type == VSWAP_SWAPFILE)
 			swap_rmap_clear_cache_only(desc->slot);
 		desc->swap_count++;
 	}
@@ -795,7 +931,6 @@ int swap_duplicate(swp_entry_t entry)
 	return swap_duplicate_nr(entry, 1);
 }
 
-
 /**
  * folio_free_swap() - Free the swap space used for this folio.
  * @folio: The folio to remove.
@@ -1025,6 +1160,274 @@ int non_swapcache_batch(swp_entry_t entry, int max_nr)
 
 static struct folio *vswap_get_swap_cache(swp_entry_t entry, bool swap_cache_only);
 
+static int vswap_check_backing(swp_entry_t entry, enum swap_type *type, int nr,
+			       struct vswap_cluster **clusterp);
+
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
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	release_backing(cluster, entry, nr);
+
+	for (i = 0; i < nr; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+		desc->type = VSWAP_FOLIO;
+		desc->swap_cache = folio;
+	}
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+}
+
+/**
+ * vswap_prepare_writeout - prepare a folio for writeout by releasing
+ *                          non-swapfile backends in a single lock context.
+ * @entry: the first virtual swap slot in the range.
+ * @folio: the folio being written out.
+ *
+ * If the folio is already backed by contiguous physical swap slots,
+ * this is a no-op (the existing backing is preserved). Otherwise,
+ * release the current backing and store the folio.
+ *
+ * Combines the vswap_swapfile_backed() check and vswap_store_folio()
+ * into a single cluster lock acquisition.
+ */
+void vswap_prepare_writeout(swp_entry_t entry, struct folio *folio)
+{
+	struct vswap_cluster *cluster = NULL;
+	int i, nr = folio_nr_pages(folio);
+	enum swap_type type;
+	struct swp_desc *desc;
+
+	VM_BUG_ON(!folio_test_locked(folio));
+	VM_BUG_ON(folio->swap.val != entry.val);
+
+	/* Check backing with lock held on return */
+	if (vswap_check_backing(entry, &type, nr, &cluster) == nr &&
+	    (type == VSWAP_SWAPFILE || type == VSWAP_FOLIO)) {
+		/* Already contiguous swapfile-backed or folio-backed, keep it */
+		if (cluster)
+			spin_unlock(&cluster->lock);
+		rcu_read_unlock();
+		return;
+	}
+
+	if (!cluster) {
+		rcu_read_unlock();
+		return;
+	}
+
+	/* Release old backing and store the folio, lock already held */
+	release_backing(cluster, entry, nr);
+
+	for (i = 0; i < nr; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
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
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	release_backing(cluster, entry, nr);
+
+	for (i = 0; i < nr; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
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
+static int vswap_check_backing(swp_entry_t entry, enum swap_type *type, int nr,
+			       struct vswap_cluster **clusterp)
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
+	if (clusterp) {
+		/* Caller takes ownership of the lock and rcu_read_lock */
+		*clusterp = cluster;
+	} else {
+		if (cluster)
+			spin_unlock(&cluster->lock);
+		rcu_read_unlock();
+	}
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
+	return vswap_check_backing(entry, &type, nr, NULL) == nr
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
+	return vswap_check_backing(entry, &type, nr, NULL) == nr && type == VSWAP_FOLIO;
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
+	return vswap_check_backing(entry, &type, nr, NULL) == nr &&
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
@@ -1088,11 +1491,6 @@ bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si)
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
@@ -1101,11 +1499,30 @@ bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si)
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
 
@@ -1354,7 +1771,7 @@ void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp
 		old = desc->shadow;
 
 		/* Warn if slot is already occupied by a folio */
-		VM_WARN_ON_FOLIO(old && !xa_is_value(old), folio);
+		VM_WARN_ON_FOLIO(old && !xa_is_value(old) && old != folio, folio);
 
 		/* Save shadow if found and not yet saved */
 		if (shadowp && xa_is_value(old) && !*shadowp)
@@ -1512,29 +1929,21 @@ void __swap_cache_replace_folio(struct folio *old, struct folio *new)
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
 
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, swpentry.val);
-	if (!desc) {
-		rcu_read_unlock();
-		return NULL;
-	}
-
-	old = desc->zswap_entry;
+	VM_WARN_ON(!desc);
+	release_backing(cluster, swpentry, 1);
 	desc->zswap_entry = entry;
+	desc->type = VSWAP_ZSWAP;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
-
-	return old;
 }
 
 /**
@@ -1549,6 +1958,7 @@ void *zswap_entry_load(swp_entry_t swpentry)
 {
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
+	enum swap_type type;
 	void *zswap_entry;
 
 	rcu_read_lock();
@@ -1558,41 +1968,15 @@ void *zswap_entry_load(swp_entry_t swpentry)
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
index 0590a96062fb..e8aa9201ea30 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -991,8 +991,10 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 {
 	struct folio *folio;
 	struct mempolicy *mpol;
-	bool folio_was_allocated;
+	bool folio_was_allocated, phys_swap_alloced = false;
 	struct swap_info_struct *si;
+	struct zswap_entry *new_entry = NULL;
+	swp_slot_t slot;
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
@@ -1027,18 +1029,25 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * old compressed data. Only when this is successful can the entry
 	 * be dereferenced.
 	 */
-	if (entry != zswap_entry_load(swpentry)) {
+	new_entry = zswap_entry_load(swpentry);
+	if (entry != new_entry) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	slot = vswap_alloc_swap_slot(folio);
+
+	if (!slot.val) {
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
@@ -1052,10 +1061,12 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	folio_set_reclaim(folio);
 
 	/* start writeback */
-	__swap_writepage(folio, NULL);
+	__swap_writepage(folio, NULL, slot);
 
 out:
 	if (ret && ret != -EEXIST) {
+		if (phys_swap_alloced)
+			zswap_entry_store(swpentry, new_entry);
 		swap_cache_del_folio(folio);
 		folio_unlock(folio);
 	}
@@ -1401,7 +1412,7 @@ static bool zswap_store_page(struct page *page,
 			     struct zswap_pool *pool)
 {
 	swp_entry_t page_swpentry = page_swap_entry(page);
-	struct zswap_entry *entry, *old;
+	struct zswap_entry *entry;
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
@@ -1413,15 +1424,12 @@ static bool zswap_store_page(struct page *page,
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
 	 * The entry is successfully compressed and stored in vswap, there is
@@ -1473,13 +1481,14 @@ bool zswap_store(struct folio *folio)
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
 	bool ret = false;
+	bool partial_store = false;
 	long index;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 	VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
 
 	if (!zswap_enabled)
-		goto check_old;
+		return false;
 
 	objcg = get_obj_cgroup_from_folio(folio);
 	if (objcg && !obj_cgroup_may_zswap(objcg)) {
@@ -1510,8 +1519,10 @@ bool zswap_store(struct folio *folio)
 	for (index = 0; index < nr_pages; ++index) {
 		struct page *page = folio_page(folio, index);
 
-		if (!zswap_store_page(page, objcg, pool))
+		if (!zswap_store_page(page, objcg, pool)) {
+			partial_store = index > 0;
 			goto put_pool;
+		}
 	}
 
 	if (objcg)
@@ -1527,24 +1538,17 @@ bool zswap_store(struct folio *folio)
 	obj_cgroup_put(objcg);
 	if (!ret && zswap_pool_reached_full)
 		queue_work(shrink_wq, &zswap_shrink_work);
-check_old:
 	/*
-	 * If the zswap store fails or zswap is disabled, we must invalidate
-	 * the possibly stale entries which were previously stored at the
-	 * offsets corresponding to each page of the folio. Otherwise,
-	 * writeback could overwrite the new data in the swapfile.
+	 * If a partial store happened, some pages have stale VSWAP_ZSWAP
+	 * entries that must be invalidated. Otherwise, writeback could
+	 * overwrite the new data in the swapfile.
+	 *
+	 * If we never entered the store loop (zswap disabled, cgroup
+	 * limits, no pool, etc.), the backing is untouched — no cleanup
+	 * needed.
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
+	if (partial_store)
+		vswap_prepare_writeout(swp, folio);
 
 	return ret;
 }
@@ -1619,8 +1623,7 @@ int zswap_load(struct folio *folio)
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


