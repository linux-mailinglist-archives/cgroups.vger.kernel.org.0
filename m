Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0764B8CE5
	for <lists+cgroups@lfdr.de>; Wed, 16 Feb 2022 16:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiBPPva (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Feb 2022 10:51:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbiBPPva (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Feb 2022 10:51:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8E32A797E
        for <cgroups@vger.kernel.org>; Wed, 16 Feb 2022 07:51:17 -0800 (PST)
Date:   Wed, 16 Feb 2022 16:51:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645026675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1k7ZyhkrwAnTT7djWkOayf2s58MsG0568eCkuBiiEs=;
        b=uINZTLNHOLdZb9uEagY9uAFJ7M4ph2dqPfdvUpb5ZuvpIGmNUHKk3w77iCrZO/YH7sm0Pa
        YP2OHtzw7TUYQtPJIq9ar5iAo1rPGlE2Q9dk32ygqlqFDkldwlXjHsPZloPXS+qB07GnXg
        +lAdO37dii6ROI5VktpRZPNvqKvw+bKke4pQByCag2JDvCAEmYpInnvm7+1bK1B3x4Yt+y
        4JQm6l+16CrAJnQksTH+gddDQKHVBa2I56DQOSyBl4CMSAq8WbeDknNXrWjGxIKdRQ6kKo
        wBQlger/qCSk4/WSKhctca4oIK0BvDcoaQDt0Kxd+/09JMHFG9iuhqhxyHJ4Tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645026675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e1k7ZyhkrwAnTT7djWkOayf2s58MsG0568eCkuBiiEs=;
        b=lAkN1dsYtPeGK3nD9OIBCYFLzr5V3ZokYJD8Ls4hmU6JeSL+iNMOLLo91vfZ+Vu4ajU9nT
        OjGyX9Pz0Df1L3DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2 4/4] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <Yg0dctKholvzADYP@linutronix.de>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-5-bigeasy@linutronix.de>
 <YgqB77SaViGRAtgt@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgqB77SaViGRAtgt@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-14 11:23:11 [-0500], Johannes Weiner wrote:
> Hi Sebastian,
Hi Johannes,

> This is a bit dubious in terms of layering. It's an objcg operation,
> but what's "locked" isn't the objcg, it's the underlying stock. That
> function then looks it up again, even though we have it right there.
> 
> You can open-code it and factor out the stock operation instead, and
> it makes things much simpler and clearer.
> 
> I.e. something like this (untested!):

This then:

------>8------

From: Johannes Weiner <hannes@cmpxchg.org>
Date: Wed, 16 Feb 2022 13:25:49 +0100
Subject: [PATCH] mm/memcg: Opencode the inner part of
 obj_cgroup_uncharge_pages() in drain_obj_stock()

Provide the inner part of refill_stock() as __refill_stock() without
disabling interrupts. This eases the integration of local_lock_t where
recursive locking must be avoided.
Open code obj_cgroup_uncharge_pages() in drain_obj_stock() and use
__refill_stock(). The caller of drain_obj_stock() already disables
interrupts.

[bigeasy: Patch body around Johannes' diff ]

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 69130a5fe3d51..f574f2e1cc399 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2227,12 +2227,9 @@ static void drain_local_stock(struct work_struct *dummy)
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
  */
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
-
-	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
@@ -2244,7 +2241,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
+}
 
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__refill_stock(memcg, nr_pages);
 	local_irq_restore(flags);
 }
 
@@ -3151,8 +3155,17 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
-		if (nr_pages)
-			obj_cgroup_uncharge_pages(old, nr_pages);
+		if (nr_pages) {
+			struct mem_cgroup *memcg;
+
+			memcg = get_mem_cgroup_from_objcg(old);
+
+			if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+				page_counter_uncharge(&memcg->kmem, nr_pages);
+			__refill_stock(memcg, nr_pages);
+
+			css_put(&memcg->css);
+		}
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
-- 
2.34.1

