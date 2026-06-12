Return-Path: <cgroups+bounces-16913-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f7JGA+NgLGqqQAQAu9opvQ
	(envelope-from <cgroups+bounces-16913-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:41:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B84F667C1DC
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:41:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=sJembO1V;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16913-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16913-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3163431C5250
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 19:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8CF3AE1B1;
	Fri, 12 Jun 2026 19:37:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955263AB291
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 19:37:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293076; cv=none; b=jLZtzjQbdIgXqHgwvCyQLEiOK31f/amydHd+NPHi6ffnvD16CfffTLzvRZJXzvYpIgkGr7dAuRO7mnhhP1JDTzKNjTN14zcAQvr3IQkxhnpUfR3aa39IwKuJy+GFngvRZbdGZvWkwgduzwCdFp3OdiRBn6mclRqYrwbH1dvJtD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293076; c=relaxed/simple;
	bh=zKTYCfMs+4ep4kfOGZp7dXj6T5Fg/BiGOuo+2LagqIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2M0/KOavo/HUIADcavrz3+WTAwIdiXDGUAfYtGZ/gsfFnzQxv6qAjQdS3ijbj0ttdeNmHVurXKQWo8fQUmW3mXupAA6EfUrF8jQqeui/oGgN3LFZJsr4HGxeSnpVtbx2QRA4Vdpan/XdJ3wDv58Vsdx3riIMYzw4z+2AasGAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJembO1V; arc=none smtp.client-ip=209.85.160.44
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43d1470491aso685778fac.2
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293073; x=1781897873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlWgO7yzJ7D4dSwTEw1DL0jwS6Qno5QzBy9pCRF+UlU=;
        b=sJembO1VSZ9ASlUOlmppr/54/2s3hQq0v2v1wOlqcNEaLBfBNIAeACmO0RCAQ2hH/7
         DD82MyTj+pagfMyNSRoQnwHbLSswXo/Le/XKJ1g5KAx7Y1tPtf+sJjEuHQQA9ab3dL3V
         9rZrDGpzadF/YxP50pLoOUQ/igSjVA8Oa6giPqD6yYtE/8yLXtb2ZQ3d5GcLiloV7QcP
         595dRUS5crdWW6jlRMwrbzZrvuIjVyGRXNIcKo6T8663D13Uk+myN9cZftq5SH+KIIta
         yG4q8HCifRESf+R2TMcla15N2qM0K1YAqTVZm3VC4hj2HSjMJ+lGcIrzn39CHO3Ks10e
         5Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293073; x=1781897873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlWgO7yzJ7D4dSwTEw1DL0jwS6Qno5QzBy9pCRF+UlU=;
        b=ExeiZSE2+d4QIXojdWEdzGKfgQULvaExVnMJleP5b5oAJXAfJo7PyOcRv7BC40wcHD
         RFPwqbwqVYD2smAf6cviUV1ol51cj7ONGtDlIYFlJU6f2drkdlgMKKSeDpl4rJMJZV2i
         bIORGy9XNyxtjsb+YTaNj5UK2cy7kghpf2cHAX1/pCtiWkj18JuXUqe3T0s2wojghSMf
         q313tLXGcc520ZHqSz5WDvKcyoBh1uxBUFhCVj2+FyYfHueH+1QuZ/iyDTpQVBlZWOJE
         5WnIwxz1WBa4PA8BQzgjV+WBFSxhu0QDqXlieyxWMou6isHvaHXUb7tnHAYgSt4y0PZX
         T42A==
X-Forwarded-Encrypted: i=1; AFNElJ8A+ObSwj6YANkWvfExEQ964FYOrmpH75kj6CqAFv4Lf1WZoshSyvlOu6Ad6eU0Kk4DpKc1sxI2@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcH1yO+NBl5AjTSI7QJEkzcoLJrcaxrA/U5vXtyYiclLiQV1F
	ApfeYvKHPheMKNUll0f8/7BHO3spUc6dAsbRE45wiBgMefN21X6TMIN+
X-Gm-Gg: Acq92OF7fJPdrps9WDYT1Pwo7uR03mmYUHew8D/hB1CY9JMdMk8YSkv9kO1OtbazXwG
	R7M8j4Mc12LYSsIRCzrD08JU1dcSWmV/0wUFkuCPNmnMtAMqJnIAndbVYWsEr7b3a7BggKeWTgW
	HQMMZQWJrf+n37S7vE9CBZW1PNBmzU6zf++PfOKDN4QWoznSqa1pTmP7m2jqfK84TXCh9Q7y+DE
	9Vkp0nfE/GbSW2GfbY/fKDwxS/trMSxujjYwJK8QQlwzYZh/cE1zBjo96MVk+A+rycCEyh0/hVG
	RbwugZfhEUYUVHAvrWXMe5ZL4ay15r8ToAAOpOBlxONtXybaHf6/42CLhESShn4zZoJ2cMq62aa
	W9higIiOCoqRty9RnM3cOY0ncmF4R/GMm4yCXsm4KgcJg0ib+ILgNVfx0N+L19TeRV5EmIbfuZ3
	6ZB65g0uYGA9tvqzmyEjVGuNyUBqBch2CYcRVIhQcmlT0jRQ==
X-Received: by 2002:a05:6820:198b:b0:69d:ffa3:f56c with SMTP id 006d021491bc7-69eec82234amr524964eaf.14.1781293073363;
        Fri, 12 Jun 2026 12:37:53 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4426ab0f533sm2500220fac.3.2026.06.12.12.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:37:52 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	yosry@kernel.org,
	david@kernel.org,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	chengming.zhou@linux.dev,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	qi.zheng@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	riel@surriel.com,
	gourry@gourry.net,
	haowenchao22@gmail.com,
	kernel-team@meta.com,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 7/7] mm, swap: widen swap_info_struct max/pages to unsigned long
Date: Fri, 12 Jun 2026 12:37:38 -0700
Message-ID: <20260612193738.2183968-8-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612193738.2183968-1-nphamcs@gmail.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16913-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:nphamcs@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B84F667C1DC

Widen swap_info_struct->max and ->pages from unsigned int to
unsigned long so the vswap device can exceed the current 16 TB
cap (ALIGN_DOWN(UINT_MAX, SWAPFILE_CLUSTER) pages).

Physical swap is unaffected; backing files/bdevs continue to bound
it independently of the field width.

The new vswap cap is the cluster_info_pool xarray's allocator
limit. XA_FLAGS_ALLOC stores allocated IDs in u32, so
max_pages = UINT_MAX * SWAPFILE_CLUSTER (~8 PB at the typical
SWAPFILE_CLUSTER=512 layout).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  4 +--
 mm/swapfile.c        | 62 +++++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2d6bc4cb442f..b8fc2aa4539f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -253,7 +253,7 @@ struct swap_info_struct {
 	signed short	prio;		/* swap priority of this type */
 	struct plist_node list;		/* entry in swap_active_head */
 	signed char	type;		/* strange name for an index */
-	unsigned int	max;		/* size of this swap device */
+	unsigned long	max;		/* size of this swap device */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head full_clusters; /* full clusters list */
@@ -261,7 +261,7 @@ struct swap_info_struct {
 					/* list of cluster that contains at least one free slot */
 	struct list_head frag_clusters[SWAP_NR_ORDERS];
 					/* list of cluster that are fragmented or contented */
-	unsigned int pages;		/* total of usable pages of swap */
+	unsigned long pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
 	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
 	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0d48240de345..b03a81993a04 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -451,10 +451,10 @@ static inline unsigned int cluster_index(struct swap_info_struct *si,
 	return ci - si->cluster_info;
 }
 
-static inline unsigned int cluster_offset(struct swap_info_struct *si,
-					  struct swap_cluster_info *ci)
+static inline unsigned long cluster_offset(struct swap_info_struct *si,
+					   struct swap_cluster_info *ci)
 {
-	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
+	return (unsigned long)cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
 static void swap_cluster_free_table_folio_rcu_cb(struct rcu_head *head)
@@ -876,7 +876,7 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 
 	/* si->max may got shrunk by swap swap_activate() */
 	if (offset >= si->max && !mask) {
-		pr_debug("Ignoring bad slot %u (max: %u)\n", offset, si->max);
+		pr_debug("Ignoring bad slot %u (max: %lu)\n", offset, si->max);
 		return 0;
 	}
 	/*
@@ -1152,12 +1152,12 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 }
 
 /* Try use a new cluster for current CPU and allocate from it. */
-static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
-					    struct swap_cluster_info *ci,
-					    struct folio *folio,
-					    unsigned long offset)
+static unsigned long alloc_swap_scan_cluster(struct swap_info_struct *si,
+					     struct swap_cluster_info *ci,
+					     struct folio *folio,
+					     unsigned long offset)
 {
-	unsigned int next = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
+	unsigned long next = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
 	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
 	unsigned int order = folio ? folio_order(folio) : 0;
 	unsigned long end = start + SWAPFILE_CLUSTER;
@@ -1235,12 +1235,12 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	return found;
 }
 
-static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
-					 struct list_head *list,
-					 struct folio *folio,
-					 bool scan_all)
+static unsigned long alloc_swap_scan_list(struct swap_info_struct *si,
+					  struct list_head *list,
+					  struct folio *folio,
+					  bool scan_all)
 {
-	unsigned int found = SWAP_ENTRY_INVALID;
+	unsigned long found = SWAP_ENTRY_INVALID;
 
 	do {
 		struct swap_cluster_info *ci = isolate_lock_cluster(si, list);
@@ -1257,8 +1257,8 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 	return found;
 }
 
-static unsigned int alloc_swap_scan_dynamic(struct swap_info_struct *si,
-					    struct folio *folio)
+static unsigned long alloc_swap_scan_dynamic(struct swap_info_struct *si,
+					     struct folio *folio)
 {
 	struct swap_cluster_info_dynamic *ci_dyn;
 	struct swap_cluster_info *ci;
@@ -1373,7 +1373,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 {
 	unsigned int order = folio ? folio_order(folio) : 0;
 	struct swap_cluster_info *ci;
-	unsigned int offset = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
+	unsigned long offset = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
 
 	/*
 	 * File-based swap can't do large contiguous IO. vswap has no IO
@@ -3492,10 +3492,10 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
  * Return 0 if there are no inuse entries after prev till end of
  * the map.
  */
-static unsigned int find_next_to_unuse(struct swap_info_struct *si,
-					unsigned int prev)
+static unsigned long find_next_to_unuse(struct swap_info_struct *si,
+					unsigned long prev)
 {
-	unsigned int i;
+	unsigned long i;
 	unsigned long swp_tb;
 
 	/*
@@ -3533,7 +3533,8 @@ static int try_to_unuse(unsigned int type)
 	struct folio *folio;
 	swp_entry_t entry, vswap_entry;
 	unsigned long swp_tb;
-	unsigned int i, j, ci_off;
+	unsigned long i;
+	unsigned int j, ci_off;
 
 	if (!swap_usage_in_pages(si))
 		goto success;
@@ -3970,7 +3971,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
 	struct inode *inode;
-	unsigned int maxpages;
+	unsigned long maxpages;
 	int err, found = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -4404,12 +4405,8 @@ static unsigned long read_swap_header(struct swap_info_struct *si,
 		pr_warn("Truncating oversized swap area, only using %luk out of %luk\n",
 			K(maxpages), K(last_page));
 	}
-	if (maxpages > last_page) {
+	if (maxpages > last_page)
 		maxpages = last_page + 1;
-		/* p->max is an unsigned int: don't overflow it */
-		if ((unsigned int)maxpages == 0)
-			maxpages = UINT_MAX;
-	}
 
 	if (!maxpages)
 		return 0;
@@ -4640,7 +4637,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 	if (si->pages != si->max - 1) {
-		pr_err("swap:%u != (max:%u - 1)\n", si->pages, si->max);
+		pr_err("swap:%lu != (max:%lu - 1)\n", si->pages, si->max);
 		error = -EINVAL;
 		goto bad_swap_unlock_inode;
 	}
@@ -4728,7 +4725,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	/* Sets SWP_WRITEOK, resurrect the percpu ref, expose the swap device */
 	enable_swap_info(si);
 
-	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
+	pr_info("Adding %luk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s\n",
 		K(si->pages), name->name, si->prio, nr_extents,
 		K((unsigned long long)span),
 		(si->flags & SWP_SOLIDSTATE) ? "SS" : "",
@@ -4900,8 +4897,13 @@ static int __init vswap_init(void)
 		return 0;
 	}
 
+	/*
+	 * Cap at the cluster_info_pool xarray's allocator limit
+	 * (XA_FLAGS_ALLOC stores IDs in u32, tops out at UINT_MAX).
+	 */
 	maxpages = min(swapfile_maximum_size,
-		       ALIGN_DOWN((unsigned long)UINT_MAX, SWAPFILE_CLUSTER));
+		       ALIGN_DOWN((unsigned long)UINT_MAX * SWAPFILE_CLUSTER,
+				  SWAPFILE_CLUSTER));
 	si->flags |= SWP_VSWAP | SWP_SOLIDSTATE | SWP_WRITEOK;
 	si->bdev = NULL;
 	si->max = maxpages;
-- 
2.53.0-Meta


