Return-Path: <cgroups+bounces-15614-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GM7MpkQ+mntIgMAu9opvQ
	(envelope-from <cgroups+bounces-15614-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:45:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F374D0779
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A85230C3B03
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACDE48AE12;
	Tue,  5 May 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V54IVMKd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8892A48C3E1
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995562; cv=none; b=SaCf7KmAxFy+H/NLG8JfgqfkMRRZ1p6xULYKVF7z4GLMSlc/hv7rmxWgubJ6v8ERNztPOU5b2klisNax7AWe0Qg62XdiFgaia3BQSZcIG6eUqvFn9ou4Vfccrs9u9HXx4NKnnRTgdipl1oB1gO1e7+K2EXPp4VuH7wnDK3p9qSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995562; c=relaxed/simple;
	bh=rxLx6wBQe/bnJm78Db27bjdPl46mqPdtucl7ho+vOPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikNsNuUqODYBH1t9qa7bNGsn7esJQr1uN4xrejAAc7ICoOooMdBOVJFZgf98KIILZAfxKRRNYVWNE6KEg5mn3kG00WxFparJ5uS2AkWyIH5rLgjBmK0ePpYGZT165lGZpisTTaG5PkdfwT9y/oSLryrrOrUnyHYqubI8hS3FWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V54IVMKd; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-479d593a0c3so5254b6e.0
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995558; x=1778600358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e35P/OP06CBwJ2CvgGAm38hrV6M0VW30Y7aJyYxGvPg=;
        b=V54IVMKdYcLdhf9GPl1F6vBQcT8eu5APn59CESVdhdN0aOmtQ/AZv6DnLgRRWjEWn9
         YefAjhwmgVFFgHlZPwcY3tyRkvhvb2hMH+slWo9yWg6jRPHk3MsYM+qcdr/AAFO8kYEO
         70kMGpXwDrrA64T1NO2QVuHniGmy0CqLlDLVXyqTd1AGlgC31XU8WuRYgpCT1cx/OWyq
         d0z1FcTbUYY7DH4zRbSv9N/sZYbYpZnWSXrayCM+uVGOlTQ/q6DIpTnsFDjfYFrUhWqj
         Vpgcj6w/wp3zfG3r8a2aosqV42YLunUBsrtIN6fk3LqfVsXjowo7NmxBMCAoeiP6BCMm
         j8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995558; x=1778600358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e35P/OP06CBwJ2CvgGAm38hrV6M0VW30Y7aJyYxGvPg=;
        b=n5iQelN+yIhfqhpTSiyG0+gyT4zhW58P01PMVS5Dmkzi34CN298nCgFxBvy/2dJnKy
         Lj7cuRhZ/xor1ILyZ8fl69ajxCaw9Fg11736p6hOdVq7UU3teyVXYuljc5UNuVY7RIk6
         UkoKA5Qex2RjZnxtHiItoQAmXEbPD1PQrDah30FzugJ6SOp1DV0TrUCud6bl/RBN412P
         gqaWEhtjjhwigmAbI+FTRfPlAAV/RZZfBsdB7/sgqKTwOzQjZuD2gMuc3Vd4vWDsbEok
         cvzRJ016+s5Xe5HM+Lh/Ey06hpeyLgHUn8F09ellt3zxGGGrNvKDlzsZn6hBzoBPlQ2n
         49Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+K01rrAjXKXzl/IQJslwv4fHJJ0CMwypDWnWi38ZbYPuzf4lWNUDX2kdS4gS5iOuS37l2861zd@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgxoh+FGWDnBDHz8YX6nu7k9vW4ExNyU7mcjQIAgykKiLgmS1b
	27ru/1TzvxignwFg5o9r8Wa8phx5Z41LjBzJs+JkXjrrXIyatLBMqv/O
X-Gm-Gg: AeBDievHXq2oJVzBa3p8oufTJg4AtW42tTRRzf7HqEnf5zWEo2pm+uDQmvC29L/jj4M
	kuP4s2Sjtem7IPeg7rAzT8RvdqI2NOFlLgbSmiw14BR7B0yr14RWInSFbEnUgk4ThN6uVAnpqY/
	AQc526JZ0vq8Y6/uWxWIh8r8uaOun/rvOGbeUcc0fF3KH7zoSrLOJjNRucfolrwTmTNhwfdKpy7
	d/ilI0gXkasqGu61unTpQUywuJ7kp72ixwSlu4AceYhk1SY1Uutpcx+nb5jVZl92Tr4vhLoTrBq
	C6Io0ZGtBfOL4B2y3s7AofFkohIt07/B+Q/jwD5NMF6QlE9pNF6V6S/gr/LdmK+TiiQNmbkxXcp
	4ZGsM2977s5AfgI6kY0ECeBJ/bqvGWtw2n6L3j3+EnO4Xex9f9Pvb+XBGUvGNGyeo0Gvy03JUvS
	QrlVw5P7F0dG0NLWreoMpJPT3dT4u/WaoAIoB3knYQtvV7xLwhKSETu28=
X-Received: by 2002:a05:6808:1a2a:b0:479:eb0e:670a with SMTP id 5614622812f47-47d365dc22dmr1986221b6e.29.1777995558176;
        Tue, 05 May 2026 08:39:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c769ca2a6sm8651987b6e.18.2026.05.05.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:16 -0700 (PDT)
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
Subject: [PATCH v6 09/22] mm: swap: allocate a virtual swap slot for each swapped out page
Date: Tue,  5 May 2026 08:38:38 -0700
Message-ID: <20260505153854.1612033-10-nphamcs@gmail.com>
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
X-Rspamd-Queue-Id: 20F374D0779
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15614-lists,cgroups=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

For the new virtual swap space design, dynamically allocate a virtual
slot (as well as an associated metadata structure) for each swapped out
page, and associate it to the (physical) swap slot on the swapfile/swap
partition. This virtual swap slot is now stored in page table entries
and used to index into swap data structures (swap cache, zswap tree,
swap cgroup array), in place of the old physical swap slot.

For now, there is always a physical slot in the swapfile associated for
each virtual swap slot (except those about to be freed). The virtual
swap slot's lifetime is still tied to the lifetime of its physical swap
slot. We do change the freeing ordering a bit - we clear the shadow,
invalidate the zswap entry, and uncharge swap cgroup when we release the
virtual swap slot, as we now use virtual swap slot to index into these
swap data structures.

We also repurpose the swap table infrastructure as a reverse map to look
up the virtual swap slot from its associated physical swap slot on
swapfile. This is used in cluster readahead, as well as several swapfile
operations, such as the swap slot reclamation that happens when the
swapfile is almost full.  It will also be used in a future patch that
simplifies swapoff.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/cpuhotplug.h |   1 +
 include/linux/swap.h       |  72 ++--
 mm/internal.h              |  28 +-
 mm/page_io.c               |   6 +-
 mm/shmem.c                 |   9 +-
 mm/swap.h                  |   8 +-
 mm/swap_state.c            |   5 +-
 mm/swapfile.c              |  64 +---
 mm/vswap.c                 | 683 +++++++++++++++++++++++++++++++++++++
 9 files changed, 759 insertions(+), 117 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 62cd7b35a29c..85cb45022e79 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -86,6 +86,7 @@ enum cpuhp_state {
 	CPUHP_FS_BUFF_DEAD,
 	CPUHP_PRINTK_DEAD,
 	CPUHP_MM_MEMCQ_DEAD,
+	CPUHP_MM_VSWAP_DEAD,
 	CPUHP_PERCPU_CNT_DEAD,
 	CPUHP_RADIX_DEAD,
 	CPUHP_PAGE_ALLOC,
diff --git a/include/linux/swap.h b/include/linux/swap.h
index df0771903a95..940f467f2af1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -425,6 +425,12 @@ extern void __meminit kswapd_stop(int nid);
 
 /* Virtual swap space API (mm/vswap.c) */
 int vswap_init(void);
+void vswap_exit(void);
+void vswap_free(swp_entry_t entry, struct swap_cluster_info *ci);
+swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
+swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
+bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si);
+void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si);
 
 /* Lifecycle swap API (mm/swapfile.c) */
 int folio_alloc_swap(struct folio *folio);
@@ -474,6 +480,7 @@ static inline long get_nr_swap_pages(void)
 }
 
 void si_swapinfo(struct sysinfo *);
+int swap_slot_alloc(swp_slot_t *slot, unsigned int order);
 swp_slot_t swap_slot_alloc_of_type(int);
 int add_swap_count_continuation(swp_entry_t, gfp_t);
 int swap_type_of(dev_t device, sector_t offset);
@@ -499,6 +506,29 @@ static inline void swap_slot_put_swap_info(struct swap_info_struct *si)
 {
 }
 
+static inline swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
+{
+	swp_slot_t ret = { .val = 0 };
+	return ret;
+}
+
+static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
+{
+	swp_entry_t ret = { .val = 0 };
+	return ret;
+}
+
+static inline bool tryget_swap_entry(swp_entry_t entry,
+				     struct swap_info_struct **si)
+{
+	return false;
+}
+
+static inline void put_swap_entry(swp_entry_t entry,
+				  struct swap_info_struct *si)
+{
+}
+
 #define get_nr_swap_pages()			0L
 #define total_swap_pages			0L
 #define total_swapcache_pages()			0UL
@@ -672,47 +702,5 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
-/**
- * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
- *                         virtual swap slot.
- * @entry: the virtual swap slot.
- *
- * Return: the physical swap slot corresponding to the virtual swap slot.
- */
-static inline swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
-{
-	return (swp_slot_t) { entry.val };
-}
-
-/**
- * swp_slot_to_swp_entry - look up the virtual swap slot corresponding to a
- *                         physical swap slot.
- * @slot: the physical swap slot.
- *
- * Return: the virtual swap slot corresponding to the physical swap slot.
- */
-static inline swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
-{
-	return (swp_entry_t) { slot.val };
-}
-
-static inline bool tryget_swap_entry(swp_entry_t entry,
-				struct swap_info_struct **sip)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *si = swap_slot_tryget_swap_info(slot);
-
-	if (sip)
-		*sip = si;
-
-	return si;
-}
-
-static inline void put_swap_entry(swp_entry_t entry,
-				struct swap_info_struct *si)
-{
-	swap_slot_put_swap_info(si);
-}
-
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff --git a/mm/internal.h b/mm/internal.h
index e739e8cac5b5..7ced0def684c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -322,6 +322,25 @@ static inline unsigned int folio_pte_batch_flags(struct folio *folio,
 unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
 		unsigned int max_nr);
 
+static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
+{
+	return (swp_entry_t) { entry.val + n };
+}
+
+/* similar to swap_nth, but check the backing physical slots as well. */
+static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
+{
+	swp_slot_t slot = swp_entry_to_swp_slot(entry), next_slot;
+	swp_entry_t next_entry = swap_nth(entry, delta);
+
+	next_slot = swp_entry_to_swp_slot(next_entry);
+	if (swp_slot_type(slot) != swp_slot_type(next_slot) ||
+			swp_slot_offset(slot) + delta != swp_slot_offset(next_slot))
+		next_entry.val = 0;
+
+	return next_entry;
+}
+
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
  *	 forward or backward by delta
@@ -334,13 +353,8 @@ unsigned int folio_pte_batch(struct folio *folio, pte_t *ptep, pte_t pte,
  */
 static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
-	softleaf_t entry = softleaf_from_pte(pte), new_entry;
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	pte_t new;
-
-	new_entry = swp_slot_to_swp_entry(swp_slot(swp_slot_type(slot),
-			swp_slot_offset(slot) + delta));
-	new = swp_entry_to_pte(new_entry);
+	softleaf_t entry = softleaf_from_pte(pte);
+	pte_t new = swp_entry_to_pte(swap_move(entry, delta));
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
diff --git a/mm/page_io.c b/mm/page_io.c
index 0b02bcc85e2a..5de370557295 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -364,7 +364,7 @@ static void sio_write_complete(struct kiocb *iocb, long ret)
 		 */
 		pr_err_ratelimited("Write error %ld on dio swapfile (%llu)\n",
 				   ret,
-				   swap_slot_pos(swp_entry_to_swp_slot(page_swap_entry(page))));
+				   swap_slot_dev_pos(swp_entry_to_swp_slot(page_swap_entry(page))));
 		for (p = 0; p < sio->pages; p++) {
 			page = sio->bvec[p].bv_page;
 			set_page_dirty(page);
@@ -384,7 +384,7 @@ static void swap_writepage_fs(struct folio *folio, struct swap_iocb **swap_plug)
 	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
 	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 	struct file *swap_file = sis->swap_file;
-	loff_t pos = swap_slot_pos(slot);
+	loff_t pos = swap_slot_dev_pos(slot);
 
 	count_swpout_vm_event(folio);
 	folio_start_writeback(folio);
@@ -549,7 +549,7 @@ static void swap_read_folio_fs(struct folio *folio, struct swap_iocb **plug)
 	swp_slot_t slot = swp_entry_to_swp_slot(folio->swap);
 	struct swap_info_struct *sis = __swap_slot_to_info(slot);
 	struct swap_iocb *sio = NULL;
-	loff_t pos = swap_slot_pos(slot);
+	loff_t pos = swap_slot_dev_pos(slot);
 
 	if (plug)
 		sio = *plug;
diff --git a/mm/shmem.c b/mm/shmem.c
index 400e2fa8e77c..13f7469a04c8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2227,7 +2227,6 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, 0);
 	int split_order = 0;
 	int i;
-	swp_slot_t slot = swp_entry_to_swp_slot(swap);
 
 	/* Convert user data gfp flags to xarray node gfp flags */
 	gfp &= GFP_RECLAIM_MASK;
@@ -2268,13 +2267,7 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
 			 */
 			for (i = 0; i < 1 << cur_order;
 			     i += (1 << split_order)) {
-				swp_entry_t tmp_entry;
-				swp_slot_t tmp_slot;
-
-				tmp_slot =
-					swp_slot(swp_slot_type(slot),
-						swp_slot_offset(slot) + swap_offset + i);
-				tmp_entry = swp_slot_to_swp_entry(tmp_slot);
+				swp_entry_t tmp_entry = swap_nth(swap, swap_offset + i);
 
 				__xa_store(&mapping->i_pages, aligned_index + i,
 					   swp_to_radix_entry(tmp_entry), 0);
diff --git a/mm/swap.h b/mm/swap.h
index 238d96869432..e8fac77a6e4c 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -36,7 +36,11 @@ struct swap_cluster_info {
 	u16 count;
 	u8 flags;
 	u8 order;
-	atomic_long_t __rcu *table;	/* Swap table entries, see mm/swap_table.h */
+	/*
+	 * Reverse map, to look up the virtual swap slot backed by a given physical
+	 * swap slot.
+	 */
+	atomic_long_t __rcu *table;
 	struct list_head list;
 };
 
@@ -154,7 +158,7 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
 }
 
 /* Return the swap device position of the swap slot. */
-static inline loff_t swap_slot_pos(swp_slot_t slot)
+static inline loff_t swap_slot_dev_pos(swp_slot_t slot)
 {
 	return ((loff_t)swp_slot_offset(slot)) << PAGE_SHIFT;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index fca17e7e7ae6..69303e949862 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -892,7 +892,8 @@ static int __init swap_init(void)
 	swap_kobj = kobject_create_and_add("swap", mm_kobj);
 	if (!swap_kobj) {
 		pr_err("failed to create swap kobject\n");
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto vswap_exit;
 	}
 	err = sysfs_create_group(swap_kobj, &swap_attr_group);
 	if (err) {
@@ -905,6 +906,8 @@ static int __init swap_init(void)
 
 delete_obj:
 	kobject_put(swap_kobj);
+vswap_exit:
+	vswap_exit();
 	return err;
 }
 subsys_initcall(swap_init);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0372062743ef..a47e024f2152 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1249,7 +1249,6 @@ static void swap_range_alloc(struct swap_info_struct *si,
 static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			    unsigned int nr_entries)
 {
-	unsigned long begin = offset;
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 	unsigned int i;
@@ -1258,10 +1257,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
 	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
 	 */
-	for (i = 0; i < nr_entries; i++) {
+	for (i = 0; i < nr_entries; i++)
 		clear_bit(offset + i, si->zeromap);
-		zswap_invalidate(swp_slot_to_swp_entry(swp_slot(si->type, offset + i)));
-	}
 
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1274,7 +1271,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
-	swap_cache_clear_shadow(swp_entry(si->type, begin), nr_entries);
 
 	/*
 	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
@@ -1405,7 +1401,7 @@ static bool swap_sync_discard(void)
 	return false;
 }
 
-static int swap_slot_alloc(swp_slot_t *slot, unsigned int order)
+int swap_slot_alloc(swp_slot_t *slot, unsigned int order)
 {
 	unsigned int size = 1 << order;
 
@@ -1438,56 +1434,10 @@ static int swap_slot_alloc(swp_slot_t *slot, unsigned int order)
 			goto again;
 	}
 
-	return 0;
-}
-
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
-{
-	unsigned int order = folio_order(folio);
-	swp_slot_t slot = { 0 };
-	swp_entry_t entry = {};
-	int err = 0, ret;
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
-
-	ret = swap_slot_alloc(&slot, order);
-	if (ret)
-		return ret;
-
-	/* XXX: for now, physical and virtual swap slots are identical */
-	entry.val = slot.val;
-
-	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		err = -ENOMEM;
-		goto out_free;
-	}
-
-	if (!slot.val)
+	if (!slot->val)
 		return -ENOMEM;
 
-	err = swap_cache_add_folio(folio, entry,
-				   __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
-				   NULL);
-	if (err)
-		goto out_free;
-
 	return 0;
-
-out_free:
-	put_swap_folio(folio, entry);
-	return err;
 }
 
 static struct swap_info_struct *_swap_info_get(swp_slot_t slot)
@@ -1735,6 +1685,13 @@ static void swap_slots_free(struct swap_info_struct *si,
 	unsigned char *map = si->swap_map + offset;
 	unsigned char *map_end = map + nr_pages;
 	swp_entry_t entry = swp_slot_to_swp_entry(slot);
+	int i;
+
+	/* release all the associated (virtual) swap slots */
+	for (i = 0; i < nr_pages; i++) {
+		vswap_free(entry, ci);
+		entry.val++;
+	}
 
 	/* It should never free entries across different clusters */
 	VM_BUG_ON(ci != __swap_offset_to_cluster(si, offset + nr_pages - 1));
@@ -1747,7 +1704,6 @@ static void swap_slots_free(struct swap_info_struct *si,
 		*map = 0;
 	} while (++map < map_end);
 
-	mem_cgroup_uncharge_swap(entry, nr_pages);
 	swap_range_free(si, offset, nr_pages);
 
 	if (!ci->count)
diff --git a/mm/vswap.c b/mm/vswap.c
index e68234f053fc..f28ca2517c10 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -4,7 +4,149 @@
  *
  * Copyright (C) 2024 Meta Platforms, Inc., Nhat Pham
  */
+#include <linux/mm.h>
+#include <linux/gfp.h>
 #include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/swap_cgroup.h>
+#include <linux/cpuhotplug.h>
+#include <linux/vmalloc.h>
+#include "swap.h"
+#include "swap_table.h"
+
+/*
+ * Virtual Swap Space
+ *
+ * We associate with each swapped out page a virtual swap slot. This will allow
+ * us to change the backing state of a swapped out page without having to
+ * update every single page table entries referring to it.
+ *
+ * For now, there is a one-to-one correspondence between a virtual swap slot
+ * and its associated physical swap slot.
+ *
+ * Virtual swap slots are organized into PMD-sized clusters, analogous to
+ * physical swap allocator. However, unlike the physical swap allocator,
+ * the clusters are dynamically allocated and freed on-demand. There is no
+ * "free list" of virtual swap clusters - new free clusters are allocated
+ * directly from the cluster map xarray.
+ *
+ * This allows us to avoid the overhead of pre-allocating a large number of
+ * virtual swap clusters.
+ */
+
+/**
+ * Swap descriptor - metadata of a swapped out page.
+ *
+ * @slot: The handle to the physical swap slot backing this page.
+ */
+struct swp_desc {
+	swp_slot_t slot;
+};
+
+#define VSWAP_CLUSTER_SHIFT HPAGE_PMD_ORDER
+#define VSWAP_CLUSTER_SIZE (1UL << VSWAP_CLUSTER_SHIFT)
+#define VSWAP_CLUSTER_MASK (VSWAP_CLUSTER_SIZE - 1)
+
+/*
+ * Map from a cluster id to the number of allocated virtual swap slots in the
+ * (PMD-sized) cluster. This allows us to quickly allocate an empty cluster
+ * for a large folio being swapped out.
+ *
+ * This xarray's lock is also used as the "global" allocator lock (for e.g, to
+ * synchronize global cluster lists manipulation).
+ */
+static struct kmem_cache *vswap_cluster_cache;
+static DEFINE_XARRAY_FLAGS(vswap_cluster_map, XA_FLAGS_TRACK_FREE);
+
+#if SWP_TYPE_SHIFT > 32
+/*
+ * In 64 bit architecture, the maximum number of virtual swap slots is capped
+ * by the number of clusters (as the vswap_cluster_map xarray can only allocate
+ * up to U32 clusters).
+ */
+#define MAX_VSWAP	\
+	(((unsigned long)U32_MAX << VSWAP_CLUSTER_SHIFT) + (VSWAP_CLUSTER_SIZE - 1))
+#else
+/*
+ * In 32 bit architecture, just make sure the range of virtual swap slots is
+ * the same as the range of physical swap slots.
+ */
+#define MAX_VSWAP	(((MAX_SWAPFILES - 1) << SWP_TYPE_SHIFT) | SWP_OFFSET_MASK)
+#endif
+
+static const struct xa_limit vswap_cluster_map_limit = {
+	.max = MAX_VSWAP >> VSWAP_CLUSTER_SHIFT,
+	.min = 0,
+};
+
+static struct list_head partial_clusters_lists[SWAP_NR_ORDERS];
+
+/**
+ * struct vswap_cluster
+ *
+ * @lock: Spinlock protecting the cluster's data
+ * @rcu: RCU head for deferred freeing when the cluster is no longer in use
+ * @list: List entry for tracking in partial_clusters_lists when not fully allocated
+ * @id: Unique identifier for this cluster, used to calculate swap slot values
+ * @count: Number of allocated virtual swap slots in this cluster
+ * @order: Order of allocation (0 for single pages, higher for contiguous ranges)
+ * @cached: Whether this cluster is cached in a per-CPU variable for fast allocation
+ * @full: Whether this cluster is considered full (no more allocations possible)
+ * @refcnt: Reference count tracking usage of slots in this cluster
+ * @bitmap: Bitmap tracking which slots in the cluster are allocated
+ * @descriptors: Array of swap descriptors for each slot in the cluster
+ *
+ * A vswap_cluster manages a PMD-sized group of contiguous virtual swap slots.
+ * It tracks which slots are allocated using a bitmap and maintains the
+ * swap descriptors in an array. The cluster is reference-counted and freed when
+ * all of its slots are released and the cluster is not cached. Each cluster
+ * only allocates aligned slots of a single order, determined when the cluster is
+ * allocated (and never change for the entire lifetime of the cluster).
+ *
+ * Clusters can be in the following states:
+ * - Cached in per-CPU variables for fast allocation.
+ * - In partial_clusters_lists when partially allocated but not cached.
+ * - Marked as full when no more allocations are possible.
+ */
+struct vswap_cluster {
+	spinlock_t lock;
+	union {
+		struct rcu_head rcu;
+		struct list_head list;
+	};
+	unsigned long id;
+	unsigned int count:VSWAP_CLUSTER_SHIFT + 1;
+	unsigned int order:4;
+	bool cached:1;
+	bool full:1;
+	refcount_t refcnt;
+	DECLARE_BITMAP(bitmap, VSWAP_CLUSTER_SIZE);
+	struct swp_desc *descriptors;
+};
+
+#define VSWAP_VAL_CLUSTER_IDX(val) ((val) >> VSWAP_CLUSTER_SHIFT)
+#define VSWAP_CLUSTER_IDX(entry) VSWAP_VAL_CLUSTER_IDX(entry.val)
+#define VSWAP_IDX_WITHIN_CLUSTER_VAL(val) ((val) & VSWAP_CLUSTER_MASK)
+#define VSWAP_IDX_WITHIN_CLUSTER(entry)	VSWAP_IDX_WITHIN_CLUSTER_VAL(entry.val)
+
+struct percpu_vswap_cluster {
+	struct vswap_cluster *clusters[SWAP_NR_ORDERS];
+	local_lock_t lock;
+};
+
+/*
+ * Per-CPU cache of the last allocated cluster for each order. This allows
+ * allocation fast path to skip the global vswap_cluster_map's spinlock, if
+ * the locally cached cluster still has free slots. Note that caching a cluster
+ * also increments its reference count.
+ */
+static DEFINE_PER_CPU(struct percpu_vswap_cluster, percpu_vswap_cluster) = {
+	.clusters = { NULL, },
+	.lock = INIT_LOCAL_LOCK(),
+};
+
+static atomic_t vswap_alloc_reject;
+static atomic_t vswap_used;
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
@@ -17,6 +159,10 @@ static int vswap_debug_fs_init(void)
 		return -ENODEV;
 
 	vswap_debugfs_root = debugfs_create_dir("vswap", NULL);
+	debugfs_create_atomic_t("alloc_reject", 0444,
+		vswap_debugfs_root, &vswap_alloc_reject);
+	debugfs_create_atomic_t("used", 0444, vswap_debugfs_root, &vswap_used);
+
 	return 0;
 }
 #else
@@ -26,10 +172,547 @@ static int vswap_debug_fs_init(void)
 }
 #endif
 
+static struct swp_desc *vswap_iter(struct vswap_cluster **clusterp, unsigned long i)
+{
+	unsigned long cluster_id = VSWAP_VAL_CLUSTER_IDX(i);
+	struct vswap_cluster *cluster = *clusterp;
+	struct swp_desc *desc = NULL;
+	unsigned long slot_index;
+
+	if (!cluster || cluster_id != cluster->id) {
+		if (cluster)
+			spin_unlock(&cluster->lock);
+		cluster = xa_load(&vswap_cluster_map, cluster_id);
+		if (!cluster)
+			goto done;
+		VM_WARN_ON(cluster->id != cluster_id);
+		spin_lock(&cluster->lock);
+	}
+
+	slot_index = VSWAP_IDX_WITHIN_CLUSTER_VAL(i);
+	if (test_bit(slot_index, cluster->bitmap))
+		desc = &cluster->descriptors[slot_index];
+
+	if (!desc) {
+		spin_unlock(&cluster->lock);
+		cluster = NULL;
+	}
+
+done:
+	*clusterp = cluster;
+	return desc;
+}
+
+static bool cluster_is_alloc_candidate(struct vswap_cluster *cluster)
+{
+	return cluster->count + (1 << (cluster->order)) <= VSWAP_CLUSTER_SIZE;
+}
+
+static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start)
+{
+	int i, nr = 1 << cluster->order;
+	struct swp_desc *desc;
+
+	for (i = 0; i < nr; i++) {
+		desc = &cluster->descriptors[start + i];
+		desc->slot.val = 0;
+	}
+	cluster->count += nr;
+}
+
+static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster)
+{
+	int nr = 1 << cluster->order;
+	unsigned long i = cluster->id ? 0 : nr;
+
+	lockdep_assert_held(&cluster->lock);
+	if (!cluster_is_alloc_candidate(cluster))
+		return 0;
+
+	/* Find the first free range of nr contiguous aligned slots */
+	i = bitmap_find_next_zero_area(cluster->bitmap,
+			VSWAP_CLUSTER_SIZE, i, nr, nr - 1);
+	if (i >= VSWAP_CLUSTER_SIZE)
+		return 0;
+
+	/* Mark the range as allocated in the bitmap */
+	bitmap_set(cluster->bitmap, i, nr);
+
+	refcount_add(nr, &cluster->refcnt);
+	__vswap_alloc_from_cluster(cluster, i);
+	return i + (cluster->id << VSWAP_CLUSTER_SHIFT);
+}
+
+/* Allocate a contiguous range of virtual swap slots */
+static swp_entry_t vswap_alloc(int order)
+{
+	struct xa_limit limit = vswap_cluster_map_limit;
+	struct vswap_cluster *local, *cluster;
+	int nr = 1 << order;
+	bool need_caching = true;
+	u32 cluster_id;
+	swp_entry_t entry;
+
+	entry.val = 0;
+
+	/* first, let's try the locally cached cluster */
+	rcu_read_lock();
+	local_lock(&percpu_vswap_cluster.lock);
+	cluster = this_cpu_read(percpu_vswap_cluster.clusters[order]);
+	if (cluster) {
+		spin_lock(&cluster->lock);
+		entry.val = vswap_alloc_from_cluster(cluster);
+		need_caching = !entry.val;
+
+		if (!entry.val || !cluster_is_alloc_candidate(cluster)) {
+			this_cpu_write(percpu_vswap_cluster.clusters[order], NULL);
+			cluster->cached = false;
+			refcount_dec(&cluster->refcnt);
+			cluster->full = true;
+		}
+		spin_unlock(&cluster->lock);
+	}
+	local_unlock(&percpu_vswap_cluster.lock);
+	rcu_read_unlock();
+
+	/*
+	 * Local cluster does not have space. Let's try the uncached partial
+	 * clusters before acquiring a new free cluster to reduce fragmentation,
+	 * and avoid having to allocate a new cluster structure.
+	 */
+	if (!entry.val) {
+		cluster = NULL;
+		xa_lock(&vswap_cluster_map);
+		list_for_each_entry_safe(cluster, local,
+				&partial_clusters_lists[order], list) {
+			if (!spin_trylock(&cluster->lock))
+				continue;
+
+			entry.val = vswap_alloc_from_cluster(cluster);
+			list_del_init(&cluster->list);
+			cluster->full = !entry.val || !cluster_is_alloc_candidate(cluster);
+			need_caching = !cluster->full;
+			spin_unlock(&cluster->lock);
+			if (entry.val)
+				break;
+		}
+		xa_unlock(&vswap_cluster_map);
+	}
+
+	/* try a new free cluster */
+	if (!entry.val) {
+		cluster = kmem_cache_zalloc(vswap_cluster_cache, GFP_KERNEL);
+		if (cluster) {
+			cluster->descriptors = vzalloc(array_size(VSWAP_CLUSTER_SIZE,
+						sizeof(struct swp_desc)));
+			if (!cluster->descriptors) {
+				kmem_cache_free(vswap_cluster_cache, cluster);
+				cluster = NULL;
+			}
+		}
+		if (cluster) {
+			/* first cluster cannot allocate a PMD-sized THP */
+			if (order == SWAP_NR_ORDERS - 1)
+				limit.min = 1;
+
+			if (!xa_alloc(&vswap_cluster_map, &cluster_id, cluster, limit,
+						GFP_KERNEL)) {
+				spin_lock_init(&cluster->lock);
+				cluster->id = cluster_id;
+				cluster->order = order;
+				INIT_LIST_HEAD(&cluster->list);
+				/* Initialize bitmap to all zeros (all slots free) */
+				bitmap_zero(cluster->bitmap, VSWAP_CLUSTER_SIZE);
+				entry.val = cluster->id << VSWAP_CLUSTER_SHIFT;
+				refcount_set(&cluster->refcnt, nr);
+				if (!cluster_id)
+					entry.val += nr;
+				__vswap_alloc_from_cluster(cluster,
+					(entry.val & VSWAP_CLUSTER_MASK));
+				/* Mark the allocated range in the bitmap */
+				bitmap_set(cluster->bitmap, (entry.val & VSWAP_CLUSTER_MASK), nr);
+				need_caching = cluster_is_alloc_candidate(cluster);
+			} else {
+				/* Failed to insert into cluster map, free the cluster */
+				vfree(cluster->descriptors);
+				kmem_cache_free(vswap_cluster_cache, cluster);
+				cluster = NULL;
+			}
+		}
+	}
+
+	if (need_caching && entry.val) {
+		local_lock(&percpu_vswap_cluster.lock);
+		local = this_cpu_read(percpu_vswap_cluster.clusters[order]);
+		if (local != cluster) {
+			if (local) {
+				spin_lock(&local->lock);
+				/* only update the local cache if cached cluster is full */
+				need_caching = !cluster_is_alloc_candidate(local);
+				if (need_caching) {
+					this_cpu_write(percpu_vswap_cluster.clusters[order], NULL);
+					local->cached = false;
+					refcount_dec(&local->refcnt);
+				}
+				spin_unlock(&local->lock);
+			}
+
+			VM_WARN_ON(!cluster);
+			spin_lock(&cluster->lock);
+			if (cluster_is_alloc_candidate(cluster)) {
+				if (need_caching) {
+					this_cpu_write(percpu_vswap_cluster.clusters[order],
+					       cluster);
+					refcount_inc(&cluster->refcnt);
+					cluster->cached = true;
+				} else {
+					xa_lock(&vswap_cluster_map);
+					VM_WARN_ON(!list_empty(&cluster->list));
+					list_add(&cluster->list, &partial_clusters_lists[order]);
+					xa_unlock(&vswap_cluster_map);
+				}
+			}
+			spin_unlock(&cluster->lock);
+		}
+		local_unlock(&percpu_vswap_cluster.lock);
+	}
+
+	if (entry.val) {
+		VM_WARN_ON(entry.val + nr - 1 > MAX_VSWAP);
+		atomic_add(nr, &vswap_used);
+	} else {
+		atomic_add(nr, &vswap_alloc_reject);
+	}
+	return entry;
+}
+
+static void vswap_cluster_free_rcu(struct rcu_head *head)
+{
+	struct vswap_cluster *cluster =
+		container_of(head, struct vswap_cluster, rcu);
+	vfree(cluster->descriptors);
+	kmem_cache_free(vswap_cluster_cache, cluster);
+}
+
+static void vswap_cluster_free(struct vswap_cluster *cluster)
+{
+	VM_WARN_ON(cluster->count || cluster->cached);
+	lockdep_assert_held(&cluster->lock);
+	xa_lock(&vswap_cluster_map);
+	list_del_init(&cluster->list);
+	__xa_erase(&vswap_cluster_map, cluster->id);
+	xa_unlock(&vswap_cluster_map);
+	rcu_head_init(&cluster->rcu);
+	call_rcu(&cluster->rcu, vswap_cluster_free_rcu);
+}
+
+static inline void release_vswap_slot(struct vswap_cluster *cluster,
+		unsigned long index)
+{
+	unsigned long slot_index = VSWAP_IDX_WITHIN_CLUSTER_VAL(index);
+
+	lockdep_assert_held(&cluster->lock);
+	cluster->count--;
+
+	bitmap_clear(cluster->bitmap, slot_index, 1);
+
+	/* we only free uncached empty clusters */
+	if (refcount_dec_and_test(&cluster->refcnt))
+		vswap_cluster_free(cluster);
+	else if (cluster->full && cluster_is_alloc_candidate(cluster)) {
+		cluster->full = false;
+		if (!cluster->cached) {
+			xa_lock(&vswap_cluster_map);
+			VM_WARN_ON(!list_empty(&cluster->list));
+			list_add_tail(&cluster->list,
+				&partial_clusters_lists[cluster->order]);
+			xa_unlock(&vswap_cluster_map);
+		}
+	}
+
+	atomic_dec(&vswap_used);
+}
+
+/*
+ * Update the physical-to-virtual swap slot mapping.
+ * Caller must ensure the physical swap slot's cluster is locked.
+ */
+static void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
+			   unsigned long vswap, int nr)
+{
+	atomic_long_t *table;
+	unsigned long slot_offset = swp_slot_offset(slot);
+	unsigned int ci_off = slot_offset % SWAPFILE_CLUSTER;
+	int i;
+
+	table = rcu_dereference_protected(ci->table, lockdep_is_held(&ci->lock));
+	VM_WARN_ON(!table);
+	for (i = 0; i < nr; i++)
+		__swap_table_set(ci, ci_off + i, vswap ? vswap + i : 0);
+}
+
+/**
+ * vswap_free - free a virtual swap slot.
+ * @entry: the virtual swap slot to free
+ * @ci: the physical swap slot's cluster (optional, can be NULL)
+ *
+ * If @ci is NULL, this function is called to clean up a virtual swap entry
+ * when no linkage has been established between physical and virtual swap slots.
+ * If @ci is provided, the caller must ensure it is locked.
+ */
+void vswap_free(swp_entry_t entry, struct swap_cluster_info *ci)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+
+	if (!entry.val)
+		return;
+
+	swap_cache_clear_shadow(entry, 1);
+	zswap_invalidate(entry);
+	mem_cgroup_uncharge_swap(entry, 1);
+
+	/* do not immediately erase the virtual slot to prevent its reuse */
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	if (!desc) {
+		rcu_read_unlock();
+		return;
+	}
+
+	if (desc->slot.val)
+		vswap_rmap_set(ci, desc->slot, 0, 1);
+
+	/* erase forward mapping and release the virtual slot for reallocation */
+	release_vswap_slot(cluster, entry.val);
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+}
+
+/**
+ * folio_alloc_swap - allocate swap space for a folio.
+ * @folio: the folio.
+ *
+ * Return: 0, if the allocation succeeded, -ENOMEM, if the allocation failed.
+ */
+int folio_alloc_swap(struct folio *folio)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	int i, err, ret, nr = folio_nr_pages(folio), order = folio_order(folio);
+	struct swp_desc *desc;
+	swp_entry_t entry;
+	swp_slot_t slot = { 0 };
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
+
+	entry = vswap_alloc(folio_order(folio));
+	if (!entry.val)
+		return -ENOMEM;
+
+	/*
+	 * XXX: for now, we always allocate a physical swap slot for each virtual
+	 * swap slot, and their lifetime are coupled. This will change once we
+	 * decouple virtual swap slots from their backing states, and only allocate
+	 * physical swap slots for them on demand (i.e on zswap writeback, or
+	 * fallback from zswap store failure).
+	 */
+	ret = swap_slot_alloc(&slot, order);
+	if (ret || !slot.val) {
+		/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
+		mem_cgroup_try_charge_swap(folio, (swp_entry_t){0});
+
+		for (i = 0; i < nr; i++)
+			vswap_free((swp_entry_t){entry.val + i}, NULL);
+
+		return ret ? ret : -ENOMEM;
+	}
+
+	/* establish the virtual <-> physical swap slots linkages. */
+	si = __swap_slot_to_info(slot);
+	ci = swap_cluster_lock(si, swp_slot_offset(slot));
+	vswap_rmap_set(ci, slot, entry.val, nr);
+	swap_cluster_unlock(ci);
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+
+		desc->slot.val = slot.val + i;
+	}
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	/*
+	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
+	 * swap slots allocation. This is acceptable because as noted above, each
+	 * virtual swap slot corresponds to a physical swap slot. Once we have
+	 * decoupled virtual and physical swap slots, we will only charge when we
+	 * actually allocate a physical swap slot.
+	 */
+	if (mem_cgroup_try_charge_swap(folio, entry))
+		goto out_free;
+
+	err = swap_cache_add_folio(folio, entry,
+				   __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
+				   NULL);
+	if (err)
+		goto out_free;
+
+	return 0;
+
+out_free:
+	put_swap_folio(folio, entry);
+	return -ENOMEM;
+}
+
+/**
+ * swp_entry_to_swp_slot - look up the physical swap slot corresponding to a
+ *                         virtual swap slot.
+ * @entry: the virtual swap slot.
+ *
+ * Return: the physical swap slot corresponding to the virtual swap slot.
+ */
+swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	swp_slot_t slot;
+
+	slot.val = 0;
+	if (!entry.val)
+		return slot;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	if (!desc) {
+		rcu_read_unlock();
+		return (swp_slot_t){0};
+	}
+	slot = desc->slot;
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	return slot;
+}
+
+/**
+ * swp_slot_to_swp_entry - look up the virtual swap slot corresponding to a
+ *                         physical swap slot.
+ * @slot: the physical swap slot.
+ *
+ * Return: the virtual swap slot corresponding to the physical swap slot.
+ */
+swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot)
+{
+	swp_entry_t ret;
+	struct swap_cluster_info *ci;
+	unsigned long offset;
+	unsigned int ci_off;
+
+	ret.val = 0;
+	if (!slot.val)
+		return ret;
+
+	offset = swp_slot_offset(slot);
+	ci_off = offset % SWAPFILE_CLUSTER;
+	ci = __swap_slot_to_cluster(slot);
+
+	ret.val = swap_table_get(ci, ci_off);
+	return ret;
+}
+
+bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si)
+{
+	struct vswap_cluster *cluster;
+	swp_slot_t slot;
+
+	slot = swp_entry_to_swp_slot(entry);
+	*si = swap_slot_tryget_swap_info(slot);
+	if (!*si)
+		return false;
+
+	/*
+	 * Ensure the cluster and its associated data structures (swap cache etc.)
+	 * remain valid.
+	 */
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, VSWAP_CLUSTER_IDX(entry));
+	if (!cluster || !refcount_inc_not_zero(&cluster->refcnt)) {
+		rcu_read_unlock();
+		swap_slot_put_swap_info(*si);
+		*si = NULL;
+		return false;
+	}
+	rcu_read_unlock();
+	return true;
+}
+
+void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si)
+{
+	struct vswap_cluster *cluster;
+
+	if (si)
+		swap_slot_put_swap_info(si);
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, VSWAP_CLUSTER_IDX(entry));
+	spin_lock(&cluster->lock);
+	if (refcount_dec_and_test(&cluster->refcnt))
+		vswap_cluster_free(cluster);
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+}
+
+static int vswap_cpu_dead(unsigned int cpu)
+{
+	struct vswap_cluster *cluster;
+	int order;
+
+	guard(rcu)();
+	for (order = 0; order < SWAP_NR_ORDERS; order++) {
+		cluster = per_cpu(percpu_vswap_cluster.clusters[order], cpu);
+		if (cluster) {
+			per_cpu(percpu_vswap_cluster.clusters[order], cpu) = NULL;
+			spin_lock(&cluster->lock);
+			cluster->cached = false;
+			if (refcount_dec_and_test(&cluster->refcnt))
+				vswap_cluster_free(cluster);
+			spin_unlock(&cluster->lock);
+		}
+	}
+
+	return 0;
+}
+
+
 int vswap_init(void)
 {
+	int i;
+
+	vswap_cluster_cache = KMEM_CACHE(vswap_cluster, 0);
+	if (!vswap_cluster_cache)
+		return -ENOMEM;
+
+	if (cpuhp_setup_state_nocalls(CPUHP_MM_VSWAP_DEAD, "mm/vswap:dead", NULL,
+				vswap_cpu_dead)) {
+		pr_err("Failed to register vswap CPU hotplug callback\n");
+		kmem_cache_destroy(vswap_cluster_cache);
+		return -ENOMEM;
+	}
+
 	if (vswap_debug_fs_init())
 		pr_warn("Failed to initialize vswap debugfs\n");
 
+	for (i = 0; i < SWAP_NR_ORDERS; i++)
+		INIT_LIST_HEAD(&partial_clusters_lists[i]);
+
 	return 0;
 }
+
+void vswap_exit(void)
+{
+}
-- 
2.52.0


