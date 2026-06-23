Return-Path: <cgroups+bounces-17191-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ks1qGXvKOmpWHAgAu9opvQ
	(envelope-from <cgroups+bounces-17191-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:03:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BFE6B959F
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:03:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="UNx4ZiN/";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17191-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17191-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0B5A3075C11
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B8D39182A;
	Tue, 23 Jun 2026 18:01:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA181390985
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 18:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237690; cv=none; b=qRyidCUiq3V58U0benQbwHq5dxtgMtqupKyyB/8Q5LKSeq4dtcEbksrW28JU0jGXG5s2PNeDM889cHgJoyU/dfNRWLIP3opLCxks6FQLLARv5kzIqlEnwCe/UY1tJfRPjdVCiHPGvWIbKPGNxTRQQs1S6d4/v3Ka9HSAbDNssyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237690; c=relaxed/simple;
	bh=d7A2Gq1LtU7ifMVPOKCxfHCkXsavNrFdB11YUUoBGY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGFFgkMz7TkGkAwwYZQ4m/0+IGG02pew5ou7SrtqQH1WpIhCFb7hYbDF0NW3u3i185HMzczbb6z5dp51Hz+H6mcS6YL/tF7YGlSVk8sswfaRXrq/Tda896S9KHk/9t2D0zc0T+biUVV7YAlXCtjsfft/WzG5W6MgLwoSYpevbYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNx4ZiN/; arc=none smtp.client-ip=209.85.210.46
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9483cd614so123202a34.1
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237688; x=1782842488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pzU1DE9THaq3wZw8gndmiVL6XdA2w7BeQ82VsVhXVw=;
        b=UNx4ZiN/7QHK7ZgsyVgIvlcNwNEiDzvTP5Jw0a9FUmfiIGh/ZvEw2pqUQJj9m0lAza
         CYajlum2lxGNBMPNd95NmPXhNi8/pPvgyheBGOJDnZ7hJZ6fH2NI4E85csb25FRdOXZt
         du7NweiSJeP8zOw41iWOXfRosdVXQzGJxykEaYOtifSqSFEFxoZ/thNaGDdW+1R3CZWZ
         Ye9ZP984NxpHUaTovVTFQDMbakDUmOfoj29XiiHFm65FA7JWq2B6QpO3kB1JMBvuQb6p
         HFPjizf9CmfDu4OAy7ZDiD+8FbsX/XSB/bGl0pYKXIZbn5WU+y2uQY+VHbpClT/D2tCs
         iNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237688; x=1782842488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7pzU1DE9THaq3wZw8gndmiVL6XdA2w7BeQ82VsVhXVw=;
        b=Q7uOC67l4aJpRADmZH+9mhlE8R//ATEIAdh4fSkjkyW31oIN6XYC9o+Wa9zwHRiseX
         L7ED6NXt1lYzKHOZsn7hBhoXCA4h2adVvq9vhkT/V1BeEFzMh7He+8OxW/fBHF9OpjIA
         Pi+EOtP3WY02G0TPqyPBsQhcgVGLEk70FdbZo/h/prwJT+SvvrS37nXKmDS6obo2D9NN
         Uj2IVG001FDsBzPar9yvDN4Ow13oLVJBUD92ogJA+1RxdOuyUCcT+2yTldci8NVGiuch
         7+hTNWISlngpJWorq+7SdFvpEJG8jx4hnX5Oc+csOO11hDPjzj8I863rAkVm1M/tLx1u
         bNTw==
X-Forwarded-Encrypted: i=1; AFNElJ8sNyuz4HcW7Nm9uVnPAGhyfhwPBdq1xhi0d2PPTIMQ2NBE5Qr4pYKuTczfwsZ+sHta2lQXOGC/@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ2aYZYEhDmyKEJZwx543XaMUarmd/Zy8/7tutXBvmVOE0qxBu
	UzSBpDFso8+avSzdlhg45RsL8l92A7kjrIgpWhdIe2hcKdrGSYbgN6GJ
X-Gm-Gg: AfdE7cn/GIybVU7Mu8GIYSNkoxifKcTogJtbibTunRa/Moohx2DRVqAjqu7YXYm5mAC
	JdiXs3p9JO6Y/LLpvx5GXxFRcmJ72wQYqud2TaVXfBWED5pzgItJYDsIq4gWlvVjlS3yG4pRptf
	WmFA5pn1ZezA00IbthdDyCHfQPdurZbZdXCmHaAhQlaiob5l4w36Ma+zirBpFCxE/7soIYR9+Dd
	+nHLEe2NOxYZF84y7NUr218LqbdAK5dD7YF526Cc/yHIKNv+oh8qw2hT4nLjuEPE3sJSAiv6nPo
	fUHOy9rBatLtsRHcisvjpXfq9HUJ25Eb5HqjMFBm/2OX+eLAhh+zcy93pw6IcTdxvQFc+R0/uSV
	2C0zu3VEzcTFoAeSd7A/YcQ7z2cqk83s+YeYVn2lIBvR/sVXEISjDrpRvbq7jVOfOjyLwGoJYJs
	WeNrPmaBCGHL4P2nR0BgAle8V2ealLJgUuXjMpixfT3Nc=
X-Received: by 2002:a05:6830:378b:b0:7dc:a51c:9197 with SMTP id 46e09a7af769-7e9740b24efmr2719111a34.7.1782237687708;
        Tue, 23 Jun 2026 11:01:27 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:51::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e943d5dc07sm10116277a34.0.2026.06.23.11.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:01:27 -0700 (PDT)
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
Subject: [PATCH v4 1/5] mm/page_counter: introduce per-page_counter stock
Date: Tue, 23 Jun 2026 11:01:19 -0700
Message-ID: <20260623180124.868655-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623180124.868655-1-joshua.hahnjy@gmail.com>
References: <20260623180124.868655-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17191-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0BFE6B959F

In order to avoid expensive hierarchy walks on every memcg charge and
limit check, memcontrol uses per-cpu stocks (memcg_stock_pcp) to cache
pre-charged pages and introduce a fast path to try_charge_memcg.
However, there are a few quirks with the current implementation that
could be improved upon.

First, each memcg_stock_pcp can only cache the charges of 7 memcgs
(defined as NR_MEMCG_STOCK), which means that once a CPU starts handling
the charging of more than 7 memcgs, it randomly selects a victim memcg
to evict and drain from the cpu, which can cause unnecessarily increased
latencies and thrashing as memcgs continually evict each other's stock.

Flushing a memcg's stock on a CPU also means that all other stock
present on that CPU is also flushed, leading to poor caching for systems
running multiple memcgs competing for the same CPUs.

Finally, stock is tightly coupled with memcg, which means that all page
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

In this scheme, stock usage and refills happen via lockless atomic
operations, eliminating the need for asynchronous workqueues as well.
In this commit we introduce the alloc, free, and drain operations,
although they are unused for now.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h | 15 +++++++++++++
 mm/page_counter.c            | 42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index d649b6bbbc871..4abc7fe7c3494 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -5,8 +5,17 @@
 #include <linux/atomic.h>
 #include <linux/cache.h>
 #include <linux/limits.h>
+#include <linux/percpu.h>
 #include <asm/page.h>
 
+struct page_counter_stock {
+	/*
+	 * Consumption/refills can only come from the owning cpu via
+	 * atomic_cmpxchg. Remote access only happens on drain via atomic_xchg.
+	 */
+	atomic_t nr_pages;
+};
+
 struct page_counter {
 	/*
 	 * Make sure 'usage' does not share cacheline with any other field in
@@ -41,6 +50,8 @@ struct page_counter {
 	unsigned long high;
 	unsigned long max;
 	struct page_counter *parent;
+	struct page_counter_stock __percpu *stock;
+	unsigned int batch;
 } ____cacheline_internodealigned_in_smp;
 
 #if BITS_PER_LONG == 32
@@ -99,6 +110,10 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 	counter->watermark = usage;
 }
 
+void page_counter_drain_stock(struct page_counter *counter, unsigned int cpu);
+int page_counter_alloc_stock(struct page_counter *counter, unsigned int batch);
+void page_counter_free_stock(struct page_counter *counter);
+
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
 				       struct page_counter *counter,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 661e0f2a5127a..6bb48a913a90d 100644
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
@@ -289,6 +290,47 @@ int page_counter_memparse(const char *buf, const char *max,
 	return 0;
 }
 
+void page_counter_drain_stock(struct page_counter *counter, unsigned int cpu)
+{
+	struct page_counter_stock *stock;
+	int nr_pages;
+
+	if (!counter->stock)
+		return;
+
+	stock = per_cpu_ptr(counter->stock, cpu);
+	nr_pages = atomic_xchg(&stock->nr_pages, 0);
+	if (nr_pages)
+		page_counter_uncharge(counter, nr_pages);
+}
+
+int page_counter_alloc_stock(struct page_counter *counter, unsigned int batch)
+{
+	struct page_counter_stock __percpu *stock;
+
+	stock = alloc_percpu(struct page_counter_stock);
+	if (!stock)
+		return -ENOMEM;
+
+	counter->stock = stock;
+	counter->batch = batch;
+
+	return 0;
+}
+
+void page_counter_free_stock(struct page_counter *counter)
+{
+	int cpu;
+
+	if (!counter->stock)
+		return;
+
+	for_each_possible_cpu(cpu)
+		page_counter_drain_stock(counter, cpu);
+
+	free_percpu(counter->stock);
+	counter->stock = NULL;
+}
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 /*
-- 
2.53.0-Meta


