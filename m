Return-Path: <cgroups+bounces-14078-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH/VK43imGm2NwMAu9opvQ
	(envelope-from <cgroups+bounces-14078-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 23:39:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0333B16B45D
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 23:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D10E30137A0
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 22:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95E130F543;
	Fri, 20 Feb 2026 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ7qHwqE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008F30F539
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 22:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627145; cv=none; b=eHKbGb50KOCDqa+wNGQfOnoum3yBmSW6TT85ErOZ5LSeLhxz7qxVf1goULVpBk7vC7ezMG2NE661ix5AcEo0FqJZ6nwBFDKnK6xL6lHP2fV1BwhrONpU5NksUXhJFHuIFB/FrNDVoBRRdgDq9HdWCr9ys16B9ses7uI8pbRuxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627145; c=relaxed/simple;
	bh=CErc1Cc+3h2ZneEzfwDGZEbOO+w6VY+iLEp30+TKX/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bw0nEPDbUZF1RikeZQRhnCLqVqCcIheOXdd/IQ2+0j+V74IslUM3FSlJ2sj+BQwQZBuvq/BWBuh3JU7SD2BmJrPdjJ/avor/7hca8CbjBAFDWNVBYN5mhE00pEfG6j2lNycy1iXt1S07dLi0zRmtjAC7RlC/+Y6jjNmmqSUv8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ7qHwqE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-506a93ba42dso26502251cf.1
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 14:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771627142; x=1772231942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ysaqx8k04M5ZyWb6NfqEX6Ito7kZyTdQoQ1l4hgF4A=;
        b=eZ7qHwqE+a5wskuZGZmTYPEFaHX+q+5rdpyLptB3gkgUnRG+LDu5mdmirQ7SpbI37V
         yXJMbfE1CQ/8w0rdEyQa0IX0x1RSebOxoN1GGgN++JFmrj8VQg01F7a0D2Blt9cVzvjI
         U2J0Upy8y8VsE4RxaWcJFPGU8Hxvrt9dMT3KsZbZWf+hqs1pXm5qFei4bYwjb7MlwpoJ
         SGMipgpxfIOmDbXyIRN4xeOzKOJuVKhqVJ0/VsCeMfzHE9WGpE6/VwV5t6Eb+H12gzHO
         GKXHTsC5vcKjyUug7nZBmFrLgabqWSkf31znQNdTaU5kUHpTXY1p26zJUCM6lqYq2NV5
         V26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771627142; x=1772231942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ysaqx8k04M5ZyWb6NfqEX6Ito7kZyTdQoQ1l4hgF4A=;
        b=vmhEkk1Ocy9AWR0Pk5oUpysCL7/7sKSErKGl8NW3ytDk1PnCWbNuXYyVp9swEbbufJ
         cw9AHMl7dxlVAi/iTQRKVReu8NpM/8G1eKYoF0FLAEG6LrgyhvJNWpfG4oivtY35vxmT
         sKJ9sNQqN8886m28nBwM+CcmYXPCo9BRjLdIiHg0u51/PAfxxF7biM+A7hPOSRgRsA0B
         2Xhstif8b/zh46C8W4Y6LLzXbMofS6Ll0VcUhJm9aXt9jZZh6HWUv8P9bfPjCiGAPtEZ
         fmScoio5JdkMpca5ClvL/aPwQXFJ0BRRA03pwR8PNlUXBfZQidS05V+Pnu6dP3g2RyTb
         tXsA==
X-Forwarded-Encrypted: i=1; AJvYcCUvw6djCBYj/q+H1Gg+iPWisxma5dPxCpDs/jH1lPDNccqfE2CYEw6VvujKmqMjNybjNCzGiv20@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28k61jrMULrYr3RQvT2JSkYT0/t8stHVPWgaawu/62APv1nRf
	CaYLXd09cbebEI/hFndki4NdCh1FriSSE2nWu2E5ySB6Wa7M0/XnLkyNlZVfr1eSQdA=
X-Gm-Gg: AZuq6aJc0/yXqhKLGfIczK1H3ckOrwnM4oBj4isWucEuCHqzaHqyx9FqZTglq9quAVK
	NwQRlDklHbrdEiMKA8mlnxzHpEJVANzGf8uLsvpqW4dNKASSzwODkhjJX6U8EHpkhQ9Cmk7EDrK
	qFaBGNKplTqZ0pSQlaHq0L26XL7fIjzT8ZxBH/WsTOgNntMqI94aGs9BbeTOQ+2k9C7Vp4cZtuw
	y+CYK8IAummyJjDTdIfry39RSPMt6qryvo+A6uW+fbcw85hSv+cCoruT0IyborycgbuU7In/L9/
	qlSdj7l4Kd+dJ5nLm6p8HQbcrn+q0wFw1Xd1hdvSvnS/FLl5ba1nxhmx9UudpJkysjs3wxwj0OU
	av6CeNvn464fuYhOQMtTlxorogrMkDAtOIQ1lwc6+3UH4BJ6UfobCGMxu9ebIu0Jz1eq/9QUOhf
	CecQUDgb4NCRVE+f2hWFwynIfNQ5p/D5A1gNs2xLib89qOCpU6/iKRpI4=
X-Received: by 2002:a05:6820:188a:b0:66e:10ca:fcd5 with SMTP id 006d021491bc7-679c424cbe9mr582827eaf.12.1771621540600;
        Fri, 20 Feb 2026 13:05:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c56ec56dsm363029eaf.12.2026.02.20.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 13:05:40 -0800 (PST)
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
Subject: [PATCH] vswap: fix poor batching behavior of vswap free path
Date: Fri, 20 Feb 2026 13:05:39 -0800
Message-ID: <20260220210539.989603-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
References: <CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14078-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0333B16B45D
X-Rspamd-Action: no action

Kairui, could you apply this patch on top of the vswap series and run it
on your test suite? It runs fairly well on my system (I actually rerun
the benchmark on a different host to double check as well), but I'd love
to get some data from your ends as well.

If there are serious discrepancies, could you also include your build
config etc.? There might be differences in our setups, but since I
managed to reproduce the free time regression on my first try I figured
I should just fix it first :)

---------------

Fix two issues that make the swap free path inefficient:

1. At the PTE zapping step, we are unnecessarily resolving the backends,
   and fall back to batch size of 1, even though virtual swap
   infrastructure now already supports freeing of mixed backend ranges
   (as long the PTEs contain virtually contiguous swap slots).
2. Optimize vswap_free() by batching consecutive free operations, and
   avoid releasing locks unnecessarily (most notably, when we release
   non-disk-swap backends).

Per a report from Kairui Song ([1]), I have run the following benchmark:

free -m
               total        used        free      shared  buff/cache   available
Mem:           31596        5094       11667          19       15302       26502
Swap:          65535          33       65502

Running the usemem benchmark with n = 1, 56G for 5 times, and average
out the result:

Baseline (6.19):

real: mean: 190.93s, stdev: 5.09s
user: mean: 46.62s, stdev: 0.27s
sys: mean: 128.51s, stdev: 5.17s
throughput: mean: 382093 KB/s, stdev: 11173.6 KB/s
free time: mean: 7916690.2 usecs, stdev: 88923.0 usecs

VSS without this patch:
real: mean: 194.59s, stdev: 7.61s
user: mean: 46.71s, stdev: 0.46s
sys: mean: 131.97s, stdev: 7.93s
throughput: mean: 379236.4 KB/s, stdev: 15912.26 KB/s
free time: mean: 10115572.2 usecs, stdev: 108318.35 usecs

VSS with this patch:
real: mean: 187.66s, stdev: 5.67s
user: mean: 46.5s, stdev: 0.16s
sys: mean: 125.3s, stdev: 5.58s
throughput: mean: 387506.4 KB/s, stdev: 12556.56 KB/s
free time: mean: 7029733.8 usecs, stdev: 124661.34 usecs

[1]: https://lore.kernel.org/linux-mm/CAMgjq7AQNGK-a=AOgvn4-V+zGO21QMbMTVbrYSW_R2oDSLoC+A@mail.gmail.com/

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |   6 +
 mm/internal.h              |  18 ++-
 mm/madvise.c               |   2 +-
 mm/memcontrol.c            |   2 +-
 mm/memory.c                |   8 +-
 mm/vswap.c                 | 294 ++++++++++++++++++-------------------
 6 files changed, 165 insertions(+), 165 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0651865a4564f..0f7f5489e1675 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -827,6 +827,7 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 	return memcg->id.id;
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
+void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
@@ -1289,6 +1290,11 @@ static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return NULL;
 }
 
+static inline void mem_cgroup_id_put_many(struct mem_cgroup *memcg,
+					  unsigned int n)
+{
+}
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
 {
diff --git a/mm/internal.h b/mm/internal.h
index cfe97501e4885..df991f601702c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -327,8 +327,6 @@ static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
 	return (swp_entry_t) { entry.val + n };
 }
 
-swp_entry_t swap_move(swp_entry_t entry, long delta);
-
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
  *	 forward or backward by delta
@@ -342,7 +340,7 @@ swp_entry_t swap_move(swp_entry_t entry, long delta);
 static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
 	softleaf_t entry = softleaf_from_pte(pte);
-	pte_t new = swp_entry_to_pte(swap_move(entry, delta));
+	pte_t new = swp_entry_to_pte(swap_nth(entry, delta));
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
@@ -372,6 +370,7 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  * @start_ptep: Page table pointer for the first entry.
  * @max_nr: The maximum number of table entries to consider.
  * @pte: Page table entry for the first entry.
+ * @free_batch: Whether the batch will be passed to free_swap_and_cache_nr().
  *
  * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
  * containing swap entries all with consecutive offsets and targeting the same
@@ -382,13 +381,15 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
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
@@ -408,7 +409,14 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
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
index 50be8066bebec..bfa25eaffa12a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3597,7 +3597,7 @@ void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
 	refcount_add(n, &memcg->id.ref);
 }
 
-static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
+void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
 {
 	if (refcount_sub_and_test(n, &memcg->id.ref)) {
 		mem_cgroup_id_remove(memcg);
diff --git a/mm/memory.c b/mm/memory.c
index a16bf84ebaaf9..59645ad238e22 100644
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
@@ -4491,7 +4491,7 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
 		return false;
 	entry = softleaf_from_pte(pte);
-	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
+	if (swap_pte_batch(ptep, nr_pages, pte, false) != nr_pages)
 		return false;
 
 	/*
@@ -4877,7 +4877,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		pte_t folio_pte = ptep_get(folio_ptep);
 
 		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
-		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
+		    swap_pte_batch(folio_ptep, nr, folio_pte, false) != nr)
 			goto out_nomap;
 
 		page_idx = idx;
@@ -4906,7 +4906,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_ptep = vmf->pte - idx;
 		folio_pte = ptep_get(folio_ptep);
 		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
-		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
+		    swap_pte_batch(folio_ptep, nr, folio_pte, false) != nr)
 			goto check_folio;
 
 		page_idx = idx;
diff --git a/mm/vswap.c b/mm/vswap.c
index 2a071d5ae173c..047c6476ef23c 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -481,18 +481,18 @@ static void vswap_cluster_free(struct vswap_cluster *cluster)
 	kvfree_rcu(cluster, rcu);
 }
 
-static inline void release_vswap_slot(struct vswap_cluster *cluster,
-		unsigned long index)
+static inline void release_vswap_slot_nr(struct vswap_cluster *cluster,
+		unsigned long index, int nr)
 {
 	unsigned long slot_index = VSWAP_IDX_WITHIN_CLUSTER_VAL(index);
 
 	VM_WARN_ON(!spin_is_locked(&cluster->lock));
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
@@ -505,7 +505,7 @@ static inline void release_vswap_slot(struct vswap_cluster *cluster,
 		}
 	}
 
-	atomic_dec(&vswap_used);
+	atomic_sub(nr, &vswap_used);
 }
 
 /*
@@ -527,23 +527,29 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 }
 
 /*
- * Caller needs to handle races with other operations themselves.
+ * release_backing - release the backend storage for a given range of virtual
+ * swap slots.
+ *
+ * Entered with the cluster locked, but might drop the lock in between.
+ * This is because several operations, such as releasing physical swap slots
+ * (i.e swap_slot_free_nr()) require the cluster to be unlocked to avoid
+ * deadlocks.
  *
- * Specifically, this function is safe to be called in contexts where the swap
- * entry has been added to the swap cache and the associated folio is locked.
- * We cannot race with other accessors, and the swap entry is guaranteed to be
- * valid the whole time (since swap cache implies one refcount).
+ * This is safe, because:
+ *
+ * 1. The swap entry to be freed has refcnt (swap count and swapcache pin)
+ *    down to 0, so no one can change its internal state
  *
- * We cannot assume that the backends will be of the same type,
- * contiguous, etc. We might have a large folio coalesced from subpages with
- * mixed backend, which is only rectified when it is reclaimed.
+ * 2. The swap entry to be freed still holds a refcnt to the cluster, keeping
+ *    the cluster itself valid.
+ *
+ * We will exit the function with the cluster re-locked.
  */
- static void release_backing(swp_entry_t entry, int nr)
+static void release_backing(struct vswap_cluster *cluster, swp_entry_t entry,
+		int nr)
 {
-	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
-	unsigned long phys_swap_released = 0;
 	unsigned int phys_swap_type = 0;
 	bool need_flushing_phys_swap = false;
 	swp_slot_t flush_slot;
@@ -551,9 +557,8 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 
 	VM_WARN_ON(!entry.val);
 
-	rcu_read_lock();
 	for (i = 0; i < nr; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 
 		/*
@@ -573,7 +578,6 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 		if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
 			zswap_entry_free(desc->zswap_entry);
 		} else if (desc->type == VSWAP_SWAPFILE) {
-			phys_swap_released++;
 			if (!phys_swap_start) {
 				/* start a new contiguous range of phys swap */
 				phys_swap_start = swp_slot_offset(desc->slot);
@@ -589,56 +593,49 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 
 		if (need_flushing_phys_swap) {
 			spin_unlock(&cluster->lock);
-			cluster = NULL;
 			swap_slot_free_nr(flush_slot, flush_nr);
+			mem_cgroup_uncharge_swap(entry, flush_nr);
+			spin_lock(&cluster->lock);
 			need_flushing_phys_swap = false;
 		}
 	}
-	if (cluster)
-		spin_unlock(&cluster->lock);
-	rcu_read_unlock();
 
 	/* Flush any remaining physical swap range */
 	if (phys_swap_start) {
 		flush_slot = swp_slot(phys_swap_type, phys_swap_start);
 		flush_nr = phys_swap_end - phys_swap_start;
+		spin_unlock(&cluster->lock);
 		swap_slot_free_nr(flush_slot, flush_nr);
+		mem_cgroup_uncharge_swap(entry, flush_nr);
+		spin_lock(&cluster->lock);
 	}
+}
 
-	if (phys_swap_released)
-		mem_cgroup_uncharge_swap(entry, phys_swap_released);
- }
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+		swp_entry_t entry, unsigned int nr_ents);
 
 /*
- * Entered with the cluster locked, but might unlock the cluster.
- * This is because several operations, such as releasing physical swap slots
- * (i.e swap_slot_free_nr()) require the cluster to be unlocked to avoid
- * deadlocks.
- *
- * This is safe, because:
- *
- * 1. The swap entry to be freed has refcnt (swap count and swapcache pin)
- *    down to 0, so no one can change its internal state
- *
- * 2. The swap entry to be freed still holds a refcnt to the cluster, keeping
- *    the cluster itself valid.
- *
- * We will exit the function with the cluster re-locked.
+ * Entered with the cluster locked. We will exit the function with the cluster
+ * still locked.
  */
-static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
-	swp_entry_t entry)
+static void vswap_free_nr(struct vswap_cluster *cluster, swp_entry_t entry,
+		int nr)
 {
-	/* Clear shadow if present */
-	if (xa_is_value(desc->shadow))
-		desc->shadow = NULL;
-	spin_unlock(&cluster->lock);
+	struct swp_desc *desc;
+	int i;
 
-	release_backing(entry, 1);
-	mem_cgroup_clear_swap(entry, 1);
+	for (i = 0; i < nr; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		/* Clear shadow if present */
+		if (xa_is_value(desc->shadow))
+			desc->shadow = NULL;
+	}
 
-	/* erase forward mapping and release the virtual slot for reallocation */
-	spin_lock(&cluster->lock);
-	release_vswap_slot(cluster, entry.val);
+	release_backing(cluster, entry, nr);
+	__vswap_swap_cgroup_clear(cluster, entry, nr);
+
+	/* erase forward mapping and release the virtual slots for reallocation */
+	release_vswap_slot_nr(cluster, entry.val, nr);
 }
 
 /**
@@ -820,18 +817,32 @@ static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	bool ret = false;
-	int i;
+	swp_entry_t free_start;
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
 		desc->swap_count--;
-		if (!desc->swap_count && !desc->in_swapcache)
-			vswap_free(cluster, desc, entry);
+		if (!desc->swap_count && !desc->in_swapcache) {
+			if (!free_nr++)
+				free_start = entry;
+		} else if (free_nr) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		entry.val++;
 	}
+	if (free_nr)
+		vswap_free_nr(cluster, free_start, free_nr);
 	if (cluster)
 		spin_unlock(&cluster->lock);
 	rcu_read_unlock();
@@ -954,19 +965,33 @@ void swapcache_clear(swp_entry_t entry, int nr)
 {
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
-	int i;
+	swp_entry_t free_start;
+	int i, free_nr = 0;
 
 	if (!nr)
 		return;
 
+	free_start.val = 0;
 	rcu_read_lock();
 	for (i = 0; i < nr; i++) {
+		/* flush pending free batch at cluster boundary */
+		if (free_nr && !VSWAP_IDX_WITHIN_CLUSTER_VAL(entry.val)) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		desc = vswap_iter(&cluster, entry.val);
 		desc->in_swapcache = false;
-		if (!desc->swap_count)
-			vswap_free(cluster, desc, entry);
+		if (!desc->swap_count) {
+			if (!free_nr++)
+				free_start = entry;
+		} else if (free_nr) {
+			vswap_free_nr(cluster, free_start, free_nr);
+			free_nr = 0;
+		}
 		entry.val++;
 	}
+	if (free_nr)
+		vswap_free_nr(cluster, free_start, free_nr);
 	if (cluster)
 		spin_unlock(&cluster->lock);
 	rcu_read_unlock();
@@ -1107,11 +1132,13 @@ void vswap_store_folio(swp_entry_t entry, struct folio *folio)
 	VM_BUG_ON(!folio_test_locked(folio));
 	VM_BUG_ON(folio->swap.val != entry.val);
 
-	release_backing(entry, nr);
-
 	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	release_backing(cluster, entry, nr);
+
 	for (i = 0; i < nr; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 		desc->type = VSWAP_FOLIO;
 		desc->swap_cache = folio;
@@ -1136,11 +1163,13 @@ void swap_zeromap_folio_set(struct folio *folio)
 	VM_BUG_ON(!folio_test_locked(folio));
 	VM_BUG_ON(!entry.val);
 
-	release_backing(entry, nr);
-
 	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	release_backing(cluster, entry, nr);
+
 	for (i = 0; i < nr; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 		desc->type = VSWAP_ZERO;
 	}
@@ -1261,89 +1290,6 @@ bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
 		(type == VSWAP_ZERO || type == VSWAP_SWAPFILE);
 }
 
-/**
- * swap_move - increment the swap slot by delta, checking the backing state and
- *             return 0 if the backing state does not match (i.e wrong backing
- *             state type, or wrong offset on the backing stores).
- * @entry: the original virtual swap slot.
- * @delta: the offset to increment the original slot.
- *
- * Note that this function is racy unless we can pin the backing state of these
- * swap slots down with swapcache_prepare().
- *
- * Caller should only rely on this function as a best-effort hint otherwise,
- * and should double-check after ensuring the whole range is pinned down.
- *
- * Return: the incremented virtual swap slot if the backing state matches, or
- *         0 if the backing state does not match.
- */
-swp_entry_t swap_move(swp_entry_t entry, long delta)
-{
-	struct vswap_cluster *cluster = NULL;
-	struct swp_desc *desc, *next_desc;
-	swp_entry_t next_entry;
-	struct folio *folio = NULL, *next_folio = NULL;
-	enum swap_type type, next_type;
-	swp_slot_t slot = {0}, next_slot = {0};
-
-	next_entry.val = entry.val + delta;
-
-	rcu_read_lock();
-
-	/* Look up first descriptor and get its type and backing store */
-	desc = vswap_iter(&cluster, entry.val);
-	if (!desc) {
-		rcu_read_unlock();
-		return (swp_entry_t){0};
-	}
-
-	type = desc->type;
-	if (type == VSWAP_ZSWAP) {
-		/* zswap not supported for move */
-		spin_unlock(&cluster->lock);
-		rcu_read_unlock();
-		return (swp_entry_t){0};
-	}
-	if (type == VSWAP_FOLIO)
-		folio = desc->swap_cache;
-	else if (type == VSWAP_SWAPFILE)
-		slot = desc->slot;
-
-	/* Look up second descriptor and get its type and backing store */
-	next_desc = vswap_iter(&cluster, next_entry.val);
-	if (!next_desc) {
-		rcu_read_unlock();
-		return (swp_entry_t){0};
-	}
-
-	next_type = next_desc->type;
-	if (next_type == VSWAP_FOLIO)
-		next_folio = next_desc->swap_cache;
-	else if (next_type == VSWAP_SWAPFILE)
-		next_slot = next_desc->slot;
-
-	if (cluster)
-		spin_unlock(&cluster->lock);
-
-	rcu_read_unlock();
-
-	/* Check if types match */
-	if (next_type != type)
-		return (swp_entry_t){0};
-
-	/* Check backing state consistency */
-	if (type == VSWAP_SWAPFILE &&
-			(swp_slot_type(next_slot) != swp_slot_type(slot) ||
-				swp_slot_offset(next_slot) !=
-							swp_slot_offset(slot) + delta))
-		return (swp_entry_t){0};
-
-	if (type == VSWAP_FOLIO && next_folio != folio)
-		return (swp_entry_t){0};
-
-	return next_entry;
-}
-
 /*
  * Return the count of contiguous swap entries that share the same
  * VSWAP_ZERO status as the starting entry. If is_zeromap is not NULL,
@@ -1863,11 +1809,10 @@ void zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 
-	release_backing(swpentry, 1);
-
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, swpentry.val);
 	VM_WARN_ON(!desc);
+	release_backing(cluster, swpentry, 1);
 	desc->zswap_entry = entry;
 	desc->type = VSWAP_ZSWAP;
 	spin_unlock(&cluster->lock);
@@ -1914,17 +1859,22 @@ bool zswap_empty(swp_entry_t swpentry)
 #endif /* CONFIG_ZSWAP */
 
 #ifdef CONFIG_MEMCG
-static unsigned short vswap_cgroup_record(swp_entry_t entry,
-				unsigned short memcgid, unsigned int nr_ents)
+/*
+ * __vswap_cgroup_record - record mem_cgroup for a set of swap entries
+ *
+ * Entered with the cluster locked. We will exit the function with the cluster
+ * still locked.
+ */
+static unsigned short __vswap_cgroup_record(struct vswap_cluster *cluster,
+				swp_entry_t entry, unsigned short memcgid,
+				unsigned int nr_ents)
 {
-	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	unsigned short oldid, iter = 0;
 	int i;
 
-	rcu_read_lock();
 	for (i = 0; i < nr_ents; i++) {
-		desc = vswap_iter(&cluster, entry.val + i);
+		desc = __vswap_iter(cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 		oldid = desc->memcgid;
 		desc->memcgid = memcgid;
@@ -1932,6 +1882,37 @@ static unsigned short vswap_cgroup_record(swp_entry_t entry,
 			iter = oldid;
 		VM_WARN_ON(iter != oldid);
 	}
+
+	return oldid;
+}
+
+/*
+ * Clear swap cgroup for a range of swap entries.
+ * Entered with the cluster locked. Caller must be under rcu_read_lock().
+ */
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+				      swp_entry_t entry, unsigned int nr_ents)
+{
+	unsigned short id;
+	struct mem_cgroup *memcg;
+
+	id = __vswap_cgroup_record(cluster, entry, 0, nr_ents);
+	memcg = mem_cgroup_from_id(id);
+	if (memcg)
+		mem_cgroup_id_put_many(memcg, nr_ents);
+}
+
+static unsigned short vswap_cgroup_record(swp_entry_t entry,
+				unsigned short memcgid, unsigned int nr_ents)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	unsigned short oldid;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	oldid = __vswap_cgroup_record(cluster, entry, memcgid, nr_ents);
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
 
@@ -1999,6 +1980,11 @@ unsigned short lookup_swap_cgroup_id(swp_entry_t entry)
 	rcu_read_unlock();
 	return ret;
 }
+#else /* !CONFIG_MEMCG */
+static void __vswap_swap_cgroup_clear(struct vswap_cluster *cluster,
+				      swp_entry_t entry, unsigned int nr_ents)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 int vswap_init(void)
-- 
2.47.3


