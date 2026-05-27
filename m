Return-Path: <cgroups+bounces-16372-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBlLNLhYF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16372-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A41F5EA311
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E99883090011
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286983B7769;
	Wed, 27 May 2026 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="LRcSNc2z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2F3C1F37
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914901; cv=none; b=QFuxA0RD2zXsrLohhUn1BBXBNoJAju9W4FOdy9UkCa5z/Tfv35ME/ZMN0h+oi9pV5y1hkZZywidQfAyjAoArJf8ayjP+IGp/bxDvAzQ7TENyRnHigrbRHNpKTAjKZqXnxyUQXaE3A9eiQg4zWxd/OAppLGgjEGbFSTZ+WkhVqh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914901; c=relaxed/simple;
	bh=YRW4qnSpMUAMG+rquHRhuw/mFIuPIMQywrOsR9YkwJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYYu4CBSzNhIZ23BOj5VvD0exNm47RM4YNWw4abH7t+ePtWhAmGwd9N8MJ3ykUDJIyQme72WDbO4AjD3MH6615jbhFVHVuxZmgo12s6qsTO9TirB+hm17iqlMCAQ1MHvn4sSF3Hslk+X61U5CeaWIYUvPosoE+H5PDH0ZR1+wvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=LRcSNc2z; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50e5c7eb565so128295681cf.3
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914895; x=1780519695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlbqhKiDqWS+kHnDvkCX36mrjE33rRvlYf46I/uZLtE=;
        b=LRcSNc2zN/RbyK+BTAF7DboHL7NVV+Gg8fzmn8QP/ENFZawV4Ccm8bNEeuW3VzIxj2
         4JPn7ohKScy4ce9bO5mveyRaf8Gg0NGiaZTjDw6rNc6g87Dh6uIunaqxKgQN6WB5jWV2
         LORJhRstTTPtBBL16zLkjwPn3jyijOJ824nHnXNkQ3+6iqCxRUSfZe1Hod/vmjF8soQY
         sKz5Tv9O1uTchYJxrlpKmXrI8BH214XbSRREzbDdp710wmEF+8dU5/K2O9knbynzvdeL
         gr4R9FDPLVEK4it7WCFOa3tHjQ4CoBS4DJ17/DG+b65ur+2n/8LOrcs55k6fkWMDCIR/
         48CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914895; x=1780519695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dlbqhKiDqWS+kHnDvkCX36mrjE33rRvlYf46I/uZLtE=;
        b=P9aOajMrr6OPgSC+jwEVrfeOd3V2Iv9GEI+kA0P/LrChc7N7SGV+jKmCXDptEKpKgg
         ttXfQ94+qSZ6ZT/haAk8NOmkcS09p9ou7Ad8QkHirdNZm27c1s8QP6BlXp5KueX3UAkq
         EcMZSYYT/q8oIXWak7PevtN3OwQ2Dlmdoa6VqPDYNl5ogHSuz7nUKxmaqVlBv8WC0zFN
         HhuncH/uHVMmE9XqrPTm391R4hJTJulTrqW3DCHrB8nHeCZGRBA/8otfoDIcvWg7ecQ1
         0Ww97movvoMGP/u2pPg8ulSadbwSEvJncVLkstqw4h6X5JukiM4bfLS2MEgx9ADPHyoa
         c2NA==
X-Forwarded-Encrypted: i=1; AFNElJ+JPF0L0pb5nE8QnC2O/Oxqc7fVWahhoa/uu/+MMRWi5sQovpMDi2xpcycId6La3Oy9O63JsWnj@vger.kernel.org
X-Gm-Message-State: AOJu0YxNhT67HglK6sK3KPCqGSlqJKH/HytZp4B3G1NNSb40GMFxiQfB
	5AZdlKjRorKcpTmSHDW7HdU2w39m8rpITgdFChajb0rA3FlkEypAbbibZctfAQNRlsA=
X-Gm-Gg: Acq92OHwxN6JlVcw4MAWDo7SmRjPddbvpnB5x4/4+EQ1058ndwJ/X86f0iIB43kSySn
	J3fbCex1z8GHKGeHyu6yLqqB9F2gjAeuyW4g+uxx2dERI11KE0ylOuGj61HvmonxpjwBOlssIEo
	nB5fu/DOZ/oKncOxBqysYAEiXh55SU3G8GO90RnLTF21poCPB2QS3o8wqH3qvlFdaTXMo9u9Tdp
	b8MozcIpj2BR7V3mHiITwOYAhAEIMq18j67wI28frv77ikJ9ajGLoGz7X+HHkWE7pe0Rup/lXWP
	o+CLwwwvEChrs6+53dtsIVPj/9ntLYRJQTgdRbzKMsG69I6kkFUhWBR0aXRv79t8FE1C1hdES0t
	AZ5RTSJjDhniZBD03bKQhlkgeaAQzWhUGU1Q9wtUM4SUci2nCTd4mATF4qB730IIGsWDiK6cWsi
	sVZBz7Bjt0DkOkXXzcGwyYmg2Voy0dz6GD
X-Received: by 2002:a05:622a:134d:b0:50f:c5d3:a191 with SMTP id d75a77b69052e-516d429f541mr332100001cf.13.1779914895147;
        Wed, 27 May 2026 13:48:15 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706af4fd2sm52466431cf.25.2026.05.27.13.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:14 -0700 (PDT)
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
Subject: [PATCH v5 5/9] mm: list_lru: deduplicate lock_list_lru()
Date: Wed, 27 May 2026 16:45:12 -0400
Message-ID: <20260527204757.2544958-6-hannes@cmpxchg.org>
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
	TAGGED_FROM(0.00)[bounces-16372-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim,linux.dev:email,infradead.org:email]
X-Rspamd-Queue-Id: 4A41F5EA311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MEMCG and !MEMCG paths have the same pattern. Share the code.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
---
 mm/list_lru.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 7d0523e44010..fdb3fe2ea64f 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -15,6 +15,14 @@
 #include "slab.h"
 #include "internal.h"
 
+static inline void lock_list_lru(struct list_lru_one *l, bool irq)
+{
+	if (irq)
+		spin_lock_irq(&l->lock);
+	else
+		spin_lock(&l->lock);
+}
+
 static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
 {
 	if (irq_off)
@@ -68,14 +76,6 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 	return &lru->node[nid].lru;
 }
 
-static inline void lock_list_lru(struct list_lru_one *l, bool irq)
-{
-	if (irq)
-		spin_lock_irq(&l->lock);
-	else
-		spin_lock(&l->lock);
-}
-
 static inline struct list_lru_one *
 lock_list_lru_of_memcg(struct list_lru *lru, int nid,
 		       struct mem_cgroup **memcg, bool irq, bool skip_empty)
@@ -136,10 +136,7 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid,
 {
 	struct list_lru_one *l = &lru->node[nid].lru;
 
-	if (irq)
-		spin_lock_irq(&l->lock);
-	else
-		spin_lock(&l->lock);
+	lock_list_lru(l, irq);
 
 	return l;
 }
-- 
2.54.0


