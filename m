Return-Path: <cgroups+bounces-10391-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8805B9533C
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 11:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686EB483450
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EFC131D373;
	Tue, 23 Sep 2025 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VmOvix5W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471883203BE
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619035; cv=none; b=ZsJ5HKup4+N/rDKcPdR79us1AeMV/TbS+lp3q1lXZP0fZGBkAjOlHLB0XtetunDH3lXQqrV85E8FryMKm61jA2idLErt/lobTpyfqtEQDc+m4HoTA0pU/u5EkLTIjw8bl04YH2MEkVxvLaQNnEjxcY9z7Kp+PLjIxYVJfRt19oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619035; c=relaxed/simple;
	bh=KOXlbh25Gsetgl3GNjGe9VD0ySH162kovB3o+nlpoCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3vsaE/ElZlJPDNuNgfsP+NQvlPc/ww8lRP/qqTm7MOVgfFqfCCRdjGR12RcLDOTw4hQzp8iUqillVe9xovy3wPerUaNDbSztbxajMxIRYgaPVSP3pphjFhkk5rIteIxcT4fXx+lpCIv7j5TaRXoXMhuOiypi1xgnHP1aqDOYdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VmOvix5W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26c209802c0so37234325ad.0
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758619032; x=1759223832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMEpf3Ea3B6J3gmDiquYNV20PPyPPv+3X/VUa2fqYkk=;
        b=VmOvix5WwQ0bzDmNQBJtI0AX1II7E5Izcavu/qt0FOElCZwNnyJxsfRdKVeU1sjj7j
         A2rlQr0kSxvqn34aW0UpJEYxfh6N+y/gybdhV5Tzy1zNRn4hBErHopH+tjgbIhsY/LVf
         4veAJvD/smNLcZi5gjPf9CIMiOgG0+CTHE7n8HdnmYAhv1cOMKNQ6URB0pQAp497x3DQ
         pCq+Dc/jofOXozrznKtluG/u/SqC+y325isPLk9YRO+nRbpITPVtCgOfwuEWGl/5PrFZ
         7nuE5braFtHWhfQlOGH8jJH1LxZWoqfv0Fk+g4u3uhxT73tj5Pxnv/cZwQJzbipNcklb
         DxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619032; x=1759223832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMEpf3Ea3B6J3gmDiquYNV20PPyPPv+3X/VUa2fqYkk=;
        b=foJDAukjKlQVsn6RF8y/DqttTmnrey0VBJ8g2VywXmpPo9CN+HOaRbYyl8P1cNkVda
         8EuKvtiY22GZOWXjRn7DZ7BmZXDKUwo1WUalmr4ga3O8G72GMlhYo1RJCqn2uQqCl0tO
         C/eLFywGaMj7e1zxjyuwMXHFiLhNyGv9XDMR6GEgRQS1/+CRKAQYZJ20NVufQgwoeFnG
         xw0yoK3VldzJ3UbnB93XYPeK8ydmn5ARer3UWsbYL7ONiZ0nJF6zR/dfRIj2782C6cTQ
         a2UWP3FP1fUxoDSu1bH85h5rHSolC1ad98XOUS5c3gxtcOfkc2vStOAB483KZ7bOErzA
         MU+A==
X-Forwarded-Encrypted: i=1; AJvYcCWemxzx+YmnArI7U0xDLsFIgJlXxbQc38gU6gqDszn3udSIE3XAJ7riowqsAQyrREhnhnFqRe6B@vger.kernel.org
X-Gm-Message-State: AOJu0YxDjvLTM/fqxpQJwiQXkQ41sqom1Ve+Mi19vPktQghtknM2DXP4
	fywSsswyRlS/8Em8GWs2hwwMcrdGYLX69xGzV1ivEjMRqe+og0ftL2Qr5a+3qum7sA4=
X-Gm-Gg: ASbGnctagzv/U68hv5lkzn3dA9xc03WIk9BlrFE7WSxf+0MNeYsApBS9zl9Rdogjee1
	KWhmheVzT3+LI0dhSK3fYOlDZn8D6vL7ikKTjTgSxhjbJkC3UM/5ed9/aD3KGyNMMhBx8qOSVal
	6ndeG4NBpPP5YFUGbkd7MckxxHpeAY01jxgoP46CjH0jjYhbtEkk+VIrDa4gmvYRLNWsSk2/BCP
	+JdP04O0kFRTqwYFWZVjlrvtMqHbuQMJqSJZe//433wy05+CDC5f1mwpgtWh/MjbTRPe0QWfhLT
	eBM2ADqRchCaRuTDhPdF8qUZIw69H0nNVajFV6Qpc8TRVXdpwwip+BdecXJrGaiVIEX4CGIfv5a
	Rz1Trra+hO0fxs9ZNQg2SsV1KIOfQOj6SL59CxPdje+Py8sADV2dnyNIDH4AMbbLBQDLTKDQ=
X-Google-Smtp-Source: AGHT+IEjW7nlqMYtk1SjNV/LLbiGjcZcRqySo0SKeu4Hh2+wqVdplupwS9kqc4xr8VvvoRI+XMKetw==
X-Received: by 2002:a17:902:ce01:b0:250:6d0e:1e40 with SMTP id d9443c01a7336-27cc1380e40mr22109715ad.7.1758619032483;
        Tue, 23 Sep 2025 02:17:12 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed26a9993sm18724713a91.11.2025.09.23.02.17.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 02:17:11 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
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
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 3/4] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()
Date: Tue, 23 Sep 2025 17:16:24 +0800
Message-ID: <782da2d3eca63d9bf152c58c6733c4e16b06b740.1758618527.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758618527.git.zhengqi.arch@bytedance.com>
References: <cover.1758618527.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
      this lock protects the local list, not the split queue.

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
---
 mm/huge_memory.c | 84 ++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2f41b8f0d4871..48b51e6230a67 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3781,21 +3781,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		struct lruvec *lruvec;
 		int expected_refs;
 
-		if (folio_order(folio) > 1 &&
-		    !list_empty(&folio->_deferred_list)) {
-			ds_queue->split_queue_len--;
+		if (folio_order(folio) > 1) {
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
 				mod_mthp_stat(folio_order(folio),
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
@@ -4194,40 +4195,44 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	struct pglist_data *pgdata = NODE_DATA(sc->nid);
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 	unsigned long flags;
-	LIST_HEAD(list);
-	struct folio *folio, *next, *prev = NULL;
-	int split = 0, removed = 0;
+	struct folio *folio, *next;
+	int split = 0, i;
+	struct folio_batch fbatch;
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
 		ds_queue = &sc->memcg->deferred_split_queue;
 #endif
 
+	folio_batch_init(&fbatch);
+retry:
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
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
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
-	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
 		bool did_split = false;
 		bool underused = false;
+		struct deferred_split *fqueue;
 
+		folio = fbatch.folios[i];
 		if (!folio_test_partially_mapped(folio)) {
 			/*
 			 * See try_to_map_unused_to_zeropage(): we cannot
@@ -4250,38 +4255,25 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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
+	if (sc->nr_to_scan)
+		goto retry;
 
 	/*
 	 * Stop shrinker if we didn't split any page, but the queue is empty.
-- 
2.20.1


