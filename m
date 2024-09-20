Return-Path: <cgroups+bounces-4921-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9748497DA82
	for <lists+cgroups@lfdr.de>; Sat, 21 Sep 2024 00:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE7C1C2110D
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13E187322;
	Fri, 20 Sep 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="bNGw7+5x"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F1183CD2
	for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726870372; cv=none; b=Au2+TsgqfdwuviY646WeGDgqu/a6zWQBqS8Qo2oPj9SCEI9WO38eJhdq/2ZGz1H384PnHC8ciDqVKV+VXw8m12RXT36YmDMixQutzKkcsagZrYqavpPOOlLklDTehxC1NWtW3lbuho2g1oM+YrWvYRgCzRqHcj2v4LOEZi5A19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726870372; c=relaxed/simple;
	bh=6jbmJ8ln3pbuOH120KnP187bsQCpicLJ5UQqThsUtbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtilB7IhzyRYfz8EspsTlA6p31Ri3yfCSJIAT1nCeGCua7G7dPl8M5CMGAdfqnHEvRk06ESorPgW9UdpvJFnJSutCrfEbPqaBBvwweBCAt8MftxCt1AhJE8mt0OCdGRGEGY4ipDPTTgh1b87BI/QV1OZvKLxU+M90S2rUZzLPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=bNGw7+5x; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c34dd6c21aso15934686d6.2
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 15:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1726870368; x=1727475168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uf3jgwkumzU+UPaFgIeEZ3O7SSYAkqNrO+ZAvwxaUDo=;
        b=bNGw7+5xuwmNBf9tDIjiYVQ2g56uJ2yLwbwSYEdqMBb/CNg9xl64be+AkspziIjBqv
         1hA4fgQ2LoD+H/yNm50deL/y703/8DIjuabTpIYb7V2fJvFl9R+zPccNWAWHJ3nv9h8g
         pHgU1dO69IZ0xGFiwptBhNRCL/aXwwB6mDOO9os1+S2s7Hb4NQ/A/aHRHPGkaxFa0NcO
         +8ZjtmSO/WASEtRhMTWGfrfZVBxiujXYRHSQaJ6GtEXQtBB/7DPPM71NoVkdbctNXK6p
         KfFEtv3dxp0809ZBGto49ZINx65zC2hYa/B4DF2PNtt5JGWy0LDHtmqrdEMtcA4jIR1G
         iiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726870368; x=1727475168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uf3jgwkumzU+UPaFgIeEZ3O7SSYAkqNrO+ZAvwxaUDo=;
        b=b8qJrAFP5qLXBe5joDpjpiHiH0exa34E/p+pJKD+bXKdeNoxIrCwUVKAH+pe4d4yLZ
         2DiJxj4NPynEMCR9KXDk148LeN1SbCb7l3RkK7YwP2lzDP7DiL3JxCVQ9bU9fVWG45xH
         /HZvAjqnO2zUaEbqY2O2+Ng66AjYa+tUHhPKI8JmeBxU5Vq6HmPNAXaScB69XjTtxI8b
         MaA0EPrgxm4gDs7og1T0M6ApqeLHok8ilCEmo1zCRC8Wr2J76+PLBZTjHSREHXm2aiSY
         IoW3oU42PqX+RgNaZ2gxKpHR1kmjbXeS26+Ya5gW4h9LNMlcdjekIKmaVOx+qCNNZnqC
         m8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVWRVY3NXjKAKfaFSMltAR96LW63pkhS2P6BnrrPsdTXJ1iAzziLQ4d7cnZTRZwO7gxxfhYT9Qz@vger.kernel.org
X-Gm-Message-State: AOJu0YxTeI8lzoYIWa91/Uxx8DSG1osxRG7+WDBrOpl/yuyD5uD9/Kr/
	gWBsVxdqnUXVKTV2sBA9f92SJYi36qOJ5pOp/r36KWC0MBW+djTPiUuUbM2oDw==
X-Google-Smtp-Source: AGHT+IEyE6YRvGHqfK+QKR9XTMQex28jIRLr/J4ytHxbuqKZ8XfKVCXNbZWUk9cnyNyCrbUZvhYABQ==
X-Received: by 2002:a05:6214:5781:b0:6c3:5496:3e06 with SMTP id 6a1803df08f44-6c7bc6a4c39mr80018546d6.10.1726870367936;
        Fri, 20 Sep 2024 15:12:47 -0700 (PDT)
Received: from localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6c75e57a4acsm23134796d6.116.2024.09.20.15.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 15:12:47 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	hannes@cmpxchg.org,
	weixugc@google.com,
	rientjes@google.com,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Subject: [RFC PATCH 2/4] calculate memory.low for the local node and track its usage
Date: Fri, 20 Sep 2024 22:11:49 +0000
Message-ID: <20240920221202.1734227-3-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
References: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Add a memory.low for the top-tier node (locallow) and track its usage.
locallow is set by scaling low by the ratio of node 0 capacity and
node 0 + node 1 capacity.

Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
---
 include/linux/page_counter.h | 16 ++++++++---
 mm/hugetlb_cgroup.c          |  4 +--
 mm/memcontrol.c              | 42 ++++++++++++++++++++++-------
 mm/page_counter.c            | 52 ++++++++++++++++++++++++++++--------
 4 files changed, 88 insertions(+), 26 deletions(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 79dbd8bc35a7..aa56c93415ef 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -13,6 +13,7 @@ struct page_counter {
 	 * memcg->memory.usage is a hot member of struct mem_cgroup.
 	 */
 	atomic_long_t usage;
+	struct mem_cgroup *memcg; /* memcg that owns this counter */
 	CACHELINE_PADDING(_pad1_);
 
 	/* effective memory.min and memory.min usage tracking */
@@ -25,6 +26,10 @@ struct page_counter {
 	atomic_long_t low_usage;
 	atomic_long_t children_low_usage;
 
+	unsigned long elocallow;
+	atomic_long_t locallow_usage;
+	atomic_long_t children_locallow_usage;
+
 	unsigned long watermark;
 	/* Latest cg2 reset watermark */
 	unsigned long local_watermark;
@@ -36,6 +41,7 @@ struct page_counter {
 	bool protection_support;
 	unsigned long min;
 	unsigned long low;
+	unsigned long locallow;
 	unsigned long high;
 	unsigned long max;
 	struct page_counter *parent;
@@ -52,12 +58,13 @@ struct page_counter {
  */
 static inline void page_counter_init(struct page_counter *counter,
 				     struct page_counter *parent,
-				     bool protection_support)
+				     bool protection_support, struct mem_cgroup *memcg)
 {
 	counter->usage = (atomic_long_t)ATOMIC_LONG_INIT(0);
 	counter->max = PAGE_COUNTER_MAX;
 	counter->parent = parent;
 	counter->protection_support = protection_support;
+	counter->memcg = memcg;
 }
 
 static inline unsigned long page_counter_read(struct page_counter *counter)
@@ -72,7 +79,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 			     struct page_counter **fail);
 void page_counter_uncharge(struct page_counter *counter, unsigned long nr_pages);
 void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages);
-void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages);
+void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages,
+					unsigned long nr_pages_local);
 
 static inline void page_counter_set_high(struct page_counter *counter,
 					 unsigned long nr_pages)
@@ -99,11 +107,11 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 #ifdef CONFIG_MEMCG
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
-				       bool recursive_protection);
+				       bool recursive_protection, int is_local);
 #else
 static inline void page_counter_calculate_protection(struct page_counter *root,
 						     struct page_counter *counter,
-						     bool recursive_protection) {}
+						     bool recursive_protection, int is_local) {}
 #endif
 
 #endif /* _LINUX_PAGE_COUNTER_H */
diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index d8d0e665caed..0e07a7a1d5b8 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -114,10 +114,10 @@ static void hugetlb_cgroup_init(struct hugetlb_cgroup *h_cgroup,
 		}
 		page_counter_init(hugetlb_cgroup_counter_from_cgroup(h_cgroup,
 								     idx),
-				  fault_parent, false);
+				  fault_parent, false, NULL);
 		page_counter_init(
 			hugetlb_cgroup_counter_from_cgroup_rsvd(h_cgroup, idx),
-			rsvd_parent, false);
+			rsvd_parent, false, NULL);
 
 		limit = round_down(PAGE_COUNTER_MAX,
 				   pages_per_huge_page(&hstates[idx]));
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 20b715441332..d7c5fff12105 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1497,6 +1497,9 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 			       vm_event_name(memcg_vm_event_stat[i]),
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
+
+	seq_buf_printf(s, "local_usage %lu\n",
+		       get_cgroup_local_usage(memcg, true));
 }
 
 static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
@@ -3597,8 +3600,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
 
-		page_counter_init(&memcg->memory, &parent->memory, true);
-		page_counter_init(&memcg->swap, &parent->swap, false);
+		page_counter_init(&memcg->memory, &parent->memory, true, memcg);
+		page_counter_init(&memcg->swap, &parent->swap, false, NULL);
 #ifdef CONFIG_MEMCG_V1
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
 		page_counter_init(&memcg->kmem, &parent->kmem, false);
@@ -3607,8 +3610,8 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	} else {
 		init_memcg_stats();
 		init_memcg_events();
-		page_counter_init(&memcg->memory, NULL, true);
-		page_counter_init(&memcg->swap, NULL, false);
+		page_counter_init(&memcg->memory, NULL, true, memcg);
+		page_counter_init(&memcg->swap, NULL, false, NULL);
 #ifdef CONFIG_MEMCG_V1
 		page_counter_init(&memcg->kmem, NULL, false);
 		page_counter_init(&memcg->tcpmem, NULL, false);
@@ -3677,7 +3680,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	memcg1_css_offline(memcg);
 
 	page_counter_set_min(&memcg->memory, 0);
-	page_counter_set_low(&memcg->memory, 0);
+	page_counter_set_low(&memcg->memory, 0, 0);
 
 	zswap_memcg_offline_cleanup(memcg);
 
@@ -3748,7 +3751,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
 #endif
 	page_counter_set_min(&memcg->memory, 0);
-	page_counter_set_low(&memcg->memory, 0);
+	page_counter_set_low(&memcg->memory, 0, 0);
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
 	memcg1_soft_limit_reset(memcg);
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
@@ -4051,6 +4054,12 @@ static ssize_t memory_min_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static int memory_locallow_show(struct seq_file *m, void *v)
+{
+	return seq_puts_memcg_tunable(m,
+		READ_ONCE(mem_cgroup_from_seq(m)->memory.locallow));
+}
+
 static int memory_low_show(struct seq_file *m, void *v)
 {
 	return seq_puts_memcg_tunable(m,
@@ -4061,7 +4070,8 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 				char *buf, size_t nbytes, loff_t off)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
-	unsigned long low;
+	struct sysinfo si;
+	unsigned long low, locallow, local_capacity, total_capacity;
 	int err;
 
 	buf = strstrip(buf);
@@ -4069,7 +4079,15 @@ static ssize_t memory_low_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
-	page_counter_set_low(&memcg->memory, low);
+	/* Hardcoded 0 for local node and 1 for remote. */
+	si_meminfo_node(&si, 0);
+	local_capacity = si.totalram; /* In pages. */
+	total_capacity = local_capacity;
+	si_meminfo_node(&si, 1);
+	total_capacity += si.totalram;
+	locallow = low * local_capacity / total_capacity;
+
+	page_counter_set_low(&memcg->memory, low, locallow);
 
 	return nbytes;
 }
@@ -4394,6 +4412,11 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_low_show,
 		.write = memory_low_write,
 	},
+	{
+		.name = "locallow",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_locallow_show,
+	},
 	{
 		.name = "high",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -4483,7 +4506,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 	if (!root)
 		root = root_mem_cgroup;
 
-	page_counter_calculate_protection(&root->memory, &memcg->memory, recursive_protection);
+	page_counter_calculate_protection(&root->memory, &memcg->memory,
+					recursive_protection, false);
 }
 
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index b249d15af9dd..97205aafab46 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -18,8 +18,10 @@ static bool track_protection(struct page_counter *c)
 	return c->protection_support;
 }
 
+extern unsigned long get_cgroup_local_usage(struct mem_cgroup *memcg, bool flush);
+
 static void propagate_protected_usage(struct page_counter *c,
-				      unsigned long usage)
+				      unsigned long usage, unsigned long local_usage)
 {
 	unsigned long protected, old_protected;
 	long delta;
@@ -44,6 +46,15 @@ static void propagate_protected_usage(struct page_counter *c,
 		if (delta)
 			atomic_long_add(delta, &c->parent->children_low_usage);
 	}
+
+	protected = min(local_usage, READ_ONCE(c->locallow));
+	old_protected = atomic_long_read(&c->locallow_usage);
+	if (protected != old_protected) {
+		old_protected = atomic_long_xchg(&c->locallow_usage, protected);
+		delta = protected - old_protected;
+		if (delta)
+			atomic_long_add(delta, &c->parent->children_locallow_usage);
+	}
 }
 
 /**
@@ -63,7 +74,8 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
 		atomic_long_set(&counter->usage, new);
 	}
 	if (track_protection(counter))
-		propagate_protected_usage(counter, new);
+		propagate_protected_usage(counter, new,
+				get_cgroup_local_usage(counter->memcg, false));
 }
 
 /**
@@ -83,7 +95,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 
 		new = atomic_long_add_return(nr_pages, &c->usage);
 		if (protection)
-			propagate_protected_usage(c, new);
+			propagate_protected_usage(c, new,
+					get_cgroup_local_usage(counter->memcg, false));
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
@@ -151,7 +164,8 @@ bool page_counter_try_charge(struct page_counter *counter,
 			goto failed;
 		}
 		if (protection)
-			propagate_protected_usage(c, new);
+			propagate_protected_usage(c, new,
+					get_cgroup_local_usage(counter->memcg, false));
 
 		/* see comment on page_counter_charge */
 		if (new > READ_ONCE(c->local_watermark)) {
@@ -238,7 +252,8 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
 	WRITE_ONCE(counter->min, nr_pages);
 
 	for (c = counter; c; c = c->parent)
-		propagate_protected_usage(c, atomic_long_read(&c->usage));
+		propagate_protected_usage(c, atomic_long_read(&c->usage),
+				get_cgroup_local_usage(counter->memcg, false));
 }
 
 /**
@@ -248,14 +263,17 @@ void page_counter_set_min(struct page_counter *counter, unsigned long nr_pages)
  *
  * The caller must serialize invocations on the same counter.
  */
-void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages)
+void page_counter_set_low(struct page_counter *counter, unsigned long nr_pages,
+				unsigned long nr_pages_local)
 {
 	struct page_counter *c;
 
 	WRITE_ONCE(counter->low, nr_pages);
+	WRITE_ONCE(counter->locallow, nr_pages_local);
 
 	for (c = counter; c; c = c->parent)
-		propagate_protected_usage(c, atomic_long_read(&c->usage));
+		propagate_protected_usage(c, atomic_long_read(&c->usage),
+				get_cgroup_local_usage(counter->memcg, false));
 }
 
 /**
@@ -421,9 +439,9 @@ static unsigned long effective_protection(unsigned long usage,
  */
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
-				       bool recursive_protection)
+				       bool recursive_protection, int is_local)
 {
-	unsigned long usage, parent_usage;
+	unsigned long usage, parent_usage, local_usage, parent_local_usage;
 	struct page_counter *parent = counter->parent;
 
 	/*
@@ -437,16 +455,19 @@ void page_counter_calculate_protection(struct page_counter *root,
 		return;
 
 	usage = page_counter_read(counter);
-	if (!usage)
+	local_usage = get_cgroup_local_usage(counter->memcg, true);
+	if (!usage || !local_usage)
 		return;
 
 	if (parent == root) {
 		counter->emin = READ_ONCE(counter->min);
 		counter->elow = READ_ONCE(counter->low);
+		counter->elocallow = READ_ONCE(counter->locallow);
 		return;
 	}
 
 	parent_usage = page_counter_read(parent);
+	parent_local_usage = get_cgroup_local_usage(parent->memcg, true);
 
 	WRITE_ONCE(counter->emin, effective_protection(usage, parent_usage,
 			READ_ONCE(counter->min),
@@ -454,7 +475,16 @@ void page_counter_calculate_protection(struct page_counter *root,
 			atomic_long_read(&parent->children_min_usage),
 			recursive_protection));
 
-	WRITE_ONCE(counter->elow, effective_protection(usage, parent_usage,
+	if (is_local)
+		WRITE_ONCE(counter->elocallow,
+			effective_protection(local_usage, parent_local_usage,
+			READ_ONCE(counter->locallow),
+			READ_ONCE(parent->elocallow),
+			atomic_long_read(&parent->children_locallow_usage),
+			recursive_protection));
+	else
+		WRITE_ONCE(counter->elow,
+			effective_protection(usage, parent_usage,
 			READ_ONCE(counter->low),
 			READ_ONCE(parent->elow),
 			atomic_long_read(&parent->children_low_usage),
-- 
2.43.0


