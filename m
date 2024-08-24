Return-Path: <cgroups+bounces-4435-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A566495DA4B
	for <lists+cgroups@lfdr.de>; Sat, 24 Aug 2024 03:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560341F23537
	for <lists+cgroups@lfdr.de>; Sat, 24 Aug 2024 01:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CC28494;
	Sat, 24 Aug 2024 01:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ppXTsg3u"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BAFB65C
	for <cgroups@vger.kernel.org>; Sat, 24 Aug 2024 01:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724461329; cv=none; b=Cr9ci7aLdJBUDcf2fPnLZz7z+me/Kzi/5FWj++EPCluS22XzXQQvKUpmM2iB7DHgUDF4vKZyjWVZIIpZvhKomCft41jfZDeunrQOmVZoI7Upfti8EvSKeE6zOJcNIiDymQ5rmMMFO1K7gN6huYhzVKhm86jpXFqel/Y1LB1eJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724461329; c=relaxed/simple;
	bh=4zpodBSrNzAnVUnjBrp32XwT62vScfoQv3qIeibPkHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8WoIJqvSO608NuweKeAiWN23tKj8kEEXnc5sNHp3gS8CalYc/i9QQU5TifHB2FCxUlAniD0Mse80dfnETGpHCClCeSypMfJkrkUlAfPVKsGHA13O9Cc0/OrkkctvWa500u3QF4S6daIJW3cCmC/2BKF3tdgXsY/akPbBMlyHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ppXTsg3u; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724461324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IdmQ24b94RdpMyCBQcOJAS4hG/aT8izdm4+zDJSbsVk=;
	b=ppXTsg3uulZ98MlT47olN013yCs3uRMV1PF616oQDPMWz8q/TebfIsoJbYcc2zaB7qZRxx
	nGY84tJYogENAU3CzE2/OlM6rDWu+b7E/AzIGegRMRuBvC0IQ5Vlj4OnOcDQMCY7kDuqVI
	kCm+V/t6jedHrr1SOJwFTf2TxIoHbFo=
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
Subject: [RFC PATCH] memcg: add charging of already allocated slab objects
Date: Fri, 23 Aug 2024 18:01:39 -0700
Message-ID: <20240824010139.1293051-1-shakeel.butt@linux.dev>
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

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---

This is RFC to get early comments and I still have to measure the
performance impact of this charging. Particularly I am planning to test
neper's tcp_crr with this patch.

 include/linux/slab.h            |  1 +
 mm/slub.c                       | 39 +++++++++++++++++++++++++++++++++
 net/ipv4/inet_connection_sock.c |  1 +
 3 files changed, 41 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 512e7c844b7f..a8b09b0ca066 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -547,6 +547,7 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 			    gfp_t gfpflags) __assume_slab_alignment __malloc;
 #define kmem_cache_alloc_lru(...)	alloc_hooks(kmem_cache_alloc_lru_noprof(__VA_ARGS__))
 
+bool kmem_cache_post_charge(void *objp, gfp_t gfpflags);
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
 kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
diff --git a/mm/slub.c b/mm/slub.c
index b6b947596e26..574122ad89b8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2189,6 +2189,16 @@ void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 	__memcg_slab_free_hook(s, slab, p, objects, obj_exts);
 }
+
+static __fastpath_inline
+bool memcg_slab_post_charge(struct kmem_cache *s, void *p, gfp_t flags)
+{
+	if (likely(!memcg_kmem_online()))
+		return true;
+
+	return __memcg_slab_post_alloc_hook(s, NULL, flags, 1, &p);
+}
+
 #else /* CONFIG_MEMCG */
 static inline bool memcg_slab_post_alloc_hook(struct kmem_cache *s,
 					      struct list_lru *lru,
@@ -2202,6 +2212,13 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 					void **p, int objects)
 {
 }
+
+static inline bool memcg_slab_post_charge(struct kmem_cache *s,
+					  void *p,
+					  gfp_t flags)
+{
+	return true;
+}
 #endif /* CONFIG_MEMCG */
 
 #ifdef CONFIG_SLUB_RCU_DEBUG
@@ -4110,6 +4127,28 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 }
 EXPORT_SYMBOL(kmem_cache_alloc_lru_noprof);
 
+bool kmem_cache_post_charge(void *objp, gfp_t gfpflags)
+{
+	struct folio *folio;
+	struct slab *slab;
+	struct kmem_cache *s;
+
+	folio = virt_to_folio(objp);
+	if (unlikely(!folio_test_slab(folio)))
+		return false;
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+
+	/* Ignore KMALLOC_NORMAL cache */
+	if (s->flags & SLAB_KMALLOC &&
+	    !(s->flags & (SLAB_CACHE_DMA|SLAB_ACCOUNT|SLAB_RECLAIM_ACCOUNT)))
+		return true;
+
+	return memcg_slab_post_charge(s, objp, gfpflags);
+}
+EXPORT_SYMBOL(kmem_cache_post_charge);
+
 /**
  * kmem_cache_alloc_node - Allocate an object on the specified node
  * @s: The cache to allocate from.
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 64d07b842e73..f707bb76e24d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -733,6 +733,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 		if (amt)
 			mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
 						GFP_KERNEL | __GFP_NOFAIL);
+		kmem_cache_post_charge(newsk, GFP_KERNEL | __GFP_NOFAIL);
 
 		release_sock(newsk);
 	}
-- 
2.43.5


