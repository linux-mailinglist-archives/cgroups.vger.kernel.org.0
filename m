Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCDB1BB236
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2020 01:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgD0X4u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 19:56:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726328AbgD0X4t (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 19:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588031808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=bG+oOpvHV7fdGOI3xpfAnUa5ETjwSHs1N5A5bl4B/qU=;
        b=iPQT2XYOUvCYah1j4sxKrOqGrk/zzBzpSoZW/9npQ6+TCMUxxoacZlCbCAmgG925prVWpM
        Z4eAojg8WqVpu2eJ1G7u1v0tFjulnOyQtiK7qAE6xtvX5rQViBN+qFN1dapukajFXL/4T7
        GebTd5b/uUZ0PYeCX7riCW1kCCrDFKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-H4_XG4_1NE6Kei4zmKFt3g-1; Mon, 27 Apr 2020 19:56:46 -0400
X-MC-Unique: H4_XG4_1NE6Kei4zmKFt3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96A5D835B8C;
        Mon, 27 Apr 2020 23:56:43 +0000 (UTC)
Received: from llong.com (ovpn-112-176.rdu2.redhat.com [10.10.112.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C1D460BF4;
        Mon, 27 Apr 2020 23:56:42 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Qian Cai <cai@lca.pw>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 1/4] mm, slab: Revert "extend slab/shrink to shrink all memcg caches"
Date:   Mon, 27 Apr 2020 19:56:18 -0400
Message-Id: <20200427235621.7823-2-longman@redhat.com>
In-Reply-To: <20200427235621.7823-1-longman@redhat.com>
References: <20200427235621.7823-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When the slub shrink sysfs file is written into, the function call
sequence is as follows:

  kernfs_fop_write
    => slab_attr_store
      => shrink_store
        => kmem_cache_shrink_all

It turns out that doing a memcg cache scan in kmem_cache_shrink_all()
is redundant as the same memcg cache scan is being done in
slab_attr_store(). So revert the commit 04f768a39d55 ("mm, slab: extend
slab/shrink to shrink all memcg caches") except the documentation change
which is still valid.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slab.h        |  1 -
 mm/slab_common.c | 37 -------------------------------------
 mm/slub.c        |  2 +-
 3 files changed, 1 insertion(+), 39 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 207c83ef6e06..0937cb2ae8aa 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -237,7 +237,6 @@ int __kmem_cache_shrink(struct kmem_cache *);
 void __kmemcg_cache_deactivate(struct kmem_cache *s);
 void __kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s);
 void slab_kmem_cache_release(struct kmem_cache *);
-void kmem_cache_shrink_all(struct kmem_cache *s);
 
 struct seq_file;
 struct file;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 23c7500eea7d..2e367ab8c15c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -995,43 +995,6 @@ int kmem_cache_shrink(struct kmem_cache *cachep)
 }
 EXPORT_SYMBOL(kmem_cache_shrink);
 
-/**
- * kmem_cache_shrink_all - shrink a cache and all memcg caches for root cache
- * @s: The cache pointer
- */
-void kmem_cache_shrink_all(struct kmem_cache *s)
-{
-	struct kmem_cache *c;
-
-	if (!IS_ENABLED(CONFIG_MEMCG_KMEM) || !is_root_cache(s)) {
-		kmem_cache_shrink(s);
-		return;
-	}
-
-	get_online_cpus();
-	get_online_mems();
-	kasan_cache_shrink(s);
-	__kmem_cache_shrink(s);
-
-	/*
-	 * We have to take the slab_mutex to protect from the memcg list
-	 * modification.
-	 */
-	mutex_lock(&slab_mutex);
-	for_each_memcg_cache(c, s) {
-		/*
-		 * Don't need to shrink deactivated memcg caches.
-		 */
-		if (s->flags & SLAB_DEACTIVATED)
-			continue;
-		kasan_cache_shrink(c);
-		__kmem_cache_shrink(c);
-	}
-	mutex_unlock(&slab_mutex);
-	put_online_mems();
-	put_online_cpus();
-}
-
 bool slab_is_available(void)
 {
 	return slab_state >= UP;
diff --git a/mm/slub.c b/mm/slub.c
index 9bf44955c4f1..183ccc364ccf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5343,7 +5343,7 @@ static ssize_t shrink_store(struct kmem_cache *s,
 			const char *buf, size_t length)
 {
 	if (buf[0] == '1')
-		kmem_cache_shrink_all(s);
+		kmem_cache_shrink(s);
 	else
 		return -EINVAL;
 	return length;
-- 
2.18.1

