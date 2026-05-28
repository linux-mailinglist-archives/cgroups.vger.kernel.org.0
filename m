Return-Path: <cgroups+bounces-16407-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AaeOv2zGGr9mAgAu9opvQ
	(envelope-from <cgroups+bounces-16407-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:30:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D8B5FA6A7
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 23:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7C733022E2C
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC642E738A;
	Thu, 28 May 2026 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3XWw+Ri"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED533603FB
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003810; cv=none; b=NrlRcWmiy5DQ6Olx/Cr25HDTyFat1pMMtPZ0D4E9+7ES9BmuVMIJcCHL8aBPKfFec1J3Wz6H/MEMW2TJXf2Q3mN5E1u4clHdvFjWlhShInB32AYHUXGijoC0wjyBwM3Y5GjucE8J50p9icMPv5sf3KmRepXR4nJATEKRtQrEmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003810; c=relaxed/simple;
	bh=+rMpHJ1FReD9AMZPCsmDYAX43qNMG7fXfRg2A6zFtVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq4R6INyhd+J+7eLPp/ZcX5VRy9T8uxuMRh+5+8F3Ope6vN7Od3gUUTh7VYnxfowsXn+Xplp25HVBMj5eaXeLCMru1qTOG/CieZYFYskG25NZZ2eQE07uvS99KfWOlau9kguDzbQmOSZGdmA9vKWdn2pJGV1DdaVmIUBf34utJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3XWw+Ri; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4855562f32eso2635228b6e.2
        for <cgroups@vger.kernel.org>; Thu, 28 May 2026 14:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780003805; x=1780608605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp4nYgBwYqbTZevet3/JvCrzNrQ24lukygwTOrJB7hw=;
        b=F3XWw+RiybZE8ufmSReJI0SSRI9kqEb1m+0p7T601DbhYywukYoqHQgnI4tsugdpN1
         cVx/QNZWlzg4mYW6N1o7hZCUGr+Ua80RVftdJ4pIrpK7WSolQH3hs/yj5kyVNvyFwyQ8
         qzKIWfFXLK/aT2dy/rRV4vkEd53yB46YvSRbla3vqlBIqAdybQ0CRAEMeKIOm6fqt5BE
         ozEMcryWwHnnJoBRalhRWxQuKDHvRfUTFV6E40/7CVIAu0g6sK4dzRMQxba1ga/KayQq
         EIaTsj79MrQt2kENVf5iQ0ydgRtx+0kfx5gToeKA0Bd8cnU0pyLET3TTObLvH1MEOlOE
         CYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003805; x=1780608605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kp4nYgBwYqbTZevet3/JvCrzNrQ24lukygwTOrJB7hw=;
        b=CBscjaZee7kcsyghDZ6HcCYxsymY8esTDyHgqucxFJwubejvA/uiUDxnj2xNCVbsqm
         tDeAaI3Rqx4NzOJIEVtSMsZPWJXU5dtxRq84oupEFlgKGZlv47/JzgokaI9oAgQobjuH
         GjqOauRIBIk5P2wlzeuyFZ3lYErgxx3G0ErcLclh9tZy2NzUW9lPWHuhnyeFgBxsfaSi
         myiUnxRD9OBXthOokqNfXpls8genT6pntV9f2eWnegHMgUAcGOTJmdPawlRQUhOlNlmK
         so2mKDk+QGP2ua2c6zsLSSleGlQo8miJanF3uocncbvkObRvgSHufTPRSlcH2CTnEgNC
         Z7aQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eInJJ6Eqd2vlU8FUoT6mw/BcZPRW7xEtURZhvnRox/BUfPTl7/YRi9+jxn/4oZLkh27tvCoQE@vger.kernel.org
X-Gm-Message-State: AOJu0YxEURwuM00vPkM1OTjtONTmySUwHydOd8vqff0RFTnvDdiWt2K1
	w19PyOoPl94LPvWHwsbW+gAhlN8UFarzMZ8zmBzvCoqOdCCbdE/0VXJz
X-Gm-Gg: Acq92OGs636AHkNojI9elcDoGpzs1Z7rxt89W4vF+h9En6olKvce99Sb6AsKPBjgywl
	xT380RYTmeuCt8RHN2Yn3AFK241emgRsr93lNj41TNaR0W1ZVob0tgglARxJVnulcG4cjoX2UY9
	4f77PAcsKspiu9d+RFs/O6mrqodlZ0GKA+X6RsTGOHCEQEqAH+QVNQCxalta9i2hE0GJiT7inzv
	9HHm2dxe2zia6qK9B9/z/GyW35KmuLRUIAMh5JpU/F3cvuXXjBQfC3Lye+xDdJdAnvucGU/NpUS
	9mBNQ+CUUsI0rrQZCNRoSbg8pHMSf9q2KakvD0qR8n7azfBPa98PuxaFRGR+lDLtdHyWNdc2FtJ
	D2q3Jo6eAkQ1lETnyLIngRHIoz2TkcP/Xhgj3HNhs/yioAZul0j8lVohfy4g1o4bGu/neW30GLm
	5Dho9FLMXRWymLZnRlEG2lx9154yCFPd5+w1PjzX4qeRdrqdj0MHYNL26i
X-Received: by 2002:a05:6808:250b:b0:485:542:f905 with SMTP id 5614622812f47-485e6acd9dbmr189559b6e.16.1780003804882;
        Thu, 28 May 2026 14:30:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4855476cbccsm10188560b6e.18.2026.05.28.14.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:30:04 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: kasong@tencent.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	corbet@lwn.net,
	david@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	hughd@google.com,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	lance.yang@linux.dev,
	lenb@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mhocko@suse.com,
	muchun.song@linux.dev,
	npache@redhat.com,
	nphamcs@gmail.com,
	pavel@kernel.org,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	rafael@kernel.org,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	surenb@google.com,
	tglx@kernel.org,
	vbabka@suse.cz,
	weixugc@google.com,
	ying.huang@linux.alibaba.com,
	yosry.ahmed@linux.dev,
	yuanchu@google.com,
	zhengqi.arch@bytedance.com,
	ziy@nvidia.com,
	kernel-team@meta.com,
	riel@surriel.com,
	haowenchao22@gmail.com
Subject: [RFC PATCH 4/5] mm, swap: only charge physical swap entries
Date: Thu, 28 May 2026 14:29:28 -0700
Message-ID: <20260528212955.1912856-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260528212955.1912856-1-nphamcs@gmail.com>
References: <20260528212955.1912856-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	TAGGED_FROM(0.00)[bounces-16407-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: A9D8B5FA6A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Stop double-charging vswap entries against memcg->swap. Previously,
the entry was charged once at vswap allocation (via
mem_cgroup_try_charge_swap) and implicitly again when physical
backing was allocated.

Split the lifecycle into four operations: record the memcg private
ID at vswap alloc without charging; charge memcg->swap only when
physical backing is allocated via folio_realloc_swap; uncharge in
vswap_release_backing (only nr_swapfile entries on v2, all nr on
v1 memsw); and drop the ID ref at __swap_cluster_free_entries
without uncharging.

Direct-mapped physical swap charging is unchanged.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  57 +++++++++++++++++++++
 mm/memcontrol.c      | 118 +++++++++++++++++++++++++++++++++++++++++++
 mm/swapfile.c        | 109 ++++++++++++++++++++++++++++++++++++---
 3 files changed, 276 insertions(+), 8 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3fb55485fc76..6f18ecdf0bb8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -597,6 +597,43 @@ static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 	return __mem_cgroup_try_charge_swap(folio);
 }
 
+extern void __mem_cgroup_record_swap(struct folio *folio);
+static inline void mem_cgroup_record_swap(struct folio *folio)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_record_swap(folio);
+}
+
+extern int __mem_cgroup_charge_backing_phys_swap(struct mem_cgroup *memcg,
+					 unsigned int nr_pages);
+static inline int mem_cgroup_charge_backing_phys_swap(struct mem_cgroup *memcg,
+					      unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return 0;
+	return __mem_cgroup_charge_backing_phys_swap(memcg, nr_pages);
+}
+
+extern void __mem_cgroup_uncharge_backing_phys_swap(struct mem_cgroup *memcg,
+					    unsigned int nr_pages);
+static inline void mem_cgroup_uncharge_backing_phys_swap(struct mem_cgroup *memcg,
+						 unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge_backing_phys_swap(memcg, nr_pages);
+}
+
+extern void __mem_cgroup_id_put_swap(unsigned short id, unsigned int nr_pages);
+static inline void mem_cgroup_id_put_swap(unsigned short id,
+					  unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_id_put_swap(id, nr_pages);
+}
+
 extern void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages);
 static inline void mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages)
 {
@@ -613,6 +650,26 @@ static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 	return 0;
 }
 
+static inline void mem_cgroup_record_swap(struct folio *folio)
+{
+}
+
+static inline int mem_cgroup_charge_backing_phys_swap(struct mem_cgroup *memcg,
+					      unsigned int nr_pages)
+{
+	return 0;
+}
+
+static inline void mem_cgroup_uncharge_backing_phys_swap(struct mem_cgroup *memcg,
+						 unsigned int nr_pages)
+{
+}
+
+static inline void mem_cgroup_id_put_swap(unsigned short id,
+					  unsigned int nr_pages)
+{
+}
+
 static inline void mem_cgroup_uncharge_swap(unsigned short id,
 					    unsigned int nr_pages)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7492879b3239..91618da7ec20 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5513,6 +5513,124 @@ int __mem_cgroup_try_charge_swap(struct folio *folio)
 	return 0;
 }
 
+/**
+ * __mem_cgroup_record_swap - record memcg for swap without charging
+ * @folio: folio being added to swap
+ *
+ * Pin the memcg private ID ref and record it in the swap cgroup table,
+ * but do not charge memcg->swap. Used for vswap entries where the charge
+ * is deferred until physical backing is allocated.
+ */
+void __mem_cgroup_record_swap(struct folio *folio)
+{
+	unsigned int nr_pages = folio_nr_pages(folio);
+	struct swap_cluster_info *ci;
+	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
+
+	if (do_memsw_account())
+		return;
+
+	objcg = folio_objcg(folio);
+	if (!objcg)
+		return;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	if (!folio_test_swapcache(folio)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	memcg = mem_cgroup_private_id_get_online(memcg, nr_pages);
+	rcu_read_unlock();
+
+	ci = swap_cluster_get_and_lock(folio);
+	__swap_cgroup_set(ci, swp_cluster_offset(folio->swap), nr_pages,
+			  mem_cgroup_private_id(memcg));
+	swap_cluster_unlock(ci);
+}
+
+/**
+ * __mem_cgroup_charge_backing_phys_swap - charge memcg->swap counter only
+ * @memcg: the mem_cgroup to charge (may be NULL)
+ * @nr_pages: number of physical swap pages to charge
+ *
+ * Unlike __mem_cgroup_try_charge_swap(), this does NOT touch the memcg
+ * private ID refcount — the ID ref was pinned earlier by
+ * __mem_cgroup_record_swap() at vswap allocation time and lives for the
+ * lifetime of the vswap entry. This helper only updates the swap counter
+ * when a vswap entry transitions to physical backing (folio_realloc_swap),
+ * so the counter and the ID ref can be managed independently.
+ *
+ * The caller resolves the memcg (typically via folio_memcg + ID
+ * comparison to avoid IDR lookups on the hot path).
+ *
+ * Returns 0 on success, -ENOMEM on failure.
+ */
+int __mem_cgroup_charge_backing_phys_swap(struct mem_cgroup *memcg,
+				  unsigned int nr_pages)
+{
+	struct page_counter *counter;
+
+	if (do_memsw_account())
+		return 0;
+	if (!memcg)
+		return 0;
+
+	if (!mem_cgroup_is_root(memcg) &&
+	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
+		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
+		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
+		return -ENOMEM;
+	}
+	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
+	return 0;
+}
+
+/**
+ * __mem_cgroup_uncharge_backing_phys_swap - uncharge memcg->swap counter only
+ * @memcg: the mem_cgroup to uncharge (may be NULL)
+ * @nr_pages: number of physical swap pages to uncharge
+ *
+ * Unlike __mem_cgroup_uncharge_swap(), this does NOT drop the memcg
+ * private ID refcount — that ref is dropped separately via
+ * __mem_cgroup_id_put_swap() when the vswap entry itself is freed.
+ * This helper only updates the swap counter when physical backing is
+ * released (vswap_release_backing), so the counter and ID ref can be
+ * managed independently.
+ */
+void __mem_cgroup_uncharge_backing_phys_swap(struct mem_cgroup *memcg,
+				     unsigned int nr_pages)
+{
+	if (!memcg)
+		return;
+
+	if (!mem_cgroup_is_root(memcg)) {
+		if (do_memsw_account())
+			page_counter_uncharge(&memcg->memsw, nr_pages);
+		else
+			page_counter_uncharge(&memcg->swap, nr_pages);
+	}
+	mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
+}
+
+/**
+ * __mem_cgroup_id_put_swap - drop memcg private ID ref without uncharging
+ * @id: cgroup private id
+ * @nr_pages: number of refs to drop
+ */
+void __mem_cgroup_id_put_swap(unsigned short id, unsigned int nr_pages)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = mem_cgroup_from_private_id(id);
+	if (memcg)
+		mem_cgroup_private_id_put(memcg, nr_pages);
+	rcu_read_unlock();
+}
+
 /**
  * __mem_cgroup_uncharge_swap - uncharge swap space
  * @id: cgroup id to uncharge
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a0976be6a12b..be901fb741e5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -33,6 +33,7 @@
 #include <linux/capability.h>
 #include <linux/syscalls.h>
 #include <linux/memcontrol.h>
+#include "memcontrol-v1.h"
 #include <linux/poll.h>
 #include <linux/oom.h>
 #include <linux/swapfile.h>
@@ -2043,8 +2044,15 @@ int folio_alloc_swap(struct folio *folio)
 			goto again;
 	}
 
-	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
-	if (unlikely(mem_cgroup_try_charge_swap(folio)))
+	/*
+	 * Vswap entries: record memcg ID without charging — the charge is
+	 * deferred to folio_realloc_swap when physical backing is allocated.
+	 * Direct-mapped physical swap entries: charge immediately as today.
+	 */
+	if (folio_test_swapcache(folio) &&
+	    swap_is_vswap(__swap_entry_to_info(folio->swap)))
+		mem_cgroup_record_swap(folio);
+	else if (unlikely(mem_cgroup_try_charge_swap(folio)))
 		swap_cache_del_folio(folio);
 
 	if (unlikely(!folio_test_swapcache(folio)))
@@ -2096,6 +2104,26 @@ static void __swap_cluster_free_phys_backing(struct swap_info_struct *psi,
 					     unsigned int ci_start,
 					     unsigned int nr_pages);
 
+static void vswap_uncharge_cgroup_batch(unsigned short memcg_id,
+					unsigned int batch_nr,
+					unsigned int batch_nr_swapfile)
+{
+	struct mem_cgroup *memcg;
+	unsigned int n;
+
+	if (do_memsw_account())
+		n = batch_nr;
+	else
+		n = batch_nr_swapfile;
+	if (!n)
+		return;
+
+	rcu_read_lock();
+	memcg = memcg_id ? mem_cgroup_from_private_id(memcg_id) : NULL;
+	rcu_read_unlock();
+	mem_cgroup_uncharge_backing_phys_swap(memcg, n);
+}
+
 void vswap_release_backing(struct swap_cluster_info *ci,
 			   unsigned int ci_start, unsigned int nr)
 {
@@ -2106,12 +2134,36 @@ void vswap_release_backing(struct swap_cluster_info *ci,
 	unsigned int ci_off;
 	unsigned long vt;
 	swp_entry_t phys;
+	/*
+	 * Per-cgroup uncharge batching: a single vswap_release_backing
+	 * call can span multiple cgroups (e.g. batched free across
+	 * folios), so we cannot uncharge with the first slot's memcg
+	 * for the whole range.
+	 */
+	unsigned short batch_id;
+	unsigned int batch_nr = 0, batch_nr_swapfile = 0;
 
 	lockdep_assert_held(&ci->lock);
 	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+	batch_id = __swap_cgroup_get(ci, ci_start);
 
 	for (ci_off = ci_start; ci_off < ci_start + nr; ci_off++) {
+		unsigned short cur_id;
+
 		vt = __vtable_get(ci_dyn, ci_off);
+		cur_id = __swap_cgroup_get(ci, ci_off);
+
+		/*
+		 * Flush per-cgroup uncharge when crossing a cgroup boundary.
+		 */
+		if (cur_id != batch_id) {
+			vswap_uncharge_cgroup_batch(batch_id, batch_nr,
+						    batch_nr_swapfile);
+			batch_id = cur_id;
+			batch_nr = 0;
+			batch_nr_swapfile = 0;
+		}
+		batch_nr++;
 
 		/*
 		 * Flush batched physical slots when the next entry
@@ -2135,6 +2187,7 @@ void vswap_release_backing(struct swap_cluster_info *ci,
 
 		switch (vtable_type(vt)) {
 		case VSWAP_SWAPFILE:
+			batch_nr_swapfile++;
 			if (!phys_start) {
 				phys = vtable_to_phys(vt);
 				phys_start = swp_offset(phys);
@@ -2165,6 +2218,9 @@ void vswap_release_backing(struct swap_cluster_info *ci,
 			phys_start % SWAPFILE_CLUSTER,
 			phys_end - phys_start);
 	}
+
+	/* Final cgroup-batch flush. */
+	vswap_uncharge_cgroup_batch(batch_id, batch_nr, batch_nr_swapfile);
 }
 
 void vswap_store_folio(swp_entry_t entry, struct folio *folio)
@@ -2222,7 +2278,9 @@ swp_entry_t folio_realloc_swap(struct folio *folio)
 	swp_entry_t vswap_entry = folio->swap;
 	struct swap_cluster_info *ci;
 	struct swap_cluster_info_dynamic *ci_dyn;
+	struct mem_cgroup *memcg;
 	unsigned int voff;
+	unsigned short memcg_id;
 	swp_entry_t phys_entry = {};
 	swp_entry_t pe;
 	int i, nr = folio_nr_pages(folio);
@@ -2245,9 +2303,33 @@ swp_entry_t folio_realloc_swap(struct folio *folio)
 		return (swp_entry_t){};
 
 	voff = swp_cluster_offset(vswap_entry);
-
 	ci = __swap_entry_to_cluster(vswap_entry);
 	ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+
+	/*
+	 * Resolve the memcg for physical swap charging. Compare
+	 * folio_memcg against the recorded swap memcg ID — on match
+	 * (common case), zero IDR lookups. Only fall back to IDR
+	 * lookup on mismatch (task migrated cgroups).
+	 */
+	spin_lock(&ci->lock);
+	memcg_id = __swap_cgroup_get(ci, voff);
+	spin_unlock(&ci->lock);
+
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	if (!memcg || mem_cgroup_private_id(memcg) != memcg_id)
+		memcg = memcg_id ? mem_cgroup_from_private_id(memcg_id) : NULL;
+	rcu_read_unlock();
+
+	if (mem_cgroup_charge_backing_phys_swap(memcg, nr)) {
+		__swap_cluster_free_phys_backing(
+			__swap_entry_to_info(phys_entry),
+			__swap_entry_to_cluster(phys_entry),
+			swp_cluster_offset(phys_entry), nr);
+		return (swp_entry_t){};
+	}
+
 	spin_lock(&ci->lock);
 	/*
 	 * Install PHYS backing without freeing any prior contents of the
@@ -2468,10 +2550,11 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 	unsigned short batch_id = 0, id_cur;
 	unsigned int ci_off = ci_start, ci_end = ci_start + nr_pages;
 	unsigned int batch_off = ci_off;
+	bool is_vswap = swap_is_vswap(si);
 
 	VM_WARN_ON(ci->count < nr_pages);
 
-	if (swap_is_vswap(si))
+	if (is_vswap)
 		vswap_release_backing(ci, ci_start, nr_pages);
 
 	ci->count -= nr_pages;
@@ -2491,18 +2574,28 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 		/*
 		 * Uncharge swap slots by memcg in batches. Consecutive
 		 * slots with the same cgroup id are uncharged together.
+		 * For vswap, only drop the ID ref — physical swap was
+		 * already uncharged in vswap_release_backing above.
 		 */
 		id_cur = __swap_cgroup_clear(ci, ci_off, 1);
 		if (batch_id != id_cur) {
-			if (batch_id)
-				mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
+			if (batch_id) {
+				if (is_vswap)
+					mem_cgroup_id_put_swap(batch_id, ci_off - batch_off);
+				else
+					mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
+			}
 			batch_id = id_cur;
 			batch_off = ci_off;
 		}
 	} while (++ci_off < ci_end);
 
-	if (batch_id)
-		mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
+	if (batch_id) {
+		if (is_vswap)
+			mem_cgroup_id_put_swap(batch_id, ci_off - batch_off);
+		else
+			mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
+	}
 
 	__swap_cluster_finish_free(si, ci, ci_start, nr_pages);
 }
-- 
2.53.0-Meta


