Return-Path: <cgroups+bounces-16907-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id plk1LqFgLGqZQAQAu9opvQ
	(envelope-from <cgroups+bounces-16907-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:40:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2C267C1AC
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 21:40:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XHFmmHhK;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16907-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16907-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEB71312E6C6
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2026 19:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E533E394498;
	Fri, 12 Jun 2026 19:37:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BA436AB54
	for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 19:37:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781293068; cv=none; b=BBdRMPXlK+vjpbDm0eaT71ItFMbR7vh3WO2bUOBkb7uRK/LdGjKbQZxQr1J4WrjSok6BpX+2KNkdp8tjUlwSn9TVX97C55jJsRyMipzGZBQmx0T62tBe7h2xR0bPHwz3DbF7py3xAIsReIO0/qxzU25MywhS/Z0fKIpXftZjt3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781293068; c=relaxed/simple;
	bh=qZLMvsSqgdx8nCVjxSSKHV/Sur0GeV6MchKfaUn9yNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfxPeq/bf33d4qnaxf9uRpU+Er7dRk5Y/Tp/E3+Si5A60t8UEUwDM3Z9MHWnxgiod/AdpuCiKrrpaoyFoA+ul0T9KSdPi8jXPI+uAa+iGt7lzA3WaivS1Jq2NzCr6plmpBfGLX56iUHj5FfMpj02aTodhZ7AKnVKGkPt3tCa33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHFmmHhK; arc=none smtp.client-ip=209.85.167.182
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-486b93fc7c8so640909b6e.3
        for <cgroups@vger.kernel.org>; Fri, 12 Jun 2026 12:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781293064; x=1781897864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bd5FRPNEityaG9EZA+uep0Wg/UzblVpzQmlatFCXSD8=;
        b=XHFmmHhKPI7OrLllQ323S/6pYr16mMJKzrT/5o4Kdmx32uUKcGLxX2UraAcukz7jJH
         fnpETK9z9es7UTaXcgu3rQfjJt1E8EHehiDwmMvFUB87UG/53ufKAX5h12eIHNLuvEcb
         BS6JZWMRNR1Viajf6ivhdKUBIvZ/+5GBUg5ec6/V/iJGGJ8QXW30xEsTUq3fFDJGqLvg
         11Ik6qFtmKh/oLvZgDaNmoJCp43iJnleflPPVM4wExP69U2Ylka56yBeTsnqkWZQI+ux
         e1FAXHQ56kU11ww0cxdC3Iy4gKuUqAXQ7fCD8a/AIxO5ngcx9yQKVLAYoipHP7Bj0B5f
         AreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781293064; x=1781897864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bd5FRPNEityaG9EZA+uep0Wg/UzblVpzQmlatFCXSD8=;
        b=WM3rZLM0/HKD+8As8KiEivMywwR0b0hKKLHBPf5rX3Hx+ih8TtagVsGbx1qQDIrU9n
         hdv3wHz1yAyDUOP+OLcHfg+RPQjfxfG+XFMrl22qjk6rrRqF450OckvxoxE62tiV/QlR
         xSvo6IRc/oFkj3LQEg9aAVc76bIb+QkmCRQ1/N7SHG5OCBEJGymjfDJSPRjcQxZ29z3H
         StJwb02YkhkgujoEJY0oSYAFxRYJNa5UFxIRVaioq5MMsLXATJtv3R5VnBNR/xayd4FZ
         Q2RUprj9np2TWgxKza+F/vNfLCWfoy5xY8JMopEtUeHzt1CNMV3gyL7d/ThVktweethu
         PCXw==
X-Forwarded-Encrypted: i=1; AFNElJ/yS1SUILQELDCz4cgp3oQltNyeqtYn1lvhdTde1mirB66eHPC1gf6OtGDmEbN+ovHpEQkCTiAs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0YqmuyOBW5i12oC6GUy/lJm9HdA5rAx1G+XTGe0sgDtXhADUV
	iDphn9VfVsZhzaYKM6MyJ+Rd1Oi0wG/JipSvecSptbbm+H8+fguLhTAR
X-Gm-Gg: Acq92OHHiDi5LEJB5ZuwjMRSl+GCiLvbNWXx6NxdNoJcLVs25Jrk46EW2yixL1+6I52
	9elVaV7j0+jsuqEhON3TmuTSX6Rr0PdNnqtY7febahHgrozwi2GHZQ6Eg70AkmkxWzjK9W5EUnE
	9ydoHY1pN5zNoBvZwA9K+xF1zbch4VESVYYQXcTG6Ddmgbeb4gYCUQsmDYcILi8rz9jTUAPI1C/
	8viG34lD2bsz5OD0y4kc5RDoVJir3Gocx5mfZ4DoZBRcY/VryWXydBAgp6G+Kws7ajMJ5z7Bc0q
	zLixSnNxraip2WkNHf8Ykrn3OrZYGGPtzZ7lw5x1wYRLvousUBNOEbPwlRAjmPaLlturwMDgC58
	9qX29oHAMvi4wRwrIMVBq38qQgCZ14oji4okAec/Ei7FDF+Be7PQUbxgdzSWAcnMFPln8hl0CGd
	UNST+uiFu1MS3aqh+vVn4kWygaFyUCUjJqzekaXmkVsIWyDQ==
X-Received: by 2002:a05:6808:250f:b0:486:32e5:22f5 with SMTP id 5614622812f47-48741b95922mr655446b6e.40.1781293064258;
        Fri, 12 Jun 2026 12:37:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:14::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e7816ba6b2sm2762956a34.13.2026.06.12.12.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:37:43 -0700 (PDT)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	yosry@kernel.org,
	david@kernel.org,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	chengming.zhou@linux.dev,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	qi.zheng@linux.dev,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	riel@surriel.com,
	gourry@gourry.net,
	haowenchao22@gmail.com,
	kernel-team@meta.com,
	nphamcs@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [RFC PATCH v2 1/7] mm, swap: add virtual swap device infrastructure
Date: Fri, 12 Jun 2026 12:37:32 -0700
Message-ID: <20260612193738.2183968-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612193738.2183968-1-nphamcs@gmail.com>
References: <20260612193738.2183968-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-16907-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:yosry@kernel.org,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:nphamcs@gmail.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tencent.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C2C267C1AC

Create a massive virtual swap device at boot, along with the
dynamic cluster infrastructure that the rest of the vswap layer
is built on:

  * swap_cluster_info_dynamic: per-cluster dynamic info kept in
    an xarray, allowing arbitrary-size devices without the static
    cluster_info[] array.
  * virtual_table: a per-slot side table for vswap backend metadata
    (tag-encoded in low bits). The field itself is added in the
    next patch; this commit only introduces the dynamic cluster
    container that will hold it.
  * The size of the vswap device is ALIGN_DOWN(UINT_MAX,
    SWAPFILE_CLUSTER) pages.

Gated by a new CONFIG_VSWAP (depends on SWAP && 64BIT). For now,
the vswap device cannot be swapon'd or swapoff'd - it is created
unconditionally at boot when CONFIG_VSWAP=y and lives for the
lifetime of the kernel. The SWP_VSWAP flag and swap_is_vswap()
helper let hot paths skip per-device bookkeeping that doesn't
apply (avail-list management, percpu_ref get/put, hibernation
target lookup, etc.).

This patch is pure scaffolding. It wires the dynamic-cluster
allocator into cluster_alloc_swap_entry (via an SWP_VSWAP branch
that dispatches to alloc_swap_scan_dynamic), but the branch is
not yet reachable because vswap_si is kept off swap_avail_head
and swap_active_head and folio_alloc_swap has no path that calls
into vswap_si directly. Backends (zswap, zero, physical disk)
and the vswap-aware swap-out / swap-in / writeback paths arrive
in subsequent patches.

Suggested-by: Kairui Song <kasong@tencent.com>
Co-developed-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 MAINTAINERS          |   1 +
 include/linux/swap.h |   4 +
 mm/Kconfig           |  10 ++
 mm/page_io.c         |  18 ++-
 mm/swap.h            |  46 ++++++--
 mm/swap_state.c      |  43 ++++---
 mm/swap_table.h      |   2 +
 mm/swapfile.c        | 260 +++++++++++++++++++++++++++++++++++++++----
 mm/vswap.h           |  43 +++++++
 mm/zswap.c           |  10 +-
 10 files changed, 387 insertions(+), 50 deletions(-)
 create mode 100644 mm/vswap.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 65bd4328fe05..92dbb159459c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17061,6 +17061,7 @@ F:	mm/swap.h
 F:	mm/swap_table.h
 F:	mm/swap_state.c
 F:	mm/swapfile.c
+F:	mm/vswap.h
 
 MEMORY MANAGEMENT - THP (TRANSPARENT HUGE PAGE)
 M:	Andrew Morton <akpm@linux-foundation.org>
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 8f0f68e245ba..822b1c90db1c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -214,6 +214,7 @@ enum {
 	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
 	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
 	SWP_HIBERNATION = (1 << 13),	/* pinned for hibernation */
+	SWP_VSWAP	= (1 << 14),	/* virtual swap device */
 					/* add others here before... */
 };
 
@@ -282,6 +283,7 @@ struct swap_info_struct {
 	struct work_struct reclaim_work; /* reclaim worker */
 	struct list_head discard_clusters; /* discard clusters list */
 	struct plist_node avail_list;   /* entry in swap_avail_head */
+	struct xarray cluster_info_pool; /* Xarray for vswap dynamic cluster info */
 };
 
 static inline swp_entry_t page_swap_entry(struct page *page)
@@ -471,6 +473,8 @@ void swap_free_hibernation_slot(swp_entry_t entry);
 
 static inline void put_swap_device(struct swap_info_struct *si)
 {
+	if (si->flags & SWP_VSWAP)
+		return;
 	percpu_ref_put(&si->users);
 }
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 776b67c66e82..ede1c639d226 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -19,6 +19,16 @@ menuconfig SWAP
 	  used to provide more virtual memory than the actual RAM present
 	  in your computer.  If unsure say Y.
 
+config VSWAP
+	bool "Virtual swap device"
+	depends on SWAP && 64BIT
+	help
+	  Adds a virtual swap layer that decouples swap entries in page
+	  tables from physical backing storage. Swap entries are allocated
+	  from a virtual swap device and can be backed by zswap, a physical
+	  swapfile, or kept in memory - with the backing changeable at
+	  runtime without invalidating page table entries.
+
 config ZSWAP
 	bool "Compressed cache for swap pages"
 	depends on SWAP
diff --git a/mm/page_io.c b/mm/page_io.c
index f2d8fe7fd057..8126be6e4cfb 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -295,8 +295,7 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	}
 	rcu_read_unlock();
 
-	__swap_writepage(folio, swap_plug);
-	return 0;
+	return __swap_writepage(folio, swap_plug);
 out_unlock:
 	folio_unlock(folio);
 	return ret;
@@ -458,11 +457,18 @@ static void swap_writepage_bdev_async(struct folio *folio,
 	submit_bio(bio);
 }
 
-void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
+int __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
 {
 	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
 
 	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
+
+	if (sis->flags & SWP_VSWAP) {
+		/* Prevent the page from getting reclaimed. */
+		folio_set_dirty(folio);
+		return AOP_WRITEPAGE_ACTIVATE;
+	}
+
 	/*
 	 * ->flags can be updated non-atomically,
 	 * but that will never affect SWP_FS_OPS, so the data_race
@@ -479,6 +485,7 @@ void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug)
 		swap_writepage_bdev_sync(folio, sis);
 	else
 		swap_writepage_bdev_async(folio, sis);
+	return 0;
 }
 
 void swap_write_unplug(struct swap_iocb *sio)
@@ -684,6 +691,11 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
 	if (zswap_load(folio) != -ENOENT)
 		goto finish;
 
+	if (unlikely(sis->flags & SWP_VSWAP)) {
+		folio_unlock(folio);
+		goto finish;
+	}
+
 	/* We have to read from slower devices. Increase zswap protection. */
 	zswap_folio_swapin(folio);
 
diff --git a/mm/swap.h b/mm/swap.h
index 77d2d14eda42..97493551edbd 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -65,6 +65,13 @@ struct swap_cluster_info {
 	struct list_head list;
 };
 
+struct swap_cluster_info_dynamic {
+	struct swap_cluster_info ci;	/* Underlying cluster info */
+	unsigned int index;		/* for cluster_index() */
+	struct rcu_head rcu;		/* For kfree_rcu deferred free */
+	/* Backend pointers (virtual_table) added in a later patch. */
+};
+
 /* All on-list cluster must have a non-zero flag. */
 enum swap_cluster_flags {
 	CLUSTER_FLAG_NONE = 0, /* For temporary off-list cluster */
@@ -75,6 +82,7 @@ enum swap_cluster_flags {
 	CLUSTER_FLAG_USABLE = CLUSTER_FLAG_FRAG,
 	CLUSTER_FLAG_FULL,
 	CLUSTER_FLAG_DISCARD,
+	CLUSTER_FLAG_DEAD,	/* Vswap dynamic cluster pending kfree_rcu */
 	CLUSTER_FLAG_MAX,
 };
 
@@ -108,9 +116,19 @@ static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
 static inline struct swap_cluster_info *__swap_offset_to_cluster(
 		struct swap_info_struct *si, pgoff_t offset)
 {
+	unsigned int cluster_idx = offset / SWAPFILE_CLUSTER;
+
 	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
 	VM_WARN_ON_ONCE(offset >= roundup(si->max, SWAPFILE_CLUSTER));
-	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
+
+	if (si->flags & SWP_VSWAP) {
+		struct swap_cluster_info_dynamic *ci_dyn;
+
+		ci_dyn = xa_load(&si->cluster_info_pool, cluster_idx);
+		return ci_dyn ? &ci_dyn->ci : NULL;
+	}
+
+	return &si->cluster_info[cluster_idx];
 }
 
 static inline struct swap_cluster_info *__swap_entry_to_cluster(swp_entry_t entry)
@@ -122,7 +140,7 @@ static inline struct swap_cluster_info *__swap_entry_to_cluster(swp_entry_t entr
 static __always_inline struct swap_cluster_info *__swap_cluster_lock(
 		struct swap_info_struct *si, unsigned long offset, bool irq)
 {
-	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
+	struct swap_cluster_info *ci;
 
 	/*
 	 * Nothing modifies swap cache in an IRQ context. All access to
@@ -135,10 +153,24 @@ static __always_inline struct swap_cluster_info *__swap_cluster_lock(
 	 */
 	VM_WARN_ON_ONCE(!in_task());
 	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
-	if (irq)
-		spin_lock_irq(&ci->lock);
-	else
-		spin_lock(&ci->lock);
+
+	rcu_read_lock();
+	ci = __swap_offset_to_cluster(si, offset);
+	if (ci) {
+		if (irq)
+			spin_lock_irq(&ci->lock);
+		else
+			spin_lock(&ci->lock);
+
+		if (ci->flags == CLUSTER_FLAG_DEAD) {
+			if (irq)
+				spin_unlock_irq(&ci->lock);
+			else
+				spin_unlock(&ci->lock);
+			ci = NULL;
+		}
+	}
+	rcu_read_unlock();
 	return ci;
 }
 
@@ -250,7 +282,7 @@ static inline void swap_read_unplug(struct swap_iocb *plug)
 }
 void swap_write_unplug(struct swap_iocb *sio);
 int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug);
-void __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
+int __swap_writepage(struct folio *folio, struct swap_iocb **swap_plug);
 
 /* linux/mm/swap_state.c */
 extern struct address_space swap_space __read_mostly;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 9c3a5cf99778..341ca8826507 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -90,8 +90,10 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
 	struct folio *folio;
 
 	for (;;) {
+		rcu_read_lock();
 		swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
 					swp_cluster_offset(entry));
+		rcu_read_unlock();
 		if (!swp_tb_is_folio(swp_tb))
 			return NULL;
 		folio = swp_tb_to_folio(swp_tb);
@@ -113,8 +115,10 @@ bool swap_cache_has_folio(swp_entry_t entry)
 {
 	unsigned long swp_tb;
 
+	rcu_read_lock();
 	swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
 				swp_cluster_offset(entry));
+	rcu_read_unlock();
 	return swp_tb_is_folio(swp_tb);
 }
 
@@ -130,8 +134,10 @@ void *swap_cache_get_shadow(swp_entry_t entry)
 {
 	unsigned long swp_tb;
 
+	rcu_read_lock();
 	swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
 				swp_cluster_offset(entry));
+	rcu_read_unlock();
 	if (swp_tb_is_shadow(swp_tb))
 		return swp_tb_to_shadow(swp_tb);
 	return NULL;
@@ -400,14 +406,16 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
  * -ENOENT / -EEXIST: Target swap entry is unavailable or cached, the caller
  *                    should abort or try to use the cached folio instead
  */
-static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
-					swp_entry_t targ_entry, gfp_t gfp,
+static struct folio *__swap_cache_alloc(swp_entry_t targ_entry, gfp_t gfp,
 					unsigned int order, struct vm_fault *vmf,
 					struct mempolicy *mpol, pgoff_t ilx)
 {
 	int err;
 	swp_entry_t entry;
 	struct folio *folio;
+	struct swap_cluster_info *ci;
+	struct swap_info_struct *si = __swap_entry_to_info(targ_entry);
+	unsigned long offset = swp_offset(targ_entry);
 	void *shadow = NULL;
 	unsigned short memcg_id;
 	unsigned long address, nr_pages = 1UL << order;
@@ -417,9 +425,12 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	entry.val = round_down(targ_entry.val, nr_pages);
 
 	/* Check if the slot and range are available, skip allocation if not */
-	spin_lock(&ci->lock);
-	err = __swap_cache_add_check(ci, targ_entry, nr_pages, NULL, NULL);
-	spin_unlock(&ci->lock);
+	err = -ENOENT;
+	ci = swap_cluster_lock(si, offset);
+	if (ci) {
+		err = __swap_cache_add_check(ci, targ_entry, nr_pages, NULL, NULL);
+		swap_cluster_unlock(ci);
+	}
 	if (unlikely(err))
 		return ERR_PTR(err);
 
@@ -440,10 +451,13 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 		return ERR_PTR(-ENOMEM);
 
 	/* Double check the range is still not in conflict */
-	spin_lock(&ci->lock);
-	err = __swap_cache_add_check(ci, targ_entry, nr_pages, &shadow, &memcg_id);
+	err = -ENOENT;
+	ci = swap_cluster_lock(si, offset);
+	if (ci)
+		err = __swap_cache_add_check(ci, targ_entry, nr_pages, &shadow, &memcg_id);
 	if (unlikely(err)) {
-		spin_unlock(&ci->lock);
+		if (ci)
+			swap_cluster_unlock(ci);
 		folio_put(folio);
 		return ERR_PTR(err);
 	}
@@ -451,13 +465,14 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 	__swap_cache_do_add_folio(ci, folio, entry);
-	spin_unlock(&ci->lock);
+	swap_cluster_unlock(ci);
 
 	if (mem_cgroup_swapin_charge_folio(folio, memcg_id,
 					   vmf ? vmf->vma->vm_mm : NULL, gfp)) {
-		spin_lock(&ci->lock);
+		/* The folio pins the cluster */
+		ci = swap_cluster_lock(si, offset);
 		__swap_cache_do_del_folio(ci, folio, entry, shadow);
-		spin_unlock(&ci->lock);
+		swap_cluster_unlock(ci);
 		folio_unlock(folio);
 		/* nr_pages refs from swap cache, 1 from allocation */
 		folio_put_refs(folio, nr_pages + 1);
@@ -511,9 +526,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
 {
 	int order, err;
 	struct folio *ret;
-	struct swap_cluster_info *ci;
 
-	ci = __swap_entry_to_cluster(targ_entry);
 	order = highest_order(orders);
 
 	/* orders must be non-zero, and must not exceed cluster size. */
@@ -521,12 +534,12 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
 		return ERR_PTR(-EINVAL);
 
 	do {
-		ret = __swap_cache_alloc(ci, targ_entry, gfp, order,
+		ret = __swap_cache_alloc(targ_entry, gfp, order,
 					 vmf, mpol, ilx);
 		if (!IS_ERR(ret))
 			break;
 		err = PTR_ERR(ret);
-		if (!order || (err && err != -EBUSY && err != -ENOMEM))
+		if (err && err != -EBUSY && err != -ENOMEM)
 			break;
 		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
 		order = next_order(&orders, order);
diff --git a/mm/swap_table.h b/mm/swap_table.h
index e6613e62f8d0..fd7f0fb9836a 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -255,6 +255,8 @@ static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
 	unsigned long swp_tb;
 
 	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	if (!ci)
+		return SWP_TB_NULL;
 
 	rcu_read_lock();
 	table = rcu_dereference(ci->table);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78b49b0658ad..352c5fb2ab75 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -42,10 +42,12 @@
 #include <linux/suspend.h>
 #include <linux/zswap.h>
 #include <linux/plist.h>
+#include <linux/major.h>
 
 #include <asm/tlbflush.h>
 #include <linux/leafops.h>
 #include "swap_table.h"
+#include "vswap.h"
 #include "internal.h"
 #include "swap.h"
 
@@ -401,6 +403,8 @@ static inline bool cluster_is_usable(struct swap_cluster_info *ci, int order)
 static inline unsigned int cluster_index(struct swap_info_struct *si,
 					 struct swap_cluster_info *ci)
 {
+	if (si->flags & SWP_VSWAP)
+		return container_of(ci, struct swap_cluster_info_dynamic, ci)->index;
 	return ci - si->cluster_info;
 }
 
@@ -733,6 +737,22 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
 		return;
 	}
 
+	if (si->flags & SWP_VSWAP) {
+		struct swap_cluster_info_dynamic *ci_dyn;
+
+		ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+		if (ci->flags != CLUSTER_FLAG_NONE) {
+			spin_lock(&si->lock);
+			list_del(&ci->list);
+			spin_unlock(&si->lock);
+		}
+		swap_cluster_free_table(ci);
+		xa_erase(&si->cluster_info_pool, ci_dyn->index);
+		ci->flags = CLUSTER_FLAG_DEAD;
+		kfree_rcu(ci_dyn, rcu);
+		return;
+	}
+
 	__free_cluster(si, ci);
 }
 
@@ -835,14 +855,21 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
  * stolen by a lower order). @usable will be set to false if that happens.
  */
 static bool cluster_reclaim_range(struct swap_info_struct *si,
-				  struct swap_cluster_info *ci,
+				  struct swap_cluster_info **pcip,
 				  unsigned long start, unsigned int order,
 				  bool *usable)
 {
+	struct swap_cluster_info *ci = *pcip;
 	unsigned int nr_pages = 1 << order;
 	unsigned long offset = start, end = start + nr_pages;
 	unsigned long swp_tb;
 
+	/*
+	 * Take RCU read lock before releasing the cluster lock to keep ci
+	 * alive - for vswap dynamic clusters, ci is freed via kfree_rcu
+	 * and the grace period could otherwise elapse in the window.
+	 */
+	rcu_read_lock();
 	spin_unlock(&ci->lock);
 	do {
 		swp_tb = swap_table_get(ci, offset % SWAPFILE_CLUSTER);
@@ -852,7 +879,15 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 			if (__try_to_reclaim_swap(si, offset, TTRS_ANYWAY) < 0)
 				break;
 	} while (++offset < end);
-	spin_lock(&ci->lock);
+	rcu_read_unlock();
+
+	/* Re-lookup: dynamic cluster may have been freed while lock was dropped */
+	ci = swap_cluster_lock(si, start);
+	*pcip = ci;
+	if (!ci) {
+		*usable = false;
+		return false;
+	}
 
 	/*
 	 * We just dropped ci->lock so cluster could be used by another
@@ -983,7 +1018,8 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 		if (!cluster_scan_range(si, ci, offset, nr_pages, &need_reclaim))
 			continue;
 		if (need_reclaim) {
-			ret = cluster_reclaim_range(si, ci, offset, order, &usable);
+			ret = cluster_reclaim_range(si, &ci, offset, order,
+						    &usable);
 			if (!usable)
 				goto out;
 			if (cluster_is_empty(ci))
@@ -1001,8 +1037,10 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 		break;
 	}
 out:
-	relocate_cluster(si, ci);
-	swap_cluster_unlock(ci);
+	if (ci) {
+		relocate_cluster(si, ci);
+		swap_cluster_unlock(ci);
+	}
 	if (si->flags & SWP_SOLIDSTATE) {
 		this_cpu_write(percpu_swap_cluster.offset[order], next);
 		this_cpu_write(percpu_swap_cluster.si[order], si);
@@ -1034,6 +1072,41 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 	return found;
 }
 
+static unsigned int alloc_swap_scan_dynamic(struct swap_info_struct *si,
+					    struct folio *folio)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	struct swap_cluster_info *ci;
+	unsigned long offset;
+
+	VM_WARN_ON(!(si->flags & SWP_VSWAP));
+
+	ci_dyn = kzalloc(sizeof(*ci_dyn), GFP_ATOMIC);
+	if (!ci_dyn)
+		return SWAP_ENTRY_INVALID;
+
+	spin_lock_init(&ci_dyn->ci.lock);
+	INIT_LIST_HEAD(&ci_dyn->ci.list);
+
+	if (swap_cluster_alloc_table(&ci_dyn->ci, GFP_ATOMIC)) {
+		kfree(ci_dyn);
+		return SWAP_ENTRY_INVALID;
+	}
+
+	if (xa_alloc(&si->cluster_info_pool, &ci_dyn->index, ci_dyn,
+		     XA_LIMIT(1, DIV_ROUND_UP(si->max, SWAPFILE_CLUSTER) - 1),
+		     GFP_ATOMIC)) {
+		swap_cluster_free_table(&ci_dyn->ci);
+		kfree(ci_dyn);
+		return SWAP_ENTRY_INVALID;
+	}
+
+	ci = &ci_dyn->ci;
+	spin_lock(&ci->lock);
+	offset = cluster_offset(si, ci);
+	return alloc_swap_scan_cluster(si, ci, folio, offset);
+}
+
 static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 {
 	long to_scan = 1;
@@ -1056,7 +1129,9 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
 								   TTRS_ANYWAY);
-				spin_lock(&ci->lock);
+				ci = swap_cluster_lock(si, offset);
+				if (!ci)
+					goto next;
 				if (nr_reclaim) {
 					offset += abs(nr_reclaim);
 					continue;
@@ -1070,6 +1145,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 			relocate_cluster(si, ci);
 
 		swap_cluster_unlock(ci);
+next:
 		if (to_scan <= 0)
 			break;
 		cond_resched();
@@ -1140,6 +1216,12 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 			goto done;
 	}
 
+	if (si->flags & SWP_VSWAP) {
+		found = alloc_swap_scan_dynamic(si, folio);
+		if (found)
+			goto done;
+	}
+
 	if (!(si->flags & SWP_PAGE_DISCARD)) {
 		found = alloc_swap_scan_list(si, &si->free_clusters, folio, false);
 		if (found)
@@ -1258,6 +1340,13 @@ static void add_to_avail_list(struct swap_info_struct *si, bool swapon)
 			goto skip;
 	}
 
+	/*
+	 * Keep vswap off the avail list - it is not allocated from by
+	 * the physical swap allocator (swap_alloc_fast/slow).
+	 */
+	if (swap_is_vswap(si))
+		goto skip;
+
 	plist_add(&si->avail_list, &swap_avail_head);
 
 skip:
@@ -1340,6 +1429,10 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 
 static bool get_swap_device_info(struct swap_info_struct *si)
 {
+	/* vswap device is always alive - no ref counting needed */
+	if (swap_is_vswap(si))
+		return true;
+
 	if (!percpu_ref_tryget_live(&si->users))
 		return false;
 	/*
@@ -1375,11 +1468,11 @@ static bool swap_alloc_fast(struct folio *folio)
 		return false;
 
 	ci = swap_cluster_lock(si, offset);
-	if (cluster_is_usable(ci, order)) {
+	if (ci && cluster_is_usable(ci, order)) {
 		if (cluster_is_empty(ci))
 			offset = cluster_offset(si, ci);
 		alloc_swap_scan_cluster(si, ci, folio, offset);
-	} else {
+	} else if (ci) {
 		swap_cluster_unlock(ci);
 	}
 
@@ -1501,6 +1594,7 @@ int swap_retry_table_alloc(swp_entry_t entry, gfp_t gfp)
 	if (!si)
 		return 0;
 
+	/* Entry is in use (being faulted in), so its cluster is alive. */
 	ci = __swap_offset_to_cluster(si, offset);
 	ret = swap_extend_table_alloc(si, ci, swp_cluster_offset(entry), gfp);
 
@@ -1736,6 +1830,7 @@ int folio_alloc_swap(struct folio *folio)
 	unsigned int order = folio_order(folio);
 	unsigned int size = 1 << order;
 
+	VM_WARN_ON_FOLIO(folio_test_swapcache(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_uptodate(folio), folio);
 
@@ -1898,7 +1993,8 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
 	return NULL;
 put_out:
 	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
-	percpu_ref_put(&si->users);
+	if (!swap_is_vswap(si))
+		percpu_ref_put(&si->users);
 	return NULL;
 }
 
@@ -2030,6 +2126,7 @@ static bool folio_maybe_swapped(struct folio *folio)
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 
+	/* Folio is locked and in swap cache, so ci->count > 0: cluster is alive. */
 	ci = __swap_entry_to_cluster(entry);
 	ci_off = swp_cluster_offset(entry);
 	ci_end = ci_off + folio_nr_pages(folio);
@@ -2217,6 +2314,9 @@ static int __find_hibernation_swap_type(dev_t device, sector_t offset)
 
 		if (!(sis->flags & SWP_WRITEOK))
 			continue;
+		/* vswap has no bdev - never a hibernation target */
+		if (swap_is_vswap(sis))
+			continue;
 
 		if (device == sis->bdev->bd_dev) {
 			struct swap_extent *se = first_se(sis);
@@ -2343,6 +2443,9 @@ int find_first_swap(dev_t *device)
 
 		if (!(sis->flags & SWP_WRITEOK))
 			continue;
+		/* vswap has no bdev - never a hibernation target */
+		if (swap_is_vswap(sis))
+			continue;
 		*device = sis->bdev->bd_dev;
 		spin_unlock(&swap_lock);
 		return type;
@@ -2554,8 +2657,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 						&vmf);
 		}
 		if (!folio) {
+			rcu_read_lock();
 			swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
 						swp_cluster_offset(entry));
+			rcu_read_unlock();
 			if (swp_tb_get_count(swp_tb) <= 0)
 				continue;
 			return -ENOMEM;
@@ -2701,8 +2806,10 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	 * allocations from this area (while holding swap_lock).
 	 */
 	for (i = prev + 1; i < si->max; i++) {
+		rcu_read_lock();
 		swp_tb = swap_table_get(__swap_offset_to_cluster(si, i),
 					i % SWAPFILE_CLUSTER);
+		rcu_read_unlock();
 		if (!swp_tb_is_null(swp_tb) && !swp_tb_is_bad(swp_tb))
 			break;
 		if ((i % LATENCY_LIMIT) == 0)
@@ -2941,6 +3048,11 @@ static int setup_swap_extents(struct swap_info_struct *sis,
 	struct inode *inode = mapping->host;
 	int ret;
 
+	if (sis->flags & SWP_VSWAP) {
+		*span = 0;
+		return 0;
+	}
+
 	if (S_ISBLK(inode->i_mode)) {
 		ret = add_swap_extent(sis, 0, sis->max, 0);
 		*span = sis->pages;
@@ -2965,15 +3077,22 @@ static int setup_swap_extents(struct swap_info_struct *sis,
 
 static void _enable_swap_info(struct swap_info_struct *si)
 {
-	atomic_long_add(si->pages, &nr_swap_pages);
-	total_swap_pages += si->pages;
+	if (!swap_is_vswap(si)) {
+		atomic_long_add(si->pages, &nr_swap_pages);
+		total_swap_pages += si->pages;
+	}
 
 	assert_spin_locked(&swap_lock);
 
-	plist_add(&si->list, &swap_active_head);
-
-	/* Add back to available list */
-	add_to_avail_list(si, true);
+	/*
+	 * Vswap has no backing file and no swapoff support - keep it
+	 * off swap_active_head (used by swapoff filename lookup and
+	 * swap_sync_discard) and swap_avail_head (physical allocator).
+	 */
+	if (!swap_is_vswap(si)) {
+		plist_add(&si->list, &swap_active_head);
+		add_to_avail_list(si, true);
+	}
 }
 
 /*
@@ -3010,6 +3129,8 @@ static void wait_for_allocation(struct swap_info_struct *si)
 	struct swap_cluster_info *ci;
 
 	BUG_ON(si->flags & SWP_WRITEOK);
+	if (si->flags & SWP_VSWAP)
+		return;
 
 	for (offset = 0; offset < end; offset += SWAPFILE_CLUSTER) {
 		ci = swap_cluster_lock(si, offset);
@@ -3148,7 +3269,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	destroy_swap_extents(p, p->swap_file);
 
-	if (!(p->flags & SWP_SOLIDSTATE))
+	if (!(p->flags & SWP_VSWAP) &&
+	    !(p->flags & SWP_SOLIDSTATE))
 		atomic_dec(&nr_rotate_swap);
 
 	mutex_lock(&swapon_mutex);
@@ -3258,6 +3380,19 @@ static void swap_stop(struct seq_file *swap, void *v)
 	mutex_unlock(&swapon_mutex);
 }
 
+static const char *swap_type_str(struct swap_info_struct *si)
+{
+	struct file *file = si->swap_file;
+
+	if (si->flags & SWP_VSWAP)
+		return "vswap\t";
+
+	if (S_ISBLK(file_inode(file)->i_mode))
+		return "partition";
+
+	return "file\t";
+}
+
 static int swap_show(struct seq_file *swap, void *v)
 {
 	struct swap_info_struct *si = v;
@@ -3277,8 +3412,7 @@ static int swap_show(struct seq_file *swap, void *v)
 	len = seq_file_path(swap, file, " \t\n\\");
 	seq_printf(swap, "%*s%s\t%lu\t%s%lu\t%s%d\n",
 			len < 40 ? 40 - len : 1, " ",
-			S_ISBLK(file_inode(file)->i_mode) ?
-				"partition" : "file\t",
+			swap_type_str(si),
 			bytes, bytes < 10000000 ? "\t" : "",
 			inuse, inuse < 10000000 ? "\t" : "",
 			si->prio);
@@ -3410,7 +3544,6 @@ static int claim_swapfile(struct swap_info_struct *si, struct inode *inode)
 	return 0;
 }
 
-
 /*
  * Find out how many pages are allowed for a single swap device. There
  * are two limiting factors:
@@ -3516,10 +3649,43 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 				    unsigned long maxpages)
 {
 	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
-	struct swap_cluster_info *cluster_info;
+	struct swap_cluster_info *cluster_info = NULL;
+	struct swap_cluster_info_dynamic *ci_dyn;
 	int err = -ENOMEM;
 	unsigned long i;
 
+	/* For SWP_VSWAP files, initialize Xarray pool instead of static array */
+	if (si->flags & SWP_VSWAP) {
+		/*
+		 * Pre-allocate cluster 0 and mark slot 0 (header page)
+		 * as bad so the allocator never hands out page offset 0.
+		 */
+		ci_dyn = kzalloc(sizeof(*ci_dyn), GFP_KERNEL);
+		if (!ci_dyn)
+			goto err;
+		spin_lock_init(&ci_dyn->ci.lock);
+		INIT_LIST_HEAD(&ci_dyn->ci.list);
+
+		nr_clusters = 0;
+		xa_init_flags(&si->cluster_info_pool, XA_FLAGS_ALLOC);
+		err = xa_insert(&si->cluster_info_pool, 0, ci_dyn, GFP_KERNEL);
+		if (err) {
+			kfree(ci_dyn);
+			goto err;
+		}
+
+		err = swap_cluster_setup_bad_slot(si, &ci_dyn->ci, 0, false);
+		if (err) {
+			xa_erase(&si->cluster_info_pool, 0);
+			swap_cluster_free_table(&ci_dyn->ci);
+			kfree(ci_dyn);
+			xa_destroy(&si->cluster_info_pool);
+			goto err;
+		}
+
+		goto setup_cluster_info;
+	}
+
 	cluster_info = kvzalloc_objs(*cluster_info, nr_clusters);
 	if (!cluster_info)
 		goto err;
@@ -3544,6 +3710,10 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 	err = swap_cluster_setup_bad_slot(si, cluster_info, 0, false);
 	if (err)
 		goto err;
+
+	if (!swap_header)
+		goto setup_cluster_info;
+
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 
@@ -3563,6 +3733,7 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 			goto err;
 	}
 
+setup_cluster_info:
 	INIT_LIST_HEAD(&si->free_clusters);
 	INIT_LIST_HEAD(&si->full_clusters);
 	INIT_LIST_HEAD(&si->discard_clusters);
@@ -3599,7 +3770,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	struct dentry *dentry;
 	int prio;
 	int error;
-	union swap_header *swap_header;
+	union swap_header *swap_header = NULL;
 	int nr_extents;
 	sector_t span;
 	unsigned long maxpages;
@@ -3673,7 +3844,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 	swap_header = kmap_local_folio(folio, 0);
-
 	maxpages = read_swap_header(si, swap_header, inode);
 	if (unlikely(!maxpages)) {
 		error = -EINVAL;
@@ -3708,7 +3878,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 
 	if (si->bdev && !bdev_rot(si->bdev)) {
 		si->flags |= SWP_SOLIDSTATE;
-	} else {
+	} else if (!(si->flags & SWP_SOLIDSTATE)) {
 		atomic_inc(&nr_rotate_swap);
 		inced_nr_rotate_swap = true;
 	}
@@ -3930,3 +4100,47 @@ static int __init swapfile_init(void)
 	return 0;
 }
 subsys_initcall(swapfile_init);
+
+#ifdef CONFIG_VSWAP
+struct swap_info_struct *vswap_si;
+
+static int __init vswap_init(void)
+{
+	struct swap_info_struct *si;
+	unsigned long maxpages;
+	int err;
+
+	si = alloc_swap_info();
+	if (IS_ERR(si))
+		return PTR_ERR(si);
+
+	maxpages = min(swapfile_maximum_size,
+		       ALIGN_DOWN((unsigned long)UINT_MAX, SWAPFILE_CLUSTER));
+	si->flags |= SWP_VSWAP | SWP_SOLIDSTATE | SWP_WRITEOK;
+	si->bdev = NULL;
+	si->max = maxpages;
+	si->pages = maxpages - 1;
+	si->prio = SHRT_MAX;
+	si->list.prio = -si->prio;
+	si->avail_list.prio = -si->prio;
+
+	err = setup_swap_clusters_info(si, NULL, maxpages);
+	if (err)
+		goto fail;
+
+	mutex_lock(&swapon_mutex);
+	enable_swap_info(si);
+	mutex_unlock(&swapon_mutex);
+
+	vswap_si = si;
+	pr_info("vswap: created virtual swap device (%lu pages)\n", maxpages);
+	return 0;
+
+fail:
+	spin_lock(&swap_lock);
+	si->flags = 0;
+	spin_unlock(&swap_lock);
+	return err;
+}
+late_initcall(vswap_init);
+#endif
diff --git a/mm/vswap.h b/mm/vswap.h
new file mode 100644
index 000000000000..a1fd7f7e568f
--- /dev/null
+++ b/mm/vswap.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Virtual swap space
+ *
+ * Copyright (C) 2026 Nhat Pham
+ */
+#ifndef _MM_VSWAP_H
+#define _MM_VSWAP_H
+
+#include <linux/swap.h>
+
+#ifdef CONFIG_VSWAP
+
+extern struct swap_info_struct *vswap_si;
+
+static inline bool swap_is_vswap(struct swap_info_struct *si)
+{
+	return si->flags & SWP_VSWAP;
+}
+
+#else
+
+static inline bool swap_is_vswap(struct swap_info_struct *si)
+{
+	return false;
+}
+
+#endif /* CONFIG_VSWAP */
+
+#ifdef CONFIG_SWAP
+#include "swap.h"
+static inline bool is_vswap_entry(swp_entry_t entry)
+{
+	return swap_is_vswap(__swap_entry_to_info(entry));
+}
+#else
+static inline bool is_vswap_entry(swp_entry_t entry)
+{
+	return false;
+}
+#endif /* CONFIG_SWAP */
+
+#endif /* _MM_VSWAP_H */
diff --git a/mm/zswap.c b/mm/zswap.c
index 761cd699e0a3..993406074d58 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -994,11 +994,16 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct swap_info_struct *si;
 	int ret = 0;
 
-	/* try to allocate swap cache folio */
 	si = get_swap_device(swpentry);
 	if (!si)
 		return -EEXIST;
 
+	if (si->flags & SWP_VSWAP) {
+		put_swap_device(si);
+		return -EINVAL;
+	}
+
+	/* try to allocate swap cache folio */
 	mpol = get_task_policy(current);
 	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
 				       NO_INTERLEAVE_INDEX);
@@ -1049,7 +1054,8 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	folio_set_reclaim(folio);
 
 	/* start writeback */
-	__swap_writepage(folio, NULL);
+	ret = __swap_writepage(folio, NULL);
+	WARN_ON_ONCE(ret);
 
 out:
 	if (ret) {
-- 
2.53.0-Meta


