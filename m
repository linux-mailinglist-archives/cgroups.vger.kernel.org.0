Return-Path: <cgroups+bounces-14948-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLXsIQmgvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14948-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:29:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9762DFF25
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05763305EE9D
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8DD3CCA11;
	Fri, 20 Mar 2026 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z08O9M5+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBF2359A7E
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034867; cv=none; b=T+am6r7mAfyjcz/xyQwXnplfUQ9Ja/mgFcJM/kWWV4YreZrcOaq8rukYYKVHVOxjo/bcFuqD9R4g6u+89qVT31LAxvaOh0uT1DeckZ5Z4ezcYbGSD57H6BxDY9qqKxSrbH7022BDDW8cStjYCz28qF4uEOMIyAX0yHN0eSoKswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034867; c=relaxed/simple;
	bh=doGbf0EPfObop4nrog4GZiP31w0uYtiVtwrMZ8pit04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNbesvFdN/SyR4XRpQkv8G7cKVYD7pG7n0N/ZehsdYq4yJogesDKYFfQ2L5SyEI97oO9OTuFcZex+1gCP6Fa+1nNixuNe8YsSxeHqpK2F34FzNQ20DmOPLzcJFk3fBs/STDR/o21JkS8jQDFkU1QHYbNem1PPYFohYmJHRQK29U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z08O9M5+; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-404254ffe8aso1581811fac.0
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034864; x=1774639664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2la7S1lv8SZ13es345xjBt9aiwYWClPAry0jC6dTWYc=;
        b=Z08O9M5+tOpAdo3fhd0MWIC7Jx5WcuaCHr4yo3a0n4rdnAERzvrfRwp5i6COC9ux0Y
         2u1u+ygodvPi57c64E9oO4GRSwp7J7GDSutHI9kzofj/vzz7+vdNYqHZ0yQpseQVf4BS
         PjXbp05lFoj+pjnXtoLfB/OYHDvQ7qEpJBUcjyNCeXJ8H1ozrqDfcBU/cfJikKTOKUeL
         1kRH5LFSfaCNC02MiILfcyENT5jU3LxjF9OECfBnXnRe8PeDimpVgnlx+4ifaKdmj3/j
         SmoejiR57M+bMM5gCuJl7woqRyDK5nQVAhehsQVMvPyDB1bL9qC38z44rruv6XwErhRS
         O22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034864; x=1774639664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2la7S1lv8SZ13es345xjBt9aiwYWClPAry0jC6dTWYc=;
        b=XvSiaQDBh8owGiEmwyZPXUvBZHWgLle5UQ0GQO0EvWkuHuH47H7y5sgKfUuUv5hD66
         9DEpwRhorKqwoALZ2eogPYEkZgTAxb67KLWnPOE7lvaHSZv/0gPkWvmnCbUHZD+0WdiN
         A3QUOONDnKosvhz4xZHHaTDniOemwmbsv0ymiTQuIn/OYgyxHHYYfUYvwxio/xUaF3pB
         9NvKlRuACjcLe6bdPSGiztmUmZ9hV0/ploWljZPf6wz+bAtmlcohHcds10AsdhyodjMG
         DZYhVUX1WtbWq5k5XALiRLrCV4LfuRFXN1UrlXNqGWG4cfhG9HTZRU57W6YbFRvjlRmR
         UBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7a+QDixP3ntsAnq/3UBajG3eYHMDuoilLHQBEmrB80yiEnj01T3OpsnnHy02I+ChH2RetEhse@vger.kernel.org
X-Gm-Message-State: AOJu0YztRwyCasqpqI94Meo451cha2ZcDGNXIrk0OcqAM03brjjZlggl
	KhF+9HOCGU8pc+K3di8r88SQc1hYT1ImLyi5dkXMmLLpLhDiCDA/6qGi
X-Gm-Gg: ATEYQzwrxgue+BA3oBLm2Y7vzShQ6tcbhJdLEBnD35jhdwrzEbA803VCktd0rI8PVWy
	r9Koa0zc8TuYL1xi3ntgGKHiug0YXjiLqk3IIBoXLs+NsCaDJjFg56+gvkcTmlIgy9hApKNPvZ0
	OnJ4O8T4GJp1apdgNM7FWvWQR5PZJzU7GjfLfcJ9ERPDUuwwfi+gKch8xmUxn5KdmhBiQvcZErv
	SttGIgviH96zuXG2yVg4kXQh94ZOzic2oS5yCydWIiwf3bqpjGBrY4DfQfXoq5WjqUFhEZsoAiH
	OPAYKkk3KbLCP17oX8ShPtkYkatCk821pvAAlcduHlIMKVTs/mqjLMH8tvpuruF2yQ/lmcy0Wvj
	+ST7zCUcTQ9puQoV5eSD+phBsC0WJXsIWUGoFdY38hdHpp13knQ4/IfSFs3GXzeheQ+qXJM/dPl
	x7Qgc4B4ORoa4rrx5NCRu8A6Vss/Rw/F6+NF9VhosEYfjBZQ==
X-Received: by 2002:a05:6871:6d0e:b0:417:3833:fbdb with SMTP id 586e51a60fabf-41c10686204mr2791653fac.17.1774034864179;
        Fri, 20 Mar 2026 12:27:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14e45213sm2645089fac.18.2026.03.20.12.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:27:43 -0700 (PDT)
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
Subject: [PATCH v5 05/21] mm/swap: add a new function to check if a swap entry is in swap cached.
Date: Fri, 20 Mar 2026 12:27:19 -0700
Message-ID: <20260320192735.748051-6-nphamcs@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-14948-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.868];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A9762DFF25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Userfaultfd checks whether a swap entry is in swapcache. This is
currently done by directly looking at the swapfile's swap map - however,
the swap cached state will soon be managed at the virtual swap layer.
Abstract away this function.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |  6 ++++++
 mm/swapfile.c        | 15 +++++++++++++++
 mm/userfaultfd.c     |  3 +--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3da637b218baf..f91a442ac0e82 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -435,6 +435,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int __swap_count(swp_entry_t entry);
 bool swap_entry_swapped(struct swap_info_struct *si, swp_entry_t entry);
 int swp_swapcount(swp_entry_t entry);
+bool is_swap_cached(swp_entry_t entry);
 
 /* Swap cache API (mm/swap_state.c) */
 static inline unsigned long total_swapcache_pages(void)
@@ -554,6 +555,11 @@ static inline int swp_swapcount(swp_entry_t entry)
 	return 0;
 }
 
+static inline bool is_swap_cached(swp_entry_t entry)
+{
+	return false;
+}
+
 static inline int folio_alloc_swap(struct folio *folio)
 {
 	return -EINVAL;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 46da28c533bbe..0471a965f222b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -194,6 +194,21 @@ static bool swap_only_has_cache(struct swap_info_struct *si,
 	return true;
 }
 
+/**
+ * is_swap_cached - check if the swap entry is cached
+ * @entry: swap entry to check
+ *
+ * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
+ *
+ * Returns true if the swap entry is cached, false otherwise.
+ */
+bool is_swap_cached(swp_entry_t entry)
+{
+	struct swap_info_struct *si = __swap_entry_to_info(entry);
+
+	return READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE;
+}
+
 static bool swap_is_last_map(struct swap_info_struct *si,
 		unsigned long offset, int nr_pages, bool *has_cache)
 {
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 25f89eba0438c..98be764fb3ecd 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1190,7 +1190,6 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 		 * Check if the swap entry is cached after acquiring the src_pte
 		 * lock. Otherwise, we might miss a newly loaded swap cache folio.
 		 *
-		 * Check swap_map directly to minimize overhead, READ_ONCE is sufficient.
 		 * We are trying to catch newly added swap cache, the only possible case is
 		 * when a folio is swapped in and out again staying in swap cache, using the
 		 * same entry before the PTE check above. The PTL is acquired and released
@@ -1200,7 +1199,7 @@ static int move_swap_pte(struct mm_struct *mm, struct vm_area_struct *dst_vma,
 		 * cache, or during the tiny synchronization window between swap cache and
 		 * swap_map, but it will be gone very quickly, worst result is retry jitters.
 		 */
-		if (READ_ONCE(si->swap_map[swp_offset(entry)]) & SWAP_HAS_CACHE) {
+		if (is_swap_cached(entry)) {
 			double_pt_unlock(dst_ptl, src_ptl);
 			return -EAGAIN;
 		}
-- 
2.52.0


