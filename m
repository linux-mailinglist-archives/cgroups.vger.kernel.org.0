Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7261574B
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 03:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKBCE4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Nov 2022 22:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiKBCEp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Nov 2022 22:04:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB53D6397
        for <cgroups@vger.kernel.org>; Tue,  1 Nov 2022 19:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667354631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9awyJRy6zbIYnxU2Cyp8GDi5vivjY8I9wO3N/Lj5YCI=;
        b=FRgrnSxEw6MrXo8g7bVS2LwGLrnJ/DyTJ6aDxu52eO3jWNDdp75fa+yu8ZL3P+m1w9CZpy
        dbE8JoyWEcsN+OeM6DQjn6rAMJT7f9obDeka0Zm4eHx4UzWMSXwXq7uMJeI14JgVSBhrXZ
        OUGRv4w3Ih4I9vbH7D0ob5E4t7BHnuY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-v4Eht0C3PQaQOIw8U9kArw-1; Tue, 01 Nov 2022 22:03:49 -0400
X-MC-Unique: v4Eht0C3PQaQOIw8U9kArw-1
Received: by mail-ot1-f72.google.com with SMTP id ck9-20020a056830648900b0066c56ff7b33so3593265otb.20
        for <cgroups@vger.kernel.org>; Tue, 01 Nov 2022 19:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9awyJRy6zbIYnxU2Cyp8GDi5vivjY8I9wO3N/Lj5YCI=;
        b=hwSI/bx/B6RUsqA8iH8ET1rkSV5RD3uC9OE+ZVmZ1xx1iPO5fyHL/4A4jMHKJKLtlb
         D0+3SRsPN0Mz/5hEcIDh5rDX2X6oNe4ZqHOdllgM7cdDkfTzn3C3HYoz2yvuOspPZ61X
         B5HRmzCA1Bt5Yrj/aYsyIxTgbAlpHJsoKlikR2mtMaK/eSISWtLlZmL6uL+Ks+YkfBBl
         Ti7XGq78XtS8Mhs7Hmco+fHWOtRgVWR6cqsT0qchOSdMfcixNsb5zYVqI0YIijj3jHji
         VBy2+3yVjqhZB5MDIDXhvu0xQALFEeju0LqlF1QIkRjvsXs0lwfxasFA5XfK7BTkL4la
         T3HQ==
X-Gm-Message-State: ACrzQf1IwXrTcjbHLO1GbkOjPMU0HuA715jX77ivzn2cZqhEJaYo/+9o
        H0itzkF902dWHNy9Yhu89t28pUUuEePjatOms+Hu9erTLxsA803TJdCxzigyZvJTZd42kKb3qcF
        flcB1pgLmsEE+bXXe0Q==
X-Received: by 2002:a05:6871:58b:b0:13c:be46:a02 with SMTP id u11-20020a056871058b00b0013cbe460a02mr11636085oan.8.1667354629096;
        Tue, 01 Nov 2022 19:03:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ltoJltHI6Z/nEB+eev0WW7uJWB140pg3Bn+RcqlseVCQsPXYU6LZG5IjvE4MMVOkxV19MIA==
X-Received: by 2002:a05:6871:58b:b0:13c:be46:a02 with SMTP id u11-20020a056871058b00b0013cbe460a02mr11636072oan.8.1667354628892;
        Tue, 01 Nov 2022 19:03:48 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a802:1099:7cb2:3a49:6197:5307])
        by smtp.gmail.com with ESMTPSA id h15-20020a9d6f8f000000b00665919f7823sm4526624otq.8.2022.11.01.19.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 19:03:48 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Leonardo Bras <leobras@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 2/3] mm/memcontrol: Change stock_lock type from local_lock_t to spinlock_t
Date:   Tue,  1 Nov 2022 23:02:42 -0300
Message-Id: <20221102020243.522358-3-leobras@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102020243.522358-1-leobras@redhat.com>
References: <20221102020243.522358-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In this context, since it's using per-cpu variables, changing from
local_lock to spinlock should not deal much impact in performance and can
allow operations such as stock draining to happen in remote cpus.

Why performance would probably not get impacted:
1 - Since the lock is in the same cache line as the information that is
    used next, there is no extra memory access for caching the lock.
2 - Since it's a percpu struct, there should be no other cpu sharing this
    cacheline, so there is no need for cacheline invalidation, and writing
    to the lock should be as fast as the next struct members.
3 - Even the write in (2) could be pipelined and batched with following
    writes to the cacheline (such as nr_pages member), further decreasing
    the impact of this change.

Suggested-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 mm/memcontrol.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8549ae1b300..add46da2e6df1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2167,7 +2167,7 @@ void unlock_page_memcg(struct page *page)
 }
 
 struct memcg_stock_pcp {
-	local_lock_t stock_lock;
+	spinlock_t stock_lock; /* Protects the percpu struct */
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
 
@@ -2184,7 +2184,7 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+	.stock_lock = __SPIN_LOCK_UNLOCKED(stock_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
@@ -2229,15 +2229,15 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
+
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
 		stock->nr_pages -= nr_pages;
 		ret = true;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 
 	return ret;
 }
@@ -2274,14 +2274,14 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
+
 	old = drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 }
@@ -2309,10 +2309,12 @@ static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
+	struct memcg_stock_pcp *stock;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
 	__refill_stock(memcg, nr_pages);
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 }
 
 /*
@@ -3157,8 +3159,8 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	unsigned long flags;
 	int *bytes;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
 
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
@@ -3210,7 +3212,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 }
@@ -3221,15 +3223,15 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
+
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 
 	return ret;
 }
@@ -3319,9 +3321,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
-
 	stock = this_cpu_ptr(&memcg_stock);
+	spin_lock_irqsave(&stock->stock_lock, flags);
+
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
 		old = drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
@@ -3337,7 +3339,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	spin_unlock_irqrestore(&stock->stock_lock, flags);
 	if (old)
 		obj_cgroup_put(old);
 
-- 
2.38.1

