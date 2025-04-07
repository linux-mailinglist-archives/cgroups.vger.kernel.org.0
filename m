Return-Path: <cgroups+bounces-7413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A45EA7F159
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 01:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B27F91799F0
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F525522C;
	Mon,  7 Apr 2025 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He6dCyPK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC099254843;
	Mon,  7 Apr 2025 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744069356; cv=none; b=ZjhalIr5J1mWVFTiPi66CyZl/MzmmUaII8jLBoBbf57MaTPvve8dMv9sE20R0dgfPIyOHSETXGwgwi76uECMnzY9WiRNCjsNdNICoQeWfwe0dqlm11s2KsJrDDUmFrMQje1oVgfPJWa9sNheNAaiGF3zyODeqHzfvhQO2pPtYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744069356; c=relaxed/simple;
	bh=Pb5ViOs0CmYN4e54sVlv/fjVcXviZqrgEdvuN/sVPDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9GGPOm1G01TGUaydQUcLmFjX2NyZkPCgRm/wUldK3E50DlPHUcuIvARzlsxRPRrjV7Tl4oRDJtJn2GNRxhztGEfb7IHnI7Jnr0AAkY5ez/FRSgRrg1KCh8ieTT8FBwDkpla9o9R+d/XFUV3XsOPUb4rYJiF3ulQ06BxRSk3xZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He6dCyPK; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e643f235a34so3663353276.1;
        Mon, 07 Apr 2025 16:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744069351; x=1744674151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy9yoaTY8WhgNX1FAQKuY1G0jgwt8VM6ywJcV8fbRa8=;
        b=He6dCyPKKZtERj65Bs+ynrNzn3KbQXUMFJuhgTPbdQzDWCGKGsTQKbl01SyPVog+kD
         MEw8P4zag9/0VAoLXcElTb5hfoscUQMQRyDBRjqGIIuWZxsXS7fu8l+yx6vwyBO5we3Q
         mjvt4ir9FfKHgVkEXQ22iQdE8S2LPgWvX9H+XhDLPLoeYYip/d1Eow8Alg73e7rdbhZj
         krJYeWuSxgMMTGyNMjrG1v2SSr21rUSo4VSfOXTeJ7a1pdLQLWaXsWNhextG6T5nxsoY
         puhbRYg4uE8yxyY+moyonFXh6fxuNP7ubU07OcAdLLw14p+84k7kmnpNs6VjMN5bnM4f
         gu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744069351; x=1744674151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gy9yoaTY8WhgNX1FAQKuY1G0jgwt8VM6ywJcV8fbRa8=;
        b=FF3FFYS23BrfwQfdLV2Baji5jrkjO+hCulnPzoNsKV/xvFwSvVZltBp9kw8zjw88j5
         ksLmaQl6YaxeX4pBLx6pvse7ElDTdMntmbfBKYE/aZLm4Yzusq5p98GqMveqvxjWgfc2
         jXtGoMh5v+Nq2bYKqXeipVlKxUqzSt9VdAkmQZyYK9sHKRcaUqs3yh41hS6WlMju4+Sw
         0wu18nZMLegDTmVXZNhT9o9YBECeYRE2wFDY1QYadNJ6c/cCh1L2twn0lNn2JlaQFqlU
         M1x2old8O5iNpp45Px1KKvPTrRWQoec75HBRaGjM3JaNSV/hFPeT3P3mUD79zp8mV50N
         fSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7Ih50gwm9eK6FlOcZJl/wJKHBX3Vw06WP5vd/a9r+FUyDzgyCeC7ha7FmTlrBvt91v9nrwHj0Nvw=@vger.kernel.org, AJvYcCW7QZuHrmv06O0TzEhTG2+EGJgHdOIdYPRxzsC9lMfNb0UpIYxFYM4BaGXeAHmfWPeN4J/1nO8x@vger.kernel.org, AJvYcCXQHqDkCSIsmCyVGbjnv+789JYw2+Tdedkk8R4MQS9B8y50fsAFepRFDyYdZcFauvT/pgbvaU4eKHaMalrG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9IaladwH9z5gSMOiLkQ6+nRHM9BRYyH3EqUQUARHRX1vcmvUA
	ldLiVBCO/fFBsex03jaRUaTV2gpACEIxRIhTI9ggMqGJhmbJzsXP
X-Gm-Gg: ASbGncvrUgtc/F4Mq+7Zp474uFfVhwEk81NGhIaDNhjM4nqXmeBHrhsnmjub8qs9U4O
	/vaB8U78naTj72B9w9nv5KnspAUuVl7BthP2B75uxvDBP8l+m94RsWtJ2jgDK9jF0q5TjWnT2nN
	TtZ1O4bPG2iWu1v2fQQEhFZJmqrJTXjEiD+r96haqdQyR8g6KfvSZ/4HAuE9YyFQ8yjti4Ovazo
	r9CrtQV0vtJpcwrz3ML0NRugjIac3BZZM+tcYFTg2AiBvKjiftdkZg6pcgr1HnTwwGio4kD1RCG
	a0p/Slqu1S3H6KfN8v9m9WU99Dap6mCJRGM=
X-Google-Smtp-Source: AGHT+IFtjIGWjrSvPLmCF0xDwxdk78WKxan9bK4HNw+sdhPaREGZ3Zv4ygkRbbvK1bFWjicLYGKEQg==
X-Received: by 2002:a05:690c:25c1:b0:6fb:a376:3848 with SMTP id 00721157ae682-703e1628096mr243017637b3.34.1744069351629;
        Mon, 07 Apr 2025 16:42:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-703d1e86700sm27862117b3.68.2025.04.07.16.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 16:42:31 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	hughd@google.com,
	yosry.ahmed@linux.dev,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	len.brown@intel.com,
	chengming.zhou@linux.dev,
	kasong@tencent.com,
	chrisl@kernel.org,
	huang.ying.caritas@gmail.com,
	ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH 11/14] memcg: swap: only charge physical swap slots
Date: Mon,  7 Apr 2025 16:42:12 -0700
Message-ID: <20250407234223.1059191-12-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that zswap and the zero-filled swap page optimization no longer
takes up any physical swap space, we should not charge towards the swap
usage and limits of the memcg in these case. We will only record the
memcg id on virtual swap slot allocation, and defer physical swap
charging (i.e towards memory.swap.current) until the virtual swap slot
is backed by an actual physical swap slot (on zswap store failure
fallback or zswap writeback).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  17 ++++++++
 mm/memcontrol.c      | 102 ++++++++++++++++++++++++++++++++++---------
 mm/vswap.c           |  43 ++++++++----------
 3 files changed, 118 insertions(+), 44 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 073835335667..98cdfe0c1da7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -679,6 +679,23 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry);
+
+void __mem_cgroup_record_swap(struct folio *folio, swp_entry_t entry);
+static inline void mem_cgroup_record_swap(struct folio *folio,
+		swp_entry_t entry)
+{
+	if (!mem_cgroup_disabled())
+		__mem_cgroup_record_swap(folio, entry);
+}
+
+void __mem_cgroup_unrecord_swap(swp_entry_t entry, unsigned int nr_pages);
+static inline void mem_cgroup_unrecord_swap(swp_entry_t entry,
+		unsigned int nr_pages)
+{
+	if (!mem_cgroup_disabled())
+		__mem_cgroup_unrecord_swap(entry, nr_pages);
+}
+
 int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
 		swp_entry_t entry)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 126b2d0e6aaa..c6bee12f2016 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5020,6 +5020,46 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	css_put(&memcg->css);
 }
 
+/**
+ * __mem_cgroup_record_swap - record the folio's cgroup for the swap entries.
+ * @folio: folio being swapped out.
+ * @entry: the first swap entry in the range.
+ *
+ * In the virtual swap implementation, we only record the folio's cgroup
+ * for the virtual swap slots on their allocation. We will only charge
+ * physical swap slots towards the cgroup's swap usage, i.e when physical swap
+ * slots are allocated for zswap writeback or fallback from zswap store
+ * failure.
+ */
+void __mem_cgroup_record_swap(struct folio *folio, swp_entry_t entry)
+{
+	unsigned int nr_pages = folio_nr_pages(folio);
+	struct mem_cgroup *memcg;
+
+	memcg = folio_memcg(folio);
+
+	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
+	if (!memcg)
+		return;
+
+	memcg = mem_cgroup_id_get_online(memcg);
+	if (nr_pages > 1)
+		mem_cgroup_id_get_many(memcg, nr_pages - 1);
+	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
+}
+
+void __mem_cgroup_unrecord_swap(swp_entry_t entry, unsigned int nr_pages)
+{
+	unsigned short id = swap_cgroup_clear(entry, nr_pages);
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_id(id);
+	if (memcg)
+		mem_cgroup_id_put_many(memcg, nr_pages);
+	rcu_read_unlock();
+}
+
 /**
  * __mem_cgroup_try_charge_swap - try charging swap space for a folio
  * @folio: folio being added to swap
@@ -5038,34 +5078,47 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	if (do_memsw_account())
 		return 0;
 
-	memcg = folio_memcg(folio);
+	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP)) {
+		/*
+		 * In the virtual swap implementation, we already record the cgroup
+		 * on virtual swap allocation. Note that the virtual swap slot holds
+		 * a reference to memcg, so this lookup should be safe.
+		 */
+		rcu_read_lock();
+		memcg = mem_cgroup_from_id(lookup_swap_cgroup_id(entry));
+		rcu_read_unlock();
+	} else {
+		memcg = folio_memcg(folio);
 
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
-		return 0;
+		VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
+		if (!memcg)
+			return 0;
 
-	if (!entry.val) {
-		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		return 0;
-	}
+		if (!entry.val) {
+			memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
+			return 0;
+		}
 
-	memcg = mem_cgroup_id_get_online(memcg);
+		memcg = mem_cgroup_id_get_online(memcg);
+	}
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		mem_cgroup_id_put(memcg);
+		if (!IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+			mem_cgroup_id_put(memcg);
 		return -ENOMEM;
 	}
 
-	/* Get references for the tail pages, too */
-	if (nr_pages > 1)
-		mem_cgroup_id_get_many(memcg, nr_pages - 1);
+	if (!IS_ENABLED(CONFIG_VIRTUAL_SWAP)) {
+		/* Get references for the tail pages, too */
+		if (nr_pages > 1)
+			mem_cgroup_id_get_many(memcg, nr_pages - 1);
+		swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
+	}
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
 
-	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
-
 	return 0;
 }
 
@@ -5079,7 +5132,11 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
-	id = swap_cgroup_clear(entry, nr_pages);
+	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+		id = lookup_swap_cgroup_id(entry);
+	else
+		id = swap_cgroup_clear(entry, nr_pages);
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
 	if (memcg) {
@@ -5090,7 +5147,8 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 				page_counter_uncharge(&memcg->swap, nr_pages);
 		}
 		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
-		mem_cgroup_id_put_many(memcg, nr_pages);
+		if (!IS_ENABLED(CONFIG_VIRTUAL_SWAP))
+			mem_cgroup_id_put_many(memcg, nr_pages);
 	}
 	rcu_read_unlock();
 }
@@ -5099,7 +5157,7 @@ static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg);
 
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages, nr_zswap_pages = 0;
+	long nr_swap_pages;
 
 	/*
 	 * If swap is virtualized and zswap is enabled, we can still use zswap even
@@ -5108,10 +5166,14 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 	if (IS_ENABLED(CONFIG_VIRTUAL_SWAP) && zswap_is_enabled() &&
 			(mem_cgroup_disabled() || do_memsw_account() ||
 				mem_cgroup_may_zswap(memcg))) {
-		nr_zswap_pages = PAGE_COUNTER_MAX;
+		/*
+		 * No need to check swap cgroup limits, since zswap is not charged
+		 * towards swap consumption.
+		 */
+		return PAGE_COUNTER_MAX;
 	}
 
-	nr_swap_pages = max_t(long, nr_zswap_pages, get_nr_swap_pages());
+	nr_swap_pages = get_nr_swap_pages();
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
diff --git a/mm/vswap.c b/mm/vswap.c
index 3146c231ca69..fcc7807ba89b 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -349,6 +349,7 @@ static inline void release_backing(swp_entry_t entry, int nr)
 			swap_slot_free_nr(slot, nr);
 			swap_slot_put_swap_info(si);
 		}
+		mem_cgroup_uncharge_swap(entry, nr);
 	}
 }
 
@@ -367,7 +368,7 @@ static void vswap_free(swp_entry_t entry)
 
 	virt_clear_shadow_from_swap_cache(entry);
 	release_backing(entry, 1);
-	mem_cgroup_uncharge_swap(entry, 1);
+	mem_cgroup_unrecord_swap(entry, 1);
 	/* erase forward mapping and release the virtual slot for reallocation */
 	release_vswap_slot(entry.val);
 	kfree_rcu(desc, rcu);
@@ -392,27 +393,13 @@ swp_entry_t folio_alloc_swap(struct folio *folio)
 {
 	swp_entry_t entry;
 	struct swp_desc *desc;
-	int i, nr = folio_nr_pages(folio);
+	int nr = folio_nr_pages(folio);
 
 	entry = vswap_alloc(nr);
 	if (!entry.val)
 		return entry;
 
-	/*
-	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
-	 * swap slots allocation. This will be changed soon - we will only charge on
-	 * physical swap slots allocation.
-	 */
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		for (i = 0; i < nr; i++) {
-			vswap_free(entry);
-			entry.val++;
-		}
-		atomic_add(nr, &vswap_alloc_reject);
-		entry.val = 0;
-		return entry;
-	}
-
+	mem_cgroup_record_swap(folio, entry);
 	XA_STATE(xas, &vswap_map, entry.val);
 
 	rcu_read_lock();
@@ -454,6 +441,9 @@ swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
 	if (!slot.val)
 		return slot;
 
+	if (mem_cgroup_try_charge_swap(folio, entry))
+		goto free_phys_swap;
+
 	/* establish the vrtual <-> physical swap slots linkages. */
 	for (i = 0; i < nr; i++) {
 		err = xa_insert(&vswap_rmap, slot.val + i,
@@ -462,13 +452,7 @@ swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
 		if (err) {
 			while (--i >= 0)
 				xa_erase(&vswap_rmap, slot.val + i);
-			/*
-			 * We have not updated the backing type of the virtual swap slot.
-			 * Simply free up the physical swap slots here!
-			 */
-			swap_slot_free_nr(slot, nr);
-			slot.val = 0;
-			return slot;
+			goto uncharge;
 		}
 	}
 
@@ -505,6 +489,17 @@ swp_slot_t vswap_alloc_swap_slot(struct folio *folio)
 	}
 	rcu_read_unlock();
 	return slot;
+
+uncharge:
+	mem_cgroup_uncharge_swap(entry, nr);
+free_phys_swap:
+	/*
+	 * We have not updated the backing type of the virtual swap slot.
+	 * Simply free up the physical swap slots here!
+	 */
+	swap_slot_free_nr(slot, nr);
+	slot.val = 0;
+	return slot;
 }
 
 /**
-- 
2.47.1


