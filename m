Return-Path: <cgroups+bounces-14958-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC2sODegvWkM/wIAu9opvQ
	(envelope-from <cgroups+bounces-14958-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:29:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C677C2DFF77
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 20:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDDE93028B40
	for <lists+cgroups@lfdr.de>; Fri, 20 Mar 2026 19:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0013F2107;
	Fri, 20 Mar 2026 19:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axLPzN6b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110273F0AA1
	for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 19:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034886; cv=none; b=rl61KABF+tGfplfROqWQrYd6KfD9gPysduvZ3Dm3oCjYY1vMMwgYaOGdze53IXlFOes7I4+/TzKhwjpsFEqZ+jJf2zi3NZDehtVytP0f8EYUz4CAWijoAA3pEOlfip9RaUa0JjG85qIOIOIHSe0wj+Tk2AAmNdyscFkFBtgp4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034886; c=relaxed/simple;
	bh=0lBeslgTwumQ6urHnq8I/VnBlJMW9R3VWIV0MRlceUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpMhDR0/Q+t0Bgy7fI24/y7nTIn9Tuqgyu1iFlDaLbytIByBMGAVWI4uhmHPGkT1pY0RrktxWaxSQNJcjqqKUaHxrexNnxNEHXOZefmkBpcgNkGSDiXaai1gIugVKZ9BpO2mAmi9I0+A6ECNPUXEHI7B3UFN4ptCXhXh1oSg5SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axLPzN6b; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-46704fbf62dso1559458b6e.1
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774034882; x=1774639682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRgUJ4HYnVe4CBYlwtFXukX7KCRZK3pYV2dpIHw1BJw=;
        b=axLPzN6bCHXoa8URBDvzI6IIOgpda+FO4AkKeH1YXcPZHvMZxN4uer5DfzSAhKT3nP
         nd4cvxWXYxu6pUh8DqGDI8CvE3znj3u7aM2jjzbOri6GUB6xaLLKeHbAhmZ0qQsa8ncB
         rFa0AO1noZJLRzyIedAzMkcJ+CNxI8OfIH+UHhBbU1SykdAHbEDW6tKmpcP0rvRRkrSd
         BfG9yxoYYfLRlpxoib+YlvXD8HZCtl085Ho8pXeN8isrFrYZqCyiPloiMjSmcvq6XM+Q
         iUj/b2Dy1Lg+weNF+2tFl+/h7ZEiYqOe0qxsQmtIsvuH/4FD6CY7R2qO/YzKZh70dYxB
         msLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034882; x=1774639682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kRgUJ4HYnVe4CBYlwtFXukX7KCRZK3pYV2dpIHw1BJw=;
        b=Qjt33+c2QI1kJ8dbGEzbYKN3uxEWZjy6JRpwsQjJCj58S2psPytlHLRUKxkGskGBPs
         wuDiCJl8lTHhnMW5fiMCWXjWnQidJowly9oEYQ4JcftDgjGyzPwoycZR8rTKylumTU57
         hwoyj8JP9evkk4B+sf9gmRiQjeWrXc9YtRy3BC3GuDtPVZi4ElMAiN4JBjC1CendEc1L
         b4bmrmXw+6E5E8+QjObz7ebQJAVXDX8BNYt6JY66WfDSH39f6JPEJ08U1tNYCZ7ZUcIg
         TbQCvnFXUslKkGYdzQeBig+pUBgXsOx+TjOw7NtV++3T6C10mAXvFTW6m1IKMTzgyOCo
         NtdA==
X-Forwarded-Encrypted: i=1; AJvYcCVcN/FfstpSLjMq4g372y5gWJjCMeI6aIKqwOueeBwnQBSa4as0783nmuXnhSehxLEOTXjw1rIk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw8g40woA03zgX9cIBVmmsENSFD9n+XKKuPUJKqcVDpIoM5B6H
	gV5pulw7SpKdqNwaE4NkN23NwKqMHZn9TD6XGWsw6PG6hlFSwKKtDOv4
X-Gm-Gg: ATEYQzyAx+btB7VYqxd965/3wvkVBWwBFgbw6p7W8n22v4nMxJ3lueFMY/6luqsLcyu
	ElK/fR74RysXB1SaRNLld478IRdmfaweUJk0LkkHKKxautoaU7PjIqKW2+K/N9/YJcWyJKr3zVW
	zyRwl+HsOf82scgxDghUI53neo6JKfYKq9bjLUQZjJliDg1prddaTptj3oJG8D1PrADHS9+lDBj
	DyBvmjGLrhAf/z1LfwzY4DWw2SeRVFGWGpM4K0GKMgh2lrR6jgjEW/Fy9K01eSvGhZiSbblBHNf
	XEqJcgvgpdH0UgHpGnKzNEjycK0pCvfOiPO1frUdMWcaPKfZxbiOKXS3ZHizsQDVnR/0ADiFdYc
	BqWKqQCboEe/rWHsJMZg/OX/dpXYyySt8DFcWKiLFtp2ejfRlX5sba7s/dXS4JcsTfF0UaOhNdo
	bNGBYT0KjxVUJxSAtNx/NT1ffkyPIwtXYiKNY1jfQSAuR5aQ==
X-Received: by 2002:a05:6808:130b:b0:467:24cb:c00 with SMTP id 5614622812f47-467e5fbd406mr2192297b6e.57.1774034881749;
        Fri, 20 Mar 2026 12:28:01 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d4c447sm1921168b6e.6.2026.03.20.12.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 12:28:01 -0700 (PDT)
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
Subject: [PATCH v5 16/21] swap: do not unnecesarily pin readahead swap entries
Date: Fri, 20 Mar 2026 12:27:30 -0700
Message-ID: <20260320192735.748051-17-nphamcs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14958-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.878];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C677C2DFF77
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
index 861a504c9fbfd..1040bb8a9f320 100644
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


