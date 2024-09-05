Return-Path: <cgroups+bounces-4721-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7C96E127
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 19:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECD81C23115
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2024 17:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1131A3BCB;
	Thu,  5 Sep 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aegBcYsH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D861B19C579
	for <cgroups@vger.kernel.org>; Thu,  5 Sep 2024 17:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725557687; cv=none; b=JI+Lvig/YqN6vTJuSEwoU32WEMzluWcjGQ7lJKmpSXrZ+l6fpO3hPspu63POSxHGQKjsMLQj5fE4M/OlIza5kRA+vzKherXRnrUgWt6xFATUGeMceR7spGU7O1FNejmU8ONNAThWWf3ZgPEc3LxOrT49Srv98dFkK7fbvSJOXbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725557687; c=relaxed/simple;
	bh=JYGCoDyAfXE6plY3BCD9/n2Am3fSVZ48MjXRX1ACfA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G4Goyy8PVkdWr9NOSz67XPz9956F5TBgIjVfCjicQHvQfXg40ThEzAFVOqbef9ZipbjTkvmFTMjwfSS5PsEI13Q3M+rsECMJvbLXZBKLPoLcEpH9aYq1SkUe8vEo8lDMOywMmpw49yqvJNgLHS0MS5/RRB/vpDvJr+f65dHwYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aegBcYsH; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725557681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YsvYqCVKQQkfAV/dC9DA9+PClCN3nQT/ynwnzjufDVo=;
	b=aegBcYsHS8vohzjzv56rTBm9b+tJe0FfwUNSBZtxslHOz5vEU+Ubqi2eUBNxUb4IIc38KH
	qExVrqXElq3QqvYjkTUAxmlM2zAT1hP2DFYq5jA7usxMMXUr8N1diwinRFFk4v0CYPEafA
	jZRZsg0WzdTX6/K3r7Al0Az4MwJhpSU=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4] memcg: add charging of already allocated slab objects
Date: Thu,  5 Sep 2024 10:34:22 -0700
Message-ID: <20240905173422.1565480-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

At the moment, the slab objects are charged to the memcg at the
allocation time. However there are cases where slab objects are
allocated at the time where the right target memcg to charge it to is
not known. One such case is the network sockets for the incoming
connection which are allocated in the softirq context.

Couple hundred thousand connections are very normal on large loaded
server and almost all of those sockets underlying those connections get
allocated in the softirq context and thus not charged to any memcg.
However later at the accept() time we know the right target memcg to
charge. Let's add new API to charge already allocated objects, so we can
have better accounting of the memory usage.

To measure the performance impact of this change, tcp_crr is used from
the neper [1] performance suite. Basically it is a network ping pong
test with new connection for each ping pong.

The server and the client are run inside 3 level of cgroup hierarchy
using the following commands:

Server:
 $ tcp_crr -6

Client:
 $ tcp_crr -6 -c -H ${server_ip}

If the client and server run on different machines with 50 GBPS NIC,
there is no visible impact of the change.

For the same machine experiment with v6.11-rc5 as base.

          base (throughput)     with-patch
tcp_crr   14545 (+- 80)         14463 (+- 56)

It seems like the performance impact is within the noise.

Link: https://github.com/google/neper [1]
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
v3: https://lore.kernel.org/all/20240829175339.2424521-1-shakeel.butt@linux.dev/
Changes since v3:
- Add kernel doc for kmem_cache_charge.

v2: https://lore.kernel.org/all/20240827235228.1591842-1-shakeel.butt@linux.dev/
Change since v2:
- Add handling of already charged large kmalloc objects.
- Move the normal kmalloc cache check into a function.

v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
Changes since v1:
- Correctly handle large allocations which bypass slab
- Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds

RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
Changes since the RFC:
- Added check for already charged slab objects.
- Added performance results from neper's tcp_crr


 include/linux/slab.h            | 20 ++++++++++++++
 mm/slab.h                       |  7 +++++
 mm/slub.c                       | 49 +++++++++++++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c |  5 ++--
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb2bf4629157..68789c79a530 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -547,6 +547,26 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 			    gfp_t gfpflags) __assume_slab_alignment __malloc;
 #define kmem_cache_alloc_lru(...)	alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
 
+/**
+ * kmem_cache_charge - memcg charge an already allocated slab memory
+ * @objp: address of the slab object to memcg charge.
+ * @gfpflags: describe the allocation context
+ *
+ * kmem_cache_charge is the normal method to charge a slab object to the current
+ * memcg. The objp should be pointer returned by the slab allocator functions
+ * like kmalloc or kmem_cache_alloc. The memcg charge behavior can be controller
+ * through gfpflags parameter.
+ *
+ * There are several cases where it will return true regardless. More
+ * specifically:
+ *
+ * 1. For !CONFIG_MEMCG or cgroup_disable=memory systems.
+ * 2. Already charged slab objects.
+ * 3. For slab objects from KMALLOC_NORMAL caches.
+ *
+ * Return: true if charge was successful otherwise false.
+ */
+bool kmem_cache_charge(void *objp, gfp_t gfpflags);
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
diff --git a/mm/slab.h b/mm/slab.h
index dcdb56b8e7f5..9f907e930609 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -443,6 +443,13 @@ static inline bool is_kmalloc_cache(struct kmem_cache *s)
 	return (s->flags & SLAB_KMALLOC);
 }
 
+static inline bool is_kmalloc_normal(struct kmem_cache *s)
+{
+	if (!is_kmalloc_cache(s))
+		return false;
+	return !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT));
+}
+
 /* Legal flag mask for kmem_cache_create(), for various configurations */
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..3f2a89f7a23a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2185,6 +2185,41 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
 }
+
+static __fastpath_inline
+bool memcg_slab_post_charge(void *p, gfp_t flags)
+{
+	struct slabobj_ext *slab_exts;
+	struct kmem_cache *s;
+	struct folio *folio;
+	struct slab *slab;
+	unsigned long off;
+
+	folio = virt_to_folio(p);
+	if (!folio_test_slab(folio)) {
+		return folio_memcg_kmem(folio) ||
+			(__memcg_kmem_charge_page(folio_page(folio, 0), flags,
+						  folio_order(folio)) == 0);
+	}
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+
+	/* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
+	if (is_kmalloc_normal(s))
+		return true;
+
+	/* Ignore already charged objects. */
+	slab_exts = slab_obj_exts(slab);
+	if (slab_exts) {
+		off = obj_to_index(s, slab, p);
+		if (unlikely(slab_exts[off].objcg))
+			return true;
+	}
+
+	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
+}
+
 #else /* CONFIG_MEMCG */
 static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct list_lru *lru,
@@ -2198,6 +2233,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
 }
+
+static inline bool memcg_slab_post_charge(void *p, gfp_t flags)
+{
+	return true;
+}
 #endif /* CONFIG_MEMCG */
 
 /*
@@ -4062,6 +4102,15 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
 
+bool kmem_cache_charge(void *objp, gfp_t gfpflags)
+{
+	if (!memcg_kmem_online())
+		return true;
+
+	return memcg_slab_post_charge(objp, gfpflags);
+}
+EXPORT_SYMBOL(kmem_cache_charge);
+
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @s: The cache to allocate from.
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 64d07b842e73..3c13ca8c11fb 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -715,6 +715,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 	release_sock(sk);
 	if (newsk && mem_cgroup_sockets_enabled) {
 		int amt = 0;
+		gfp_t gfp = GFP_KERNEL | __GFP_NOFAIL;
 
 		/* atomically get the memory usage, set and charge the
 		 * newsk->sk_memcg.
@@ -731,8 +732,8 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		}
 
 		if (amt)
-			mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
-						GFP_KERNEL | __GFP_NOFAIL);
+			mem_cgroup_charge_skmem(newsk->sk_memcg, amt, gfp);
+		kmem_cache_charge(newsk, gfp);
 
 		release_sock(newsk);
 	}
-- 
2.43.5


