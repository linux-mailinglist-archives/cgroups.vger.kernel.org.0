Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85D235EA46
	for <lists+cgroups@lfdr.de>; Wed, 14 Apr 2021 03:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbhDNBVP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 21:21:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35863 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345685AbhDNBVP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Apr 2021 21:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618363254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=80OiZdRF0zG+/9/xLJu7PaNs7xvMkYou02sp8RHghi4=;
        b=eitblPOHkUcGTgsbgRplAGvN7EIwPWPNPGtNXVfaC2ceIDnm/j9dXL8STnTgPFpR6Zna7a
        hT29apIv1brqLP8QxN2dnp13uzTmrpPcY6wOdlM5X/6sHUsTEGGxtPbtiqBInQF2OSqsnx
        lAv8StRU7lgh5aEgQNfz5TOUdStynyQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-mOc640h4MkquAy0kaneemg-1; Tue, 13 Apr 2021 21:20:50 -0400
X-MC-Unique: mOc640h4MkquAy0kaneemg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72107107ACCD;
        Wed, 14 Apr 2021 01:20:48 +0000 (UTC)
Received: from llong.com (ovpn-113-4.rdu2.redhat.com [10.10.113.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E81F1F419;
        Wed, 14 Apr 2021 01:20:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 1/5] mm/memcg: Pass both memcg and lruvec to mod_memcg_lruvec_state()
Date:   Tue, 13 Apr 2021 21:20:23 -0400
Message-Id: <20210414012027.5352-2-longman@redhat.com>
In-Reply-To: <20210414012027.5352-1-longman@redhat.com>
References: <20210414012027.5352-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
available. So both of them are now passed to mod_memcg_lruvec_state()
and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
updated to allow either of the two parameters to be set to null. This
makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
is null.

The new __mod_memcg_lruvec_state() function will be used in the next
patch as a replacement of mod_memcg_state() in mm/percpu.c for the
consolidation of the memory uncharge and vmstat update functions in
the kmem_cache_free() path.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 12 +++++++-----
 mm/memcontrol.c            | 19 +++++++++++++------
 mm/slab.h                  |  2 +-
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0c04d39a7967..95f12996e66c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -955,8 +955,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
-void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			      int val);
+void __mod_memcg_lruvec_state(struct mem_cgroup *memcg, struct lruvec *lruvec,
+			      enum node_stat_item idx, int val);
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
 
 static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
@@ -969,13 +969,14 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
 	local_irq_restore(flags);
 }
 
-static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
+static inline void mod_memcg_lruvec_state(struct mem_cgroup *memcg,
+					  struct lruvec *lruvec,
 					  enum node_stat_item idx, int val)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	__mod_memcg_lruvec_state(lruvec, idx, val);
+	__mod_memcg_lruvec_state(memcg, lruvec, idx, val);
 	local_irq_restore(flags);
 }
 
@@ -1369,7 +1370,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
-static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+static inline void __mod_memcg_lruvec_state(struct mem_cgroup *memcg,
+					    struct lruvec *lruvec,
 					    enum node_stat_item idx, int val)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e064ac0d850a..d66e1e38f8ac 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -799,20 +799,27 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
 	return mem_cgroup_nodeinfo(parent, nid);
 }
 
-void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
-			      int val)
+/*
+ * Either one of memcg or lruvec can be NULL, but not both.
+ */
+void __mod_memcg_lruvec_state(struct mem_cgroup *memcg, struct lruvec *lruvec,
+			      enum node_stat_item idx, int val)
 {
 	struct mem_cgroup_per_node *pn;
-	struct mem_cgroup *memcg;
 	long x, threshold = MEMCG_CHARGE_BATCH;
 
+	/* Update lruvec */
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	memcg = pn->memcg;
+
+	if (!memcg)
+		memcg = pn->memcg;
 
 	/* Update memcg */
 	__mod_memcg_state(memcg, idx, val);
 
-	/* Update lruvec */
+	if (!lruvec)
+		return;
+
 	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
 
 	if (vmstat_item_in_bytes(idx))
@@ -848,7 +855,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 
 	/* Update memcg and lruvec */
 	if (!mem_cgroup_disabled())
-		__mod_memcg_lruvec_state(lruvec, idx, val);
+		__mod_memcg_lruvec_state(NULL, lruvec, idx, val);
 }
 
 void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
diff --git a/mm/slab.h b/mm/slab.h
index 076582f58f68..bc6c7545e487 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -293,7 +293,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-	mod_memcg_lruvec_state(lruvec, idx, nr);
+	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
 	rcu_read_unlock();
 }
 
-- 
2.18.1

