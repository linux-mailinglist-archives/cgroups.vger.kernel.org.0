Return-Path: <cgroups+bounces-7553-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 529D0A89213
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 04:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7AA163EF7
	for <lists+cgroups@lfdr.de>; Tue, 15 Apr 2025 02:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65351221DB3;
	Tue, 15 Apr 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OMZsgufo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F0214A7A
	for <cgroups@vger.kernel.org>; Tue, 15 Apr 2025 02:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685196; cv=none; b=V7kttgss3c3CyIpSPDdrhKLexSmAW2xeZpvPRDeIWmWHQWqdT12ie50E52X1v4h/Ca51z/INuumPh6XIG63OPBBBwIBAwP+x5rFr373kh9pleaBseSQupTVEUQtPatl3hzAtt9uTR3bsD3udkm6knkKUYovBAPfkIOLhsAZ2y0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685196; c=relaxed/simple;
	bh=84sEftSYIXbatP8ktiNMwP5R5mvWYXBwXyaqvwHswlo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W6ZjeoS5JVYk+LCDbC10xBrIPXHgP+kGaYgxlR962ACMpLuCCdIhBzIses16EpD5jth52IbW1xT+TvmFD8khVlHvFpIaKn2Bl4EV3zVSYys+7xCK+hQy7TyxAnUO82tsGhBVDTwJpzhPQOgHM394FxrfOioZgvcQU92hChJRoOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OMZsgufo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-227aaa82fafso39526205ad.2
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 19:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1744685193; x=1745289993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8vA4hA6IVI4psjQZDVnpF3qlQM7CohLDDJ5h+RUQ50=;
        b=OMZsgufow1ebs6FLwZbHco8mCG+Z/vxDvHw0KkvQ3xivgPSthk+CN5l9KHYZ7XZiZl
         8R+p6fs7nxU8PVB7EKILd01yWYrBFb68n4BENYPDMTaecjExbkITfQ/XJnF+qVU6DuaA
         M9KzQmKibOvJImTZbQhxr0DkElSQjAOaizZQtFPKAKMleloGYmSMDV1EojFHuA0usGeA
         qQXQ5to4ik4KXD6DhQvhEGewtkkGQLD8eh8ET9eX07c0q0xXOzBYMxQRrMtzCzNI7O60
         1KSBrnNuioqwFfTvt6lxuFc7qkeQUtfH6KeBZQT16P9nDRNO688RVYvYs+YMjozHO/Hs
         RjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744685193; x=1745289993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8vA4hA6IVI4psjQZDVnpF3qlQM7CohLDDJ5h+RUQ50=;
        b=uzwhhwEjmFdpCVTDptGCs6BB0gRtffCDX2QqYIQfDTx/Xz1C15OgjDP7aLd2SLcDMS
         zwIGMSOhP3PWcOMWKmKdyBcREPeZZCQQpl/Wi0kSOAGT48sZazoWgVwpoonT73A73nXu
         5easqD8UB6jJfZFgVyGz9vJS5icjvDHvMQFq+enpyk3gr234BJFsq1xlH7kEo0ZRTZ2A
         74LaDxI7P9CVGEShtZdEGJzhG2jKJJTXHz/4/EBErYGe4pq3bQTJ0vQ3wNZsvo3BlATc
         hIG7OJ3aKUwXg0KamMwU7GmVcRJfi+gjX+Da1XXRyvk1x3xBIQ9ypfTpWcAV8xdBcsKI
         Z2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWB8GCuSZyIN889KSEcJXEFa+KMKum6rLOpBBQ8Ah7zR89ehFRgw7lM3Ow80z3Nm+Wb1ii843Vk@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbqqNOvnVymej+Xw7koX3eGTnG/KSqtBVksMKWSJW/O47tlVd
	qHDmwzWqtGy2CDreOm29FplscCAGuUzEsJ9vlYiVNJm/5s85yMs+1VvSGAg0ipQ=
X-Gm-Gg: ASbGncvq97Q6PQobO1MGS3D1xdIMuu9qL04jHjYsBW7dILIg1yLbjcI1s8AbTuP5Ogf
	8VmqueySpAS7WITg38gGmMgHi6rB0cgEt/awoZfjE/JjbrWwEjVJcpXIN3GtW/mbKMMWo0+Nj1I
	uEOZoLMp3CLwYW+YeHCIt7MUdSoYPM8VPEEOH0Ye/1eHao3ZR+iKZsvjduc3m6v/78u7RKscDr8
	rKuHS9sAejei3ihHkZgFV/JChns6oAtSx/2/vFiyZTdzl7XO0lwiJhWz7hC6KVxRQ+ONcQ8q3HL
	ahkJTQSsvZD2jCzBfFDFevVlidPkRcM/5/kGGXbqmGJCRItrOwfiTN9bhvaGgamVxsZXgztt
X-Google-Smtp-Source: AGHT+IGN/ZCUfpQSbaBS4W8bBOfntfSIoehjtu5uWTeww1FUk2wFfobrLS/nbSO2R96mT1mo6Vfdog==
X-Received: by 2002:a17:902:e552:b0:223:66bc:f1de with SMTP id d9443c01a7336-22bea4afc0fmr177104965ad.21.1744685192967;
        Mon, 14 Apr 2025 19:46:32 -0700 (PDT)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccac49sm106681185ad.217.2025.04.14.19.46.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Apr 2025 19:46:32 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	david@fromorbit.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RFC 07/28] mm: thp: use folio_batch to handle THP splitting in deferred_split_scan()
Date: Tue, 15 Apr 2025 10:45:11 +0800
Message-Id: <20250415024532.26632-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250415024532.26632-1-songmuchun@bytedance.com>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
      details can be found in commit e66f3185fa04. It's rather tricky.

We can use the folio_batch infrastructure to handle this clearly. In this
case, ->split_queue_len will be consistent with the real number of folios
in the split queue. If list_empty(&folio->_deferred_list) returns false,
it's clear the folio must be in its split queue (not in a local list
anymore).

In the future, we aim to reparent LRU folios during memcg offline to
eliminate dying memory cgroups. This patch prepares for using
folio_split_queue_lock_irqsave() as folio memcg may change then.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 69 +++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 39 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 70820fa75c1f..d2bc943a40e8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4220,40 +4220,47 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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
-
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
 	split_queue_unlock_irqrestore(ds_queue, flags);
 
-	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
 		bool did_split = false;
 		bool underused = false;
+		struct deferred_split *fqueue;
 
+		folio = fbatch.folios[i];
 		if (!folio_test_partially_mapped(folio)) {
 			underused = thp_underused(folio);
 			if (!underused)
@@ -4269,39 +4276,23 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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
-		}
-		if (folio)
-			folio_put(folio);
+		fqueue = folio_split_queue_lock_irqsave(folio, &flags);
+		list_add_tail(&folio->_deferred_list, &fqueue->split_queue);
+		fqueue->split_queue_len++;
+		split_queue_unlock_irqrestore(fqueue, flags);
 	}
+	folios_put(&fbatch);
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-	list_splice_tail(&list, &ds_queue->split_queue);
-	ds_queue->split_queue_len -= removed;
-	split_queue_unlock_irqrestore(ds_queue, flags);
-
-	if (prev)
-		folio_put(prev);
-
+	if (!done)
+		goto retry;
 	/*
 	 * Stop shrinker if we didn't split any page, but the queue is empty.
 	 * This can happen if pages were freed under us.
-- 
2.20.1


