Return-Path: <cgroups+bounces-14069-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNo1A8WxmGnsKwMAu9opvQ
	(envelope-from <cgroups+bounces-14069-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 20:11:01 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BF16A4A0
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 20:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 26C51303D64E
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF026366DC4;
	Fri, 20 Feb 2026 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="TmnfVjnI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717331A7E1
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771614640; cv=none; b=Noyi4gkPHUxgoRTRqXVZC5nF4iZ0vrNXpbqq3sK4A4MqpITU3SI2TB1qihQ4tQYaBMKPk+4LUHDQpurZB4fiznuUx88mrHPTzDJ/tpqw29vPXCvII+mtMEq+C1YNdInLiuzRge8Z4v3EfsmKqkirTKKjMqk+Qh/1kT7t3R/17xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771614640; c=relaxed/simple;
	bh=utJESbMjuYKt520hS9qyPp85rEhDO7vmzpqGJ8Lrwno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnT48jSFA5lpbEHGer4yS0XcNh3GZbsESU7kBfqsRh1jmrgOxHxytWzNltxzhZmYOBwcISniR3NFUoBOv6QjWZdKQ7Q3cOpAhyeHBwwypqjyLLzoYE7WgtFuQRBL774dbjK0nGuE/IYsfoQIUpA8EZX0PSm26HAAzEJH2sb6tD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=TmnfVjnI; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-896fcfc591eso22555556d6.2
        for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 11:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1771614638; x=1772219438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRgCQhFlEEQQz8iVKpR/+XrwMVRXcKNbXIMlR69ixQE=;
        b=TmnfVjnIZhLDXV3cs5Pg0CEBeFf10iPC7u5atUalRV09oU+/sJrJfsNeKocLjoxI15
         YKH95ixb796wOFaiHY8E0dasqQvYXrCej1R1SnQ9s5tM97OiEiH/nO29si5ZOtO6Efy0
         1vW+ORiXD1KUYGHtc/tJqvK2Tvwuxsdkgo2w0tHjTDgGmGw8vvwQYOkOtuOwDWE2rXmt
         k2a5xyZfJJBtZtwODU0emXcQjVxGwX+WBOcKDaNth/aKA5LJ19fQ+crHGiqsk03VTOpE
         wAVXPfLDZsp/g2uFW73cjP+F9GO/GR6gH3n5AazPFe1issJiOjwOOvBj66CWQEEnNMCO
         ZseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771614638; x=1772219438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRgCQhFlEEQQz8iVKpR/+XrwMVRXcKNbXIMlR69ixQE=;
        b=rgLXWyZy4Q3/eu5WZLBJEw/t0+cW8g3CJX/YvO3AZFsssXCqX8rWpDr6N0ZULwCvSL
         vuClzIDujkfTn1FxnZJX2PXAxLvtckdXmm7NH3C4rLFchelNRe4dSA4CIYHWzRIWnUUN
         Nn0IKpVK2gdxTDT5Lhrg3GCEnMeu10gr9U/87C5BbmINa3NKBFBQHe48x+L3XQPl6kad
         0S0Yglb3CCMcBXEEdmMjhiCz68IXp1Ttoutyo6p2lGwL/yHAqZMu7KHrdcP8/hVQOkJq
         7gjdWFMTopee7YDvVj95/duqaTGXLYrKcsGgA4NsfJo68Ev+GYSSQHnX1rhIg4DcPjxj
         qu1g==
X-Forwarded-Encrypted: i=1; AJvYcCVP+JQzmZg0Tv1FZy1a74HTBTuakQR89pYCeU1l6Wev4CTJKmZfHmXRO0pzjgIKSJ1eeaT3T4Gw@vger.kernel.org
X-Gm-Message-State: AOJu0YyqpsJwRJmtpZD0h2MMyy/NP32JwTFNC7vtr8mkor/Z9K0CSWWr
	6XpMz5de1oUyncBgyjaNdqhEG6A8sx4sZCXjd2ysyzyk+Kpi3vGnlFxNtYHhX4O8g3U=
X-Gm-Gg: AZuq6aK5A5MMhvs/Qhk0Prrfzi2RlEhKZyVQW7mCGyhXH0+Alz7Hg2jPSkNsiJ5xX6B
	4bUB8BdjEijWGJ9ibLm2FFVDjo/WroLadCXiGsCSQmrw6Isp1C5zRXJbA+kiEUPIN8OGp/Egomi
	TNH2HUNfPyfN4vCsHQui8qNO7RlOeh896D9x90DEk6/1IWGfjnewrO4GlNj/dydt0LWyz+BBkPA
	900jWL7JimItlpZ6ZbkqUuRTMhzuLwsODTYW/E2OQkIt17+0ptqZG9X6DdAWV4VgV1JJUqkRDX2
	GoemodF/vb8vG8ICEFk9wbZ1rQXm0BCAVhs2HRBbueQXmDKcpBroaWNChFvBvNVEyoxCZJJa/sQ
	upgxTkKSrTdXI8p5Bs0CmJyVpSD0fEuFp5/fI9YPRk9/7hO3d6wHAQ4nKrdQmpEkd3LC0nAPVKv
	jiOEDRrQCwOISYtU2TNTpFNA==
X-Received: by 2002:ad4:5c6e:0:b0:894:562d:c0b9 with SMTP id 6a1803df08f44-89979d45c79mr15844316d6.0.1771614638028;
        Fri, 20 Feb 2026 11:10:38 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d1013fesm18977785a.36.2026.02.20.11.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 11:10:37 -0800 (PST)
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
Subject: [PATCH 2/2] mm: memcontrol: switch to native NR_VMALLOC vmstat counter
Date: Fri, 20 Feb 2026 14:10:35 -0500
Message-ID: <20260220191035.3703800-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220191035.3703800-1-hannes@cmpxchg.org>
References: <20260220191035.3703800-1-hannes@cmpxchg.org>
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
	TAGGED_FROM(0.00)[bounces-14069-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 7C6BF16A4A0
X-Rspamd-Action: no action

Eliminates the custom memcg counter and results in a single,
consolidated accounting call in vmalloc code.

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
index a49a46de9c4f..8773bc0c4734 100644
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
 
-		mod_node_page_state(page, NR_VMALLOC, 1 << large_order);
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
 
-		mod_node_page_state(page, NR_VMALLOC, 1 << order);
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


