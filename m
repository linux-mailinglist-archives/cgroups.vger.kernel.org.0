Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2E3638AB
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 02:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhDSABe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Apr 2021 20:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236562AbhDSABd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Apr 2021 20:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618790464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=78iLLfuZ7fTLXxoPFDJyruPJpxKm3UtpGKR94vx8lFk=;
        b=BkS2TRCD1EsrrqqtEELcWZxI3DWKs3Jt4GQ9lF9Q5gd+39Pk+zuqAqfa1VU27ZqfGYigy6
        11V8qv5KvnmK5C+4rH9REkRDUcOQ9SwDrrM5L3FTINIt+kwasnoyOCyEHvHFSNssN8sk4Y
        mK4QU+/6jlDSe4ODaRyJQATxA1vulK4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-z61uXu-IMuWv6NwlBfQYIA-1; Sun, 18 Apr 2021 20:01:00 -0400
X-MC-Unique: z61uXu-IMuWv6NwlBfQYIA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6A988030C4;
        Mon, 19 Apr 2021 00:00:57 +0000 (UTC)
Received: from llong.com (ovpn-112-235.rdu2.redhat.com [10.10.112.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72DF65D741;
        Mon, 19 Apr 2021 00:00:55 +0000 (UTC)
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
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 4/5] mm/memcg: Save both reclaimable & unreclaimable bytes in object stock
Date:   Sun, 18 Apr 2021 20:00:31 -0400
Message-Id: <20210419000032.5432-5-longman@redhat.com>
In-Reply-To: <20210419000032.5432-1-longman@redhat.com>
References: <20210419000032.5432-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, the object stock structure caches either reclaimable vmstat
bytes or unreclaimable vmstat bytes in its object stock structure. The
hit rate can be improved if both types of vmstat data can be cached
especially for single-node system.

This patch supports the cacheing of both type of vmstat data, though
at the expense of a slightly increased complexity in the caching code.
For large object (>= PAGE_SIZE), vmstat array is done directly without
going through the stock caching step.

On a 2-socket Cascade Lake server with instrumentation enabled, the
miss rates are shown in the table below.

  Initial bootup:

  Kernel       __mod_objcg_state    mod_objcg_state    %age
  ------       -----------------    ---------------    ----
  Before patch      634400              3243830        19.6%
  After patch       419810              3182424        13.2%

  Parallel kernel build:

  Kernel       __mod_objcg_state    mod_objcg_state    %age
  ------       -----------------    ---------------    ----
  Before patch      24329265           142512465       17.1%
  After patch       24051721           142445825       16.9%

There was a decrease of miss rate after initial system bootup. However,
the miss rate for parallel kernel build remained about the same probably
because most of the touched kmemcache objects were reclaimable inodes
and dentries.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 79 +++++++++++++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 28 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c13502eab282..a6dd18f6d8a8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2212,8 +2212,8 @@ struct obj_stock {
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
-	int vmstat_idx;
-	int vmstat_bytes;
+	int reclaimable_bytes;		/* NR_SLAB_RECLAIMABLE_B */
+	int unreclaimable_bytes;	/* NR_SLAB_UNRECLAIMABLE_B */
 #else
 	int dummy[0];
 #endif
@@ -3217,40 +3217,56 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_stock *stock;
+	int *bytes, *alt_bytes, alt_idx;
+
+	/*
+	 * Directly update vmstat array for big object.
+	 */
+	if (unlikely(abs(nr) >= PAGE_SIZE))
+		goto update_vmstat;
+
+	stock = get_obj_stock(&flags);
+	if (idx == NR_SLAB_RECLAIMABLE_B) {
+		bytes = &stock->reclaimable_bytes;
+		alt_bytes = &stock->unreclaimable_bytes;
+		alt_idx = NR_SLAB_UNRECLAIMABLE_B;
+	} else {
+		bytes = &stock->unreclaimable_bytes;
+		alt_bytes = &stock->reclaimable_bytes;
+		alt_idx = NR_SLAB_RECLAIMABLE_B;
+	}
 
 	/*
-	 * Save vmstat data in stock and skip vmstat array update unless
-	 * accumulating over a page of vmstat data or when pgdat or idx
+	 * Try to save vmstat data in stock and skip vmstat array update
+	 * unless accumulating over a page of vmstat data or when pgdat
 	 * changes.
 	 */
 	if (stock->cached_objcg != objcg) {
 		/* Output the current data as is */
-	} else if (!stock->vmstat_bytes) {
-		/* Save the current data */
-		stock->vmstat_bytes = nr;
-		stock->vmstat_idx = idx;
-		stock->cached_pgdat = pgdat;
-		nr = 0;
-	} else if ((stock->cached_pgdat != pgdat) ||
-		   (stock->vmstat_idx != idx)) {
-		/* Output the cached data & save the current data */
-		swap(nr, stock->vmstat_bytes);
-		swap(idx, stock->vmstat_idx);
+	} else if (stock->cached_pgdat != pgdat) {
+		/* Save the current data and output cached data, if any */
+		swap(nr, *bytes);
 		swap(pgdat, stock->cached_pgdat);
+		if (*alt_bytes) {
+			__mod_objcg_state(objcg, pgdat, alt_idx,
+					  *alt_bytes);
+			*alt_bytes = 0;
+		}
 	} else {
-		stock->vmstat_bytes += nr;
-		if (abs(stock->vmstat_bytes) > PAGE_SIZE) {
-			nr = stock->vmstat_bytes;
-			stock->vmstat_bytes = 0;
+		*bytes += nr;
+		if (abs(*bytes) > PAGE_SIZE) {
+			nr = *bytes;
+			*bytes = 0;
 		} else {
 			nr = 0;
 		}
 	}
-	if (nr)
-		__mod_objcg_state(objcg, pgdat, idx, nr);
-
 	put_obj_stock(flags);
+	if (!nr)
+		return;
+update_vmstat:
+	__mod_objcg_state(objcg, pgdat, idx, nr);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
@@ -3303,12 +3319,19 @@ static void drain_obj_stock(struct obj_stock *stock)
 	/*
 	 * Flush the vmstat data in current stock
 	 */
-	if (stock->vmstat_bytes) {
-		__mod_objcg_state(old, stock->cached_pgdat, stock->vmstat_idx,
-				  stock->vmstat_bytes);
+	if (stock->reclaimable_bytes || stock->unreclaimable_bytes) {
+		int bytes;
+
+		if ((bytes = stock->reclaimable_bytes))
+			__mod_objcg_state(old, stock->cached_pgdat,
+					  NR_SLAB_RECLAIMABLE_B, bytes);
+		if ((bytes = stock->unreclaimable_bytes))
+			__mod_objcg_state(old, stock->cached_pgdat,
+					  NR_SLAB_UNRECLAIMABLE_B, bytes);
+
 		stock->cached_pgdat = NULL;
-		stock->vmstat_bytes = 0;
-		stock->vmstat_idx = 0;
+		stock->reclaimable_bytes = 0;
+		stock->unreclaimable_bytes = 0;
 	}
 
 	obj_cgroup_put(old);
-- 
2.18.1

