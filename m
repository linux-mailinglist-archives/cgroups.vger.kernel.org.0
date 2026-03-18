Return-Path: <cgroups+bounces-14886-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHfqIPgnu2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14886-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:32:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2442C36DD
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 746CB3057E81
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC13876B1;
	Wed, 18 Mar 2026 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwi1i24+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0987381AE7
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873006; cv=none; b=KvhvOxsFnTMJydu5U73jxfLYkoKgELW/n4erYQaU6sTJCP6h1MCoBCgMbDOgQUglca8GqvO8d6g147VimaJaqP2oFf9ePxYNI8uXhYo9KqyFrZ6eHdHgwqdHAfsJGgbhDHZFjqom1M+EbBSvhiWpQqny24rzJoTfoBvG+Yer3So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873006; c=relaxed/simple;
	bh=doGbf0EPfObop4nrog4GZiP31w0uYtiVtwrMZ8pit04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSdwpawTian6MmRPqUUqOoKzTgO6lckcvWBB9npy4I1oq2err525BChhq4S7+/yELnyB1SZEmAuZQQf9ezN+tDMHNcExuP/UdMUwM0GUv0aO8DkYEJ791oSuzFqhS4oo0F0TZpj1My7QIZbiBBnoNOvJvZbsnjZApQIF1Y7Eu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nwi1i24+; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d7851e2cc4so317431a34.3
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873004; x=1774477804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2la7S1lv8SZ13es345xjBt9aiwYWClPAry0jC6dTWYc=;
        b=Nwi1i24+ajqqGDUxg7y8XL1Ci0ZGtH6iOZmOpfK8C5oVVuP5JifUL6ktqaf6SZEQWx
         QMRzWx8rKXx/qh8PjdCZL2TokPhZTiGkwhKpq9UIjAAUj4nVHmemNjK1joTl3OqE5J+8
         TEWyvwWkCwU5tNra3sAebb50E7G9vWXOkqqPg9YtAH7PG6UQfPEgZR7ShcIjXD3RafZJ
         4hbaiepYFDIuSKMiSI7PTebxPp3B01g8m3d4dmlIYcc5I9W6Az2c5leEnv868vXBm3/+
         U7NlmL2IAEHhhZF1bAf3jmm4CZg/htOGogIWdvJjasuMTtKbqVxRqu6G+gwmzXjdzCuk
         7q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873004; x=1774477804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2la7S1lv8SZ13es345xjBt9aiwYWClPAry0jC6dTWYc=;
        b=d/pt8NcfZqbKA16qWhyh7+pv9UnxYbM5yoB3+lglrViK8SsX07FhX6U8OZGRgInR3z
         NRjQrDtsf11uw1zcm4qA6oYdK006P+etAwct5jqrYZEWdmbeSbZElLhJrRAm35/LLWYR
         0jTtYEemAxBVOFRLMZDvAlxFdvz8z3Gwngknu3jVKRyCFULZmvODUHDn7WmMfl+HktAe
         0xJuHtcoFyDgIjyhMRCzoK1sr3LawCNfrp3tpmu6xWtn+TyYsP/zTJ88UNXaQV5IZ8Mf
         YhOpDHTaprd6oxyFXRMiJusUQVuLv/CGPpYfl7IOFU00XxPrn21dULvwSF37WpC7L4HH
         uhZw==
X-Forwarded-Encrypted: i=1; AJvYcCUScq3wKqBeacxTQJ8kYd5l2v0QUTTW1OkIiIbVxSwfGuB/05umbXuE/1ueCdorUSMytPiFsk4k@vger.kernel.org
X-Gm-Message-State: AOJu0Yzof8/0iy2qOzl7jYe7GSceQSBLuST/MyyDqb5T9163NxUIxpkT
	UZHkzezcOrArHMtsNUu0XOqIgl/Ub/3eCZlMMs7fMrfdjFLvRPcnRlo2
X-Gm-Gg: ATEYQzy7sVsK/Mw4zqBwO4Sp4yyr5xXqRkmcGb2LunBFg5tTogTg6rxv//GiJZdEKQ3
	XsuzIcl8oCb+h8QkOcZGQhnhIjFg6EGDUzuwnFaS+jO+Cyiqnj+z/T2qHpYWOi7O4IE1mIdokS+
	YoH67qDux+KChKX3oiWzdnLNs/UtttD75SCs1ujO/D3OKxc/yqIfnRAOpV/CqDJSO1vZKr1Rj4c
	EUILXfwEIDEY2w+zwuzJursoEnYSRCfNUENFZu/ESF2U0iOqpeAcTOQ4n0vjN+TaM8A+x3jBnWu
	QsO4JPs6xOh0GnzpG6IsOxlzf14LxoShCm1siAIUonuiWLDy6UDAwBPiabg8ojybpDz2iMGSBeL
	B3ZRCG6LNFgwoOLABYAp30tIPrt+oHiLulaNrXboif9fUlRUS8uJsvf0tRhniYEErWV5fD0Pi3b
	y9QHq6P2qExM7jjMrqTm7JjNjjn4brK0eQJmWslqFdWjtZ
X-Received: by 2002:a05:6830:498b:b0:7d4:96c3:3f97 with SMTP id 46e09a7af769-7d7ca566cf8mr3460497a34.2.1773873003460;
        Wed, 18 Mar 2026 15:30:03 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9be847fsm3020992a34.27.2026.03.18.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:02 -0700 (PDT)
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
Subject: [PATCH v4 05/21] mm/swap: add a new function to check if a swap entry is in swap cached.
Date: Wed, 18 Mar 2026 15:29:36 -0700
Message-ID: <20260318222953.441758-6-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14886-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.861];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD2442C36DD
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


