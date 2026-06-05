Return-Path: <cgroups+bounces-16669-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9D4AAprwImoDfgEAu9opvQ
	(envelope-from <cgroups+bounces-16669-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:51:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BF26497DE
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:51:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GWJkQkzH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16669-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16669-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9117B309C5D2
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA1C3D3D16;
	Fri,  5 Jun 2026 15:36:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170603976A0
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:36:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673770; cv=none; b=DtQy5k1WlDkSq3QfVhn2xpwTmN4cgvgJdvWy5nulLQsLbKJnJEnKh/s8/CYz5tFpw8c6aS0WzXOHoo74rwSHm3C998sOk3f/QDfO0uy1boWlUOxh1LPaqH992GSD07dJ1h+JpRFPZ0oBZvwrYofg1f7PsWCws10J+9vO7E/uwDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673770; c=relaxed/simple;
	bh=6nKZOMhL2fHuHg0gYnjNYxhIeU7ReFbDaJLhznUpz1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku6y17D+u/fpuDn1HtP1VKNA29gkLEherjGYC2cHBbOVFZgt84S7TaWneAQCQ7W2djvefCFNXTNtIMOrDehMNuDd2oFdS7tZfTVfZ1CUy1P5/LAw9Ws5W+9uzSIoJjycrqpVCb0941XHASkAqbcH5EY5iHjajCudtIGXwhDwcE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWJkQkzH; arc=none smtp.client-ip=209.85.161.51
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69d7aa0ac18so1515076eaf.0
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673766; x=1781278566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lh7157a6UldulsYLa+rcYTJC4JAQaUR5k2UCa7NfvOc=;
        b=GWJkQkzH8qGa3tNsLVFPTYWXz/3ec5vbaZe1b6L/nW4/G1Uk9rg1/tLbYPF4YGvKOy
         dgxik5Vy9ZXq7+yyr131d5NmSavhE6n6uTbxQnZ51b6jR9vf7GRuEzb3aB/Lt3V8ht86
         nENNqEeGfEZVLzaLzgiVjNkOvLYB4RpDliZ58IERFAaRIcHKmrLeAAuqyQB5T4itt+mf
         +4i3x4lJtH/WJ+vXrlL4xVEYMQQYokSN5uGwwB1UN3Q1jlBCB9d3C+CIq5BJojwaXD5t
         JRZqHDaAqM+cQJ5UYvuP33oaw5n+UKU9oeL+ynoEIzcKJjL3v8HWw5FRaWcjyUq33jie
         a88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673766; x=1781278566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lh7157a6UldulsYLa+rcYTJC4JAQaUR5k2UCa7NfvOc=;
        b=BCzX8MpNBo2gluQBduveqVFeMVaXIPLhEtzSWlYxn26sMTUUrepcqhuXaw7liA/XnG
         3sliSkjdNEJVJ8s3EtOTZhoYjagQubcJzH6ZsfVMYlr78aK9my0gXc6tKTXa5o7kGHZJ
         PNMOFg/FPdB+1zXt4nyxz6uy3QeOJ/qOrTgxgNjmlmrA1I3PW3qQ6r/iUfdpg0GN2bsF
         waJNe5xMKuvsOMSKPEzUtiwzLJFQtRbvoaESyXqLcxucvw2c0ewqCbSWwvsX9U0IIr9R
         WRnzLlhQtMOX+0s39/RhqRJOjxRiH+tyAFsw5tyBG3+0Wn/ujnLKQjE8kO+e6ztLxBIT
         xoCA==
X-Forwarded-Encrypted: i=1; AFNElJ/ULWdbRNS6XGoP4sfRFse4F7yyC8V8zksD32NiqBATAGSNFhu7OP6oJNcWF9S4ZSyEmt74Y04p@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqi9py4VDSVGHl0ThdNJOVW1uNTL5TvdNpAM6WNIXEax9+91gY
	PcToe4oixMXb2nKPcpaCZmklcpAPTjhddIqt0MksqwxPj3y1nDhcJD/k
X-Gm-Gg: Acq92OE1E07PYH0O+qHg2q0gD+NtvCppOuPDHkkd8Lw415KbWC6pHPeAsiAdpIs8fyU
	G+7CyggeD6zxOiBrCXo7e1wOTVhiuLGS4it0Wc8hbS5ekC9KvhTJRRH9Bv5zGac3fLYkQv8T/1R
	TmXMRLdFXMHQoKJ9aCNdbGW+FCRyy4t8xQEwiHJt/aK1XW8RGuH5j9vnWSkMKj/ie1a0+trJFKc
	ciSoI2lXqp5fqF0n+r5qLep7dtB6F4/AuK+tdWYS6dGxqDQgjjKztGNXpSuQPZkJhbGHxsz+BjF
	innnk4dRoVp+cuB6RxzfhEM+FBc6cbDcV6HSB9C1x7+wCy6TMeoefNui5HRFZ6CjRy9BElJhiLO
	rh0QNACjTXoY9y/NFGY9X2UXOMyTIrNith7q3Qm+p89R0p0SPzWRhfQ4t9X3vr1hgEoGtuV8Mse
	4M2SSJLKPj505pI2T3JvU4ilAKFzjvPFOIqRSq+nWaU1WtqAOc8TDoSBvW7zZJoQc=
X-Received: by 2002:a05:6820:818a:b0:69e:59af:ec9d with SMTP id 006d021491bc7-69e68c089eamr2288542eaf.31.1780673765870;
        Fri, 05 Jun 2026 08:36:05 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:b::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm5180102eaf.9.2026.06.05.08.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:36:05 -0700 (PDT)
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
Subject: [PATCH 1/6 v3] mm/page_counter: introduce per-page_counter stock
Date: Fri,  5 Jun 2026 08:35:57 -0700
Message-ID: <20260605153603.234296-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
References: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16669-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46BF26497DE

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
alloc/disable/free functions, but does not use these yet.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h | 13 +++++++++
 mm/page_counter.c            | 53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index d649b6bbbc871..c92bb2ee2a581 100644
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
 
+int page_counter_alloc_stock(struct page_counter *counter, unsigned int batch);
+void page_counter_disable_stock(struct page_counter *counter);
+void page_counter_free_stock(struct page_counter *counter);
+
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 661e0f2a5127a..9f3e3f8d896c4 100644
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
@@ -289,6 +290,58 @@ int page_counter_memparse(const char *buf, const char *max,
 	return 0;
 }
 
+int page_counter_alloc_stock(struct page_counter *counter, unsigned int batch)
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
+void page_counter_disable_stock(struct page_counter *counter)
+{
+	if (!counter->stock)
+		return;
+
+	/* This prevents future charges from trying to deposit pages */
+	WRITE_ONCE(counter->batch, 0);
+}
+
+void page_counter_free_stock(struct page_counter *counter)
+{
+	unsigned long stock_to_drain = 0;
+	int cpu;
+
+	if (!counter->stock)
+		return;
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
+
+	free_percpu(counter->stock);
+	counter->stock = NULL;
+}
+
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 /*
-- 
2.53.0-Meta


