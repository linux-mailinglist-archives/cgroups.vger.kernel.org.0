Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6FE41F582
	for <lists+cgroups@lfdr.de>; Fri,  1 Oct 2021 21:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355883AbhJATMG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 15:12:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33453 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355861AbhJATMF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 15:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633115421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=4NNmOdozgW34250h3i+XZDY/eQfLDbJdb5QbTC9VPyU=;
        b=OWCUKVzgJjApLLcSlSARA0N48z6Vx1xtqEFqQQSi8uiFBumD0zvRu8RV4qXay/4Ro1P6a3
        Zk5iAgoZBqP5ZLPS6K8O9yvsS99pakcbD8U0CeM+k6tT5uZoD0hwjwmWWMh0rqkMz33e0X
        gWI2DWltxizz9z1/wyBMYMyNZaeRRWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-QPseJOL4PxykHrj_plzBZg-1; Fri, 01 Oct 2021 15:10:17 -0400
X-MC-Unique: QPseJOL4PxykHrj_plzBZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3082B107B0F3;
        Fri,  1 Oct 2021 19:10:16 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA75C60BD8;
        Fri,  1 Oct 2021 19:10:14 +0000 (UTC)
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
Subject: [PATCH 2/3] mm, memcg: Remove obsolete memcg_free_kmem()
Date:   Fri,  1 Oct 2021 15:09:37 -0400
Message-Id: <20211001190938.14050-3-longman@redhat.com>
In-Reply-To: <20211001190938.14050-1-longman@redhat.com>
References: <20211001190938.14050-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
irreversible"), the only thing memcg_free_kmem() does is to call
memcg_offline_kmem() when the memcg is still online. However,
memcg_offline_kmem() is only called from mem_cgroup_css_free() which
cannot be reached if the memcg hasn't been offlined first. As this
function now serves no purpose, we should just remove it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4568363062c1..8177f253a127 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3673,13 +3673,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
 	memcg_free_cache_id(kmemcg_id);
 }
-
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-	/* css_alloc() failed, offlining didn't happen */
-	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
-		memcg_offline_kmem(memcg);
-}
 #else
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
@@ -3688,9 +3681,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 }
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
@@ -5325,7 +5315,6 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
-	memcg_free_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
 
-- 
2.18.1

