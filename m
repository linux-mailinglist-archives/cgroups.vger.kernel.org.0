Return-Path: <cgroups+bounces-13786-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEvwAKgHiWnK1QQAu9opvQ
	(envelope-from <cgroups+bounces-13786-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:01:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA3210A55E
	for <lists+cgroups@lfdr.de>; Sun, 08 Feb 2026 23:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7217301022C
	for <lists+cgroups@lfdr.de>; Sun,  8 Feb 2026 21:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC036072E;
	Sun,  8 Feb 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AM7xwZHD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBCB34FF67
	for <cgroups@vger.kernel.org>; Sun,  8 Feb 2026 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770587955; cv=none; b=o5bW8WJyZLwD8tpWXfAl465db1RaRq7gIWgugZ1i+7SBr9w0UV1gFbuOg4WgGBaCmzNBH1wsnkgZUQPRImF3nEcvfvb4a16KfPzAeJwmeTLDcQUCYHAQ6a7dM6S+l57fV8y0Bme8AFb54i7ys/bU3iRXVAHhxSebx3yNsn3+UeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770587955; c=relaxed/simple;
	bh=vWlPyTOaBTunUX0BNNJOtxtXZN+2/4+4XM8QxVMmPhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qee3ZmqsyHX7QQeTtw9KpDQkxoXoIzwabWGfivFaBVlDGDH7nJioGvy42XorXeGIopQ2tSCGkhTujR5176fi0AQ6RnF11XwvjCDKqAg46kSrFzCGf2I0L/zLB48jK0gMzc506e0MiBO8VwcZTx+lcSrYNxrwM0MvY22xioiS/dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AM7xwZHD; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d18d0e6d71so1621996a34.1
        for <cgroups@vger.kernel.org>; Sun, 08 Feb 2026 13:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770587951; x=1771192751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruceNSX4J0gFFUSUTt6Ls7KI6XV9ahGZQUD7Wf6LUkY=;
        b=AM7xwZHD89tEZOV6pjR8Qw/NK/16Vnt0H62jOzlWB6n2IYfP+8O10l5tar34T2Xdgn
         PfA8KBW3HT6BmBr9u7RgfFh0XAA7KwadYHyfuPwtYQ3RwZxOB3rSWpjNWX1O3o/9R2U7
         hwvYNl75cY2YyZz5xfAqsSt7k7PspZQaLdhbJUGvH3NYZKM10hq0gxZeWcqCAIcpGb5M
         nnXog8zfpbpnQ7bnfrOOYt7nefAd5jE6AzzNWOZF9padm8ZIy33WbApeoJGfTqaSnHnt
         sUaxNTdmWWiinyzYIaG2nqcOw46mCyA08r2BUW+Ue9cREcs2cZYoZo7sRRyixlnbZ3U8
         bRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770587951; x=1771192751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ruceNSX4J0gFFUSUTt6Ls7KI6XV9ahGZQUD7Wf6LUkY=;
        b=t1ToNo+pD0BqrwEUYeOV3sWp9RUcSJWsJJY2db2sxpxyvq5tWfmrqlFyRSbkhKeyD5
         CB1ylMvG3jRo6IAgwVcPkfMifczBD9NSN8wIxgIyQJ1LbizLUZa7jh6jw/bS5lS90+mY
         vDHIr7XScpkJFm1smJRdQU3IjHlDydKK3w/OeR90v1/J9oSZchRWrlxlzoGPKpPLnWGp
         E9jFp51/SAoP6Mfam0BXNhJyCrwQIfRaFYXaNaqNw5Xr6hzcfrc3uMyxRtcudC5Zjx8w
         H69TZoR87HvWUNZsRVxL8IujTFSPd6DpLJa+tMrWzJcuQx57xp9sWYEFIdKvugScHR/v
         6C9w==
X-Forwarded-Encrypted: i=1; AJvYcCWZL/faG0FSKy1veNCcE97qp3ZHIwapRQtoohdMG8OyiTEZMFyJiTW0KtonrRPCH7RCOJQVHKRC@vger.kernel.org
X-Gm-Message-State: AOJu0YyoKtiABWo8cUZp+hf2mnmpWDoMFDXNJ6/LYFWSsJP8LFf5eZIL
	GCeKKo9P6lJ66aPqy6eY42ovM+UnPBcSncGP1n7Ml+MzJYPgU0XoR82Q
X-Gm-Gg: AZuq6aK8yJNU0kZar32LJ2diRYYZE8yY/XTSJ4HfPhqiq5vjUuuveDtRUkvb0xP/kfh
	HbB0C1b7WWYgTPrxXw7VojQGq9gcZltXes08yoKRg4dzIGwD3SIzD+sZNDB8i41eN/Imnu5bfOm
	MIeHvDOMyX+5RmzdQ9ASlPGY1JlsnLeQP7UH1Rjyaz7A0N8x2uss3B+VUVBXfNhrH/eQ5gPzkpm
	431ISciFtnJhtdrdNt1O3R2loNjWELPHIS39nOmz/tCO+s71OFZStveMmkX73gIELvLVU0O3FFE
	86ptTmInbTDuHjbWU7bQuI58vgigeXvpbADp71y70nts7ubVqZz/qlAmLhz0jMWBcmPM3TCa5Zs
	rmyWZFwCvJ4cWVkGV6efInnBZoZdR5xZvham/NhW3zQyF6cnBJSm/Y1s63zuW4eyKXV9TH016ra
	sJ3Z6nEpAoaspF34U7jmITdWHHY6BrogDrtw==
X-Received: by 2002:a05:6830:628c:b0:7d1:9217:94e with SMTP id 46e09a7af769-7d464489f8dmr5885223a34.26.1770587951179;
        Sun, 08 Feb 2026 13:59:11 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d46470da04sm6394262a34.7.2026.02.08.13.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 13:59:10 -0800 (PST)
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
	shikemeng@huaweicloud.com,
	viro@zeniv.linux.org.uk,
	baohua@kernel.org,
	bhe@redhat.com,
	osalvador@suse.de,
	lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	pavel@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org,
	peterx@redhat.com,
	riel@surriel.com,
	joshua.hahnjy@gmail.com,
	npache@redhat.com,
	gourry@gourry.net,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	rafael@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	zhengqi.arch@bytedance.com
Subject: [PATCH v3 14/20] mm: swap: decouple virtual swap slot from backing store
Date: Sun,  8 Feb 2026 13:58:27 -0800
Message-ID: <20260208215839.87595-15-nphamcs@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[linux-foundation.org,cmpxchg.org,google.com,linux.dev,kernel.org,intel.com,tencent.com,gmail.com,arm.com,huaweicloud.com,zeniv.linux.org.uk,redhat.com,suse.de,oracle.com,csgroup.eu,meta.com,vger.kernel.org,surriel.com,gourry.net,bytedance.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13786-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BEA3210A55E
X-Rspamd-Action: no action

This patch presents the first real use case of the new virtual swap
design. It leverages the virtualization of the swap space to decouple a
swap entry and its backing storage. A swap entry can now be backed by
one of the following options:

1. A physical swap slot (i.e on a physical swapfile/swap partition).
2. A "zero swap page", i.e the swapped out page is a zero page.
3. A compressed object in the zswap pool.
4. An in-memory page. This can happen when a page is loaded
   (exclusively) from the zswap pool, or if the page is rejected by
   zswap and zswap writeback is disabled.

This allows us to use zswap and the zero swap page optimization, without
having to reserved a slot on a swapfile, or a swapfile at all. This
translates to tens to hundreds of GBs of disk saving on hosts and
workloads that have high memory usage, as well as removes this spurious
limit on the usage of these optimizations.

One implication of this change is that we need to be much more careful
with THP swapin and batched swap free operations. The central
requirement is the range of entries we are working with must
have no mixed backing states:

1. For now, zswap-backed entries are not supported for these batched
   operations.
2. All the entries must be backed by the same type.
3. If the swap entries in the batch are backed by in-memory folio, it
   must be the same folio (i.e they correspond to the subpages of that
   folio).
4. If the swap entries in the batch are backed by slots on swapfiles, it
   must be the same swapfile, and these physical swap slots must also be
   contiguous.

For now, we still charge virtual swap slots towards the memcg's swap
usage. In a following patch, we will change this behavior and only
charge physical (i.e on swapfile) swap slots towards the memcg's swap
usage.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h  |  14 +
 include/linux/zswap.h |   3 +-
 mm/internal.h         |  14 +-
 mm/memcontrol.c       |  65 +++--
 mm/memory.c           |  84 ++++--
 mm/page_io.c          |  74 ++---
 mm/shmem.c            |   6 +-
 mm/swap.h             |  32 +--
 mm/swap_state.c       |  29 +-
 mm/swapfile.c         |   8 -
 mm/vmscan.c           |  19 +-
 mm/vswap.c            | 638 ++++++++++++++++++++++++++++++++++--------
 mm/zswap.c            |  45 ++-
 13 files changed, 729 insertions(+), 302 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index aae2e502d9975..54df972608047 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -658,12 +658,26 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 
 int vswap_init(void);
 void vswap_exit(void);
+bool vswap_alloc_swap_slot(struct folio *folio);
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry);
 swp_entry_t swp_slot_to_swp_entry(swp_slot_t slot);
 bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si);
 void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si);
 bool folio_swapped(struct folio *folio);
 bool vswap_only_has_cache(swp_entry_t entry, int nr);
+int non_swapcache_batch(swp_entry_t entry, int nr);
+bool vswap_swapfile_backed(swp_entry_t entry, int nr);
+bool vswap_folio_backed(swp_entry_t entry, int nr);
+void vswap_store_folio(swp_entry_t entry, struct folio *folio);
+void swap_zeromap_folio_set(struct folio *folio);
+void vswap_assoc_zswap(swp_entry_t entry, struct zswap_entry *zswap_entry);
+bool vswap_can_swapin_thp(swp_entry_t entry, int nr);
 
+static inline struct swap_info_struct *vswap_get_device(swp_entry_t entry)
+{
+	swp_slot_t slot = swp_entry_to_swp_slot(entry);
+
+	return slot.val ? swap_slot_tryget_swap_info(slot) : NULL;
+}
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 07b2936c38f29..f33b4433a5ee8 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -33,9 +33,8 @@ void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
 bool zswap_never_enabled(void);
-void *zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry);
+void zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry);
 void *zswap_entry_load(swp_entry_t swpentry);
-void *zswap_entry_erase(swp_entry_t swpentry);
 bool zswap_empty(swp_entry_t swpentry);
 void zswap_entry_free(struct zswap_entry *entry);
 
diff --git a/mm/internal.h b/mm/internal.h
index 7ced0def684ca..cfe97501e4885 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -327,19 +327,7 @@ static inline swp_entry_t swap_nth(swp_entry_t entry, long n)
 	return (swp_entry_t) { entry.val + n };
 }
 
-/* similar to swap_nth, but check the backing physical slots as well. */
-static inline swp_entry_t swap_move(swp_entry_t entry, long delta)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry), next_slot;
-	swp_entry_t next_entry = swap_nth(entry, delta);
-
-	next_slot = swp_entry_to_swp_slot(next_entry);
-	if (swp_slot_type(slot) != swp_slot_type(next_slot) ||
-			swp_slot_offset(slot) + delta != swp_slot_offset(next_slot))
-		next_entry.val = 0;
-
-	return next_entry;
-}
+swp_entry_t swap_move(swp_entry_t entry, long delta);
 
 /**
  * pte_move_swp_offset - Move the swap entry offset field of a swap pte
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 86f43b7e5f710..2ba5811e7edba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5247,10 +5247,18 @@ void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	rcu_read_unlock();
 }
 
+static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg);
+
 long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
-	long nr_swap_pages = get_nr_swap_pages();
+	long nr_swap_pages, nr_zswap_pages = 0;
+
+	if (zswap_is_enabled() && (mem_cgroup_disabled() || do_memsw_account() ||
+				mem_cgroup_may_zswap(memcg))) {
+		nr_zswap_pages = PAGE_COUNTER_MAX;
+	}
 
+	nr_swap_pages = max_t(long, nr_zswap_pages, get_nr_swap_pages());
 	if (mem_cgroup_disabled() || do_memsw_account())
 		return nr_swap_pages;
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg))
@@ -5419,6 +5427,29 @@ static struct cftype swap_files[] = {
 };
 
 #ifdef CONFIG_ZSWAP
+static bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg)
+{
+	struct mem_cgroup *memcg;
+
+	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
+	     memcg = parent_mem_cgroup(memcg)) {
+		unsigned long max = READ_ONCE(memcg->zswap_max);
+		unsigned long pages;
+
+		if (max == PAGE_COUNTER_MAX)
+			continue;
+		if (max == 0)
+			return false;
+
+		/* Force flush to get accurate stats for charging */
+		__mem_cgroup_flush_stats(memcg, true);
+		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
+		if (pages >= max)
+			return false;
+	}
+	return true;
+}
+
 /**
  * obj_cgroup_may_zswap - check if this cgroup can zswap
  * @objcg: the object cgroup
@@ -5433,34 +5464,15 @@ static struct cftype swap_files[] = {
  */
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
-	struct mem_cgroup *memcg, *original_memcg;
+	struct mem_cgroup *memcg;
 	bool ret = true;
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return true;
 
-	original_memcg = get_mem_cgroup_from_objcg(objcg);
-	for (memcg = original_memcg; !mem_cgroup_is_root(memcg);
-	     memcg = parent_mem_cgroup(memcg)) {
-		unsigned long max = READ_ONCE(memcg->zswap_max);
-		unsigned long pages;
-
-		if (max == PAGE_COUNTER_MAX)
-			continue;
-		if (max == 0) {
-			ret = false;
-			break;
-		}
-
-		/* Force flush to get accurate stats for charging */
-		__mem_cgroup_flush_stats(memcg, true);
-		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
-		if (pages < max)
-			continue;
-		ret = false;
-		break;
-	}
-	mem_cgroup_put(original_memcg);
+	memcg = get_mem_cgroup_from_objcg(objcg);
+	ret = mem_cgroup_may_zswap(memcg);
+	mem_cgroup_put(memcg);
 	return ret;
 }
 
@@ -5604,6 +5616,11 @@ static struct cftype zswap_files[] = {
 	},
 	{ }	/* terminate */
 };
+#else
+static inline bool mem_cgroup_may_zswap(struct mem_cgroup *original_memcg)
+{
+	return false;
+}
 #endif /* CONFIG_ZSWAP */
 
 static int __init mem_cgroup_swap_init(void)
diff --git a/mm/memory.c b/mm/memory.c
index 641e3f65edc00..a16bf84ebaaf9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4362,6 +4362,15 @@ static inline bool should_try_to_free_swap(struct folio *folio,
 	if (mem_cgroup_swap_full(folio) || (vma->vm_flags & VM_LOCKED) ||
 	    folio_test_mlocked(folio))
 		return true;
+
+	/*
+	 * Mixed and/or non-swapfile backends cannot be re-used for future swapouts
+	 * anyway. Try to free swap space unless the folio is backed by contiguous
+	 * physical swap slots.
+	 */
+	if (!vswap_swapfile_backed(folio->swap, folio_nr_pages(folio)))
+		return true;
+
 	/*
 	 * If we want to map a page that's in the swapcache writable, we
 	 * have to detect via the refcount if we're really the exclusive
@@ -4623,12 +4632,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	struct folio *swapcache, *folio = NULL;
 	DECLARE_WAITQUEUE(wait, current);
 	struct page *page;
-	struct swap_info_struct *si = NULL;
+	struct swap_info_struct *si = NULL, *stable_si;
 	rmap_t rmap_flags = RMAP_NONE;
 	bool need_clear_cache = false;
 	bool swapoff_locked = false;
 	bool exclusive = false;
-	softleaf_t entry;
+	softleaf_t orig_entry, entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
@@ -4641,6 +4650,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out;
 
 	entry = softleaf_from_pte(vmf->orig_pte);
+	/*
+	 * entry might change if we get a large folio - remember the original entry
+	 * for unlocking swapoff etc.
+	 */
+	orig_entry = entry;
 	if (unlikely(!softleaf_is_swap(entry))) {
 		if (softleaf_is_migration(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
@@ -4705,7 +4719,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	swapcache = folio;
 
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
+		if (si && data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
 		    __swap_count(entry) == 1) {
 			/* skip swapcache */
 			folio = alloc_swap_folio(vmf);
@@ -4736,6 +4750,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				}
 				need_clear_cache = true;
 
+				/*
+				 * Recheck to make sure the entire range is still
+				 * THP-swapin-able. Note that before we call
+				 * swapcache_prepare(), entries in the range can
+				 * still have their backing status changed.
+				 */
+				if (!vswap_can_swapin_thp(entry, nr_pages)) {
+					schedule_timeout_uninterruptible(1);
+					goto out_page;
+				}
+
 				memcg1_swapin(entry, nr_pages);
 
 				shadow = swap_cache_get_shadow(entry);
@@ -4916,27 +4941,40 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			 * swapcache -> certainly exclusive.
 			 */
 			exclusive = true;
-		} else if (exclusive && folio_test_writeback(folio) &&
-			  data_race(si->flags & SWP_STABLE_WRITES)) {
+		} else if (exclusive && folio_test_writeback(folio)) {
 			/*
-			 * This is tricky: not all swap backends support
-			 * concurrent page modifications while under writeback.
-			 *
-			 * So if we stumble over such a page in the swapcache
-			 * we must not set the page exclusive, otherwise we can
-			 * map it writable without further checks and modify it
-			 * while still under writeback.
+			 * We need to look up the swap device again here, because
+			 * the si we got from tryget_swap_entry() might have changed
+			 * before we pin the backend.
 			 *
-			 * For these problematic swap backends, simply drop the
-			 * exclusive marker: this is perfectly fine as we start
-			 * writeback only if we fully unmapped the page and
-			 * there are no unexpected references on the page after
-			 * unmapping succeeded. After fully unmapped, no
-			 * further GUP references (FOLL_GET and FOLL_PIN) can
-			 * appear, so dropping the exclusive marker and mapping
-			 * it only R/O is fine.
+			 * With the folio locked and loaded into the swap cache, we can
+			 * now guarantee a stable backing state.
 			 */
-			exclusive = false;
+			stable_si = vswap_get_device(entry);
+			if (stable_si && data_race(stable_si->flags & SWP_STABLE_WRITES)) {
+				/*
+				 * This is tricky: not all swap backends support
+				 * concurrent page modifications while under writeback.
+				 *
+				 * So if we stumble over such a page in the swapcache
+				 * we must not set the page exclusive, otherwise we can
+				 * map it writable without further checks and modify it
+				 * while still under writeback.
+				 *
+				 * For these problematic swap backends, simply drop the
+				 * exclusive marker: this is perfectly fine as we start
+				 * writeback only if we fully unmapped the page and
+				 * there are no unexpected references on the page after
+				 * unmapping succeeded. After fully unmapped, no
+				 * further GUP references (FOLL_GET and FOLL_PIN) can
+				 * appear, so dropping the exclusive marker and mapping
+				 * it only R/O is fine.
+				 */
+				exclusive = false;
+			}
+
+			if (stable_si)
+				swap_slot_put_swap_info(stable_si);
 		}
 	}
 
@@ -5045,7 +5083,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			wake_up(&swapcache_wq);
 	}
 	if (swapoff_locked)
-		put_swap_entry(entry, si);
+		put_swap_entry(orig_entry, si);
 	return ret;
 out_nomap:
 	if (vmf->pte)
@@ -5064,7 +5102,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			wake_up(&swapcache_wq);
 	}
 	if (swapoff_locked)
-		put_swap_entry(entry, si);
+		put_swap_entry(orig_entry, si);
 	return ret;
 }
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 5de3705572955..675ec6445609b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -201,44 +201,6 @@ static bool is_folio_zero_filled(struct folio *folio)
 	return true;
 }
 
-static void swap_zeromap_folio_set(struct folio *folio)
-{
-	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
-	struct swap_info_struct *sis =
-		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
-	int nr_pages = folio_nr_pages(folio);
-	swp_entry_t entry;
-	swp_slot_t slot;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		slot = swp_entry_to_swp_slot(entry);
-		set_bit(swp_slot_offset(slot), sis->zeromap);
-	}
-
-	count_vm_events(SWPOUT_ZERO, nr_pages);
-	if (objcg) {
-		count_objcg_events(objcg, SWPOUT_ZERO, nr_pages);
-		obj_cgroup_put(objcg);
-	}
-}
-
-static void swap_zeromap_folio_clear(struct folio *folio)
-{
-	struct swap_info_struct *sis =
-		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
-	swp_entry_t entry;
-	swp_slot_t slot;
-	unsigned int i;
-
-	for (i = 0; i < folio_nr_pages(folio); i++) {
-		entry = page_swap_entry(folio_page(folio, i));
-		slot = swp_entry_to_swp_slot(entry);
-		clear_bit(swp_slot_offset(slot), sis->zeromap);
-	}
-}
-
 /*
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
@@ -260,23 +222,22 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 		goto out_unlock;
 	}
 
-	/*
-	 * Use a bitmap (zeromap) to avoid doing IO for zero-filled pages.
-	 * The bits in zeromap are protected by the locked swapcache folio
-	 * and atomic updates are used to protect against read-modify-write
-	 * corruption due to other zero swap entries seeing concurrent updates.
-	 */
 	if (is_folio_zero_filled(folio)) {
 		swap_zeromap_folio_set(folio);
 		goto out_unlock;
 	}
 
 	/*
-	 * Clear bits this folio occupies in the zeromap to prevent zero data
-	 * being read in from any previous zero writes that occupied the same
-	 * swap entries.
+	 * Release swap backends to make sure we do not have mixed backends
+	 *
+	 * The only exception is if the folio is already backed by a
+	 * contiguous range of physical swap slots (for e.g, from a previous
+	 * swapout attempt when zswap is disabled).
+	 *
+	 * Keep that backend to avoid reallocation of physical swap slots.
 	 */
-	swap_zeromap_folio_clear(folio);
+	if (!vswap_swapfile_backed(folio->swap, folio_nr_pages(folio)))
+		vswap_store_folio(folio->swap, folio);
 
 	if (zswap_store(folio)) {
 		count_mthp_stat(folio_order(folio), MTHP_STAT_ZSWPOUT);
@@ -287,6 +248,12 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 		return AOP_WRITEPAGE_ACTIVATE;
 	}
 
+	/* fall back to physical swap device */
+	if (!vswap_alloc_swap_slot(folio)) {
+		folio_mark_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	__swap_writepage(folio, swap_plug);
 	return 0;
 out_unlock:
@@ -618,14 +585,11 @@ static void swap_read_folio_bdev_async(struct folio *folio,
 
 void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 {
-	struct swap_info_struct *sis =
-		__swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
-	bool synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
-	bool workingset = folio_test_workingset(folio);
+	struct swap_info_struct *sis;
+	bool synchronous, workingset = folio_test_workingset(folio);
 	unsigned long pflags;
 	bool in_thrashing;
 
-	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
 
@@ -651,6 +615,10 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
 
+	sis = __swap_slot_to_info(swp_entry_to_swp_slot(folio->swap));
+	synchronous = sis->flags & SWP_SYNCHRONOUS_IO;
+	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio) && !synchronous, folio);
+
 	if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_read_folio_fs(folio, plug);
 	} else if (synchronous) {
diff --git a/mm/shmem.c b/mm/shmem.c
index 780571c830e5b..3a346cca114ab 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1459,7 +1459,7 @@ static unsigned int shmem_find_swap_entries(struct address_space *mapping,
 		 * swapin error entries can be found in the mapping. But they're
 		 * deliberately ignored here as we've done everything we can do.
 		 */
-		if (swp_slot_type(slot) != type)
+		if (!slot.val || swp_slot_type(slot) != type)
 			continue;
 
 		indices[folio_batch_count(fbatch)] = xas.xa_index;
@@ -1604,7 +1604,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 	if ((info->flags & SHMEM_F_LOCKED) || sbinfo->noswap)
 		goto redirty;
 
-	if (!total_swap_pages)
+	if (!zswap_is_enabled() && !total_swap_pages)
 		goto redirty;
 
 	/*
@@ -2341,7 +2341,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	/* Look it up and read it in.. */
 	folio = swap_cache_get_folio(swap);
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+		if (si && data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			/* Direct swapin skipping swap cache & readahead */
 			folio = shmem_swap_alloc_folio(inode, vma, index,
 						       index_entry, order, gfp);
diff --git a/mm/swap.h b/mm/swap.h
index ae97cf9712c5c..d41e6a0e70753 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -310,35 +310,15 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	swp_slot_t swp_slot = swp_entry_to_swp_slot(folio->swap);
 
+	/* The folio might not be backed by any physical swap slots
+	 * (for e.g zswap-backed only).
+	 */
+	if (!swp_slot.val)
+		return 0;
 	return __swap_slot_to_info(swp_slot)->flags;
 }
 
-/*
- * Return the count of contiguous swap entries that share the same
- * zeromap status as the starting entry. If is_zeromap is not NULL,
- * it will return the zeromap status of the starting entry.
- */
-static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
-		bool *is_zeromap)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(entry);
-	struct swap_info_struct *sis = __swap_slot_to_info(slot);
-	unsigned long start = swp_slot_offset(slot);
-	unsigned long end = start + max_nr;
-	bool first_bit;
-
-	first_bit = test_bit(start, sis->zeromap);
-	if (is_zeromap)
-		*is_zeromap = first_bit;
-
-	if (max_nr <= 1)
-		return max_nr;
-	if (first_bit)
-		return find_next_zero_bit(sis->zeromap, end, start) - start;
-	else
-		return find_next_bit(sis->zeromap, end, start) - start;
-}
-
+int swap_zeromap_batch(swp_entry_t entry, int max_nr, bool *is_zeromap);
 int non_swapcache_batch(swp_entry_t entry, int max_nr);
 
 #else /* CONFIG_SWAP */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1827527e88d33..ad80bf098b63f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -179,6 +179,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	struct folio *result = NULL;
 	void *shadow = NULL;
 
+	/* we might get an unsed entry from cluster readahead - just skip */
+	if (!entry.val)
+		return NULL;
+
 	*new_page_allocated = false;
 	for (;;) {
 		int err;
@@ -213,8 +217,20 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		 * Swap entry may have been freed since our caller observed it.
 		 */
 		err = swapcache_prepare(entry, 1);
-		if (!err)
+		if (!err) {
+			/* This might be invoked by swap_cluster_readahead(), which can
+			 * race with shmem_swapin_folio(). The latter might have already
+			 * called swap_cache_del_folio(), allowing swapcache_prepare()
+			 * to succeed here. This can lead to reading bogus data to populate
+			 * the page. To prevent this, skip folio-backed virtual swap slots,
+			 * and let caller retry if necessary.
+			 */
+			if (vswap_folio_backed(entry, 1)) {
+				swapcache_clear(entry, 1);
+				goto put_and_return;
+			}
 			break;
+		}
 		else if (err != -EEXIST)
 			goto put_and_return;
 
@@ -391,11 +407,18 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	unsigned long offset = slot_offset;
 	unsigned long start_offset, end_offset;
 	unsigned long mask;
-	struct swap_info_struct *si = __swap_slot_to_info(slot);
+	struct swap_info_struct *si = swap_slot_tryget_swap_info(slot);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
 	bool page_allocated;
 
+	/*
+	 * The swap entry might not be backed by any physical swap slot. In that
+	 * case, just skip readahead and bring in the target entry.
+	 */
+	if (!si)
+		goto skip;
+
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
 		goto skip;
@@ -429,6 +452,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	swap_read_unplug(splug);
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
+	if (si)
+		swap_slot_put_swap_info(si);
 	/* The page was likely read above, so no need for plugging here */
 	folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 					&page_allocated, false);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6c5e46bf40701..1aa29dd220f9a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1210,14 +1210,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 {
 	unsigned long end = offset + nr_entries - 1;
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
-	unsigned int i;
-
-	/*
-	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
-	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
-	 */
-	for (i = 0; i < nr_entries; i++)
-		clear_bit(offset + i, si->zeromap);
 
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c9ec1a1458b4e..6b200a6bb1160 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -365,10 +365,11 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 {
 	if (memcg == NULL) {
 		/*
-		 * For non-memcg reclaim, is there
-		 * space in any swap device?
+		 * For non-memcg reclaim:
+		 *
+		 * Check if zswap is enabled or if there is space in any swap device?
 		 */
-		if (get_nr_swap_pages() > 0)
+		if (zswap_is_enabled() || get_nr_swap_pages() > 0)
 			return true;
 	} else {
 		/* Is the memcg below its swap limit? */
@@ -2640,12 +2641,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 static bool can_age_anon_pages(struct lruvec *lruvec,
 			       struct scan_control *sc)
 {
-	/* Aging the anon LRU is valuable if swap is present: */
-	if (total_swap_pages > 0)
-		return true;
-
-	/* Also valuable if anon pages can be demoted: */
-	return can_demote(lruvec_pgdat(lruvec)->node_id, sc,
+	/*
+	 * Aging the anon LRU is valuable if zswap or physical swap is available or
+	 * anon pages can be demoted
+	 */
+	return zswap_is_enabled() || total_swap_pages > 0 ||
+			can_demote(lruvec_pgdat(lruvec)->node_id, sc,
 			  lruvec_memcg(lruvec));
 }
 
diff --git a/mm/vswap.c b/mm/vswap.c
index 318933071edc6..fb6179ce3ace7 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -11,6 +11,7 @@
 #include <linux/swap_cgroup.h>
 #include <linux/cpuhotplug.h>
 #include <linux/zswap.h>
+#include "internal.h"
 #include "swap.h"
 #include "swap_table.h"
 
@@ -54,22 +55,48 @@
  *
  * Note that we do not have a reference count field per se - it is derived from
  * the swap_count and the in_swapcache fields.
+ *
+ * III. Backing State
+ *
+ * Each virtual swap slot can be backed by:
+ *
+ * 1. A slot on a physical swap device (i.e a swapfile or a swap partition).
+ * 2. A swapped out zero-filled page.
+ * 3. A compressed object in zswap.
+ * 4. An in-memory folio, that is not backed by neither a physical swap device
+ *    nor zswap (i.e only in swap cache). This is used for pages that are
+ *    rejected by zswap, but not (yet) backed by a physical swap device,
+ *    (for e.g, due to zswap.writeback = 0), or for pages that were previously
+ *    stored in zswap, but has since been loaded back into memory (and has its
+ *    zswap copy invalidated).
  */
 
+/* The backing state options of a virtual swap slot */
+enum swap_type {
+	VSWAP_SWAPFILE,
+	VSWAP_ZERO,
+	VSWAP_ZSWAP,
+	VSWAP_FOLIO
+};
+
 /**
  * Swap descriptor - metadata of a swapped out page.
  *
  * @slot: The handle to the physical swap slot backing this page.
  * @zswap_entry: The zswap entry associated with this swap slot.
- * @swap_cache: The folio in swap cache.
+ * @swap_cache: The folio in swap cache. If the swap entry backing type is
+ *              VSWAP_FOLIO, the backend is also stored here.
  * @shadow: The shadow entry.
- * @memcgid: The memcg id of the owning memcg, if any.
  * @swap_count: The number of page table entries that refer to the swap entry.
+ * @memcgid: The memcg id of the owning memcg, if any.
  * @in_swapcache: Whether the swap entry is (about to be) pinned in swap cache.
+ * @type: The backing store type of the swap entry.
  */
 struct swp_desc {
-	swp_slot_t slot;
-	struct zswap_entry *zswap_entry;
+	union {
+		swp_slot_t slot;
+		struct zswap_entry *zswap_entry;
+	};
 	union {
 		struct folio *swap_cache;
 		void *shadow;
@@ -78,10 +105,10 @@ struct swp_desc {
 	unsigned int swap_count;
 
 #ifdef CONFIG_MEMCG
-	unsigned short memcgid;
+	unsigned short memcgid:16;
 #endif
-
-	bool in_swapcache;
+	bool in_swapcache:1;
+	enum swap_type type:2;
 };
 
 #define VSWAP_CLUSTER_SHIFT HPAGE_PMD_ORDER
@@ -266,15 +293,16 @@ static bool cluster_is_alloc_candidate(struct vswap_cluster *cluster)
 	return cluster->count + (1 << (cluster->order)) <= VSWAP_CLUSTER_SIZE;
 }
 
-static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start)
+static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster,
+		int start, struct folio *folio)
 {
 	int i, nr = 1 << cluster->order;
 	struct swp_desc *desc;
 
 	for (i = 0; i < nr; i++) {
 		desc = &cluster->descriptors[start + i];
-		desc->slot.val = 0;
-		desc->zswap_entry = NULL;
+		desc->type = VSWAP_FOLIO;
+		desc->swap_cache = folio;
 #ifdef CONFIG_MEMCG
 		desc->memcgid = 0;
 #endif
@@ -284,7 +312,8 @@ static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start)
 	cluster->count += nr;
 }
 
-static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster)
+static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster,
+		struct folio *folio)
 {
 	int nr = 1 << cluster->order;
 	unsigned long i = cluster->id ? 0 : nr;
@@ -303,16 +332,16 @@ static unsigned long vswap_alloc_from_cluster(struct vswap_cluster *cluster)
 	bitmap_set(cluster->bitmap, i, nr);
 
 	refcount_add(nr, &cluster->refcnt);
-	__vswap_alloc_from_cluster(cluster, i);
+	__vswap_alloc_from_cluster(cluster, i, folio);
 	return i + (cluster->id << VSWAP_CLUSTER_SHIFT);
 }
 
 /* Allocate a contiguous range of virtual swap slots */
-static swp_entry_t vswap_alloc(int order)
+static swp_entry_t vswap_alloc(struct folio *folio)
 {
 	struct xa_limit limit = vswap_cluster_map_limit;
 	struct vswap_cluster *local, *cluster;
-	int nr = 1 << order;
+	int order = folio_order(folio), nr = 1 << order;
 	bool need_caching = true;
 	u32 cluster_id;
 	swp_entry_t entry;
@@ -325,7 +354,7 @@ static swp_entry_t vswap_alloc(int order)
 	cluster = this_cpu_read(percpu_vswap_cluster.clusters[order]);
 	if (cluster) {
 		spin_lock(&cluster->lock);
-		entry.val = vswap_alloc_from_cluster(cluster);
+		entry.val = vswap_alloc_from_cluster(cluster, folio);
 		need_caching = !entry.val;
 
 		if (!entry.val || !cluster_is_alloc_candidate(cluster)) {
@@ -352,7 +381,7 @@ static swp_entry_t vswap_alloc(int order)
 			if (!spin_trylock(&cluster->lock))
 				continue;
 
-			entry.val = vswap_alloc_from_cluster(cluster);
+			entry.val = vswap_alloc_from_cluster(cluster, folio);
 			list_del_init(&cluster->list);
 			cluster->full = !entry.val || !cluster_is_alloc_candidate(cluster);
 			need_caching = !cluster->full;
@@ -384,7 +413,7 @@ static swp_entry_t vswap_alloc(int order)
 				if (!cluster_id)
 					entry.val += nr;
 				__vswap_alloc_from_cluster(cluster,
-					(entry.val & VSWAP_CLUSTER_MASK));
+					(entry.val & VSWAP_CLUSTER_MASK), folio);
 				/* Mark the allocated range in the bitmap */
 				bitmap_set(cluster->bitmap, (entry.val & VSWAP_CLUSTER_MASK), nr);
 				need_caching = cluster_is_alloc_candidate(cluster);
@@ -497,6 +526,84 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 		__swap_table_set(ci, ci_off + i, vswap ? vswap + i : 0);
 }
 
+/*
+ * Caller needs to handle races with other operations themselves.
+ *
+ * Specifically, this function is safe to be called in contexts where the swap
+ * entry has been added to the swap cache and the associated folio is locked.
+ * We cannot race with other accessors, and the swap entry is guaranteed to be
+ * valid the whole time (since swap cache implies one refcount).
+ *
+ * We cannot assume that the backends will be of the same type,
+ * contiguous, etc. We might have a large folio coalesced from subpages with
+ * mixed backend, which is only rectified when it is reclaimed.
+ */
+ static void release_backing(swp_entry_t entry, int nr)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	unsigned long flush_nr, phys_swap_start = 0, phys_swap_end = 0;
+	unsigned int phys_swap_type = 0;
+	bool need_flushing_phys_swap = false;
+	swp_slot_t flush_slot;
+	int i;
+
+	VM_WARN_ON(!entry.val);
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+
+		/*
+		 * We batch contiguous physical swap slots for more efficient
+		 * freeing.
+		 */
+		if (phys_swap_start != phys_swap_end &&
+				(desc->type != VSWAP_SWAPFILE ||
+					swp_slot_type(desc->slot) != phys_swap_type ||
+					swp_slot_offset(desc->slot) != phys_swap_end)) {
+			need_flushing_phys_swap = true;
+			flush_slot = swp_slot(phys_swap_type, phys_swap_start);
+			flush_nr = phys_swap_end - phys_swap_start;
+			phys_swap_start = phys_swap_end = 0;
+		}
+
+		if (desc->type == VSWAP_ZSWAP && desc->zswap_entry) {
+			zswap_entry_free(desc->zswap_entry);
+		} else if (desc->type == VSWAP_SWAPFILE) {
+			if (!phys_swap_start) {
+				/* start a new contiguous range of phys swap */
+				phys_swap_start = swp_slot_offset(desc->slot);
+				phys_swap_end = phys_swap_start + 1;
+				phys_swap_type = swp_slot_type(desc->slot);
+			} else {
+				/* extend the current contiguous range of phys swap */
+				phys_swap_end++;
+			}
+		}
+
+		desc->slot.val = 0;
+
+		if (need_flushing_phys_swap) {
+			spin_unlock(&cluster->lock);
+			cluster = NULL;
+			swap_slot_free_nr(flush_slot, flush_nr);
+			need_flushing_phys_swap = false;
+		}
+	}
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	/* Flush any remaining physical swap range */
+	if (phys_swap_start) {
+		flush_slot = swp_slot(phys_swap_type, phys_swap_start);
+		flush_nr = phys_swap_end - phys_swap_start;
+		swap_slot_free_nr(flush_slot, flush_nr);
+	}
+ }
+
 /*
  * Entered with the cluster locked, but might unlock the cluster.
  * This is because several operations, such as releasing physical swap slots
@@ -516,35 +623,21 @@ void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 	swp_entry_t entry)
 {
-	struct zswap_entry *zswap_entry;
-	swp_slot_t slot;
-
 	/* Clear shadow if present */
 	if (xa_is_value(desc->shadow))
 		desc->shadow = NULL;
-
-	slot = desc->slot;
-	desc->slot.val = 0;
-
-	zswap_entry = desc->zswap_entry;
-	if (zswap_entry) {
-		desc->zswap_entry = NULL;
-		zswap_entry_free(zswap_entry);
-	}
 	spin_unlock(&cluster->lock);
 
+	release_backing(entry, 1);
 	mem_cgroup_uncharge_swap(entry, 1);
 
-	if (slot.val)
-		swap_slot_free_nr(slot, 1);
-
-	spin_lock(&cluster->lock);
 	/* erase forward mapping and release the virtual slot for reallocation */
+	spin_lock(&cluster->lock);
 	release_vswap_slot(cluster, entry.val);
 }
 
 /**
- * folio_alloc_swap - allocate swap space for a folio.
+ * folio_alloc_swap - allocate virtual swap space for a folio.
  * @folio: the folio.
  *
  * Return: 0, if the allocation succeeded, -ENOMEM, if the allocation failed.
@@ -552,38 +645,77 @@ static void vswap_free(struct vswap_cluster *cluster, struct swp_desc *desc,
 int folio_alloc_swap(struct folio *folio)
 {
 	struct vswap_cluster *cluster = NULL;
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	int i, nr = folio_nr_pages(folio), order = folio_order(folio);
+	int i, nr = folio_nr_pages(folio);
 	struct swp_desc *desc;
 	swp_entry_t entry;
-	swp_slot_t slot;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
 
-	entry = vswap_alloc(folio_order(folio));
+	entry = vswap_alloc(folio);
 	if (!entry.val)
 		return -ENOMEM;
 
 	/*
-	 * XXX: for now, we always allocate a physical swap slot for each virtual
-	 * swap slot, and their lifetime are coupled. This will change once we
-	 * decouple virtual swap slots from their backing states, and only allocate
-	 * physical swap slots for them on demand (i.e on zswap writeback, or
-	 * fallback from zswap store failure).
+	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
+	 * swap slots allocation. This will be changed soon - we will only charge on
+	 * physical swap slots allocation.
 	 */
-	if (swap_slot_alloc(&slot, order)) {
+	if (mem_cgroup_try_charge_swap(folio, entry)) {
+		rcu_read_lock();
 		for (i = 0; i < nr; i++) {
 			desc = vswap_iter(&cluster, entry.val + i);
 			VM_WARN_ON(!desc);
 			vswap_free(cluster, desc, (swp_entry_t){ entry.val + i });
 		}
 		spin_unlock(&cluster->lock);
+		rcu_read_unlock();
+		atomic_add(nr, &vswap_alloc_reject);
 		entry.val = 0;
 		return -ENOMEM;
 	}
 
+	swap_cache_add_folio(folio, entry, NULL);
+
+	return 0;
+}
+
+/**
+ * vswap_alloc_swap_slot - allocate physical swap space for a folio that is
+ *                         already associated with virtual swap slots.
+ * @folio: folio we want to allocate physical swap space for.
+ *
+ * Note that this does NOT release existing swap backends of the folio.
+ * Callers need to handle this themselves.
+
+ * Return: true if the folio is now backed by physical swap slots, false
+ * otherwise.
+ */
+bool vswap_alloc_swap_slot(struct folio *folio)
+{
+	int i, nr = folio_nr_pages(folio);
+	struct vswap_cluster *cluster = NULL;
+	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	swp_slot_t slot = { .val = 0 };
+	swp_entry_t entry = folio->swap;
+	struct swp_desc *desc;
+	bool fallback = false;
+
+	/*
+	 * We might have already allocated a backing physical swap slot in past
+	 * attempts (for instance, when we disable zswap). If the entire range is
+	 * already swapfile-backed we can skip swapfile case.
+	 */
+	if (vswap_swapfile_backed(entry, nr))
+		return true;
+
+	if (swap_slot_alloc(&slot, folio_order(folio)))
+		return false;
+
+	if (!slot.val)
+		return false;
+
 	/* establish the vrtual <-> physical swap slots linkages. */
 	si = __swap_slot_to_info(slot);
 	ci = swap_cluster_lock(si, swp_slot_offset(slot));
@@ -595,29 +727,29 @@ int folio_alloc_swap(struct folio *folio)
 		desc = vswap_iter(&cluster, entry.val + i);
 		VM_WARN_ON(!desc);
 
+		if (desc->type == VSWAP_FOLIO) {
+			/* case 1: fallback from zswap store failure */
+			fallback = true;
+			if (!folio)
+				folio = desc->swap_cache;
+			else
+				VM_WARN_ON(folio != desc->swap_cache);
+		} else {
+			/*
+			 * Case 2: zswap writeback.
+			 *
+			 * No need to free zswap entry here - it will be freed once zswap
+			 * writeback suceeds.
+			 */
+			VM_WARN_ON(desc->type != VSWAP_ZSWAP);
+			VM_WARN_ON(fallback);
+		}
+		desc->type = VSWAP_SWAPFILE;
 		desc->slot.val = slot.val + i;
 	}
-	if (cluster)
-		spin_unlock(&cluster->lock);
+	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
-
-	/*
-	 * XXX: for now, we charge towards the memory cgroup's swap limit on virtual
-	 * swap slots allocation. This is acceptable because as noted above, each
-	 * virtual swap slot corresponds to a physical swap slot. Once we have
-	 * decoupled virtual and physical swap slots, we will only charge when we
-	 * actually allocate a physical swap slot.
-	 */
-	if (mem_cgroup_try_charge_swap(folio, entry))
-		goto out_free;
-
-	swap_cache_add_folio(folio, entry, NULL);
-
-	return 0;
-
-out_free:
-	put_swap_folio(folio, entry);
-	return -ENOMEM;
+	return true;
 }
 
 /**
@@ -625,7 +757,9 @@ int folio_alloc_swap(struct folio *folio)
  *                         virtual swap slot.
  * @entry: the virtual swap slot.
  *
- * Return: the physical swap slot corresponding to the virtual swap slot.
+ * Return: the physical swap slot corresponding to the virtual swap slot, if
+ * exists, or the zero physical swap slot if the virtual swap slot is not
+ * backed by any physical slot on a swapfile.
  */
 swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 {
@@ -644,7 +778,10 @@ swp_slot_t swp_entry_to_swp_slot(swp_entry_t entry)
 		return (swp_slot_t){0};
 	}
 
-	slot = desc->slot;
+	if (desc->type != VSWAP_SWAPFILE)
+		slot.val = 0;
+	else
+		slot = desc->slot;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
 
@@ -962,6 +1099,293 @@ int non_swapcache_batch(swp_entry_t entry, int max_nr)
 	return i;
 }
 
+/**
+ * vswap_store_folio - set a folio as the backing of a range of virtual swap
+ *                     slots.
+ * @entry: the first virtual swap slot in the range.
+ * @folio: the folio.
+ */
+void vswap_store_folio(swp_entry_t entry, struct folio *folio)
+{
+	struct vswap_cluster *cluster = NULL;
+	int i, nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+
+	VM_BUG_ON(!folio_test_locked(folio));
+	VM_BUG_ON(folio->swap.val != entry.val);
+
+	release_backing(entry, nr);
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+		desc->type = VSWAP_FOLIO;
+		desc->swap_cache = folio;
+	}
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+}
+
+/**
+ * swap_zeromap_folio_set - mark a range of virtual swap slots corresponding to
+ *                          a folio as zero-filled.
+ * @folio: the folio
+ */
+void swap_zeromap_folio_set(struct folio *folio)
+{
+	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
+	struct vswap_cluster *cluster = NULL;
+	swp_entry_t entry = folio->swap;
+	int i, nr = folio_nr_pages(folio);
+	struct swp_desc *desc;
+
+	VM_BUG_ON(!folio_test_locked(folio));
+	VM_BUG_ON(!entry.val);
+
+	release_backing(entry, nr);
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+		desc->type = VSWAP_ZERO;
+	}
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	count_vm_events(SWPOUT_ZERO, nr);
+	if (objcg) {
+		count_objcg_events(objcg, SWPOUT_ZERO, nr);
+		obj_cgroup_put(objcg);
+	}
+}
+
+/*
+ * Iterate through the entire range of virtual swap slots, returning the
+ * longest contiguous range of slots starting from the first slot that satisfies:
+ *
+ * 1. If the first slot is zero-mapped, the entire range should be
+ *    zero-mapped.
+ * 2. If the first slot is backed by a swapfile, the entire range should
+ *    be backed by a range of contiguous swap slots on the same swapfile.
+ * 3. If the first slot is zswap-backed, the entire range should be
+ *    zswap-backed.
+ * 4. If the first slot is backed by a folio, the entire range should
+ *    be backed by the same folio.
+ *
+ * Note that this check is racy unless we can ensure that the entire range
+ * has their backing state stable - for instance, if the caller was the one
+ * who set the swap cache pin.
+ */
+static int vswap_check_backing(swp_entry_t entry, enum swap_type *type, int nr)
+{
+	unsigned int swapfile_type;
+	struct vswap_cluster *cluster = NULL;
+	enum swap_type first_type;
+	struct swp_desc *desc;
+	pgoff_t first_offset;
+	struct folio *folio;
+	int i = 0;
+
+	if (!entry.val)
+		return 0;
+
+	rcu_read_lock();
+	for (i = 0; i < nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		if (!desc)
+			goto done;
+
+		if (!i) {
+			first_type = desc->type;
+			if (first_type == VSWAP_SWAPFILE) {
+				swapfile_type = swp_slot_type(desc->slot);
+				first_offset = swp_slot_offset(desc->slot);
+			} else if (first_type == VSWAP_FOLIO) {
+				folio = desc->swap_cache;
+			}
+		} else if (desc->type != first_type) {
+			goto done;
+		} else if (first_type == VSWAP_SWAPFILE &&
+				(swp_slot_type(desc->slot) != swapfile_type ||
+					swp_slot_offset(desc->slot) != first_offset + i)) {
+			goto done;
+		} else if (first_type == VSWAP_FOLIO && desc->swap_cache != folio) {
+			goto done;
+		}
+	}
+done:
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	if (type)
+		*type = first_type;
+	return i;
+}
+
+/**
+ * vswap_swapfile_backed - check if the virtual swap slots are backed by physical
+ *                         swap slots.
+ * @entry: the first entry in the range.
+ * @nr: the number of entries in the range.
+ */
+bool vswap_swapfile_backed(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr
+				&& type == VSWAP_SWAPFILE;
+}
+
+/**
+ * vswap_folio_backed - check if the virtual swap slots are backed by in-memory
+ *                      pages.
+ * @entry: the first virtual swap slot in the range.
+ * @nr: the number of slots in the range.
+ */
+bool vswap_folio_backed(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr && type == VSWAP_FOLIO;
+}
+
+/**
+ * vswap_can_swapin_thp - check if the swap entries can be swapped in as a THP.
+ * @entry: the first virtual swap slot in the range.
+ * @nr: the number of slots in the range.
+ *
+ * For now, we can only swap in a THP if the entire range is zero-filled, or if
+ * the entire range is backed by a contiguous range of physical swap slots on a
+ * swapfile.
+ */
+bool vswap_can_swapin_thp(swp_entry_t entry, int nr)
+{
+	enum swap_type type;
+
+	return vswap_check_backing(entry, &type, nr) == nr &&
+		(type == VSWAP_ZERO || type == VSWAP_SWAPFILE);
+}
+
+/**
+ * swap_move - increment the swap slot by delta, checking the backing state and
+ *             return 0 if the backing state does not match (i.e wrong backing
+ *             state type, or wrong offset on the backing stores).
+ * @entry: the original virtual swap slot.
+ * @delta: the offset to increment the original slot.
+ *
+ * Note that this function is racy unless we can pin the backing state of these
+ * swap slots down with swapcache_prepare().
+ *
+ * Caller should only rely on this function as a best-effort hint otherwise,
+ * and should double-check after ensuring the whole range is pinned down.
+ *
+ * Return: the incremented virtual swap slot if the backing state matches, or
+ *         0 if the backing state does not match.
+ */
+swp_entry_t swap_move(swp_entry_t entry, long delta)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc, *next_desc;
+	swp_entry_t next_entry;
+	struct folio *folio = NULL, *next_folio = NULL;
+	enum swap_type type, next_type;
+	swp_slot_t slot = {0}, next_slot = {0};
+
+	next_entry.val = entry.val + delta;
+
+	rcu_read_lock();
+
+	/* Look up first descriptor and get its type and backing store */
+	desc = vswap_iter(&cluster, entry.val);
+	if (!desc) {
+		rcu_read_unlock();
+		return (swp_entry_t){0};
+	}
+
+	type = desc->type;
+	if (type == VSWAP_ZSWAP) {
+		/* zswap not supported for move */
+		spin_unlock(&cluster->lock);
+		rcu_read_unlock();
+		return (swp_entry_t){0};
+	}
+	if (type == VSWAP_FOLIO)
+		folio = desc->swap_cache;
+	else if (type == VSWAP_SWAPFILE)
+		slot = desc->slot;
+
+	/* Look up second descriptor and get its type and backing store */
+	next_desc = vswap_iter(&cluster, next_entry.val);
+	if (!next_desc) {
+		rcu_read_unlock();
+		return (swp_entry_t){0};
+	}
+
+	next_type = next_desc->type;
+	if (next_type == VSWAP_FOLIO)
+		next_folio = next_desc->swap_cache;
+	else if (next_type == VSWAP_SWAPFILE)
+		next_slot = next_desc->slot;
+
+	if (cluster)
+		spin_unlock(&cluster->lock);
+
+	rcu_read_unlock();
+
+	/* Check if types match */
+	if (next_type != type)
+		return (swp_entry_t){0};
+
+	/* Check backing state consistency */
+	if (type == VSWAP_SWAPFILE &&
+			(swp_slot_type(next_slot) != swp_slot_type(slot) ||
+				swp_slot_offset(next_slot) !=
+							swp_slot_offset(slot) + delta))
+		return (swp_entry_t){0};
+
+	if (type == VSWAP_FOLIO && next_folio != folio)
+		return (swp_entry_t){0};
+
+	return next_entry;
+}
+
+/*
+ * Return the count of contiguous swap entries that share the same
+ * VSWAP_ZERO status as the starting entry. If is_zeromap is not NULL,
+ * it will return the VSWAP_ZERO status of the starting entry.
+ */
+int swap_zeromap_batch(swp_entry_t entry, int max_nr, bool *is_zeromap)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	int i = 0;
+	bool is_zero = false;
+
+	VM_WARN_ON(!entry.val);
+
+	rcu_read_lock();
+	for (i = 0; i < max_nr; i++) {
+		desc = vswap_iter(&cluster, entry.val + i);
+		if (!desc)
+			goto done;
+
+		if (!i)
+			is_zero = (desc->type == VSWAP_ZERO);
+		else if ((desc->type == VSWAP_ZERO) != is_zero)
+			goto done;
+	}
+done:
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	if (i && is_zeromap)
+		*is_zeromap = is_zero;
+
+	return i;
+}
+
 /**
  * free_swap_and_cache_nr() - Release a swap count on range of swap entries and
  *                            reclaim their cache if no more references remain.
@@ -1028,11 +1452,6 @@ bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si)
 	struct vswap_cluster *cluster;
 	swp_slot_t slot;
 
-	slot = swp_entry_to_swp_slot(entry);
-	*si = swap_slot_tryget_swap_info(slot);
-	if (!*si)
-		return false;
-
 	/*
 	 * Ensure the cluster and its associated data structures (swap cache etc.)
 	 * remain valid.
@@ -1041,11 +1460,30 @@ bool tryget_swap_entry(swp_entry_t entry, struct swap_info_struct **si)
 	cluster = xa_load(&vswap_cluster_map, VSWAP_CLUSTER_IDX(entry));
 	if (!cluster || !refcount_inc_not_zero(&cluster->refcnt)) {
 		rcu_read_unlock();
-		swap_slot_put_swap_info(*si);
 		*si = NULL;
 		return false;
 	}
 	rcu_read_unlock();
+
+	slot = swp_entry_to_swp_slot(entry);
+	/*
+	 * Note that this function does not provide any guarantee that the virtual
+	 * swap slot's backing state will be stable. This has several implications:
+	 *
+	 * 1. We have to obtain a reference to the swap device itself, because we
+	 * need swap device's metadata in certain scenarios, for example when we
+	 * need to inspect the swap device flag in do_swap_page().
+	 *
+	 * 2. The swap device we are looking up here might be outdated by the time we
+	 * return to the caller. It is perfectly OK, if the swap_info_struct is only
+	 * used in a best-effort manner (i.e optimization). If we need the precise
+	 * backing state, we need to re-check after the entry is pinned in swapcache.
+	 */
+	if (slot.val)
+		*si = swap_slot_tryget_swap_info(slot);
+	else
+		*si = NULL;
+
 	return true;
 }
 
@@ -1288,7 +1726,7 @@ void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp
 		old = desc->shadow;
 
 		/* Warn if slot is already occupied by a folio */
-		VM_WARN_ON_FOLIO(old && !xa_is_value(old), folio);
+		VM_WARN_ON_FOLIO(old && !xa_is_value(old) && old != folio, folio);
 
 		/* Save shadow if found and not yet saved */
 		if (shadowp && xa_is_value(old) && !*shadowp)
@@ -1415,29 +1853,22 @@ void __swap_cache_replace_folio(struct folio *old, struct folio *new)
  * @entry: the zswap entry to store
  *
  * Stores a zswap entry in the swap descriptor for the given swap entry.
- * The cluster is locked during the store operation.
- *
- * Return: the old zswap entry if one existed, NULL otherwise
+ * Releases the old backend if one existed.
  */
-void *zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
+void zswap_entry_store(swp_entry_t swpentry, struct zswap_entry *entry)
 {
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
-	void *old;
+
+	release_backing(swpentry, 1);
 
 	rcu_read_lock();
 	desc = vswap_iter(&cluster, swpentry.val);
-	if (!desc) {
-		rcu_read_unlock();
-		return NULL;
-	}
-
-	old = desc->zswap_entry;
+	VM_WARN_ON(!desc);
 	desc->zswap_entry = entry;
+	desc->type = VSWAP_ZSWAP;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
-
-	return old;
 }
 
 /**
@@ -1452,6 +1883,7 @@ void *zswap_entry_load(swp_entry_t swpentry)
 {
 	struct vswap_cluster *cluster = NULL;
 	struct swp_desc *desc;
+	enum swap_type type;
 	void *zswap_entry;
 
 	rcu_read_lock();
@@ -1461,41 +1893,15 @@ void *zswap_entry_load(swp_entry_t swpentry)
 		return NULL;
 	}
 
+	type = desc->type;
 	zswap_entry = desc->zswap_entry;
 	spin_unlock(&cluster->lock);
 	rcu_read_unlock();
 
-	return zswap_entry;
-}
-
-/**
- * zswap_entry_erase - erase a zswap entry for a swap entry
- * @swpentry: the swap entry
- *
- * Erases the zswap entry from the swap descriptor for the given swap entry.
- * The cluster is locked during the erase operation.
- *
- * Return: the zswap entry that was erased, NULL if none existed
- */
-void *zswap_entry_erase(swp_entry_t swpentry)
-{
-	struct vswap_cluster *cluster = NULL;
-	struct swp_desc *desc;
-	void *old;
-
-	rcu_read_lock();
-	desc = vswap_iter(&cluster, swpentry.val);
-	if (!desc) {
-		rcu_read_unlock();
+	if (type != VSWAP_ZSWAP)
 		return NULL;
-	}
 
-	old = desc->zswap_entry;
-	desc->zswap_entry = NULL;
-	spin_unlock(&cluster->lock);
-	rcu_read_unlock();
-
-	return old;
+	return zswap_entry;
 }
 
 bool zswap_empty(swp_entry_t swpentry)
diff --git a/mm/zswap.c b/mm/zswap.c
index e46349f9c90bb..c5e1d252cb463 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -991,8 +991,9 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 {
 	struct folio *folio;
 	struct mempolicy *mpol;
-	bool folio_was_allocated;
+	bool folio_was_allocated, phys_swap_alloced = false;
 	struct swap_info_struct *si;
+	struct zswap_entry *new_entry = NULL;
 	int ret = 0;
 
 	/* try to allocate swap cache folio */
@@ -1027,18 +1028,23 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	 * old compressed data. Only when this is successful can the entry
 	 * be dereferenced.
 	 */
-	if (entry != zswap_entry_load(swpentry)) {
+	new_entry = zswap_entry_load(swpentry);
+	if (entry != new_entry) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
+	if (!vswap_alloc_swap_slot(folio)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	phys_swap_alloced = true;
+
 	if (!zswap_decompress(entry, folio)) {
 		ret = -EIO;
 		goto out;
 	}
 
-	zswap_entry_erase(swpentry);
-
 	count_vm_event(ZSWPWB);
 	if (entry->objcg)
 		count_objcg_events(entry->objcg, ZSWPWB, 1);
@@ -1056,6 +1062,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 out:
 	if (ret && ret != -EEXIST) {
+		if (phys_swap_alloced)
+			zswap_entry_store(swpentry, new_entry);
 		swap_cache_del_folio(folio);
 		folio_unlock(folio);
 	}
@@ -1401,7 +1409,7 @@ static bool zswap_store_page(struct page *page,
 			     struct zswap_pool *pool)
 {
 	swp_entry_t page_swpentry = page_swap_entry(page);
-	struct zswap_entry *entry, *old;
+	struct zswap_entry *entry;
 
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL, page_to_nid(page));
@@ -1413,15 +1421,12 @@ static bool zswap_store_page(struct page *page,
 	if (!zswap_compress(page, entry, pool))
 		goto compress_failed;
 
-	old = zswap_entry_store(page_swpentry, entry);
-
 	/*
 	 * We may have had an existing entry that became stale when
 	 * the folio was redirtied and now the new version is being
-	 * swapped out. Get rid of the old.
+	 * swapped out. zswap_entry_store() will get rid of the old.
 	 */
-	if (old)
-		zswap_entry_free(old);
+	zswap_entry_store(page_swpentry, entry);
 
 	/*
 	 * The entry is successfully compressed and stored in the tree, there is
@@ -1533,18 +1538,13 @@ bool zswap_store(struct folio *folio)
 	 * the possibly stale entries which were previously stored at the
 	 * offsets corresponding to each page of the folio. Otherwise,
 	 * writeback could overwrite the new data in the swapfile.
+	 *
+	 * The only exception is if we still have a full contiguous
+	 * range of physical swap slots backing the folio. Keep them for
+	 * fallback disk swapping.
 	 */
-	if (!ret) {
-		unsigned type = swp_type(swp);
-		pgoff_t offset = swp_offset(swp);
-		struct zswap_entry *entry;
-
-		for (index = 0; index < nr_pages; ++index) {
-			entry = zswap_entry_erase(swp_entry(type, offset + index));
-			if (entry)
-				zswap_entry_free(entry);
-		}
-	}
+	if (!ret && !vswap_swapfile_backed(swp, nr_pages))
+		vswap_store_folio(swp, folio);
 
 	return ret;
 }
@@ -1619,8 +1619,7 @@ int zswap_load(struct folio *folio)
 	 */
 	if (swapcache) {
 		folio_mark_dirty(folio);
-		zswap_entry_erase(swp);
-		zswap_entry_free(entry);
+		vswap_store_folio(swp, folio);
 	}
 
 	folio_unlock(folio);
-- 
2.47.3


