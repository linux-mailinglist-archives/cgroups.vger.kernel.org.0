Return-Path: <cgroups+bounces-14152-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BLVAIV8nGm6IQQAu9opvQ
	(envelope-from <cgroups+bounces-14152-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:12:53 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D117975E
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 17:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB724315F908
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975DC30EF83;
	Mon, 23 Feb 2026 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="E1uFTbv0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248A730E85B
	for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862514; cv=none; b=OXcy2rZSwRIjZPG1xrQ9mR2Vajqx+TvP8HfI21Y3ACFL7q/idovgE6JBjMI8SFzzah/8NqL7pApTuE7o26gfJFl/qYHUqrAmAmrPvNsVbjWncgeaSjntGaApNXY79xISn5BbIcHx0Hih0FOU5xP+bT6rC2gCrJICiqa0fyUOtcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862514; c=relaxed/simple;
	bh=RLCDY/1zjQaubgq3bBR851hPUzZ+4N6tiWN4RlBY8m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNKacXNmhS13gdgfxk0sbGCHyIYsbdH3jSiDefvVzZwtkrS5kUvJ3/r2b7bXDHO5u6lQMNtrkXMKjCEetzY57r/atQmeIBP4hA9YmZrOVQ9g0xmtYFLM92XWwKkFo0Cpza/00Aw6sQzzoX57EVIBuc7bvSww6iBbApQfpN+1F6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=E1uFTbv0; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c710439535so319982385a.1
        for <cgroups@vger.kernel.org>; Mon, 23 Feb 2026 08:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771862512; x=1772467312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LteDtGYRVDzNtl6BMvU4eGCDLJeRdYaj9DQgkFpHKvk=;
        b=E1uFTbv0wDNB6xkF6RcEteaeGZf7fzPQui7uWk058MMrMtgVC84N2hQPUVbmqbAcSg
         GRwtvFoO07p4pfc4M5tWI4MF22J3HAM67MfH3XcHNBE46A14YLNsLJqvn6EkNXGyT363
         TL9QlKEODGTN2JiF337Pds0szb57Xnw2wEjlbuyDilC+DcRTPAWUEpHXbawIOX0eDdYG
         WRGrNGmxSckNJlTT0wdCpVrA5S+wHMqI/vb8EKuIPgjxhDKhQCW8tWCdODOzdEbYMHeZ
         AMlkvo7y9/qdzB7RF3xXAbzvkgxBgAMRFQEz1dPfw393o2qvHRJCqpyLeEtmAWaapqgK
         q0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862512; x=1772467312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LteDtGYRVDzNtl6BMvU4eGCDLJeRdYaj9DQgkFpHKvk=;
        b=bvxrRU4Wts+eNLi9ClXpACON5TcU8V5ALvWa98w4czvO4RLZdzzCyTmFQv+0hRpivf
         pck0PnfX1nGPRnlbYuVMsNKsWtSTc7csxgCttC68+UUiP9lY20t2XHxfJdlQe+ArYMH3
         42noxFuVlKuzX5KJC/hAcwbtydEqyTPhdQlJC2OVprsjzy08fUvGQ6aLAYw8of4aNrFW
         j9Q8R6gE2bx0u5aj1Y8BLCd4Cj3QmJ8/b+NaJpRixSp7X92tqB42Gag3ztLEjem6n2V6
         VK/c0V2ZWtWYlZ0Z+5CW4ZY7g9ZShG7v6AW/YwOgZ48IeQu24xh0mdxaQBnWKI4pnTC6
         bZrA==
X-Forwarded-Encrypted: i=1; AJvYcCX8XQqUIc/uuVEjwyJe+4GMuSYJCVmNVZ/lF932RWPlAY1s+sRtww1pmm4UyJfak/qKlvScWc/P@vger.kernel.org
X-Gm-Message-State: AOJu0YxrLYBk6awsqIKd6XGiCe0AN6CBulYUasxYBpH2rCdqOdBmgnHS
	NHPEN1r8rmgio3cSIxXYOnTNGXZSvtxPkDWuIkrXLU+Og+Ej/wt1fdx4EM0BYVoDKc4=
X-Gm-Gg: AZuq6aJb+8uWEpsC/AoyBRn7W+e4VyzfH9Arj9n6HF3dqPBnVxjvGl2EhHoR5pj+S2q
	jGpQbD6NTMKAqBn7F93JBDkXj+bMtBKS2N6ttS5Z0hC3kDWZp4idrPmrleR7Iyhpee9e3ZEsaw3
	P+gvQAyQMuGPK5eFFmz8QZBUXi0KHlcsZDSoN4Uk/IJ6cPna2aljhsiI1XQGMPKdsH0Pgcky6fe
	vBuahMmV3gW/9B+3OklrkmiZWLogYKx2Du1uN7FtuRDVXhJOLkfGescxuVL2E/N4S6r4nzxG8cN
	h6dzxS6qF7aOaemsxmD//UBoA/bKUbrdgWCyOIZ9B9VZja+igxsfxIKjP9GTJJW3TqKtq4znObx
	XDfLRy8IvOAydvKaaj3VqwxCFBKlMGP0bAUfL1r77qwJBgWioHc52FzXEKF5ySzUF3uPXJUSWtN
	sLucUqI0wmt9ZtHsYTFnNoVw==
X-Received: by 2002:a05:620a:1714:b0:89b:9b75:f5f1 with SMTP id af79cd13be357-8cb8ca65b1dmr1104819285a.53.1771862510373;
        Mon, 23 Feb 2026 08:01:50 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0614fbsm842409585a.17.2026.02.23.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:01:49 -0800 (PST)
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
Subject: [PATCH v2 2/2] mm: memcontrol: switch to native NR_VMALLOC vmstat counter
Date: Mon, 23 Feb 2026 11:01:07 -0500
Message-ID: <20260223160147.3792777-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223160147.3792777-1-hannes@cmpxchg.org>
References: <20260223160147.3792777-1-hannes@cmpxchg.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.com,linux.dev,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-14152-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 6C8D117975E
X-Rspamd-Action: no action

Eliminates the custom memcg counter and results in a single,
consolidated accounting call in vmalloc code.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  1 -
 mm/memcontrol.c            |  4 ++--
 mm/vmalloc.c               | 16 ++++------------
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 67f154de10bc..c7cc4e50e59a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -35,7 +35,6 @@ enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
-	MEMCG_VMALLOC,
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 129eed3ff5bb..fef5bdd887e0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -317,6 +317,7 @@ static const unsigned int memcg_node_stat_items[] = {
 	NR_SHMEM_THPS,
 	NR_FILE_THPS,
 	NR_ANON_THPS,
+	NR_VMALLOC,
 	NR_KERNEL_STACK_KB,
 	NR_PAGETABLE,
 	NR_SECONDARY_PAGETABLE,
@@ -339,7 +340,6 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_SWAP,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
-	MEMCG_VMALLOC,
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
@@ -1359,7 +1359,7 @@ static const struct memory_stat memory_stats[] = {
 	{ "sec_pagetables",		NR_SECONDARY_PAGETABLE		},
 	{ "percpu",			MEMCG_PERCPU_B			},
 	{ "sock",			MEMCG_SOCK			},
-	{ "vmalloc",			MEMCG_VMALLOC			},
+	{ "vmalloc",			NR_VMALLOC			},
 	{ "shmem",			NR_SHMEM			},
 #ifdef CONFIG_ZSWAP
 	{ "zswap",			MEMCG_ZSWAP_B			},
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a5fc7795aafd..8773bc0c4734 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3446,9 +3446,6 @@ void vfree(const void *addr)
 
 	if (unlikely(vm->flags & VM_FLUSH_RESET_PERMS))
 		vm_reset_perms(vm);
-	/* All pages of vm should be charged to same memcg, so use first one. */
-	if (vm->nr_pages && !(vm->flags & VM_MAP_PUT_PAGES))
-		mod_memcg_page_state(vm->pages[0], MEMCG_VMALLOC, -vm->nr_pages);
 	for (i = 0; i < vm->nr_pages; i++) {
 		struct page *page = vm->pages[i];
 
@@ -3458,7 +3455,7 @@ void vfree(const void *addr)
 		 * can be freed as an array of order-0 allocations
 		 */
 		if (!(vm->flags & VM_MAP_PUT_PAGES))
-			dec_node_page_state(page, NR_VMALLOC);
+			mod_lruvec_page_state(page, NR_VMALLOC, -1);
 		__free_page(page);
 		cond_resched();
 	}
@@ -3649,7 +3646,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 			continue;
 		}
 
-		mod_node_page_state(page_pgdat(page), NR_VMALLOC, 1 << large_order);
+		mod_lruvec_page_state(page, NR_VMALLOC, 1 << large_order);
 
 		split_page(page, large_order);
 		for (i = 0; i < (1U << large_order); i++)
@@ -3696,7 +3693,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 							pages + nr_allocated);
 
 			for (i = nr_allocated; i < nr_allocated + nr; i++)
-				inc_node_page_state(pages[i], NR_VMALLOC);
+				mod_lruvec_page_state(pages[i], NR_VMALLOC, 1);
 
 			nr_allocated += nr;
 
@@ -3722,7 +3719,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 		if (unlikely(!page))
 			break;
 
-		mod_node_page_state(page_pgdat(page), NR_VMALLOC, 1 << order);
+		mod_lruvec_page_state(page, NR_VMALLOC, 1 << order);
 
 		/*
 		 * High-order allocations must be able to be treated as
@@ -3866,11 +3863,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			vmalloc_gfp_adjust(gfp_mask, page_order), node,
 			page_order, nr_small_pages, area->pages);
 
-	/* All pages of vm should be charged to same memcg, so use first one. */
-	if (gfp_mask & __GFP_ACCOUNT && area->nr_pages)
-		mod_memcg_page_state(area->pages[0], MEMCG_VMALLOC,
-				     area->nr_pages);
-
 	/*
 	 * If not enough pages were obtained to accomplish an
 	 * allocation request, free them via vfree() if any.
-- 
2.53.0


