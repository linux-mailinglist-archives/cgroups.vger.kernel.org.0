Return-Path: <cgroups+bounces-10282-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA7B87D71
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 05:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3855A1B2079A
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 03:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853CF26AAAB;
	Fri, 19 Sep 2025 03:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Atv76PuE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A558726AA91
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758253804; cv=none; b=cd+zVCpYQ4+8x4JcsdNhUM+I4jkhgw5mewFktQbUIGEuvM3poCnpStdS6ex5A40e2rGsXjIfi+mNV21evR3QfbmI4CojD8G7EAfDMGF4uxfAJGkxBY1zY04uk0RMGNS9PbU/VFIDPRdX3hF5WQElA55QiPLCl1EH5OaoBfA0k/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758253804; c=relaxed/simple;
	bh=uFqXaX4786zqLvlI1mUVJQRvKysWf2519E4f/yIziLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWdFVkVSbt0jm5kj8NxAdFPw9IprGAp/WeQinsgLaqU//ck+YYAKem67h00Z4QluoLIeb39dZmFgEbG7xwqvXarojZ+a3hxqRN0B4FrlvdY8DoFUudkOobHMDTrVVdtud0dSfyGwut03rgQyjfl6ZLP/+fhjLmfmq3J/8gxTN28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Atv76PuE; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54c707374fso1157675a12.1
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 20:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758253802; x=1758858602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDYs9OGpSFKUZZGueotNHOqsQDyScZ0e77VVTnkWHNA=;
        b=Atv76PuEY0qf4fYS70v91/sDTuMteu2nk1+3drTEbeoMVR/0V+rvn+nsf1R26EOwIo
         N1dRlcb9c/lhAZ3669UQJAHowY5t/IlrtwyUYz1R8gZnwmDcn+dOe/pJlvzeMsH6ZFfi
         gPoS8ECVPYR8tyJjnt8b/RXfhTw5t5HQE3OcYiaOuEok4FbbXEuyJYBrGIaCndX5cS2y
         FN4bnUKa2JxPRe7XIBLBPosAu9tAg2LLENSzbBXarIzdKQ4SGydZ1qCjXNm6FqxjYzP1
         ASmR5i2gZcbqIG6YAW0hpaLYi22N4IZbR+fxBmL0jg4oBa00IExmaRWUvrGKW2cudyXH
         rWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758253802; x=1758858602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDYs9OGpSFKUZZGueotNHOqsQDyScZ0e77VVTnkWHNA=;
        b=J2hhZRc1ZG2/sej4gCZnq9KsAQo050azLuzRInKbsb+5+1x4Y+wccurVel7+WCj2Ux
         lHN9qW9UMQOqffQkZ2ZYbry8NyIaueuxMcOnxJUeI/fFuVzLqWvg6G1YqBxyGqPURQ3H
         Hwwnpk2Qt3GUQyAcof88zrrN1gKFFTakV8gprzyRClZn6VPPgv2XfnktJPjKWzzI0r4+
         xxlf0UYDpTRgXP9gWGRBd0s2UlBZpuN/upBdzTXb70YgQ8ZKHLCvsf9oEYAk3ovau71P
         ud9sx0srl2l+XdQSsxqhoJ40jDznkNXHK4ZyKCldhhau6tmCWSLuibWDUTMAYjzRc4jJ
         D9Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXKe5FJFPrvSsKBdebVz8f7PXcHH0VnNucQunAR1CjXRzvhmZh/e5A8W/zGUQ8jUkan+gAcDH3i@vger.kernel.org
X-Gm-Message-State: AOJu0YwZPs7MoOXtvVlm//xQF/mRmKa5I911q+KCfXfldbzR+3ZPIOEz
	fkapHotSBf9f8+dYXUCV13IC74eGanr6LuZMKB1BSR8asrzq+f1BbI3X98Iksp8oaWI=
X-Gm-Gg: ASbGncukWzoHTLmt2yv3cL0h25pWKdjjRh72qafM3xUnEzYsYtUKmuLSDMAuMnrkdcd
	Tvxo7jWbFzq+37CI1uwlZdgsbIF4CQpaaEkSKNG0VjPB0XuVh47IFIGyhfexFUl76pjP0MSBDQw
	/AJFgJ6c4sH9UN4z4BIcgtuOUq1LNh0fGQtDEL451Ig0THcO+9m2+e5xBLgH/SivGesTaAhNyLG
	McqZe7PoGHGyHsHd1EaWjODtYkWtKR0Dg70Ar1NtMP6mf5LXa31tX0/HNQ7Blpm+pK726rtP6z8
	uc7bNrLVgDNzEKqmyq62OSjWq1ZFV1chdFQMvpT1qeFbJbFMh0GMLAMaOvoE7XRfr4y6dxQPvQG
	k/1I+7+0WfPFrGJzOFc4/ec+MWuAqICBMPp4gVE6fwODrv+l72BCgjT4CAbPTVMAMtFeqVAA=
X-Google-Smtp-Source: AGHT+IFwsSMJjHL+zbHQOwnU5q2n34Jm6lBoXue7BH/hv8fZoGm3UEzcsPvo+mERmOTWnPv00CgCYw==
X-Received: by 2002:a17:903:6c3:b0:262:661d:eb1d with SMTP id d9443c01a7336-269ba3c2c39mr19723955ad.1.1758253801748;
        Thu, 18 Sep 2025 20:50:01 -0700 (PDT)
Received: from G7HT0H2MK4.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5e9sm39629235ad.72.2025.09.18.20.49.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Sep 2025 20:50:01 -0700 (PDT)
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
Subject: [PATCH 3/4] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()
Date: Fri, 19 Sep 2025 11:46:34 +0800
Message-ID: <3db5da29d767162a006a562963eb52df9ce45a51.1758253018.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1758253018.git.zhengqi.arch@bytedance.com>
References: <cover.1758253018.git.zhengqi.arch@bytedance.com>
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
 mm/huge_memory.c | 88 +++++++++++++++++++++++-------------------------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d34516a22f5bb..ab16da21c94e0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3760,21 +3760,22 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
@@ -4173,40 +4174,48 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	struct pglist_data *pgdata = NODE_DATA(sc->nid);
 	struct deferred_split *ds_queue = &pgdata->deferred_split_queue;
 	unsigned long flags;
-	LIST_HEAD(list);
-	struct folio *folio, *next, *prev = NULL;
-	int split = 0, removed = 0;
+	struct folio *folio, *next;
+	int split = 0, i;
+	struct folio_batch fbatch;
+	bool done;
 
 #ifdef CONFIG_MEMCG
 	if (sc->memcg)
 		ds_queue = &sc->memcg->deferred_split_queue;
 #endif
 
+	folio_batch_init(&fbatch);
+retry:
+	done = true;
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
+		if (folio_batch_space(&fbatch) == 0) {
+			done = false;
+			break;
+		}
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
@@ -4229,38 +4238,25 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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
+	if (!done)
+		goto retry;
 
 	/*
 	 * Stop shrinker if we didn't split any page, but the queue is empty.
-- 
2.20.1


