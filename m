Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA09370E5C
	for <lists+cgroups@lfdr.de>; Sun,  2 May 2021 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhEBSJf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 2 May 2021 14:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231801AbhEBSJe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 2 May 2021 14:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619978921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=kEFyh88t8RjL4Ya/tUcmCMYYCtAJ4jkovquK5V2cmso=;
        b=ZerIt5R+MVsZ06BNy13VlnPNW9HpjJqVswSmBbFdlqJcNDucTrfNSgOl8bHCTszi8HIvnr
        APYdJDDDwyazFyXMeivVIHqYAHG9WZgG71PSVFLVTpwEFxnRfq/iMlYmlsrbjkr2TYchuh
        sm7jkr2RU/KoqaKvIxc0/27tNnm644c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-TArhv3WIP_WJue1uC6L8Ug-1; Sun, 02 May 2021 14:08:40 -0400
X-MC-Unique: TArhv3WIP_WJue1uC6L8Ug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E89E2107ACC7;
        Sun,  2 May 2021 18:08:37 +0000 (UTC)
Received: from llong.com (ovpn-112-236.rdu2.redhat.com [10.10.112.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40BDE19D7D;
        Sun,  2 May 2021 18:08:36 +0000 (UTC)
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
Subject: [PATCH 2/2] mm: memcg/slab: Don't create unfreeable slab
Date:   Sun,  2 May 2021 14:07:55 -0400
Message-Id: <20210502180755.445-2-longman@redhat.com>
In-Reply-To: <20210502180755.445-1-longman@redhat.com>
References: <20210502180755.445-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The obj_cgroup array (memcg_data) embedded in the page structure is
allocated at the first instance an accounted memory allocation happens.
With the right size object, it is possible that the allocated obj_cgroup
array comes from the same slab that requires memory accounting. If this
happens, the slab will never become empty again as there is at least one
object left (the obj_cgroup array) in the slab.

With instructmentation code added to detect this situation, I got 76
hits on the kmalloc-192 slab when booting up a test kernel on a VM.
So this can really happen.

To avoid the creation of these unfreeable slabs, a check is added to
memcg_alloc_page_obj_cgroups() to detect that and double the size
of the array in case it happens to make sure that it comes from a
different kmemcache.

This change, however, does not completely eliminate the presence
of unfreeable slabs which can still happen if a circular obj_cgroup
array dependency is formed.

Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b0695d3aa530..44852ac048c3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2876,12 +2876,24 @@ int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
 	 */
 	objects = max(objs_per_slab_page(s, page),
 		      (int)(sizeof(struct rcu_head)/sizeof(void *)));
-
+retry:
 	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *), gfp,
 			   page_to_nid(page));
 	if (!vec)
 		return -ENOMEM;
 
+	/*
+	 * The allocated vector should not come from the same slab.
+	 * Otherwise, this slab will never become empty. Double the size
+	 * in this case to make sure that the vector comes from a different
+	 * kmemcache.
+	 */
+	if (unlikely(virt_to_head_page(vec) == page)) {
+		kfree(vec);
+		objects *= 2;
+		goto retry;
+	}
+
 	memcg_data = (unsigned long) vec | MEMCG_DATA_OBJCGS;
 	if (new_page) {
 		/*
-- 
2.18.1

