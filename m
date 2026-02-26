Return-Path: <cgroups+bounces-14443-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCJZNYWgoGlVlAQAu9opvQ
	(envelope-from <cgroups+bounces-14443-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:35:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D241AE6C4
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D85CF30D3E85
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 19:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665934508E4;
	Thu, 26 Feb 2026 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhwA1atj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF56244CF4E
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772134201; cv=none; b=o0T/2mFp9bHk8LP+dU6oPHvc8yLwd1YeRSpoi1yyHqs7EzRxr61fAUYqleWUhSPCbZv/BU0bCmsWlYs28ZdPWaAr5gnGau/RT91eOw8ulBaOQLiE7ecjwzPFJp+APf99nw9OdsU/J8BhDReT0UQe8pmK/p43ykJGqNvgUO72LaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772134201; c=relaxed/simple;
	bh=edHifQhuD39SytJ2pdcEcAu31cCV6BrBABjFy6qdldM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSDf2baBg9jp4ddUrP2PwxubdbKSlpSgO6Wny4nDgQlDV+1nkHyVs/3sUYMOUsqwo2iTUIvb3PloskDnPw5KaVhlhmCHuR7NsS2TWMefbnMDdSgC/VCtAXJOVVkjjNt+mlEv262BEUsw9B+brU52GbJfFTyyB8qE28NnL1eInmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhwA1atj; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d1890f5cafso492696a34.1
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772134194; x=1772738994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB+jMUpA86bxO+NhQL7ENpCNqUG0HUtrRjDNh//YUrM=;
        b=XhwA1atjD5hDDHc1pivvDyZRBKzL1yjyBZIUMS6ZVJ2pwpsrN6h5tDl9SW1dtl+Mlx
         zAXYX1j+slujQgZ8cVtRA4dnkTpyZn2hIa5KwbVqoB0z6zyccJFV1KxrSh1dIMC6c+Mk
         +eIamg5qCaXnijzUa/67kVrEWHncBsoRfgZKs3Wb2Gz5k55ubRL3pkwAx2BzUturpQxr
         LGHduzsAOMFnF/76rerVqPjAfbIyFNJ0sLsw+d0WpDjP/ijKMRSNx109wyA1PLP+uq/o
         Jd9Io6Y1/v+5hF9FuY5219XfiTTCM89/dfcZVEYjoP5Am2mf1Hc7G+cGtgVcnqea0slx
         7A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772134194; x=1772738994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DB+jMUpA86bxO+NhQL7ENpCNqUG0HUtrRjDNh//YUrM=;
        b=haS7rHy9z79blRDkRW3MvR4tpc3RPZF/gVXOcL+eLXE2uOu1+GORzMZEvhEWZmv0Aq
         qYmoNxq3hV3MFjIWORykRYgs05w2TD0d9PZVydTWvBCj/QG5/iU2+oXwYYkzFr+9tdVr
         U85sSAnn/UQcTH/WvQqciVW3ikX9roNAQTIhbWA+7SPNh4A15O5hjO4JbPPoIu94Lxh2
         MceDqDj4C4ge7G2PM2JCqKGjSzlguFVMKG5kmOSLIaeS5Nn2xVaMojUq5CoRKkfEtl/S
         mLV6h1//gO/AxLdk/zszAAB9hG8su1Wz+PMj6T7fvX6Xq9L7EFmKPhmofQlpjeHuNHN7
         ObgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB/8+csAIT/g70IqvpxrruB7JvNwpYhOyE2pNbLGlPov+n8eogiHMLXBv++VhTH8hBebNLGZRV@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfoiMtif9EGIL1JFrP2eTN7qk8H2zCkM2R94e9NFV5s+nCdXX
	TGjcT0/Cm2ah2UrMvvCe4ft1ebjTYBs6/HsgtqxMDOFgodUCzlzUWCg3
X-Gm-Gg: ATEYQzzraL2a5DGUF/6tFVOy2e/CFDO7xAI8iyP3tMnkadDDgFoHRwxq2ZvfsMPtLJK
	0IDcLqEe4OYSaAiW6NCTAxbBwlQwQlQQuc9LouQob+O30nK6bupEU0494FLS81e+YmFKbovBbfh
	rrdmxG2eQd6W3Pnpa+Mgt+wcRgWGC2/vpK9fKg9KHUxe26G9Csaqkn6uN4aKTHUlmvRfoZ2EBMx
	b4+rUBofBhVhMH6Zi8WNQpJqAWlF+ru0FmC5OfTQGf2ac7xl2EDzVVzHxN//n4aOdz3rXfH9/E5
	RT697z9hJiaIEga419zwJpglTz8T2ix/zxdacjmYHsMX1wSnMKCndupaUTV5di0UQetPZGZucym
	/nhGns5dlkMIs1RWqo+QaNAodrFd2wk9DG/kNQxq3lvIXb3qxEVjTRiM8pLzqki4qSczjViE4jj
	QWByb2SsK6YkaUmBK08OBFlg==
X-Received: by 2002:a05:6830:8388:b0:7cb:125d:2a43 with SMTP id 46e09a7af769-7d591be4a4dmr307474a34.28.1772134193631;
        Thu, 26 Feb 2026 11:29:53 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d5866557c6sm2419781a34.24.2026.02.26.11.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:29:53 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 8/8] mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec
Date: Thu, 26 Feb 2026 11:29:31 -0800
Message-ID: <20260226192936.3190275-9-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
References: <20260226192936.3190275-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kernel.org,google.com,oracle.com,suse.cz,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14443-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65D241AE6C4
X-Rspamd-Action: no action

Now that memcg charging happens in the zsmalloc layer where we have both
objcg and page information, we can specify which node's memcg lruvec
zswapped memory should be accounted to.

Move MEMCG_ZSWAP_B and MEMCG_ZSWAPPED_B from enum_node_stat_item to
int memcg_node_stat_items. Rename their prefix from MEMCG to NR to
reflect this move as well.

In addition, decouple the updates of node stats (vmstat) and
memcg-lruvec stats, since node stats can only track values at a
PAGE_SIZE granularity.

Finally, track the moving charges whenever a compressed object migrates
from one zspage to another.

memcg-lruvec stats are now updated precisely and proportionally when
compressed objects are split across pages. Unfortunately for node stats,
only NR_ZSWAP_B can be kept accurate. NR_ZSWAPPED_B works as a good
best-effort value, but cannot proportionally account for compressed
objects split across pages due to the coarse PAGE_SIZE granularity
of node stats. For such objects, NR_ZSWAPPED_B is accounted to the first
zpdesc's node stats.

Note that this is not a new inaccuracy, but one that is simply left
unable to be fixed as part of these changes. The small inaccuracy is
accepted in place of invasive changes across all of vmstat
infrastructure to begin tracking stats at byte granularity.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h |  5 +--
 include/linux/mmzone.h     |  2 ++
 mm/memcontrol.c            | 18 +++++-----
 mm/vmstat.c                |  2 ++
 mm/zsmalloc.c              | 72 ++++++++++++++++++++++++++++++--------
 mm/zswap.c                 |  4 +--
 6 files changed, 76 insertions(+), 27 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d3952c918fd4..ba97b86d9104 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -37,8 +37,6 @@ enum memcg_stat_item {
 	MEMCG_PERCPU_B,
 	MEMCG_VMALLOC,
 	MEMCG_KMEM,
-	MEMCG_ZSWAP_B,
-	MEMCG_ZSWAPPED_B,
 	MEMCG_NR_STAT,
 };
 
@@ -932,6 +930,9 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 void mod_memcg_state(struct mem_cgroup *memcg,
 		     enum memcg_stat_item idx, int val);
 
+void mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			    int val);
+
 static inline void mod_memcg_page_state(struct page *page,
 					enum memcg_stat_item idx, int val)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3e51190a55e4..ae16a90491ac 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -258,6 +258,8 @@ enum node_stat_item {
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
+	NR_ZSWAP_B,
+	NR_ZSWAPPED_B,
 	NR_BALLOON_PAGES,
 	NR_KERNEL_FILE_PAGES,
 	NR_VM_NODE_STAT_ITEMS
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b662902d4e03..dc7cfff97296 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -331,6 +331,8 @@ static const unsigned int memcg_node_stat_items[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
+	NR_ZSWAP_B,
+	NR_ZSWAPPED_B,
 };
 
 static const unsigned int memcg_stat_items[] = {
@@ -339,8 +341,6 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_PERCPU_B,
 	MEMCG_VMALLOC,
 	MEMCG_KMEM,
-	MEMCG_ZSWAP_B,
-	MEMCG_ZSWAPPED_B,
 };
 
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
@@ -726,7 +726,7 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 }
 #endif
 
-static void mod_memcg_lruvec_state(struct lruvec *lruvec,
+void mod_memcg_lruvec_state(struct lruvec *lruvec,
 				     enum node_stat_item idx,
 				     int val)
 {
@@ -1344,8 +1344,8 @@ static const struct memory_stat memory_stats[] = {
 	{ "vmalloc",			MEMCG_VMALLOC			},
 	{ "shmem",			NR_SHMEM			},
 #ifdef CONFIG_ZSWAP
-	{ "zswap",			MEMCG_ZSWAP_B			},
-	{ "zswapped",			MEMCG_ZSWAPPED_B		},
+	{ "zswap",			NR_ZSWAP_B			},
+	{ "zswapped",			NR_ZSWAPPED_B			},
 #endif
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
@@ -1392,8 +1392,8 @@ static int memcg_page_state_unit(int item)
 {
 	switch (item) {
 	case MEMCG_PERCPU_B:
-	case MEMCG_ZSWAP_B:
-	case MEMCG_ZSWAPPED_B:
+	case NR_ZSWAP_B:
+	case NR_ZSWAPPED_B:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
 		return 1;
@@ -5424,7 +5424,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 
 		/* Force flush to get accurate stats for charging */
 		__mem_cgroup_flush_stats(memcg, true);
-		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
+		pages = memcg_page_state(memcg, NR_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
 		ret = false;
@@ -5453,7 +5453,7 @@ static u64 zswap_current_read(struct cgroup_subsys_state *css,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	mem_cgroup_flush_stats(memcg);
-	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
+	return memcg_page_state(memcg, NR_ZSWAP_B);
 }
 
 static int zswap_max_show(struct seq_file *m, void *v)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 99270713e0c1..4b10610bd999 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1279,6 +1279,8 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
+	[I(NR_ZSWAP_B)]				= "zswap",
+	[I(NR_ZSWAPPED_B)]			= "zswapped",
 	[I(NR_BALLOON_PAGES)]			= "nr_balloon_pages",
 	[I(NR_KERNEL_FILE_PAGES)]		= "nr_kernel_file_pages",
 #undef I
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 6794927c60fb..548e7f4b8bf6 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -810,6 +810,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
 	struct zpdesc *zpdesc, *next;
+	bool objcg = !!zpdesc_objcgs(zspage->first_zpdesc);
 
 	assert_spin_locked(&class->lock);
 
@@ -823,6 +824,8 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 		reset_zpdesc(zpdesc);
 		zpdesc_unlock(zpdesc);
 		zpdesc_dec_zone_page_state(zpdesc);
+		if (objcg)
+			dec_node_page_state(zpdesc_page(zpdesc), NR_ZSWAP_B);
 		zpdesc_put(zpdesc);
 		zpdesc = next;
 	} while (zpdesc != NULL);
@@ -963,11 +966,45 @@ static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
 	return true;
 }
 
-static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
-			    int size, unsigned long offset)
+static void __zs_mod_memcg_lruvec(struct zpdesc *zpdesc,
+				  struct obj_cgroup *objcg, int size,
+				  int sign, unsigned long offset)
 {
 	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+	int compressed_size = size, original_size = PAGE_SIZE;
+	int nid = page_to_nid(zpdesc_page(zpdesc));
+	int next_nid = nid;
+
+	if (offset + size > PAGE_SIZE) {
+		struct zpdesc *next_zpdesc = get_next_zpdesc(zpdesc);
+
+		next_nid = page_to_nid(zpdesc_page(next_zpdesc));
+		if (nid != next_nid) {
+			compressed_size = PAGE_SIZE - offset;
+			original_size = (PAGE_SIZE * compressed_size) / size;
+		}
+	}
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+	mod_memcg_lruvec_state(lruvec, NR_ZSWAP_B, sign * compressed_size);
+	mod_memcg_lruvec_state(lruvec, NR_ZSWAPPED_B, sign * original_size);
+
+	if (nid != next_nid) {
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(next_nid));
+		mod_memcg_lruvec_state(lruvec, NR_ZSWAP_B,
+				       sign * (size - compressed_size));
+		mod_memcg_lruvec_state(lruvec, NR_ZSWAPPED_B,
+				       sign * (PAGE_SIZE - original_size));
+	}
+	rcu_read_unlock();
+}
 
+static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
+			    int size, unsigned long offset)
+{
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
@@ -977,28 +1014,30 @@ static void zs_charge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
 	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
 		VM_WARN_ON_ONCE(1);
 
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
-	mod_memcg_state(memcg, MEMCG_ZSWAPPED_B, 1);
-	rcu_read_unlock();
+	__zs_mod_memcg_lruvec(zpdesc, objcg, size, 1, offset);
+
+	/*
+	 * Node-level vmstats are charged in PAGE_SIZE units. As a
+	 * best-effort, always charge NR_ZSWAPPED_B to the first zpdesc.
+	 */
+	inc_node_page_state(zpdesc_page(zpdesc), NR_ZSWAPPED_B);
 }
 
 static void zs_uncharge_objcg(struct zpdesc *zpdesc, struct obj_cgroup *objcg,
 			      int size, unsigned long offset)
 {
-	struct mem_cgroup *memcg;
-
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
 	obj_cgroup_uncharge(objcg, size);
 
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
-	mod_memcg_state(memcg, MEMCG_ZSWAPPED_B, -1);
-	rcu_read_unlock();
+	__zs_mod_memcg_lruvec(zpdesc, objcg, size, -1, offset);
+
+	/*
+	 * Node-level vmstats are uncharged in PAGE_SIZE units. As a
+	 * best-effort, always uncharge NR_ZSWAPPED_B to the first zpdesc.
+	 */
+	dec_node_page_state(zpdesc_page(zpdesc), NR_ZSWAPPED_B);
 }
 
 static void migrate_obj_objcg(unsigned long used_obj, unsigned long free_obj,
@@ -1135,6 +1174,8 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		__zpdesc_set_zsmalloc(zpdesc);
 
 		zpdesc_inc_zone_page_state(zpdesc);
+		if (objcg)
+			inc_node_page_state(zpdesc_page(zpdesc), NR_ZSWAP_B);
 		zpdescs[i] = zpdesc;
 	}
 
@@ -1149,6 +1190,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 err:
 	while (--i >= 0) {
 		zpdesc_dec_zone_page_state(zpdescs[i]);
+		if (objcg)
+			dec_node_page_state(zpdesc_page(zpdescs[i]),
+					    NR_ZSWAP_B);
 		free_zpdesc(zpdescs[i]);
 	}
 	cache_free_zspage(zspage);
diff --git a/mm/zswap.c b/mm/zswap.c
index 97f38d0afa86..9e845e1d7214 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1214,9 +1214,9 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 */
 	if (!mem_cgroup_disabled()) {
 		mem_cgroup_flush_stats(memcg);
-		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B);
+		nr_backing = memcg_page_state(memcg, NR_ZSWAP_B);
 		nr_backing >>= PAGE_SHIFT;
-		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED_B);
+		nr_stored = memcg_page_state(memcg, NR_ZSWAPPED_B);
 		nr_stored >>= PAGE_SHIFT;
 	} else {
 		nr_backing = zswap_total_pages();
-- 
2.47.3


