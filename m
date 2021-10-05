Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E124231CF
	for <lists+cgroups@lfdr.de>; Tue,  5 Oct 2021 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhJEU1M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Oct 2021 16:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229805AbhJEU1M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Oct 2021 16:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633465521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=fphjzfCNo4ZpuqMZyls+oQxve30/shqr62DPT4ol2Kk=;
        b=R42K2PpGzQebBVmX66VxdDAkkaUE/P80NDBx9vTPx/PcKaUvUu0CoCldRNTIP/+WrsKOQr
        MQ+XwznikhSUCCD7cpOM+gIZ5s0q0mtXuNuTB+bQHekCk8NL9zaGbj/Enslg4Mc9V7dXgZ
        MjUkYgFG40JEFdHPXgXQQETAduCjI6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-0Zf8uCHhPCqIIoHyVyTwIg-1; Tue, 05 Oct 2021 16:25:20 -0400
X-MC-Unique: 0Zf8uCHhPCqIIoHyVyTwIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62BB71966320;
        Tue,  5 Oct 2021 20:25:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B59FF5D9D5;
        Tue,  5 Oct 2021 20:25:16 +0000 (UTC)
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
Subject: [PATCH v2] mm/memcg: Remove obsolete memcg_free_kmem()
Date:   Tue,  5 Oct 2021 16:24:50 -0400
Message-Id: <20211005202450.11775-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit d648bcc7fe65 ("mm: kmem: make memcg_kmem_enabled()
irreversible"), the only thing memcg_free_kmem() does is to call
memcg_offline_kmem() when the memcg is still online which can happen when
online_css() fails due to -ENOMEM. However, the name memcg_free_kmem()
is confusing and it is more clear and straight forward to call
memcg_offline_kmem() directly from mem_cgroup_css_free().

Suggested-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6da5020a8656..96a93c608d80 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3656,13 +3656,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 
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
@@ -3671,9 +3664,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 }
-static void memcg_free_kmem(struct mem_cgroup *memcg)
-{
-}
 #endif /* CONFIG_MEMCG_KMEM */
 
 static int memcg_update_kmem_max(struct mem_cgroup *memcg,
@@ -5308,7 +5298,9 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	cancel_work_sync(&memcg->high_work);
 	mem_cgroup_remove_from_trees(memcg);
 	free_shrinker_info(memcg);
-	memcg_free_kmem(memcg);
+
+	/* Need to offline kmem if online_css() fails */
+	memcg_offline_kmem(memcg);
 	mem_cgroup_free(memcg);
 }
 
-- 
2.18.1

