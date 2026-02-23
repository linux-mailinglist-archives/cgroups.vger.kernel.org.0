Return-Path: <cgroups+bounces-14151-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cILkGfh6nGlfIAQAu9opvQ
	(envelope-from <cgroups+bounces-14151-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:06:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516D817955B
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF34230054D1
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B461B307AF0;
	Mon, 23 Feb 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="aHOQ72DW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAA309F00
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862511; cv=none; b=p1Dpx5TqjExgVYyZCdF3tsLt/8s81whArsyydUYRNUmRO95mztdyI9/MHWHk7a4ZwcpLFMJYwNUDWEJBzKKljt2ppg5vuqr81Sthjy+/JNV0noMTgYm6Jkl5zKJ+7rn1XRIPAFb8h/LgGyvyoz7iESadSfrhGCEwA1Ny5v+rWk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862511; c=relaxed/simple;
	bh=ihwCY+885/DJ41iFQibyxx318RHDEpAXKJdoYYRfTsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CsVCgVxBATWZnxtgNfxDv/zmvxgdPaOXliJyr34/kcaWKQX/Fty8njWURhw7kDe7LWUJiN+9jM79C2gTGasnOAu9AlhP1j9Hsfnwzy9zSYhLJ54eLeLyshqGvNArmpMzV08qcZhgNqLvqBaLEjTBxKzZKf39/6aq7cYLw/+PHz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=aHOQ72DW; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-506989e8516so37365561cf.0
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771862509; x=1772467309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OE3e/mRY2hQ14eIolnufoTqQ/7nanRq+a9D/btXLD44=;
        b=aHOQ72DWjcM2YFIKKYWhCehqngbunTG6xlRrRTYhAW1Mohfo7bqeE9gbPQFqTZnq8Y
         ZKjkITmdmnUmpz7sKTyV6vjE+BGWC67sAvZadMNC0EjjyeHka5yBl/V5Xs75EiKFWFeW
         1omH8iFcCbkxvZlcE6e1DIN3fpIQXAmtLK4Yfi6Ci+CS5YXWLKVW4rv5NFBqnD272F9z
         dMetsTgkKoFWlyDntfaobxTdmFRjCkp+0Xby9Km02LWv0fYuFmZlzy8FKxB4ijtrfOzU
         yYCwY/Z+lQJvO0v+fCEHWSkv08EBTtTqg/7qlpJiLIVW2ppW5ZpHHrm6HDthp7rbfLMk
         187Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862509; x=1772467309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE3e/mRY2hQ14eIolnufoTqQ/7nanRq+a9D/btXLD44=;
        b=LQG206Svpj4AMdux6wfRxM8NKd3lp+nqjzVI2dPTYl1GpNPRng7+7SQpAoyKRpSKF+
         45csjqLZKmEqlU+aZ1HKkJaripeWwHCSzG4RIhkUJVWJjXpLgFsULVzuYDuPN0dh3To1
         OIQ1yzKfQKc/TpPBJQSE/VxxqfXM0ok+gT9ONeN22N/68rXVG+utCZXnp8mNiAF3wZxf
         VGXtW+myvVq5NS/bvT8iw/0b9d8UJ4xh4cQpcDOMgqU5qYF0CmcWEcuRMdfx7vL8qyYT
         qaLiYCuPacJwo0gdd3TqV0deCDT3+EBVhh+cpmLFxgOHjNPb8Q7rKQUI2jvaMdLSLRzP
         Ahdg==
X-Forwarded-Encrypted: i=1; AJvYcCXLXHfVZqsGNAj8UtPfp9+EyTBFa87Qvof9kIvWeFUjx0SV/nj8QbZYBdvkCe1ZSxoWPCALVI2t@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw7GriVLWmfl7XMOOKZwYZnQObgjCEWyiZlDQAo7/wpBVwonZw
	VfPCmtUkM8rhgrjyRQp8FsMM4NiUv/0KMU98HGu6xV/pl3NURLs6ESeCdLvSYuc3Hzx2pBAsAQU
	jjui25Hk=
X-Gm-Gg: AZuq6aIz0mf/u9N+cwqoz6MsAjiWn3viNy/07s1IrAxJooCPiUIrRX6kPOkRAB8O43r
	6XVsb+zgXjw7lW8J9T140qQRvwjuXM077KEdIGHUTgJS2MNB8mc62vjSWUQpXlVwDqm2NKrUyN1
	RVFwUb7krJCl8bVWZ95oNpEbNJyiOFfYOWSngkh46QZgqwo7oBi4VMGFo/Q5xGDUxOekBxxJZHA
	br68seaIG+9UAKQhIz5IvMyrGKjBjPQX4z8OG7DbnTS/u0lgzZAiUj4h2ql7XRt87c/1mj9DZf4
	iA65liWIGm8RZUH8Q8vEtfz69OhkHWuz7z8Hildv+lVZoK+Qj2WCsZIcAO9Eg2oSb8UHgEM4eZA
	7Hpux/RQpGsNVchKRxZPp5e3/f2CmwBGaGyzhLyJpeQqGjHgJC9njb7PFiSiU2HdJ2yfCGAnEKH
	q0LlLbOYC2xS6lbbdF8OcePw==
X-Received: by 2002:a05:622a:14:b0:502:9a98:34b6 with SMTP id d75a77b69052e-5070bbde388mr116096171cf.19.1771862508740;
        Mon, 23 Feb 2026 08:01:48 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5070d6c9de8sm70140001cf.26.2026.02.23.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:01:47 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: vmalloc: streamline vmalloc memory accounting
Date: Mon, 23 Feb 2026 11:01:06 -0500
Message-ID: <20260223160147.3792777-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.53.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-14151-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 516D817955B
X-Rspamd-Action: no action

Use a vmstat counter instead of a custom, open-coded atomic. This has
the added benefit of making the data available per-node, and prepares
for cleaning up the memcg accounting as well.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/proc/meminfo.c       |  3 ++-
 include/linux/mmzone.h  |  1 +
 include/linux/vmalloc.h |  3 ---
 mm/vmalloc.c            | 19 ++++++++++---------
 mm/vmstat.c             |  1 +
 5 files changed, 14 insertions(+), 13 deletions(-)

V2:
- Fix mod_node_page_state() pgdat argument (Shakeel)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index a458f1e112fd..549793f44726 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -126,7 +126,8 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "Committed_AS:   ", committed);
 	seq_printf(m, "VmallocTotal:   %8lu kB\n",
 		   (unsigned long)VMALLOC_TOTAL >> 10);
-	show_val_kb(m, "VmallocUsed:    ", vmalloc_nr_pages());
+	show_val_kb(m, "VmallocUsed:    ",
+		    global_node_page_state(NR_VMALLOC));
 	show_val_kb(m, "VmallocChunk:   ", 0ul);
 	show_val_kb(m, "Percpu:         ", pcpu_nr_pages());
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fc5d6c88d2f0..64df797d45c6 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -220,6 +220,7 @@ enum node_stat_item {
 	NR_KERNEL_MISC_RECLAIMABLE,	/* reclaimable non-slab kernel pages */
 	NR_FOLL_PIN_ACQUIRED,	/* via: pin_user_page(), gup flag: FOLL_PIN */
 	NR_FOLL_PIN_RELEASED,	/* pages returned via unpin_user_page() */
+	NR_VMALLOC,
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	NR_KERNEL_SCS_KB,	/* measured in KiB */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index e8e94f90d686..3b02c0c6b371 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -286,8 +286,6 @@ int unregister_vmap_purge_notifier(struct notifier_block *nb);
 #ifdef CONFIG_MMU
 #define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
 
-unsigned long vmalloc_nr_pages(void);
-
 int vm_area_map_pages(struct vm_struct *area, unsigned long start,
 		      unsigned long end, struct page **pages);
 void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
@@ -304,7 +302,6 @@ static inline void set_vm_flush_reset_perms(void *addr)
 #else  /* !CONFIG_MMU */
 #define VMALLOC_TOTAL 0UL
 
-static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 static inline void set_vm_flush_reset_perms(void *addr) {}
 #endif /* CONFIG_MMU */
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e286c2d2068c..a5fc7795aafd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1063,14 +1063,8 @@ static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
 static void drain_vmap_area_work(struct work_struct *work);
 static DECLARE_WORK(drain_vmap_work, drain_vmap_area_work);
 
-static __cacheline_aligned_in_smp atomic_long_t nr_vmalloc_pages;
 static __cacheline_aligned_in_smp atomic_long_t vmap_lazy_nr;
 
-unsigned long vmalloc_nr_pages(void)
-{
-	return atomic_long_read(&nr_vmalloc_pages);
-}
-
 static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
 {
 	struct rb_node *n = root->rb_node;
@@ -3463,11 +3457,11 @@ void vfree(const void *addr)
 		 * High-order allocs for huge vmallocs are split, so
 		 * can be freed as an array of order-0 allocations
 		 */
+		if (!(vm->flags & VM_MAP_PUT_PAGES))
+			dec_node_page_state(page, NR_VMALLOC);
 		__free_page(page);
 		cond_resched();
 	}
-	if (!(vm->flags & VM_MAP_PUT_PAGES))
-		atomic_long_sub(vm->nr_pages, &nr_vmalloc_pages);
 	kvfree(vm->pages);
 	kfree(vm);
 }
@@ -3655,6 +3649,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			continue;
 		}
 
+		mod_node_page_state(page_pgdat(page), NR_VMALLOC, 1 << large_order);
+
 		split_page(page, large_order);
 		for (i = 0; i < (1U << large_order); i++)
 			pages[nr_allocated + i] = page + i;
@@ -3675,6 +3671,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	if (!order) {
 		while (nr_allocated < nr_pages) {
 			unsigned int nr, nr_pages_request;
+			int i;
 
 			/*
 			 * A maximum allowed request is hard-coded and is 100
@@ -3698,6 +3695,9 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 							nr_pages_request,
 							pages + nr_allocated);
 
+			for (i = nr_allocated; i < nr_allocated + nr; i++)
+				inc_node_page_state(pages[i], NR_VMALLOC);
+
 			nr_allocated += nr;
 
 			/*
@@ -3722,6 +3722,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		if (unlikely(!page))
 			break;
 
+		mod_node_page_state(page_pgdat(page), NR_VMALLOC, 1 << order);
+
 		/*
 		 * High-order allocations must be able to be treated as
 		 * independent small pages by callers (as they can with
@@ -3864,7 +3866,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			vmalloc_gfp_adjust(gfp_mask, page_order), node,
 			page_order, nr_small_pages, area->pages);
 
-	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 	/* All pages of vm should be charged to same memcg, so use first one. */
 	if (gfp_mask & __GFP_ACCOUNT && area->nr_pages)
 		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d6e814c82952..bc199c7cd07b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1270,6 +1270,7 @@ const char * const vmstat_text[] = {
 	[I(NR_KERNEL_MISC_RECLAIMABLE)]		= "nr_kernel_misc_reclaimable",
 	[I(NR_FOLL_PIN_ACQUIRED)]		= "nr_foll_pin_acquired",
 	[I(NR_FOLL_PIN_RELEASED)]		= "nr_foll_pin_released",
+	[I(NR_VMALLOC)]				= "nr_vmalloc",
 	[I(NR_KERNEL_STACK_KB)]			= "nr_kernel_stack",
 #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
 	[I(NR_KERNEL_SCS_KB)]			= "nr_shadow_call_stack",
-- 
2.53.0


