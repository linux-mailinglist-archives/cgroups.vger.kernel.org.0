Return-Path: <cgroups+bounces-16171-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCyqDMY6D2otIAYAu9opvQ
	(envelope-from <cgroups+bounces-16171-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 19:03:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C70B35A9CF6
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D64B8328D39F
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E637204A;
	Thu, 21 May 2026 15:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="tU/jJ+b3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4522E33A9CB
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375836; cv=none; b=ArAqd1qmXs48lj0Aum/9bI+wFbUbFES4SF38YI3CQEg3Wm+LBPGzBIDbgitDqIpcEWfSef+H7xTKw9qu7vf9v/7zPS/+PzsUP/u+bO+jPuMj8W3/OFaRuNtNlUmmAP/J6X8hl9qLB13p3y5r4BXAzUzrtIwiNyPtYie4/d1N8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375836; c=relaxed/simple;
	bh=XDHwiXK7DhsPrkpYFuamx5LXb9zFWccd6v2gAdweAKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VufUHxjzNPwGMrOOqy3EGlGDE79ZZTr/2vsMw2K2n2DLNwgCwWfj6SHj/SYLlu6DiC8gKYxcP8t0bXhEXlXiW9TLiDzEedqa/NiG5Vy7oYr4mpa0JIEHB82sn7nkmnpMtJcJ9eVYcNN8qZsLc8MVcr4xAOuA1WDWdSfb1PUGmAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=tU/jJ+b3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51306c9f2e1so74840271cf.0
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779375834; x=1779980634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR/PuWQM6I0Sn5LudGZTwz22IXjqotRj7EvDPtJsrZA=;
        b=tU/jJ+b3fBUHI05Ny9Rarn81/d3LqESIs0nKlG4J1eEJheSlCQtFCP/32+74qqqEtI
         bAdTQ++1D4trnZNETWRTCBHKF53dmE9Tyvsd96vybtCVHR2JQQRegJe7wvcKO/7IcKzq
         1FdlSwn2Hle05Fe9IlqugXYvLCJUUiinjbqjw1z8PcSwbroD53IhGY00Yr51xftalFC0
         2NKvSdt13c5hasmceAlg26aaIRKe4AzRI/CEhBcAMmrjkfVE+EdfuiVp37UhR6LjzfEn
         puQRixSBwQ2yiNxRWMiDFJ8e+HG6Op9aZa39+k5t6yoRzbHL36MLau3xZbd0zS/h/pyh
         ZzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375834; x=1779980634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rR/PuWQM6I0Sn5LudGZTwz22IXjqotRj7EvDPtJsrZA=;
        b=Ss5g1DsVqfmdixeWLj3Y7BFWvsHg/NpTeYkbbE2+9KhFaLIgzwvEUNXG/LhBx7uK45
         hqT9tkOC3/d+blMQPCV98Ysv6pMliiQhbMX4dBd8tM4mdpaMf+t6wDmU6aOkuUlZSgR9
         6S6AWlrh5emlPOHOFSdzZlNYGrgfPBmdYifJuMtbuD6Q0t/IC7UU8INSiZlwlyA3zpv3
         Wpn9vQzdp6B8Jcxn3972XUQlAaBgIOZ7kTWfv0i0RTF9kciGMmJZHlHlVwy8un/vDay3
         pvw1zhyQU47N5UKMC06o6uwVsuJOGFkUdMBiGhh/xYCeAyusjT46VWeYISVrTFACeLc4
         psJA==
X-Forwarded-Encrypted: i=1; AFNElJ/E7LoOYTurSb0BV5w17FtF46NCJJ25QVwoLOIlJSkxHmtwH8c6oYfN2ZRTtE6aooXFOszOXf2N@vger.kernel.org
X-Gm-Message-State: AOJu0YzsFPjVzIfuypAJ7SPW7wFPyI+NHJwElk/EgZPI+nAqrTImhBzk
	gZp4Bhi+qt66aZ5VQNbJ+Ly2fDiK1Ux0Y/ct3+sDEHUU+NjTQK/iBd9HlwlQmbjCfNA=
X-Gm-Gg: Acq92OE+czoAr/XEb+C/ENKI+7PB4elnj96J67Xj1so9fQBPOk4rlVpnZmM0xrwwAGx
	x2ZpZDGT2MycdFdXexjthkqbwI8S5o9QBnZZdgYM4Vf5vr+JBVlVwfXGK6g9JW5HSdkxEXfLmbM
	SnsyFvQ4I2G2kIgUvxKJfEBkKhIdlDwFKUSe8tXGiJd7gTQ8w1LX/GW0fS7RbKMBwE+fAgUU5x5
	86DudUVsGX7bJmBysmrXbiRVxLXtNbrr5wDc/AXFZeLhMZvqae993LfC3AL8yyqgBgY2GqzzS7a
	A5M6uU+dJ6PGQ5QZsiBfj7dBD0K875YKQOXONvyirJnjp7RFWy1zRSPLIiRedRARHusmkyMIspz
	K7bzmuwz/dtDFCq8i6jantPH44e8oFrE3e0tyLHWWOYJwWlqFPcGlX6Oh71Vqt9dKkfNPJVeIP5
	O1gJkvwkDkRo5nIFmNy0hJXW6JRBhp9oNV
X-Received: by 2002:ac8:5e0f:0:b0:50f:b3d2:6ee1 with SMTP id d75a77b69052e-516c555a206mr43518571cf.31.1779375834075;
        Thu, 21 May 2026 08:03:54 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516ccba5ffdsm9168671cf.5.2026.05.21.08.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:03:52 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] mm: list_lru: introduce folio_memcg_list_lru_alloc()
Date: Thu, 21 May 2026 11:02:12 -0400
Message-ID: <20260521150330.1955924-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150330.1955924-1-hannes@cmpxchg.org>
References: <20260521150330.1955924-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16171-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C70B35A9CF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

memcg_list_lru_alloc() is called every time an object that may end up
on the list_lru is created. It needs to quickly check if the list_lru
heads for the memcg already exist, and allocate them when they don't.

Doing this with folio objects is tricky: folio_memcg() is not stable
and requires either RCU protection or pinning the cgroup. But it's
desirable to make the existence check lightweight under RCU, and only
pin the memcg when we need to allocate list_lru heads and may block.

In preparation for switching the THP shrinker to list_lru, add a
helper function for allocating list_lru heads coming from a folio.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/list_lru.h | 27 +++++++++++++++++++++++++++
 mm/list_lru.c            | 39 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index c79ed378311f..733a262b91e5 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -81,6 +81,33 @@ static inline int list_lru_init_memcg_key(struct list_lru *lru, struct shrinker
 
 int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			 gfp_t gfp);
+
+#ifdef CONFIG_MEMCG
+/**
+ * folio_memcg_list_lru_alloc - allocate list_lru heads for shrinkable folio
+ * @folio: the newly allocated & charged folio
+ * @lru: the list_lru this might be queued on
+ * @gfp: gfp mask
+ *
+ * Allocate list_lru heads (per-memcg, per-node) needed to queue this
+ * particular folio down the line.
+ *
+ * This does memcg_list_lru_alloc(), but on the memcg that @folio is
+ * associated with. Handles folio_memcg() access rules in the fast
+ * path (list_lru heads allocated) and the allocation slowpath.
+ *
+ * Returns 0 on success, a negative error value otherwise.
+ */
+int folio_memcg_list_lru_alloc(struct folio *folio, struct list_lru *lru,
+			       gfp_t gfp);
+#else
+static inline int folio_memcg_list_lru_alloc(struct folio *folio,
+					     struct list_lru *lru, gfp_t gfp)
+{
+	return 0;
+}
+#endif
+
 void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 /**
diff --git a/mm/list_lru.c b/mm/list_lru.c
index df58226eea8c..4eeb4351c475 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -562,17 +562,14 @@ static inline bool memcg_list_lru_allocated(struct mem_cgroup *memcg,
 	return idx < 0 || xa_load(&lru->xa, idx);
 }
 
-int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
-			 gfp_t gfp)
+static int __memcg_list_lru_alloc(struct mem_cgroup *memcg,
+				  struct list_lru *lru, gfp_t gfp)
 {
 	unsigned long flags;
 	struct list_lru_memcg *mlru = NULL;
 	struct mem_cgroup *pos, *parent;
 	XA_STATE(xas, &lru->xa, 0);
 
-	if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
-		return 0;
-
 	gfp &= GFP_RECLAIM_MASK;
 	/*
 	 * Because the list_lru can be reparented to the parent cgroup's
@@ -613,6 +610,38 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 
 	return xas_error(&xas);
 }
+
+int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
+			 gfp_t gfp)
+{
+	if (!list_lru_memcg_aware(lru) || memcg_list_lru_allocated(memcg, lru))
+		return 0;
+	return __memcg_list_lru_alloc(memcg, lru, gfp);
+}
+
+int folio_memcg_list_lru_alloc(struct folio *folio, struct list_lru *lru,
+			       gfp_t gfp)
+{
+	struct mem_cgroup *memcg;
+	int res;
+
+	if (!list_lru_memcg_aware(lru))
+		return 0;
+
+	/* Fast path when list_lru heads already exist */
+	rcu_read_lock();
+	memcg = folio_memcg(folio);
+	res = memcg_list_lru_allocated(memcg, lru);
+	rcu_read_unlock();
+	if (likely(res))
+		return 0;
+
+	/* Allocation may block, pin the memcg */
+	memcg = get_mem_cgroup_from_folio(folio);
+	res = __memcg_list_lru_alloc(memcg, lru, gfp);
+	mem_cgroup_put(memcg);
+	return res;
+}
 #else
 static inline void memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
 {
-- 
2.54.0


