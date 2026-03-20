Return-Path: <cgroups+bounces-14945-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMA0G8efvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14945-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:28:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5052DFEA1
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13542301EBF8
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC160351C05;
	Fri, 20 Mar 2026 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1qIrHlz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF034D4C2
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034862; cv=none; b=I/OdJxCBNJuTOpT/mnSshU6OfOB2rna5/c8h1TyDup5xV3qKt+y/U+C4ZqxK+oiq4+zBg7H/Ihkab3u+p1E5igt014jKlbBmGh6TMZKBjS3hpDq7GV9w8yskH9TwrMcijgnhhO8T6WJHPW5oezo2KvBo/yBcPrtVsfvgXm4huIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034862; c=relaxed/simple;
	bh=uEuxC+U0EH2cifAJR8TSPQ6DLIW9OBzV0QnjDV2zKyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJtiE0ezrwQ693PRDSsj6ScObT7zLLQOZ62HtIDbzCEr55BXzAmgolnWf5GKtxeWyfHSiMsijhXCtxT9jTXxQJNgJbNClJRI2agntG4eYS1XNExHXbEaSBRB7CCJMmzdfTfTtALt7KLF05oc1vksAPBpd7ru4jHE15CFmL6b7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1qIrHlz; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4670464029eso632914b6e.2
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034858; x=1774639658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF+/JKAJr2pUxH4OXxNVSwNbppDUHY+8lmqC/UiyZ/Q=;
        b=L1qIrHlzoQX+5OaFIx0aF8joi860M4IEHdhhp6ejQJd4OIR7f9QuypYC2OpzPraRZW
         GfV3cKDH9O2diNvljYPtXwGoIEEZsRn7RfyLgFyNtMUnD6dv1aE/FDS5Vr8+zX3IIOsp
         Nv0LVFqc2yPmVqmjOzlSuh5VTDu5Mdg1G9F8YCyGBcNosZtDR+RDJgXcInfuOEXAlLO5
         vAAU97DEb9emHrsIgZAgql6K2RLReo1IP0HEvLs5GHR1RVHAA6hflauYrSTT18z/xZeg
         MZGpRP2MX5QBoxgzY9ih1R7JHmm7mEOfWo+9rHp+93OdKqErQ9959Byg9/nBTlPFlEsA
         2nQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034858; x=1774639658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gF+/JKAJr2pUxH4OXxNVSwNbppDUHY+8lmqC/UiyZ/Q=;
        b=Hc6U4mD6A0h6AZmwdAQlsg10OneZad5tq8Ncj3vGoaKkaAtBLHueIRc+MaA84NmUld
         iBBnDFbUMBv3FflWjbzDqQhbobhm97VlmvsRyuD8A2u/IR9iLJieYbYypR4JatHDhDWg
         vxDLA5TwDx7ScCSty1VFzCw4fxJH5JigIRiuYC8AtOBpmzGqaAfuGbyOOY7NiloHe4lO
         iNNtxAAnY0pWlZeJkIipO10IoPZe8bKgjCM2nasGb/X5LMyMYXNqZcRyIsfMkW79T5LQ
         W/d0ds7Iwv6hyEKXi8asrHGIp9NbVBFU1AV91glbijIEihdl32o+5rLqJd4/Lnia7YyM
         LD2g==
X-Forwarded-Encrypted: i=1; AJvYcCVyNyzEhnTA+ZrIRU6K9bCPcrWyuV0D1LtmAMuiOYkCx2t+5ZDAfafC9rYhQM29Ivu/JNeEz8LM@vger.kernel.org
X-Gm-Message-State: AOJu0YxD2hAerMmIVpTA5j1HiTkkEOcHWdxq4tOBRFqQNhLynrqKHcrD
	MfdHq249kGsJpcMWGX7qJIH9PMlS/enEF4Dklk66GzGeNMAqA93nHeXd
X-Gm-Gg: ATEYQzy5J3EdcCySbRyALSkwtm44R7VoeMPnYqH+wsg1Ehc/bVZsWmTzMG4VgDUd8IT
	6Z0ld+ECEVkEWl6v3GTrmU9OHlMw2YnQAzw4UVUtIglYgJQne9EF8RUdVo06Hze2Nr3gpkki/1C
	o7hODTfYtnAyyZcRwynyieYTnRi5okPNNBkLl6it6WeLJMRC17Aan7YVRVFvLtz23M8LaoDODt6
	dbfqt1C7STSyNGbeTlnCQKABspN3rRxzaOz16mU2p/DQmJozV9Onvn4S0DHNmM6wzxpA0PvXMlz
	gz/h11EuoSEINkyY39EyhiYN5bc3Z0uKySSIIsin/KGIFNj1RVUIjKkmG+fdeuYbkWE/BFbTEAv
	gFXjQMFKkWqb1liauzWQ0dqy8bnnZRul6DPGmSZkXCFAMtdomqM46JnaLmAud+sQNoHIqFbJZOn
	0qbzt8v2S11/gBz4aXiRn08Kvkh/OMVR1EwvP8vxyAw/ND
X-Received: by 2002:a05:6808:e88f:20b0:45f:131b:db41 with SMTP id 5614622812f47-467e5d580famr1935551b6e.12.1774034857884;
        Fri, 20 Mar 2026 12:27:37 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c148a90f3sm3005680fac.1.2026.03.20.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:37 -0700 (PDT)
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
Subject: [PATCH v5 01/21] mm/swap: decouple swap cache from physical swap infrastructure
Date: Fri, 20 Mar 2026 12:27:15 -0700
Message-ID: <20260320192735.748051-2-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14945-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.849];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 8E5052DFEA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 Documentation/mm/swap-table.rst |  69 -----------
 MAINTAINERS                     |   1 -
 mm/huge_memory.c                |  11 +-
 mm/migrate.c                    |  13 +-
 mm/shmem.c                      |   7 +-
 mm/swap.h                       |  44 +++++--
 mm/swap_state.c                 | 205 +++++++++++++++++---------------
 mm/swap_table.h                 |  78 +-----------
 mm/swapfile.c                   |  45 +++----
 mm/vmscan.c                     |   9 +-
 10 files changed, 178 insertions(+), 304 deletions(-)
 delete mode 100644 Documentation/mm/swap-table.rst

diff --git a/Documentation/mm/swap-table.rst b/Documentation/mm/swap-table.rst
deleted file mode 100644
index da10bb7a0dc37..0000000000000
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
index e087673237636..d3780bb330378 100644
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
index 40cf59301c21a..21215ac870144 100644
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
index 4688b9e38cd2f..11d9b43dff5d8 100644
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
index 79af5f9f8b908..1db97ef2d14eb 100644
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
index 1bd466da30393..78bf60a49b44d 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -199,6 +199,11 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 
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
@@ -247,14 +252,13 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
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
@@ -411,21 +415,37 @@ static inline void *swap_cache_get_shadow(swp_entry_t entry)
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
index 44d228982521e..34c9d9b243a74 100644
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
@@ -180,30 +221,23 @@ void swap_cache_add_folio(struct folio *folio, swp_entry_t entry, void **shadowp
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
+		VM_WARN_ON_FOLIO(old != folio, folio);
+		xas_next(&xas);
+	}
 
 	folio->swap.val = 0;
 	folio_clear_swapcache(folio);
@@ -223,12 +257,11 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
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
@@ -236,7 +269,6 @@ void swap_cache_del_folio(struct folio *folio)
 
 /**
  * __swap_cache_replace_folio - Replace a folio in the swap cache.
- * @ci: The locked swap cluster.
  * @old: The old folio to be replaced.
  * @new: The new folio.
  *
@@ -246,39 +278,23 @@ void swap_cache_del_folio(struct folio *folio)
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
-
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
+	for (i = 0; i < nr_pages; i++) {
+		void *old_entry = xas_store(&xas, new);
+		WARN_ON_ONCE(!old_entry || xa_is_value(old_entry) || old_entry != old);
+		xas_next(&xas);
 	}
 }
 
@@ -287,20 +303,20 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
  * @entry: The starting index entry.
  * @nr_ents: How many slots need to be cleared.
  *
- * Context: Caller must ensure the range is valid, all in one single cluster,
- * not occupied by any folio, and lock the cluster.
+ * Context: Caller must ensure the range is valid and all in one single cluster,
+ * not occupied by any folio.
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
@@ -480,7 +496,10 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
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
index ea244a57a5b7a..ad2cb2ef46903 100644
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
index 46d2008e4b996..46da28c533bbe 100644
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
index 614ccf39fe3fa..558ff7f413786 100644
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


