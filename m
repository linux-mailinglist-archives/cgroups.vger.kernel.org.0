Return-Path: <cgroups+bounces-16370-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EZZIbxYF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16370-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:49:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E08FE5EA318
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB6C6308ED43
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBC93B7B8B;
	Wed, 27 May 2026 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="uyN+DClH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2953B5F50
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914895; cv=none; b=EzPMRNeCP/Ai2pV3FTtkthsJpa+CCLmhfsiwHrUwX2v4noE2v/ZGCM1rwPA8Rx2CGiU00J6Xe/MrtZTQ9G80B/btDzbQ28Kb3wEnG97qHE2EUioGTtogE4UA3ZfoI3xlqeFp2GY0YhTbktKSBBoSsZMMasMSMYNUswThOruGO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914895; c=relaxed/simple;
	bh=c1f+DX2H5xUC03KS0fGkNUDbCLWT6iyE15zMiC1PVlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqfS4+lCdfyUkpsEXLCVxei7WnYGoeWT2aRfnXjJqkaAlL9PPnoIobuwLYETjP1Rj8i91IyqAQ6CJItTAP9AKF0HKbOBVGWW7/F1sEhiXNj4JOMvP+VmMUUhkPZmxtjv5/j0GTSagOdjU4mLDe1QQx3QdN0WOcPfY8WnJdLiJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=uyN+DClH; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-516d65a15f6so57698381cf.1
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914891; x=1780519691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDvTkX11jVGNHNrahXzBPb3ZfYee1UhmGAXLDAQTujI=;
        b=uyN+DClHYRu0RexPP4ecU+sMVANxESB3BQmZgRdra2FUnddQMP7C4sgRCfOeXK2CsN
         tmQiAOhvaYQK8H4j6m/qpGuIjR5U2QspVNffgC81sS7sIMhTVh6mnQKjmS/76y7xDfeP
         4b0zfr9hxduzyGg/CEWSjH1wvwE62MoML5jR4VbX+i+u8aaggvnPxMHTDsXoHdsovwW4
         iCgGVL5tlrlninPLdzCe0WgL1RZKoOS4PJsmYHyo1GmN8eWhyG0kNSHQ2wPFiu6+pPTd
         bc4mxpzKldSDq2DwYXUhoEdRfVJvjoZw8R4DKaz1P0IDlpDdi/f4QdHtBEWye6eh46L6
         qf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914891; x=1780519691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sDvTkX11jVGNHNrahXzBPb3ZfYee1UhmGAXLDAQTujI=;
        b=EAfHAz6ZbPSZZk55x/qvwlLmMIgixNScxD1LPlhyv89qIZ6VZv6X9jyC3VsYonp2Oc
         OvbWq3wdrWZQTPR0QhBViPIFmPm21ksV+lgLPrg2I6QOEs51iRm/1s0qnyBEp9V8axdJ
         W1CEDlot7iH8VvdkPnfMQgetUHs4NBKxhCRmHbEx8lIEW5m/6/FIBUf6yv06QjyxMqWR
         EvpMfBRHdL3nBsIxx7b+Meh+lQbGP8+3kDFdJt43Q4HC1cQafr/EqpiCoS5aR9QeULAk
         k822acKhovCuIA0VLJPljDGH7XUuClLfT6wOi2m3+jxwPHeEniigbwwIlXfjB83N4leW
         JlzA==
X-Forwarded-Encrypted: i=1; AFNElJ8ddUDgAqfNOLWcvD9U+QwwR1wo1TNUqFUaNJg+Ykqye9NcAU3ejyUl1J/BrHap/jlzIeF8JDPI@vger.kernel.org
X-Gm-Message-State: AOJu0YzH5F5/JIoHJapwxHRUNcbN8T492/H4qg4a9OlZ9wEh0n5xGT1C
	X+J/cbT3uLCQ+MgO2Fw8SaTvjP7nWF8ZnIpN30nIFgBllTVzlk9YN85dRsMC9LA1J98=
X-Gm-Gg: Acq92OGZr1EYIw2oSIOElG8OzTEtsGGcd2KrE890vWPUp9w4i+x5ItpNL3n7wUXwgZ6
	CBtbF65Qu5E03z1xyKr7BfgNflw/BZx0AzcwVtE1a5171ZzdqJcDvg4nb70zCniZH3nO24g4xws
	tPncH4NwmSFJWpPku25nO+1Xue+WMw60pz3FrrBrzUF3un2KzfQkxGt1fPTvX1RCocGC5i3omTS
	v6hVmyXA/ywfab3y1mviW1ASP+oeTlKxs2iUC1cddTPPZKiAbBC+fUf6+/8KTelzMksueEDdzRA
	pH6BDPyPrZ95EYrHpgg283s6nsyR0kGo6JxuxfHDbmlsM2xIDXpZ+gcXu8wq9QQVR/MU6iJkfy8
	mo7uTop5Ti5zCnIIgoFvPQGsOxfRx7IwG9uhlormiR/pX44RQFKVE1/E92KkitNlzlRxNkueygZ
	splNtaQRDmMKYciGNnZZzRgVsIUBf+BXu0
X-Received: by 2002:ac8:7f8f:0:b0:50f:a53b:9d3 with SMTP id d75a77b69052e-516d58a803emr268033681cf.27.1779914891532;
        Wed, 27 May 2026 13:48:11 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706b0bad4sm53558101cf.31.2026.05.27.13.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:10 -0700 (PDT)
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
Subject: [PATCH v5 3/9] mm: list_lru: deduplicate unlock_list_lru()
Date: Wed, 27 May 2026 16:45:10 -0400
Message-ID: <20260527204757.2544958-4-hannes@cmpxchg.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16370-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim,linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email]
X-Rspamd-Queue-Id: E08FE5EA318
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MEMCG and !MEMCG variants are the same. lock_list_lru() has the
same pattern when bailing. Consolidate into a common implementation.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
---
 mm/list_lru.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 77999ed78fa5..5497034e80f3 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -15,6 +15,14 @@
 #include "slab.h"
 #include "internal.h"
 
+static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
+{
+	if (irq_off)
+		spin_unlock_irq(&l->lock);
+	else
+		spin_unlock(&l->lock);
+}
+
 #ifdef CONFIG_MEMCG
 static LIST_HEAD(memcg_list_lrus);
 static DEFINE_MUTEX(list_lrus_mutex);
@@ -67,10 +75,7 @@ static inline bool lock_list_lru(struct list_lru_one *l, bool irq)
 	else
 		spin_lock(&l->lock);
 	if (unlikely(READ_ONCE(l->nr_items) == LONG_MIN)) {
-		if (irq)
-			spin_unlock_irq(&l->lock);
-		else
-			spin_unlock(&l->lock);
+		unlock_list_lru(l, irq);
 		return false;
 	}
 	return true;
@@ -101,14 +106,6 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid,
 	*memcg = parent_mem_cgroup(*memcg);
 	goto again;
 }
-
-static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
-{
-	if (irq_off)
-		spin_unlock_irq(&l->lock);
-	else
-		spin_unlock(&l->lock);
-}
 #else
 static void list_lru_register(struct list_lru *lru)
 {
@@ -147,14 +144,6 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid,
 
 	return l;
 }
-
-static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
-{
-	if (irq_off)
-		spin_unlock_irq(&l->lock);
-	else
-		spin_unlock(&l->lock);
-}
 #endif /* CONFIG_MEMCG */
 
 /* The caller must ensure the memcg lifetime. */
-- 
2.54.0


