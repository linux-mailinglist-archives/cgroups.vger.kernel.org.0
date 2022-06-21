Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C375532BD
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350991AbiFUM7Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 08:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351025AbiFUM6Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 08:58:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C12BDA
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:58:12 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id w24so4650616pjg.5
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIZConLAu+BQmuX/Tvb9zBVZtwEjqQiDdIX8payO2zo=;
        b=Zk51NSDrVMZPvZN3TRE8By5zbzxn4KfxBk7mAPZIGImd6sXrZQTiixROziyC4GK7i2
         tjX3Uc/E0v4rj4SK78xIySUmqwcFv2/QqpusGj+so6BOEcPZY8a1BVGjEQEYoGh7bkkl
         OE/0bXu3mXp+aWvIm0cGBgL12WKiQodj2ZzTuAk2u3eLaReU+cqH1yGlGUUfgMhXcIsa
         pMZ2j0weSC5IJyI7Bg2HlgmEVFzD4vXJM29uR5XzcRBOtii439vkQTRNzX2HOBB+Ru/L
         ngbXnl0WALO2G1k49DSGVvpkOu3AFIwpwC5BwKEXviwXxw5OpAxEnvkkS7Z0wzEZO0oN
         dG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIZConLAu+BQmuX/Tvb9zBVZtwEjqQiDdIX8payO2zo=;
        b=77pQhF4Y5JKOYwXj47kJWAMKJdiIWoWjwmWdZIY/m6a46DYYnfSiJ8hbGnpZ98qoAu
         8txoBco0kjsonvTfy8ucNE5UA2t57B/wlICAoqYS0aY5Ry7va9RkT1BnoVRN5lRhP0hz
         onrDk5vIAkST1ArSzZ6KD/zB4mNnmV32x6PVbMx0ixZXsciePO326wMT6HywwlfsRdSe
         WYR/m9yHQ6HmdIWlKhL01+d5gbmqWx0MTj5OtrjUpI467XMb34DRmrel3Jm4hpo2q1EW
         s1J3vynGkMBR1T5I0ycwZWAkpKkFID3Fbs6dbJEOQ6g/a9jjfhWorDX7NiZnnuPGA7DQ
         qFzQ==
X-Gm-Message-State: AJIora/uKY68AkQA89BCF39/XjgjefWXyQc+NTP4yrWwr/R+XpdKolSr
        f/zo/9+XaTRghG1d1O1eQY8TrQ==
X-Google-Smtp-Source: AGRyM1sfMqtOuqujc10J2sSlGnIc2sn0IXLs0wAthMZegVzDh1Wtv0OMoc9MoJz2Lr6MQuwf390UoQ==
X-Received: by 2002:a17:902:c40c:b0:16a:252c:ec82 with SMTP id k12-20020a170902c40c00b0016a252cec82mr10424049plk.5.1655816291697;
        Tue, 21 Jun 2022 05:58:11 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:58:11 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 06/11] mm: thp: make split queue lock safe when LRU pages are reparented
Date:   Tue, 21 Jun 2022 20:56:53 +0800
Message-Id: <20220621125658.64935-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Similar to the lruvec lock, we use the same approach to make the split
queue lock safe when LRU pages are reparented.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  10 ++++
 mm/huge_memory.c           | 116 +++++++++++++++++++++++++++++++++++----------
 2 files changed, 100 insertions(+), 26 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ff3106eca6f3..026b62b206b1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1691,6 +1691,11 @@ int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
 void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int shrinker_id);
 void reparent_shrinker_deferred(struct mem_cgroup *memcg);
+
+static inline int shrinker_id(struct shrinker *shrinker)
+{
+	return shrinker->id;
+}
 #else
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
@@ -1704,6 +1709,11 @@ static inline void set_shrinker_bit(struct mem_cgroup *memcg,
 				    int nid, int shrinker_id)
 {
 }
+
+static inline int shrinker_id(struct shrinker *shrinker)
+{
+	return -1;
+}
 #endif
 
 #ifdef CONFIG_MEMCG_KMEM
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 66d9ed8a1289..11ec92783b37 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -558,25 +558,90 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_MEMCG
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
+static inline struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
+		struct deferred_split *queue)
 {
-	struct mem_cgroup *memcg = page_memcg(compound_head(page));
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	if (mem_cgroup_disabled())
+		return NULL;
+	if (&NODE_DATA(folio_nid(folio))->deferred_split_queue == queue)
+		return NULL;
+	return container_of(queue, struct mem_cgroup, deferred_split_queue);
+}
 
-	if (memcg)
-		return &memcg->deferred_split_queue;
-	else
-		return &pgdat->deferred_split_queue;
+static inline struct deferred_split *folio_memcg_split_queue(struct folio *folio)
+{
+	struct mem_cgroup *memcg = folio_memcg(folio);
+
+	return memcg ? &memcg->deferred_split_queue : NULL;
 }
 #else
-static inline struct deferred_split *get_deferred_split_queue(struct page *page)
+static inline struct mem_cgroup *folio_split_queue_memcg(struct folio *folio,
+		struct deferred_split *queue)
 {
-	struct pglist_data *pgdat = NODE_DATA(page_to_nid(page));
+	return NULL;
+}
 
-	return &pgdat->deferred_split_queue;
+static inline struct deferred_split *folio_memcg_split_queue(struct folio *folio)
+{
+	return NULL;
 }
 #endif
 
+static struct deferred_split *folio_split_queue(struct folio *folio)
+{
+	struct deferred_split *queue = folio_memcg_split_queue(folio);
+
+	return queue ? : &NODE_DATA(folio_nid(folio))->deferred_split_queue;
+}
+
+static struct deferred_split *folio_split_queue_lock(struct folio *folio)
+{
+	struct deferred_split *queue;
+
+	rcu_read_lock();
+retry:
+	queue = folio_split_queue(folio);
+	spin_lock(&queue->split_queue_lock);
+
+	if (unlikely(folio_split_queue_memcg(folio, queue) != folio_memcg(folio))) {
+		spin_unlock(&queue->split_queue_lock);
+		goto retry;
+	}
+	rcu_read_unlock();
+
+	return queue;
+}
+
+static struct deferred_split *
+folio_split_queue_lock_irqsave(struct folio *folio, unsigned long *flags)
+{
+	struct deferred_split *queue;
+
+	rcu_read_lock();
+retry:
+	queue = folio_split_queue(folio);
+	spin_lock_irqsave(&queue->split_queue_lock, *flags);
+
+	if (unlikely(folio_split_queue_memcg(folio, queue) != folio_memcg(folio))) {
+		spin_unlock_irqrestore(&queue->split_queue_lock, *flags);
+		goto retry;
+	}
+	rcu_read_unlock();
+
+	return queue;
+}
+
+static inline void split_queue_unlock(struct deferred_split *queue)
+{
+	spin_unlock(&queue->split_queue_lock);
+}
+
+static inline void split_queue_unlock_irqrestore(struct deferred_split *queue,
+						 unsigned long flags)
+{
+	spin_unlock_irqrestore(&queue->split_queue_lock, flags);
+}
+
 void prep_transhuge_page(struct page *page)
 {
 	/*
@@ -2600,7 +2665,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct folio *folio = page_folio(page);
 	struct page *head = &folio->page;
-	struct deferred_split *ds_queue = get_deferred_split_queue(head);
+	struct deferred_split *ds_queue;
 	XA_STATE(xas, &head->mapping->i_pages, head->index);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
@@ -2692,13 +2757,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	ds_queue = folio_split_queue_lock(folio);
 	if (page_ref_freeze(head, 1 + extra_pins)) {
 		if (!list_empty(page_deferred_list(head))) {
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 		if (mapping) {
 			int nr = thp_nr_pages(head);
 
@@ -2716,7 +2781,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		__split_huge_page(page, list, end);
 		ret = 0;
 	} else {
-		spin_unlock(&ds_queue->split_queue_lock);
+		split_queue_unlock(ds_queue);
 fail:
 		if (mapping)
 			xas_unlock(&xas);
@@ -2740,25 +2805,23 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 
 void free_transhuge_page(struct page *page)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
+	struct deferred_split *ds_queue;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = folio_split_queue_lock_irqsave(page_folio(page), &flags);
 	if (!list_empty(page_deferred_list(page))) {
 		ds_queue->split_queue_len--;
 		list_del(page_deferred_list(page));
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 	free_compound_page(page);
 }
 
 void deferred_split_huge_page(struct page *page)
 {
-	struct deferred_split *ds_queue = get_deferred_split_queue(page);
-#ifdef CONFIG_MEMCG
-	struct mem_cgroup *memcg = page_memcg(compound_head(page));
-#endif
+	struct deferred_split *ds_queue;
 	unsigned long flags;
+	struct folio *folio = page_folio(page);
 
 	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
 
@@ -2775,18 +2838,19 @@ void deferred_split_huge_page(struct page *page)
 	if (PageSwapCache(page))
 		return;
 
-	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	ds_queue = folio_split_queue_lock_irqsave(folio, &flags);
 	if (list_empty(page_deferred_list(page))) {
+		struct mem_cgroup *memcg;
+
+		memcg = folio_split_queue_memcg(folio, ds_queue);
 		count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 		list_add_tail(page_deferred_list(page), &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
-#ifdef CONFIG_MEMCG
 		if (memcg)
 			set_shrinker_bit(memcg, page_to_nid(page),
-					 deferred_split_shrinker.id);
-#endif
+					 shrinker_id(&deferred_split_shrinker));
 	}
-	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
+	split_queue_unlock_irqrestore(ds_queue, flags);
 }
 
 static unsigned long deferred_split_count(struct shrinker *shrink,
-- 
2.11.0

