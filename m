Return-Path: <cgroups+bounces-16374-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FqgJZVZF2oPBQgAu9opvQ
	(envelope-from <cgroups+bounces-16374-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:52:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E70AF5EA389
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 22:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE8B3144D1B
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DD736F8E9;
	Wed, 27 May 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="kDYMnlvx"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9E3B7753
	for <cgroups@vger.kernel.org>; Wed, 27 May 2026 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914906; cv=none; b=QqR+HMiUYvj8ifbK3TI4GhEZDKQX6H5vbc+qgASs3u5OYMP7K6oGOYwDUpKt3ZWH+TeY1N/XFJbyvOW0QSW5fCV0apCAQpKe3txCUcOuzY8p5Ay+rV/O92R8m652ITjN6rVKtJEi6wrxgRC1CDYre8PnndUrmrF4vftWGBUQS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914906; c=relaxed/simple;
	bh=d7WDZsdV2/aQKgp+6i2HTqrXT82J3vqCl3Frd8mspGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jho+QeZ60KqVSFf4HOP6WvhxHy9Nw5KOC8Bo7WZzRiTJdeGvnEGku02Y5CvNLtCyoL0NRdlbhJVrrQeOEXnCezJhBIb+3fP1+1FVcpHqHKZ/ev4adsqNLf8/qITPguT0ROSThlkPUpdXRjsMoLYB2BiqpyLVrit9ZaXRJn53Uw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=kDYMnlvx; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-516cc5471bdso89112271cf.2
        for <cgroups@vger.kernel.org>; Wed, 27 May 2026 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1779914897; x=1780519697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AOQtP7Xnnp/Xq7xApSFU4g8ZA9bsT8U0JJPgTL+uXI=;
        b=kDYMnlvxmW29C1xP3Cp/45n2MazTQCmeV6qu88TowIQzsyH6SA5QfHIeo98yyA0sAQ
         tEgVlVQAbZHXjI6cDShBxK6ZKE8vyyKNSQVHXEung51Hr9UAcdu6ZZWsMqxYpVo8wAhs
         CgcQK1KwRLVhFYU+fRbavn/Vra5HsWvDHIvBw0VY1m9iY+CYEsmkmI2ZMZTCZCwAtUWE
         6bP/Id4xkX8ln//AR0uLdqE4rgIB3/cQehxX1QSqDLQalzp8o4ufKdKfFsEjI9i3eZdX
         KrdRADTqEvzn9YSgfy+N830whmjKrHrPuknx4ldGTS9RK+A45GTblD/i/BWalgmDRrHj
         uDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779914897; x=1780519697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3AOQtP7Xnnp/Xq7xApSFU4g8ZA9bsT8U0JJPgTL+uXI=;
        b=GVUhPrnlwLMQNx4g0IwgWEPiTse2FZuEVw3HknkdjLoGGEErwNf2onRBjlX6FEXJV6
         l4qnKl2uta8q8W+WVhC0XQSRMeuD78JTJbgF0ipVZf32x8CPKJQXVWHwjxeUGhbvbCV0
         nZ2HfQDZFCfz07HHpKG7rb6PMMEZQ09tIrhesaUD9xabvpRZaIgmu0dYCCi+v7epoP4u
         9TsAMXUPB/N/vKX2Ml6Y/ucJOv6xWlY2PEhuq279el2HU/9HceHusOIO0O3h85G5xgOv
         cqgldyeFAHoZe9ebWNAz2bSUBzxElju5cfl5WmqkaDuYZYILYdc82L+6HWvRYhFFQ0Ax
         1Btw==
X-Forwarded-Encrypted: i=1; AFNElJ+BoD1+GcVmUPRKX+uMI0NJFgljvPLMxchwkMohUogYnvt5nCo9z3lNozXYAhbswmNnBsqwpXST@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkoC2cjud7AxPyCGE3iRvnT9nRJ4F9FWk9mii+yca0bcfzVtl
	u+93bkuBqqPXs9PrH2Xvp2isKfap4mtqadnT6a3LMeabS+mzn8FgvQBeZaYptNsbypg=
X-Gm-Gg: Acq92OHr028oYEzg8py9loyAsF32mhVkonFnhcHPQNqxDBNtlZjwXOnJvLU7z163NnL
	8UHprfq0TpSIBwxCMbckqt7yittINvZE7Pw0/vC0iNkgGrhmOBATxqO7aKtq6+tx1f20snrXCuB
	fqGMtO3aAX+wczFkVorvXTAgYFeMvt3xC4zVOCEZf7isVwrBmwAC269yRZpNAeuZeNa97xsVDmd
	SNX7imgAdwPct7kmYj3kj2MCdn+s1eGESW0maRdcnj0ixptB/PkU5Sax0hl2/iyhUL8eYpJHObb
	uBk+r/ERNCZ4eAx0L9Wy5hBRCOhrE4OBSneE5Atb1+r+wKqRvo4AzWWHoR4nj/gBFZfSfxdaAGc
	2lAk0JzMYW5hFBEXAvRNA8qVfYqRwDx33y/1d46qd0xXGhB217CKjH0K2zMfddlZXA9IliMQMCe
	dDPNgWeCUdgh0zKfhEwY3u2in3Jqm9NqvLnSINFBhDSr8=
X-Received: by 2002:a05:622a:2d5:b0:516:4fc0:27ac with SMTP id d75a77b69052e-516d43e4561mr353992391cf.50.1779914896842;
        Wed, 27 May 2026 13:48:16 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706a28ddcsm58877121cf.13.2026.05.27.13.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:48:15 -0700 (PDT)
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
Subject: [PATCH v5 6/9] mm: list_lru: introduce caller locking for additions and deletions
Date: Wed, 27 May 2026 16:45:13 -0400
Message-ID: <20260527204757.2544958-7-hannes@cmpxchg.org>
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
	TAGGED_FROM(0.00)[bounces-16374-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux.dev:email,cmpxchg.org:email,cmpxchg.org:mid,cmpxchg.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E70AF5EA389
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
Reviewed-by: Liam R. Howlett (Oracle) <liam@infradead.org>
---
 include/linux/list_lru.h |  43 +++++++++++++
 mm/list_lru.c            | 133 ++++++++++++++++++++++++++++++---------
 2 files changed, 145 insertions(+), 31 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index fe739d35a864..134cb3e5652a 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -83,6 +83,46 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			 gfp_t gfp);
 void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
+/**
+ * list_lru_lock: lock the sublist for the given node and memcg
+ * @lru: the lru pointer
+ * @nid: the node id of the sublist to lock.
+ * @memcg: pointer to the cgroup of the sublist to lock. On return,
+ *         updated to the cgroup whose sublist was actually locked,
+ *         which may be an ancestor if the original memcg was dying.
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
+		struct mem_cgroup **memcg);
+
+/**
+ * list_lru_unlock: unlock a sublist locked by list_lru_lock()
+ * @l: the list_lru_one to unlock
+ */
+void list_lru_unlock(struct list_lru_one *l);
+
+struct list_lru_one *list_lru_lock_irq(struct list_lru *lru, int nid,
+		struct mem_cgroup **memcg);
+void list_lru_unlock_irq(struct list_lru_one *l);
+
+struct list_lru_one *list_lru_lock_irqsave(struct list_lru *lru, int nid,
+		struct mem_cgroup **memcg, unsigned long *irq_flags);
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
@@ -115,6 +155,9 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
 bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		    struct mem_cgroup *memcg);
 
+bool list_lru_add_irq(struct list_lru *lru, struct list_head *item, int nid,
+		      struct mem_cgroup *memcg);
+
 /**
  * list_lru_add_obj: add an element to the lru list's tail
  * @lru: the lru pointer
diff --git a/mm/list_lru.c b/mm/list_lru.c
index fdb3fe2ea64f..402bb028114d 100644
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
@@ -78,7 +84,8 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 
 static inline struct list_lru_one *
 lock_list_lru_of_memcg(struct list_lru *lru, int nid,
-		       struct mem_cgroup **memcg, bool irq, bool skip_empty)
+		       struct mem_cgroup **memcg, bool irq,
+		       unsigned long *irq_flags, bool skip_empty)
 {
 	struct list_lru_one *l;
 
@@ -86,12 +93,12 @@ lock_list_lru_of_memcg(struct list_lru *lru, int nid,
 again:
 	l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(*memcg));
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
@@ -132,24 +139,58 @@ list_lru_from_memcg_idx(struct list_lru *lru, int nid, int idx)
 
 static inline struct list_lru_one *
 lock_list_lru_of_memcg(struct list_lru *lru, int nid,
-		       struct mem_cgroup **memcg, bool irq, bool skip_empty)
+		       struct mem_cgroup **memcg, bool irq,
+		       unsigned long *irq_flags, bool skip_empty)
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
+				   struct mem_cgroup **memcg)
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
+				       struct mem_cgroup **memcg)
+{
+	return lock_list_lru_of_memcg(lru, nid, memcg, /*irq=*/true,
+				      /*irq_flags=*/NULL, /*skip_empty=*/false);
+}
+
+void list_lru_unlock_irq(struct list_lru_one *l)
+{
+	unlock_list_lru(l, /*irq_off=*/true, /*irq_flags=*/NULL);
+}
 
-	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
+struct list_lru_one *list_lru_lock_irqsave(struct list_lru *lru, int nid,
+					   struct mem_cgroup **memcg,
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
 		/*
@@ -159,15 +200,50 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
 		 */
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
+	l = list_lru_lock(lru, nid, &memcg);
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
+	l = list_lru_lock_irq(lru, nid, &memcg);
+	ret = __list_lru_add(lru, l, item, nid, memcg);
+	list_lru_unlock_irq(l);
+	return ret;
+}
+
 bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
 {
 	bool ret;
@@ -189,19 +265,13 @@ EXPORT_SYMBOL_GPL(list_lru_add_obj);
 bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
 		  struct mem_cgroup *memcg)
 {
-	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
+	bool ret;
 
-	l = lock_list_lru_of_memcg(lru, nid, &memcg, false, false);
-	if (!list_empty(item)) {
-		list_del_init(item);
-		l->nr_items--;
-		unlock_list_lru(l, false);
-		atomic_long_dec(&nlru->nr_items);
-		return true;
-	}
-	unlock_list_lru(l, false);
-	return false;
+	l = list_lru_lock(lru, nid, &memcg);
+	ret = __list_lru_del(lru, l, item, nid);
+	list_lru_unlock(l);
+	return ret;
 }
 
 bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
@@ -274,7 +344,8 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
 	unsigned long isolated = 0;
 
 restart:
-	l = lock_list_lru_of_memcg(lru, nid, &memcg, irq_off, true);
+	l = lock_list_lru_of_memcg(lru, nid, &memcg, /*irq=*/irq_off,
+				   /*irq_flags=*/NULL, /*skip_empty=*/true);
 	if (!l)
 		return isolated;
 	list_for_each_safe(item, n, &l->list) {
@@ -315,7 +386,7 @@ __list_lru_walk_one(struct list_lru *lru, int nid, struct mem_cgroup *memcg,
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


