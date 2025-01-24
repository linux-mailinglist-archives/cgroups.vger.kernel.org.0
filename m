Return-Path: <cgroups+bounces-6256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEC7A1AFFE
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 06:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E363A4F47
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 05:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B021D86C0;
	Fri, 24 Jan 2025 05:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="pDjXnP9n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2134117FE
	for <cgroups@vger.kernel.org>; Fri, 24 Jan 2025 05:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737697307; cv=none; b=Jfetc4gBtSzAN8bvjzMErNmj12iv89fGxMdaBqtfbfqQm67fyXU6f+SBAqhv3qQCaFmeSLb5Nw1GC7jMKFEMv5j21b0r9+IqbUYgjWZseeGBatQNO6n5TNeR72NRSVbgyGMjYlxO2IV0lLk3ANg29jvLMc+DcOGtauvsqYY21sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737697307; c=relaxed/simple;
	bh=EjQi1SYAVttJNzE6RIpXeZO3wXVaxFZrdodN0KNedek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B08KOVbwpnHMhuIlCd1sNjgV/oGE2uDkmdM+Xh52PZc1ZuW2OLs0M2EQlYkfJuGKEmyYO5ish99uPfWrhWmy+zR2IZHSpmvrqaJhEKGNTT3fOuDYcKmtdX8nV9tKh54kdWq78iGsnMhUdrugU++ogyg+jf9dE8aI53drhLzVeDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=pDjXnP9n; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be44a90468so196865485a.3
        for <cgroups@vger.kernel.org>; Thu, 23 Jan 2025 21:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737697302; x=1738302102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3BNRrt+Dbe/9hWGpIRXWblSlY9nc8Z0+7pKW2wxcF4c=;
        b=pDjXnP9nRpFl7AO1EI4/7nFIEK1cF4qWFF1jKvMm8nFF9LF1Luseo3eOhH4VQdOtqf
         CH9KHqAl2uVqGtvZ6A+IOFIl2aEsiYZGr5OYFhZeXwTB3MvcsQle2sDo/tIgrlZwXWOX
         ZLzJjrYpkyMUJh4IPGoGmDRHzztpW+DdyxUv21aNH9OFzQKIyoTRS0hZPPLjzBuipwhM
         fRn1byv2iOPxcv364QT79+SuANSyjJr6gt1DNafq1ZvORJvEt3AjPgujKmcQGkD7x8al
         gXdc+KXW2uny5+qaWDaXdYiBZynyQpC8x5ZdVjRaeUISvt1EjArPIoC1nL+jTEaav0rJ
         8n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737697302; x=1738302102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BNRrt+Dbe/9hWGpIRXWblSlY9nc8Z0+7pKW2wxcF4c=;
        b=qaOKvH/meQRdLQxfT9UNgVsOIp72UhPBU+mbUkhXICpiu+/+zTAhyP2C5R/LMDhNIu
         1pOtZDWkxRNqcytqaUybPaTGIq0lfdhAHy5CIcQh7o2CTk5Y4NVhGoCuNiofcF79Fznp
         9cWt2M04zQHNYSRNC4RXFIaR3Zmxzc/2912/XIHP1zFzkER/Hic4Y3AHygT1TZ0ApGjr
         1Xx8t0sHXrqVCHcVnRzLJWYy1+dz7j08LHMF8RnjVKkmhz2BsKZKEgytVGk1QES/1mwl
         GCRcTsqBIEyQn7JgpFabIOc5r2SR4RR2vipUqKkZxUrQ3eWVRLNDx8o0aRPghkLbjiOp
         OLtg==
X-Forwarded-Encrypted: i=1; AJvYcCVauT2q29Wpn6DtYunwMekcKCYv6JhWw0Ff+00lNAS8T9UbOIjPwLy2bZuq2BC3hKpnF+pm0Pu6@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjsRKkA5hSUXzoopBPB/o1QIElB230ougfzPeU4r3GYm0if+U
	0g6szgRNCPEr2MvXBGXlXdYq48dervJYAZI+uFZFdaPlOG2fA14rQ4EjThEgCQlrVzn3P7ln+nP
	e
X-Gm-Gg: ASbGncuBJ2f7FtKjhKZJ27Qjb5mTHdfbIet70SDZLywcNZOmEb0DKtoUwI54NFWKdhC
	UIOSCS5Ha65CWE3tMd1HK//MfKBxlO2Jr4ygg5tLXkaTA2SBy9jMlsP0fQUFLw7UnyC/2U3C4fj
	aaQN03cFUKLua2+KqI3n2QP5kh47inJTtoJw0Y9sQL17szNb/O0uRyl7SwRjj3tp0nKcV6ls9Rr
	dqSK2nVD/KqYj0BgReA9kRUvePwtIKx0H/sdI/pKvjlU/s73brLIlNauC3sDujBkhfztVb+TMzL
	F7c=
X-Google-Smtp-Source: AGHT+IHFExbh/6JCGP5+qzQe+smO7IPccOucefu+keobPXrC2uOopUiYmPw6EVLwZ0LiqKwsCFU9FA==
X-Received: by 2002:a05:620a:2607:b0:7bc:db11:4940 with SMTP id af79cd13be357-7be63253e2fmr5105961085a.55.1737697301694;
        Thu, 23 Jan 2025 21:41:41 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:cbb0:8ad0:a429:60f5])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7be9ae7fe2bsm60330985a.20.2025.01.23.21.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 21:41:38 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: memcontrol: move memsw charge callbacks to v1
Date: Fri, 24 Jan 2025 00:41:32 -0500
Message-ID: <20250124054132.45643-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interweaving of two entirely different swap accounting strategies
has been one of the more confusing parts of the memcg code. Split out
the v1 code to clarify the implementation and a handful of callsites,
and to avoid building the v1 bits when !CONFIG_MEMCG_V1.

   text	  data	   bss	   dec	   hex	filename
  39253	  6446	  4160	 49859	  c2c3	mm/memcontrol.o.old
  38877	  6382	  4160	 49419	  c10b	mm/memcontrol.o

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  17 +++--
 include/linux/swap.h       |   5 --
 mm/huge_memory.c           |   2 +-
 mm/memcontrol-v1.c         |  89 ++++++++++++++++++++++++-
 mm/memcontrol-v1.h         |   6 +-
 mm/memcontrol.c            | 129 ++++++-------------------------------
 mm/memory.c                |   2 +-
 mm/shmem.c                 |   2 +-
 mm/swap_state.c            |   2 +-
 mm/vmscan.c                |   2 +-
 10 files changed, 126 insertions(+), 130 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6e74b8254d9b..57664e2a8fb7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -649,8 +649,6 @@ int mem_cgroup_charge_hugetlb(struct folio* folio, gfp_t gfp);
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
-
 void __mem_cgroup_uncharge(struct folio *folio);
 
 /**
@@ -1165,10 +1163,6 @@ static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 	return 0;
 }
 
-static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr)
-{
-}
-
 static inline void mem_cgroup_uncharge(struct folio *folio)
 {
 }
@@ -1848,6 +1842,9 @@ static inline void mem_cgroup_exit_user_fault(void)
 	current->in_user_fault = 0;
 }
 
+void memcg1_swapout(struct folio *folio, swp_entry_t entry);
+void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages);
+
 #else /* CONFIG_MEMCG_V1 */
 static inline
 unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
@@ -1875,6 +1872,14 @@ static inline void mem_cgroup_exit_user_fault(void)
 {
 }
 
+static inline void memcg1_swapout(struct folio *folio, swp_entry_t entry)
+{
+}
+
+static inline void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
+{
+}
+
 #endif /* CONFIG_MEMCG_V1 */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/include/linux/swap.h b/include/linux/swap.h
index b13b72645db3..91b30701274e 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -659,7 +659,6 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 #endif
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
-void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry);
 int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
 		swp_entry_t entry)
@@ -680,10 +679,6 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct folio *folio);
 #else
-static inline void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
-{
-}
-
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
 					     swp_entry_t entry)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 3d3ebdc002d5..c40b42a1015a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3740,7 +3740,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 
 	/*
 	 * Exclude swapcache: originally to avoid a corrupt deferred split
-	 * queue. Nowadays that is fully prevented by mem_cgroup_swapout();
+	 * queue. Nowadays that is fully prevented by memcg1_swapout();
 	 * but if page reclaim is already handling the same folio, it is
 	 * unnecessary to handle it again in the shrinker, so excluding
 	 * swapcache here may still be a useful optimization.
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6d184fae0ad1..1d16a99fb964 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -581,8 +581,59 @@ void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	local_irq_restore(flags);
 }
 
-void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg)
+/**
+ * memcg1_swapout - transfer a memsw charge to swap
+ * @folio: folio whose memsw charge to transfer
+ * @entry: swap entry to move the charge to
+ *
+ * Transfer the memsw charge of @folio to @entry.
+ */
+void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 {
+	struct mem_cgroup *memcg, *swap_memcg;
+	unsigned int nr_entries;
+
+	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
+	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
+
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!do_memsw_account())
+		return;
+
+	memcg = folio_memcg(folio);
+
+	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
+	if (!memcg)
+		return;
+
+	/*
+	 * In case the memcg owning these pages has been offlined and doesn't
+	 * have an ID allocated to it anymore, charge the closest online
+	 * ancestor for the swap instead and transfer the memory+swap charge.
+	 */
+	swap_memcg = mem_cgroup_id_get_online(memcg);
+	nr_entries = folio_nr_pages(folio);
+	/* Get references for the tail pages, too */
+	if (nr_entries > 1)
+		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
+	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
+
+	swap_cgroup_record(folio, entry);
+
+	folio_unqueue_deferred_split(folio);
+	folio->memcg_data = 0;
+
+	if (!mem_cgroup_is_root(memcg))
+		page_counter_uncharge(&memcg->memory, nr_entries);
+
+	if (memcg != swap_memcg) {
+		if (!mem_cgroup_is_root(swap_memcg))
+			page_counter_charge(&swap_memcg->memsw, nr_entries);
+		page_counter_uncharge(&memcg->memsw, nr_entries);
+	}
+
 	/*
 	 * Interrupts should be disabled here because the caller holds the
 	 * i_pages lock which is taken with interrupts-off. It is
@@ -594,6 +645,42 @@ void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg)
 	memcg1_charge_statistics(memcg, -folio_nr_pages(folio));
 	preempt_enable_nested();
 	memcg1_check_events(memcg, folio_nid(folio));
+
+	css_put(&memcg->css);
+}
+
+/*
+ * memcg1_swapin - uncharge swap slot
+ * @entry: the first swap entry for which the pages are charged
+ * @nr_pages: number of pages which will be uncharged
+ *
+ * Call this function after successfully adding the charged page to swapcache.
+ *
+ * Note: This function assumes the page for which swap slot is being uncharged
+ * is order 0 page.
+ */
+void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
+{
+	/*
+	 * Cgroup1's unified memory+swap counter has been charged with the
+	 * new swapcache page, finish the transfer by uncharging the swap
+	 * slot. The swap slot would also get uncharged when it dies, but
+	 * it can stick around indefinitely and we'd count the page twice
+	 * the entire time.
+	 *
+	 * Cgroup2 has separate resource counters for memory and swap,
+	 * so this is a non-issue here. Memory and swap charge lifetimes
+	 * correspond 1:1 to page and swap slot lifetimes: we charge the
+	 * page to memory here, and uncharge swap when the slot is freed.
+	 */
+	if (do_memsw_account()) {
+		/*
+		 * The swap entry might not get freed for a long time,
+		 * let's not wait for it.  The page already received a
+		 * memory+swap charge, drop the swap entry duplicate.
+		 */
+		mem_cgroup_uncharge_swap(entry, nr_pages);
+	}
 }
 
 void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 4c8f36430fe9..1dc759e65471 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -39,6 +39,9 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
+void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
+struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
+
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
 
@@ -69,7 +72,6 @@ void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
 void memcg1_oom_recover(struct mem_cgroup *memcg);
 
 void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
-void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg);
 void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
 			   unsigned long nr_memory, int nid);
 
@@ -107,8 +109,6 @@ static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
 static inline void memcg1_commit_charge(struct folio *folio,
 					struct mem_cgroup *memcg) {}
 
-static inline void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg) {}
-
 static inline void memcg1_uncharge_batch(struct mem_cgroup *memcg,
 					 unsigned long pgpgout,
 					 unsigned long nr_memory, int nid) {}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 818143b81760..a95cb3fbb2c8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3377,7 +3377,7 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 	}
 }
 
-static void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
+void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
 					   unsigned int n)
 {
 	refcount_add(n, &memcg->id.ref);
@@ -3398,6 +3398,24 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
 	mem_cgroup_id_put_many(memcg, 1);
 }
 
+struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
+{
+	while (!refcount_inc_not_zero(&memcg->id.ref)) {
+		/*
+		 * The root cgroup cannot be destroyed, so it's refcount must
+		 * always be >= 1.
+		 */
+		if (WARN_ON_ONCE(mem_cgroup_is_root(memcg))) {
+			VM_BUG_ON(1);
+			break;
+		}
+		memcg = parent_mem_cgroup(memcg);
+		if (!memcg)
+			memcg = root_mem_cgroup;
+	}
+	return memcg;
+}
+
 /**
  * mem_cgroup_from_id - look up a memcg from a memcg id
  * @id: the memcg id to look up
@@ -4585,40 +4603,6 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 	return ret;
 }
 
-/*
- * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
- * @entry: the first swap entry for which the pages are charged
- * @nr_pages: number of pages which will be uncharged
- *
- * Call this function after successfully adding the charged page to swapcache.
- *
- * Note: This function assumes the page for which swap slot is being uncharged
- * is order 0 page.
- */
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
-{
-	/*
-	 * Cgroup1's unified memory+swap counter has been charged with the
-	 * new swapcache page, finish the transfer by uncharging the swap
-	 * slot. The swap slot would also get uncharged when it dies, but
-	 * it can stick around indefinitely and we'd count the page twice
-	 * the entire time.
-	 *
-	 * Cgroup2 has separate resource counters for memory and swap,
-	 * so this is a non-issue here. Memory and swap charge lifetimes
-	 * correspond 1:1 to page and swap slot lifetimes: we charge the
-	 * page to memory here, and uncharge swap when the slot is freed.
-	 */
-	if (do_memsw_account()) {
-		/*
-		 * The swap entry might not get freed for a long time,
-		 * let's not wait for it.  The page already received a
-		 * memory+swap charge, drop the swap entry duplicate.
-		 */
-		mem_cgroup_uncharge_swap(entry, nr_pages);
-	}
-}
-
 struct uncharge_gather {
 	struct mem_cgroup *memcg;
 	unsigned long nr_memory;
@@ -4944,81 +4928,6 @@ static int __init mem_cgroup_init(void)
 subsys_initcall(mem_cgroup_init);
 
 #ifdef CONFIG_SWAP
-static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
-{
-	while (!refcount_inc_not_zero(&memcg->id.ref)) {
-		/*
-		 * The root cgroup cannot be destroyed, so it's refcount must
-		 * always be >= 1.
-		 */
-		if (WARN_ON_ONCE(mem_cgroup_is_root(memcg))) {
-			VM_BUG_ON(1);
-			break;
-		}
-		memcg = parent_mem_cgroup(memcg);
-		if (!memcg)
-			memcg = root_mem_cgroup;
-	}
-	return memcg;
-}
-
-/**
- * mem_cgroup_swapout - transfer a memsw charge to swap
- * @folio: folio whose memsw charge to transfer
- * @entry: swap entry to move the charge to
- *
- * Transfer the memsw charge of @folio to @entry.
- */
-void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
-{
-	struct mem_cgroup *memcg, *swap_memcg;
-	unsigned int nr_entries;
-
-	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
-	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
-
-	if (mem_cgroup_disabled())
-		return;
-
-	if (!do_memsw_account())
-		return;
-
-	memcg = folio_memcg(folio);
-
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
-		return;
-
-	/*
-	 * In case the memcg owning these pages has been offlined and doesn't
-	 * have an ID allocated to it anymore, charge the closest online
-	 * ancestor for the swap instead and transfer the memory+swap charge.
-	 */
-	swap_memcg = mem_cgroup_id_get_online(memcg);
-	nr_entries = folio_nr_pages(folio);
-	/* Get references for the tail pages, too */
-	if (nr_entries > 1)
-		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
-	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
-
-	swap_cgroup_record(folio, entry);
-
-	folio_unqueue_deferred_split(folio);
-	folio->memcg_data = 0;
-
-	if (!mem_cgroup_is_root(memcg))
-		page_counter_uncharge(&memcg->memory, nr_entries);
-
-	if (memcg != swap_memcg) {
-		if (!mem_cgroup_is_root(swap_memcg))
-			page_counter_charge(&swap_memcg->memsw, nr_entries);
-		page_counter_uncharge(&memcg->memsw, nr_entries);
-	}
-
-	memcg1_swapout(folio, memcg);
-	css_put(&memcg->css);
-}
-
 /**
  * __mem_cgroup_try_charge_swap - try charging swap space for a folio
  * @folio: folio being added to swap
diff --git a/mm/memory.c b/mm/memory.c
index 2a20e3810534..708ae27673b1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4393,7 +4393,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				}
 				need_clear_cache = true;
 
-				mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
+				memcg1_swapin(entry, nr_pages);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
diff --git a/mm/shmem.c b/mm/shmem.c
index 44379bee5b96..d885ecb6fe1e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2017,7 +2017,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	__folio_set_swapbacked(new);
 	new->swap = entry;
 
-	mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
+	memcg1_swapin(entry, nr_pages);
 	shadow = get_shadow_from_swap_cache(entry);
 	if (shadow)
 		workingset_refault(new, shadow);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ca42b2be64d9..2e1acb210e57 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -521,7 +521,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (add_to_swap_cache(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
 		goto fail_unlock;
 
-	mem_cgroup_swapin_uncharge_swap(entry, 1);
+	memcg1_swapin(entry, 1);
 
 	if (shadow)
 		workingset_refault(new_folio, shadow);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3bbe917b6a34..b2b2f27b10a0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -769,7 +769,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
 		__delete_from_swap_cache(folio, swap, shadow);
-		mem_cgroup_swapout(folio, swap);
+		memcg1_swapout(folio, swap);
 		xa_unlock_irq(&mapping->i_pages);
 		put_swap_folio(folio, swap);
 	} else {
-- 
2.48.1


