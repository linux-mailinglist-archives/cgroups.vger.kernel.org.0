Return-Path: <cgroups+bounces-14894-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yECWM+Qnu2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14894-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:32:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE82C36AF
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA8AF305B356
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378B239E192;
	Wed, 18 Mar 2026 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow8htcHO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7CC393DF7
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873024; cv=none; b=EaCQLQKr2GW6ED9wgxw1+IfRdvbiU8DfHato38MbnNcnQRKaCGFn63KrUA/T2Q0LgagqjMbb+fT0grAWozuNSjpAjl80C3T31KxeU8iVHaAINUxggjfyRMVKiv0ixVRYDLqcerxWQT1srIaOMCphLzV0L1fUwZH3X0fPr1Cng+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873024; c=relaxed/simple;
	bh=6kQ1Brr/qgB7F4jDhKZpbjlhl/qr7JOSifthmprYrSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryEEawh5Mqosi6iCOYyYYUYlH9yArk0DoyLqF5syI7WatFpbn/FcuRbQUlHjhga0K+BfO8yCgfHKvFd4tOgGotHOKUZYwHwJGpUXoE4hYNxnh/HAHNTINo5x1XUiGz8JIcTDvTABCjAdLe2jIXN9fw2OodizJshvH8ecRS/XzAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ow8htcHO; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d55b97f358so226604a34.3
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873017; x=1774477817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziYceeYuRYJp984CpyaaNBYYVrUBLDaz+CkymQwPz+w=;
        b=Ow8htcHO/EdDWgqSBmZ4Sz0l4pYRinPdcIx89NzdQxraUv+YnRCjTMO2TItA8ciFSD
         tBuU8RVGykSM5EH/QFobmZYmbRJTGQbDwvRdVYvtoR0B2FKRr8dAY3fBCP7+8IXArqZ1
         RPVLp/SZMdWE8e9KL+aBsT6w9i0bzQR6N8e5HHf1i51SBLByAep9kYBS9/658Q9sHXEr
         oralDbOfLDi51+lIwZwocNrAjx1wLDNjv4cB4NQLRijy0B4yYNgYwuW3MX9/hm3aZk1V
         nwqS/Eng782gTHEng7/a0L5X23cSlcrluM7IaoVsQsRCVtrogeKa2aTbT7cZyWqznaX+
         1F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873017; x=1774477817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ziYceeYuRYJp984CpyaaNBYYVrUBLDaz+CkymQwPz+w=;
        b=RiYJX9YlbWsyA94D6aVin7G0FlMyesoM9WAEEhJmhhlFwEkDd4ru03/TQwBylwmeVg
         OLm0Bf1BlyWqS1suHmAFyP7DW6JntcP+kZPt6yPwgEWP0tXu9uwz7WNISaGog3neUZxv
         GkHdgmx6WdaoibKwCqCA2YQP3XaZs6fenc9hvvLQZ7xucH/VZPqpZBzZaiyGYAwziazo
         hTOXa1moU/nNeZ8ZWturLTjTwaMkAnS8Lj8ytjTQKK6TcFRZ/anx7h2i6kWaLlcCwzcH
         CSR7VcfOejnOJ7X9jocipEYR4/CbqZyYbqvrRYIlx91STvl6yY1m2PE/bOzoqKx+9ymh
         8nvw==
X-Forwarded-Encrypted: i=1; AJvYcCWhK35rnBR7vV/YCQn3QO8tizantTnCaAQuMJZJY/uqQ5VGg/BrBM1Vc9fiSc3BohnH+f9cJzFy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyok4M/FsDUruEglwTHobh7b2gyQnsZeHvFFt8jHsegUaySg32x
	PiDjDbA8dZXPBvYTHqVup3+n52iF6nuXobPeHJgn/G5Dpf8UjdfVDwZ+
X-Gm-Gg: ATEYQzyb+mTlu7vZSRYYlKQ3NgP+C5LYDpifMlHvRUszeWawrmEsuxEG0/VuQG1nFuX
	3TymCDMpqPr4n7VnErStrHcK5WL4ds3jBaacDSuzp/r1kT2i7mMz0VWW+vDWi3DebGgZMIU/IHO
	ecMi6j4JmEZ5Pz7i7JGxTB+tWWxa3llN7QAWnp5JMJOTlPCOTgIUG2ntpwDC4WBBcKSlPTz156g
	EaIo9rgDJ9C+ADbHige1Hb+JdWmGWizVF1dFMsW2bChExfHE6bODstMDAIFfUJKrIXfZEJYdUKm
	gX7HCjGA5PyRCJvxtL3KJSYRqqXE0X4EZsajYYFt6JGvvkek6iaSifui27TF+71P1Ht/TVSGhph
	1qpzQEF2ECIepi3x1tSeJLumXwzs+h6SA7CBb8RR35STI9TK9/PdmfDZa6XFFBdTYn4q2h1kWvB
	hXa5aEP9p3HgQoRTqgG6McIg6v1AqP7ox0p46TvJ1RLS4Ddw==
X-Received: by 2002:a05:6830:2109:b0:7d7:4ff4:c1b5 with SMTP id 46e09a7af769-7d7ca62dcbdmr3290098a34.9.1773873016435;
        Wed, 18 Mar 2026 15:30:16 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:50::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b3809fsm3032734a34.14.2026.03.18.15.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:15 -0700 (PDT)
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
Subject: [PATCH v4 13/21] swap: manage swap entry lifecycle at the virtual swap layer
Date: Wed, 18 Mar 2026 15:29:44 -0700
Message-ID: <20260318222953.441758-14-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
References: <20260318222953.441758-1-nphamcs@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-14894-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.884];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28FE82C36AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch moves the swap entry lifecycle management to the virtual swap
layer by adding to the swap descriptor two fields:

1. in_swapcache, i.e whether the swap entry is in swap cache (or about
   to be added).
2. The swap count of the swap entry, which counts the number of page
   table entries at which the swap entry is inserted.

and re-implementing all of the swap entry lifecycle API
(swap_duplicate(), swap_free_nr(), swapcache_prepare(), etc.) in the
virtual swap layer.

For now, we do not implement swap count continuation - the swap_count
field in the swap descriptor is big enough to hold the maximum number of
swap counts. This vastly simplifies the logic.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h  |  30 +-
 include/linux/zswap.h |   5 +-
 mm/memory.c           |   8 +-
 mm/shmem.c            |   4 +-
 mm/swap.h             |  58 ++--
 mm/swap_state.c       |   4 +-
 mm/swapfile.c         | 786 ++----------------------------------------
 mm/vswap.c            | 452 ++++++++++++++++++++++--
 mm/zswap.c            |  14 +-
 9 files changed, 503 insertions(+), 858 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 940f467f2af17..17218fe917fc3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -223,17 +223,9 @@ enum {
 #define SWAP_CLUSTER_MAX_SKIPPED (SWAP_CLUSTER_MAX << 10)
 #define COMPACT_CLUSTER_MAX SWAP_CLUSTER_MAX
 
-/* Bit flag in swap_map */
-#define SWAP_HAS_CACHE	0x40	/* Flag page is cached, in first swap_map */
-#define COUNT_CONTINUED	0x80	/* Flag swap_map continuation for full count */
-
-/* Special value in first swap_map */
-#define SWAP_MAP_MAX	0x3e	/* Max count */
-#define SWAP_MAP_BAD	0x3f	/* Note page is bad */
-#define SWAP_MAP_SHMEM	0xbf	/* Owned by shmem/tmpfs */
-
-/* Special value in each swap_map continuation */
-#define SWAP_CONT_MAX	0x7f	/* Max count */
+/* Swapfile's swap map state*/
+#define SWAP_MAP_ALLOCATED	0x01	/* Page is allocated */
+#define SWAP_MAP_BAD	0x02	/* Page is bad */
 
 /*
  * The first page in the swap file is the swap header, which is always marked
@@ -426,13 +418,13 @@ extern void __meminit kswapd_stop(int nid);
 /* Virtual swap space API (mm/vswap.c) */
 int vswap_init(void);
 void vswap_exit(void);
-void vswap_free(swp_entry_t entry, struct swap_cluster_info *ci);
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
 bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si);
 void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si);
 
-/* Lifecycle swap API (mm/swapfile.c) */
+
+/* Lifecycle swap API (mm/swapfile.c and mm/vswap.c) */
 int folio_alloc_swap(struct folio *folio);
 bool folio_free_swap(struct folio *folio);
 void put_swap_folio(struct folio *folio, swp_entry_t entry);
@@ -442,9 +434,10 @@ int swapcache_prepare(swp_entry_t entry, int nr);
 void swap_free_nr(swp_entry_t entry, int nr_pages);
 void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int __swap_count(swp_entry_t entry);
-bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
+bool swap_entry_swapped(swp_entry_t entry);
 int swp_swapcount(swp_entry_t entry);
 bool is_swap_cached(swp_entry_t entry);
+bool folio_swapped(struct folio *folio);
 
 /* Swap cache API (mm/swap_state.c) */
 static inline unsigned long total_swapcache_pages(void)
@@ -452,6 +445,7 @@ static inline unsigned long total_swapcache_pages(void)
 	return global_node_page_state(NR_SWAPCACHE);
 }
 
+bool vswap_only_has_cache(swp_entry_t entry, int nr);
 void free_folio_and_swap_cache(struct folio *folio);
 void free_pages_and_swap_cache(struct encoded_page **, int);
 void free_swap_cache(struct folio *folio);
@@ -482,7 +476,6 @@ static inline long get_nr_swap_pages(void)
 void si_swapinfo(struct sysinfo *);
 int swap_slot_alloc(swp_slot_t *slot, unsigned int order);
 swp_slot_t swap_slot_alloc_of_type(int);
-int add_swap_count_continuation(swp_entry_t, gfp_t);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
 unsigned int count_swap_pages(int, int);
@@ -549,11 +542,6 @@ static inline void free_swap_cache(struct folio *folio)
 {
 }
 
-static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
-{
-	return 0;
-}
-
 static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
 {
 }
@@ -581,7 +569,7 @@ static inline int __swap_count(swp_entry_t entry)
 	return 0;
 }
 
-static inline bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
+static inline bool swap_entry_swapped(swp_entry_t entry)
 {
 	return false;
 }
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 7eb3ce7e124fc..07b2936c38f29 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -28,7 +28,6 @@ struct zswap_lruvec_state {
 unsigned long zswap_total_pages(void);
 bool zswap_store(struct folio *folio);
 int zswap_load(struct folio *folio);
-void zswap_invalidate(swp_entry_t swp);
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
@@ -38,6 +37,7 @@ void *zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry);
 void *zswap_entry_load(swp_entry_t swpentry);
 void *zswap_entry_erase(swp_entry_t swpentry);
 bool zswap_empty(swp_entry_t swpentry);
+void zswap_entry_free(struct zswap_entry *entry);
 
 #else
 
@@ -53,7 +53,6 @@ static inline int zswap_load(struct folio *folio)
 	return -ENOENT;
 }
 
-static inline void zswap_invalidate(swp_entry_t swp) {}
 static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
 static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
 static inline void zswap_folio_swapin(struct folio *folio) {}
@@ -68,6 +67,8 @@ static inline bool zswap_never_enabled(void)
 	return true;
 }
 
+static inline void zswap_entry_free(struct zswap_entry *entry) {}
+
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/memory.c b/mm/memory.c
index 90031f833f52e..641e3f65edc00 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1333,10 +1333,6 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 
 	if (ret == -EIO) {
 		VM_WARN_ON_ONCE(!entry.val);
-		if (add_swap_count_continuation(entry, GFP_KERNEL) < 0) {
-			ret = -ENOMEM;
-			goto out;
-		}
 		entry.val = 0;
 	} else if (ret == -EBUSY || unlikely(ret == -EHWPOISON)) {
 		goto out;
@@ -5044,7 +5040,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
 	/* Clear the swap cache pin for direct swapin after PTL unlock */
 	if (need_clear_cache) {
-		swapcache_clear(si, entry, nr_pages);
+		swapcache_clear(entry, nr_pages);
 		if (waitqueue_active(&swapcache_wq))
 			wake_up(&swapcache_wq);
 	}
@@ -5063,7 +5059,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		folio_put(swapcache);
 	}
 	if (need_clear_cache) {
-		swapcache_clear(si, entry, nr_pages);
+		swapcache_clear(entry, nr_pages);
 		if (waitqueue_active(&swapcache_wq))
 			wake_up(&swapcache_wq);
 	}
diff --git a/mm/shmem.c b/mm/shmem.c
index 66cf8af6779ca..780571c830e5b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2442,7 +2442,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 
 	if (skip_swapcache) {
 		folio->swap.val = 0;
-		swapcache_clear(si, swap, nr_pages);
+		swapcache_clear(swap, nr_pages);
 	} else {
 		swap_cache_del_folio(folio);
 	}
@@ -2463,7 +2463,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		folio_unlock(folio);
 failed_nolock:
 	if (skip_swapcache)
-		swapcache_clear(si, folio->swap, folio_nr_pages(folio));
+		swapcache_clear(folio->swap, folio_nr_pages(folio));
 	if (folio)
 		folio_put(folio);
 	put_swap_entry(swap, si);
diff --git a/mm/swap.h b/mm/swap.h
index 7618b77bbb85f..4109b1caa59a6 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -211,6 +211,8 @@ void swap_cache_lock_irq(swp_entry_t entry);
 void swap_cache_unlock_irq(swp_entry_t entry);
 void swap_cache_lock(swp_entry_t entry);
 void swap_cache_unlock(swp_entry_t entry);
+void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
+			   unsigned long vswap, int nr);
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
@@ -245,6 +247,31 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
 	return folio_entry.val == round_down(entry.val, nr_pages);
 }
 
+/**
+ * folio_matches_swap_slot - Check if a folio matches both the virtual
+ *                           swap entry and its backing physical swap slot.
+ * @folio: The folio.
+ * @entry: The virtual swap entry to check against.
+ * @slot: The physical swap slot to check against.
+ *
+ * Context: The caller should have the folio locked to ensure it's stable
+ * and nothing will move it in or out of the swap cache.
+ * Return: true if both checks pass, false otherwise.
+ */
+static inline bool folio_matches_swap_slot(const struct folio *folio,
+					   swp_entry_t entry,
+					   swp_slot_t slot)
+{
+	if (!folio_matches_swap_entry(folio, entry))
+		return false;
+
+	/*
+	 * Confirm the virtual swap entry is still backed by the same
+	 * physical swap slot.
+	 */
+	return slot.val == swp_entry_to_swp_slot(entry).val;
+}
+
 /*
  * All swap cache helpers below require the caller to ensure the swap entries
  * used are valid and stablize the device by any of the following ways:
@@ -266,7 +293,7 @@ void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow
 void __swap_cache_replace_folio(struct folio *old, struct folio *new);
 
 void show_swap_cache_info(void);
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
+void swapcache_clear(swp_entry_t entry, int nr);
 struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct vm_area_struct *vma, unsigned long addr,
 		struct swap_iocb **plug);
@@ -313,25 +340,7 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 		return find_next_bit(sis->zeromap, end, start) - start;
 }
 
-static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *si = __swap_slot_to_info(slot);
-	pgoff_t offset = swp_slot_offset(slot);
-	int i;
-
-	/*
-	 * While allocating a large folio and doing mTHP swapin, we need to
-	 * ensure all entries are not cached, otherwise, the mTHP folio will
-	 * be in conflict with the folio in swap cache.
-	 */
-	for (i = 0; i < max_nr; i++) {
-		if ((si->swap_map[offset + i] & SWAP_HAS_CACHE))
-			return i;
-	}
-
-	return i;
-}
+int non_swapcache_batch(swp_entry_t entry, int max_nr);
 
 #else /* CONFIG_SWAP */
 struct swap_iocb;
@@ -383,6 +392,13 @@ static inline bool folio_matches_swap_entry(const struct folio *folio, swp_entry
 	return false;
 }
 
+static inline bool folio_matches_swap_slot(const struct folio *folio,
+					   swp_entry_t entry,
+					   swp_slot_t slot)
+{
+	return false;
+}
+
 static inline void show_swap_cache_info(void)
 {
 }
@@ -410,7 +426,7 @@ static inline int swap_writeout(struct folio *folio,
 	return 0;
 }
 
-static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
+static inline void swapcache_clear(swp_entry_t entry, int nr)
 {
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 00fa3e76a5c19..1827527e88d33 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -174,8 +174,6 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists)
 {
-	struct swap_info_struct *si =
-		__swap_slot_to_info(swp_entry_to_swp_slot(entry));
 	struct folio *folio;
 	struct folio *new_folio = NULL;
 	struct folio *result = NULL;
@@ -196,7 +194,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		/*
 		 * Just skip read ahead for unused swap slot.
 		 */
-		if (!swap_entry_swapped(si, entry))
+		if (!swap_entry_swapped(entry))
 			goto put_and_return;
 
 		/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index adfcce286258f..ab1ae81b4e0cc 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -50,9 +50,6 @@
 #include "internal.h"
 #include "swap.h"
 
-static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
-				 unsigned char);
-static void free_swap_count_continuations(struct swap_info_struct *);
 static void swap_slots_free(struct swap_info_struct *si,
 			      struct swap_cluster_info *ci,
 			      swp_slot_t slot, unsigned int nr_pages);
@@ -146,7 +143,7 @@ static struct swap_info_struct *swap_slot_to_info(swp_slot_t slot)
 
 static inline unsigned char swap_count(unsigned char ent)
 {
-	return ent & ~SWAP_HAS_CACHE;	/* may include COUNT_CONTINUED flag */
+	return ent;
 }
 
 /*
@@ -182,52 +179,14 @@ static long swap_usage_in_pages(struct swap_info_struct *si)
 static bool swap_only_has_cache(struct swap_info_struct *si,
 			      unsigned long offset, int nr_pages)
 {
-	unsigned char *map = si->swap_map + offset;
-	unsigned char *map_end = map + nr_pages;
-
-	do {
-		VM_BUG_ON(!(*map & SWAP_HAS_CACHE));
-		if (*map != SWAP_HAS_CACHE)
-			return false;
-	} while (++map < map_end);
+	swp_entry_t entry = swp_slot_to_swp_entry(swp_slot(si->type, offset));
 
-	return true;
+	return vswap_only_has_cache(entry, nr_pages);
 }
 
-/**
- * is_swap_cached - check if the swap entry is cached
- * @entry: swap entry to check
- *
- * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
- *
- * Returns true if the swap entry is cached, false otherwise.
- */
-bool is_swap_cached(swp_entry_t entry)
+static bool swap_cache_only(struct swap_info_struct *si, unsigned long offset)
 {
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *si = swap_slot_to_info(slot);
-	unsigned long offset = swp_slot_offset(slot);
-
-	return READ_ONCE(si->swap_map[offset]) & SWAP_HAS_CACHE;
-}
-
-static bool swap_is_last_map(struct swap_info_struct *si,
-		unsigned long offset, int nr_pages, bool *has_cache)
-{
-	unsigned char *map = si->swap_map + offset;
-	unsigned char *map_end = map + nr_pages;
-	unsigned char count = *map;
-
-	if (swap_count(count) != 1 && swap_count(count) != SWAP_MAP_SHMEM)
-		return false;
-
-	while (++map < map_end) {
-		if (*map != count)
-			return false;
-	}
-
-	*has_cache = !!(count & SWAP_HAS_CACHE);
-	return true;
+	return swap_only_has_cache(si, offset, 1);
 }
 
 /*
@@ -238,15 +197,15 @@ static bool swap_is_last_map(struct swap_info_struct *si,
 static int __try_to_reclaim_swap(struct swap_info_struct *si,
 				 unsigned long offset, unsigned long flags)
 {
-	const swp_entry_t entry =
-		swp_slot_to_swp_entry(swp_slot(si->type, offset));
-	swp_slot_t slot;
+	const swp_slot_t slot = swp_slot(si->type, offset);
+	swp_entry_t entry;
 	struct swap_cluster_info *ci;
 	struct folio *folio;
 	int ret, nr_pages;
 	bool need_reclaim;
 
 again:
+	entry = swp_slot_to_swp_entry(slot);
 	folio = swap_cache_get_folio(entry);
 	if (!folio)
 		return 0;
@@ -266,14 +225,15 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 	/*
 	 * Offset could point to the middle of a large folio, or folio
 	 * may no longer point to the expected offset before it's locked.
+	 * Additionally, the virtual swap entry may no longer be backed
+	 * by the same physical swap slot.
 	 */
-	if (!folio_matches_swap_entry(folio, entry)) {
+	if (!folio_matches_swap_slot(folio, entry, slot)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		goto again;
 	}
-	slot = swp_entry_to_swp_slot(folio->swap);
-	offset = swp_slot_offset(slot);
+	offset = swp_slot_offset(swp_entry_to_swp_slot(folio->swap));
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
@@ -283,8 +243,7 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 
 	/*
 	 * It's safe to delete the folio from swap cache only if the folio's
-	 * swap_map is HAS_CACHE only, which means the slots have no page table
-	 * reference or pending writeback, and can't be allocated to others.
+	 * swap slots have no page table reference or pending writeback.
 	 */
 	ci = swap_cluster_lock(si, offset);
 	need_reclaim = swap_only_has_cache(si, offset, nr_pages);
@@ -811,7 +770,7 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 		case 0:
 			offset++;
 			break;
-		case SWAP_HAS_CACHE:
+		case SWAP_MAP_ALLOCATED:
 			nr_reclaim = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
 			if (nr_reclaim > 0)
 				offset += nr_reclaim;
@@ -842,22 +801,23 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 {
 	unsigned long offset, end = start + nr_pages;
 	unsigned char *map = si->swap_map;
+	unsigned char count;
 
 	if (cluster_is_empty(ci))
 		return true;
 
 	for (offset = start; offset < end; offset++) {
-		switch (READ_ONCE(map[offset])) {
-		case 0:
+		count = READ_ONCE(map[offset]);
+		if (!count)
 			continue;
-		case SWAP_HAS_CACHE:
+
+		if (swap_cache_only(si, offset)) {
 			if (!vm_swap_full())
 				return false;
 			*need_reclaim = true;
 			continue;
-		default:
-			return false;
 		}
+		return false;
 	}
 
 	return true;
@@ -974,7 +934,6 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 	long to_scan = 1;
 	unsigned long offset, end;
 	struct swap_cluster_info *ci;
-	unsigned char *map = si->swap_map;
 	int nr_reclaim;
 
 	if (force)
@@ -986,7 +945,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 		to_scan--;
 
 		while (offset < end) {
-			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
+			if (swap_cache_only(si, offset)) {
 				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
 								   TTRS_ANYWAY);
@@ -1320,7 +1279,8 @@ static bool swap_alloc_fast(swp_slot_t *slot, int order)
 	if (cluster_is_usable(ci, order)) {
 		if (cluster_is_empty(ci))
 			offset = cluster_offset(si, ci);
-		found = alloc_swap_scan_cluster(si, ci, offset, order, SWAP_HAS_CACHE);
+		found = alloc_swap_scan_cluster(si, ci, offset, order,
+			SWAP_MAP_ALLOCATED);
 		if (found)
 			*slot = swp_slot(si->type, found);
 	} else {
@@ -1344,7 +1304,7 @@ static void swap_alloc_slow(swp_slot_t *slot, int order)
 		plist_requeue(&si->avail_list, &swap_avail_head);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			offset = cluster_alloc_swap_slot(si, order, SWAP_HAS_CACHE);
+			offset = cluster_alloc_swap_slot(si, order, SWAP_MAP_ALLOCATED);
 			swap_slot_put_swap_info(si);
 			if (offset) {
 				*slot = swp_slot(si->type, offset);
@@ -1474,48 +1434,6 @@ static struct swap_info_struct *_swap_info_get(swp_slot_t slot)
 	return NULL;
 }
 
-static unsigned char swap_slot_put_locked(struct swap_info_struct *si,
-					   struct swap_cluster_info *ci,
-					   swp_slot_t slot,
-					   unsigned char usage)
-{
-	unsigned long offset = swp_slot_offset(slot);
-	unsigned char count;
-	unsigned char has_cache;
-
-	count = si->swap_map[offset];
-
-	has_cache = count & SWAP_HAS_CACHE;
-	count &= ~SWAP_HAS_CACHE;
-
-	if (usage == SWAP_HAS_CACHE) {
-		VM_BUG_ON(!has_cache);
-		has_cache = 0;
-	} else if (count == SWAP_MAP_SHMEM) {
-		/*
-		 * Or we could insist on shmem.c using a special
-		 * swap_shmem_free() and free_shmem_swap_and_cache()...
-		 */
-		count = 0;
-	} else if ((count & ~COUNT_CONTINUED) <= SWAP_MAP_MAX) {
-		if (count == COUNT_CONTINUED) {
-			if (swap_count_continued(si, offset, count))
-				count = SWAP_MAP_MAX | COUNT_CONTINUED;
-			else
-				count = SWAP_MAP_MAX;
-		} else
-			count--;
-	}
-
-	usage = count | has_cache;
-	if (usage)
-		WRITE_ONCE(si->swap_map[offset], usage);
-	else
-		swap_slots_free(si, ci, slot, 1);
-
-	return usage;
-}
-
 /*
  * When we get a swap entry, if there aren't some other ways to
  * prevent swapoff, such as the folio in swap cache is locked, RCU
@@ -1583,94 +1501,23 @@ struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot)
 	return NULL;
 }
 
-static void swap_slots_put_cache(struct swap_info_struct *si,
-				   swp_slot_t slot, int nr)
-{
-	unsigned long offset = swp_slot_offset(slot);
-	struct swap_cluster_info *ci;
-
-	ci = swap_cluster_lock(si, offset);
-	if (swap_only_has_cache(si, offset, nr)) {
-		swap_slots_free(si, ci, slot, nr);
-	} else {
-		for (int i = 0; i < nr; i++, slot.val++)
-			swap_slot_put_locked(si, ci, slot, SWAP_HAS_CACHE);
-	}
-	swap_cluster_unlock(ci);
-}
-
 static bool swap_slots_put_map(struct swap_info_struct *si,
 				 swp_slot_t slot, int nr)
 {
 	unsigned long offset = swp_slot_offset(slot);
 	struct swap_cluster_info *ci;
-	bool has_cache = false;
-	unsigned char count;
-	int i;
-
-	if (nr <= 1)
-		goto fallback;
-	count = swap_count(data_race(si->swap_map[offset]));
-	if (count != 1 && count != SWAP_MAP_SHMEM)
-		goto fallback;
 
 	ci = swap_cluster_lock(si, offset);
-	if (!swap_is_last_map(si, offset, nr, &has_cache)) {
-		goto locked_fallback;
-	}
-	if (!has_cache)
-		swap_slots_free(si, ci, slot, nr);
-	else
-		for (i = 0; i < nr; i++)
-			WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
+	vswap_rmap_set(ci, slot, 0, nr);
+	swap_slots_free(si, ci, slot, nr);
 	swap_cluster_unlock(ci);
 
-	return has_cache;
-
-fallback:
-	ci = swap_cluster_lock(si, offset);
-locked_fallback:
-	for (i = 0; i < nr; i++, slot.val++) {
-		count = swap_slot_put_locked(si, ci, slot, 1);
-		if (count == SWAP_HAS_CACHE)
-			has_cache = true;
-	}
-	swap_cluster_unlock(ci);
-	return has_cache;
-}
-
-/*
- * Only functions with "_nr" suffix are able to free entries spanning
- * cross multi clusters, so ensure the range is within a single cluster
- * when freeing entries with functions without "_nr" suffix.
- */
-static bool swap_slots_put_map_nr(struct swap_info_struct *si,
-				    swp_slot_t slot, int nr)
-{
-	int cluster_nr, cluster_rest;
-	unsigned long offset = swp_slot_offset(slot);
-	bool has_cache = false;
-
-	cluster_rest = SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER;
-	while (nr) {
-		cluster_nr = min(nr, cluster_rest);
-		has_cache |= swap_slots_put_map(si, slot, cluster_nr);
-		cluster_rest = SWAPFILE_CLUSTER;
-		nr -= cluster_nr;
-		slot.val += cluster_nr;
-	}
-
-	return has_cache;
+	return true;
 }
 
-/*
- * Check if it's the last ref of swap entry in the freeing path.
- * Qualified value includes 1, SWAP_HAS_CACHE or SWAP_MAP_SHMEM.
- */
 static inline bool __maybe_unused swap_is_last_ref(unsigned char count)
 {
-	return (count == SWAP_HAS_CACHE) || (count == 1) ||
-	       (count == SWAP_MAP_SHMEM);
+	return count == SWAP_MAP_ALLOCATED;
 }
 
 /*
@@ -1684,14 +1531,6 @@ static void swap_slots_free(struct swap_info_struct *si,
 	unsigned long offset = swp_slot_offset(slot);
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
-	swp_entry_t entry = swp_slot_to_swp_entry(slot);
-	int i;
-
-	/* release all the associated (virtual) swap slots */
-	for (i = 0; i < nr_pages; i++) {
-		vswap_free(entry, ci);
-		entry.val++;
-	}
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != __swap_offset_to_cluster(si, offset + nr_pages - 1));
@@ -1734,149 +1573,6 @@ void swap_slot_free_nr(swp_slot_t slot, int nr_pages)
 	}
 }
 
-/*
- * Caller has made sure that the swap device corresponding to entry
- * is still around or has not been recycled.
- */
-void swap_free_nr(swp_entry_t entry, int nr_pages)
-{
-	swap_slot_free_nr(swp_entry_to_swp_slot(entry), nr_pages);
-}
-
-/*
- * Called after dropping swapcache to decrease refcnt to swap entries.
- */
-void put_swap_folio(struct folio *folio, swp_entry_t entry)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *si;
-	int size = 1 << swap_slot_order(folio_order(folio));
-
-	si = _swap_info_get(slot);
-	if (!si)
-		return;
-
-	swap_slots_put_cache(si, slot, size);
-}
-
-int __swap_count(swp_entry_t entry)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *si = __swap_slot_to_info(slot);
-	pgoff_t offset = swp_slot_offset(slot);
-
-	return swap_count(si->swap_map[offset]);
-}
-
-/*
- * How many references to @entry are currently swapped out?
- * This does not give an exact answer when swap count is continued,
- * but does include the high COUNT_CONTINUED flag to allow for that.
- */
-bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	pgoff_t offset = swp_slot_offset(slot);
-	struct swap_cluster_info *ci;
-	int count;
-
-	ci = swap_cluster_lock(si, offset);
-	count = swap_count(si->swap_map[offset]);
-	swap_cluster_unlock(ci);
-	return !!count;
-}
-
-/*
- * How many references to @entry are currently swapped out?
- * This considers COUNT_CONTINUED so it returns exact answer.
- */
-int swp_swapcount(swp_entry_t entry)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	int count, tmp_count, n;
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	struct page *page;
-	pgoff_t offset;
-	unsigned char *map;
-
-	si = _swap_info_get(slot);
-	if (!si)
-		return 0;
-
-	offset = swp_slot_offset(slot);
-
-	ci = swap_cluster_lock(si, offset);
-
-	count = swap_count(si->swap_map[offset]);
-	if (!(count & COUNT_CONTINUED))
-		goto out;
-
-	count &= ~COUNT_CONTINUED;
-	n = SWAP_MAP_MAX + 1;
-
-	page = vmalloc_to_page(si->swap_map + offset);
-	offset &= ~PAGE_MASK;
-	VM_BUG_ON(page_private(page) != SWP_CONTINUED);
-
-	do {
-		page = list_next_entry(page, lru);
-		map = kmap_local_page(page);
-		tmp_count = map[offset];
-		kunmap_local(map);
-
-		count += (tmp_count & ~COUNT_CONTINUED) * n;
-		n *= (SWAP_CONT_MAX + 1);
-	} while (tmp_count & COUNT_CONTINUED);
-out:
-	swap_cluster_unlock(ci);
-	return count;
-}
-
-static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
-					 swp_entry_t entry, int order)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_cluster_info *ci;
-	unsigned char *map = si->swap_map;
-	unsigned int nr_pages = 1 << order;
-	unsigned long roffset = swp_slot_offset(slot);
-	unsigned long offset = round_down(roffset, nr_pages);
-	int i;
-	bool ret = false;
-
-	ci = swap_cluster_lock(si, offset);
-	if (nr_pages == 1) {
-		if (swap_count(map[roffset]))
-			ret = true;
-		goto unlock_out;
-	}
-	for (i = 0; i < nr_pages; i++) {
-		if (swap_count(map[offset + i])) {
-			ret = true;
-			break;
-		}
-	}
-unlock_out:
-	swap_cluster_unlock(ci);
-	return ret;
-}
-
-static bool folio_swapped(struct folio *folio)
-{
-	swp_entry_t entry = folio->swap;
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *si = _swap_info_get(slot);
-
-	if (!si)
-		return false;
-
-	if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(folio)))
-		return swap_entry_swapped(si, entry);
-
-	return swap_page_trans_huge_swapped(si, entry, folio_order(folio));
-}
-
 static bool folio_swapcache_freeable(struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -1928,72 +1624,6 @@ bool folio_free_swap(struct folio *folio)
 	return true;
 }
 
-/**
- * free_swap_and_cache_nr() - Release reference on range of swap entries and
- *                            reclaim their cache if no more references remain.
- * @entry: First entry of range.
- * @nr: Number of entries in range.
- *
- * For each swap entry in the contiguous range, release a reference. If any swap
- * entries become free, try to reclaim their underlying folios, if present. The
- * offset range is defined by [entry.offset, entry.offset + nr).
- */
-void free_swap_and_cache_nr(swp_entry_t entry, int nr)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	const unsigned long start_offset = swp_slot_offset(slot);
-	const unsigned long end_offset = start_offset + nr;
-	struct swap_info_struct *si;
-	bool any_only_cache = false;
-	unsigned long offset;
-
-	si = swap_slot_tryget_swap_info(slot);
-	if (!si)
-		return;
-
-	if (WARN_ON(end_offset > si->max))
-		goto out;
-
-	/*
-	 * First free all entries in the range.
-	 */
-	any_only_cache = swap_slots_put_map_nr(si, slot, nr);
-
-	/*
-	 * Short-circuit the below loop if none of the entries had their
-	 * reference drop to zero.
-	 */
-	if (!any_only_cache)
-		goto out;
-
-	/*
-	 * Now go back over the range trying to reclaim the swap cache.
-	 */
-	for (offset = start_offset; offset < end_offset; offset += nr) {
-		nr = 1;
-		if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
-			/*
-			 * Folios are always naturally aligned in swap so
-			 * advance forward to the next boundary. Zero means no
-			 * folio was found for the swap entry, so advance by 1
-			 * in this case. Negative value means folio was found
-			 * but could not be reclaimed. Here we can still advance
-			 * to the next boundary.
-			 */
-			nr = __try_to_reclaim_swap(si, offset,
-						   TTRS_UNMAPPED | TTRS_FULL);
-			if (nr == 0)
-				nr = 1;
-			else if (nr < 0)
-				nr = -nr;
-			nr = ALIGN(offset + 1, nr) - offset;
-		}
-	}
-
-out:
-	swap_slot_put_swap_info(si);
-}
-
 #ifdef CONFIG_HIBERNATION
 
 swp_slot_t swap_slot_alloc_of_type(int type)
@@ -2904,8 +2534,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	flush_percpu_swap_cluster(p);
 
 	destroy_swap_extents(p);
-	if (p->flags & SWP_CONTINUED)
-		free_swap_count_continuations(p);
 
 	if (!(p->flags & SWP_SOLIDSTATE))
 		atomic_dec(&nr_rotate_swap);
@@ -3641,364 +3269,6 @@ void si_swapinfo(struct sysinfo *val)
 	spin_unlock(&swap_lock);
 }
 
-/*
- * Verify that nr swap entries are valid and increment their swap map counts.
- *
- * Returns error code in following case.
- * - success -> 0
- * - swp_entry is invalid -> EINVAL
- * - swap-cache reference is requested but there is already one. -> EEXIST
- * - swap-cache reference is requested but the entry is not used. -> ENOENT
- * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
- */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	unsigned long offset;
-	unsigned char count;
-	unsigned char has_cache;
-	int err, i;
-
-	si = swap_slot_to_info(slot);
-	if (WARN_ON_ONCE(!si)) {
-		pr_err("%s%08lx\n", Bad_file, entry.val);
-		return -EINVAL;
-	}
-
-	offset = swp_slot_offset(slot);
-	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-	VM_WARN_ON(usage == 1 && nr > 1);
-	ci = swap_cluster_lock(si, offset);
-
-	err = 0;
-	for (i = 0; i < nr; i++) {
-		count = si->swap_map[offset + i];
-
-		/*
-		 * swapin_readahead() doesn't check if a swap entry is valid, so the
-		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
-		 */
-		if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
-			err = -ENOENT;
-			goto unlock_out;
-		}
-
-		has_cache = count & SWAP_HAS_CACHE;
-		count &= ~SWAP_HAS_CACHE;
-
-		if (!count && !has_cache) {
-			err = -ENOENT;
-		} else if (usage == SWAP_HAS_CACHE) {
-			if (has_cache)
-				err = -EEXIST;
-		} else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
-			err = -EINVAL;
-		}
-
-		if (err)
-			goto unlock_out;
-	}
-
-	for (i = 0; i < nr; i++) {
-		count = si->swap_map[offset + i];
-		has_cache = count & SWAP_HAS_CACHE;
-		count &= ~SWAP_HAS_CACHE;
-
-		if (usage == SWAP_HAS_CACHE)
-			has_cache = SWAP_HAS_CACHE;
-		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
-			count += usage;
-		else if (swap_count_continued(si, offset + i, count))
-			count = COUNT_CONTINUED;
-		else {
-			/*
-			 * Don't need to rollback changes, because if
-			 * usage == 1, there must be nr == 1.
-			 */
-			err = -ENOMEM;
-			goto unlock_out;
-		}
-
-		WRITE_ONCE(si->swap_map[offset + i], count | has_cache);
-	}
-
-unlock_out:
-	swap_cluster_unlock(ci);
-	return err;
-}
-
-/*
- * Help swapoff by noting that swap entry belongs to shmem/tmpfs
- * (in which case its reference count is never incremented).
- */
-void swap_shmem_alloc(swp_entry_t entry, int nr)
-{
-	__swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
-}
-
-/*
- * Increase reference count of swap entry by 1.
- * Returns 0 for success, or -ENOMEM if a swap_count_continuation is required
- * but could not be atomically allocated.  Returns 0, just as if it succeeded,
- * if __swap_duplicate() fails for another reason (-EINVAL or -ENOENT), which
- * might occur if a page table entry has got corrupted.
- */
-int swap_duplicate(swp_entry_t entry)
-{
-	int err = 0;
-
-	while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
-		err = add_swap_count_continuation(entry, GFP_ATOMIC);
-	return err;
-}
-
-/*
- * @entry: first swap entry from which we allocate nr swap cache.
- *
- * Called when allocating swap cache for existing swap entries,
- * This can return error codes. Returns 0 at success.
- * -EEXIST means there is a swap cache.
- * Note: return code is different from swap_duplicate().
- */
-int swapcache_prepare(swp_entry_t entry, int nr)
-{
-	return __swap_duplicate(entry, SWAP_HAS_CACHE, nr);
-}
-
-/*
- * Caller should ensure entries belong to the same folio so
- * the entries won't span cross cluster boundary.
- */
-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
-{
-	swap_slots_put_cache(si, swp_entry_to_swp_slot(entry), nr);
-}
-
-/*
- * add_swap_count_continuation - called when a swap count is duplicated
- * beyond SWAP_MAP_MAX, it allocates a new page and links that to the entry's
- * page of the original vmalloc'ed swap_map, to hold the continuation count
- * (for that entry and for its neighbouring PAGE_SIZE swap entries).  Called
- * again when count is duplicated beyond SWAP_MAP_MAX * SWAP_CONT_MAX, etc.
- *
- * These continuation pages are seldom referenced: the common paths all work
- * on the original swap_map, only referring to a continuation page when the
- * low "digit" of a count is incremented or decremented through SWAP_MAP_MAX.
- *
- * add_swap_count_continuation(, GFP_ATOMIC) can be called while holding
- * page table locks; if it fails, add_swap_count_continuation(, GFP_KERNEL)
- * can be called after dropping locks.
- */
-int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
-{
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	struct page *head;
-	struct page *page;
-	struct page *list_page;
-	pgoff_t offset;
-	unsigned char count;
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	int ret = 0;
-
-	/*
-	 * When debugging, it's easier to use __GFP_ZERO here; but it's better
-	 * for latency not to zero a page while GFP_ATOMIC and holding locks.
-	 */
-	page = alloc_page(gfp_mask | __GFP_HIGHMEM);
-
-	si = swap_slot_tryget_swap_info(slot);
-	if (!si) {
-		/*
-		 * An acceptable race has occurred since the failing
-		 * __swap_duplicate(): the swap device may be swapoff
-		 */
-		goto outer;
-	}
-
-	offset = swp_slot_offset(slot);
-
-	ci = swap_cluster_lock(si, offset);
-
-	count = swap_count(si->swap_map[offset]);
-
-	if ((count & ~COUNT_CONTINUED) != SWAP_MAP_MAX) {
-		/*
-		 * The higher the swap count, the more likely it is that tasks
-		 * will race to add swap count continuation: we need to avoid
-		 * over-provisioning.
-		 */
-		goto out;
-	}
-
-	if (!page) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	head = vmalloc_to_page(si->swap_map + offset);
-	offset &= ~PAGE_MASK;
-
-	spin_lock(&si->cont_lock);
-	/*
-	 * Page allocation does not initialize the page's lru field,
-	 * but it does always reset its private field.
-	 */
-	if (!page_private(head)) {
-		BUG_ON(count & COUNT_CONTINUED);
-		INIT_LIST_HEAD(&head->lru);
-		set_page_private(head, SWP_CONTINUED);
-		si->flags |= SWP_CONTINUED;
-	}
-
-	list_for_each_entry(list_page, &head->lru, lru) {
-		unsigned char *map;
-
-		/*
-		 * If the previous map said no continuation, but we've found
-		 * a continuation page, free our allocation and use this one.
-		 */
-		if (!(count & COUNT_CONTINUED))
-			goto out_unlock_cont;
-
-		map = kmap_local_page(list_page) + offset;
-		count = *map;
-		kunmap_local(map);
-
-		/*
-		 * If this continuation count now has some space in it,
-		 * free our allocation and use this one.
-		 */
-		if ((count & ~COUNT_CONTINUED) != SWAP_CONT_MAX)
-			goto out_unlock_cont;
-	}
-
-	list_add_tail(&page->lru, &head->lru);
-	page = NULL;			/* now it's attached, don't free it */
-out_unlock_cont:
-	spin_unlock(&si->cont_lock);
-out:
-	swap_cluster_unlock(ci);
-	swap_slot_put_swap_info(si);
-outer:
-	if (page)
-		__free_page(page);
-	return ret;
-}
-
-/*
- * swap_count_continued - when the original swap_map count is incremented
- * from SWAP_MAP_MAX, check if there is already a continuation page to carry
- * into, carry if so, or else fail until a new continuation page is allocated;
- * when the original swap_map count is decremented from 0 with continuation,
- * borrow from the continuation and report whether it still holds more.
- * Called while __swap_duplicate() or caller of swap_entry_put_locked()
- * holds cluster lock.
- */
-static bool swap_count_continued(struct swap_info_struct *si,
-				 pgoff_t offset, unsigned char count)
-{
-	struct page *head;
-	struct page *page;
-	unsigned char *map;
-	bool ret;
-
-	head = vmalloc_to_page(si->swap_map + offset);
-	if (page_private(head) != SWP_CONTINUED) {
-		BUG_ON(count & COUNT_CONTINUED);
-		return false;		/* need to add count continuation */
-	}
-
-	spin_lock(&si->cont_lock);
-	offset &= ~PAGE_MASK;
-	page = list_next_entry(head, lru);
-	map = kmap_local_page(page) + offset;
-
-	if (count == SWAP_MAP_MAX)	/* initial increment from swap_map */
-		goto init_map;		/* jump over SWAP_CONT_MAX checks */
-
-	if (count == (SWAP_MAP_MAX | COUNT_CONTINUED)) { /* incrementing */
-		/*
-		 * Think of how you add 1 to 999
-		 */
-		while (*map == (SWAP_CONT_MAX | COUNT_CONTINUED)) {
-			kunmap_local(map);
-			page = list_next_entry(page, lru);
-			BUG_ON(page == head);
-			map = kmap_local_page(page) + offset;
-		}
-		if (*map == SWAP_CONT_MAX) {
-			kunmap_local(map);
-			page = list_next_entry(page, lru);
-			if (page == head) {
-				ret = false;	/* add count continuation */
-				goto out;
-			}
-			map = kmap_local_page(page) + offset;
-init_map:		*map = 0;		/* we didn't zero the page */
-		}
-		*map += 1;
-		kunmap_local(map);
-		while ((page = list_prev_entry(page, lru)) != head) {
-			map = kmap_local_page(page) + offset;
-			*map = COUNT_CONTINUED;
-			kunmap_local(map);
-		}
-		ret = true;			/* incremented */
-
-	} else {				/* decrementing */
-		/*
-		 * Think of how you subtract 1 from 1000
-		 */
-		BUG_ON(count != COUNT_CONTINUED);
-		while (*map == COUNT_CONTINUED) {
-			kunmap_local(map);
-			page = list_next_entry(page, lru);
-			BUG_ON(page == head);
-			map = kmap_local_page(page) + offset;
-		}
-		BUG_ON(*map == 0);
-		*map -= 1;
-		if (*map == 0)
-			count = 0;
-		kunmap_local(map);
-		while ((page = list_prev_entry(page, lru)) != head) {
-			map = kmap_local_page(page) + offset;
-			*map = SWAP_CONT_MAX | count;
-			count = COUNT_CONTINUED;
-			kunmap_local(map);
-		}
-		ret = count == COUNT_CONTINUED;
-	}
-out:
-	spin_unlock(&si->cont_lock);
-	return ret;
-}
-
-/*
- * free_swap_count_continuations - swapoff free all the continuation pages
- * appended to the swap_map, after swap_map is quiesced, before vfree'ing it.
- */
-static void free_swap_count_continuations(struct swap_info_struct *si)
-{
-	pgoff_t offset;
-
-	for (offset = 0; offset < si->max; offset += PAGE_SIZE) {
-		struct page *head;
-		head = vmalloc_to_page(si->swap_map + offset);
-		if (page_private(head)) {
-			struct page *page, *next;
-
-			list_for_each_entry_safe(page, next, &head->lru, lru) {
-				list_del(&page->lru);
-				__free_page(page);
-			}
-		}
-	}
-}
-
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
 static bool __has_usable_swap(void)
 {
diff --git a/mm/vswap.c b/mm/vswap.c
index 95d683cf4505e..47fc42f9351ab 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -24,6 +24,8 @@
  * For now, there is a one-to-one correspondence between a virtual swap slot
  * and its associated physical swap slot.
  *
+ * I. Allocation
+ *
  * Virtual swap slots are organized into PMD-sized clusters, analogous to
  * physical swap allocator. However, unlike the physical swap allocator,
  * the clusters are dynamically allocated and freed on-demand. There is no
@@ -32,6 +34,26 @@
  *
  * This allows us to avoid the overhead of pre-allocating a large number of
  * virtual swap clusters.
+ *
+ * II. Swap Entry Lifecycle
+ *
+ * The swap entry's lifecycle is managed at the virtual swap layer. Conceptually,
+ * each virtual swap slot has a reference count, which includes:
+ *
+ * 1. The number of page table entries that refer to the virtual swap slot, i.e
+ *    its swap count.
+ *
+ * 2. Whether the virtual swap slot has been added to the swap cache - if so,
+ *    its reference count is incremented by 1.
+ *
+ * Each virtual swap slot starts out with a reference count of 1 (since it is
+ * about to be added to the swap cache). Its reference count is incremented or
+ * decremented every time it is mapped to or unmapped from a PTE, as well as
+ * when it is added to or removed from the swap cache. Finally, when its
+ * reference count reaches 0, the virtual swap slot is freed.
+ *
+ * Note that we do not have a reference count field per se - it is derived from
+ * the swap_count and the in_swapcache fields.
  */
 
 /**
@@ -42,6 +64,8 @@
  * @swap_cache: The folio in swap cache.
  * @shadow: The shadow entry.
  * @memcgid: The memcg id of the owning memcg, if any.
+ * @swap_count: The number of page table entries that refer to the swap entry.
+ * @in_swapcache: Whether the swap entry is (about to be) pinned in swap cache.
  */
 struct swp_desc {
 	swp_slot_t slot;
@@ -50,9 +74,14 @@ struct swp_desc {
 		struct folio *swap_cache;
 		void *shadow;
 	};
+
+	unsigned int swap_count;
+
 #ifdef CONFIG_MEMCG
 	unsigned short memcgid;
 #endif
+
+	bool in_swapcache;
 };
 
 #define VSWAP_CLUSTER_SHIFT HPAGE_PMD_ORDER
@@ -249,6 +278,8 @@ static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start)
 #ifdef CONFIG_MEMCG
 		desc->memcgid = 0;
 #endif
+		desc->swap_count = 0;
+		desc->in_swapcache = true;
 	}
 	cluster->count += nr;
 }
@@ -453,7 +484,7 @@ static inline void release_vswap_slot(struct vswap_cluster *cluster,
  * Update the physical-to-virtual swap slot mapping.
  * Caller must ensure the physical swap slot's cluster is locked.
  */
-static void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
+void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 			   unsigned long vswap, int nr)
 {
 	atomic_long_t *table;
@@ -467,45 +498,50 @@ static void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 		__swap_table_set(ci, ci_off + i, vswap ? vswap + i : 0);
 }
 
-/**
- * vswap_free - free a virtual swap slot.
- * @entry: the virtual swap slot to free
- * @ci: the physical swap slot's cluster (optional, can be NULL)
+/*
+ * Entered with the cluster locked, but might unlock the cluster.
+ * This is because several operations, such as releasing physical swap slots
+ * (i.e swap_slot_free_nr()) require the cluster to be unlocked to avoid
+ * deadlocks.
  *
- * If @ci is NULL, this function is called to clean up a virtual swap entry
- * when no linkage has been established between physical and virtual swap slots.
- * If @ci is provided, the caller must ensure it is locked.
+ * This is safe, because:
+ *
+ * 1. The swap entry to be freed has refcnt (swap count and swapcache pin)
+ *    down to 0, so no one can change its internal state
+ *
+ * 2. The swap entry to be freed still holds a refcnt to the cluster, keeping
+ *    the cluster itself valid.
+ *
+ * We will exit the function with the cluster re-locked.
  */
-void vswap_free(swp_entry_t entry, struct swap_cluster_info *ci)
+static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
+	swp_entry_t entry)
 {
-	struct vswap_cluster *cluster = NULL;
-	struct swp_desc *desc;
+	struct zswap_entry *zswap_entry;
+	swp_slot_t slot;
 
-	if (!entry.val)
-		return;
+	/* Clear shadow if present */
+	if (xa_is_value(desc->shadow))
+		desc->shadow = NULL;
 
-	zswap_invalidate(entry);
-	mem_cgroup_uncharge_swap(entry, 1);
+	slot = desc->slot;
+	desc->slot.val = 0;
 
-	/* do not immediately erase the virtual slot to prevent its reuse */
-	rcu_read_lock();
-	desc = vswap_iter(&cluster, entry.val);
-	if (!desc) {
-		rcu_read_unlock();
-		return;
+	zswap_entry = desc->zswap_entry;
+	if (zswap_entry) {
+		desc->zswap_entry = NULL;
+		zswap_entry_free(zswap_entry);
 	}
+	spin_unlock(&cluster->lock);
 
-	/* Clear shadow if present */
-	if (xa_is_value(desc->shadow))
-		desc->shadow = NULL;
+	mem_cgroup_uncharge_swap(entry, 1);
 
-	if (desc->slot.val)
-		vswap_rmap_set(ci, desc->slot, 0, 1);
+	if (slot.val)
+		swap_slot_free_nr(slot, 1);
 
+	spin_lock(&cluster->lock);
 	/* erase forward mapping and release the virtual slot for reallocation */
 	release_vswap_slot(cluster, entry.val);
-	spin_unlock(&cluster->lock);
-	rcu_read_unlock();
 }
 
 /**
@@ -543,8 +579,12 @@ int folio_alloc_swap(struct folio *folio)
 		/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
 		mem_cgroup_try_charge_swap(folio, (swp_entry_t){0});
 
-		for (i = 0; i < nr; i++)
-			vswap_free((swp_entry_t){entry.val + i}, NULL);
+		for (i = 0; i < nr; i++) {
+			desc = vswap_iter(&cluster, entry.val + i);
+			VM_WARN_ON(!desc);
+			vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
+		}
+		spin_unlock(&cluster->lock);
 
 		return ret ? ret : -ENOMEM;
 	}
@@ -608,9 +648,11 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 		rcu_read_unlock();
 		return (swp_slot_t){0};
 	}
+
 	slot = desc->slot;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
+
 	return slot;
 }
 
@@ -640,6 +682,352 @@ swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
 	return ret;
 }
 
+/*
+ * Decrease the swap count of nr contiguous swap entries by 1 (when the swap
+ * entries are removed from a range of PTEs), and check if any of the swap
+ * entries are in swap cache only after its swap count is decreased.
+ *
+ * The check is racy, but it is OK because free_swap_and_cache_nr() only use
+ * the result as a hint.
+ */
+static bool vswap_free_nr_any_cache_only(swp_entry_t entry, int nr)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	bool ret = false;
+	int i;
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val);
+		VM_WARN_ON(!desc);
+		ret |= (desc->swap_count == 1 && desc->in_swapcache);
+		desc->swap_count--;
+		if (!desc->swap_count && !desc->in_swapcache)
+			vswap_free(cluster, desc, entry);
+		entry.val++;
+	}
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	return ret;
+}
+
+/**
+ * swap_free_nr - decrease the swap count of nr contiguous swap entries by 1
+ *                (when the swap entries are removed from a range of PTEs).
+ * @entry: the first entry in the range.
+ * @nr: the number of entries in the range.
+ */
+void swap_free_nr(swp_entry_t entry, int nr)
+{
+	vswap_free_nr_any_cache_only(entry, nr);
+}
+
+static int swap_duplicate_nr(swp_entry_t entry, int nr)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	int i = 0;
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		if (!desc || (!desc->swap_count && !desc->in_swapcache))
+			goto done;
+		desc->swap_count++;
+	}
+done:
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	if (i && i < nr)
+		swap_free_nr(entry, i);
+
+	return i == nr ? 0 : -ENOENT;
+}
+
+/**
+ * swap_duplicate - increase the swap count of the swap entry by 1 (i.e when
+ *                  the swap entry is stored at a new PTE).
+ * @entry: the swap entry.
+ *
+ * Return: -ENONENT, if we try to duplicate a non-existent swap entry.
+ */
+int swap_duplicate(swp_entry_t entry)
+{
+	return swap_duplicate_nr(entry, 1);
+}
+
+
+bool folio_swapped(struct folio *folio)
+{
+	struct vswap_cluster *cluster = NULL;
+	swp_entry_t entry = folio->swap;
+	int i, nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+	bool swapped = false;
+
+	if (!entry.val)
+		return false;
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		if (desc && desc->swap_count) {
+			swapped = true;
+			break;
+		}
+	}
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	return swapped;
+}
+
+/**
+ * swp_swapcount - return the swap count of the swap entry.
+ * @id: the swap entry.
+ *
+ * Note that all the swap count functions are identical in the new design,
+ * since we no longer need swap count continuation.
+ *
+ * Return: the swap count of the swap entry.
+ */
+int swp_swapcount(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	unsigned int ret;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	ret = desc ? desc->swap_count : 0;
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	return ret;
+}
+
+int __swap_count(swp_entry_t entry)
+{
+	return swp_swapcount(entry);
+}
+
+bool swap_entry_swapped(swp_entry_t entry)
+{
+	return !!swp_swapcount(entry);
+}
+
+void swap_shmem_alloc(swp_entry_t entry, int nr)
+{
+	swap_duplicate_nr(entry, nr);
+}
+
+void swapcache_clear(swp_entry_t entry, int nr)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	int i;
+
+	if (!nr)
+		return;
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val);
+		desc->in_swapcache = false;
+		if (!desc->swap_count)
+			vswap_free(cluster, desc, entry);
+		entry.val++;
+	}
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+}
+
+int swapcache_prepare(swp_entry_t entry, int nr)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	int i, ret = 0;
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+
+		if (!desc) {
+			ret = -ENOENT;
+			goto done;
+		}
+
+		if (!desc->swap_count && !desc->in_swapcache) {
+			ret = -ENOENT;
+			goto done;
+		}
+
+		if (desc->in_swapcache) {
+			ret = -EEXIST;
+			goto done;
+		}
+
+		desc->in_swapcache = true;
+	}
+done:
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	if (i && i < nr)
+		swapcache_clear(entry, i);
+	if (i < nr && !ret)
+		ret = -ENOENT;
+	return ret;
+}
+
+/**
+ * is_swap_cached - check if the swap entry is cached
+ * @entry: swap entry to check
+ *
+ * Returns true if the swap entry is cached, false otherwise.
+ */
+bool is_swap_cached(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	bool cached;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	cached = desc ? desc->in_swapcache : false;
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	return cached;
+}
+
+/**
+ * vswap_only_has_cache - check if all the slots in the range are still valid,
+ *                        and are in swap cache only (i.e not stored in any
+ *                        PTEs).
+ * @entry: the first slot in the range.
+ * @nr: the number of slots in the range.
+ *
+ * Return: true if all the slots in the range are still valid, and are in swap
+ * cache only, or false otherwise.
+ */
+bool vswap_only_has_cache(swp_entry_t entry, int nr)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	int i = 0;
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		if (!desc || desc->swap_count || !desc->in_swapcache)
+			goto done;
+	}
+done:
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	return i == nr;
+}
+
+/**
+ * non_swapcache_batch - count the longest range starting from a particular
+ *                       swap slot that are stil valid, but not in swap cache.
+ * @entry: the first slot to check.
+ * @max_nr: the maximum number of slots to check.
+ *
+ * Return: the number of slots in the longest range that are still valid, but
+ * not in swap cache.
+ */
+int non_swapcache_batch(swp_entry_t entry, int max_nr)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	int i;
+
+	if (!entry.val)
+		return 0;
+
+	rcu_read_lock();
+	for (i = 0; i < max_nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		if (!desc || desc->in_swapcache || !desc->swap_count)
+			goto done;
+	}
+done:
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	return i;
+}
+
+/**
+ * free_swap_and_cache_nr() - Release a swap count on range of swap entries and
+ *                            reclaim their cache if no more references remain.
+ * @entry: First entry of range.
+ * @nr: Number of entries in range.
+ *
+ * For each swap entry in the contiguous range, release a swap count. If any
+ * swap entries have their swap count decremented to zero, try to reclaim their
+ * associated swap cache pages.
+ */
+void free_swap_and_cache_nr(swp_entry_t entry, int nr)
+{
+	int i = 0, incr = 1;
+	struct folio *folio;
+
+	if (vswap_free_nr_any_cache_only(entry, nr)) {
+		while (i < nr) {
+			incr = 1;
+			if (vswap_only_has_cache(entry, 1)) {
+				folio = swap_cache_get_folio(entry);
+				if (!folio)
+					goto next;
+
+				if (!folio_trylock(folio)) {
+					folio_put(folio);
+					goto next;
+				}
+
+				if (!folio_matches_swap_entry(folio, entry)) {
+					folio_unlock(folio);
+					folio_put(folio);
+					goto next;
+				}
+
+				/*
+				 * Folios are always naturally aligned in swap so
+				 * advance forward to the next boundary.
+				 */
+				incr = ALIGN(entry.val + 1, folio_nr_pages(folio)) - entry.val;
+				folio_free_swap(folio);
+				folio_unlock(folio);
+				folio_put(folio);
+			}
+next:
+			i += incr;
+			entry.val += incr;
+		}
+	}
+}
+
+/*
+ * Called after dropping swapcache to decrease refcnt to swap entries.
+ */
+void put_swap_folio(struct folio *folio, swp_entry_t entry)
+{
+	int nr = folio_nr_pages(folio);
+
+	VM_WARN_ON(!folio_test_locked(folio));
+	swapcache_clear(entry, nr);
+}
+
 bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si)
 {
 	struct vswap_cluster *cluster;
@@ -869,8 +1257,8 @@ void *swap_cache_get_shadow(swp_entry_t entry)
  * Context: Caller must ensure @entry is valid and protect the cluster with
  * reference count or locks.
  *
- * The caller also needs to update the corresponding swap_map slots with
- * SWAP_HAS_CACHE bit to avoid race or conflict.
+ * The caller also needs to obtain the swap entries' swap cache pins to avoid
+ * race or conflict.
  */
 void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp)
 {
diff --git a/mm/zswap.c b/mm/zswap.c
index 72441131f094e..e46349f9c90bb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -703,7 +703,7 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
  * Carries out the common pattern of freeing an entry's zsmalloc allocation,
  * freeing the entry itself, and decrementing the number of stored pages.
  */
-static void zswap_entry_free(struct zswap_entry *entry)
+void zswap_entry_free(struct zswap_entry *entry)
 {
 	zswap_lru_del(&zswap_list_lru, entry);
 	zs_free(entry->pool->zs_pool, entry->handle);
@@ -1627,18 +1627,6 @@ int zswap_load(struct folio *folio)
 	return 0;
 }
 
-void zswap_invalidate(swp_entry_t swp)
-{
-	struct zswap_entry *entry;
-
-	if (zswap_empty(swp))
-		return;
-
-	entry = zswap_entry_erase(swp);
-	if (entry)
-		zswap_entry_free(entry);
-}
-
 /*********************************
 * debugfs functions
 **********************************/
-- 
2.52.0


