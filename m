Return-Path: <cgroups+bounces-14856-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIogAq3guWk7PAIAu9opvQ
	(envelope-from <cgroups+bounces-14856-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:15:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2802B40CC
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 00:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F20E830C32D2
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 23:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49F73FA5C9;
	Tue, 17 Mar 2026 23:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muesGX3u"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE83F9F2A
	for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788847; cv=none; b=WDw2xyqHMlHByhcF2gvz8I9XT63A/wA5xUOKoGLMV/dvVfm6QMq99FkqvX4MoyJ4eNdX3LTl2lMge/s9Qh681c2gBzbacxomwvns3/bikRut9PfsaCfuoxcOGFMbal/56MW9XQoHyIHTwKBY6q4aQBlMUcjrM41x19KBuwuXAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788847; c=relaxed/simple;
	bh=lTY2DkVlB1ZqmArZtsCW+40/HO85obKkV4Bbav50FdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jjuqBg4mmM2vH7HdU+S1aEQdpZJQMUB0xwA+Cg+9QzO+lW4ut7WnymNFyGfbqyWk82JvBYCh1b5l8b3ylIRZHnvVJKSm51jLEcw+RZ18UOVkvHr0948MWPJluz4IYkVEE+f9Ab4nqZ5vpGnT+5MC5jU0ZCgJByM7MnsfVbpk7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muesGX3u; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae3badc00dso91913975ad.3
        for <cgroups@vger.kernel.org>; Tue, 17 Mar 2026 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773788845; x=1774393645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=By9SVSNyV82E5eeo5rQU1kGPzHgbL0ThBDCP4IlBKCg=;
        b=muesGX3uZ4sPoOWXsfwkJ0bxJTO3/DnReO0HtDdsSTAWX0sKLtEFLVvSjQi8tyXgNE
         NnXn2mUvxDExVOJJkF3ZNnfMXXIM/6vYssOp2tEEeBffq7PiI3TZ4CJIpBaFGysUB2VY
         77bcubsbrlT3unBOEm90JZ3j9KUB+8xXzOHAt+SXGo7ChYx0izEaRF8Wd7qRpar2m2rh
         SRcp+Z5UPGBBb192UxDAN3k9ASktuSMPi5oYHd7F9VeEiBRdG9san6bk3iaPed/ofNEm
         7G8R6JDMbphBKCc8N9bxEls8sKIfm8UhPfi4X75WkENOx1xaVMPgxae/gccB0HuYpGm0
         HkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773788845; x=1774393645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=By9SVSNyV82E5eeo5rQU1kGPzHgbL0ThBDCP4IlBKCg=;
        b=JY8WkbHcZ68S/7TROsER7saw0PRZUziulXN54Y7BPyVcJE2d6wkZ8vV3akDZ/pJ6nH
         b6YNQlA4itZMXCkNuT6WeP9T2JWY72WVLmQIBOCRV7+wivzBAb/zZpgGpfL5VORgav0B
         60vYiQOZ6dgbaTy1pPLSdRmjV7dMXckZ633xxhbrb8Gdq5SKlPGTgfZ3Obj/8YfPFFjI
         W/zbiDhRWWjTieXU4/xyGzZYU1Z77KO3A3gieyrBEmkJiKxBcrcSoYcTOddG2x//QLdt
         5PZ7oAvQMAX0v3dP09Q6dNxq076X9XEjzbiSvWC9YN7e/0z9EQBA9QnOzE5VbsRGJmSX
         p//w==
X-Forwarded-Encrypted: i=1; AJvYcCV5XeyxhxE4N2Dj9CN+TmtgIwMHY4YxilRWEuwGuXSkZb+FRPzr1DF6eYsQ/Y+QVTuI2+d5vogB@vger.kernel.org
X-Gm-Message-State: AOJu0YyiX2HEJkY6ne+OS421oTziMCkNJuTdubIIMSBr2ezsc69ymPAz
	zdpYKJbWOXh4w4cjPKkmVjRUE8b+3jllBfXZ3R6l5WKFUtVSWL0jnA85w58fB0MllcaZ2ohNurs
	4vNuYQCZV2f+nmg==
X-Received: from plbli7.prod.google.com ([2002:a17:903:2947:b0:2b0:4e8e:5c09])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f544:b0:2ae:4732:285a with SMTP id d9443c01a7336-2b06e332b4fmr12404475ad.3.1773788845155;
 Tue, 17 Mar 2026 16:07:25 -0700 (PDT)
Date: Tue, 17 Mar 2026 23:07:01 +0000
In-Reply-To: <20260317230720.990329-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260317230720.990329-1-bingjiao@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317230720.990329-3-bingjiao@google.com>
Subject: [PATCH 2/3] mm/memcontrol: disable demotion in memcg direct reclaim
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: Bing Jiao <bingjiao@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, 
	Yosry Ahmed <yosry@kernel.org>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, David Hildenbrand <david@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14856-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,vger.kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,bytedance.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB2802B40CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NUMA demotion counts towards reclaim targets in shrink_folio_list(), but
it does not reduce the total memory usage of a memcg. In memcg direct
reclaim paths (e.g., charge-triggered or manual limit writes), where
demotion is allowed, this leads to "fake progress" where the reclaim
loop concludes it has satisfied the memory request without actually
reducing the cgroup's charge.

This could result in inefficient reclaim loops, CPU waste, moving all
pages to far-tier nodes, and potentially premature OOM kills when the
cgroup is under memory pressure but demotion is still possible.

Introduce the MEMCG_RECLAIM_NO_DEMOTION flag to disable demotion in
these memcg-specific reclaim paths. This ensures that reclaim
progress is only counted when memory is actually freed or swapped out.

Signed-off-by: Bing Jiao <bingjiao@google.com>
---
 include/linux/swap.h |  1 +
 mm/memcontrol-v1.c   | 10 ++++++++--
 mm/memcontrol.c      | 16 +++++++++++-----
 mm/vmscan.c          |  1 +
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7a09df6977a5..e83897a6dc72 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -356,6 +356,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone

 #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
 #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
+#define MEMCG_RECLAIM_NO_DEMOTION (1 << 3)
 #define MIN_SWAPPINESS 0
 #define MAX_SWAPPINESS 200

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 433bba9dfe71..3cb600e28e5b 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1466,6 +1466,10 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	int ret;
 	bool limits_invariant;
 	struct page_counter *counter = memsw ? &memcg->memsw : &memcg->memory;
+	unsigned int reclaim_options = MEMCG_RECLAIM_NO_DEMOTION;
+
+	if (!memsw)
+		reclaim_options |= MEMCG_RECLAIM_MAY_SWAP;

 	do {
 		if (signal_pending(current)) {
@@ -1500,7 +1504,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 		}

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
+						 reclaim_options, NULL)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -1520,6 +1524,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 {
 	int nr_retries = MAX_RECLAIM_RETRIES;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
+				       MEMCG_RECLAIM_NO_DEMOTION;

 	/* we call try-to-free pages for make this cgroup empty */
 	lru_add_drain_all();
@@ -1532,7 +1538,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 			return -EINTR;

 		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
-						  MEMCG_RECLAIM_MAY_SWAP, NULL))
+						  reclaim_options, NULL))
 			nr_retries--;
 	}

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 303ac622d22d..fcf1cd0da643 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2287,6 +2287,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 				  gfp_t gfp_mask)
 {
 	unsigned long nr_reclaimed = 0;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
+				       MEMCG_RECLAIM_NO_DEMOTION;

 	do {
 		unsigned long pflags;
@@ -2300,7 +2302,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							gfp_mask,
-							MEMCG_RECLAIM_MAY_SWAP,
+							reclaim_options,
 							NULL);
 		psi_memstall_leave(&pflags);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
@@ -2572,7 +2574,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		/* Avoid the refill and flush of the older stock */
 		batch = nr_pages;

-	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
+	reclaim_options = MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_NO_DEMOTION;
 	if (!do_memsw_account() ||
 	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
 		if (page_counter_try_charge(&memcg->memory, batch, &counter))
@@ -2610,7 +2612,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,

 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options, NULL);
+					gfp_mask, reclaim_options, NULL);
 	psi_memstall_leave(&pflags);

 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -4638,6 +4640,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
+				       MEMCG_RECLAIM_NO_DEMOTION;
 	bool drained = false;
 	unsigned long high;
 	int err;
@@ -4669,7 +4673,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}

 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
+					GFP_KERNEL, reclaim_options, NULL);

 		if (!reclaimed && !nr_retries--)
 			break;
@@ -4690,6 +4694,8 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
 	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
+	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP |
+				       MEMCG_RECLAIM_NO_DEMOTION;
 	bool drained = false;
 	unsigned long max;
 	int err;
@@ -4721,7 +4727,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,

 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL))
+					GFP_KERNEL, reclaim_options, NULL))
 				nr_reclaims--;
 			continue;
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 33287ba4a500..7a8617ba1748 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6809,6 +6809,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.may_unmap = 1,
 		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
 		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
+		.no_demotion = !!(reclaim_options & MEMCG_RECLAIM_NO_DEMOTION),
 	};
 	/*
 	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
--
2.53.0.851.ga537e3e6e9-goog


