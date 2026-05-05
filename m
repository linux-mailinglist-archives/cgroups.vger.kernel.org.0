Return-Path: <cgroups+bounces-15607-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFxlIXkP+mntIgMAu9opvQ
	(envelope-from <cgroups+bounces-15607-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:40:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1F84D05D5
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4961F308D929
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B148A2AC;
	Tue,  5 May 2026 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPdOZ0N0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C91481FD9
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995544; cv=none; b=tfssMTL+LrpkB5GAzYdOsM37fGevSMTlYPhh3NS4mveASBl5wg0XwGEUuC5E7s2Sp7tI/igqyCGZmQ7X0XR3yYzSbkhScwg46kjW0FZswQAH6jZGTItYm65IYYRzLLjyu7kTiTtdPp19lczyZt1wi19px4lHE+n0Uxalk3nTf1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995544; c=relaxed/simple;
	bh=+/wTn7+qyNbjtXRmK8/m4I7YlX7MUYsOWRWikeQDbrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQjqtLSJ9H0jTbxCedCaE9Zp1H99cQx2wU5Fp+uRXsP80fLWBwBkzHFbwDWrYADiz2TLTcHZ71EMCnUDJTH8E6+UskP/n6x+MO2/ug2o+jKWLzAJvlZN4xWQEDn90XeOgiU1c15Isr7Dd2gfH2NqTPEtWLkYS/yyQdDBDRAQi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPdOZ0N0; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45f053b7b90so3231549b6e.0
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995539; x=1778600339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPaTYOdMOSuO3jTRT9FD8KdRm4JxTltO7CFQr2l2uoo=;
        b=MPdOZ0N0UZiT77CjK+tkYZ4W3otA2UdXD8x4m0wADoJv/EDF30d3k+BASnTNaiXmq5
         eu6k19GOBQ/dvPO+roUsCt1VGIhpwvZfXZQ98cgRMkGmpAqE7oIp5yBQps+lYaS4RjBk
         MKeOZvyVSpby3MmS0Q5+2XAjuWIWqCidJXPKMLOrLHazWMwPI3iSW3l2Rtc6ACHfwO9u
         vsyxhMwwWGzLXATIxRlHzJyBlcMEJWcYaGje7prOKGbwi9Vg1bdaRiArg7wbYa4874r6
         lqHE6/Sn7RFZPSA7pBaKIFJhO4kQ9X5OHwoWwHl5JP2TxO7jTk4tzoPQlz3oR2owO+rz
         Cu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995539; x=1778600339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WPaTYOdMOSuO3jTRT9FD8KdRm4JxTltO7CFQr2l2uoo=;
        b=rNVXrPM6Y27G2dcRmbVwRy4WCZNSJH5SNUeNQxHDV2b5RdYyF4MDCmDOZTOvOtk/9q
         xCALALlyse5dYVEjOFHK0RXbTIXu2eBIw0mIVt3dL4DYAKRd4eC7SbQPHthHTN7J8h5O
         sUSLecLOV7/ZE9FrJd1GuVrYAF4/1mkF5BjxHPhs+UGTUrC4/o3gszikqoikwcKnrasa
         KP45tOKOJc1ijK+vkg8KisfFHzkZJY4A2jRE3QMDVx3sIgPzG0Wj8hFpb+CDpThS58TF
         2S+W69puBv6xkU8elqTjPPrjX8CVUdohi7OBnNykVx3Q0156eDleuIDldqraVtJNFMme
         UWpg==
X-Forwarded-Encrypted: i=1; AFNElJ+/GFM4ia5niyBnNOjBpJuBxAeQeor4gGgZ5vYgAO9MXugrR8zdN/rmvR9PlSRe1CizgO9ozF+P@vger.kernel.org
X-Gm-Message-State: AOJu0YzXIRZuNMiLnnBD11drcRO5DUciCOwL487zIixmMGI2iqosIeuM
	BQt/y3Du7Rhwo7LxomJ3681bp07CyWjYRkbFyzRYvoeK6pm4FgP7tAPj
X-Gm-Gg: AeBDievp+UVZhQWDY53D7w0V95G670bORa36Vjlco4PA7BdEPnJPMZe3biDoGV4cYaI
	cqb9+6aGE9qrNnrYPmsNlAroQt3YLwv5gkmATiBf5N3hVATCnw9SbNW34UkwnH+bTXysjh16BWg
	IwQ7JImDdmlBGJdG2iTPmAaRmVNQN1Ocv3bBoVSeNMnxdqejB12gl7npuCzzlJwgDxUM+SFIAAP
	ht4KvZCupedBB2hw5cT2GEzYYVM4ivdovlf/wCABcgQaSzloiMfNG4QW1MXD7MyT1tosSySXV9n
	qRnHxMplHWqsDB9aq2pr8HaIiMPEsOkA1se3p5FjqlQjFe1LbX+RG99TA2aiCKAOrdnHbP/kQBW
	3vTAR37GkoHWx/iGMQogRjPZHj+33lMP0AlraxNrkfcUsZ/pYLKhcuUnujJJY9Do6hoGxryIcmi
	wXtGZzGr2+s9+mchVUqmDW5rpLGv8+wj3IFOi/5tK5MCgOlx/QszHAY9g0
X-Received: by 2002:a05:6808:c236:b0:479:d4df:69fd with SMTP id 5614622812f47-47c8927873dmr7760415b6e.27.1777995539153;
        Tue, 05 May 2026 08:38:59 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f9dsm8885796b6e.16.2026.05.05.08.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:38:57 -0700 (PDT)
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
Subject: [PATCH v6 01/22] mm/swap: decouple swap cache from physical swap infrastructure
Date: Tue,  5 May 2026 08:38:30 -0700
Message-ID: <20260505153854.1612033-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260505153854.1612033-1-nphamcs@gmail.com>
References: <20260505153854.1612033-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D1F84D05D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15607-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kvack.org:email,tencent.com:email]

When we virtualize the swap space, we will manage swap cache at the
virtual swap layer. To prepare for this, decouple swap cache from
physical swap infrastructure.

We will also remove all the swap cache related helpers of swap table. We
will keep the rest of the swap table infrastructure, which will be
repurposed to serve as the rmap (physical -> virtual swap mapping)
later.

Note that with this patch, we will move to a single global lock to
synchronize swap cache accesses. This is temporarily, as the swap cache
will be re-partitioned in to (virtual) swap clusters once we move the
swap cache to the soon-to-be-introduced virtual swap layer.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 Documentation/mm/index.rst      |   1 -
 Documentation/mm/swap-table.rst |  69 -----------
 MAINTAINERS                     |   1 -
 mm/huge_memory.c                |  11 +-
 mm/migrate.c                    |  13 +-
 mm/shmem.c                      |   7 +-
 mm/swap.h                       | 138 +++++++--------------
 mm/swap_state.c                 | 204 ++++++++++++++++++--------------
 mm/swap_table.h                 |  78 +-----------
 mm/swapfile.c                   |  45 +++----
 mm/vmscan.c                     |   9 +-
 11 files changed, 189 insertions(+), 387 deletions(-)
 delete mode 100644 Documentation/mm/swap-table.rst

diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
index 7aa2a8886908..c504156149a0 100644
--- a/Documentation/mm/index.rst
+++ b/Documentation/mm/index.rst
@@ -20,7 +20,6 @@ see the :doc:`admin guide <../admin-guide/mm/index>`.
    highmem
    page_reclaim
    swap
-   swap-table
    page_cache
    shmfs
    oom
diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-table.rst
deleted file mode 100644
index da10bb7a0dc3..000000000000
--- a/Documentation/mm/swap-table.rst
+++ /dev/null
@@ -1,69 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-:Author: Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
-
-==========
-Swap Table
-==========
-
-Swap table implements swap cache as a per-cluster swap cache value array.
-
-Swap Entry
-----------
-
-A swap entry contains the information required to serve the anonymous page
-fault.
-
-Swap entry is encoded as two parts: swap type and swap offset.
-
-The swap type indicates which swap device to use.
-The swap offset is the offset of the swap file to read the page data from.
-
-Swap Cache
-----------
-
-Swap cache is a map to look up folios using swap entry as the key. The result
-value can have three possible types depending on which stage of this swap entry
-was in.
-
-1. NULL: This swap entry is not used.
-
-2. folio: A folio has been allocated and bound to this swap entry. This is
-   the transient state of swap out or swap in. The folio data can be in
-   the folio or swap file, or both.
-
-3. shadow: The shadow contains the working set information of the swapped
-   out folio. This is the normal state for a swapped out page.
-
-Swap Table Internals
---------------------
-
-The previous swap cache is implemented by XArray. The XArray is a tree
-structure. Each lookup will go through multiple nodes. Can we do better?
-
-Notice that most of the time when we look up the swap cache, we are either
-in a swap in or swap out path. We should already have the swap cluster,
-which contains the swap entry.
-
-If we have a per-cluster array to store swap cache value in the cluster.
-Swap cache lookup within the cluster can be a very simple array lookup.
-
-We give such a per-cluster swap cache value array a name: the swap table.
-
-A swap table is an array of pointers. Each pointer is the same size as a
-PTE. The size of a swap table for one swap cluster typically matches a PTE
-page table, which is one page on modern 64-bit systems.
-
-With swap table, swap cache lookup can achieve great locality, simpler,
-and faster.
-
-Locking
--------
-
-Swap table modification requires taking the cluster lock. If a folio
-is being added to or removed from the swap table, the folio must be
-locked prior to the cluster lock. After adding or removing is done, the
-folio shall be unlocked.
-
-Swap table lookup is protected by RCU and atomic read. If the lookup
-returns a folio, the user must lock the folio before use.
diff --git a/MAINTAINERS b/MAINTAINERS
index e08767323763..d3780bb33037 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16730,7 +16730,6 @@ R:	Baoquan He <bhe@redhat.com>
 R:	Barry Song <baohua@kernel.org>
 L:	linux-mm@kvack.org
 S:	Maintained
-F:	Documentation/mm/swap-table.rst
 F:	include/linux/swap.h
 F:	include/linux/swapfile.h
 F:	include/linux/swapops.h
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 40cf59301c21..21215ac87014 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3783,7 +3783,6 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 	/* Prevent deferred_split_scan() touching ->_refcount */
 	ds_queue = folio_split_queue_lock(folio);
 	if (folio_ref_freeze(folio, folio_cache_ref_count(folio) + 1)) {
-		struct swap_cluster_info *ci = NULL;
 		struct lruvec *lruvec;
 
 		if (old_order > 1) {
@@ -3826,7 +3825,7 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 				return -EINVAL;
 			}
 
-			ci = swap_cluster_get_and_lock(folio);
+			swap_cache_lock();
 		}
 
 		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
@@ -3862,8 +3861,8 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 			 * Anonymous folio with swap cache.
 			 * NOTE: shmem in swap cache is not supported yet.
 			 */
-			if (ci) {
-				__swap_cache_replace_folio(ci, folio, new_folio);
+			if (folio_test_swapcache(folio)) {
+				__swap_cache_replace_folio(folio, new_folio);
 				continue;
 			}
 
@@ -3901,8 +3900,8 @@ static int __folio_freeze_and_split_unmapped(struct folio *folio, unsigned int n
 		if (do_lru)
 			unlock_page_lruvec(lruvec);
 
-		if (ci)
-			swap_cluster_unlock(ci);
+		if (folio_test_swapcache(folio))
+			swap_cache_unlock();
 	} else {
 		split_queue_unlock(ds_queue);
 		return -EAGAIN;
diff --git a/mm/migrate.c b/mm/migrate.c
index 4688b9e38cd2..11d9b43dff5d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -571,7 +571,6 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int expected_count)
 {
 	XA_STATE(xas, &mapping->i_pages, folio->index);
-	struct swap_cluster_info *ci = NULL;
 	struct zone *oldzone, *newzone;
 	int dirty;
 	long nr = folio_nr_pages(folio);
@@ -601,13 +600,13 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	newzone = folio_zone(newfolio);
 
 	if (folio_test_swapcache(folio))
-		ci = swap_cluster_get_and_lock_irq(folio);
+		swap_cache_lock_irq();
 	else
 		xas_lock_irq(&xas);
 
 	if (!folio_ref_freeze(folio, expected_count)) {
-		if (ci)
-			swap_cluster_unlock_irq(ci);
+		if (folio_test_swapcache(folio))
+			swap_cache_unlock_irq();
 		else
 			xas_unlock_irq(&xas);
 		return -EAGAIN;
@@ -640,7 +639,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	}
 
 	if (folio_test_swapcache(folio))
-		__swap_cache_replace_folio(ci, folio, newfolio);
+		__swap_cache_replace_folio(folio, newfolio);
 	else
 		xas_store(&xas, newfolio);
 
@@ -652,8 +651,8 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	folio_ref_unfreeze(folio, expected_count - nr);
 
 	/* Leave irq disabled to prevent preemption while updating stats */
-	if (ci)
-		swap_cluster_unlock(ci);
+	if (folio_test_swapcache(folio))
+		swap_cache_unlock();
 	else
 		xas_unlock(&xas);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 79af5f9f8b90..1db97ef2d14e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2133,7 +2133,6 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 				struct shmem_inode_info *info, pgoff_t index,
 				struct vm_area_struct *vma)
 {
-	struct swap_cluster_info *ci;
 	struct folio *new, *old = *foliop;
 	swp_entry_t entry = old->swap;
 	int nr_pages = folio_nr_pages(old);
@@ -2166,12 +2165,12 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	new->swap = entry;
 	folio_set_swapcache(new);
 
-	ci = swap_cluster_get_and_lock_irq(old);
-	__swap_cache_replace_folio(ci, old, new);
+	swap_cache_lock_irq();
+	__swap_cache_replace_folio(old, new);
 	mem_cgroup_replace_folio(old, new);
 	shmem_update_stats(new, nr_pages);
 	shmem_update_stats(old, -nr_pages);
-	swap_cluster_unlock_irq(ci);
+	swap_cache_unlock_irq();
 
 	folio_add_lru(new);
 	*foliop = new;
diff --git a/mm/swap.h b/mm/swap.h
index 1bd466da3039..c1e7d4713bd7 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -94,8 +94,16 @@ static inline struct swap_cluster_info *__swap_entry_to_cluster(swp_entry_t entr
 					swp_offset(entry));
 }
 
-static __always_inline struct swap_cluster_info *__swap_cluster_lock(
-		struct swap_info_struct *si, unsigned long offset, bool irq)
+/**
+ * swap_cluster_lock - Lock and return the swap cluster of given offset.
+ * @si: swap device the cluster belongs to.
+ * @offset: the swap slot offset, pointing to a valid slot.
+ *
+ * Context: The caller must ensure the offset is in the valid range and
+ * protect the swap device with reference count or locks.
+ */
+static inline struct swap_cluster_info *swap_cluster_lock(
+		struct swap_info_struct *si, unsigned long offset)
 {
 	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
 
@@ -110,79 +118,15 @@ static __always_inline struct swap_cluster_info *__swap_cluster_lock(
 	 */
 	VM_WARN_ON_ONCE(!in_task());
 	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
-	if (irq)
-		spin_lock_irq(&ci->lock);
-	else
-		spin_lock(&ci->lock);
+	spin_lock(&ci->lock);
 	return ci;
 }
 
-/**
- * swap_cluster_lock - Lock and return the swap cluster of given offset.
- * @si: swap device the cluster belongs to.
- * @offset: the swap entry offset, pointing to a valid slot.
- *
- * Context: The caller must ensure the offset is in the valid range and
- * protect the swap device with reference count or locks.
- */
-static inline struct swap_cluster_info *swap_cluster_lock(
-		struct swap_info_struct *si, unsigned long offset)
-{
-	return __swap_cluster_lock(si, offset, false);
-}
-
-static inline struct swap_cluster_info *__swap_cluster_get_and_lock(
-		const struct folio *folio, bool irq)
-{
-	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
-	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
-	return __swap_cluster_lock(__swap_entry_to_info(folio->swap),
-				   swp_offset(folio->swap), irq);
-}
-
-/*
- * swap_cluster_get_and_lock - Locks the cluster that holds a folio's entries.
- * @folio: The folio.
- *
- * This locks and returns the swap cluster that contains a folio's swap
- * entries. The swap entries of a folio are always in one single cluster.
- * The folio has to be locked so its swap entries won't change and the
- * cluster won't be freed.
- *
- * Context: Caller must ensure the folio is locked and in the swap cache.
- * Return: Pointer to the swap cluster.
- */
-static inline struct swap_cluster_info *swap_cluster_get_and_lock(
-		const struct folio *folio)
-{
-	return __swap_cluster_get_and_lock(folio, false);
-}
-
-/*
- * swap_cluster_get_and_lock_irq - Locks the cluster that holds a folio's entries.
- * @folio: The folio.
- *
- * Same as swap_cluster_get_and_lock but also disable IRQ.
- *
- * Context: Caller must ensure the folio is locked and in the swap cache.
- * Return: Pointer to the swap cluster.
- */
-static inline struct swap_cluster_info *swap_cluster_get_and_lock_irq(
-		const struct folio *folio)
-{
-	return __swap_cluster_get_and_lock(folio, true);
-}
-
 static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
 {
 	spin_unlock(&ci->lock);
 }
 
-static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
-{
-	spin_unlock_irq(&ci->lock);
-}
-
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
@@ -199,6 +143,11 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 
 /* linux/mm/swap_state.c */
 extern struct address_space swap_space __read_mostly;
+void swap_cache_lock_irq(void);
+void swap_cache_unlock_irq(void);
+void swap_cache_lock(void);
+void swap_cache_unlock(void);
+
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
 	return &swap_space;
@@ -247,14 +196,13 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
-void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow);
+int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
+			 gfp_t gfp, void **shadow);
 void swap_cache_del_folio(struct folio *folio);
-/* Below helpers require the caller to lock and pass in the swap cluster. */
-void __swap_cache_del_folio(struct swap_cluster_info *ci,
-			    struct folio *folio, swp_entry_t entry, void *shadow);
-void __swap_cache_replace_folio(struct swap_cluster_info *ci,
-				struct folio *old, struct folio *new);
-void __swap_cache_clear_shadow(swp_entry_t entry, int nr_ents);
+/* Below helpers require the caller to lock the swap cache. */
+void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow);
+void __swap_cache_replace_folio(struct folio *old, struct folio *new);
+void swap_cache_clear_shadow(swp_entry_t entry, int nr_ents);
 
 void show_swap_cache_info(void);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
@@ -328,26 +276,10 @@ static inline struct swap_cluster_info *swap_cluster_lock(
 	return NULL;
 }
 
-static inline struct swap_cluster_info *swap_cluster_get_and_lock(
-		struct folio *folio)
-{
-	return NULL;
-}
-
-static inline struct swap_cluster_info *swap_cluster_get_and_lock_irq(
-		struct folio *folio)
-{
-	return NULL;
-}
-
 static inline void swap_cluster_unlock(struct swap_cluster_info *ci)
 {
 }
 
-static inline void swap_cluster_unlock_irq(struct swap_cluster_info *ci)
-{
-}
-
 static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
 {
 	return NULL;
@@ -411,21 +343,37 @@ static inline void *swap_cache_get_shadow(swp_entry_t entry)
 	return NULL;
 }
 
-static inline void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadow)
+static inline int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
+				       gfp_t gfp, void **shadow)
 {
+	return 0;
 }
 
 static inline void swap_cache_del_folio(struct folio *folio)
 {
 }
 
-static inline void __swap_cache_del_folio(struct swap_cluster_info *ci,
-		struct folio *folio, swp_entry_t entry, void *shadow)
+static inline void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow)
+{
+}
+
+static inline void __swap_cache_replace_folio(struct folio *old, struct folio *new)
+{
+}
+
+static inline void swap_cache_lock_irq(void)
+{
+}
+
+static inline void swap_cache_unlock_irq(void)
+{
+}
+
+static inline void swap_cache_lock(void)
 {
 }
 
-static inline void __swap_cache_replace_folio(struct swap_cluster_info *ci,
-		struct folio *old, struct folio *new)
+static inline void swap_cache_unlock(void)
 {
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 44d228982521..01212975c00c 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -22,8 +22,8 @@
 #include <linux/vmalloc.h>
 #include <linux/huge_mm.h>
 #include <linux/shmem_fs.h>
+#include <linux/xarray.h>
 #include "internal.h"
-#include "swap_table.h"
 #include "swap.h"
 
 /*
@@ -41,6 +41,28 @@ struct address_space swap_space __read_mostly = {
 	.a_ops = &swap_aops,
 };
 
+static DEFINE_XARRAY(swap_cache);
+
+void swap_cache_lock_irq(void)
+{
+	xa_lock_irq(&swap_cache);
+}
+
+void swap_cache_unlock_irq(void)
+{
+	xa_unlock_irq(&swap_cache);
+}
+
+void swap_cache_lock(void)
+{
+	xa_lock(&swap_cache);
+}
+
+void swap_cache_unlock(void)
+{
+	xa_unlock(&swap_cache);
+}
+
 static bool enable_vma_readahead __read_mostly = true;
 
 #define SWAP_RA_ORDER_CEILING	5
@@ -86,17 +108,22 @@ void show_swap_cache_info(void)
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry)
 {
-	unsigned long swp_tb;
+	void *entry_val;
 	struct folio *folio;
 
 	for (;;) {
-		swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
-					swp_cluster_offset(entry));
-		if (!swp_tb_is_folio(swp_tb))
+		rcu_read_lock();
+		entry_val = xa_load(&swap_cache, entry.val);
+		if (!entry_val || xa_is_value(entry_val)) {
+			rcu_read_unlock();
 			return NULL;
-		folio = swp_tb_to_folio(swp_tb);
-		if (likely(folio_try_get(folio)))
+		}
+		folio = entry_val;
+		if (likely(folio_try_get(folio))) {
+			rcu_read_unlock();
 			return folio;
+		}
+		rcu_read_unlock();
 	}
 
 	return NULL;
@@ -112,12 +139,14 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
  */
 void *swap_cache_get_shadow(swp_entry_t entry)
 {
-	unsigned long swp_tb;
+	void *entry_val;
+
+	rcu_read_lock();
+	entry_val = xa_load(&swap_cache, entry.val);
+	rcu_read_unlock();
 
-	swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
-				swp_cluster_offset(entry));
-	if (swp_tb_is_shadow(swp_tb))
-		return swp_tb_to_shadow(swp_tb);
+	if (xa_is_value(entry_val))
+		return entry_val;
 	return NULL;
 }
 
@@ -132,46 +161,58 @@ void *swap_cache_get_shadow(swp_entry_t entry)
  * with reference count or locks.
  * The caller also needs to update the corresponding swap_map slots with
  * SWAP_HAS_CACHE bit to avoid race or conflict.
+ *
+ * Return: 0 on success, negative error code on failure.
  */
-void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp)
+int swap_cache_add_folio(struct folio *folio, swp_entry_t entry, gfp_t gfp, void **shadowp)
 {
-	void *shadow = NULL;
-	unsigned long old_tb, new_tb;
-	struct swap_cluster_info *ci;
-	unsigned int ci_start, ci_off, ci_end;
+	XA_STATE_ORDER(xas, &swap_cache, entry.val, folio_order(folio));
 	unsigned long nr_pages = folio_nr_pages(folio);
+	unsigned long i;
+	void *old;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_swapcache(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapbacked(folio), folio);
 
-	new_tb = folio_to_swp_tb(folio);
-	ci_start = swp_cluster_offset(entry);
-	ci_end = ci_start + nr_pages;
-	ci_off = ci_start;
-	ci = swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(entry));
-	do {
-		old_tb = __swap_table_xchg(ci, ci_off, new_tb);
-		WARN_ON_ONCE(swp_tb_is_folio(old_tb));
-		if (swp_tb_is_shadow(old_tb))
-			shadow = swp_tb_to_shadow(old_tb);
-	} while (++ci_off < ci_end);
-
 	folio_ref_add(folio, nr_pages);
 	folio_set_swapcache(folio);
 	folio->swap = entry;
-	swap_cluster_unlock(ci);
 
-	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
-	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
+	do {
+		xas_lock_irq(&xas);
+		xas_create_range(&xas);
+		if (xas_error(&xas))
+			goto unlock;
+		for (i = 0; i < nr_pages; i++) {
+			VM_BUG_ON_FOLIO(xas.xa_index != entry.val + i, folio);
+			old = xas_load(&xas);
+			if (old && !xa_is_value(old)) {
+				VM_WARN_ON_ONCE_FOLIO(1, folio);
+				xas_set_err(&xas, -EEXIST);
+				goto unlock;
+			}
+			if (shadowp && xa_is_value(old) && !*shadowp)
+				*shadowp = old;
+			xas_store(&xas, folio);
+			xas_next(&xas);
+		}
+		node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+		lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
+unlock:
+		xas_unlock_irq(&xas);
+	} while (xas_nomem(&xas, gfp));
 
-	if (shadowp)
-		*shadowp = shadow;
+	if (!xas_error(&xas))
+		return 0;
+
+	folio_clear_swapcache(folio);
+	folio_ref_sub(folio, nr_pages);
+	return xas_error(&xas);
 }
 
 /**
  * __swap_cache_del_folio - Removes a folio from the swap cache.
- * @ci: The locked swap cluster.
  * @folio: The folio.
  * @entry: The first swap entry that the folio corresponds to.
  * @shadow: shadow value to be filled in the swap cache.
@@ -180,30 +221,24 @@ void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp
  * This won't put the folio's refcount. The caller has to do that.
  *
  * Context: Caller must ensure the folio is locked and in the swap cache
- * using the index of @entry, and lock the cluster that holds the entries.
+ * using the index of @entry, and lock the swap cache xarray.
  */
-void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
-			    swp_entry_t entry, void *shadow)
+void __swap_cache_del_folio(struct folio *folio, swp_entry_t entry, void *shadow)
 {
-	unsigned long old_tb, new_tb;
-	unsigned int ci_start, ci_off, ci_end;
-	unsigned long nr_pages = folio_nr_pages(folio);
+	long nr_pages = folio_nr_pages(folio);
+	XA_STATE(xas, &swap_cache, entry.val);
+	int i;
 
-	VM_WARN_ON_ONCE(__swap_entry_to_cluster(entry) != ci);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(folio_test_writeback(folio), folio);
 
-	new_tb = shadow_swp_to_tb(shadow);
-	ci_start = swp_cluster_offset(entry);
-	ci_end = ci_start + nr_pages;
-	ci_off = ci_start;
-	do {
-		/* If shadow is NULL, we sets an empty shadow */
-		old_tb = __swap_table_xchg(ci, ci_off, new_tb);
-		WARN_ON_ONCE(!swp_tb_is_folio(old_tb) ||
-			     swp_tb_to_folio(old_tb) != folio);
-	} while (++ci_off < ci_end);
+	for (i = 0; i < nr_pages; i++) {
+		void *old = xas_store(&xas, shadow);
+
+		VM_WARN_ON_FOLIO(old != folio, folio);
+		xas_next(&xas);
+	}
 
 	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
@@ -223,12 +258,11 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
  */
 void swap_cache_del_folio(struct folio *folio)
 {
-	struct swap_cluster_info *ci;
 	swp_entry_t entry = folio->swap;
 
-	ci = swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(entry));
-	__swap_cache_del_folio(ci, folio, entry, NULL);
-	swap_cluster_unlock(ci);
+	xa_lock_irq(&swap_cache);
+	__swap_cache_del_folio(folio, entry, NULL);
+	xa_unlock_irq(&swap_cache);
 
 	put_swap_folio(folio, entry);
 	folio_ref_sub(folio, folio_nr_pages(folio));
@@ -236,7 +270,6 @@ void swap_cache_del_folio(struct folio *folio)
 
 /**
  * __swap_cache_replace_folio - Replace a folio in the swap cache.
- * @ci: The locked swap cluster.
  * @old: The old folio to be replaced.
  * @new: The new folio.
  *
@@ -246,39 +279,24 @@ void swap_cache_del_folio(struct folio *folio)
  * the starting offset to override all slots covered by the new folio.
  *
  * Context: Caller must ensure both folios are locked, and lock the
- * cluster that holds the old folio to be replaced.
+ * swap cache xarray.
  */
-void __swap_cache_replace_folio(struct swap_cluster_info *ci,
-				struct folio *old, struct folio *new)
+void __swap_cache_replace_folio(struct folio *old, struct folio *new)
 {
 	swp_entry_t entry = new->swap;
 	unsigned long nr_pages = folio_nr_pages(new);
-	unsigned int ci_off = swp_cluster_offset(entry);
-	unsigned int ci_end = ci_off + nr_pages;
-	unsigned long old_tb, new_tb;
+	XA_STATE(xas, &swap_cache, entry.val);
+	int i;
 
 	VM_WARN_ON_ONCE(!folio_test_swapcache(old) || !folio_test_swapcache(new));
 	VM_WARN_ON_ONCE(!folio_test_locked(old) || !folio_test_locked(new));
 	VM_WARN_ON_ONCE(!entry.val);
 
-	/* Swap cache still stores N entries instead of a high-order entry */
-	new_tb = folio_to_swp_tb(new);
-	do {
-		old_tb = __swap_table_xchg(ci, ci_off, new_tb);
-		WARN_ON_ONCE(!swp_tb_is_folio(old_tb) || swp_tb_to_folio(old_tb) != old);
-	} while (++ci_off < ci_end);
+	for (i = 0; i < nr_pages; i++) {
+		void *old_entry = xas_store(&xas, new);
 
-	/*
-	 * If the old folio is partially replaced (e.g., splitting a large
-	 * folio, the old folio is shrunk, and new split sub folios replace
-	 * the shrunk part), ensure the new folio doesn't overlap it.
-	 */
-	if (IS_ENABLED(CONFIG_DEBUG_VM) &&
-	    folio_order(old) != folio_order(new)) {
-		ci_off = swp_cluster_offset(old->swap);
-		ci_end = ci_off + folio_nr_pages(old);
-		while (ci_off++ < ci_end)
-			WARN_ON_ONCE(swp_tb_to_folio(__swap_table_get(ci, ci_off)) != old);
+		WARN_ON_ONCE(!old_entry || xa_is_value(old_entry) || old_entry != old);
+		xas_next(&xas);
 	}
 }
 
@@ -287,20 +305,19 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
  * @entry: The starting index entry.
  * @nr_ents: How many slots need to be cleared.
  *
- * Context: Caller must ensure the range is valid, all in one single cluster,
- * not occupied by any folio, and lock the cluster.
+ * Context: Caller must ensure the range is valid and not occupied by any folio.
  */
-void __swap_cache_clear_shadow(swp_entry_t entry, int nr_ents)
+void swap_cache_clear_shadow(swp_entry_t entry, int nr_ents)
 {
-	struct swap_cluster_info *ci = __swap_entry_to_cluster(entry);
-	unsigned int ci_off = swp_cluster_offset(entry), ci_end;
-	unsigned long old;
+	XA_STATE(xas, &swap_cache, entry.val);
+	int i;
 
-	ci_end = ci_off + nr_ents;
-	do {
-		old = __swap_table_xchg(ci, ci_off, null_to_swp_tb());
-		WARN_ON_ONCE(swp_tb_is_folio(old));
-	} while (++ci_off < ci_end);
+	xas_lock(&xas);
+	for (i = 0; i < nr_ents; i++) {
+		xas_store(&xas, NULL);
+		xas_next(&xas);
+	}
+	xas_unlock(&xas);
 }
 
 /*
@@ -480,7 +497,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (mem_cgroup_swapin_charge_folio(new_folio, NULL, gfp_mask, entry))
 		goto fail_unlock;
 
-	swap_cache_add_folio(new_folio, entry, &shadow);
+	/* May fail (-ENOMEM) if XArray node allocation failed. */
+	if (swap_cache_add_folio(new_folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
+		goto fail_unlock;
+
 	memcg1_swapin(entry, 1);
 
 	if (shadow)
diff --git a/mm/swap_table.h b/mm/swap_table.h
index ea244a57a5b7..ad2cb2ef4690 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -13,71 +13,6 @@ struct swap_table {
 
 #define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) == PAGE_SIZE)
 
-/*
- * A swap table entry represents the status of a swap slot on a swap
- * (physical or virtual) device. The swap table in each cluster is a
- * 1:1 map of the swap slots in this cluster.
- *
- * Each swap table entry could be a pointer (folio), a XA_VALUE
- * (shadow), or NULL.
- */
-
-/*
- * Helpers for casting one type of info into a swap table entry.
- */
-static inline unsigned long null_to_swp_tb(void)
-{
-	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(atomic_long_t));
-	return 0;
-}
-
-static inline unsigned long folio_to_swp_tb(struct folio *folio)
-{
-	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(void *));
-	return (unsigned long)folio;
-}
-
-static inline unsigned long shadow_swp_to_tb(void *shadow)
-{
-	BUILD_BUG_ON((BITS_PER_XA_VALUE + 1) !=
-		     BITS_PER_BYTE * sizeof(unsigned long));
-	VM_WARN_ON_ONCE(shadow && !xa_is_value(shadow));
-	return (unsigned long)shadow;
-}
-
-/*
- * Helpers for swap table entry type checking.
- */
-static inline bool swp_tb_is_null(unsigned long swp_tb)
-{
-	return !swp_tb;
-}
-
-static inline bool swp_tb_is_folio(unsigned long swp_tb)
-{
-	return !xa_is_value((void *)swp_tb) && !swp_tb_is_null(swp_tb);
-}
-
-static inline bool swp_tb_is_shadow(unsigned long swp_tb)
-{
-	return xa_is_value((void *)swp_tb);
-}
-
-/*
- * Helpers for retrieving info from swap table.
- */
-static inline struct folio *swp_tb_to_folio(unsigned long swp_tb)
-{
-	VM_WARN_ON(!swp_tb_is_folio(swp_tb));
-	return (void *)swp_tb;
-}
-
-static inline void *swp_tb_to_shadow(unsigned long swp_tb)
-{
-	VM_WARN_ON(!swp_tb_is_shadow(swp_tb));
-	return (void *)swp_tb;
-}
-
 /*
  * Helpers for accessing or modifying the swap table of a cluster,
  * the swap cluster must be locked.
@@ -92,17 +27,6 @@ static inline void __swap_table_set(struct swap_cluster_info *ci,
 	atomic_long_set(&table[off], swp_tb);
 }
 
-static inline unsigned long __swap_table_xchg(struct swap_cluster_info *ci,
-					      unsigned int off, unsigned long swp_tb)
-{
-	atomic_long_t *table = rcu_dereference_protected(ci->table, true);
-
-	lockdep_assert_held(&ci->lock);
-	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
-	/* Ordering is guaranteed by cluster lock, relax */
-	return atomic_long_xchg_relaxed(&table[off], swp_tb);
-}
-
 static inline unsigned long __swap_table_get(struct swap_cluster_info *ci,
 					     unsigned int off)
 {
@@ -122,7 +46,7 @@ static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
 
 	rcu_read_lock();
 	table = rcu_dereference(ci->table);
-	swp_tb = table ? atomic_long_read(&table[off]) : null_to_swp_tb();
+	swp_tb = table ? atomic_long_read(&table[off]) : 0;
 	rcu_read_unlock();
 
 	return swp_tb;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 46d2008e4b99..46da28c533bb 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -474,7 +474,7 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 	lockdep_assert_held(&ci->lock);
 	VM_WARN_ON_ONCE(!cluster_is_empty(ci));
 	for (ci_off = 0; ci_off < SWAPFILE_CLUSTER; ci_off++)
-		VM_WARN_ON_ONCE(!swp_tb_is_null(__swap_table_get(ci, ci_off)));
+		VM_WARN_ON_ONCE(__swap_table_get(ci, ci_off));
 	table = (void *)rcu_dereference_protected(ci->table, true);
 	rcu_assign_pointer(ci->table, NULL);
 
@@ -843,26 +843,6 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 	return true;
 }
 
-/*
- * Currently, the swap table is not used for count tracking, just
- * do a sanity check here to ensure nothing leaked, so the swap
- * table should be empty upon freeing.
- */
-static void swap_cluster_assert_table_empty(struct swap_cluster_info *ci,
-				unsigned int start, unsigned int nr)
-{
-	unsigned int ci_off = start % SWAPFILE_CLUSTER;
-	unsigned int ci_end = ci_off + nr;
-	unsigned long swp_tb;
-
-	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
-		do {
-			swp_tb = __swap_table_get(ci, ci_off);
-			VM_WARN_ON_ONCE(!swp_tb_is_null(swp_tb));
-		} while (++ci_off < ci_end);
-	}
-}
-
 static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
 				unsigned int start, unsigned char usage,
 				unsigned int order)
@@ -882,7 +862,6 @@ static bool cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 		ci->order = order;
 
 	memset(si->swap_map + start, usage, nr_pages);
-	swap_cluster_assert_table_empty(ci, start, nr_pages);
 	swap_range_alloc(si, nr_pages);
 	ci->count += nr_pages;
 
@@ -1275,7 +1254,7 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 			swap_slot_free_notify(si->bdev, offset);
 		offset++;
 	}
-	__swap_cache_clear_shadow(swp_entry(si->type, begin), nr_entries);
+	swap_cache_clear_shadow(swp_entry(si->type, begin), nr_entries);
 
 	/*
 	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
@@ -1423,6 +1402,7 @@ int folio_alloc_swap(struct folio *folio)
 	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
 	swp_entry_t entry = {};
+	int err;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
@@ -1457,19 +1437,25 @@ int folio_alloc_swap(struct folio *folio)
 	}
 
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
-	if (mem_cgroup_try_charge_swap(folio, entry))
+	if (mem_cgroup_try_charge_swap(folio, entry)) {
+		err = -ENOMEM;
 		goto out_free;
+	}
 
 	if (!entry.val)
 		return -ENOMEM;
 
-	swap_cache_add_folio(folio, entry, NULL);
+	err = swap_cache_add_folio(folio, entry,
+				   __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
+				   NULL);
+	if (err)
+		goto out_free;
 
 	return 0;
 
 out_free:
 	put_swap_folio(folio, entry);
-	return -ENOMEM;
+	return err;
 }
 
 static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
@@ -1729,7 +1715,6 @@ static void swap_entries_free(struct swap_info_struct *si,
 
 	mem_cgroup_uncharge_swap(entry, nr_pages);
 	swap_range_free(si, offset, nr_pages);
-	swap_cluster_assert_table_empty(ci, offset, nr_pages);
 
 	if (!ci->count)
 		free_cluster(si, ci);
@@ -4057,9 +4042,9 @@ static int __init swapfile_init(void)
 	swapfile_maximum_size = arch_max_swapfile_size();
 
 	/*
-	 * Once a cluster is freed, it's swap table content is read
-	 * only, and all swap cache readers (swap_cache_*) verifies
-	 * the content before use. So it's safe to use RCU slab here.
+	 * Once a cluster is freed, it's swap table content is read only, and
+	 * all swap table readers verify the content before use. So it's safe to
+	 * use RCU slab here.
 	 */
 	if (!SWP_TABLE_USE_PAGE)
 		swap_table_cachep = kmem_cache_create("swap_table",
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 614ccf39fe3f..558ff7f41378 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -707,13 +707,12 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 {
 	int refcount;
 	void *shadow = NULL;
-	struct swap_cluster_info *ci;
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(mapping != folio_mapping(folio));
 
 	if (folio_test_swapcache(folio)) {
-		ci = swap_cluster_get_and_lock_irq(folio);
+		swap_cache_lock_irq();
 	} else {
 		spin_lock(&mapping->host->i_lock);
 		xa_lock_irq(&mapping->i_pages);
@@ -758,9 +757,9 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		__swap_cache_del_folio(ci, folio, swap, shadow);
+		__swap_cache_del_folio(folio, swap, shadow);
 		memcg1_swapout(folio, swap);
-		swap_cluster_unlock_irq(ci);
+		swap_cache_unlock_irq();
 		put_swap_folio(folio, swap);
 	} else {
 		void (*free_folio)(struct folio *);
@@ -799,7 +798,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 cannot_free:
 	if (folio_test_swapcache(folio)) {
-		swap_cluster_unlock_irq(ci);
+		swap_cache_unlock_irq();
 	} else {
 		xa_unlock_irq(&mapping->i_pages);
 		spin_unlock(&mapping->host->i_lock);
-- 
2.52.0


