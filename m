Return-Path: <cgroups+bounces-16169-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JwKEHolD2paGgYAu9opvQ
	(envelope-from <cgroups+bounces-16169-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:32:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 958925A8660
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 17:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA0C432E9A6D
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B5636A360;
	Thu, 21 May 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="HvW18WP2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFC368D68
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375832; cv=none; b=Up2tmalcqpnw35j7Vil86JNtzjw6qJuTm0a3xvEeQvvKwNpIbKDMMupIYHyjqbSQg8ma14qtVnUAosdKNt35GfoJUBT2ozoRihqVP1wipfNx4w92y+zr3ABs7ayCaSsFl3RLsT9mQEGXSJHlOAPW4RRMHxxYDxeRKG8r6Em9mok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375832; c=relaxed/simple;
	bh=j8U8aUC7GF7hZAPSnE7T1xSkXrx5X2zPqG7sVz0ma50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFrLQdUNLVeSdwdoUr3/M8RX7/i2zMWqC8SgyXBFq1XxbRkIwbza8Qry94JZTP1pH/LNWuWIElvHbSJpYLCNmF2ehk4SDuxd5aq5WJzVb5fi1uCi8XsDXdXr8V+7I1diLciOEZA0K7AlmW/K7OahBhjm/E+nZd0i9orBwjmdtBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=HvW18WP2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so112646426d6.2
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 08:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779375830; x=1779980630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BH9Ib0oi5E8fnc2UPrjbKjmGT1EOdGnzHGNmtCTvMlI=;
        b=HvW18WP22E+fJyxY94AuFRyyP2CZZf2oCfjPP2btq8n0Gux83gMzljmOzLBGa7kZU5
         iDh+SVMvN0EYNwYLHC2Aa2JSFYJo9qrV1zHzyiusB3+d4BLLb6BoRpQv2ASOz6K/yZwY
         kK18JARRo98uIJmQxScM6obmznrTT4uhrYE6hoX5Q5QdTtWd++D2+RVFkXFIh1xdPZCo
         coKBWy9K6N7YE6jjdkwFwsZwXNMJj0hb83hM1uGjjXpHbR6+2qjH+Kap93/OwhSmvoqC
         wx54awSNzNqAf6vM1cbBPG+/ekdC+rYPnyvX/ylazQ3r3YKMakCBJGZp/r6YmlamqFKc
         g36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375830; x=1779980630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BH9Ib0oi5E8fnc2UPrjbKjmGT1EOdGnzHGNmtCTvMlI=;
        b=qkTS6AVF9cDIv2Bk56cO0N1Y/YDrQPvSpisB2hkmYKyBMNBjKR3Jf7Ie4oVy08Uvwm
         LYeZ8iPtymc43OLe+CrHdr0tmsxwpCAEBjRN45K6nK/viYmp9yfa7RpX6X2RPF244oiy
         t4xujo1NpJXMYF70yA7KEw79kJqpbOWzaFc5Fk6nz5UoPGFOMxCljJkbFGoOi/1qQhE4
         R5ag+gVdpFE04nlPJoscuPw9VUNLq26Xo2NZ32FhES8AmWksSwgQtmM0ZegPZUKd/0bB
         25XdUfHCQQWtnky/PgQZ5P2Gc3APOEGgJyQamKF04qmvsH1YMRftUp9ReSdeIpufqQ3B
         BuBw==
X-Forwarded-Encrypted: i=1; AFNElJ/nOleWUTRP+XsGPCWoZ/pbtAgW+NGUJPOe8YMhXpUVlYkMWknal9WADI0qA8jylXMX6HUJ9z2F@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv3fRxYRY2Rjx/muXE+VogFSo0N52httGeqycL1FZij24U+CiB
	aIUqFe8KanhOzOb/DWf1Gt8oHkxDjn2l4e83F+JZcHYgV6OabWG2DBhqEoooZRExp5c=
X-Gm-Gg: Acq92OGjQAp3K2c9GRQUp8UwQ8xETBrK7ZfgBa6YzSSlCLBpj+paoRP+1WdfFmGDItN
	4bcBFITeNXdg85ii1lQuxHYK6FecE0o7sUNJGj2Z3geaQDTSSxFSWnZ+HPsgdOIKqL+g03hK9+k
	fIdQ22X6wrZBIE9/lNOdYH5laQzWGhsWEdXOEORmgm5hhGSzggd9PyDV/woGXO3/+JWq4UFqdiW
	ycyBSAxUHDFBDgTZFXeFn2qYqEFeccNoJsifjwlTqg4EPbugBf+R6B0JYpDNIREHR+C57YR0H1l
	G9cd3KU2KdIql/mAjkHMgwIWjw5GvaIgMy+1ywBSFlON9nCYLx9j49oc26McdYZFygLA0BNKDD+
	MnvDZYGgcz9Jv6h09TaMYKgbhT6A5v9P/A3aW5EQktBa5MeG8NP+9qbugAnevgKTqhNSpDhVxcB
	Trt7pLihad5t2i1QlfyG1ZApQywQ1Nf28W
X-Received: by 2002:a05:6214:3a8a:b0:8bd:6baa:6a0c with SMTP id 6a1803df08f44-8cc6e31e7ffmr51218506d6.11.1779375829379;
        Thu, 21 May 2026 08:03:49 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768b7032sm7149496d6.4.2026.05.21.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:03:48 -0700 (PDT)
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
Subject: [PATCH v4 4/8] mm: list_lru: deduplicate lock_list_lru()
Date: Thu, 21 May 2026 11:02:10 -0400
Message-ID: <20260521150330.1955924-5-hannes@cmpxchg.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-16169-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 958925A8660
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The MEMCG and !MEMCG paths have the same pattern. Share the code.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/list_lru.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 9da6fce19832..65962dbf6dda 100644
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
 lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 		       bool irq, bool skip_empty)
@@ -136,10 +136,7 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
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


