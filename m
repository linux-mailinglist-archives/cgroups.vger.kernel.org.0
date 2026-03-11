Return-Path: <cgroups+bounces-14772-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MdFGz/IsWnvFAAAu9opvQ
	(envelope-from <cgroups+bounces-14772-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:53:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD08269AAD
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 761E5300DEEF
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 19:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A8237C0F8;
	Wed, 11 Mar 2026 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grVR1c4e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560FE37CD3F
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258733; cv=none; b=AIj+9EphsPj8OD5kaO2waxAldaALloL+hCgYWbFhXrNM6VcfPkVGgLzhmKfhiD68mcjpJLEr1ExoyHFuWafHyzRDVuRgejgZOLIOr0NDX1/ss7XAPA2PGvFMSJqMwoVrUlgIlQer2lHWlrCd7TesoGqz3CfQVxD0Hgj87RjHS00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258733; c=relaxed/simple;
	bh=dAUgueIEZ0YXut4fS4lJiG6S2nqFrA7mA7DBgHTcaq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzaiNqlElcuOGo1/LCf8Sr6ZFj+VkPYsrQlN21CVZ0y0C3NPDOEsa85TfSZULoXYoOazlTucqDSB7eclSnQ6I99mUneYzsbt+YSo235tMD6OZrw71gUEBAVAwXh9U8QWQngZ2joJKLpjk5M1AULygdIUhZ4HRJIhG6OwnsdhsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grVR1c4e; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-67bb04151dcso186741eaf.0
        for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 12:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773258727; x=1773863527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4vnZsb9mXNhtrNGbaJxIgoiKf+xedfYV6/25GSFY7Q=;
        b=grVR1c4ey3ufRp/etWAguwvOJXDqU8ZisNM0pjrvsGywWK9mBs/ufSOVSGKFRrdwwl
         f4+vdHVtGtTE/mML7wD8lpt+X1I7PuKwAPMqstHR7EYaQsg2QZAMt1kRJAZ3FCvsufoj
         nWFp9SyGSWlFuzO2df0egZQpImM2WtaEM9jdsUbMWKgtRtnVbT+fPNct/sod00SFmUaI
         ko+QdkI7q3dozCQZYhvlK5Z9YBb2dulhbQY8Kd+62Mx6dUtS0fLvoOtVn5ed/NxPAjX9
         WaOq0Ie7Zk5vgIyJybYzrYi6EYdbR35FYXo+4CqrtXE56oIWL0Oon9qbrhX3LGLoWrzL
         CisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773258727; x=1773863527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e4vnZsb9mXNhtrNGbaJxIgoiKf+xedfYV6/25GSFY7Q=;
        b=hPPrEXrkGE32PqhM6lie4EpgvMJ0eF9YMcpk7AJvoc6zhWDaZzJVWP14tPWILZMv8i
         qTIi1mFIXd6tAVSR5tZ5G64/ePmd4+L0y9wWEh4avaZJFgJt05kAS0fpw2pxB9E1vKc6
         7aDejn4X2CEW8YKVmDncNPooQ5hHnxEQLFjGJAI8tkDYp0YffA6u7LmXR7SiBGwDI0Zj
         0U+Na4/KP3UxhmnYfP8S1pFklpRTlt8DsU3cYdVgPBIbi0tuRdYDf+orFHyDFUraQlGi
         lvXFyKo7ivubzttpl9LCD+mYZjNRY39m6PBjfL7VTomxtbxEfSB2iiq6kBuiMlymxfhl
         IWBw==
X-Forwarded-Encrypted: i=1; AJvYcCVQaTsYjS3122w0OMFnz9sN6q93jEYx6mr0TAIuctgOt7A+5N4IcFFoI+Rwr7pZTXl/HXgiBXoc@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPyroGz87JjqBpLh8WophiQFP2d+gsBhSsKom1DAa1pgRuIY9
	iu0NKw7RX4JTXytAwXtzZm093AMn1IL+LCBYdDibomOMzhXcSRVowDt+
X-Gm-Gg: ATEYQzwvUMehNELvDGwWAP/Ttu443irNWIbwyqLORsoHYqQmhe91AeHRo8fmyOVcZ5G
	gVUZ1MnfMI/mQyeE1OGQwv+WzJRN/xmrk5Z3G18F7r9yde/CnxpsL7QnxRHmIoY83XQZjrOHxqL
	tG8SXZ1ZmHLEcLshFkhRX9lNDoUhzoGA6U25LzeAUUPXpQX7NzbxfnVtORuKuYXUYgEpdTOM/qa
	LObwEBR1QnVXP9L/25fIWmkJgHiYBITbJHU1rXrH+Yz8sIDiM00a7HAGhpoXlZRIVtVF9wEQcn/
	PVJ0rd5GvYMm9nAHJZOe1YI4/Ix+Uq8b4nz/qklffm17hPYdNGW106KnF+fKrBlNl72qZu3sGUo
	uCM/vF5GtH7I2+O5GNPQORe3ZHkLMWmvA8kWZ+qLMvGYjKf4sa98WYOVHLpo0Y7aFzoKkZ4gN8t
	UqbOuAVjyxHw28htRx6/w7yInkEpcrN+Vz
X-Received: by 2002:a05:6820:c92:b0:67b:af79:4c1c with SMTP id 006d021491bc7-67bc887c1e1mr2569350eaf.2.1773258726845;
        Wed, 11 Mar 2026 12:52:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:47::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bc9354e59sm1922332eaf.16.2026.03.11.12.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:52:06 -0700 (PDT)
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
Subject: [PATCH 09/11] mm/vmstat, memcontrol: Track ZSWAP_B, ZSWAPPED_B per-memcg-lruvec
Date: Wed, 11 Mar 2026 12:51:46 -0700
Message-ID: <20260311195153.4013476-10-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,linux.dev,gmail.com,kernel.org,google.com,oracle.com,suse.cz,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14772-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FD08269AAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that memcg charging happens in the zsmalloc layer where we have both
objcg and page information, we can specify which node's memcg lruvec
zswapped memory should be accounted to.

Move MEMCG_ZSWAP_B and MEMCG_ZSWAPPED_B from enum memcg_stat_item to
enum node_stat_item. Reanme their prefixes from MEMCG to NR to reflect
this move as well.

In addition, decouple the updates of node stats (vmstat) and
memcg-lruvec stats, since node stats can only track values at a
PAGE_SIZE granularity.

As a result of tracking zswap statistics at a finer granularity, the
charging from zsmalloc also gets more complicated to cover the cases
when the compressed object spans two zpdescs, which both live on
different nodes. In this case, the memcg-lruvec of both node-memcg
combinations are partially charged.

memcg-lruvec stats are now updated precisely and proportionally when
compressed objects are split across pages. Unfortunately for node stats,
only NR_ZSWAP_B can be kept accurate. NR_ZSWAPPED_B works as a good
best-effort value, but cannot proportionally account for compressed
objects split across nodes due to the coarse PAGE_SIZE granularity of
node stats. For such objects, NR_ZSWAPPED_B is accounted to the first
zpdesc's node stats.

Note that this is not a new inaccuracy, but one that is simply left
unable to be fixed as part of these changes. The small inaccuracy is
accepted in place of invasive changes across all of vmstat
infrastructure to begin tracking stats at byte granularity.

Finally, note that handling of objcg migrations across zspages (and
their subsequent migrations across nodes) are handled in the next patch.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/memcontrol.h |   5 +-
 include/linux/mmzone.h     |   2 +
 include/linux/zsmalloc.h   |   6 +--
 mm/memcontrol.c            |  22 ++++----
 mm/vmstat.c                |   2 +
 mm/zsmalloc.c              | 104 +++++++++++++++++++++++++++----------
 mm/zswap.c                 |   7 ++-
 7 files changed, 102 insertions(+), 46 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ce2e598b5963..b03501e0c09b 100644
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
 
@@ -927,6 +925,9 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
+void mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			    int val);
+
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 void mod_memcg_state(struct mem_cgroup *memcg,
 		     enum memcg_stat_item idx, int val);
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
diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index 6010d8dac9ff..fd79916c7740 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -24,11 +24,11 @@ struct zs_pool_stats {
 struct zs_pool;
 struct scatterlist;
 struct obj_cgroup;
-enum memcg_stat_item;
+enum node_stat_item;
 
 struct zs_pool *zs_create_pool(const char *name, bool memcg_aware,
-			       enum memcg_stat_item compressed_stat,
-			       enum memcg_stat_item uncompressed_stat);
+			       enum node_stat_item compressed_stat,
+			       enum node_stat_item uncompressed_stat);
 void zs_destroy_pool(struct zs_pool *pool);
 
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t flags,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1cb02d2febe8..d87bc4beff16 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -333,6 +333,8 @@ static const unsigned int memcg_node_stat_items[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
+	NR_ZSWAP_B,
+	NR_ZSWAPPED_B,
 };
 
 static const unsigned int memcg_stat_items[] = {
@@ -341,8 +343,6 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_PERCPU_B,
 	MEMCG_VMALLOC,
 	MEMCG_KMEM,
-	MEMCG_ZSWAP_B,
-	MEMCG_ZSWAPPED_B,
 };
 
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
@@ -737,9 +737,8 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 }
 #endif
 
-static void mod_memcg_lruvec_state(struct lruvec *lruvec,
-				     enum node_stat_item idx,
-				     int val)
+void mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			    int val)
 {
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
@@ -766,6 +765,7 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 
 	put_cpu();
 }
+EXPORT_SYMBOL(mod_memcg_lruvec_state);
 
 /**
  * mod_lruvec_state - update lruvec memory statistics
@@ -1363,8 +1363,8 @@ static const struct memory_stat memory_stats[] = {
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
@@ -1411,8 +1411,8 @@ static int memcg_page_state_unit(int item)
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
@@ -5482,7 +5482,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 
 		/* Force flush to get accurate stats for charging */
 		__mem_cgroup_flush_stats(memcg, true);
-		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
+		pages = memcg_page_state(memcg, NR_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
 		ret = false;
@@ -5511,7 +5511,7 @@ static u64 zswap_current_read(struct cgroup_subsys_state *css,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	mem_cgroup_flush_stats(memcg);
-	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
+	return memcg_page_state(memcg, NR_ZSWAP_B);
 }
 
 static int zswap_max_show(struct seq_file *m, void *v)
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 86b14b0f77b5..389ff986ceac 100644
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
index 24665d7cd4a9..ab085961b0e2 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -216,8 +216,8 @@ struct zs_pool {
 	struct work_struct free_work;
 #endif
 	bool memcg_aware;
-	enum memcg_stat_item compressed_stat;
-	enum memcg_stat_item uncompressed_stat;
+	enum node_stat_item compressed_stat;
+	enum node_stat_item uncompressed_stat;
 	/* protect zspage migration/compaction */
 	rwlock_t lock;
 	atomic_t compaction_in_progress;
@@ -823,6 +823,9 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 		reset_zpdesc(zpdesc);
 		zpdesc_unlock(zpdesc);
 		zpdesc_dec_zone_page_state(zpdesc);
+		if (pool->memcg_aware)
+			dec_node_page_state(zpdesc_page(zpdesc),
+					    pool->compressed_stat);
 		zpdesc_put(zpdesc);
 		zpdesc = next;
 	} while (zpdesc != NULL);
@@ -974,6 +977,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 		__zpdesc_set_zsmalloc(zpdesc);
 
 		zpdesc_inc_zone_page_state(zpdesc);
+		if (pool->memcg_aware)
+			inc_node_page_state(zpdesc_page(zpdesc),
+					    pool->compressed_stat);
 		zpdescs[i] = zpdesc;
 	}
 
@@ -985,6 +991,9 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 err:
 	while (--i >= 0) {
 		zpdesc_dec_zone_page_state(zpdescs[i]);
+		if (pool->memcg_aware)
+			dec_node_page_state(zpdesc_page(zpdescs[i]),
+					    pool->compressed_stat);
 		free_zpdesc(zpdescs[i]);
 	}
 	if (pool->memcg_aware)
@@ -1029,10 +1038,48 @@ static bool zspage_empty(struct zspage *zspage)
 }
 
 #ifdef CONFIG_MEMCG
-static void zs_charge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
-			    int size)
+static void __zs_mod_memcg_lruvec(struct zs_pool *pool, struct zpdesc *zpdesc,
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
+	mod_memcg_lruvec_state(lruvec, pool->compressed_stat,
+			       sign * compressed_size);
+	mod_memcg_lruvec_state(lruvec, pool->uncompressed_stat,
+			       sign * original_size);
+
+	if (nid != next_nid) {
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(next_nid));
+		mod_memcg_lruvec_state(lruvec, pool->compressed_stat,
+				       sign * (size - compressed_size));
+		mod_memcg_lruvec_state(lruvec, pool->uncompressed_stat,
+				       sign * (PAGE_SIZE - original_size));
+	}
+	rcu_read_unlock();
+}
+
+static void zs_charge_objcg(struct zs_pool *pool, struct zpdesc *zpdesc,
+			    struct obj_cgroup *objcg, int size,
+			    unsigned long offset)
+{
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
@@ -1044,18 +1091,19 @@ static void zs_charge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
 	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
 		VM_WARN_ON_ONCE(1);
 
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	mod_memcg_state(memcg, pool->compressed_stat, size);
-	mod_memcg_state(memcg, pool->uncompressed_stat, PAGE_SIZE);
-	rcu_read_unlock();
+	__zs_mod_memcg_lruvec(pool, zpdesc, objcg, size, 1, offset);
+
+	/*
+	 * Node-level vmstats are charged in PAGE_SIZE units. As a best-effort,
+	 * always charge the uncompressed stats to the first zpdesc.
+	 */
+	inc_node_page_state(zpdesc_page(zpdesc), pool->uncompressed_stat);
 }
 
-static void zs_uncharge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
-			      int size)
+static void zs_uncharge_objcg(struct zs_pool *pool, struct zpdesc *zpdesc,
+			      struct obj_cgroup *objcg, int size,
+			      unsigned long offset)
 {
-	struct mem_cgroup *memcg;
-
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
@@ -1063,20 +1111,24 @@ static void zs_uncharge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
 
 	obj_cgroup_uncharge(objcg, size);
 
-	rcu_read_lock();
-	memcg = obj_cgroup_memcg(objcg);
-	mod_memcg_state(memcg, pool->compressed_stat, -size);
-	mod_memcg_state(memcg, pool->uncompressed_stat, -(int)PAGE_SIZE);
-	rcu_read_unlock();
+	__zs_mod_memcg_lruvec(pool, zpdesc, objcg, size, -1, offset);
+
+	/*
+	 * Node-level vmstats are charged in PAGE_SIZE units. As a best-effort,
+	 * always uncharged the uncompressed stats from the first zpdesc.
+	 */
+	dec_node_page_state(zpdesc_page(zpdesc), pool->uncompressed_stat);
 }
 #else
-static void zs_charge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
-			    int size)
+static void zs_charge_objcg(struct zs_pool *pool, struct zpdesc *zpdesc,
+			    struct obj_cgroup *objcg, int size,
+			    unsigned long offset)
 {
 }
 
-static void zs_uncharge_objcg(struct zs_pool *pool, struct obj_cgroup *objcg,
-			      int size)
+static void zs_uncharge_objcg(struct zs_pool *pool, struct zpdesc *zpdesc,
+			      struct obj_cgroup *objcg, int size,
+			      unsigned long offset)
 {
 }
 #endif
@@ -1298,7 +1350,7 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
 		WARN_ON_ONCE(!pool->memcg_aware);
 		zspage->objcgs[obj_idx] = objcg;
 		obj_cgroup_get(objcg);
-		zs_charge_objcg(pool, objcg, class->size);
+		zs_charge_objcg(pool, zpdesc, objcg, class->size, off);
 	}
 
 	if (!ZsHugePage(zspage))
@@ -1477,7 +1529,7 @@ static void obj_free(int class_size, unsigned long obj)
 	if (pool->memcg_aware && zspage->objcgs[f_objidx]) {
 		struct obj_cgroup *objcg = zspage->objcgs[f_objidx];
 
-		zs_uncharge_objcg(pool, objcg, class_size);
+		zs_uncharge_objcg(pool, f_zpdesc, objcg, class_size, f_offset);
 		obj_cgroup_put(objcg);
 		zspage->objcgs[f_objidx] = NULL;
 	}
@@ -2191,8 +2243,8 @@ static int calculate_zspage_chain_size(int class_size)
  * otherwise NULL.
  */
 struct zs_pool *zs_create_pool(const char *name, bool memcg_aware,
-			       enum memcg_stat_item compressed_stat,
-			       enum memcg_stat_item uncompressed_stat)
+			       enum node_stat_item compressed_stat,
+			       enum node_stat_item uncompressed_stat)
 {
 	int i;
 	struct zs_pool *pool;
diff --git a/mm/zswap.c b/mm/zswap.c
index d81e2db4490b..2e9352b46693 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -256,8 +256,7 @@ static struct zswap_pool *zswap_pool_create(char *compressor)
 
 	/* unique name for each pool specifically required by zsmalloc */
 	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
-	pool->zs_pool = zs_create_pool(name, true, MEMCG_ZSWAP_B,
-				       MEMCG_ZSWAPPED_B);
+	pool->zs_pool = zs_create_pool(name, true, NR_ZSWAP_B, NR_ZSWAPPED_B);
 	if (!pool->zs_pool)
 		goto error;
 
@@ -1214,9 +1213,9 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
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
2.52.0


