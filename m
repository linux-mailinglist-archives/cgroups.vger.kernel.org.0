Return-Path: <cgroups+bounces-15612-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBu6MDUQ+mntIgMAu9opvQ
	(envelope-from <cgroups+bounces-15612-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:43:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5930D4D06BF
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF3A8307CDA5
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7539948BD2D;
	Tue,  5 May 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMdRhfrR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592048B37F
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995556; cv=none; b=A58yEQVZP7q3BpGEEfuR9HhXS0v8N+mO3vLNOtX2zKG8EQK3iFxBkwK0KIOKGt2UfoCVGqJpy/NOZPEIvckkxSGREj8i9x7Z47KkPo255m+JstWXDorrIwfHOIhl3uBAdbJEn8162rSFRs/B0gUMuCtlEz7WeX3tCA6ctD+r8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995556; c=relaxed/simple;
	bh=Zmn4O4bjTESgcMvcFV32eUILnaEHKsD0nXxBQ0qkMFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keEcjTeoaBZbSwwukoUMDYgOGi0Ia1f/7cSgB3bvsWcEr3/bAVKMg2bwELljPGkc5MW3JsMhm684JM3pjkyK8V/AF7nFcZP01+z/9xaOp+afAjw6J1uhEft18EqbNue40YAIIh8YyfBJxnj6FrxdXALy9F0AM0Jri5ArB2KD8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMdRhfrR; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6948d7ccfbbso2270151eaf.1
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995550; x=1778600350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NtyZe0qP7kXfFY5DeHliZ6au+tELTnVSXpwSHZXHko=;
        b=DMdRhfrRhfN/Gl0Lv6M9uflmKE1veUjA/vRvCUgpHg+aya9hfuQjpGiSdISYlSRQ0K
         s5rhwn/CgTSg/k4/Xi4xkvEdU1O3HR6UDahMB2x59rnrsq0o0eT0JIQCdhe4NVW+v/TA
         TuMIhXtlBcm8pc/NbvBA/1dyDvHt6OQ0YgdGx2bBzjPWVyO1xxURBqfj1R9w6VEQy9uc
         ySgWAzIO4Dba88PZgpAneZsaKVaD5iov8okQC8JGUr7FtLxbVzh5DeCD/p30E7091rmo
         HZpsrYOBcmqIk9jYnFsr8ZYFJ68SoP7DaiFua2xiWp5gOFF7TfPANKIeo3wJq4Kz8VHO
         lHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995550; x=1778600350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6NtyZe0qP7kXfFY5DeHliZ6au+tELTnVSXpwSHZXHko=;
        b=ZuTXylfOj0Xdf8+BlGu38MvK2tbuIxYcBh4k4QneGYlZ9wdWnqjgNXu+uujjvhUGr+
         55E5Xtz7bu3IfRCdXizxuc57QTyLCHKnvmrLrbKhnNwK7+QBRuOBNlWdyFnM9mbOK6dq
         bA1ix5AI9zeSuOXMZza60AMaV4tGAhZpjhy1px3qZlJkURY7t2XMiECVSBHsBhJeyif7
         Zs33i+wXpIL4/S1kh8kA7KvdFIKn+XFomeeUGqAPATFz8FEfKyl3XJoP6FJBCOKFlqTt
         RTp9xP1NLzy2iMg2NIkK4F7SJ4q3FfjeewsFzNU5vxXKjr8FatszK2KnhoFpPT3HK16Y
         WFyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+93uXfyF0C5cii5aRINVNU+YrNvquU8eDle8AyxLklES747zGZgKZTAaboVeusXUj1u57i1snQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPrUwW050dlTO+VvaOv8tW6FbqEpYPKT1TCppO07NiG+zbOx51
	qHdyREMv6l3ZOJdAvBB0OzvQxyxOGm6IwxGdLLsQk1k6ffC8ZJkfP4/M
X-Gm-Gg: AeBDievFKlOthgaJnSjv8+34BjAZ5lDJWR9fAf3XiP7/X/6ePCxYexKmC870O0yb07q
	EDx0hiMwUvSpJMpyACovRu+21z5/J9oH/W7cp4zPZCsaJr14w2FI7XUna6YpisVIufupL/ea3QW
	QueAGMbPcx0oRNHBde5BkSHptxUKHoyvumkW2JTm+kSH2T/V8pTTZjf+vbNZmL38Aj7u52s/XBl
	/b0J/aEkl7hz6zKVENgf+p+NEIExh+nlVNuAl5+U6b4VTynEfS2xn4oW2B3j9FnqvzLInZwuJKL
	EVEfzs3l/RqWEkNOQPXsW22C5DAIhA4CMCwHLn7DlnZwRgqLAN8fWfKth179PhUrMLgw5O9dF+0
	VZw9ctJI5msHoCFZdRqEav243LWfJxVxBcQlXtglZ2RYKAsnXobKU6q0Sk9BsLV9Eiw/up5Q5gK
	ApMTC7c2nXuB033bZOkQkymZTwcw0lczBtSKd2vOnxjXQ/+ryDSGAy2x5P
X-Received: by 2002:a05:6820:8c9:b0:694:9ea7:7a9f with SMTP id 006d021491bc7-6998d248269mr1817428eaf.35.1777995550097;
        Tue, 05 May 2026 08:39:10 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4b::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69689708162sm8121683eaf.13.2026.05.05.08.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:09 -0700 (PDT)
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
Subject: [PATCH v6 06/22] mm: swap: add a separate type for physical swap slots
Date: Tue,  5 May 2026 08:38:35 -0700
Message-ID: <20260505153854.1612033-7-nphamcs@gmail.com>
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
X-Rspamd-Queue-Id: 5930D4D06BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15612-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

In preparation for swap virtualization, add a new type to represent the
physical swap slots of swapfile. This allows us to separates:

1. The logical view of the swap entry (i.e what is stored in page table
   entries and used to index into the swap cache), represented by the
   old swp_entry_t type.

from:

2. Its physical backing state (i.e the actual backing slot on the swap
   device), represented by the new swp_slot_t type.

The functions that operate at the physical level (i.e on the swp_slot_t
types) are also renamed where appropriate (prefixed with swp_slot_* for
e.g).

The mapping between the two types is the identity mapping, so the
patch is largely a mechanical refactor. The only intentional behavioral
change is in swap_vma_readahead(): readahead entries are now pinned via
tryget_swap_entry()/put_swap_entry() unconditionally to avoid an awkward
conversion to physical swap slots. The same-cluster fast path is
restored in a later patch.

In later patches, we shall dynamically allocate a virtual swap slot
(of type swp_entry_t) for each swapped out page to store in the page
table entry, and associate it with a backing store. A physical swap
slot (i.e a slot on a physical swap device) is one of the backing
options.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/mm_types.h |  16 +++
 include/linux/swap.h     |  47 ++++--
 include/linux/swapops.h  |  25 ++++
 kernel/power/swap.c      |   6 +-
 mm/internal.h            |  10 +-
 mm/page_io.c             |  33 +++--
 mm/shmem.c               |  19 ++-
 mm/swap.h                |  44 +++---
 mm/swap_cgroup.c         |  18 +--
 mm/swap_state.c          |  32 +++--
 mm/swapfile.c            | 300 ++++++++++++++++++++++-----------------
 11 files changed, 347 insertions(+), 203 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 78950eb8926d..bffde812decc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -279,6 +279,13 @@ static __always_inline unsigned long encoded_nr_pages(struct encoded_page *page)
 }
 
 /*
+ * Virtual swap slot.
+ *
+ * This type is used to represent a virtual swap slot, i.e an identifier of
+ * a swap entry. This is stored in PTEs that originally refer to the swapped
+ * out page, and is used to index into various swap architectures (swap cache,
+ * zswap tree, swap cgroup array, etc.).
+ *
  * A swap entry has to fit into a "unsigned long", as the entry is hidden
  * in the "index" field of the swapper address space.
  */
@@ -286,6 +293,15 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+/*
+ * Physical swap slot.
+ *
+ * This type is used to represent a PAGE_SIZED slot on a swapfile.
+ */
+typedef struct {
+	unsigned long val;
+} swp_slot_t;
+
 /**
  * typedef softleaf_t - Describes a page table software leaf entry, abstracted
  * from its architecture-specific encoding.
diff --git a/include/linux/swap.h b/include/linux/swap.h
index f91a442ac0e8..918b47da55f4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -241,7 +241,7 @@ enum {
  * cluster to which it belongs being marked free. Therefore 0 is safe to use as
  * a sentinel to indicate an entry is not valid.
  */
-#define SWAP_ENTRY_INVALID	0
+#define SWAP_SLOT_INVALID	0
 
 #ifdef CONFIG_THP_SWAP
 #define SWAP_NR_ORDERS		(PMD_ORDER + 1)
@@ -442,11 +442,14 @@ static inline unsigned long total_swapcache_pages(void)
 {
 	return global_node_page_state(NR_SWAPCACHE);
 }
+
 void free_folio_and_swap_cache(struct folio *folio);
 void free_pages_and_swap_cache(struct encoded_page **, int);
 void free_swap_cache(struct folio *folio);
 
 /* Physical swap allocator and swap device API (mm/swapfile.c) */
+void swap_slot_free_nr(swp_slot_t slot, int nr_pages);
+
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
 int generic_swapfile_activate(struct swap_info_struct *, struct file *,
@@ -468,28 +471,28 @@ static inline long get_nr_swap_pages(void)
 }
 
 void si_swapinfo(struct sysinfo *);
-swp_entry_t get_swap_page_of_type(int);
+swp_slot_t swap_slot_alloc_of_type(int);
 int add_swap_count_continuation(swp_entry_t, gfp_t);
 int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
 unsigned int count_swap_pages(int, int);
 sector_t swapdev_block(int, pgoff_t);
 struct backing_dev_info;
-struct swap_info_struct *get_swap_device(swp_entry_t entry);
+struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot);
 sector_t swap_folio_sector(struct folio *folio);
 
-static inline void put_swap_device(struct swap_info_struct *si)
+static inline void swap_slot_put_swap_info(struct swap_info_struct *si)
 {
 	percpu_ref_put(&si->users);
 }
 
 #else /* CONFIG_SWAP */
-static inline struct swap_info_struct *get_swap_device(swp_entry_t entry)
+static inline struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot)
 {
 	return NULL;
 }
 
-static inline void put_swap_device(struct swap_info_struct *si)
+static inline void swap_slot_put_swap_info(struct swap_info_struct *si)
 {
 }
 
@@ -536,7 +539,7 @@ static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
 {
 }
 
-static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
+static inline void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
 }
 
@@ -576,6 +579,7 @@ static inline int add_swap_extent(struct swap_info_struct *sis,
 {
 	return -EINVAL;
 }
+
 #endif /* CONFIG_SWAP */
 
 static inline void free_swap_and_cache(swp_entry_t entry)
@@ -665,10 +669,35 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+/**
+ * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
+ *                         virtual swap slot.
+ * @entry: the virtual swap slot.
+ *
+ * Return: the physical swap slot corresponding to the virtual swap slot.
+ */
+static inline swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
+{
+	return (swp_slot_t) { entry.val };
+}
+
+/**
+ * swp_slot_to_swp_entry - look up the virtual swap slot corresponding to a
+ *                         physical swap slot.
+ * @slot: the physical swap slot.
+ *
+ * Return: the virtual swap slot corresponding to the physical swap slot.
+ */
+static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
+{
+	return (swp_entry_t) { slot.val };
+}
+
 static inline bool tryget_swap_entry(swp_entry_t entry,
 				struct swap_info_struct **sip)
 {
-	struct swap_info_struct *si = get_swap_device(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *si = swap_slot_tryget_swap_info(slot);
 
 	if (sip)
 		*sip = si;
@@ -679,7 +708,7 @@ static inline bool tryget_swap_entry(swp_entry_t entry,
 static inline void put_swap_entry(swp_entry_t entry,
 				struct swap_info_struct *si)
 {
-	put_swap_device(si);
+	swap_slot_put_swap_info(si);
 }
 
 #endif /* __KERNEL__*/
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 8cfc966eae48..9e41c35664a9 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -360,5 +360,30 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
+/* Physical swap slots operations */
+
+/*
+ * Store a swap device type + offset into a swp_slot_t handle.
+ */
+static inline swp_slot_t swp_slot(unsigned long type, pgoff_t offset)
+{
+	swp_slot_t ret;
+
+	ret.val = (type << SWP_TYPE_SHIFT) | (offset & SWP_OFFSET_MASK);
+	return ret;
+}
+
+/* Extract the `type' field from a swp_slot_t. */
+static inline unsigned swp_slot_type(swp_slot_t slot)
+{
+	return (slot.val >> SWP_TYPE_SHIFT);
+}
+
+/* Extract the `offset' field from a swp_slot_t. */
+static inline pgoff_t swp_slot_offset(swp_slot_t slot)
+{
+	return slot.val & SWP_OFFSET_MASK;
+}
+
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 8050e5182835..0129c5ffa649 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -174,10 +174,10 @@ sector_t alloc_swapdev_block(int swap)
 	 * Allocate a swap page and register that it has been allocated, so that
 	 * it can be freed in case of an error.
 	 */
-	offset = swp_offset(get_swap_page_of_type(swap));
+	offset = swp_slot_offset(swap_slot_alloc_of_type(swap));
 	if (offset) {
 		if (swsusp_extents_insert(offset))
-			swap_free(swp_entry(swap, offset));
+			swap_slot_free_nr(swp_slot(swap, offset), 1);
 		else
 			return swapdev_block(swap, offset);
 	}
@@ -197,7 +197,7 @@ void free_all_swap_pages(int swap)
 
 		ext = rb_entry(node, struct swsusp_extent, node);
 		rb_erase(node, &swsusp_extents);
-		swap_free_nr(swp_entry(swap, ext->start),
+		swap_slot_free_nr(swp_slot(swap, ext->start),
 			     ext->end - ext->start + 1);
 
 		kfree(ext);
diff --git a/mm/internal.h b/mm/internal.h
index f35dbcf99a86..e739e8cac5b5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -334,9 +334,13 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
  */
 static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
-	const softleaf_t entry = softleaf_from_pte(pte);
-	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
-						   (swp_offset(entry) + delta)));
+	softleaf_t entry = softleaf_from_pte(pte), new_entry;
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	pte_t new;
+
+	new_entry = swp_slot_to_swp_entry(swp_slot(swp_slot_type(slot),
+			swp_slot_offset(slot) + delta));
+	new = swp_entry_to_pte(new_entry);
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
diff --git a/mm/page_io.c b/mm/page_io.c
index 3c342db77ce3..0b02bcc85e2a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -204,14 +204,17 @@ static bool is_folio_zero_filled(struct folio *folio)
 static void swap_zeromap_folio_set(struct folio *folio)
 {
 	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	struct swap_info_struct *sis =
+		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
 	int nr_pages = folio_nr_pages(folio);
 	swp_entry_t entry;
+	swp_slot_t slot;
 	unsigned int i;
 
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		entry = page_swap_entry(folio_page(folio, i));
-		set_bit(swp_offset(entry), sis->zeromap);
+		slot = swp_entry_to_swp_slot(entry);
+		set_bit(swp_slot_offset(slot), sis->zeromap);
 	}
 
 	count_vm_events(SWPOUT_ZERO, nr_pages);
@@ -223,13 +226,16 @@ static void swap_zeromap_folio_set(struct folio *folio)
 
 static void swap_zeromap_folio_clear(struct folio *folio)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	struct swap_info_struct *sis =
+		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
 	swp_entry_t entry;
+	swp_slot_t slot;
 	unsigned int i;
 
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		entry = page_swap_entry(folio_page(folio, i));
-		clear_bit(swp_offset(entry), sis->zeromap);
+		slot = swp_entry_to_swp_slot(entry);
+		clear_bit(swp_slot_offset(slot), sis->zeromap);
 	}
 }
 
@@ -357,7 +363,8 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		 * messages.
 		 */
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
-				   ret, swap_dev_pos(page_swap_entry(page)));
+				   ret,
+				   swap_slot_pos(swp_entry_to_swp_slot(page_swap_entry(page))));
 		for (p = 0; p < sio->pages; p++) {
 			page = sio->bvec[p].bv_page;
 			set_page_dirty(page);
@@ -374,9 +381,10 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 static void swap_writepage_fs(struct folio *folio, struct swap_iocb **swap_plug)
 {
 	struct swap_iocb *sio = swap_plug ? *swap_plug : NULL;
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
+	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 	struct file *swap_file = sis->swap_file;
-	loff_t pos = swap_dev_pos(folio->swap);
+	loff_t pos = swap_slot_pos(slot);
 
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
@@ -446,7 +454,8 @@ static void swap_writepage_bdev_async(struct folio *folio,
 
 void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	struct swap_info_struct *sis =
+		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
 
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
 	/*
@@ -537,9 +546,10 @@ static bool swap_read_folio_zeromap(struct folio *folio)
 
 static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
+	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 	struct swap_iocb *sio = NULL;
-	loff_t pos = swap_dev_pos(folio->swap);
+	loff_t pos = swap_slot_pos(slot);
 
 	if (plug)
 		sio = *plug;
@@ -608,7 +618,8 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 
 void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	struct swap_info_struct *sis =
+		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
 	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
 	bool workingset = folio_test_workingset(folio);
 	unsigned long pflags;
diff --git a/mm/shmem.c b/mm/shmem.c
index b40be22fa5f0..400e2fa8e77c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1442,6 +1442,7 @@ static unsigned int shmem_find_swap_entries(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, start);
 	struct folio *folio;
 	swp_entry_t entry;
+	swp_slot_t slot;
 
 	rcu_read_lock();
 	xas_for_each(&xas, folio, ULONG_MAX) {
@@ -1452,11 +1453,13 @@ static unsigned int shmem_find_swap_entries(struct address_space *mapping,
 			continue;
 
 		entry = radix_to_swp_entry(folio);
+		slot = swp_entry_to_swp_slot(entry);
+
 		/*
 		 * swapin error entries can be found in the mapping. But they're
 		 * deliberately ignored here as we've done everything we can do.
 		 */
-		if (swp_type(entry) != type)
+		if (swp_slot_type(slot) != type)
 			continue;
 
 		indices[folio_batch_count(fbatch)] = xas.xa_index;
@@ -2224,6 +2227,7 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
 	int split_order = 0;
 	int i;
+	swp_slot_t slot = swp_entry_to_swp_slot(swap);
 
 	/* Convert user data gfp flags to xarray node gfp flags */
 	gfp &= GFP_RECLAIM_MASK;
@@ -2264,13 +2268,16 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 			 */
 			for (i = 0; i < 1 << cur_order;
 			     i += (1 << split_order)) {
-				swp_entry_t tmp;
+				swp_entry_t tmp_entry;
+				swp_slot_t tmp_slot;
+
+				tmp_slot =
+					swp_slot(swp_slot_type(slot),
+						swp_slot_offset(slot) + swap_offset + i);
+				tmp_entry = swp_slot_to_swp_entry(tmp_slot);
 
-				tmp = swp_entry(swp_type(swap),
-						swp_offset(swap) + swap_offset +
-							i);
 				__xa_store(&mapping->i_pages, aligned_index + i,
-					   swp_to_radix_entry(tmp), 0);
+					   swp_to_radix_entry(tmp_entry), 0);
 			}
 			cur_order = split_order;
 			split_order = xas_try_split_min_order(split_order);
diff --git a/mm/swap.h b/mm/swap.h
index c1e7d4713bd7..238d96869432 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -10,10 +10,10 @@ extern int page_cluster;
 
 #ifdef CONFIG_THP_SWAP
 #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
-#define swap_entry_order(order)	(order)
+#define swap_slot_order(order)	(order)
 #else
 #define SWAPFILE_CLUSTER	256
-#define swap_entry_order(order)	0
+#define swap_slot_order(order)	0
 #endif
 
 extern struct swap_info_struct *swap_info[];
@@ -57,9 +57,9 @@ enum swap_cluster_flags {
 #include <linux/swapops.h> /* for swp_offset */
 #include <linux/blk_types.h> /* for bio_end_io_t */
 
-static inline unsigned int swp_cluster_offset(swp_entry_t entry)
+static inline unsigned int swp_cluster_offset(swp_slot_t slot)
 {
-	return swp_offset(entry) % SWAPFILE_CLUSTER;
+	return swp_slot_offset(slot) % SWAPFILE_CLUSTER;
 }
 
 /*
@@ -75,9 +75,9 @@ static inline struct swap_info_struct *__swap_type_to_info(int type)
 	return si;
 }
 
-static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
+static inline struct swap_info_struct *__swap_slot_to_info(swp_slot_t slot)
 {
-	return __swap_type_to_info(swp_type(entry));
+	return __swap_type_to_info(swp_slot_type(slot));
 }
 
 static inline struct swap_cluster_info *__swap_offset_to_cluster(
@@ -88,10 +88,10 @@ static inline struct swap_cluster_info *__swap_offset_to_cluster(
 	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
 }
 
-static inline struct swap_cluster_info *__swap_entry_to_cluster(swp_entry_t entry)
+static inline struct swap_cluster_info *__swap_slot_to_cluster(swp_slot_t slot)
 {
-	return __swap_offset_to_cluster(__swap_entry_to_info(entry),
-					swp_offset(entry));
+	return __swap_offset_to_cluster(__swap_slot_to_info(slot),
+					swp_slot_offset(slot));
 }
 
 /**
@@ -153,12 +153,10 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 	return &swap_space;
 }
 
-/*
- * Return the swap device position of the swap entry.
- */
-static inline loff_t swap_dev_pos(swp_entry_t entry)
+/* Return the swap device position of the swap slot. */
+static inline loff_t swap_slot_pos(swp_slot_t slot)
 {
-	return ((loff_t)swp_offset(entry)) << PAGE_SHIFT;
+	return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
 }
 
 /**
@@ -221,7 +219,9 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
 {
-	return __swap_entry_to_info(folio->swap)->flags;
+	swp_slot_t swp_slot = swp_entry_to_swp_slot(folio->swap);
+
+	return __swap_slot_to_info(swp_slot)->flags;
 }
 
 /*
@@ -232,8 +232,9 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 		bool *is_zeromap)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(entry);
-	unsigned long start = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *sis = __swap_slot_to_info(slot);
+	unsigned long start = swp_slot_offset(slot);
 	unsigned long end = start + max_nr;
 	bool first_bit;
 
@@ -251,8 +252,9 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 
 static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 {
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
-	pgoff_t offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *si = __swap_slot_to_info(slot);
+	pgoff_t offset = swp_slot_offset(slot);
 	int i;
 
 	/*
@@ -271,7 +273,7 @@ static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline struct swap_cluster_info *swap_cluster_lock(
-	struct swap_info_struct *si, pgoff_t offset, bool irq)
+	struct swap_info_struct *si, unsigned long offset)
 {
 	return NULL;
 }
@@ -280,7 +282,7 @@ static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
 {
 }
 
-static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
+static inline struct swap_info_struct *__swap_slot_to_info(swp_slot_t slot)
 {
 	return NULL;
 }
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index de779fed8c21..77ce1d66c318 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -65,13 +65,14 @@ void swap_cgroup_record(struct folio *folio, unsigned short id,
 			swp_entry_t ent)
 {
 	unsigned int nr_ents = folio_nr_pages(folio);
+	swp_slot_t slot = swp_entry_to_swp_slot(ent);
 	struct swap_cgroup *map;
 	pgoff_t offset, end;
 	unsigned short old;
 
-	offset = swp_offset(ent);
+	offset = swp_slot_offset(slot);
 	end = offset + nr_ents;
-	map = swap_cgroup_ctrl[swp_type(ent)].map;
+	map = swap_cgroup_ctrl[swp_slot_type(slot)].map;
 
 	do {
 		old = __swap_cgroup_id_xchg(map, offset, id);
@@ -92,13 +93,13 @@ void swap_cgroup_record(struct folio *folio, unsigned short id,
  */
 unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents)
 {
-	pgoff_t offset, end;
+	swp_slot_t slot = swp_entry_to_swp_slot(ent);
+	pgoff_t offset = swp_slot_offset(slot);
+	pgoff_t end = offset + nr_ents;
 	struct swap_cgroup *map;
 	unsigned short old, iter = 0;
 
-	offset = swp_offset(ent);
-	end = offset + nr_ents;
-	map = swap_cgroup_ctrl[swp_type(ent)].map;
+	map = swap_cgroup_ctrl[swp_slot_type(slot)].map;
 
 	do {
 		old = __swap_cgroup_id_xchg(map, offset, 0);
@@ -119,12 +120,13 @@ unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents)
 unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 {
 	struct swap_cgroup_ctrl *ctrl;
+	swp_slot_t slot = swp_entry_to_swp_slot(ent);
 
 	if (mem_cgroup_disabled())
 		return 0;
 
-	ctrl = &swap_cgroup_ctrl[swp_type(ent)];
-	return __swap_cgroup_id_lookup(ctrl->map, swp_offset(ent));
+	ctrl = &swap_cgroup_ctrl[swp_slot_type(slot)];
+	return __swap_cgroup_id_lookup(ctrl->map, swp_slot_offset(slot));
 }
 
 int swap_cgroup_swapon(int type, unsigned long max_pages)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 7647341e00ed..6714d59fb108 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -422,7 +422,8 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct mempolicy *mpol, pgoff_t ilx, bool *new_page_allocated,
 		bool skip_if_exists)
 {
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
+	struct swap_info_struct *si =
+		__swap_slot_to_info(swp_entry_to_swp_slot(entry));
 	struct folio *folio;
 	struct folio *new_folio = NULL;
 	struct folio *result = NULL;
@@ -637,11 +638,12 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 				    struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct folio *folio;
-	unsigned long entry_offset = swp_offset(entry);
-	unsigned long offset = entry_offset;
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	unsigned long slot_offset = swp_slot_offset(slot);
+	unsigned long offset = slot_offset;
 	unsigned long start_offset, end_offset;
 	unsigned long mask;
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
+	struct swap_info_struct *si = __swap_slot_to_info(slot);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
 	bool page_allocated;
@@ -662,13 +664,13 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
 		folio = __read_swap_cache_async(
-				swp_entry(swp_type(entry), offset),
+				swp_slot_to_swp_entry(swp_slot(swp_slot_type(slot), offset)),
 				gfp_mask, mpol, ilx, &page_allocated, false);
 		if (!folio)
 			continue;
 		if (page_allocated) {
 			swap_read_folio(folio, &splug);
-			if (offset != entry_offset) {
+			if (offset != slot_offset) {
 				folio_set_readahead(folio);
 				count_vm_event(SWAP_RA);
 			}
@@ -780,16 +782,20 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		/*
 		 * Readahead entry may come from a device that we are not
 		 * holding a reference to, try to grab a reference, or skip.
+		 *
+		 * XXX: for now, always try to pin the swap entries in the
+		 * readahead window to avoid the annoying conversion to physical
+		 * swap slots. Once we move all swap metadata to virtual swap
+		 * layer, we can simply compare the clusters of the target
+		 * swap entry and the current swap entry, and pin the latter
+		 * swap entry's cluster if it differ from the former's.
 		 */
-		if (swp_type(entry) != swp_type(targ_entry)) {
-			swapoff_locked = tryget_swap_entry(entry, &si);
-			if (!swapoff_locked)
-				continue;
-		}
+		swapoff_locked = tryget_swap_entry(entry, &si);
+		if (!swapoff_locked)
+			continue;
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
-		if (swapoff_locked)
-			put_swap_entry(entry, si);
+		put_swap_entry(entry, si);
 		if (!folio)
 			continue;
 		if (page_allocated) {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0471a965f222..6b155471941c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -53,9 +53,9 @@
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
-static void swap_entries_free(struct swap_info_struct *si,
+static void swap_slots_free(struct swap_info_struct *si,
 			      struct swap_cluster_info *ci,
-			      swp_entry_t entry, unsigned int nr_pages);
+			      swp_slot_t slot, unsigned int nr_pages);
 static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries);
 static bool folio_swapcache_freeable(struct folio *folio);
@@ -126,7 +126,7 @@ struct percpu_swap_cluster {
 
 static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.si = { NULL },
-	.offset = { SWAP_ENTRY_INVALID },
+	.offset = { SWAP_SLOT_INVALID },
 	.lock = INIT_LOCAL_LOCK(),
 };
 
@@ -139,9 +139,9 @@ static struct swap_info_struct *swap_type_to_info(int type)
 }
 
 /* May return NULL on invalid entry, caller must check for NULL return */
-static struct swap_info_struct *swap_entry_to_info(swp_entry_t entry)
+static struct swap_info_struct *swap_slot_to_info(swp_slot_t slot)
 {
-	return swap_type_to_info(swp_type(entry));
+	return swap_type_to_info(swp_slot_type(slot));
 }
 
 static inline unsigned char swap_count(unsigned char ent)
@@ -204,9 +204,11 @@ static bool swap_only_has_cache(struct swap_info_struct *si,
  */
 bool is_swap_cached(swp_entry_t entry)
 {
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *si = swap_slot_to_info(slot);
+	unsigned long offset = swp_slot_offset(slot);
 
-	return READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE;
+	return READ_ONCE(si->swap_map[offset]) & SWAP_HAS_CACHE;
 }
 
 static bool swap_is_last_map(struct swap_info_struct *si,
@@ -236,7 +238,9 @@ static bool swap_is_last_map(struct swap_info_struct *si,
 static int __try_to_reclaim_swap(struct swap_info_struct *si,
 				 unsigned long offset, unsigned long flags)
 {
-	const swp_entry_t entry = swp_entry(si->type, offset);
+	const swp_entry_t entry =
+		swp_slot_to_swp_entry(swp_slot(si->type, offset));
+	swp_slot_t slot;
 	struct swap_cluster_info *ci;
 	struct folio *folio;
 	int ret, nr_pages;
@@ -268,7 +272,8 @@ static int __try_to_reclaim_swap(struct swap_info_struct *si,
 		folio_put(folio);
 		goto again;
 	}
-	offset = swp_offset(folio->swap);
+	slot = swp_entry_to_swp_slot(folio->swap);
+	offset = swp_slot_offset(slot);
 
 	need_reclaim = ((flags & TTRS_ANYWAY) ||
 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
@@ -368,12 +373,12 @@ offset_to_swap_extent(struct swap_info_struct *sis, unsigned long offset)
 
 sector_t swap_folio_sector(struct folio *folio)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
+	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 	struct swap_extent *se;
 	sector_t sector;
-	pgoff_t offset;
+	pgoff_t offset = swp_slot_offset(slot);
 
-	offset = swp_offset(folio->swap);
 	se = offset_to_swap_extent(sis, offset);
 	sector = se->start_block + (offset - se->start_page);
 	return sector << (PAGE_SHIFT - 9);
@@ -890,7 +895,7 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 					    unsigned int order,
 					    unsigned char usage)
 {
-	unsigned int next = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
+	unsigned int next = SWAP_SLOT_INVALID, found = SWAP_SLOT_INVALID;
 	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
 	unsigned long end = min(start + SWAPFILE_CLUSTER, si->max);
 	unsigned int nr_pages = 1 << order;
@@ -947,7 +952,7 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 					 unsigned char usage,
 					 bool scan_all)
 {
-	unsigned int found = SWAP_ENTRY_INVALID;
+	unsigned int found = SWAP_SLOT_INVALID;
 
 	do {
 		struct swap_cluster_info *ci = isolate_lock_cluster(si, list);
@@ -1017,11 +1022,11 @@ static void swap_reclaim_work(struct work_struct *work)
  * Try to allocate swap entries with specified order and try set a new
  * cluster for current CPU too.
  */
-static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
+static unsigned long cluster_alloc_swap_slot(struct swap_info_struct *si, int order,
 					      unsigned char usage)
 {
 	struct swap_cluster_info *ci;
-	unsigned int offset = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
+	unsigned int offset = SWAP_SLOT_INVALID, found = SWAP_SLOT_INVALID;
 
 	/*
 	 * Swapfile is not block device so unable
@@ -1034,7 +1039,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		/* Serialize HDD SWAP allocation for each device. */
 		spin_lock(&si->global_cluster_lock);
 		offset = si->global_cluster->next[order];
-		if (offset == SWAP_ENTRY_INVALID)
+		if (offset == SWAP_SLOT_INVALID)
 			goto new_cluster;
 
 		ci = swap_cluster_lock(si, offset);
@@ -1255,7 +1260,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	 */
 	for (i = 0; i < nr_entries; i++) {
 		clear_bit(offset + i, si->zeromap);
-		zswap_invalidate(swp_entry(si->type, offset + i));
+		zswap_invalidate(swp_slot_to_swp_entry(swp_slot(si->type, offset + i)));
 	}
 
 	if (si->flags & SWP_BLKDEV)
@@ -1300,12 +1305,11 @@ static bool get_swap_device_info(struct swap_info_struct *si)
  * Fast path try to get swap entries with specified order from current
  * CPU's swap entry pool (a cluster).
  */
-static bool swap_alloc_fast(swp_entry_t *entry,
-			    int order)
+static bool swap_alloc_fast(swp_slot_t *slot, int order)
 {
 	struct swap_cluster_info *ci;
 	struct swap_info_struct *si;
-	unsigned int offset, found = SWAP_ENTRY_INVALID;
+	unsigned int offset, found = SWAP_SLOT_INVALID;
 
 	/*
 	 * Once allocated, swap_info_struct will never be completely freed,
@@ -1322,18 +1326,17 @@ static bool swap_alloc_fast(swp_entry_t *entry,
 			offset = cluster_offset(si, ci);
 		found = alloc_swap_scan_cluster(si, ci, offset, order, SWAP_HAS_CACHE);
 		if (found)
-			*entry = swp_entry(si->type, found);
+			*slot = swp_slot(si->type, found);
 	} else {
 		swap_cluster_unlock(ci);
 	}
 
-	put_swap_device(si);
+	swap_slot_put_swap_info(si);
 	return !!found;
 }
 
 /* Rotate the device and switch to a new cluster */
-static void swap_alloc_slow(swp_entry_t *entry,
-			    int order)
+static void swap_alloc_slow(swp_slot_t *slot, int order)
 {
 	unsigned long offset;
 	struct swap_info_struct *si, *next;
@@ -1345,10 +1348,10 @@ static void swap_alloc_slow(swp_entry_t *entry,
 		plist_requeue(&si->avail_list, &swap_avail_head);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			offset = cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE);
-			put_swap_device(si);
+			offset = cluster_alloc_swap_slot(si, order, SWAP_HAS_CACHE);
+			swap_slot_put_swap_info(si);
 			if (offset) {
-				*entry = swp_entry(si->type, offset);
+				*slot = swp_slot(si->type, offset);
 				return;
 			}
 			if (order)
@@ -1388,7 +1391,7 @@ static bool swap_sync_discard(void)
 		if (get_swap_device_info(si)) {
 			if (si->flags & SWP_PAGE_DISCARD)
 				ret = swap_do_scheduled_discard(si);
-			put_swap_device(si);
+			swap_slot_put_swap_info(si);
 		}
 		if (ret)
 			return true;
@@ -1402,25 +1405,9 @@ static bool swap_sync_discard(void)
 	return false;
 }
 
-/**
- * folio_alloc_swap - allocate swap space for a folio
- * @folio: folio we want to move to swap
- *
- * Allocate swap space for the folio and add the folio to the
- * swap cache.
- *
- * Context: Caller needs to hold the folio lock.
- * Return: Whether the folio was added to the swap cache.
- */
-int folio_alloc_swap(struct folio *folio)
+static int swap_slot_alloc(swp_slot_t *slot, unsigned int order)
 {
-	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
-	swp_entry_t entry = {};
-	int err;
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
 
 	if (order) {
 		/*
@@ -1442,22 +1429,52 @@ int folio_alloc_swap(struct folio *folio)
 
 again:
 	local_lock(&percpu_swap_cluster.lock);
-	if (!swap_alloc_fast(&entry, order))
-		swap_alloc_slow(&entry, order);
+	if (!swap_alloc_fast(slot, order))
+		swap_alloc_slow(slot, order);
 	local_unlock(&percpu_swap_cluster.lock);
 
-	if (unlikely(!order && !entry.val)) {
+	if (unlikely(!order && !slot->val)) {
 		if (swap_sync_discard())
 			goto again;
 	}
 
+	return 0;
+}
+
+/**
+ * folio_alloc_swap - allocate swap space for a folio
+ * @folio: folio we want to move to swap
+ *
+ * Allocate swap space for the folio and add the folio to the
+ * swap cache.
+ *
+ * Context: Caller needs to hold the folio lock.
+ * Return: Whether the folio was added to the swap cache.
+ */
+int folio_alloc_swap(struct folio *folio)
+{
+	unsigned int order = folio_order(folio);
+	swp_slot_t slot = { 0 };
+	swp_entry_t entry = {};
+	int err = 0, ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
+
+	ret = swap_slot_alloc(&slot, order);
+	if (ret)
+		return ret;
+
+	/* XXX: for now, physical and virtual swap slots are identical */
+	entry.val = slot.val;
+
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
 	if (mem_cgroup_try_charge_swap(folio, entry)) {
 		err = -ENOMEM;
 		goto out_free;
 	}
 
-	if (!entry.val)
+	if (!slot.val)
 		return -ENOMEM;
 
 	err = swap_cache_add_folio(folio, entry,
@@ -1473,46 +1490,46 @@ int folio_alloc_swap(struct folio *folio)
 	return err;
 }
 
-static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
+static struct swap_info_struct *_swap_info_get(swp_slot_t slot)
 {
 	struct swap_info_struct *si;
 	unsigned long offset;
 
-	if (!entry.val)
+	if (!slot.val)
 		goto out;
-	si = swap_entry_to_info(entry);
+	si = swap_slot_to_info(slot);
 	if (!si)
 		goto bad_nofile;
 	if (data_race(!(si->flags & SWP_USED)))
 		goto bad_device;
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 	if (offset >= si->max)
 		goto bad_offset;
-	if (data_race(!si->swap_map[swp_offset(entry)]))
+	if (data_race(!si->swap_map[swp_slot_offset(slot)]))
 		goto bad_free;
 	return si;
 
 bad_free:
-	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Unused_offset, slot.val);
 	goto out;
 bad_offset:
-	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_offset, slot.val);
 	goto out;
 bad_device:
-	pr_err("%s: %s%08lx\n", __func__, Unused_file, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Unused_file, slot.val);
 	goto out;
 bad_nofile:
-	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_file, slot.val);
 out:
 	return NULL;
 }
 
-static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
+static unsigned char swap_slot_put_locked(struct swap_info_struct *si,
 					   struct swap_cluster_info *ci,
-					   swp_entry_t entry,
+					   swp_slot_t slot,
 					   unsigned char usage)
 {
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 	unsigned char count;
 	unsigned char has_cache;
 
@@ -1544,7 +1561,7 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
 	if (usage)
 		WRITE_ONCE(si->swap_map[offset], usage);
 	else
-		swap_entries_free(si, ci, entry, 1);
+		swap_slots_free(si, ci, slot, 1);
 
 	return usage;
 }
@@ -1554,8 +1571,9 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
  * prevent swapoff, such as the folio in swap cache is locked, RCU
  * reader side is locked, etc., the swap entry may become invalid
  * because of swapoff.  Then, we need to enclose all swap related
- * functions with get_swap_device() and put_swap_device(), unless the
- * swap functions call get/put_swap_device() by themselves.
+ * functions with swap_slot_tryget_swap_info() and
+ * swap_slot_put_swap_info(), unless the swap functions call
+ * swap_slot_(tryget|put)_swap_info by themselves.
  *
  * RCU reader side lock (including any spinlock) is sufficient to
  * prevent swapoff, because synchronize_rcu() is called in swapoff()
@@ -1564,11 +1582,11 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
- * put_swap_device() is called.  Otherwise return NULL.
+ * swap_slot_put_swap_info() is called.  Otherwise return NULL.
  *
  * Notice that swapoff or swapoff+swapon can still happen before the
- * percpu_ref_tryget_live() in get_swap_device() or after the
- * percpu_ref_put() in put_swap_device() if there isn't any other way
+ * percpu_ref_tryget_live() in swap_slot_tryget_swap_info() or after the
+ * percpu_ref_put() in swap_slot_put_swap_info() if there isn't any other way
  * to prevent swapoff.  The caller must be prepared for that.  For
  * example, the following situation is possible.
  *
@@ -1588,53 +1606,53 @@ static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
  * changed with the page table locked to check whether the swap device
  * has been swapoff or swapoff+swapon.
  */
-struct swap_info_struct *get_swap_device(swp_entry_t entry)
+struct swap_info_struct *swap_slot_tryget_swap_info(swp_slot_t slot)
 {
 	struct swap_info_struct *si;
 	unsigned long offset;
 
-	if (!entry.val)
+	if (!slot.val)
 		goto out;
-	si = swap_entry_to_info(entry);
+	si = swap_slot_to_info(slot);
 	if (!si)
 		goto bad_nofile;
 	if (!get_swap_device_info(si))
 		goto out;
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 	if (offset >= si->max)
 		goto put_out;
 
 	return si;
 bad_nofile:
-	pr_err("%s: %s%08lx\n", __func__, Bad_file, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_file, slot.val);
 out:
 	return NULL;
 put_out:
-	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
+	pr_err("%s: %s%08lx\n", __func__, Bad_offset, slot.val);
 	percpu_ref_put(&si->users);
 	return NULL;
 }
 
-static void swap_entries_put_cache(struct swap_info_struct *si,
-				   swp_entry_t entry, int nr)
+static void swap_slots_put_cache(struct swap_info_struct *si,
+				   swp_slot_t slot, int nr)
 {
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 	struct swap_cluster_info *ci;
 
 	ci = swap_cluster_lock(si, offset);
 	if (swap_only_has_cache(si, offset, nr)) {
-		swap_entries_free(si, ci, entry, nr);
+		swap_slots_free(si, ci, slot, nr);
 	} else {
-		for (int i = 0; i < nr; i++, entry.val++)
-			swap_entry_put_locked(si, ci, entry, SWAP_HAS_CACHE);
+		for (int i = 0; i < nr; i++, slot.val++)
+			swap_slot_put_locked(si, ci, slot, SWAP_HAS_CACHE);
 	}
 	swap_cluster_unlock(ci);
 }
 
-static bool swap_entries_put_map(struct swap_info_struct *si,
-				 swp_entry_t entry, int nr)
+static bool swap_slots_put_map(struct swap_info_struct *si,
+				 swp_slot_t slot, int nr)
 {
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 	struct swap_cluster_info *ci;
 	bool has_cache = false;
 	unsigned char count;
@@ -1651,7 +1669,7 @@ static bool swap_entries_put_map(struct swap_info_struct *si,
 		goto locked_fallback;
 	}
 	if (!has_cache)
-		swap_entries_free(si, ci, entry, nr);
+		swap_slots_free(si, ci, slot, nr);
 	else
 		for (i = 0; i < nr; i++)
 			WRITE_ONCE(si->swap_map[offset + i], SWAP_HAS_CACHE);
@@ -1662,8 +1680,8 @@ static bool swap_entries_put_map(struct swap_info_struct *si,
 fallback:
 	ci = swap_cluster_lock(si, offset);
 locked_fallback:
-	for (i = 0; i < nr; i++, entry.val++) {
-		count = swap_entry_put_locked(si, ci, entry, 1);
+	for (i = 0; i < nr; i++, slot.val++) {
+		count = swap_slot_put_locked(si, ci, slot, 1);
 		if (count == SWAP_HAS_CACHE)
 			has_cache = true;
 	}
@@ -1676,20 +1694,20 @@ static bool swap_entries_put_map(struct swap_info_struct *si,
  * cross multi clusters, so ensure the range is within a single cluster
  * when freeing entries with functions without "_nr" suffix.
  */
-static bool swap_entries_put_map_nr(struct swap_info_struct *si,
-				    swp_entry_t entry, int nr)
+static bool swap_slots_put_map_nr(struct swap_info_struct *si,
+				    swp_slot_t slot, int nr)
 {
 	int cluster_nr, cluster_rest;
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 	bool has_cache = false;
 
 	cluster_rest = SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER;
 	while (nr) {
 		cluster_nr = min(nr, cluster_rest);
-		has_cache |= swap_entries_put_map(si, entry, cluster_nr);
+		has_cache |= swap_slots_put_map(si, slot, cluster_nr);
 		cluster_rest = SWAPFILE_CLUSTER;
 		nr -= cluster_nr;
-		entry.val += cluster_nr;
+		slot.val += cluster_nr;
 	}
 
 	return has_cache;
@@ -1709,13 +1727,14 @@ static inline bool __maybe_unused swap_is_last_ref(unsigned char count)
  * Drop the last ref of swap entries, caller have to ensure all entries
  * belong to the same cgroup and cluster.
  */
-static void swap_entries_free(struct swap_info_struct *si,
+static void swap_slots_free(struct swap_info_struct *si,
 			      struct swap_cluster_info *ci,
-			      swp_entry_t entry, unsigned int nr_pages)
+			      swp_slot_t slot, unsigned int nr_pages)
 {
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
+	swp_entry_t entry = swp_slot_to_swp_entry(slot);
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != __swap_offset_to_cluster(si, offset + nr_pages - 1));
@@ -1741,43 +1760,54 @@ static void swap_entries_free(struct swap_info_struct *si,
  * Caller has made sure that the swap device corresponding to entry
  * is still around or has not been recycled.
  */
-void swap_free_nr(swp_entry_t entry, int nr_pages)
+void swap_slot_free_nr(swp_slot_t slot, int nr_pages)
 {
 	int nr;
 	struct swap_info_struct *sis;
-	unsigned long offset = swp_offset(entry);
+	unsigned long offset = swp_slot_offset(slot);
 
-	sis = _swap_info_get(entry);
+	sis = _swap_info_get(slot);
 	if (!sis)
 		return;
 
 	while (nr_pages) {
 		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-		swap_entries_put_map(sis, swp_entry(sis->type, offset), nr);
+		swap_slots_put_map(sis, swp_slot(sis->type, offset), nr);
 		offset += nr;
 		nr_pages -= nr;
 	}
 }
 
+/*
+ * Caller has made sure that the swap device corresponding to entry
+ * is still around or has not been recycled.
+ */
+void swap_free_nr(swp_entry_t entry, int nr_pages)
+{
+	swap_slot_free_nr(swp_entry_to_swp_slot(entry), nr_pages);
+}
+
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
 void put_swap_folio(struct folio *folio, swp_entry_t entry)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	struct swap_info_struct *si;
-	int size = 1 << swap_entry_order(folio_order(folio));
+	int size = 1 << swap_slot_order(folio_order(folio));
 
-	si = _swap_info_get(entry);
+	si = _swap_info_get(slot);
 	if (!si)
 		return;
 
-	swap_entries_put_cache(si, entry, size);
+	swap_slots_put_cache(si, slot, size);
 }
 
 int __swap_count(swp_entry_t entry)
 {
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
-	pgoff_t offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *si = __swap_slot_to_info(slot);
+	pgoff_t offset = swp_slot_offset(slot);
 
 	return swap_count(si->swap_map[offset]);
 }
@@ -1789,7 +1819,8 @@ int __swap_count(swp_entry_t entry)
  */
 bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
 {
-	pgoff_t offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	pgoff_t offset = swp_slot_offset(slot);
 	struct swap_cluster_info *ci;
 	int count;
 
@@ -1805,6 +1836,7 @@ bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry)
  */
 int swp_swapcount(swp_entry_t entry)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	int count, tmp_count, n;
 	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
@@ -1812,11 +1844,11 @@ int swp_swapcount(swp_entry_t entry)
 	pgoff_t offset;
 	unsigned char *map;
 
-	si = _swap_info_get(entry);
+	si = _swap_info_get(slot);
 	if (!si)
 		return 0;
 
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 
 	ci = swap_cluster_lock(si, offset);
 
@@ -1848,10 +1880,11 @@ int swp_swapcount(swp_entry_t entry)
 static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 					 swp_entry_t entry, int order)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	struct swap_cluster_info *ci;
 	unsigned char *map = si->swap_map;
 	unsigned int nr_pages = 1 << order;
-	unsigned long roffset = swp_offset(entry);
+	unsigned long roffset = swp_slot_offset(slot);
 	unsigned long offset = round_down(roffset, nr_pages);
 	int i;
 	bool ret = false;
@@ -1876,7 +1909,8 @@ static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
 static bool folio_swapped(struct folio *folio)
 {
 	swp_entry_t entry = folio->swap;
-	struct swap_info_struct *si = _swap_info_get(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	struct swap_info_struct *si = _swap_info_get(slot);
 
 	if (!si)
 		return false;
@@ -1950,13 +1984,14 @@ bool folio_free_swap(struct folio *folio)
  */
 void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 {
-	const unsigned long start_offset = swp_offset(entry);
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+	const unsigned long start_offset = swp_slot_offset(slot);
 	const unsigned long end_offset = start_offset + nr;
 	struct swap_info_struct *si;
 	bool any_only_cache = false;
 	unsigned long offset;
 
-	si = get_swap_device(entry);
+	si = swap_slot_tryget_swap_info(slot);
 	if (!si)
 		return;
 
@@ -1966,7 +2001,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	/*
 	 * First free all entries in the range.
 	 */
-	any_only_cache = swap_entries_put_map_nr(si, entry, nr);
+	any_only_cache = swap_slots_put_map_nr(si, slot, nr);
 
 	/*
 	 * Short-circuit the below loop if none of the entries had their
@@ -2000,16 +2035,16 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	}
 
 out:
-	put_swap_device(si);
+	swap_slot_put_swap_info(si);
 }
 
 #ifdef CONFIG_HIBERNATION
 
-swp_entry_t get_swap_page_of_type(int type)
+swp_slot_t swap_slot_alloc_of_type(int type)
 {
 	struct swap_info_struct *si = swap_type_to_info(type);
 	unsigned long offset;
-	swp_entry_t entry = {0};
+	swp_slot_t slot = {0};
 
 	if (!si)
 		goto fail;
@@ -2022,15 +2057,15 @@ swp_entry_t get_swap_page_of_type(int type)
 			 * with swap table allocation.
 			 */
 			local_lock(&percpu_swap_cluster.lock);
-			offset = cluster_alloc_swap_entry(si, 0, 1);
+			offset = cluster_alloc_swap_slot(si, 0, 1);
 			local_unlock(&percpu_swap_cluster.lock);
 			if (offset)
-				entry = swp_entry(si->type, offset);
+				slot = swp_slot(si->type, offset);
 		}
-		put_swap_device(si);
+		swap_slot_put_swap_info(si);
 	}
 fail:
-	return entry;
+	return slot;
 }
 
 /*
@@ -2259,6 +2294,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long offset;
 		unsigned char swp_count;
 		softleaf_t entry;
+		swp_slot_t slot;
 		int ret;
 		pte_t ptent;
 
@@ -2273,10 +2309,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		if (!softleaf_is_swap(entry))
 			continue;
-		if (swp_type(entry) != type)
+
+		slot = swp_entry_to_swp_slot(entry);
+		if (swp_slot_type(slot) != type)
 			continue;
 
-		offset = swp_offset(entry);
+		offset = swp_slot_offset(slot);
 		pte_unmap(pte);
 		pte = NULL;
 
@@ -2461,6 +2499,7 @@ static int try_to_unuse(unsigned int type)
 	struct swap_info_struct *si = swap_info[type];
 	struct folio *folio;
 	swp_entry_t entry;
+	swp_slot_t slot;
 	unsigned int i;
 
 	if (!swap_usage_in_pages(si))
@@ -2508,7 +2547,8 @@ static int try_to_unuse(unsigned int type)
 	       !signal_pending(current) &&
 	       (i = find_next_to_unuse(si, i)) != 0) {
 
-		entry = swp_entry(type, i);
+		slot = swp_slot(type, i);
+		entry = swp_slot_to_swp_entry(slot);
 		folio = swap_cache_get_folio(entry);
 		if (!folio)
 			continue;
@@ -2892,7 +2932,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	}
 
 	/*
-	 * Wait for swap operations protected by get/put_swap_device()
+	 * Wait for swap operations protected by swap_slot_(tryget|put)_swap_info()
 	 * to complete.  Because of synchronize_rcu() here, all swap
 	 * operations protected by RCU reader side lock (including any
 	 * spinlock) will be waited too.  This makes it easy to
@@ -3333,7 +3373,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 		if (!si->global_cluster)
 			goto err;
 		for (i = 0; i < SWAP_NR_ORDERS; i++)
-			si->global_cluster->next[i] = SWAP_ENTRY_INVALID;
+			si->global_cluster->next[i] = SWAP_SLOT_INVALID;
 		spin_lock_init(&si->global_cluster_lock);
 	}
 
@@ -3671,6 +3711,7 @@ void si_swapinfo(struct sysinfo *val)
  */
 static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 {
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
 	unsigned long offset;
@@ -3678,13 +3719,13 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 	unsigned char has_cache;
 	int err, i;
 
-	si = swap_entry_to_info(entry);
+	si = swap_slot_to_info(slot);
 	if (WARN_ON_ONCE(!si)) {
 		pr_err("%s%08lx\n", Bad_file, entry.val);
 		return -EINVAL;
 	}
 
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
 	VM_WARN_ON(usage == 1 && nr > 1);
 	ci = swap_cluster_lock(si, offset);
@@ -3790,7 +3831,7 @@ int swapcache_prepare(swp_entry_t entry, int nr)
  */
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
 {
-	swap_entries_put_cache(si, entry, nr);
+	swap_slots_put_cache(si, swp_entry_to_swp_slot(entry), nr);
 }
 
 /*
@@ -3817,6 +3858,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	struct page *list_page;
 	pgoff_t offset;
 	unsigned char count;
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
 	int ret = 0;
 
 	/*
@@ -3825,7 +3867,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	 */
 	page = alloc_page(gfp_mask | __GFP_HIGHMEM);
 
-	si = get_swap_device(entry);
+	si = swap_slot_tryget_swap_info(slot);
 	if (!si) {
 		/*
 		 * An acceptable race has occurred since the failing
@@ -3834,7 +3876,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 		goto outer;
 	}
 
-	offset = swp_offset(entry);
+	offset = swp_slot_offset(slot);
 
 	ci = swap_cluster_lock(si, offset);
 
@@ -3897,7 +3939,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 	spin_unlock(&si->cont_lock);
 out:
 	swap_cluster_unlock(ci);
-	put_swap_device(si);
+	swap_slot_put_swap_info(si);
 outer:
 	if (page)
 		__free_page(page);
-- 
2.52.0


