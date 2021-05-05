Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287B6373EE5
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbhEEPsg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 11:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233687AbhEEPsf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 May 2021 11:48:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620229658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=UYxtPKpE548sgyGm/1fmGwS+oSULE1eFSrQRq98f+o4=;
        b=YGnUd7+spKG43oVAR2uVEvdOx/5T6yhy+bjSdjFjVvuhnaDSXV5dlgZO3l415azTNWBGo9
        +OOBL6iUiBTmK8QiEYmwyUWaprshZ/4H1a8fdYad8+dN8XTSlDPTIBa95yVf8T5C3Kwbq+
        Nz1gmKXqaU9Xivcs74ZHftIO+JgK9kc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-fQrnHrtDOCynD-6wzndQNw-1; Wed, 05 May 2021 11:47:27 -0400
X-MC-Unique: fQrnHrtDOCynD-6wzndQNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF23F835DE0;
        Wed,  5 May 2021 15:47:24 +0000 (UTC)
Received: from llong.com (ovpn-117-4.rdu2.redhat.com [10.10.117.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 387995D6AC;
        Wed,  5 May 2021 15:47:22 +0000 (UTC)
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
Subject: [PATCH v3 1/2] mm: memcg/slab: Properly set up gfp flags for objcg pointer array
Date:   Wed,  5 May 2021 11:46:12 -0400
Message-Id: <20210505154613.17214-2-longman@redhat.com>
In-Reply-To: <20210505154613.17214-1-longman@redhat.com>
References: <20210505154613.17214-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since the merging of the new slab memory controller in v5.9, the page
structure may store a pointer to obj_cgroup pointer array for slab pages.
Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
is not readily reclaimable and doesn't need to come from the DMA buffer.
So those GFP bits should be masked off as well.

Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
that it is consistently applied no matter where it is called.

Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 8 ++++++++
 mm/slab.h       | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c100265dc393..5e3b4f23b830 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2863,6 +2863,13 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
 }
 
 #ifdef CONFIG_MEMCG_KMEM
+/*
+ * The allocated objcg pointers array is not accounted directly.
+ * Moreover, it should not come from DMA buffer and is not readily
+ * reclaimable. So those GFP bits should be masked off.
+ */
+#define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
+
 int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 				 gfp_t gfp, bool new_page)
 {
@@ -2870,6 +2877,7 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 	unsigned long memcg_data;
 	void *vec;
 
+	gfp &= ~OBJCGS_CLEAR_MASK;
 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
 			   page_to_nid(page));
 	if (!vec)
diff --git a/mm/slab.h b/mm/slab.h
index 18c1927cd196..b3294712a686 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -309,7 +309,6 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
 	if (!memcg_kmem_enabled() || !objcg)
 		return;
 
-	flags &= ~__GFP_ACCOUNT;
 	for (i = 0; i < size; i++) {
 		if (likely(p[i])) {
 			page = virt_to_head_page(p[i]);
-- 
2.18.1

