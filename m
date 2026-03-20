Return-Path: <cgroups+bounces-14955-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAZEG5mgvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14955-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:31:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 099072E0016
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD14C3083CD9
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF83EFD10;
	Fri, 20 Mar 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMzuBC9d"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73242351C1C
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034878; cv=none; b=exry24qm5iDjL5qh6LoV8vur0prnGyVF33QXgqqgTl0iJy5/6VzWB6X0YFxdU6S1zKRqAmc0xNR4aNQ6eVjmc0y1iVhMH1yT6wrH6vbpZxGtcfwpf2M9wnf33ehD3kd8Mxpv5qmCD4NksZthFWTxDkrv/54YpJDGSvxmEGrwok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034878; c=relaxed/simple;
	bh=33weWvIHLDuvHbEuj+cGfVGBBfjaA2lpKK24CgGIPow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrVoTe9ghOqzJ0ZcFEKjCbWdtFFiJFCBtE/YTGFTFLtucTPcGkpdWzofhcLWlm6LLIgcSh+9towPMcGGNWzBdz0N1iYZfK/y98a/Rve3asnsKTcbPQQ2Nuo9XPM5u5xv05SQlB5gDYJUd1IchHJ/NH30L1qkWH5KV/K3UOFZwbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMzuBC9d; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7eb85fb81so1238718a34.0
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034874; x=1774639674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/hCJezq6i9YBJbsR8fO/KYYPUcAwg9EMc6jEkUFETU=;
        b=QMzuBC9d+zLC2R/jYTBOwjEjUV+QZpoSlNK6urxwtKdhkm9rtSbPXqJnDqDW/uNkGX
         F3lbt5Q/PjSaOcdVhJIprh+LJk3/UFdWtan+zTQ8dRqNhFDN9sNh241t4mB9VqBZtNTK
         /vfv7qenTZHRujs81FKE2MTAvVQ/6MArLrz79ePSDjNLicyeodQqbfyJZXvRwdHgnaKH
         lGYlba9SOVgEXlWZz4F8Woh3IaP+NK70+vOSRk/8UPg/WnwhOtf57GDzIAvLLMqx4imP
         9BpW75Q53Jdi6rEMZZmY/aqBFiLg4ggk8nXKs/LD14LEuPXQ+D2PhrZhq4YPOY2+8jub
         Q/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034874; x=1774639674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/hCJezq6i9YBJbsR8fO/KYYPUcAwg9EMc6jEkUFETU=;
        b=tJ0YPelvVPx+qWvpDRf+Utwlml57LtyXNnLWEcZcvHOOVp14F94TAJU5aA3QSR9r1E
         AAalvjxnfcZ4TWGK8ozCYE0nlvAdHiPvxk8RbE6FFUXCB0BTuZFtionbAhcnxJB8tt5H
         +C7c9aSdQU1tXrcK7VYsNb0U4qHBLVd8VUNRNrJEyV+RqwQtU2nfsOtUYkx9NjOWapsY
         IreMrBeant8JubKgeMLSUOubM4QSE++1uZ3gPZAdtj7fENAyFrLGVaemqL8uSjZcWipC
         wb3cEwlle9nWrgrK+z4Pom1n8wVtXxyeeS4pP3P9wmM5ftCixXpB2+DwlmXXcghcmlZx
         cR5w==
X-Forwarded-Encrypted: i=1; AJvYcCUjzFirt1IEBc19xOJc/RveVCpEBiQXHqnu0YZbS7jrUkIQmEML+4oF7zZsF4J556PDgkKOiFpp@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVLuHh6BGAfIlxKXmpWe6yHi+4luNJz1IXgpW/X3L7mDyARM2
	EwbWl/O4uCadWnVliF++XZ1yXVYBNsS6M0ZX2r8/Gc346tsPriDTPR21
X-Gm-Gg: ATEYQzz3pkMAQHS3tvQOx/IfE8KvHVNe6wWV99uAZtcGlCBr9lD1fWwcKVj2YOh1C6C
	SIWVebQe9FEr6VnAc36Fn2Pa726RUyktCbtq7boDjtMI+0TclKPKUa1HmWqWg3L8j7Vw1f1yfJ7
	dwLs6gw5yW0Kh/R/n29Ff/vCPPKcNzrDbMxPFJFtYEoYq3/P9FVIL/TXQGViRSwQIv6QDL7CSkk
	zXg24TlW9FBfU3xZ3xfl8PHTE095wwa+a93HeLbNWLnNazhB8e3g6ckzkg2Y1WncNnA9HwwBUhM
	G7rXex4/naUyezxWD3nJhP50HvOQBKgVO+NVrKhgVd0RgqbcpQmAnFA5rM/MEt8NF3AGDfwpdRK
	TYf+Lxs9bHjnilJlr7a2WDhf3ARd/YlY59sM3hG+ygoTw7Q2W+Pq3hrdNwodsxxzIDLow246k88
	DqhTfsGC0EfcB7+Xpp6YgI6BaXimbZUuM5yZZy+yCaIuCYvA==
X-Received: by 2002:a05:6830:8382:b0:7d7:ea04:6654 with SMTP id 46e09a7af769-7d7eaeced6fmr2911142a34.15.1774034874277;
        Fri, 20 Mar 2026 12:27:54 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:46::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eac17471sm3081351a34.7.2026.03.20.12.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:53 -0700 (PDT)
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
Subject: [PATCH v5 12/21] swap: implement the swap_cgroup API using virtual swap
Date: Fri, 20 Mar 2026 12:27:26 -0700
Message-ID: <20260320192735.748051-13-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14955-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.871];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 099072E0016
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Once we decouple a swap entry from its backing store via the virtual
swap, we can no longer statically allocate an array to store the swap
entries' cgroup information. Move it to the swap descriptor.

Note that the memory overhead for swap cgroup information is now on
demand, i.e dynamically incurred when the virtual swap cluster is
allocated. This help reduces the memory overhead in a huge but
sparsely used swap space.

For instance, a 2 TB swapfile consists of 2147483648 swap slots, each
incurring 2 bytes of overhead for swap cgroup, for a total of 1 GB. If
we only utilize 10% of the swapfile, we will save 900 MB.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap_cgroup.h |  17 ++--
 mm/Makefile                 |   3 -
 mm/memcontrol-v1.c          |   2 +-
 mm/swap_cgroup.c            | 174 ------------------------------------
 mm/swapfile.c               |   7 --
 mm/vswap.c                  | 142 +++++++++++++++++++++++++++++
 6 files changed, 148 insertions(+), 197 deletions(-)
 delete mode 100644 mm/swap_cgroup.c

diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
index 91cdf12190a03..a5b549a9ba3c3 100644
--- a/include/linux/swap_cgroup.h
+++ b/include/linux/swap_cgroup.h
@@ -7,10 +7,9 @@
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 
 extern void swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent);
+extern void __swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent);
 extern unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents);
 extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
-extern int swap_cgroup_swapon(int type, unsigned long max_pages);
-extern void swap_cgroup_swapoff(int type);
 
 #else
 
@@ -20,28 +19,22 @@ void swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent)
 }
 
 static inline
-unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents)
+void __swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent)
 {
-	return 0;
 }
 
 static inline
-unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
+unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents)
 {
 	return 0;
 }
 
-static inline int
-swap_cgroup_swapon(int type, unsigned long max_pages)
+static inline
+unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
 {
 	return 0;
 }
 
-static inline void swap_cgroup_swapoff(int type)
-{
-	return;
-}
-
 #endif
 
 #endif /* __LINUX_SWAP_CGROUP_H */
diff --git a/mm/Makefile b/mm/Makefile
index 67fa4586e7e18..a7538784191bf 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -103,9 +103,6 @@ obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_LIVEUPDATE) += memfd_luo.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
-ifdef CONFIG_SWAP
-obj-$(CONFIG_MEMCG) += swap_cgroup.o
-endif
 obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
 obj-$(CONFIG_GUP_TEST) += gup_test.o
 obj-$(CONFIG_DMAPOOL_TEST) += dmapool_test.o
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff7426..7b010e165e1ba 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -620,7 +620,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
-	swap_cgroup_record(folio, mem_cgroup_id(swap_memcg), entry);
+	__swap_cgroup_record(folio, mem_cgroup_id(swap_memcg), entry);
 
 	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
deleted file mode 100644
index 77ce1d66c318d..0000000000000
--- a/mm/swap_cgroup.c
+++ /dev/null
@@ -1,174 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/swap_cgroup.h>
-#include <linux/vmalloc.h>
-#include <linux/mm.h>
-
-#include <linux/swapops.h> /* depends on mm.h include */
-
-static DEFINE_MUTEX(swap_cgroup_mutex);
-
-/* Pack two cgroup id (short) of two entries in one swap_cgroup (atomic_t) */
-#define ID_PER_SC (sizeof(struct swap_cgroup) / sizeof(unsigned short))
-#define ID_SHIFT (BITS_PER_TYPE(unsigned short))
-#define ID_MASK (BIT(ID_SHIFT) - 1)
-struct swap_cgroup {
-	atomic_t ids;
-};
-
-struct swap_cgroup_ctrl {
-	struct swap_cgroup *map;
-};
-
-static struct swap_cgroup_ctrl swap_cgroup_ctrl[MAX_SWAPFILES];
-
-static unsigned short __swap_cgroup_id_lookup(struct swap_cgroup *map,
-					      pgoff_t offset)
-{
-	unsigned int shift = (offset % ID_PER_SC) * ID_SHIFT;
-	unsigned int old_ids = atomic_read(&map[offset / ID_PER_SC].ids);
-
-	BUILD_BUG_ON(!is_power_of_2(ID_PER_SC));
-	BUILD_BUG_ON(sizeof(struct swap_cgroup) != sizeof(atomic_t));
-
-	return (old_ids >> shift) & ID_MASK;
-}
-
-static unsigned short __swap_cgroup_id_xchg(struct swap_cgroup *map,
-					    pgoff_t offset,
-					    unsigned short new_id)
-{
-	unsigned short old_id;
-	struct swap_cgroup *sc = &map[offset / ID_PER_SC];
-	unsigned int shift = (offset % ID_PER_SC) * ID_SHIFT;
-	unsigned int new_ids, old_ids = atomic_read(&sc->ids);
-
-	do {
-		old_id = (old_ids >> shift) & ID_MASK;
-		new_ids = (old_ids & ~(ID_MASK << shift));
-		new_ids |= ((unsigned int)new_id) << shift;
-	} while (!atomic_try_cmpxchg(&sc->ids, &old_ids, new_ids));
-
-	return old_id;
-}
-
-/**
- * swap_cgroup_record - record mem_cgroup for a set of swap entries.
- * These entries must belong to one single folio, and that folio
- * must be being charged for swap space (swap out), and these
- * entries must not have been charged
- *
- * @folio: the folio that the swap entry belongs to
- * @id: mem_cgroup ID to be recorded
- * @ent: the first swap entry to be recorded
- */
-void swap_cgroup_record(struct folio *folio, unsigned short id,
-			swp_entry_t ent)
-{
-	unsigned int nr_ents = folio_nr_pages(folio);
-	swp_slot_t slot = swp_entry_to_swp_slot(ent);
-	struct swap_cgroup *map;
-	pgoff_t offset, end;
-	unsigned short old;
-
-	offset = swp_slot_offset(slot);
-	end = offset + nr_ents;
-	map = swap_cgroup_ctrl[swp_slot_type(slot)].map;
-
-	do {
-		old = __swap_cgroup_id_xchg(map, offset, id);
-		VM_BUG_ON(old);
-	} while (++offset != end);
-}
-
-/**
- * swap_cgroup_clear - clear mem_cgroup for a set of swap entries.
- * These entries must be being uncharged from swap. They either
- * belongs to one single folio in the swap cache (swap in for
- * cgroup v1), or no longer have any users (slot freeing).
- *
- * @ent: the first swap entry to be recorded into
- * @nr_ents: number of swap entries to be recorded
- *
- * Returns the existing old value.
- */
-unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents)
-{
-	swp_slot_t slot = swp_entry_to_swp_slot(ent);
-	pgoff_t offset = swp_slot_offset(slot);
-	pgoff_t end = offset + nr_ents;
-	struct swap_cgroup *map;
-	unsigned short old, iter = 0;
-
-	map = swap_cgroup_ctrl[swp_slot_type(slot)].map;
-
-	do {
-		old = __swap_cgroup_id_xchg(map, offset, 0);
-		if (!iter)
-			iter = old;
-		VM_BUG_ON(iter != old);
-	} while (++offset != end);
-
-	return old;
-}
-
-/**
- * lookup_swap_cgroup_id - lookup mem_cgroup id tied to swap entry
- * @ent: swap entry to be looked up.
- *
- * Returns ID of mem_cgroup at success. 0 at failure. (0 is invalid ID)
- */
-unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
-{
-	struct swap_cgroup_ctrl *ctrl;
-	swp_slot_t slot = swp_entry_to_swp_slot(ent);
-
-	if (mem_cgroup_disabled())
-		return 0;
-
-	ctrl = &swap_cgroup_ctrl[swp_slot_type(slot)];
-	return __swap_cgroup_id_lookup(ctrl->map, swp_slot_offset(slot));
-}
-
-int swap_cgroup_swapon(int type, unsigned long max_pages)
-{
-	struct swap_cgroup *map;
-	struct swap_cgroup_ctrl *ctrl;
-
-	if (mem_cgroup_disabled())
-		return 0;
-
-	BUILD_BUG_ON(sizeof(unsigned short) * ID_PER_SC !=
-		     sizeof(struct swap_cgroup));
-	map = vzalloc(DIV_ROUND_UP(max_pages, ID_PER_SC) *
-		      sizeof(struct swap_cgroup));
-	if (!map)
-		goto nomem;
-
-	ctrl = &swap_cgroup_ctrl[type];
-	mutex_lock(&swap_cgroup_mutex);
-	ctrl->map = map;
-	mutex_unlock(&swap_cgroup_mutex);
-
-	return 0;
-nomem:
-	pr_info("couldn't allocate enough memory for swap_cgroup\n");
-	pr_info("swap_cgroup can be disabled by swapaccount=0 boot option\n");
-	return -ENOMEM;
-}
-
-void swap_cgroup_swapoff(int type)
-{
-	struct swap_cgroup *map;
-	struct swap_cgroup_ctrl *ctrl;
-
-	if (mem_cgroup_disabled())
-		return;
-
-	mutex_lock(&swap_cgroup_mutex);
-	ctrl = &swap_cgroup_ctrl[type];
-	map = ctrl->map;
-	ctrl->map = NULL;
-	mutex_unlock(&swap_cgroup_mutex);
-
-	vfree(map);
-}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a47e024f2152c..adfcce286258f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2934,8 +2934,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	vfree(swap_map);
 	kvfree(zeromap);
 	free_cluster_info(cluster_info, maxpages);
-	/* Destroy swap account information */
-	swap_cgroup_swapoff(p->type);
 
 	inode = mapping->host;
 
@@ -3500,10 +3498,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
-	error = swap_cgroup_swapon(si->type, maxpages);
-	if (error)
-		goto bad_swap_unlock_inode;
-
 	error = setup_swap_map(si, swap_header, swap_map, maxpages);
 	if (error)
 		goto bad_swap_unlock_inode;
@@ -3608,7 +3602,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	si->global_cluster = NULL;
 	inode = NULL;
 	destroy_swap_extents(si);
-	swap_cgroup_swapoff(si->type);
 	spin_lock(&swap_lock);
 	si->swap_file = NULL;
 	si->flags = 0;
diff --git a/mm/vswap.c b/mm/vswap.c
index 9b2122647b850..d85fd0fdace97 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -41,6 +41,7 @@
  * @zswap_entry: The zswap entry associated with this swap slot.
  * @swap_cache: The folio in swap cache.
  * @shadow: The shadow entry.
+ * @memcgid: The memcg id of the owning memcg, if any.
  */
 struct swp_desc {
 	swp_slot_t slot;
@@ -49,6 +50,9 @@ struct swp_desc {
 		struct folio *swap_cache;
 		void *shadow;
 	};
+#ifdef CONFIG_MEMCG
+	unsigned short memcgid;
+#endif
 };
 
 #define VSWAP_CLUSTER_SHIFT HPAGE_PMD_ORDER
@@ -242,6 +246,9 @@ static void __vswap_alloc_from_cluster(struct vswap_cluster *cluster, int start)
 		desc = &cluster->descriptors[start + i];
 		desc->slot.val = 0;
 		desc->zswap_entry = NULL;
+#ifdef CONFIG_MEMCG
+		desc->memcgid = 0;
+#endif
 	}
 	cluster->count += nr;
 }
@@ -1108,6 +1115,141 @@ bool zswap_empty(swp_entry_t swpentry)
 }
 #endif /* CONFIG_ZSWAP */
 
+#ifdef CONFIG_MEMCG
+/*
+ * __vswap_cgroup_record - record mem_cgroup for a set of swap entries.
+ *
+ * Entered with the cluster locked. We will exit the function with the cluster
+ * still locked.
+ */
+static unsigned short __vswap_cgroup_record(struct vswap_cluster *cluster,
+				swp_entry_t entry, unsigned short memcgid,
+				unsigned int nr_ents)
+{
+	struct swp_desc *desc;
+	unsigned short oldid, iter = 0;
+	int i;
+
+	for (i = 0; i < nr_ents; i++) {
+		desc = __vswap_iter(cluster, entry.val + i);
+		VM_WARN_ON(!desc);
+		oldid = desc->memcgid;
+		desc->memcgid = memcgid;
+		if (!iter)
+			iter = oldid;
+		VM_WARN_ON(iter != oldid);
+	}
+
+	return oldid;
+}
+
+static unsigned short vswap_cgroup_record(swp_entry_t entry,
+				unsigned short memcgid, unsigned int nr_ents)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	unsigned short oldid;
+
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	VM_WARN_ON(!desc);
+	oldid = __vswap_cgroup_record(cluster, entry, memcgid, nr_ents);
+	spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+
+	return oldid;
+}
+
+/**
+ * swap_cgroup_record - record mem_cgroup for a set of swap entries.
+ * These entries must belong to one single folio, and that folio
+ * must be being charged for swap space (swap out), and these
+ * entries must not have been charged
+ *
+ * @folio: the folio that the swap entry belongs to
+ * @memcgid: mem_cgroup ID to be recorded
+ * @entry: the first swap entry to be recorded
+ */
+void swap_cgroup_record(struct folio *folio, unsigned short memcgid,
+			swp_entry_t entry)
+{
+	unsigned short oldid =
+		vswap_cgroup_record(entry, memcgid, folio_nr_pages(folio));
+
+	VM_WARN_ON(oldid);
+}
+
+/**
+ * __swap_cgroup_record - record mem_cgroup for a set of swap entries.
+ *
+ * Same as swap_cgroup_record, but assumes the swap cache (vswap cluster)
+ * lock is already held.
+ *
+ * @folio: the folio that the swap entry belongs to
+ * @memcgid: mem_cgroup ID to be recorded
+ * @entry: the first swap entry to be recorded
+ */
+void __swap_cgroup_record(struct folio *folio, unsigned short memcgid,
+			  swp_entry_t entry)
+{
+	struct vswap_cluster *cluster;
+	unsigned long cluster_id = VSWAP_CLUSTER_IDX(entry);
+	unsigned short oldid;
+
+	rcu_read_lock();
+	cluster = xa_load(&vswap_cluster_map, cluster_id);
+	VM_WARN_ON(!cluster);
+	oldid = __vswap_cgroup_record(cluster, entry, memcgid,
+				      folio_nr_pages(folio));
+	rcu_read_unlock();
+
+	VM_WARN_ON(oldid);
+}
+
+/**
+ * swap_cgroup_clear - clear mem_cgroup for a set of swap entries.
+ * These entries must be being uncharged from swap. They either
+ * belongs to one single folio in the swap cache (swap in for
+ * cgroup v1), or no longer have any users (slot freeing).
+ *
+ * @entry: the first swap entry to be recorded into
+ * @nr_ents: number of swap entries to be recorded
+ *
+ * Returns the existing old value.
+ */
+unsigned short swap_cgroup_clear(swp_entry_t entry, unsigned int nr_ents)
+{
+	return vswap_cgroup_record(entry, 0, nr_ents);
+}
+
+/**
+ * lookup_swap_cgroup_id - lookup mem_cgroup id tied to swap entry
+ * @entry: swap entry to be looked up.
+ *
+ * Returns ID of mem_cgroup at success. 0 at failure. (0 is invalid ID)
+ */
+unsigned short lookup_swap_cgroup_id(swp_entry_t entry)
+{
+	struct vswap_cluster *cluster = NULL;
+	struct swp_desc *desc;
+	unsigned short ret;
+
+	/*
+	 * Note that the virtual swap slot can be freed under us, for instance in
+	 * the invocation of mem_cgroup_swapin_charge_folio. We need to wrap the
+	 * entire lookup in RCU read-side critical section, and double check the
+	 * existence of the swap descriptor.
+	 */
+	rcu_read_lock();
+	desc = vswap_iter(&cluster, entry.val);
+	ret = desc ? desc->memcgid : 0;
+	if (cluster)
+		spin_unlock(&cluster->lock);
+	rcu_read_unlock();
+	return ret;
+}
+#endif /* CONFIG_MEMCG */
+
 int vswap_init(void)
 {
 	int i;
-- 
2.52.0


