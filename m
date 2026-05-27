Return-Path: <cgroups+bounces-16373-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ks2Kr5YF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16373-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:49:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6037E5EA31F
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCB133092782
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0533B47FA;
	Wed, 27 May 2026 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="NVRoLY7g"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B23B38AF
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914905; cv=none; b=HrEblRIAad6iL4jbcO6lmljLY6li8FXEqm2AEOZTyh5gNxLls8OxU1C4Emo1yDBM2auxWaxL/8+jkriBCEIp83NMgFMRMAAklCzHzvhYVes9IZiTZYfDgdtOfk9lQpUZkLLZl1tH+ZxTCfGD0XfDEzrDeMJkpDKtiS0YSOMlJJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914905; c=relaxed/simple;
	bh=N2Ysi3RJi1LDN5IxBqkDR80jjekbuSRg9CVC7t69+nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V03b1IuCqyZr7zqy8FsyL5obHcEZOBDci9E6SmS0icNN9HlsGD/ryFewSSasFenhLUrnYkldeWaLtfVNFwRsTvwNNS6TeJCnA7x8K8us+7gx/YyHSkMGN7mPEwhGUxpuhVoRizlhdHwaUN9XomY7BefYu4uEDIAFPAx99jtYeE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=NVRoLY7g; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-914beab9a08so407766685a.3
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914899; x=1780519699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36NJZcIxb79ojrPGdd3UkzDEUVDRZxNst0ZLZe3TsZo=;
        b=NVRoLY7gfcJNCveCkv+9G3Ch6GovJZZD65SGTeTn8jxRuD/LawEekJ+YSmmSyLQxg5
         40lZXflbHqx/dFbuyhp0H225GyVIVBh7rWPlWnWNUuVKF+ufOhvQNf4kUoQ3PP/WKkoC
         hST01QBrH7VgV6y/0ajHM5U5EfrzG/F5eP/GC95zgmnyvEo+t6ZB3QLYBU4bqGOxPaaG
         MyA2iSRa0cBz7yu5Sa0d9t9lhAi3b3QokVRNadjg1HiPGUxMFoM3B1wqq88zR/9BzYkV
         X+pAkC9IdSEqJpjetpKqUWHZNFcXPNrBhHUd7ikQTttHcqHnlC7C6t6AfRQW4JTBGmYw
         a8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914899; x=1780519699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=36NJZcIxb79ojrPGdd3UkzDEUVDRZxNst0ZLZe3TsZo=;
        b=qJ3HzHbGRbgbLWiRHdOBVSLrSOPkSiOYEuJhmJWQHySFUJ8Uj7DGmtSdNrZwVt9Qvy
         JcsepFBSjcUJO4VMBZ+8xQ8RdG5f7tPfDqYv7wGlBpyRMhdrLJ0rOa9bV4YHWao4yCTa
         9HANC3j5cyhWKQeL9U+8hIrPtWstAHz4rVl1YT3xNUT0ZZVK5PfJDBPz+vsqveGlNInz
         RQmUdbaToKk4RzQYrxi0npuhwL0q0n4y+zb1x4IcNm8YakremP23TezxeNuFMPgDdohP
         3QZ1DQL5ESZhRkPzQy0LaW5X8QNza7f6Q8MSXnEYT6TPmvS7tTB7M0Sr7nHFs2Q8XCFF
         8rZg==
X-Forwarded-Encrypted: i=1; AFNElJ8xrFuYSRVEZSfWZNLOpICVS3giGTi07oTAXMAwLn3YdIQmkNRIT4Pzc+fl2QyQGluFlconMsjJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxi73IJcx/+MtRqyCd+gPOR0jC4D6VA0iW/vTycNr8eDK+OVJZ
	bwYB0ztWOxaRsqr32RAgvlnAJ7GVsnW8xov+XCYPr08RzATw+guHEYLvdHIHqMkphgQ=
X-Gm-Gg: Acq92OGEP6tT6Q2e3tCNuhoipVNgUecZ5HE9sk3jf22WdxLinMw1+XVppw+vFWgti+4
	l8V4FrSqt3S0fyrYE8Cl8SrsaylzCWEi5BdU1bx/GtRsgcw0Q9wREMwzjJy1iUTJlWcJbOn85Z8
	lcbHgqxEkNLWVNgGCSz4/CP9BGYR4G1xLo76yd+1Mc83maOLmQjVp7E/q9AnsVu97eVTR1YGcp3
	m/ffPRwN2XCoBxN1T/2bqSuhHE5ChR8rfV3QcLSM47OBNEUVgWWNe9klDv4K+4zZhDCTEkDVZWW
	rNw4OMIpST5z8OVy3Xqa899OPyrcHZyx2+qSwuzJ5dQQe301v+5KlFx//X5eahnuQ0aj3i4Ef+q
	miNSxhuRh1f6RzOH3iEtD4EMnIK34Tkq6lGs21y9a2BcwQlOJCWpsFEP8ljnfXH5qmWSMpSn+Pr
	F50HWKetpa2RsQbr9wBGgZgbv6wUwtv1K0
X-Received: by 2002:a05:620a:2909:b0:8f2:c47b:962e with SMTP id af79cd13be357-914b49f5399mr3644650685a.49.1779914898663;
        Wed, 27 May 2026 13:48:18 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87d1a27sm589350185a.28.2026.05.27.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:17 -0700 (PDT)
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
Subject: [PATCH v5 7/9] mm: list_lru: introduce folio_memcg_list_lru_alloc()
Date: Wed, 27 May 2026 16:45:14 -0400
Message-ID: <20260527204757.2544958-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527204757.2544958-1-hannes@cmpxchg.org>
References: <20260527204757.2544958-1-hannes@cmpxchg.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16373-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim]
X-Rspamd-Queue-Id: 6037E5EA31F
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
index 134cb3e5652a..a450fffe1550 100644
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
index 402bb028114d..41a811966063 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -568,17 +568,14 @@ static inline bool memcg_list_lru_allocated(struct mem_cgroup *memcg,
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
@@ -619,6 +616,38 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 
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


