Return-Path: <cgroups+bounces-16253-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDFsGWSdFGqpOwcAu9opvQ
	(envelope-from <cgroups+bounces-16253-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:05:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 009FA5CDE5F
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 751FF3009094
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C920B38B7D4;
	Mon, 25 May 2026 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWCIwxcZ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11468386552
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735902; cv=none; b=tkOGTs+xqfrHxE6yulLERKu44KPDk4nyyDK6De5J2xoyCy6JTNXOkhgXnigiWReOD3Y0+FxiKzNA3MrXWgANdNsL9Hc8lxSGiF6RgOBPJKv5u30A/XwbMN2nB7OFsiBPpSjRSJursaTfZr7pLoJGgP4E7mciyXQaUQ94tZ57b0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735902; c=relaxed/simple;
	bh=8I8Xvk6Gz3cosLpmWj+Gb/iKGe7OG5+jYM3K/AvEEYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcaHR6Z4qpUZEndjpZDXnJsNwSxB1ZMxREQbknqBMXOCocJYh30RGlzCc2HwCvkfUHvAJRfxNtF/vc7Tan8v6oAGYigDVH24QmoCAHUvLy/pSsYm6CNp4t8A2xZP0pYBbu7IWv/NYfz2I7h10btaxyyL8oa5JVISISdcWZf2vfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWCIwxcZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-485433a6889so1114601b6e.0
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735900; x=1780340700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDRjwcWKT8jzrOHACXaQIaOyyT2TFq8Oufd7POOepxo=;
        b=RWCIwxcZPp9uH343qWVtGo5os0Wp4MVVM1iL6qhFkCXtYN5Sr70d9GF1wQJCrdp07S
         CPVBIXJPMceD4DTeUHgqqK/Ys1VtCEEuFyT+VnXSjrxdCX3BF7afxFagisCOsOjyjGOS
         MuRDZ9Eo+ObCpe4FlENwkcPid6+gc+OKPHPbHPkOckwXZVn9GtKlLUZeXgtY1b+bN6ZM
         B366AusD53PKsp37cK/KkpNGtr0Qg/bGpVifVy6nSAp28dVUwFvnJe67TKIWCnf5eMt1
         35kNNXivXGOhZ8Fk9xcyxhY1M34Wzx61kLbEB/ZvlsT5q50gJwtWddN+bd+Wm8a6WLRc
         UxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735900; x=1780340700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDRjwcWKT8jzrOHACXaQIaOyyT2TFq8Oufd7POOepxo=;
        b=Rc2ylOtl+KA9My7rJP0egVzquFzEv+MQBwlnpDp7Jan70L++vPjjOJ4Rh087pHI4EF
         vKN5CdHkqQAhNNfuBn+5dvkxHITlLqJK8R1l/I0adb3cm956Jk6YZa0UOs7BECW4/3lP
         x1Tf81OUMS0+23BK2HUMYPE/2+m3sIMprZR89AvPGaa4gSlnc1CqAHQn26GhVv7CBxU0
         rIBbnQiRaoc1azWLovpt4EkSgKg19baSDpemCZggI2LGkYQ6EJmNjExwflOYjuuM/xqd
         J+8xZZvaZJpuU+zt1L6gJaWmFpyjS6+KQrhXLL5xiYoiTIZIS953A+OjvgI53MaoHu6c
         tEWg==
X-Forwarded-Encrypted: i=1; AFNElJ/FisKUk7auVGBeasw9bafGMtJlfnlc01KZRJYdgw7a+XJAi/4OgdDNiYk/Xzw5PrYSnng0usX1@vger.kernel.org
X-Gm-Message-State: AOJu0YwojFBEukObkgUZJOdArIuSNtJfEAQf9QBT6u+A1i0LZnHWOy6h
	Kj7GiMr/w0UZ6cIKQ+5xgOdL1qMs8MPuYMfRZ/9o00WpgJrZ9t+KIy95
X-Gm-Gg: Acq92OGE+RwI3pb+wJbf5xoPMHuXFd90UkWW/ZAupRvRtzwhD+YYvC+i8PEZmmsxFh4
	c+bxy7+46u/Q3Vjl5nrDtW+IVBLffvJTH2Y9yUYAw2hoWOpxla6fahBTmS0is3oMM6XbT1SEMnq
	c5JDKksskTEixOQArXpWOcQ70F/Zr8HCYl1C32o7KeaCzHY2fHnwA/c7pWcikZrQ19wDYg4CMfE
	6vKSxjfE2b9OJpfJFjRdORk1nJWySAZG0IqZ4DhvPVrZxo7aIYy0tWMBxZKAw50Cs6oHnYHgYwh
	QwgcuggoS9XycqAxhUS3FIYbekk9CJw689VVvGTsnwEckDXVWltDnvgNwziwhpKquFXZIF0ESme
	SSiaiZA3D7HLopokT7JW2LJy0GyXL57OLEpnb/fyJcN5Bbtj6EnTtWxxBEtKgoI+9gGvzvN9nZu
	UsAq7LFOvUqp1V8RHf9Xh5QE//CzcuMgQrlJUw/M36dRu2SnxAu9He7g==
X-Received: by 2002:a05:6808:1455:b0:485:1173:f62a with SMTP id 5614622812f47-48549d8fb9fmr8720464b6e.1.1779735899959;
        Mon, 25 May 2026 12:04:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:56::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485545070easm5050032b6e.7.2026.05.25.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:04:58 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 1/7 v3] mm/page_counter: introduce per-page_counter stock
Date: Mon, 25 May 2026 12:04:48 -0700
Message-ID: <20260525190455.2843786-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
References: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16253-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 009FA5CDE5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to avoid expensive hierarchy walks on every memcg charge and
limit check, memcontrol uses per-cpu stocks (memcg_stock_pcp) to cache
pre-charged pages and introduce a fast path to try_charge_memcg.

However, there are a few quirks with the current implementation that
could be improved upon.

First, each memcg_stock_pcp can only cache the charges of 7 memcgs
(defined as NR_MEMCG_STOCK), which means that once a CPU starts handling
the charging of more than 7 memcgs, it randomly selects a victim memcg
to evict and drain from the cpu, which can cause unnecessarily increased
latencies and thrashing as memcgs continually evict each others' stock.

Second, stock is tightly coupled with memcg, which means that all page
counters in a memcg share the same resource. This may simplify some of
the charging logic, but it prevents new page counters from being added
and using a separate stock.

We can address these concerns by pushing the concept of stock down to
the page_counter level, which addresses the random eviction problem by
getting rid of the 7 slot limit, and makes enabling separate stock
caches for other page_counters simpler.

Introduce a generic per-cpu stock directly in struct page_counter.
Stock can optionally be enabled per-page_counter, limiting the overhead
increase for page_counters who do not benefit greatly from caching
charges.

This patch introduces the page_counter_stock struct and its
enable/disable/free functions, but does not use these yet.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h | 13 ++++++++
 mm/page_counter.c            | 64 ++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index d649b6bbbc871..c7e3ab3356d20 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -5,8 +5,15 @@
 #include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/limits.h>
+#include <linux/local_lock.h>
+#include <linux/percpu.h>
 #include <asm/page.h>
 
+struct page_counter_stock {
+	local_trylock_t lock;
+	unsigned long nr_pages;
+};
+
 struct page_counter {
 	/*
 	 * Make sure 'usage' does not share cacheline with any other field in
@@ -41,6 +48,8 @@ struct page_counter {
 	unsigned long high;
 	unsigned long max;
 	struct page_counter *parent;
+	struct page_counter_stock __percpu *stock;
+	unsigned int batch;
 } ____cacheline_internodealigned_in_smp;
 
 #if BITS_PER_LONG == 32
@@ -99,6 +108,10 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 	counter->watermark = usage;
 }
 
+int page_counter_enable_stock(struct page_counter *counter, unsigned int batch);
+void page_counter_disable_stock(struct page_counter *counter);
+void page_counter_free_stock(struct page_counter *counter);
+
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 661e0f2a5127a..a1a871a9d5c49 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -8,6 +8,7 @@
 #include <linux/page_counter.h>
 #include <linux/atomic.h>
 #include <linux/kernel.h>
+#include <linux/percpu.h>
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/bug.h>
@@ -289,6 +290,69 @@ int page_counter_memparse(const char *buf, const char *max,
 	return 0;
 }
 
+int page_counter_enable_stock(struct page_counter *counter, unsigned int batch)
+{
+	struct page_counter_stock __percpu *stock;
+	int cpu;
+
+	stock = alloc_percpu(struct page_counter_stock);
+	if (!stock)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		struct page_counter_stock *s = per_cpu_ptr(stock, cpu);
+
+		local_trylock_init(&s->lock);
+	}
+	counter->stock = stock;
+	counter->batch = batch;
+
+	return 0;
+}
+
+static void page_counter_drain_stock_nolock(struct page_counter *counter)
+{
+	unsigned long stock_to_drain = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct page_counter_stock *stock;
+
+		stock = per_cpu_ptr(counter->stock, cpu);
+		stock_to_drain += stock->nr_pages;
+		stock->nr_pages = 0;
+	}
+
+	if (stock_to_drain)
+		page_counter_uncharge(counter, stock_to_drain);
+}
+
+void page_counter_disable_stock(struct page_counter *counter)
+{
+	if (!counter->stock)
+		return;
+
+	/* This prevents future charges from trying to deposit pages */
+	WRITE_ONCE(counter->batch, 0);
+
+	/*
+	 * Charges can still be in-flight at this time. Instead of locking here,
+	 * do the majority of the drains here without locking to free up pages
+	 * now. Any remaining stock will be drained in page_counter_free_stock.
+	 */
+	page_counter_drain_stock_nolock(counter);
+}
+
+void page_counter_free_stock(struct page_counter *counter)
+{
+	if (!counter->stock)
+		return;
+
+	page_counter_drain_stock_nolock(counter);
+	free_percpu(counter->stock);
+	counter->stock = NULL;
+}
+
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 /*
-- 
2.53.0-Meta


