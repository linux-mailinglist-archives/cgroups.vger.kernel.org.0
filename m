Return-Path: <cgroups+bounces-4530-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E7961ADC
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2024 01:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62C891F24940
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 23:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F631D47D8;
	Tue, 27 Aug 2024 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KXJZfp3t"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA61D47B4
	for <cgroups@vger.kernel.org>; Tue, 27 Aug 2024 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802766; cv=none; b=sZp+SkYJ0PwB9W8DhvB66UAhZOTjvMFHTXYLoIZKe2mL70IINAkj3XY6Vkx0sRJyIde1J2/pRJhEZYQsjairkIEbEr9KcXsFjyhMvHZO4Y3td6pHZblIFbIXiRevPfDIjyT/NY5UWX3iDok7pI58j9mLZY+79QieDuBYIaVsUtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802766; c=relaxed/simple;
	bh=BmfFu4yrspw+WKGzyeyd2ChfQihU26tgqZAVBGi9NjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWuspcogyY3qskOCYle1dTB9QMtMM79UQq75/XVd2O0y/rlUTXgH6teI5oO4Jlp6kJt3ER85LL1g+IJi607msxvfz8VCED2KuhKEY4sFGlmZJc8rCGtNz+dEGwBI8zuv9pWCjid/Ahk1TC2oK7iLS7GXbAfC7756w4wYXoz3VZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KXJZfp3t; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724802760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DSSWXtbn5wILLvu1XA/R47N7+NK81XaTgeRTtJ7F0iM=;
	b=KXJZfp3trgSdfSgQA9oiaLntyzsc/WZFfi6sOps73DNgH131rMGlngp2SlZ22JUjcSDbA4
	6qK9UNIyuORAR2WpXFCnR5DoUEFYSFPw+3JNhru+l8jPVqDEId2sO9LbN0A3cU8hfHGaSl
	LSNRwbE7EAyYhcosD+q3XiZUSEBDcmk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
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
Subject: [PATCH v2] memcg: add charging of already allocated slab objects
Date: Tue, 27 Aug 2024 16:52:28 -0700
Message-ID: <20240827235228.1591842-1-shakeel.butt@linux.dev>
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
---
v1: https://lore.kernel.org/all/20240826232908.4076417-1-shakeel.butt@linux.dev/
Changes since v1:
- Correctly handle large allocations which bypass slab
- Rearrange code to avoid compilation errors for !CONFIG_MEMCG builds

RFC: https://lore.kernel.org/all/20240824010139.1293051-1-shakeel.butt@linux.dev/
Changes since the RFC:
- Added check for already charged slab objects.
- Added performance results from neper's tcp_crr

 include/linux/slab.h            |  1 +
 mm/slub.c                       | 51 +++++++++++++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c |  5 ++--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb2bf4629157..05cfab107c72 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -547,6 +547,7 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 			    gfp_t gfpflags) __assume_slab_alignment __malloc;
 #define kmem_cache_alloc_lru(...)	alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
 
+bool kmem_cache_charge(void *objp, gfp_t gfpflags);
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..8265ea5f25be 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2185,6 +2185,43 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
 }
+
+#define KMALLOC_TYPE (SLAB_KMALLOC | SLAB_CACHE_DMA | \
+		      SLAB_ACCOUNT | SLAB_RECLAIM_ACCOUNT)
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
+		return __memcg_kmem_charge_page(folio_page(folio, 0), flags,
+						folio_order(folio)) == 0;
+	}
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+
+	/* Ignore KMALLOC_NORMAL cache to avoid circular dependency. */
+	if ((s->flags & KMALLOC_TYPE) == SLAB_KMALLOC)
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
@@ -2198,6 +2235,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
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
@@ -4062,6 +4104,15 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
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


