Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E541F584
	for <lists+cgroups@lfdr.de>; Fri,  1 Oct 2021 21:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356001AbhJATMI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 15:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355653AbhJATMH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 15:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633115422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=eTKxhjw7Yo5S8XqVnMv4HlnJDXI4fKHSCti6PPjnd+Y=;
        b=hPTBwKSyaP/5/I9uCiYpDCGZjbIEJtru0UPT0TuP5z+27AXdMJ2SZjqI/DrIvCdnlp70uT
        7LYVZ68i0wRwYErFasxScxQQMcg0POm9shUg6d9x9aYixRnmLaNMkXZ2FdOPc6/8qvh3eB
        PqN1bddhq18hGLlJ/sy6QiQHIr58/Co=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-iuOMRinSNDSYTE6u2ziHIg-1; Fri, 01 Oct 2021 15:10:19 -0400
X-MC-Unique: iuOMRinSNDSYTE6u2ziHIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AFC78145E5;
        Fri,  1 Oct 2021 19:10:17 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55E2F60BD8;
        Fri,  1 Oct 2021 19:10:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] mm, memcg: Ensure valid memcg from objcg within a RCU critical section
Date:   Fri,  1 Oct 2021 15:09:38 -0400
Message-Id: <20211001190938.14050-4-longman@redhat.com>
In-Reply-To: <20211001190938.14050-1-longman@redhat.com>
References: <20211001190938.14050-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

To ensure that a to-be-offlined memcg fetched from objcg remains
valid (has non-zero reference count) within a RCU critical section,
a synchronize_rcu() call is inserted at the end of memcg_offline_kmem().

With that change, we no longer need to use css_tryget()
in get_mem_cgroup_from_objcg() as the final css_put() in
css_killed_work_fn() would not have been called yet.

The obj_cgroup_uncharge_pages() function is simplifed to perform
the whole uncharge operation within a RCU critical section saving a
css_get()/css_put() pair.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8177f253a127..1dbb37d96e49 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2769,10 +2769,8 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
 	struct mem_cgroup *memcg;
 
 	rcu_read_lock();
-retry:
 	memcg = obj_cgroup_memcg(objcg);
-	if (unlikely(!css_tryget(&memcg->css)))
-		goto retry;
+	css_get(&memcg->css);
 	rcu_read_unlock();
 
 	return memcg;
@@ -2947,13 +2945,14 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 {
 	struct mem_cgroup *memcg;
 
-	memcg = get_mem_cgroup_from_objcg(objcg);
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
 	refill_stock(memcg, nr_pages);
 
-	css_put(&memcg->css);
+	rcu_read_unlock();
 }
 
 /*
@@ -3672,6 +3671,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	memcg_drain_all_list_lrus(kmemcg_id, parent);
 
 	memcg_free_cache_id(kmemcg_id);
+
+	/*
+	 * To ensure that a to-be-offlined memcg fetched from objcg remains
+	 * valid within a RCU critical section, we need to wait here until
+	 * the a grace period has elapsed.
+	 */
+	synchronize_rcu();
 }
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
-- 
2.18.1

