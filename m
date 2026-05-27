Return-Path: <cgroups+bounces-16367-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKyGM5FYF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16367-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDCF5EA2C6
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E883044224
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5683A3B637F;
	Wed, 27 May 2026 20:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="QB0CiFIL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82903342173
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914893; cv=none; b=ItCAPpTWu06Hm+IsLrS0nY9HkZFFQdnE8tBgiOr6XOufo2A5MStix6EtB2G9JXsPIyX1nFYB/4tYDnZ0e5Ky4X7i5+z6KElj5B1oEaCSZyXrLxviFN3+HQxLKM3HuiYYGQmpdYQsczwf7DD4Gvo/UXztXMAXY3NikxM7KQC1t2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914893; c=relaxed/simple;
	bh=gquPeyIrgrXq7dLjLlFiTq8DRz00IYvKdULLyzd3nQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NijtHHBegez9g08SfTh58qjzBwiZGj5JS1HEnLwYOc9zvsM41YxVIL+nSxn6fFpNdS9eGU8wAYK50A0MNX0/Qnms8ebB+rHmLwVNOjT46Q4rJvW8tPGgLkr7NCi8iND3alS3Jy9s1YdJt31FOsgeorPkhzF5zv1wtYVOVthew5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=QB0CiFIL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51306c9f2e1so141376291cf.0
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914888; x=1780519688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBXzyPhWkzGmNH/N9A+/kfLtlL9nu+YFCZMUKmgaFzk=;
        b=QB0CiFILJDYJbNEV//W8WxUN7gH4RvSyq3pCkLHgldimXgbNAR7sqZYaSmrg9uIQEl
         oc4zjfpob2K2S3id7/3gaensZcIMiWDlGvZnlvkDy5L7RzkFd5ysUg85xop5oBdNJZyi
         IlzxyKOkqCVWneZs3Dt+5pR+qu8L7hfis6IFx9vCKiMlepAvHmOc1kvpCXJjv0YWa8O1
         TH2jS0ll2jZUNUfCy9rAMktfA+EJDoqtZlSU+ldwZAjrIs/VaPexAuLTFICSbx9EPcBF
         wtmSWAiMP1OxMS+OnmPjkFIIIoRfjnnhhWkhIfBaQSY6IonAXkTIRVwFUBinik9pSvTw
         9fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914888; x=1780519688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBXzyPhWkzGmNH/N9A+/kfLtlL9nu+YFCZMUKmgaFzk=;
        b=fgEnrwO6sXZLsmq5fFTpH5veAbQ4PiZIpAYKBs5aNoK6Eat5wZM3049IvS9f4e863M
         OdLkFwc461As8L+/cPW/HWW3F3gvtkjNcBApvVQ1B+lVLaJLOxx6llJ+qRYah+WS7wRA
         5Twysp9lOr8NGHRxEX2xiQjKZwFZC9XHK80kZiQ1+DIkVBr0O3ZoBRuyYQqDMWKnaBma
         qI6rMVNDqwkBT3I/DBFuDRoJn49bQQz4ZZNk8nzSAtAvJigRrV8jBmUznTO6xMGLCdfd
         PAg1HaBaB9h62g6Z7DreiWRbbGWIGViXzDuv85CLLOtaDhGs3TtT2GFoAca+iYEnYTjl
         8Dlg==
X-Forwarded-Encrypted: i=1; AFNElJ8OrsCCPYjQXF7W5cDsf8P0Y2AO2OYsaibC4Sm5b2VcXIbkjS18Im10qy205gckyAgQ+9ccnrfe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JdZTxPo2MSJM1hUnqJQ2CpCs8BKl9NO7YY2QM2W2Geo3WI6t
	dOr/1lWJ0AWpnHWktop8uSmgSAHQ7fTwap28P0VKTrrZ26ikbBGowmEvpqKWpoi680s=
X-Gm-Gg: Acq92OEMCxRqAhYTjuJgICQZgTDCrGf1UNrga01xvUJSP+Gk3b5ZkC0jpnD7PPH65oU
	cgNj0XT8ZaqDVam02WhSAEQd3oELF6aDnnqZ9j6dCCpPwRNtGw+kxHIuLoIV0Tkw5txQy7Udy3G
	T+/hq+FyDsGqeAcCzHC1Tey/z0Hz4gFQuMtcoKwysbtCLRkKaSUGy5cfKTwYpdIrd7S4cOhxC+N
	nORvyk9uhHhgCqlE7BddxZCkZkq7C98TY2r3Q35R9dncwgrc2YZ/ewgt/Q1et1k4FtyHzmY+o0j
	jg3mY4RMo197LRtXl2MmOjZL6Pdo8luL9167bUD7pRQ5miJ3crHf1xEuyk3+1BcwgqRZfkVHuK4
	jGx882dfZyiydEPWw60msWLwTbqXp2cNHvsvHIEU0kSVLqQ+JuHadCY8HfD9k8YxKkkAkMEhe/i
	vcR1RTKiF9sZJMnCIAVB9rw8Vvcx/koPym
X-Received: by 2002:a05:622a:244b:b0:50d:e471:2d1e with SMTP id d75a77b69052e-516d43cb2dbmr336768581cf.35.1779914887963;
        Wed, 27 May 2026 13:48:07 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069f2d2fsm59376831cf.3.2026.05.27.13.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:07 -0700 (PDT)
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
Subject: [PATCH v5 1/9] mm: list_lru: fix set_shrinker_bit() call during race with cgroup deletion
Date: Wed, 27 May 2026 16:45:08 -0400
Message-ID: <20260527204757.2544958-2-hannes@cmpxchg.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16367-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 2EDCF5EA2C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When list_lru_add() races with cgroup deletion, the shrinker bit is set
on the wrong group and lost. This can cause a shrinker run to miss the
cgroup that actually has the object.

When the passed in memcg is dead, the function finds the first non-dead
parent from the passed in memcg and adds the object there; but the
shrinker bit is set on the memcg that was passed in.

This bug is as old as the shrinker bitmap itself.

Fix it by returning the "effective" memcg from the locking function, and
have the caller use that.

Fixes: fae91d6d8be5 ("mm/list_lru.c: set bit in memcg shrinker bitmap on first list_lru item appearance")
Reported-by: Usama Arif <usama.arif@linux.dev>
Reported-by: Sashiko
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/list_lru.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index dd29bcf8eb5f..45d1b97737ea 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -77,14 +77,14 @@ static inline bool lock_list_lru(struct list_lru_one *l, bool irq)
 }
 
 static inline struct list_lru_one *
-lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
-		       bool irq, bool skip_empty)
+lock_list_lru_of_memcg(struct list_lru *lru, int nid,
+		       struct mem_cgroup **memcg, bool irq, bool skip_empty)
 {
 	struct list_lru_one *l;
 
 	rcu_read_lock();
 again:
-	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
+	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(*memcg));
 	if (likely(l) && lock_list_lru(l, irq)) {
 		rcu_read_unlock();
 		return l;
@@ -97,8 +97,8 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 		rcu_read_unlock();
 		return NULL;
 	}
-	VM_WARN_ON(!css_is_dying(&memcg->css));
-	memcg = parent_mem_cgroup(memcg);
+	VM_WARN_ON(!css_is_dying(&(*memcg)->css));
+	*memcg = parent_mem_cgroup(*memcg);
 	goto again;
 }
 
@@ -135,8 +135,8 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 }
 
 static inline struct list_lru_one *
-lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
-		       bool irq, bool skip_empty)
+lock_list_lru_of_memcg(struct list_lru *lru, int nid,
+		       struct mem_cgroup **memcg, bool irq, bool skip_empty)
 {
 	struct list_lru_one *l = &lru->node[nid].lru;
 
@@ -164,12 +164,16 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
 
-	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
+	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
 	if (!l)
 		return false;
 	if (list_empty(item)) {
 		list_add_tail(item, &l->list);
-		/* Set shrinker bit if the first element was added */
+		/*
+		 * Set shrinker bit on the memcg that owns the locked
+		 * sublist - lock_list_lru_of_memcg() may have walked up
+		 * past a dying memcg, and the bit must be set there.
+		 */
 		if (!l->nr_items++)
 			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
 		unlock_list_lru(l, false);
@@ -204,7 +208,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 {
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
-	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
+	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
 	if (!l)
 		return false;
 	if (!list_empty(item)) {
@@ -288,7 +292,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long isolated = 0;
 
 restart:
-	l = lock_list_lru_of_memcg(lru, nid, memcg, irq_off, true);
+	l = lock_list_lru_of_memcg(lru, nid, &memcg, irq_off, true);
 	if (!l)
 		return isolated;
 	list_for_each_safe(item, n, &l->list) {
-- 
2.54.0


