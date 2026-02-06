Return-Path: <cgroups+bounces-13733-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APiaF+SWhWk7DwQAu9opvQ
	(envelope-from <cgroups+bounces-13733-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 08:23:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09799FAED9
	for <lists+cgroups@lfdr.de>; Fri, 06 Feb 2026 08:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97F0D3017781
	for <lists+cgroups@lfdr.de>; Fri,  6 Feb 2026 07:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16CF30B518;
	Fri,  6 Feb 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kWhW/9Q2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0A2EC0B0
	for <cgroups@vger.kernel.org>; Fri,  6 Feb 2026 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770362561; cv=none; b=LNnx/BSNzJBTdMbbb9QAuY6FVDruXB9PXjeWlLMZGKfUlzLgOWAf3mz2+8xwvE848n4TSG8ORCIz7pSYycSsWYy7G/j7wovITjUA3i1NO8toaaZngRRkEiuwAcHbujZ85hDDETefn74FTrljZEg61nyd0D50j/3I80PuVwWuNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770362561; c=relaxed/simple;
	bh=F7W3yiVr/M0UglItoXhkGkH8zbC0c5HRKNf8oOiaVgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJVzFObTYlPgfvMFH76SFkELEDAxtygi1UJnpsExgtYa8ZVGlEKgwaib7kg6KylSw9E9OmnF00gyhyogGJNWVcdAt/tfvXOwWETqTQJrdZPbbJOxOioN0dTsOLpZWjLCobz8pD7VXPLuDhruvErhdN69Odx1ucwfxVFWERhcwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kWhW/9Q2; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770362559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlgnQqPR0Eqtlq7a3B9xxhSsLwOvW1r1+v4iZpc7xIc=;
	b=kWhW/9Q2R5RI8yTcLIJXaW0F0l2jwPZG+wn3xYTgRi6V2vts0omDsq/CDPphq2QsoFQECt
	pB69MQnUf5fELBEb3fISrxDsqxbq4Sup6C9qWK5NiqR0+CP+L6VppMGK7XQRDgrd+KCkPl
	HxmYS3RrMHIqcKlfVnmPms3K/Gs431M=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/2] mm: zswap: add per-memcg stat for incompressible pages
Date: Fri,  6 Feb 2026 15:22:15 +0800
Message-ID: <20260206072220.144008-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260206072220.144008-1-jiayuan.chen@linux.dev>
References: <20260206072220.144008-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[shopee.com,gmail.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linux.dev,linux-foundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13733-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 09799FAED9
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

The global zswap_stored_incompressible_pages counter was added in commit
dca4437a5861 ("mm/zswap: store <PAGE_SIZE compression failed page as-is")
to track how many pages are stored in raw (uncompressed) form in zswap.
However, in containerized environments, knowing which cgroup is
contributing incompressible pages is essential for effective resource
management [1].

Add a new memcg stat 'zswap_incomp' to track incompressible pages per
cgroup. This helps administrators and orchestrators to:

1. Identify workloads that produce incompressible data (e.g., encrypted
   data, already-compressed media, random data) and may not benefit from
   zswap.

2. Make informed decisions about workload placement - moving
   incompressible workloads to nodes with larger swap backing devices
   rather than relying on zswap.

3. Debug zswap efficiency issues at the cgroup level without needing to
   correlate global stats with individual cgroups.

While the compression ratio can be estimated from existing stats
(zswap / zswapped * PAGE_SIZE), this doesn't distinguish between
"uniformly poor compression" and "a few completely incompressible pages
mixed with highly compressible ones". The zswap_incomp stat provides
direct visibility into the latter case.

[1]: https://lore.kernel.org/linux-mm/CAF8kJuONDFj4NAksaR4j_WyDbNwNGYLmTe-o76rqU17La=nkOw@mail.gmail.com/
Acked-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 5 +++++
 include/linux/memcontrol.h              | 1 +
 mm/memcontrol.c                         | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce..78a329414615 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1737,6 +1737,11 @@ The following nested keys are defined.
 	  zswpwb
 		Number of pages written from zswap to swap.
 
+	  zswap_incomp
+		Number of incompressible pages currently stored in zswap
+		without compression. These pages could not be compressed to
+		a size smaller than PAGE_SIZE, so they are stored as-is.
+
 	  thp_fault_alloc (npn)
 		Number of transparent hugepages which were allocated to satisfy
 		a page fault. This counter is not present when CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index b6c82c8f73e1..d8ec05dd5d43 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -39,6 +39,7 @@ enum memcg_stat_item {
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
+	MEMCG_ZSWAP_INCOMP,
 	MEMCG_NR_STAT,
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 007413a53b45..a6b6cf5f1aeb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -341,6 +341,7 @@ static const unsigned int memcg_stat_items[] = {
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
+	MEMCG_ZSWAP_INCOMP,
 };
 
 #define NR_MEMCG_NODE_STAT_ITEMS ARRAY_SIZE(memcg_node_stat_items)
@@ -1346,6 +1347,7 @@ static const struct memory_stat memory_stats[] = {
 #ifdef CONFIG_ZSWAP
 	{ "zswap",			MEMCG_ZSWAP_B			},
 	{ "zswapped",			MEMCG_ZSWAPPED			},
+	{ "zswap_incomp",		MEMCG_ZSWAP_INCOMP		},
 #endif
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
@@ -5458,6 +5460,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
 	memcg = obj_cgroup_memcg(objcg);
 	mod_memcg_state(memcg, MEMCG_ZSWAP_B, size);
 	mod_memcg_state(memcg, MEMCG_ZSWAPPED, 1);
+	/* size == PAGE_SIZE means compression failed, page is incompressible */
+	if (size == PAGE_SIZE)
+		mod_memcg_state(memcg, MEMCG_ZSWAP_INCOMP, 1);
 	rcu_read_unlock();
 }
 
@@ -5481,6 +5486,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 	memcg = obj_cgroup_memcg(objcg);
 	mod_memcg_state(memcg, MEMCG_ZSWAP_B, -size);
 	mod_memcg_state(memcg, MEMCG_ZSWAPPED, -1);
+	/* size == PAGE_SIZE means compression failed, page is incompressible */
+	if (size == PAGE_SIZE)
+		mod_memcg_state(memcg, MEMCG_ZSWAP_INCOMP, -1);
 	rcu_read_unlock();
 }
 
-- 
2.43.0


