Return-Path: <cgroups+bounces-15211-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPonFyBn2Wm8pQgAu9opvQ
	(envelope-from <cgroups+bounces-15211-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:09:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A98823DCBFC
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E05304C977
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A79C3A9605;
	Fri, 10 Apr 2026 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDtwKJ1q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FA32ED40
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855268; cv=none; b=Opyz8DXc5XlTAizY14roYFEMsqRqGNeXrlxbdEgQ41l04uYp1oXd8n8UogLKJHuUuwL7H/HTTJbr5lNUn2oXvTQZgM125jsQo8js/S9IZSLEMH5aHXPbpX1ehu5hRJYk6OiHoeuj88CGuy6hBqsfzL7rUs4BRppSti9pRgEXQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855268; c=relaxed/simple;
	bh=u9ErvmZeT2BqDjl0OuopUNGSnpUsL3K8g6ZSAxdifZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAO3qJZEi8k8iwa024SoO1gR7qL6Z3kCL9fLktafd/j5xWdwsZgjBE5RF/r7NIjMZOnaFwFyTgM/P9Y9FwuRWRdTXQZPNqeKQDBfWlMy9NQDP1M60LzAc1825nHLJgqO6C6t+QHDLM/BWqNF6Spxc/HVngItRg74ToafYheAf5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDtwKJ1q; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d1872504cbso2236927a34.0
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855266; x=1776460066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ra7lyKTz0FXclo/ZAhEfnaPWl8hR2IKs3cjWe/KBKyU=;
        b=kDtwKJ1qEnskAltVCx0rxmJUKWdMJJnxsWhBeqxd/jncd3cngRWiRWp3HTNBYhK+j5
         OD3aSqf9+6GnbqxD5ZTHWPwcHLkbgwnyQcBj4eEuHbTOFB2r+m+igRx3HKRhf3LhoGRV
         OY5SPdcNblunCkUP0KOqnasi+lW0e0kr8fukvfJ50P7b/pH0rt7CRn7kCbq5niA7d3xl
         eMn1WqbcbQ+R76v5cA0NJEN25uxfvBh7fhglfdtfTOBIQEh3nBZSrQjsXOqzX83vH9Pv
         dLnd64oTvz8/6HpDUoggTLK4LQzjzEMFMSSe28toUTPHxWr/ghC2/Fi+5bxLDbeUVixh
         SReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855266; x=1776460066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ra7lyKTz0FXclo/ZAhEfnaPWl8hR2IKs3cjWe/KBKyU=;
        b=Ye9WhbXZSvldlNqCeC3S3v9ndO5ClbzDCHPjL5erWaLjIwnCIloJH2uHVXCJBOSIms
         mCKyiCyaftUyadS/pbh0PBGJfcoc6hrBjoORiKBL2QHifRTosd6mqxXayi4imiLSPPw3
         fteDs5HUBhGjJ8CSQsRgAuXOyHHcHfoU3LP7o5vH97rrVqo/yKWshUeYj6QdlQox+Z8e
         qryogNQ9cuf74OGgqc0px5stLWAZONYtjdqcbbPjyLnlFeYxeJ+eQjcoEVn9pzuD4obq
         Z5nJ7VNUX3FdRMDl6f4Ohi/TuaTey3c5I2cS4UBxXSbZBtgfzUMh+4oGpjAJB8dYLdGl
         i75A==
X-Forwarded-Encrypted: i=1; AJvYcCVrtuB+5ydqKmv5Z+MxS/RrfehnyGRvbNAV0srD1x2sSjr4ziPuMKaUrrMoUqegvuluYnHPMnng@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09AvqjmN6CAYd4VXDSkAtyAYTLc+T5uk6XJ/uhglHmGK+cDty
	bpxUlg4Fg6wx0kZhRIAkkLAJ2uMcPJ7clnkmKa407JnEkeRMcf3koRYB
X-Gm-Gg: AeBDievMMyM/FPHK6WPMNfMW/NJiNeTm5W5IeFQurpzXkVSNb13xtKy82Gfy6h3PoBp
	tkk9GuIXEm8kT2grOhLbcWVSgUVg8LZnEg0edeOcThiCOPiBxXzI3e6cpQmtKq1XgUur98arEJh
	HLehmq5fr7LsC8jAyraBAzyTB8fDRUHGMzOVKrL4dv2OvIw/UTwkdR8XLRvkA2L5DzrrG68KnAM
	ArMN2zjlQyWJdwHpz/gOUaLNosMB0RMQDjfv9o6igyCf669E4EecoltlcqJBZKhBSbr/whaDzij
	isy+fxd76JGQ6RLMP19p2C3ih+jTu8GRrdk0mgdSvrRjPib5kwVPAvCkkGufuk/Zp4Ebp/6Hs3t
	El6KSGwZtrdmDYpEQS/9sDlnNGrYKLtwdP/XwDHH2xm02+UYc4zc1K3id+HciCRmzdlo/OKDphy
	MFPL4X7N88njxm5m5lboAhbD0XcNL4+vo/
X-Received: by 2002:a05:6830:8312:b0:7d8:7da0:7d8f with SMTP id 46e09a7af769-7dc177a646fmr3456536a34.16.1775855266401;
        Fri, 10 Apr 2026 14:07:46 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc269d52ffsm3136947a34.26.2026.04.10.14.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:46 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
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
Subject: [PATCH 1/8 RFC] mm/page_counter: introduce per-page_counter stock
Date: Fri, 10 Apr 2026 14:06:55 -0700
Message-ID: <20260410210742.550489-2-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
References: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15211-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A98823DCBFC
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
 mm/page_counter.c            | 60 ++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

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
index 661e0f2a5127a..965021993e161 100644
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
@@ -289,6 +290,65 @@ int page_counter_memparse(const char *buf, const char *max,
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
+void page_counter_disable_stock(struct page_counter *counter)
+{
+	unsigned int stock_to_drain = 0;
+	int cpu;
+
+	if (!counter->stock)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct page_counter_stock *stock;
+
+		/*
+		 * No need for local lock; this is called during css_offline,
+		 * after the cgroup has already been removed.
+		 */
+		stock = per_cpu_ptr(counter->stock, cpu);
+		stock_to_drain += stock->nr_pages;
+	}
+
+	if (stock_to_drain) {
+		struct page_counter *c;
+
+		for (c = counter; c; c = c->parent)
+			page_counter_cancel(c, stock_to_drain);
+	}
+
+	/* This prevents future charges from trying to deposit pages */
+	counter->batch = 0;
+}
+
+void page_counter_free_stock(struct page_counter *counter)
+{
+	if (!counter->stock)
+		return;
+
+	free_percpu(counter->stock);
+	counter->stock = NULL;
+}
+
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 /*
-- 
2.52.0


