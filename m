Return-Path: <cgroups+bounces-10482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231C0BA6FC3
	for <lists+cgroups@lfdr.de>; Sun, 28 Sep 2025 13:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C78A7A2A95
	for <lists+cgroups@lfdr.de>; Sun, 28 Sep 2025 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298182DD5F3;
	Sun, 28 Sep 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CjEPIszI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393472DAFAB
	for <cgroups@vger.kernel.org>; Sun, 28 Sep 2025 11:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759058275; cv=none; b=NMN2P1lNtvRbYL0wusTxdfoeAM+Uri4mdOyigubm6sHV6zDiUeCqmUOxgDcJQ/T5pDQAlVy1tac+5s57nb41xe9sH/QGHgVtZHJKXTC4NPnj1iFNYQMbUxQG5tVZBJ7jN2TiwBOj0RdZL4FsHDIKExllNqJAJ6R2jvwrOGOrfnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759058275; c=relaxed/simple;
	bh=VNY5dirm+uEkDQXaxi1k9ptTWRpaYGc8tLEYF2RFCkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgIfXo20ooMuwUHvqLIJHilh7j3X9D166I4UWmvA+GpkRt8NAQbkS2ql0sJ/oM0KbY8MFdkHH7uCK6kSB0yntjt2s4kTABJEg67GQtKR3xFZApNGg50uB6QXVJ+9kW+BzAY6ftZw8bdp80jHPoisKXxmMjq1QGNhOxwxW2hCJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CjEPIszI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78127433a32so892525b3a.1
        for <cgroups@vger.kernel.org>; Sun, 28 Sep 2025 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759058273; x=1759663073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REKRs8CKWU4LVKPgGJm+MTqNzgJQGfW7CB6Vx4pkWZs=;
        b=CjEPIszIw+UbzIBw37vAWtPqgiqsLfXfQy4trdpm7+waIbvB2PikyBV46mU1PFkpFc
         pZNTQalUXfg6pJqtbspwPlKG6X0H3+QfHWCtH2SH5Ed/w++h3xXaeT2Vb67tTIFJjqem
         kPgPAS1d/nFzce6lydk2QZ6hs+PB+L8xewXb46YoxrPjrqm+yUTkXmwpb23xi0mc5TaR
         N9cwmYJToLsbxtajcWaIDGMBufLxG/0Q7Lqr5c5qrdFjLPALnXhFbt9VJYQ0X2EUMWNS
         G17llpKG9j3gcDXZiziHkRrvFGFN8ADSEifdQY/AUGyxqVsNQxn1XugvOSheqbO1M0yE
         Z6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759058273; x=1759663073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REKRs8CKWU4LVKPgGJm+MTqNzgJQGfW7CB6Vx4pkWZs=;
        b=jt8rok1sCfw41PDPUSgUNTNnTyEY25L7kbN+joN8EefjEQ6CpXw1fSN4RnRe76DVKz
         vZzIaj2mejwS58Mc7wL5abELPPD3nGbxr0wGM8XossTJ5pCRCGClRIBcwI4p9a/Plh6d
         r8v/Ye6/XWs4ZGUWg1cel75EqtLoHEtLckLzUiUWOxDOw20KyP3gBX1Bbf+4U6PjmxHV
         RqjMZhN295i/UJJLfvXE/3GeIQ15i5m1M7hR0NNv5k/AYTa+qmZWpP+g4Is1zoplv+zm
         czQMcB4WevGddMJu5PFwMF1a1avjqqNiQvfWWGAOy6XvrZWWxNRRA4mQnZ7Y/UD5et8H
         jdoA==
X-Forwarded-Encrypted: i=1; AJvYcCVEGPQe3Q8y8665dg6OO93cTEJmIAk7o0Y1AICQ8eIeYYa5SgxvbW03a06UgrwhnpDRTcE/+aXk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WHV2CBf2pCGnXdcZvoTUcCVKDWeQYhuhfBJF6HMQFhbumjRG
	ocoea22uSdpwhfSWF/nKxMwxL2eKRwQyZULdTFGBv7wwgDw71sIv9sLvLadEb9dmn88=
X-Gm-Gg: ASbGncvj1M9Cdj8lbKX+uq/ZI5UafrbcshSSxShYlN7+2KaZe8cH+Cy0Kc0vAoayQX8
	GIXJsVGcda8XdrQIcFj6lXHMk7KkazZfPzL3BfQRwCzWr7I/pla6VXv2277Kxv/YlpjLL2B8pUJ
	F2jROqPpLgTB1CbQtyDu8HiZYRyppYNY0EOhoWVor/jTamFFMzlB6dS0hhPOPUHkL/wq3O1NUoN
	qftUpUSvEfjnBoZIW54WiqMoR2enhYHN9ZGFscLg/YphT2z9nvYWuX3dlPTUAODL+Gd0qRqZi3j
	O47SDYp46sSnav+o3WDjx2o0Yu5D72XuGNhiNcYbOobgAWBSJRZBicbmiG1Y40fJHFVG86IzQsT
	7SaI2VimLBRK5CiqS9d3DnF2+tGaMeelGPgaNIP6J4UjJ4Ioie40qeS94zk52EiSyO6Xkd6qPC0
	XG
X-Google-Smtp-Source: AGHT+IGIIdlp+3ne4RMEMjmjf/O27EuwNrQ4psGtAD9bT7M8UEYwxZbaO2h7CkCYrbpbiJHcop3BUQ==
X-Received: by 2002:a05:6a20:734e:b0:2ca:1b5:9d4d with SMTP id adf61e73a8af0-2e7bf478afcmr17761831637.2.1759058273370;
        Sun, 28 Sep 2025 04:17:53 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a2c45sm8687451a12.45.2025.09.28.04.17.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 04:17:52 -0700 (PDT)
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
Subject: [PATCH v3 3/4] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()
Date: Sun, 28 Sep 2025 19:17:01 +0800
Message-ID: <43dc58065a4905cdcc02b3e755f3fa9d3fec350b.1759056506.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1759056506.git.zhengqi.arch@bytedance.com>
References: <cover.1759056506.git.zhengqi.arch@bytedance.com>
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
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 84 ++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 46 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0ac3b97177b7f..bb32091e3133e 100644
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
@@ -4185,40 +4186,44 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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
@@ -4241,38 +4246,25 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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


