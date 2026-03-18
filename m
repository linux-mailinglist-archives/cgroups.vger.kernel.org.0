Return-Path: <cgroups+bounces-14899-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH1OJUsou2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14899-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:33:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E262C376A
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9611B3088EEE
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BEF3B0AFD;
	Wed, 18 Mar 2026 22:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYIZSCXG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9B3A784B
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873030; cv=none; b=P35ucbd/sbMNlvCsvEDR+Jd52+AYSEnAeI9QCo9X1pkYbIpUIbaZbSnjJkmcrsfLFpJaue+ph21J6v3OVUeDitOyxS4ixKscmLwU9Q4sgGF5/9TG2wPioiv/SII4H31E0JUpjVOy5gUM2nVFKk3+Chv3thyMJt8AJ/652qy9nbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873030; c=relaxed/simple;
	bh=SLWNcExtGBAna8TNO7YxdDa/Na9CfEEr7Lzcl87e66I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfEIo6UacqhfUTYcTHsg6qpGyi7BM9w6bV0txywxFBtlGcXPcgy/bvk5Nt2OjGqfuL78BdYQFuTHUFjbpOnBu40tntkJnAzFNrMPdkCoBsi6/lR3eNeqTDSepgmxFIbhiDa3YHp5inoqIoO9J9XiNMojwKXwdih9I4/+sAdgi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYIZSCXG; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7d74c1157a4so46879a34.1
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873026; x=1774477826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESVpGQYFBCiWMDqw6fxjJx7j9Ms0hezUwaEqwm+xWcM=;
        b=DYIZSCXGLo+eNKPzkI2VnozKMlrndBhDN43G9C4dKzmCKuC7EV3YktW8tup6y5Ok7r
         GlGM9SYQlnZ3zpeHSdHlnTrxKgoogGNaXTgcgZuSyAtbg5GS3WYWfjNGqimk4EQbbdGw
         Zczm2g5AAKwVWFWHbxuEoYzhmaL1nHooxE7lmjDpkOwH6A6TmRaAcjEfZUQlY384HZTx
         XcPy491MlFtKcxXjXRGWnDnaF66LFWlrWOYJvo8yUD+AjMXHCyqBfxUwZYr5Xvl7apj0
         VicV+Hun2PiPWd1lKN4mG1nPRQE5VUK4DEGCjCS2Ln61LEYEfjN0LBVQAJ0c9bSEJ63t
         Fhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873026; x=1774477826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESVpGQYFBCiWMDqw6fxjJx7j9Ms0hezUwaEqwm+xWcM=;
        b=WaszTsXtBpws5vhTCMN56Z30iZkaahRwuESbTxHFYiFOiBSbiyk9viX5KPKySRIgpo
         O0B/b7cmU1AYXLVzE+9/FbUnl4FoewWXB+/XeBe2eGyKyM5tNEUMvn9MsJ71grNA4eFW
         tg64jC04g7uAVYS491EIgKfy2KcMKH5P59nPEuHGuDx2jsZO8sYcbTvtuoBzwt00yH+a
         cd2KWaT1cgH+92ykZNwZOMeYo3l1AyZxnjqJkfn1zm+A+SfZ+8ZAt4EKjBDIwRX1WM8O
         eiBQ7w6taR2RDQaF/27qsQxroX0czKNuokn0Nu8iBVhC40WoZEWAF9ZOnbE6Ppk1ekl6
         YWbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm48qzNqtKJqq8/E0IldBgIiMt2g1K7haGQw7B7DS1HwF1fFScVGraxESO24RyURXno2jXeLzY@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Wm2HymEwQh27rTwSZoyoHh5DtSt4StdObMwSuAIbDA6CkDjb
	ywkJHJnMd3GrEa0BxSSZL+7OHx67hV9gSKNSb2U/98np9D77p96X8oTp
X-Gm-Gg: ATEYQzxvsNHk2Rpzv4/J3GKHsfdTquZIbMLhsRUyVEzauJiARCC1FCMSdYlDhq50PcM
	nr/0DLTFcMVjhVPQGTcfP+BYSORnEIsd6Tx9fLgv0ZHV6ke/XZjqszguUHW1mW3BO8RfEL4ZW7e
	sPDiEWy0FrmdgoRvbRIsUM2aChma6jFq+sZtZ0l2xxYYQsHctQjhlPMhDgM8kROc5mrnSBtcGKB
	Uhi+XE/eHSQQVZiSrveFciV7Tls7UOwWNsaON158M/8Ub7ZK+robzRYcrh6vAqk1Qf3umXqDRai
	UMFWDdsan9UvRYesALktUj407ewGE4nMheWPoPp1y6FWN+0pOyLF5UkyZNn1N12E5h0arrp4Dni
	9KBvyqAWh42GXa9cV1WzQITOu9XIzikfkT3gXqq3SM/LL0yhtaSoWE7Itlss0/s7oC9vCc0E6Cw
	SYXRbbzOXjCFhGOQodYJRGiGGw7GrRQcLRtOLWo+1NV+d5CA==
X-Received: by 2002:a05:6830:4985:b0:7d7:4aa5:521c with SMTP id 46e09a7af769-7d7ca6bb6edmr3479621a34.21.1773873026118;
        Wed, 18 Mar 2026 15:30:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b837f0sm2976890a34.21.2026.03.18.15.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:24 -0700 (PDT)
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
Subject: [PATCH v4 18/21] memcg: swap: only charge physical swap slots
Date: Wed, 18 Mar 2026 15:29:49 -0700
Message-ID: <20260318222953.441758-19-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318222953.441758-1-nphamcs@gmail.com>
References: <20260318222953.441758-1-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14899-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.874];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48E262C376A
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
index 6eed14bff7426..4580a034dcf72 100644
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
index b391511e0f0b9..96f4615f29a95 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -544,6 +544,7 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
 	unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
+	unsigned long phys_swap_released = 0;
 	unsigned int phys_swap_type = 0;
 	bool need_flushing_phys_swap = false;
 	swp_slot_t flush_slot;
@@ -573,6 +574,7 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 		if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
 			zswap_entry_free(desc->zswap_entry);
 		} else if (desc->type == VSWAP_SWAPFILE) {
+			phys_swap_released++;
 			if (!phys_swap_start) {
 				/* start a new contiguous range of phys swap */
 				phys_swap_start = swp_slot_offset(desc->slot);
@@ -603,6 +605,9 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
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


