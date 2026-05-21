Return-Path: <cgroups+bounces-16170-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPJjLq0vD2pSHgYAu9opvQ
	(envelope-from <cgroups+bounces-16170-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 18:15:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0D5A90BA
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 18:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54FF032DE034
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746BC36F8E0;
	Thu, 21 May 2026 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="SCOi4vRt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9808236B046
	for <cgroups@vger.kernel.org>; Thu, 21 May 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375834; cv=none; b=sts5SjLcXC+Wn/ao98Ff8SsfhH379+tqyhdv3nVPjCeHG9qv6ud+WVVIYwCQHvemUMSyiJcOkiOW0937Zprj41BrxgstWqZgTQ6nvY+GnywTI0GzW6wZxPCytMldIziepodDVXAlLtq9mHBQ23TU6g2I+yvuH3D//KaA8ZpnjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375834; c=relaxed/simple;
	bh=jPUR/BukKVEfdy9PQWQstfIwiip/659dV2dK1M/R6KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnsC0OUB2A/Z9pjxPjIfy5fbmSrOxQR3M8hStMuenki1BLFJVWmz+aODpToLxWqxcq651SX/IIBUSgG95FVQxunYCOtA7Oc5dtKnpwEob+xuheutcQ8E/XxihLjgSlCVLI6fTfQKBSIKiPNE0ul5p8lOVK1zmhBmS24EuzsCNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=SCOi4vRt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36a3dd2e66eso727187a91.0
        for <cgroups@vger.kernel.org>; Thu, 21 May 2026 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779375832; x=1779980632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USyWRFDNXHImycXHNr3l4mW9eMlhPd90cPYpqyp43EY=;
        b=SCOi4vRt1MEuazsd+OQXt3NN7g8/YZhF7A0NTn6F+gsBRviY3gwxyt2aLC6jnW1Y8S
         MzHRr9mhXenhzJ6q7rhJiNcfty5BUXD4XpdiZ4s0aOj3QLahmHv4u02k5+N2m45IE3U/
         2v6l7SVcnoCPlU3/KMc2R8cCkeWfJzGfh/M5HlaQ6iPOo8prBNMZQBuCsjJYWhGeR3ui
         fZvqi+8AjFf1ICSsRUo2CX9Yo/FXoMVbk8XOlXAKaJ/Ax9LV91r1M/2ZaECCXh1ali8g
         Y/luLOmDmvZdSlIfuB4IFjIFOGkj/H3PzbYD/k/EVwRZ6tP/KX+anfpfPEJXeGS8cwk9
         XfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779375832; x=1779980632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=USyWRFDNXHImycXHNr3l4mW9eMlhPd90cPYpqyp43EY=;
        b=N36rqhHDt8Yi9RaC2nF9kSNWAH/J1DDDftLvp/JWO9SQSpRQflG0hvihOOPbEWJQJq
         xwBbEzonb+MwoKGIzOJGUW/2tSqBX5GoIugax7+I2eDzfyNzC0B8nhSTfw2RCUFfw0l4
         9/hHoi54kLlJFQWc2V6IM1J7d+KNA2rEliXPXoQouFQ4Px0H40gFcBQkQVM8tRzxJqd9
         P9Y+jA8JueFyj0Vf3Q0ajrCIzpYRG4C4ffk4XntVkdVJPrE9XUZCL1Noziq959RSue90
         ViXAOr0/lh9y+LfNrNaABpojpHF6I7G2UHpR2v3YF+MEy1LxG5xzv6FyK5FzEr/EQnaz
         VN4w==
X-Forwarded-Encrypted: i=1; AFNElJ+gKOmyal8RFTy7/JQ2F/VmDdw/4UYQu2JQPbdjPE2WnXNI12zXpYzKJEfPY0KSIjnPILwGfbLk@vger.kernel.org
X-Gm-Message-State: AOJu0YwyTr37QYVaihZD5jCX4e4GvP4HrrR3y6TOu0HadZjfC2ntlv1g
	a4djBpEprZ1Y567Cz3+6YQXKovHF0dNLKqGC9WvfdWhjYIrXV4X3gVYtVh+6/9hVDRc=
X-Gm-Gg: Acq92OH2oM8gIrXlTb3+fXFFmJFfV/jhakSnepFOVqOokFzLDA+tZBrAzQ0vlATSGN3
	Xps4rfq24Ym39fxR83X1CnVHtjvy7KB5vbDSX2nLUUfskGnjF8KoeFV83BSCmSoaJAc9MWVMLf9
	Tuz32rfMIQCqX6njhS79WLTISIRWMl6fkgbLhkQCO4stCImQKlnIl4oLpSXEDY9YxpFco9cWTLH
	vtjj7RocC4O7tOsMku33RHabiupVU+Ngac/B5AboiqHF4BVcGSt7GnRAWu4Aq4z/G2VwiaadZEV
	EJj7sqmXPFXau+jDF6qIy1DUq7K3AYIb0mg/+JbmRzHPsz/XsiEzX52rDJfz4ezX8mP2gVvZF14
	1ftSHOQH776B9TnG7TEsOmS9R7/JLK0T3IGEYEXRolBQIDm29NjLftAtaXxKYsSlgbo97j0bgeg
	9cCuyeKXi1lkKjUeMyIixs9w==
X-Received: by 2002:a17:90b:548b:b0:369:996d:282c with SMTP id 98e67ed59e1d1-36a4518224amr3266558a91.9.1779375831567;
        Thu, 21 May 2026 08:03:51 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abb9935bsm114647585a.31.2026.05.21.08.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:03:50 -0700 (PDT)
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
Subject: [PATCH v4 5/8] mm: list_lru: introduce caller locking for additions and deletions
Date: Thu, 21 May 2026 11:02:11 -0400
Message-ID: <20260521150330.1955924-6-hannes@cmpxchg.org>
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
	TAGGED_FROM(0.00)[bounces-16170-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim,linux.dev:email]
X-Rspamd-Queue-Id: AEB0D5A90BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Locking is currently internal to the list_lru API. However, a caller
might want to keep auxiliary state synchronized with the LRU state.

For example, the THP shrinker uses the lock of its custom LRU to keep
PG_partially_mapped and vmstats consistent.

To allow the THP shrinker to switch to list_lru, provide normal and
irqsafe locking primitives as well as caller-locked variants of the
addition and deletion functions.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/list_lru.h |  41 ++++++++++++
 mm/list_lru.c            | 131 ++++++++++++++++++++++++++++++---------
 2 files changed, 141 insertions(+), 31 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index fe739d35a864..c79ed378311f 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -83,6 +83,44 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			 gfp_t gfp);
 void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
+/**
+ * list_lru_lock: lock the sublist for the given node and memcg
+ * @lru: the lru pointer
+ * @nid: the node id of the sublist to lock.
+ * @memcg: the cgroup of the sublist to lock.
+ *
+ * Returns the locked list_lru_one sublist. The caller must call
+ * list_lru_unlock() when done.
+ *
+ * You must ensure that the memcg is not freed during this call (e.g., with
+ * rcu or by taking a css refcnt).
+ *
+ * Return: the locked list_lru_one, or NULL on failure
+ */
+struct list_lru_one *list_lru_lock(struct list_lru *lru, int nid,
+		struct mem_cgroup *memcg);
+
+/**
+ * list_lru_unlock: unlock a sublist locked by list_lru_lock()
+ * @l: the list_lru_one to unlock
+ */
+void list_lru_unlock(struct list_lru_one *l);
+
+struct list_lru_one *list_lru_lock_irq(struct list_lru *lru, int nid,
+		struct mem_cgroup *memcg);
+void list_lru_unlock_irq(struct list_lru_one *l);
+
+struct list_lru_one *list_lru_lock_irqsave(struct list_lru *lru, int nid,
+		struct mem_cgroup *memcg, unsigned long *irq_flags);
+void list_lru_unlock_irqrestore(struct list_lru_one *l,
+		unsigned long *irq_flags);
+
+/* Caller-locked variants, see list_lru_add() etc for documentation */
+bool __list_lru_add(struct list_lru *lru, struct list_lru_one *l,
+		struct list_head *item, int nid, struct mem_cgroup *memcg);
+bool __list_lru_del(struct list_lru *lru, struct list_lru_one *l,
+		struct list_head *item, int nid);
+
 /**
  * list_lru_add: add an element to the lru list's tail
  * @lru: the lru pointer
@@ -115,6 +153,9 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg);
 
+bool list_lru_add_irq(struct list_lru *lru, struct list_head *item, int nid,
+		      struct mem_cgroup *memcg);
+
 /**
  * list_lru_add_obj: add an element to the lru list's tail
  * @lru: the lru pointer
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 65962dbf6dda..df58226eea8c 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -15,17 +15,23 @@
 #include "slab.h"
 #include "internal.h"
 
-static inline void lock_list_lru(struct list_lru_one *l, bool irq)
+static inline void lock_list_lru(struct list_lru_one *l, bool irq,
+				 unsigned long *irq_flags)
 {
-	if (irq)
+	if (irq_flags)
+		spin_lock_irqsave(&l->lock, *irq_flags);
+	else if (irq)
 		spin_lock_irq(&l->lock);
 	else
 		spin_lock(&l->lock);
 }
 
-static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off)
+static inline void unlock_list_lru(struct list_lru_one *l, bool irq_off,
+				   unsigned long *irq_flags)
 {
-	if (irq_off)
+	if (irq_flags)
+		spin_unlock_irqrestore(&l->lock, *irq_flags);
+	else if (irq_off)
 		spin_unlock_irq(&l->lock);
 	else
 		spin_unlock(&l->lock);
@@ -78,7 +84,7 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 
 static inline struct list_lru_one *
 lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
-		       bool irq, bool skip_empty)
+		       bool irq, unsigned long *irq_flags, bool skip_empty)
 {
 	struct list_lru_one *l;
 
@@ -86,12 +92,12 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 again:
 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 	if (likely(l)) {
-		lock_list_lru(l, irq);
+		lock_list_lru(l, irq, irq_flags);
 		if (likely(READ_ONCE(l->nr_items) != LONG_MIN)) {
 			rcu_read_unlock();
 			return l;
 		}
-		unlock_list_lru(l, irq);
+		unlock_list_lru(l, irq, irq_flags);
 	}
 	/*
 	 * Caller may simply bail out if raced with reparenting or
@@ -132,38 +138,106 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 
 static inline struct list_lru_one *
 lock_list_lru_of_memcg(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
-		       bool irq, bool skip_empty)
+		       bool irq, unsigned long *irq_flags, bool skip_empty)
 {
 	struct list_lru_one *l = &lru->node[nid].lru;
 
-	lock_list_lru(l, irq);
+	lock_list_lru(l, irq, irq_flags);
 
 	return l;
 }
 #endif /* CONFIG_MEMCG */
 
-/* The caller must ensure the memcg lifetime. */
-bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
-		  struct mem_cgroup *memcg)
+struct list_lru_one *list_lru_lock(struct list_lru *lru, int nid,
+				   struct mem_cgroup *memcg)
 {
-	struct list_lru_node *nlru = &lru->node[nid];
-	struct list_lru_one *l;
+	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/false,
+				      /*irq_flags=*/NULL, /*skip_empty=*/false);
+}
+
+void list_lru_unlock(struct list_lru_one *l)
+{
+	unlock_list_lru(l, /*irq_off=*/false, /*irq_flags=*/NULL);
+}
+
+struct list_lru_one *list_lru_lock_irq(struct list_lru *lru, int nid,
+				       struct mem_cgroup *memcg)
+{
+	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/true,
+				      /*irq_flags=*/NULL, /*skip_empty=*/false);
+}
+
+void list_lru_unlock_irq(struct list_lru_one *l)
+{
+	unlock_list_lru(l, /*irq_off=*/true, /*irq_flags=*/NULL);
+}
 
-	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
+struct list_lru_one *list_lru_lock_irqsave(struct list_lru *lru, int nid,
+					   struct mem_cgroup *memcg,
+					   unsigned long *flags)
+{
+	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/true,
+				      /*irq_flags=*/flags, /*skip_empty=*/false);
+}
+
+void list_lru_unlock_irqrestore(struct list_lru_one *l, unsigned long *flags)
+{
+	unlock_list_lru(l, /*irq_off=*/true, /*irq_flags=*/flags);
+}
+
+bool __list_lru_add(struct list_lru *lru, struct list_lru_one *l,
+		    struct list_head *item, int nid,
+		    struct mem_cgroup *memcg)
+{
 	if (list_empty(item)) {
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
 			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
-		unlock_list_lru(l, false);
-		atomic_long_inc(&nlru->nr_items);
+		atomic_long_inc(&lru->node[nid].nr_items);
 		return true;
 	}
-	unlock_list_lru(l, false);
 	return false;
 }
 EXPORT_SYMBOL_GPL(list_lru_add);
 
+bool __list_lru_del(struct list_lru *lru, struct list_lru_one *l,
+		    struct list_head *item, int nid)
+{
+	if (!list_empty(item)) {
+		list_del_init(item);
+		l->nr_items--;
+		atomic_long_dec(&lru->node[nid].nr_items);
+		return true;
+	}
+	return false;
+}
+
+/* The caller must ensure the memcg lifetime. */
+bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
+		  struct mem_cgroup *memcg)
+{
+	struct list_lru_one *l;
+	bool ret;
+
+	l = list_lru_lock(lru, nid, memcg);
+	ret = __list_lru_add(lru, l, item, nid, memcg);
+	list_lru_unlock(l);
+	return ret;
+}
+
+bool list_lru_add_irq(struct list_lru *lru, struct list_head *item,
+		      int nid, struct mem_cgroup *memcg)
+{
+	struct list_lru_one *l;
+	bool ret;
+
+	l = list_lru_lock_irq(lru, nid, memcg);
+	ret = __list_lru_add(lru, l, item, nid, memcg);
+	list_lru_unlock_irq(l);
+	return ret;
+}
+
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 {
 	bool ret;
@@ -185,19 +259,13 @@ EXPORT_SYMBOL_GPL(list_lru_add_obj);
 bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 		  struct mem_cgroup *memcg)
 {
-	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
+	bool ret;
 
-	l = lock_list_lru_of_memcg(lru, nid, memcg, false, false);
-	if (!list_empty(item)) {
-		list_del_init(item);
-		l->nr_items--;
-		unlock_list_lru(l, false);
-		atomic_long_dec(&nlru->nr_items);
-		return true;
-	}
-	unlock_list_lru(l, false);
-	return false;
+	l = list_lru_lock(lru, nid, memcg);
+	ret = __list_lru_del(lru, l, item, nid);
+	list_lru_unlock(l);
+	return ret;
 }
 
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
@@ -270,7 +338,8 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long isolated = 0;
 
 restart:
-	l = lock_list_lru_of_memcg(lru, nid, memcg, irq_off, true);
+	l = lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/irq_off,
+				   /*irq_flags=*/NULL, /*skip_empty=*/true);
 	if (!l)
 		return isolated;
 	list_for_each_safe(item, n, &l->list) {
@@ -311,7 +380,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 			BUG();
 		}
 	}
-	unlock_list_lru(l, irq_off);
+	unlock_list_lru(l, irq_off, NULL);
 out:
 	return isolated;
 }
-- 
2.54.0


