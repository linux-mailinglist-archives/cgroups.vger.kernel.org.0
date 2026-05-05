Return-Path: <cgroups+bounces-15610-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGF0II4P+mntIgMAu9opvQ
	(envelope-from <cgroups+bounces-15610-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:41:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7933E4D060F
	for <lists+cgroups@lfdr.de>; Tue, 05 May 2026 17:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C732F3019004
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C5848B382;
	Tue,  5 May 2026 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYEashty"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4348A2C0
	for <cgroups@vger.kernel.org>; Tue,  5 May 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777995551; cv=none; b=GPqeNL95bt1lrCTrFoAdvsJuxI/PGcbq+BNsarRFi7vEh1gjPRQA4l+wT7FaFRxd75DRHHvImf5F0tLyKMJcKQTkG83BbMXkHJ+SLPhByGBBObDMFBAJtMoUVqA7WfOgNA4OUSKxnDAcoYGZm2E7YfpXb/db/yHbI5w1pP44cms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777995551; c=relaxed/simple;
	bh=X9dE5SnxTHQWLGLGF1Tm4Hd+Xo2utpkChYtUmYAYABQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzSznQh3scBNeEVJ3x5c//dBWnF4ls2i/TwOQiRIyZuYuSD2zF1XgrHgIcayLhInfQkS21LeW9B/UCJ29fbwSv/dWGZTAsS2SAOyXKYqTs8Oz6BkL3D5EOnhbN9j2rP9tEr0XFYD/jhlM09djRMWqDZJjfiwKR6pfs+Y2bU31wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYEashty; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7de7dc85b74so4875971a34.2
        for <cgroups@vger.kernel.org>; Tue, 05 May 2026 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777995548; x=1778600348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uq6RStVYG/AZxKiwJHi2taHWJECHTirH9n/mFE+40q0=;
        b=IYEashtyxtd23fIvcGom3d/XGBqE+vfKKGeTvI07iIv1ui7fclp5VRCvpvq1z22fwJ
         6AnuDzEYy2K0umZd0jeojqKmGxtpXMtOj4I1oTStSoNm1uaJZqk4f4ZoEQPMjsizEHVm
         o8Wf7IZ6zxmQHzQvPS98IDjgD78kV09976nnKbBHDfECpA3gBb3AMxP+Dd+mNlkymQx5
         b7v7CdJYY5gE/T9sxVB33Nw5AQ5zgs2PP/VO6eu4S7Gr5OouRaKxn9oIbytD3Zunw1yS
         aPkA9AtDt4oYDTfV4PhCl56C4WK8/lYgYSTBtIwv7poZqGyNIk2AeILlk4pRIIEY2Yqx
         oP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777995548; x=1778600348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uq6RStVYG/AZxKiwJHi2taHWJECHTirH9n/mFE+40q0=;
        b=VoQ/BAHmVhb7+M2ThHRtRPJvcTigB5FpmdP4uhnluxOIeaxxSNGoP34SO8Rk7pewsD
         GnBxaNjhDXaOs0WeghF4phosXJZX88umGM7ObJBW/UrpAGujt5WrmBJKs86rIWGu8cgK
         byCikj2YUWLB7Wyo3H0XdLWQ4WfAa0JiFoykIRNzeoX/R1d8xfdj5YyYjgJ6O/TlRgxV
         KpKAjhANN9hIS6B96aAMa7ibjGBVcjIsIT7TyFRpjvJWdMJl5jRIo+BMDOcJA1/dTTed
         F2mSGCuI+gQiSuJ5BrClz/uFTT/16xY5GLijGInms1OPZWZ//lfjPxUqqToaDWomLXdI
         73gQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jRorA9fs9i96uBMTXTmlP6X7Pj+IDZtI0X24VwZvrSiF0A8G+R2bPAGkZIMt/g2qy1WYS6fbk@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3aAlNP/ZPSjxx6KtY88fbrgIJhTax0fbaxNXcKH8LxZ21paI
	jzUso91vB9hk9BCuyzPNhkNHbgZQu6ni2duOt3wphdHDjtaPnjRmDcCs
X-Gm-Gg: AeBDieuGwn7zF4613lWBrV4qxQpMxqTHo4W+c+67PkbJ4tegxUCkemFrqvZHmf1N8sB
	a7Xv0UUjDbXx3VdfHUI/4kkelCmWe/oANWox6a356ywop9LCf/ZfLKbrFs6c31WC1NYm86nzXFf
	9HxlDQKfTnp8iEbf5JvwEldr9cJB/O5QIyiOth4i9+SG2vRf0oXSru7gt7CO+GOhXyS5/y9O5hZ
	v1a8k4tkVREm2oweiUnxyYikSDkEqMOMCP4d/bJ9Zda9fuxLVI2c0ESldBEJjj16k8NGiH0BSLR
	J3Jkl2I2cEXOC3jyjWEglSw0IQPWZ7N03IPbzskE3kyNRke5HObLbIVJnK8+ysn/jSEslshXx/r
	vCN0hjNgenr1upjdWwDOYg9B1GHtEhY6mclSkce0j2gxPBn0LwlFpiy0HtlaiwJFdsR0LLbznfy
	JV6q0nZHE3PPSVsFeBpf1rl8KQ+/yhrPPopb2hZKrYsk9HZ9dfoSvpFqnj
X-Received: by 2002:a05:6830:2690:b0:7d9:b338:a695 with SMTP id 46e09a7af769-7dee11f9cacmr8510809a34.5.1777995548342;
        Tue, 05 May 2026 08:39:08 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:45::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7deca7f46e7sm10930497a34.8.2026.05.05.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:39:07 -0700 (PDT)
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
Subject: [PATCH v6 05/22] mm/swap: add a new function to check if a swap entry is in swap cached.
Date: Tue,  5 May 2026 08:38:34 -0700
Message-ID: <20260505153854.1612033-6-nphamcs@gmail.com>
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
X-Rspamd-Queue-Id: 7933E4D060F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15610-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_GT_50(0.00)[55];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
index 3da637b218ba..f91a442ac0e8 100644
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
index 46da28c533bb..0471a965f222 100644
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
index 25f89eba0438..98be764fb3ec 100644
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


