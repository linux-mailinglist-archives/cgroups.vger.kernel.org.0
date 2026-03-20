Return-Path: <cgroups+bounces-14959-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJbKIQShvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14959-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:33:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 033642E009D
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8192530A1B46
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4CA3F54D3;
	Fri, 20 Mar 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdpdpn3g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F253F166E
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034890; cv=none; b=I7b0GcIpfkCYImTJV1aQn8BOqtt2XbRpsF/7YEGoMGb62HoJ1EBuIQ//nVsEv7pR/glklHTR++JHHamXufQg0AlnSRSCblAtWzDnskiKffnnA0Dralbzpqnc7uNfIrc5Z7xCjerSQAFH/9E/gmmIdmD69l/8EE6Evbrc77PVFzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034890; c=relaxed/simple;
	bh=SJ63GLUGOecatoQ/g009qj/zvLFx7BaJcs4mqiTEjx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPseo0bevxhGGbE1honcMnM2ZS5epukICabeaB6wbng2nYLmn1KT0YlFnI0JZEswUmcyMd2M/O06PpUfbnsSKXBs73HHvqOIeyo72oGCsiQAm8ezKiyFoo6ddsAgOYP74j61Q8N8Vedp39P8olKqwe/su5gNBkDhOXwzsOa0vJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdpdpn3g; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d7f8f0d7c9so363030a34.0
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034884; x=1774639684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDjzYCMXOArzX+CdGGVkkCHbdkQXDMD21rMLRVh2D6Y=;
        b=bdpdpn3g2DbZY+Z631AuZmtzpeNyn9UZU1ZBriZmpOtq3xoJK7+ETde6ABpo0wtAaE
         DvyvlqKPMJ9U0iwqeXZ6ioGpFEDv1tqtvFcMyL9ZCfa4RdbCe4RfwgOr/coSZoWF202l
         lB4NMEEEE/ek57JMdEIJfUtOYQ+1mKmKdNryQdBO06PhAGFC0BckU0sTsyRiJC4NT+ae
         xwYxxKQfBl6r4QeBgwOC+ST4S0ZVvcUkZsGSLQ9mmyxPbrKT7+r0BcdredmrEygf2VVY
         ubI4ntVCw3s9j4m3mo41KZym60+XM43pZvzZXphkayJ+PJBdm4NF484u3DROuI/V9YEE
         lvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034884; x=1774639684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDjzYCMXOArzX+CdGGVkkCHbdkQXDMD21rMLRVh2D6Y=;
        b=qabz+3G+aBV1jHPxdBcAgN07YcSF0Ba9EEn2+xGlRsOTDK+hhuR+heJlKCuIweyG3p
         nNWnJxl9ecuewg7tf7D9Dy4oSvyIC4D55rYXn/YImZ057+nMt4SkYutourDvhEgHIk6A
         35mfA4f+zUvdrBTNGbCg7Y9mOdqSKRdKQQ9txppVKBlml8o3XHoJgA0gJYbAk+k7WaRp
         6hHQlL+ZTk/iyiKd+Icpb/1Xer9qEfXNzhQ9Bsenxbwjj1ZDCwnRqr4dkaGKXoc+u0Ns
         tIlWZC2ePeRM97j9hAJkD6zFhkZm42TA+9TGhIXZLwAdnV+QXGZjCXvc16r0SBVYKLG2
         PPpw==
X-Forwarded-Encrypted: i=1; AJvYcCVaT16UdQEMPtH484Vwc8YyDfzUg8a0GEb13Kp418RhFnOtnIkUdQH+smoqj9dxbN+la8BB6q40@vger.kernel.org
X-Gm-Message-State: AOJu0YyLEERx3VkdDwP6W89ke+7lxdNYj2ol0IXSuqrZrmJm4R91lzq7
	mLFI1zcmiBKiWEIMn5dYv1RgUzpja9OHT3bMUb/7wK1b7fiY09UKsvK5
X-Gm-Gg: ATEYQzyY4kaYi0VUSokTgmlN+4tWLlFstfGUF5fuXeJhiYpwOVUCs4y103c7NfDAsqO
	XehWlc5ozPfquBYwvHRp/bYDR8AOcoHt6MoJngatckfvO3m0+ATCerA7bRVFhJ/7m9vmrwqM0r/
	4dhNmwvEBExPVFxUKDY7r/Sy6byuehRFi7l4LAMJyF8R0VYYFr+URGBgAQmZ5+zHn9bWc9yQurP
	lnIiiR934m7uVHs0qca45FKjwLjGwgTVz81YPyrIhskDEEEAWHxls2qS7rwYV9emNTFV2Dz3KjV
	ePJeTdywmRe2yNWcf4BhcNIWhUvqa7wmXrp0Ntrf1SHxu7ULWudVdGYZfMmQlAPYzb2zT/Knv+S
	jzc8dcgApok3/b1bhKAb0PjD7DpxLrmu3vYPQKp5cuOHZguC+17E6AEAoB/Jbjz5ez5fDc5KpPg
	KAWo/56fV8sRxkLlEHeLch4tnjPE2h/gPNvFEZxOW6nFW7Tw==
X-Received: by 2002:a05:6830:82d4:b0:7d7:f90c:5833 with SMTP id 46e09a7af769-7d7f90c6a69mr1201918a34.27.1774034884181;
        Fri, 20 Mar 2026 12:28:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eac17471sm3081723a34.7.2026.03.20.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:28:03 -0700 (PDT)
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
	riel@surriel.com
Subject: [PATCH v5 18/21] memcg: swap: only charge physical swap slots
Date: Fri, 20 Mar 2026 12:27:32 -0700
Message-ID: <20260320192735.748051-19-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14959-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 033642E009D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that zswap and the zero-filled swap page optimization no longer
takes up any physical swap space, we should not charge towards the swap
usage and limits of the memcg in these case. We will only record the
memcg id on virtual swap slot allocation, and defer physical swap
charging (i.e towards memory.swap.current) until the virtual swap slot
is backed by an actual physical swap slot (on zswap store failure
fallback or zswap writeback).

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h | 26 ++++++++++++++
 mm/memcontrol-v1.c   |  6 ++++
 mm/memcontrol.c      | 83 ++++++++++++++++++++++++++++++++------------
 mm/vswap.c           | 39 +++++++++------------
 4 files changed, 108 insertions(+), 46 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index cc1ca4ac2946d..21e528d8d3480 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -676,6 +676,22 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 #endif
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
+void __mem_cgroup_record_swap(struct folio *folio, swp_entry_t entry);
+static inline void mem_cgroup_record_swap(struct folio *folio,
+		swp_entry_t entry)
+{
+	if (!mem_cgroup_disabled())
+		__mem_cgroup_record_swap(folio, entry);
+}
+
+void __mem_cgroup_clear_swap(swp_entry_t entry, unsigned int nr_pages);
+static inline void mem_cgroup_clear_swap(swp_entry_t entry,
+		unsigned int nr_pages)
+{
+	if (!mem_cgroup_disabled())
+		__mem_cgroup_clear_swap(entry, nr_pages);
+}
+
 int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
 		swp_entry_t entry)
@@ -696,6 +712,16 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct folio *folio);
 #else
+static inline void mem_cgroup_record_swap(struct folio *folio,
+					     swp_entry_t entry)
+{
+}
+
+static inline void mem_cgroup_clear_swap(swp_entry_t entry,
+					     unsigned int nr_pages)
+{
+}
+
 static inline int mem_cgroup_try_charge_swap(struct folio *folio,
 					     swp_entry_t entry)
 {
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 7b010e165e1ba..12bc5c680b03a 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -680,6 +680,12 @@ void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
 		mem_cgroup_uncharge_swap(entry, nr_pages);
+
+		/*
+		 * Clear the cgroup association now to prevent double memsw
+		 * uncharging when the backends are released later.
+		 */
+		mem_cgroup_clear_swap(entry, nr_pages);
 	}
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2ba5811e7edba..4525c21754e7f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5172,6 +5172,49 @@ int __init mem_cgroup_init(void)
 }
 
 #ifdef CONFIG_SWAP
+/**
+ * __mem_cgroup_record_swap - record the folio's cgroup for the swap entries.
+ * @folio: folio being swapped out.
+ * @entry: the first swap entry in the range.
+ */
+void __mem_cgroup_record_swap(struct folio *folio, swp_entry_t entry)
+{
+	unsigned int nr_pages = folio_nr_pages(folio);
+	struct mem_cgroup *memcg;
+
+	/* Recording will be done by memcg1_swapout(). */
+	if (do_memsw_account())
+		return;
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
+/**
+ * __mem_cgroup_clear_swap - clear cgroup information of the swap entries.
+ * @entry: the first swap entry in the range.
+ * @nr_pages: the number of pages in the range.
+ */
+void __mem_cgroup_clear_swap(swp_entry_t entry, unsigned int nr_pages)
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
@@ -5190,34 +5233,24 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	if (do_memsw_account())
 		return 0;
 
-	memcg = folio_memcg(folio);
-
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
-		return 0;
-
-	if (!entry.val) {
-		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		return 0;
-	}
-
-	memcg = mem_cgroup_id_get_online(memcg);
+	/*
+	 * We already record the cgroup on virtual swap allocation.
+	 * Note that the virtual swap slot holds a reference to memcg,
+	 * so this lookup should be safe.
+	 */
+	rcu_read_lock();
+	memcg = mem_cgroup_from_id(lookup_swap_cgroup_id(entry));
+	rcu_read_unlock();
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		mem_cgroup_id_put(memcg);
 		return -ENOMEM;
 	}
 
-	/* Get references for the tail pages, too */
-	if (nr_pages > 1)
-		mem_cgroup_id_get_many(memcg, nr_pages - 1);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
 
-	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
-
 	return 0;
 }
 
@@ -5231,7 +5264,8 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
-	id = swap_cgroup_clear(entry, nr_pages);
+	id = lookup_swap_cgroup_id(entry);
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
 	if (memcg) {
@@ -5242,7 +5276,6 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 				page_counter_uncharge(&memcg->swap, nr_pages);
 		}
 		mod_memcg_state(memcg, MEMCG_SWAP, -nr_pages);
-		mem_cgroup_id_put_many(memcg, nr_pages);
 	}
 	rcu_read_unlock();
 }
@@ -5251,14 +5284,18 @@ static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg);
 
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages, nr_zswap_pages = 0;
+	long nr_swap_pages;
 
 	if (zswap_is_enabled() && (mem_cgroup_disabled() || do_memsw_account() ||
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
index 1040bb8a9f320..fa37165cb10d0 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -544,6 +544,7 @@ static void release_backing(swp_entry_t entry, int nr)
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
+	unsigned long phys_swap_released = 0;
 	unsigned int phys_swap_type = 0;
 	bool need_flushing_phys_swap = false;
 	swp_slot_t flush_slot;
@@ -573,6 +574,7 @@ static void release_backing(swp_entry_t entry, int nr)
 		if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
 			zswap_entry_free(desc->zswap_entry);
 		} else if (desc->type == VSWAP_SWAPFILE) {
+			phys_swap_released++;
 			if (!phys_swap_start) {
 				/* start a new contiguous range of phys swap */
 				phys_swap_start = swp_slot_offset(desc->slot);
@@ -603,6 +605,9 @@ static void release_backing(swp_entry_t entry, int nr)
 		flush_nr = phys_swap_end - phys_swap_start;
 		swap_slot_free_nr(flush_slot, flush_nr);
 	}
+
+	if (phys_swap_released)
+		mem_cgroup_uncharge_swap(entry, phys_swap_released);
 }
 
 /*
@@ -630,7 +635,7 @@ static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 	spin_unlock(&cluster->lock);
 
 	release_backing(entry, 1);
-	mem_cgroup_uncharge_swap(entry, 1);
+	mem_cgroup_clear_swap(entry, 1);
 
 	/* erase forward mapping and release the virtual slot for reallocation */
 	spin_lock(&cluster->lock);
@@ -645,9 +650,6 @@ static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
  */
 int folio_alloc_swap(struct folio *folio)
 {
-	struct vswap_cluster *cluster = NULL;
-	int i, nr = folio_nr_pages(folio);
-	struct swp_desc *desc;
 	swp_entry_t entry;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -657,25 +659,7 @@ int folio_alloc_swap(struct folio *folio)
 	if (!entry.val)
 		return -ENOMEM;
 
-	/*
-	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
-	 * swap slots allocation. This will be changed soon - we will only charge on
-	 * physical swap slots allocation.
-	 */
-	if (mem_cgroup_try_charge_swap(folio, entry)) {
-		rcu_read_lock();
-		for (i = 0; i < nr; i++) {
-			desc = vswap_iter(&cluster, entry.val + i);
-			VM_WARN_ON(!desc);
-			vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
-		}
-		spin_unlock(&cluster->lock);
-		rcu_read_unlock();
-		atomic_add(nr, &vswap_alloc_reject);
-		entry.val = 0;
-		return -ENOMEM;
-	}
-
+	mem_cgroup_record_swap(folio, entry);
 	swap_cache_add_folio(folio, entry, NULL);
 
 	return 0;
@@ -717,6 +701,15 @@ bool vswap_alloc_swap_slot(struct folio *folio)
 	if (!slot.val)
 		return false;
 
+	if (mem_cgroup_try_charge_swap(folio, entry)) {
+		/*
+		 * We have not updated the backing type of the virtual swap slot.
+		 * Simply free up the physical swap slots here!
+		 */
+		swap_slot_free_nr(slot, nr);
+		return false;
+	}
+
 	/* establish the vrtual <-> physical swap slots linkages. */
 	si = __swap_slot_to_info(slot);
 	ci = swap_cluster_lock(si, swp_slot_offset(slot));
-- 
2.52.0


