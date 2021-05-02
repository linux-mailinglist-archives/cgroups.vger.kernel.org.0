Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB54370E5A
	for <lists+cgroups@lfdr.de>; Sun,  2 May 2021 20:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhEBSJb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 2 May 2021 14:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231788AbhEBSJb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 2 May 2021 14:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619978919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=vyxShKxSh89EB6np4IlWbUt6LchDd4K6ZPvcD0TSg7Y=;
        b=aN1yKFAyFP15wzc5LL6+7ZcpiU2HkMUn8+O2PcWt6dtGLQkwq6Vc6e3O4QwoF/jcI4AIvP
        m9CQuT54Hup1d/tcKbKH5bSFlyWkdJUEnkoRsCpeLpscGsfmbLnxfSs01tPCcLTPIe7wAg
        nxLjUs8ZGr1vIw8pHFeeEERljNEwtV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-6t6b3JrgNQK4dwAPINmdYw-1; Sun, 02 May 2021 14:08:38 -0400
X-MC-Unique: 6t6b3JrgNQK4dwAPINmdYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8D6B801B12;
        Sun,  2 May 2021 18:08:35 +0000 (UTC)
Received: from llong.com (ovpn-112-236.rdu2.redhat.com [10.10.112.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B42CA19D7C;
        Sun,  2 May 2021 18:08:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] mm: memcg/slab: Prevent recursive kfree() loop
Date:   Sun,  2 May 2021 14:07:54 -0400
Message-Id: <20210502180755.445-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since the merging of the new slab memory controller in v5.9, the
page structure stores a pointer to obj_cgroup pointer array for
slab pages. When the slab has no used objects, it can be freed in
free_slab() which will call kfree() to free the obj_cgroup pointer array
in memcg_alloc_page_obj_cgroups(). If it happens that the obj_cgroup
array is the last used object in its slab, that slab may then be freed
which may caused kfree() to be called again.

With the right workload, the slab cache may be set up in a way that
allows the recursive kfree() calling loop to nest deep enough to
cause a kernel stack overflow and panic the system. In fact, we have
a reproducer that can cause kernel stack overflow on a s390 system
involving kmalloc-rcl-256 and kmalloc-rcl-128 slabs with the following
kfree() loop recursively called 74 times:

  [  285.520739]  [<000000000ec432fc>] kfree+0x4bc/0x560
  [  285.520740]  [<000000000ec43466>] __free_slab+0xc6/0x228
  [  285.520741]  [<000000000ec41fc2>] __slab_free+0x3c2/0x3e0
  [  285.520742]  [<000000000ec432fc>] kfree+0x4bc/0x560
					:

One way to prevent this from happening is to defer the freeing of the
obj_cgroup array to a later time like using kfree_rcu() even though we
don't really need rcu protection in this case.

The size of rcu_head is just two pointers. The allocated obj_cgroup
array should not be less than that. To be safe, however, additional
code is added to make sure that this is really the case.

Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c |  9 ++++++++-
 mm/slab.h       | 11 ++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c100265dc393..b0695d3aa530 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2866,10 +2866,17 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
 {
-	unsigned int objects = objs_per_slab_page(s, page);
+	unsigned int objects;
 	unsigned long memcg_data;
 	void *vec;
 
+	/*
+	 * Since kfree_rcu() is used for freeing, we have to make
+	 * sure that the allocated buffer is big enough for rcu_head.
+	 */
+	objects = max(objs_per_slab_page(s, page),
+		      (int)(sizeof(struct rcu_head)/sizeof(void *)));
+
 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
 			   page_to_nid(page));
 	if (!vec)
diff --git a/mm/slab.h b/mm/slab.h
index 18c1927cd196..6244a00d30ce 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -242,8 +242,17 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 
 static inline void memcg_free_page_obj_cgroups(struct page *page)
 {
-	kfree(page_objcgs(page));
+	struct {
+		struct rcu_head rcu;
+	} *objcgs = (void *)page_objcgs(page);
+
+	/*
+	 * We don't actually need to use rcu to protect objcg pointers.
+	 * kfree_rcu() is used here just to defer the actual freeing to avoid
+	 * a recursive kfree() loop which may lead to kernel stack overflow.
+	 */
 	page->memcg_data = 0;
+	kfree_rcu(objcgs, rcu);
 }
 
 static inline size_t obj_full_size(struct kmem_cache *s)
-- 
2.18.1

