Return-Path: <cgroups+bounces-13877-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOoBOqxcjWns1QAAu9opvQ
	(envelope-from <cgroups+bounces-13877-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 05:53:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA2612A54F
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 05:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20F3E315F0AD
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 04:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2896259C94;
	Thu, 12 Feb 2026 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV23WAps"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03652238C07
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770871894; cv=none; b=GIWghNhsRqDFU9rDr/jBZYH+pxMFpe3/F61ZNq9tj76i09Jeo5eBzrOIJf2/4Vy+PlAClS7ur4mcvN83GiSsQKPTXLEW3MLXZ/0OKr5l1ZUDd9Z1eMO8fiy8bMk+ComDaqWzaDgiXf1grRLrsHVGN85mjtLtlNv5pCNMvjAaP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770871894; c=relaxed/simple;
	bh=3KDDnkAfe9/mVhflKpeuOU6R545jzogvk/ExLONqcck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hH3cCSgId5EKXaWdLqeL/3Jzc3mF74amReURV2TZbAY3cIOYE3NjJdMMEBcDPkYcRPkPyfgSN41cblUdaJF284DZz4/R9a1X+U5spJac0CT6He3IwN1egzaPXdflCBPZWp8/vp8fO+Z8MBBK3lJzQzYmH6JXIaT6RbXaaXj17+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV23WAps; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso4466394eec.1
        for <cgroups@vger.kernel.org>; Wed, 11 Feb 2026 20:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770871891; x=1771476691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3624LeowZDDBkH5ZBXE4RT1ghzAQISXfFg8F+edSqSU=;
        b=KV23WAps2qEPln42T408fdhEfWmTQOkKPlwkxqxsj+SKL/tlUt6cA9BjK1NpCIt0b5
         hcqgbMQCmkXe2c+nvRZLxmlG4EUoWw+0gKnlQfpF6OU8yVTgpaDeP9daQs0CU5x6gFDa
         E05+16jjqzSVyClupLkWaNdUgzeK9kBkTzN9HVNnbMEv6Rv7c5TFkiijfHUH4lznpdhJ
         ydbQDC2yiEM1RMQ+PRH0CwD+IPkJ8th+d1UBht1O+lgWxMYf4NqsNEjAvD/M+7vXZ8qF
         QO5kK+tpaqZkeNi+FKhMtXYs8L8CGGMOmdbM4kW7uJ+u7fY6HhzTepLWiTRHQG6uBaLN
         hHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770871891; x=1771476691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3624LeowZDDBkH5ZBXE4RT1ghzAQISXfFg8F+edSqSU=;
        b=Lc57axenYbubxlHQEZxdo8F+UXmWr+tktEi/osaw2ZRKx+yJ9DIXGVVMYWjizy8oDt
         FFL/F6s0WZc18fkgVQOUh53Lw8kb0AJQSdsBMEeOB4A0hwwc6I0Vfc5wPSLRs5eLshTt
         NMgXtgFRSw5TSq37RE40QtlXjUstUcMwwEnB0WM7sOb2ie/o4I3fccbW2KuxEOCOfpq/
         iO7KclF55kH1CaeMhnJmieWK1VLwROVvrlC1kn55yEVgiEgt0rwFJrlIiODRdwAtYJWv
         pCvewMLrFKTGP1G10S/KvXVHlusjMv3UnPLF6ApwiROPb2QzhcfEdDEoooBOckaFehUk
         NDSA==
X-Forwarded-Encrypted: i=1; AJvYcCWy03QD6LAJ5aXMBPBtgsR0OJZR1GNnSmThf+9KHDKM/VMby6ajrjBuIqp428RY3qxE8LQ0/lMA@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8nGSYJ9R5fszC1ywOvlw6dMez4xQ9L8mIJOKMC6p5Ln2oVbQg
	1aVAW/JUxnUDpkTwsUYuYpFXmpMAC54iZ2oiwYrzBi9xiMinv525UYbx
X-Gm-Gg: AZuq6aJYRfySyrN3Gdbt/jzhktgs/mKGKYo3XIA3asoF2/VYQV8TiHwcS+/pmOvy+Xn
	ugyqWlCSK2knKn9sdjAQUBCULKvcxpPjJBH06giSr1sdpsaElNIPGgrVQPILJUXCGMPs5R5gWeO
	9JitYuKOIP77us7QSgWzHnhzPzaPrNH4DchtmzhoS6sU6TN9hju2Nka8acnt1oc5CQ0/C18iA/G
	54asQiwzdxSgTRV5dbSR+bIYe442nBxNIRUz+T6zWMnyNHcmYweElOQrgGn0RkxF/FyxRVljjZS
	ZI4zpwmHtnkKWeznZZkw1i2332cQRUapI21fn5x6w6om2B/cBYOKBDiGDqNhzuZpdtU2WFWEcu+
	EULScl5iEnqHMfVS0RPp3rtSRzGy5ItCHFbCtWUjSQ2NzrdmYYtf/6fhe8o5Y00A+nm9bQc7/B8
	LRqmHH/iwZQJ+MwKsvivmVyYqGmaX59fgKiwZSnqXv6QtwmNLRbw==
X-Received: by 2002:a05:7301:2f91:b0:2ba:871f:796d with SMTP id 5a478bee46e88-2baa8091399mr577872eec.30.1770871891051;
        Wed, 11 Feb 2026 20:51:31 -0800 (PST)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9daa6151sm2878699eec.0.2026.02.11.20.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 20:51:30 -0800 (PST)
From: JP Kobryn <inwardvessel@gmail.com>
To: linux-mm@kvack.org
Cc: apopple@nvidia.com,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	byungchul@sk.com,
	cgroups@vger.kernel.org,
	david@kernel.org,
	eperezma@redhat.com,
	gourry@gourry.net,
	jasowang@redhat.com,
	hannes@cmpxchg.org,
	joshua.hahnjy@gmail.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	matthew.brost@intel.com,
	mst@redhat.com,
	mhocko@suse.com,
	rppt@kernel.org,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com,
	rakie.kim@sk.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	surenb@google.com,
	virtualization@lists.linux.dev,
	vbabka@suse.cz,
	weixugc@google.com,
	xuanzhuo@linux.alibaba.com,
	ying.huang@linux.alibaba.com,
	yuanchu@google.com,
	ziy@nvidia.com,
	kernel-team@meta.com
Subject: [PATCH 1/2] mm/mempolicy: track page allocations per mempolicy
Date: Wed, 11 Feb 2026 20:51:08 -0800
Message-ID: <20260212045109.255391-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212045109.255391-1-inwardvessel@gmail.com>
References: <20260212045109.255391-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,suse.com,linux.dev,bytedance.com,lists.linux.dev,suse.cz,linux.alibaba.com,meta.com];
	TAGGED_FROM(0.00)[bounces-13877-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_NONE(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EA2612A54F
X-Rspamd-Action: no action

It would be useful to see a breakdown of allocations to understand which
NUMA policies are driving them. For example, when investigating memory
pressure, having policy-specific counts could show that allocations were
bound to the affected node (via MPOL_BIND).

Add per-policy page allocation counters as new node stat items. These
counters can provide correlation between a mempolicy and pressure on a
given node.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  9 +++++++++
 mm/mempolicy.c         | 30 ++++++++++++++++++++++++++++--
 mm/vmstat.c            |  9 +++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fc5d6c88d2f0..762609d5f0af 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -255,6 +255,15 @@ enum node_stat_item {
 	PGDEMOTE_DIRECT,
 	PGDEMOTE_KHUGEPAGED,
 	PGDEMOTE_PROACTIVE,
+#ifdef CONFIG_NUMA
+	PGALLOC_MPOL_DEFAULT,
+	PGALLOC_MPOL_PREFERRED,
+	PGALLOC_MPOL_BIND,
+	PGALLOC_MPOL_INTERLEAVE,
+	PGALLOC_MPOL_LOCAL,
+	PGALLOC_MPOL_PREFERRED_MANY,
+	PGALLOC_MPOL_WEIGHTED_INTERLEAVE,
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 68a98ba57882..3c64784af761 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -217,6 +217,21 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
 		new_iw[nid] /= iw_gcd;
 }
 
+#define CHECK_MPOL_NODE_STAT_OFFSET(mpol) \
+	BUILD_BUG_ON(PGALLOC_##mpol - mpol != PGALLOC_MPOL_DEFAULT)
+
+static enum node_stat_item mpol_node_stat(unsigned short mode)
+{
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_PREFERRED);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_BIND);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_INTERLEAVE);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_LOCAL);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_PREFERRED_MANY);
+	CHECK_MPOL_NODE_STAT_OFFSET(MPOL_WEIGHTED_INTERLEAVE);
+
+	return PGALLOC_MPOL_DEFAULT + mode;
+}
+
 int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
 {
 	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
@@ -2446,8 +2461,14 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 
 	nodemask = policy_nodemask(gfp, pol, ilx, &nid);
 
-	if (pol->mode == MPOL_PREFERRED_MANY)
-		return alloc_pages_preferred_many(gfp, order, nid, nodemask);
+	if (pol->mode == MPOL_PREFERRED_MANY) {
+		page = alloc_pages_preferred_many(gfp, order, nid, nodemask);
+		if (page)
+			__mod_node_page_state(page_pgdat(page),
+					mpol_node_stat(MPOL_PREFERRED_MANY), 1 << order);
+
+		return page;
+	}
 
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 	    /* filter "hugepage" allocation, unless from alloc_pages() */
@@ -2472,6 +2493,9 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 			page = __alloc_frozen_pages_noprof(
 				gfp | __GFP_THISNODE | __GFP_NORETRY, order,
 				nid, NULL);
+			if (page)
+				__mod_node_page_state(page_pgdat(page),
+						mpol_node_stat(pol->mode), 1 << order);
 			if (page || !(gfp & __GFP_DIRECT_RECLAIM))
 				return page;
 			/*
@@ -2484,6 +2508,8 @@ static struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 	}
 
 	page = __alloc_frozen_pages_noprof(gfp, order, nid, nodemask);
+	if (page)
+		__mod_node_page_state(page_pgdat(page), mpol_node_stat(pol->mode), 1 << order);
 
 	if (unlikely(pol->mode == MPOL_INTERLEAVE ||
 		     pol->mode == MPOL_WEIGHTED_INTERLEAVE) && page) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 65de88cdf40e..74e0ddde1e93 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1291,6 +1291,15 @@ const char * const vmstat_text[] = {
 	[I(PGDEMOTE_DIRECT)]			= "pgdemote_direct",
 	[I(PGDEMOTE_KHUGEPAGED)]		= "pgdemote_khugepaged",
 	[I(PGDEMOTE_PROACTIVE)]			= "pgdemote_proactive",
+#ifdef CONFIG_NUMA
+	[I(PGALLOC_MPOL_DEFAULT)]		= "pgalloc_mpol_default",
+	[I(PGALLOC_MPOL_PREFERRED)]		= "pgalloc_mpol_preferred",
+	[I(PGALLOC_MPOL_BIND)]			= "pgalloc_mpol_bind",
+	[I(PGALLOC_MPOL_INTERLEAVE)]		= "pgalloc_mpol_interleave",
+	[I(PGALLOC_MPOL_LOCAL)]			= "pgalloc_mpol_local",
+	[I(PGALLOC_MPOL_PREFERRED_MANY)]	= "pgalloc_mpol_preferred_many",
+	[I(PGALLOC_MPOL_WEIGHTED_INTERLEAVE)]	= "pgalloc_mpol_weighted_interleave",
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
-- 
2.47.3


