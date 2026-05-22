Return-Path: <cgroups+bounces-16221-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OgONwbWEGrYeQYAu9opvQ
	(envelope-from <cgroups+bounces-16221-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:17:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 468B55BB125
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4F6E309DBB9
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 22:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDB13939B9;
	Fri, 22 May 2026 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El8uEpT7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F053769E0
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487595; cv=none; b=iW+pQYQV3PbmNkoz7mxWLqDFykWwFP8N9kYN9GuAvIIFz2GXq5dp9oCEti4cv8ITkBcHBZqYD8Yqb2TCf09zzWMy4SbTrB70PKMWiZVof2F158aAFduqqezY1lDtgZNjFHEinpKPUvZ5rwM2vOHULjygg8I89In/1jL1PwhTr1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487595; c=relaxed/simple;
	bh=8I8Xvk6Gz3cosLpmWj+Gb/iKGe7OG5+jYM3K/AvEEYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XM0p24DUnhJbWow5kE4O2ASuE3Sq+Kt5pt45peg0zIHFTOr/e1a2klTqhD1v0DLkw1a6pFLjJP8z09h1iRwhS2IClcJpdyJxH0kjxy1ekBiJUc8C/T+/K6jSUtxSL1efS93t6RLDZpbw6uw8jjdkPkpmVMEZzxFCnJFt26C4wJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El8uEpT7; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479d85152c9so2991255b6e.2
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 15:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779487592; x=1780092392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDRjwcWKT8jzrOHACXaQIaOyyT2TFq8Oufd7POOepxo=;
        b=El8uEpT7wia9wavqpW/Tu5UqRsm0/OJbSOPX/5KzYkpnlvMWozDhzeodhouAA9kvpV
         x7bj5GDYmCi3YJe4PZqHsEEPQjR8l3adacxfDrt0kY8NxNMm0mhaMlWi4claz7oIRxwB
         jtqLxATPkUOqiEYudsLruXglU/lEu8QcDhMqnrg7SBvkoDeky1HV39N7eGJy0RMb3NG/
         DX3PVvfBOkEFQ3fHYmAKp6aKn3pGghvFIuY2Y0fF9pEbWoeRY0Al/WSFvdkkgLkMTpiB
         JFrcUdEm+pMtAKbRpbcs4kztuqU1kLpGrKCYAl+0wCWYDDl3sctFfZz/4cP7yjSW4SmR
         ZW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487592; x=1780092392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RDRjwcWKT8jzrOHACXaQIaOyyT2TFq8Oufd7POOepxo=;
        b=ZQ332udxPJKlyFMPYHq/BZOWEYwPJFxQ6LbtCUwtZJsIsQWVTmVWw668DzOh/e6LV0
         xrTFGOzuRM16JZN/W3d80XnQgSiZXXfzchkFkitaSvjI1ejfRjCnY0jr8i9SglmNUJ3h
         p+IWLZR6jFCe7MPOf+K2Mvs0yc7o/qjg0nZ58hGCoxADamwAnpgHu1y+5qizRS5MRXhD
         IgNZiSpRFa7kLMUG3E3oFvLEqUkZznS7r5fTxsmzfCu8Dd8LHnqYj+3Xq9E+xla1Rl2v
         aBeRJ1C1EvuEfxL4+R0KYGQtAgCW4qYUqQO2YUy2+Z9YcQ9aTxbdGxLGIC4mhBA0moxe
         QnHg==
X-Forwarded-Encrypted: i=1; AFNElJ/IH4OSvj8PSIvs0yGv4oQSFVi6BAuQIIXsVPH59Rplb9uvoqfSdIa7VK+lXoHYZVoPzOmaNJIk@vger.kernel.org
X-Gm-Message-State: AOJu0YyxMVHRixb5PglLeYVJ1I4Di7ayF0VeTfaJkAaCCHgSJum0YUOL
	EdGjKGlFXZo1hakBrr5x6wHPB/79rrmpEuIlk+Xnwhm0O6kySGex9Myc
X-Gm-Gg: Acq92OFEQd8QQlqslLtOi+P8RjpGfACme7Wzr31hC6X5UnMh23kP+H8NcvQe0lZ8ZNz
	z3OVVh13xunmsb3iJsHAQEEwGoUTIV7ti+C+o1YEG1hE3kXEVPdFeQyzuy4c3TG+5/0dvECYEkD
	BPfVfjkYEujXrmAy0Qvrxmb6wAsX1+aZ7QYmsyFQS75WDTTC67ShQpUPreaSoKZLYP+QrtMHuNr
	vNbUL9FB7lSp/67vcWXV0Z+njJujZ21xFKOQB3UIZjL/9764o6fp3YJ7lSu9TrTMPPU2JY2b5Tu
	P/YCvzgYFrP/gr8WNfuYeGl0wmkyTC3ITVzVTfFK2G4Ifvyb9BZ1kg5ohU0Qh8cHnBAWfRReFMj
	LoZOOQx0iqJf8V2NqkYKBmx8wWmafTO+2UktadqQmPgrCck2VlzagcIYu47YaFx6ZWAgZhN4mON
	MMA2T+gBR1T4ypmM/gD62kbNTvDtBtoJkbOdX1SzHagYn8daLqWwfcnA==
X-Received: by 2002:a05:6808:1387:b0:45f:12bc:4579 with SMTP id 5614622812f47-4854a0e93c1mr3205060b6e.19.1779487592420;
        Fri, 22 May 2026 15:06:32 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-485546edd14sm1199998b6e.10.2026.05.22.15.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:06:31 -0700 (PDT)
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
Subject: [PATCH 1/7 v2] mm/page_counter: introduce per-page_counter stock
Date: Fri, 22 May 2026 15:06:19 -0700
Message-ID: <20260522220627.1150804-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
References: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16221-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 468B55BB125
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


