Return-Path: <cgroups+bounces-14070-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGhYDsWxmGnsKwMAu9opvQ
	(envelope-from <cgroups+bounces-14070-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 20:11:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5A716A4A1
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 20:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58D25303E484
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5B1366DC6;
	Fri, 20 Feb 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="enLx39iW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4036604A
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614640; cv=none; b=d4WicjqvmJqC5SeOqMMq4Q4CtNx6V4HfK37aWP0CIfJ0e2cNQnGytM0UTeCkTAYH35wZ6bkhxOkWrCdW1AoJtUPcoQ5o/lUldSaIYVFhrywXNmjuuwCdLVmg1ZQBq8RPRIHDaRDU+T2zSRRPHIkriRn0EWIEDJvTD+DAWLunhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614640; c=relaxed/simple;
	bh=sjzHicn/XuRN/ik3PoytqdDZ7F4UK/PXCnsncIr2GLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b60ETOtEohc+cG8EWOTqvOVmitIX7+2qIFH813Y8wuzTevaM92pOo8+IswylT5E1fKOGw9VWJ/pFDKfaAz3cvtTrkpibJ0nVn7VeubhYKV2AFWTS78AqXKJpezx/Yt48xVVlms96WglylG1UEtBy1QVIua0MRPMph3NxjdG6qmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=enLx39iW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb4136d865so282558385a.1
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 11:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771614637; x=1772219437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OWO7RKWgQr+7ICFBB9SCVBLs7NDhlsurdO9niRwwF2Q=;
        b=enLx39iW0sohtWkqbOpmLyaTh02votxP6EQDyMg8gPBWp+oowZb4q0cSxDrUEQkOD1
         dok7vIWs5DKRobWbspv+h38Y71K3ApX9GKFI/NdrKGbyU9DBqM3OtYi370k1xKz/v5SV
         nIAD0HKZVtsLjE+8iatoNkvG87so5OCFdRdR5WI1PNFK4X3OewiBxGeolaO3mXcAaWep
         qV6BztasJaDP+HYn8nqGWViNaUKCjB4RZHVNUKmthurfAXGcer/UxqCZJ2tPxZGDA1df
         zlSdHbtB5mwLvfJxcf7aqFJ6OH270UXy7Lw45+VDP0WV/10N6uRAFLZ9Ra3KZvYV4fK6
         xM8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771614637; x=1772219437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWO7RKWgQr+7ICFBB9SCVBLs7NDhlsurdO9niRwwF2Q=;
        b=oMIFRVZQwb3hKabqunAB5aCy6gw4ChMxuHRIb6bbMT3vPfLkx6D4XCk5kJr/dYvEfZ
         lnu8nyEGAN9GVwgNmHhiDfnxsMwKBphDBT31ybTW/pf7CjyqM/hT0E3GAYK6oDnu+yU+
         /AFpBjYMjEYrzgGRor1HLyMJeR/umMvclgwkHfcA0x6FNSUqVoAI5s0EjfDkDBd0rIM/
         AOxdFhDuCwLhj4ZaaLhXw8dFIVf6S7E27KC5m8PdBdvydIjQfYYQpFLFg/1zpTJRuckj
         iu+N/ETj7lx8+y28j9MNoXR6Yzr2f25YT2Mf2r6eVipkWSCiqcKBvmthVSlOmEMH5U3C
         V7kg==
X-Forwarded-Encrypted: i=1; AJvYcCWCth73BHwKoO964WQfevk05KbbEfIgmzKKLKSMnluuLt77Ak8VjO85JMPVJCIpxhtMK3edLuAn@vger.kernel.org
X-Gm-Message-State: AOJu0YzmA6qXifVC3o6+deSipthkX/gmFe4NR7DcMKgPIlP+nmJr2lR7
	7Z6PhcwnkZkbQgghDc/s1Je43jm1JqbY60aHy0Z7iXVK0PpUH+khSpLzLevmGsJwBr0=
X-Gm-Gg: AZuq6aJ1W53aK40+CI9FJnTroqTKDfzzaqG/oHJUjX1owIZho8xeFHoZ8ZMv5RNR/iC
	2QQ8DQ18qR6zUY8IBzo0W99/nzaYjjXMmzJQveEtEYZB2UHke2EkB5HKNm1zwKgXczPC+uCsA4g
	sJ8FNkL9saRTRyctOT3tXvBSvX6/8FcnFsEKrrc1vAXC9Mz41mZNqkMhrw7DZ66W6KuRatyHGwe
	O921vDIZiPhmEpAZoCKZ99ETAdPqmHq39Ma7H0xLkDltD5R2/7IJpnmmIU/IQM4oor8Vi/PZe1M
	jWITWBUOZdtDcH2FcwuyYGYifqosJLO1Gw1lNx3KF/6A4SD0XFKWt5l73Bsqp45ho4RTq2OLheb
	FMRMRR+hU7nSMwSYN9o7uxbjW5Z+qO8MTm2YzGO5LhlKTB2RwygrgQTj+bvC70UvjM68GqIomS3
	ReDjC4ydcfE1Y0y7XV5ZLrHfcgJCNXyPC5
X-Received: by 2002:a05:620a:d8d:b0:8c6:a5bc:8a90 with SMTP id af79cd13be357-8cb8c9e0086mr82079585a.14.1771614636634;
        Fri, 20 Feb 2026 11:10:36 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0ebcd0sm22196885a.28.2026.02.20.11.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:10:36 -0800 (PST)
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
Subject: [PATCH 1/2] mm: vmalloc: streamline vmalloc memory accounting
Date: Fri, 20 Feb 2026 14:10:34 -0500
Message-ID: <20260220191035.3703800-1-hannes@cmpxchg.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14070-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:mid,cmpxchg.org:dkim,cmpxchg.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC5A716A4A1
X-Rspamd-Action: no action

Use a vmstat counter instead of a custom, open-coded atomic. This has
the added benefit of making the data available per-node, and prepares
for cleaning up the memcg accounting as well.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/proc/meminfo.c       |  3 ++-
 include/linux/mmzone.h  |  1 +
 include/linux/vmalloc.h |  3 ---
 mm/vmalloc.c            | 19 ++++++++++---------
 mm/vmstat.c             |  1 +
 5 files changed, 14 insertions(+), 13 deletions(-)

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
index e286c2d2068c..a49a46de9c4f 100644
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
 
+		mod_node_page_state(page, NR_VMALLOC, 1 << large_order);
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
 
+		mod_node_page_state(page, NR_VMALLOC, 1 << order);
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


