Return-Path: <cgroups+bounces-14898-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNjEMRgou2kcfwIAu9opvQ
	(envelope-from <cgroups+bounces-14898-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:32:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 878762C3709
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 23:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6B423046D89
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DCB3A962B;
	Wed, 18 Mar 2026 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODFnzVc8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40851395DA5
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773873027; cv=none; b=d1lmaN1YbwI27uGvbpOkK6dSpIIU39wuyR3MzdZJxGioXhxslKoClUqaFOfAoJBu9P5YPjwJ0j/jg1gt0M0Lm5sd0xsqGDdgu0sUgvDmuGr/n9boQfhsQDBf5rSqtjnWobAOyDnYL/XME6dcHBIfOoJzdtnueHTR5WMnrpNC/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773873027; c=relaxed/simple;
	bh=fnjImx7VCwMKBpHwkDW1K85lk6CY/A2Ul7Cqjhn0QzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpvY1uWrrSZk+HulZHFQdPREn6wKlEejo2zWFDu6jgFelM8NnkhRP4zjtm06l0kDlkgz14DmU0kQMcioRkTO/NGEPlB1ur9Mwk/YhiBUF9MXtE1m4E5/fL/lTMs7G2MclVo5WTIZJVRZxPlWbaTm/Dz0M5SIz2xMvBNdVwzLs4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODFnzVc8; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d75371d873so415919a34.3
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773873022; x=1774477822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKrmsaRryTJ5nHXiiuirqMc/v+zxITLhw4bMyN6ZWm0=;
        b=ODFnzVc858qDi1mXZysSz7VqRXZ85fqpT46m+xw2hCc9HoK+NtVe89BIpGAhlBGfyU
         5ezJDUWEqTUnfH7FhbRGCtzJSao3DOonIXH+/ApmLLNzbaIGxGaD9QGgBvPvfFwqMXth
         aN659UwJvSnoeL3AchKQx8fAL8UOMCQVpaIWi4IvXdYuS3kU0hOElHN4vlALkfnXKXwj
         2oMnALciPcEHPy4MUeOKoj/X8Rn5DSoCAsUlfhFXaZCjT6aYTVkpuq99Iuf9aRG+PT55
         fRbqLOmnGkYGR7qFQXb9U3tgQ7ui2Stny67g/GdX2maZCsudg/LosPB3Q2U9xP043z/E
         n1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773873022; x=1774477822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKrmsaRryTJ5nHXiiuirqMc/v+zxITLhw4bMyN6ZWm0=;
        b=RBx/e6QigK4BPMzdq1K8d3OBAcqvCbeFRYYAxipEWG3Wu5LKN11FmqfNd2uWCAqI3z
         ak/vu3YwjP1gFBXOy9RKaEWfeHv+Sdpu+dwhtt7UjdOdR33fc0He7FMZ4z7yKm+4VhoL
         3wCUvrdNIqn6yx2Iu0pI9+TaOtvIOavIpPf1qw1EZVGBCymP0KJw81uqX4oAMYeSwXQT
         wYmIBCII8PXie1ZEGVWHjMfUJb/k+4mrjRbCB/coOBPtHYDgLcPnwFsJ5nMRtceLvlfA
         4S3E+dU19gBCqL9R09ApXy79tqzvjSY8GXIDTe+695W9VQHUsWIZMjZw9e+cagKwxEhq
         6BKA==
X-Forwarded-Encrypted: i=1; AJvYcCW69pLMlgx46ws8oJA7cLUT8Urcp5lSYMhshld8Kjnzk/ud/fcMIaHNCkbIkMezRoc773DXuNBn@vger.kernel.org
X-Gm-Message-State: AOJu0YwIv7wOIQaZFL6yY3YFPthNlYTM/XV8+j0x+ztrr/mgPztPG8+u
	mChVvPMV0Ef0lR8q27a4lASbZ//d5lh+ihd7ob/OH7RiV14uuNg0C6rX
X-Gm-Gg: ATEYQzxx++L0a8/qcDtnKQ1rAsevf4hyLJ15WyPYAn++kv93Lz5K/+iFJgqnObEP9sM
	oImzD47pQjE8OCAZPxHLnNU5kPdZ6c0TNRAdH0nghhmsxbI478OHD+vRfzbJ4M08zoi0qV2F8mr
	Qz6Am8oPxtoWUG+YaKrKgwNKSulJVFyGidwUNMXiQTnRsgVoQz9/VARIL3O2wKq8octnMKUmM5o
	JMB3lEEh1T2Z9vmVc7unOP19cq6CUNm80M9dq0luLuQU5qigp09+ysqxead9nYsD9PpL9jWNrdp
	kD7mIzfeE2uDMAkJPJtbDRxhV6Kx9LM8JJUpvf6WPkz+mEfAOF/Kx3RTcY012Dx9wxr8+E79lBj
	xjUgzVbbb43i87r/kVzW9MhUCOV9UMj91DNiCzfV7jBZu3V3Oi5irWYARSVyZOKE/FSRj+X0uZF
	PYQvaYhe98L9xr57jhbkRlZUV32D2fiTGh50ZBawF2HfQ52Q==
X-Received: by 2002:a05:6830:6af5:b0:7d7:d217:5116 with SMTP id 46e09a7af769-7d7d21752afmr1935454a34.17.1773873022052;
        Wed, 18 Mar 2026 15:30:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7c9b3696asm3133813a34.16.2026.03.18.15.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:30:20 -0700 (PDT)
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
Subject: [PATCH v4 16/21] swap: do not unnecesarily pin readahead swap entries
Date: Wed, 18 Mar 2026 15:29:47 -0700
Message-ID: <20260318222953.441758-17-nphamcs@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-14898-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.876];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 878762C3709
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When we perform swap readahead, the target entry is already pinned by
the caller. No need to pin swap entries in the readahead window that
belongs in the same virtual swap cluster as the target swap entry.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/swap.h       |  1 +
 mm/swap_state.c | 22 +++++++++-------------
 mm/vswap.c      | 10 ++++++++++
 3 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index d7981ec82cf49..2229c3485b7e2 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -213,6 +213,7 @@ void swap_cache_lock(swp_entry_t entry);
 void swap_cache_unlock(swp_entry_t entry);
 void vswap_rmap_set(struct swap_cluster_info *ci, swp_slot_t slot,
 			   unsigned long vswap, int nr);
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2);
 
 static inline struct address_space *swap_address_space(swp_entry_t entry)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index ad80bf098b63f..e8e0905c7723f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -553,22 +553,18 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 		pte_unmap(pte);
 		pte = NULL;
 		/*
-		 * Readahead entry may come from a device that we are not
-		 * holding a reference to, try to grab a reference, or skip.
-		 *
-		 * XXX: for now, always try to pin the swap entries in the
-		 * readahead window to avoid the annoying conversion to physical
-		 * swap slots. Once we move all swap metadata to virtual swap
-		 * layer, we can simply compare the clusters of the target
-		 * swap entry and the current swap entry, and pin the latter
-		 * swap entry's cluster if it differ from the former's.
+		 * The target entry is already pinned - if the readahead entry
+		 * belongs to the same cluster, it's already protected.
 		 */
-		swapoff_locked = tryget_swap_entry(entry, &si);
-		if (!swapoff_locked)
-			continue;
+		if (!vswap_same_cluster(entry, targ_entry)) {
+			swapoff_locked = tryget_swap_entry(entry, &si);
+			if (!swapoff_locked)
+				continue;
+		}
 		folio = __read_swap_cache_async(entry, gfp_mask, mpol, ilx,
 						&page_allocated, false);
-		put_swap_entry(entry, si);
+		if (swapoff_locked)
+			put_swap_entry(entry, si);
 		if (!folio)
 			continue;
 		if (page_allocated) {
diff --git a/mm/vswap.c b/mm/vswap.c
index fbb7c6003ad8c..b391511e0f0b9 100644
--- a/mm/vswap.c
+++ b/mm/vswap.c
@@ -1418,6 +1418,16 @@ void put_swap_entry(swp_entry_t entry, struct swap_info_struct *si)
 	rcu_read_unlock();
 }
 
+/*
+ * Check if two virtual swap entries belong to the same vswap cluster.
+ * Useful for optimizing readahead when entries in the same cluster
+ * share protection from a pinned target entry.
+ */
+bool vswap_same_cluster(swp_entry_t entry1, swp_entry_t entry2)
+{
+	return VSWAP_CLUSTER_IDX(entry1) == VSWAP_CLUSTER_IDX(entry2);
+}
+
 static int vswap_cpu_dead(unsigned int cpu)
 {
 	struct vswap_cluster *cluster;
-- 
2.52.0


