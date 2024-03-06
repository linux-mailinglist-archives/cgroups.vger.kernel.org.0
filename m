Return-Path: <cgroups+bounces-1988-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE959873F0D
	for <lists+cgroups@lfdr.de>; Wed,  6 Mar 2024 19:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BF0287347
	for <lists+cgroups@lfdr.de>; Wed,  6 Mar 2024 18:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD6E14BD41;
	Wed,  6 Mar 2024 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smWRj0Wn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9509814A4D2
	for <cgroups@vger.kernel.org>; Wed,  6 Mar 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709749529; cv=none; b=RD9VOyrL9FeywhknWJ38OT+iQ8Kibm5esed3NqWrVty5zTIHS0LIspmbluG4XvfckemDmWJyjtWK1PmdrmhU6bLxFo5sxsyvIVmqOJ1x3NXAHo0GU0waZcT1lGnjSaVBR1UDl+qmg1Eani15L3lcUtF2kUNzLVv5J11WlPBbyh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709749529; c=relaxed/simple;
	bh=8gZDLXySUHS8SR1VChM+2ulcrAIJsKB6/fnzku3BZtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YttUbKfqedYVMWz+KOks125sLxZkcU52zaMq/j+b83FFZhq0VWAE2msNMqBaqSQ0asV5t8lKw5Nx5xwlSeov0/6ZyG9Tsbelkevw5F3mvjrON7V3hQxFVUOvHODWWrif8rDLwjUEMQ59HhFR8xDdoTC99uL+Go4wWXwtMjLlJNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=smWRj0Wn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60802b0afd2so837987b3.1
        for <cgroups@vger.kernel.org>; Wed, 06 Mar 2024 10:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709749526; x=1710354326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UytzFxvo2MN54m2UV3o6+O9sIke62l96NyrXCwye1Yc=;
        b=smWRj0WnRrzh3JgstPGR1NfZ8PLBDC6e+a3FPdXTtVLMWSdVqToMlq8jR7umoPtouZ
         qOyG8czagrdmNza2YH1Zd5c+0gnbyiRPq3zLbhLCdTfA+SaQRZikgZS4j6xqGrcl6uk2
         41MVpE6mPOdozYq6m3cJhFcC52dPLTiKWY6KqqY1e5rT3s8TrIYeXEX4FLDjK9n4VHjk
         sR/T6M1eCCaZNnZRSxc9LSTPhRyDUN00r/socdK4IKFwMye0YE4n51QBUrKOUYhtohsx
         efZQnslQXFfgo+pwzEYaqUPUYM+aM06cPTzkOP4BFTqxGapuddAcQYv8hKV0fekgcuVp
         OAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709749526; x=1710354326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UytzFxvo2MN54m2UV3o6+O9sIke62l96NyrXCwye1Yc=;
        b=ptzkt26DQPk5dkDc0C/8dxOv7PJoIfnkt2+Li42C+pc9WjfvtwCHmfwCFEqiQkYLlx
         YrsZB/k8xsKmJUsmCMp3tASiPvbcP8KvCmvOZXW6sy+RKsiN2k5oXObqHAjFaI7KaOpY
         l3wQjKN71pYaKt9X9rf7Hap0PWE/+I4sHt9zCe0CEJUB1M1u3SJyYE/gdpbWHwYK3osc
         cKMstXF5169eQwX9XGo/XzlF+btQJEhZA/oE2H2aFT8kyD9bvJCe1M1v4Rvni1tLBCer
         0WAbwicL8P8RvuOOdPom5+o8WP2M1T02EIMNpbeTSG9e0Q7AwUjGcfB6fRzDwNO902m+
         7Ljg==
X-Forwarded-Encrypted: i=1; AJvYcCXd36m774ZIPpakTF4qGTva8TJ/A/JmTb7s9S70S5Z5OJYNIRIHUCz1MfJxdAR95B4Q5VM52GKS6JrAP8PbPXdQW17qx+ujoQ==
X-Gm-Message-State: AOJu0YwAAHzfdiFNZhetntPAZRjCpVnRPHJc+koZT6vccKbS7+QYXbyp
	cB5I5cfESc6MzoSoa4AM2J6aLmYP59HZ4UXxX6xP+3sWviQr4/N1nO60t5lOE6uEG7E+766NyRP
	Zew==
X-Google-Smtp-Source: AGHT+IELFceSPWFrUjgphXkqF3QF81hXppl+wz2Z5M52XUCNjOCO0HkPXUz6VhR3ZLtCxZs2Az+yJ39E678=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:85f0:e3db:db05:85e2])
 (user=surenb job=sendgmr) by 2002:a81:7948:0:b0:609:5bd8:de84 with SMTP id
 u69-20020a817948000000b006095bd8de84mr1217843ywc.0.1709749525732; Wed, 06 Mar
 2024 10:25:25 -0800 (PST)
Date: Wed,  6 Mar 2024 10:24:17 -0800
In-Reply-To: <20240306182440.2003814-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306182440.2003814-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306182440.2003814-20-surenb@google.com>
Subject: [PATCH v5 19/37] mm: create new codetag references during page splitting
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, shakeelb@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a high-order page is split into smaller ones, each newly split
page should get its codetag. After the split each split page will be
referencing the original codetag. The codetag's "bytes" counter
remains the same because the amount of allocated memory has not
changed, however the "calls" counter gets increased to keep the
counter correct when these individual pages get freed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/alloc_tag.h   |  9 +++++++++
 include/linux/pgalloc_tag.h | 30 ++++++++++++++++++++++++++++++
 mm/huge_memory.c            |  2 ++
 mm/page_alloc.c             |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 28c0005edae1..bc9b1b99a55b 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -106,6 +106,15 @@ static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag
 	this_cpu_inc(tag->counters->calls);
 }
 
+static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
+{
+	alloc_tag_add_check(ref, tag);
+	if (!ref || !tag)
+		return;
+
+	__alloc_tag_ref_set(ref, tag);
+}
+
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
 {
 	alloc_tag_add_check(ref, tag);
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index b49ab955300f..9e6ad8e0e4aa 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -67,11 +67,41 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int order)
 	}
 }
 
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
+{
+	int i;
+	struct page_ext *page_ext;
+	union codetag_ref *ref;
+	struct alloc_tag *tag;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	page_ext = page_ext_get(page);
+	if (unlikely(!page_ext))
+		return;
+
+	ref = codetag_ref_from_page_ext(page_ext);
+	if (!ref->ct)
+		goto out;
+
+	tag = ct_to_alloc_tag(ref->ct);
+	page_ext = page_ext_next(page_ext);
+	for (i = 1; i < nr; i++) {
+		/* Set new reference to point to the original tag */
+		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
+		page_ext = page_ext_next(page_ext);
+	}
+out:
+	page_ext_put(page_ext);
+}
+
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int order) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int order) {}
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a81a09236c16..d596449b5bc8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -38,6 +38,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/compat.h>
+#include <linux/pgalloc_tag.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -2946,6 +2947,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, order, new_order);
+	pgalloc_tag_split(head, 1 << order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (folio_test_anon(folio)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eb5cae9b967d..39dc4dcf14f5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2663,6 +2663,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order, 0);
+	pgalloc_tag_split(page, 1 << order);
 	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4850,6 +4851,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, order, 0);
+		pgalloc_tag_split(page, 1 << order);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
-- 
2.44.0.278.ge034bb2e1d-goog


