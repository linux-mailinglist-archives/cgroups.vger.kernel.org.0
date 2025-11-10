Return-Path: <cgroups+bounces-11714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A7C4558C
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 09:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 562E34E91C3
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB862F7ACA;
	Mon, 10 Nov 2025 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OdYJSjJS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79F32F5496
	for <cgroups@vger.kernel.org>; Mon, 10 Nov 2025 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762762767; cv=none; b=GjO+DZt+jCw+MeG93UGy7aNaLOWCexbFyfQeqwz/V4kwlgS/kOzvrcOMTWOHg3mQli66IRafHTR5OjZWS88I9RXB5r/VELG7R0c/XrZRUxs3s1O/bHz0+DeX2aH0C3Nn7Fq3weDeRnv/n4Wp9b5QPYz7E6bUMFhhY22NdNI1vzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762762767; c=relaxed/simple;
	bh=+fJmmTJGWtbKly2kNs7vuuon15ChqOOB9dU6vcLwI6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCd1jQQzV52icfRPp1JIIbZ2e8QTSlm/jLLfJh6eYCW+nEdpqWzuGw1x2xwT/uK45dW2zkK8g7gj/CRMytLNI5cv4mLn3W/o1WozPq++m/1FBUppgrjPiPbkCjW17hq2EPp7Fv30CDtFhdHaojxmF07zo/1Fb5ZZ1tYjuMYHm9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OdYJSjJS; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762762761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcH5FRh2OgNOiAA5XZ85DFKUDIXRNw+gAWgPnqyqYP4=;
	b=OdYJSjJSJdjBoyYkava6ac8Gy+FB90GioWBEWKbzkcWNozB5qkOZZPF/jVTVGcQCKsmE/T
	Boit6jYQ7m5eROKfG7JnIXra5LCXxCXeilTWneeY9HFrzUX9ouHRy3DXLQuJiPeEI6yUwR
	j6Eiznh1aF6jCuHAtVgsCyGNs9Ew7ps=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	akpm@linux-foundation.org,
	richard.weiyang@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v6 3/4] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()
Date: Mon, 10 Nov 2025 16:17:57 +0800
Message-ID: <59cb6b6fb5ffcff9d23b81890b252960139ad8e7.1762762324.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1762762324.git.zhengqi.arch@bytedance.com>
References: <cover.1762762324.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

The maintenance of the folio->_deferred_list is intricate because it's
reused in a local list.

Here are some peculiarities:

   1) When a folio is removed from its split queue and added to a local
      on-stack list in deferred_split_scan(), the ->split_queue_len isn't
      updated, leading to an inconsistency between it and the actual
      number of folios in the split queue.

   2) When the folio is split via split_folio() later, it's removed from
      the local list while holding the split queue lock. At this time,
      the lock is not needed as it is not protecting anything.

   3) To handle the race condition with a third-party freeing or migrating
      the preceding folio, we must ensure there's always one safe (with
      raised refcount) folio before by delaying its folio_put(). More
      details can be found in commit e66f3185fa04 ("mm/thp: fix deferred
      split queue not partially_mapped"). It's rather tricky.

We can use the folio_batch infrastructure to handle this clearly. In this
case, ->split_queue_len will be consistent with the real number of folios
in the split queue. If list_empty(&folio->_deferred_list) returns false,
it's clear the folio must be in its split queue (not in a local list
anymore).

In the future, we will reparent LRU folios during memcg offline to
eliminate dying memory cgroups, which requires reparenting the split queue
to its parent first. So this patch prepares for using
folio_split_queue_lock_irqsave() as the memcg may change then.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 mm/huge_memory.c | 87 +++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 46 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 858f896ef3bf3..db03853a73e3f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3901,21 +3901,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		struct lruvec *lruvec;
 		int expected_refs;
 
-		if (old_order > 1 &&
-		    !list_empty(&folio->_deferred_list)) {
-			ds_queue->split_queue_len--;
+		if (old_order > 1) {
+			if (!list_empty(&folio->_deferred_list)) {
+				ds_queue->split_queue_len--;
+				/*
+				 * Reinitialize page_deferred_list after removing the
+				 * page from the split_queue, otherwise a subsequent
+				 * split will see list corruption when checking the
+				 * page_deferred_list.
+				 */
+				list_del_init(&folio->_deferred_list);
+			}
 			if (folio_test_partially_mapped(folio)) {
 				folio_clear_partially_mapped(folio);
 				mod_mthp_stat(old_order,
 					MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			}
-			/*
-			 * Reinitialize page_deferred_list after removing the
-			 * page from the split_queue, otherwise a subsequent
-			 * split will see list corruption when checking the
-			 * page_deferred_list.
-			 */
-			list_del_init(&folio->_deferred_list);
 		}
 		split_queue_unlock(ds_queue);
 		if (mapping) {
@@ -4314,35 +4315,40 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 {
 	struct deferred_split *ds_queue;
 	unsigned long flags;
-	LIST_HEAD(list);
-	struct folio *folio, *next, *prev = NULL;
-	int split = 0, removed = 0;
+	struct folio *folio, *next;
+	int split = 0, i;
+	struct folio_batch fbatch;
 
+	folio_batch_init(&fbatch);
+
+retry:
 	ds_queue = split_queue_lock_irqsave(sc->nid, sc->memcg, &flags);
 	/* Take pin on all head pages to avoid freeing them under us */
 	list_for_each_entry_safe(folio, next, &ds_queue->split_queue,
 							_deferred_list) {
 		if (folio_try_get(folio)) {
-			list_move(&folio->_deferred_list, &list);
-		} else {
+			folio_batch_add(&fbatch, folio);
+		} else if (folio_test_partially_mapped(folio)) {
 			/* We lost race with folio_put() */
-			if (folio_test_partially_mapped(folio)) {
-				folio_clear_partially_mapped(folio);
-				mod_mthp_stat(folio_order(folio),
-					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
-			}
-			list_del_init(&folio->_deferred_list);
-			ds_queue->split_queue_len--;
+			folio_clear_partially_mapped(folio);
+			mod_mthp_stat(folio_order(folio),
+				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 		}
+		list_del_init(&folio->_deferred_list);
+		ds_queue->split_queue_len--;
 		if (!--sc->nr_to_scan)
 			break;
+		if (!folio_batch_space(&fbatch))
+			break;
 	}
 	split_queue_unlock_irqrestore(ds_queue, flags);
 
-	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
 		bool did_split = false;
 		bool underused = false;
+		struct deferred_split *fqueue;
 
+		folio = fbatch.folios[i];
 		if (!folio_test_partially_mapped(folio)) {
 			/*
 			 * See try_to_map_unused_to_zeropage(): we cannot
@@ -4365,38 +4371,27 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		}
 		folio_unlock(folio);
 next:
+		if (did_split || !folio_test_partially_mapped(folio))
+			continue;
 		/*
-		 * split_folio() removes folio from list on success.
 		 * Only add back to the queue if folio is partially mapped.
 		 * If thp_underused returns false, or if split_folio fails
 		 * in the case it was underused, then consider it used and
 		 * don't add it back to split_queue.
 		 */
-		if (did_split) {
-			; /* folio already removed from list */
-		} else if (!folio_test_partially_mapped(folio)) {
-			list_del_init(&folio->_deferred_list);
-			removed++;
-		} else {
-			/*
-			 * That unlocked list_del_init() above would be unsafe,
-			 * unless its folio is separated from any earlier folios
-			 * left on the list (which may be concurrently unqueued)
-			 * by one safe folio with refcount still raised.
-			 */
-			swap(folio, prev);
+		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
+		if (list_empty(&folio->_deferred_list)) {
+			list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
+			fqueue->split_queue_len++;
 		}
-		if (folio)
-			folio_put(folio);
+		split_queue_unlock_irqrestore(fqueue, flags);
 	}
+	folios_put(&fbatch);
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-	list_splice_tail(&list, &ds_queue->split_queue);
-	ds_queue->split_queue_len -= removed;
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
-
-	if (prev)
-		folio_put(prev);
+	if (sc->nr_to_scan && !list_empty(&ds_queue->split_queue)) {
+		cond_resched();
+		goto retry;
+	}
 
 	/*
 	 * Stop shrinker if we didn't split any page, but the queue is empty.
-- 
2.20.1


