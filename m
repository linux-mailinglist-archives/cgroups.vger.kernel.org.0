Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DC778109
	for <lists+cgroups@lfdr.de>; Thu, 10 Aug 2023 21:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjHJTJC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Aug 2023 15:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjHJTJB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Aug 2023 15:09:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD0F90;
        Thu, 10 Aug 2023 12:09:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A3F666A3;
        Thu, 10 Aug 2023 19:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2229BC433C7;
        Thu, 10 Aug 2023 19:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691694540;
        bh=Oi7cQ2Coc+w2eRImA7LKy7Tv7W4x0/pEx/hFmFxWWY4=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=jqUWcBesFjkeEEvNGvxmlBPgNV4l5kJJXzmwfZUtOO2h7Voaq2+KUwxqFgxxHUcIM
         OlX2P3gLDwOE4uwawibqQ1rWZRs6iWRY0qLThpoMY17NXhd6oLQ8A+4nf/sTQCCpYY
         OG/fpZvT7WHqDau8s0CrZT2PpZfG8OAcrHrAF5H96tS8cll2RR75tiRPZFBOtEhhyV
         HwPpB4V8YNIRU9OiKa5JP25ZtWWsAMoqsuqYkvGD4JTKTib4E+7t8EOJ1exYMi3O+3
         XLclUcu42FDLf/MDaZqp7UqYNIlDSJpI986sFQ3D3M0crLBrawi3SCuWZlpIU1A7mx
         lhWja/BCfbIdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id F35CEC001E0;
        Thu, 10 Aug 2023 19:08:59 +0000 (UTC)
From:   Zachary Goldstein via B4 Relay 
        <devnull+zachary.goldstein.concurrent-rt.com@kernel.org>
Date:   Thu, 10 Aug 2023 15:05:34 -0400
Subject: [PATCH RT] mm/memcg: Fix recursive locking on refill_stock() on
 PREEMPT_RT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-memcg-fix-recursive-lock-v1-1-0870815484c6@concurrent-rt.com>
X-B4-Tracking: v=1; b=H4sIAP001WQC/x2NQQ6CMBBFr0Jm7ZgCMYLHMO6Mi3b8QqMUMsWGh
 HB3i8uXl//+ShHqEelSrKRIPvoxZCgPBUlvQwf2z8xUmao2jWl5wCAdv/zCCvlq9An8GeXNEGl
 EHM5tXVOeOxvBTm2Qfg+k07E0rDMHLPPuJ0Wu/K/vdL3RY9t+pvjoHI4AAAA=
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691694539; l=3174;
 i=zachary.goldstein@concurrent-rt.com; s=20230809; h=from:subject:message-id;
 bh=iGCY5O8pU90PvwzpSq10zAF0Xf00Oq3bpeBOxq/cAek=;
 b=0aJq6ecGEBSIY9wfC7XKUKq9WBhQh5kGwH74a64bwReInzEPOAdFARO74YqaxHYeNuO34f2AC
 CjAntrJQVhPBUN9HNANwJ+l3vOvu1T13Y/zZGi+XgFi0NP+BRcVYOjS
X-Developer-Key: i=zachary.goldstein@concurrent-rt.com; a=ed25519;
 pk=GLF18lQ96tRolyWMpDtJzDQ9bi7+1+rMHript5TFdSg=
X-Endpoint-Received: by B4 Relay for zachary.goldstein@concurrent-rt.com/20230809 with auth_id=74
X-Original-From: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
Reply-To: <zachary.goldstein@concurrent-rt.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>

5.10 suffers from the same recursive locking issue that
commit a848d25434de4 ("mm/memcg: Opencode the inner part of
obj_cgroup_uncharge_pages() in drain_obj_stock()") fixes.

Modified description from the commit to reflect this patch changes:

Provide the inner part of refill_stock() as __refill_stock() without
disabling interrupts. This eases the integration of local_lock_t where
recursive locking must be avoided.
Open code __memcg_kmem_uncharge() in drain_obj_stock() and
obj_cgroup_release() and use __refill_stock(). The caller of
drain_obj_stock() and obj_cgroup_release() already disables interrupts.

Signed-off-by: Zachary Goldstein <zachary.goldstein@concurrent-rt.com>
---
 mm/memcontrol.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5dd77e260c25..d61918cc44c1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -260,6 +260,8 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
 #ifdef CONFIG_MEMCG_KMEM
 static DEFINE_SPINLOCK(objcg_lock);
 
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages);
+
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
 	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
@@ -294,8 +296,12 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 
 	spin_lock_irqsave(&objcg_lock, flags);
 	memcg = obj_cgroup_memcg(objcg);
-	if (nr_pages)
-		__memcg_kmem_uncharge(memcg, nr_pages);
+	if (nr_pages) {
+		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+			page_counter_uncharge(&memcg->kmem, nr_pages);
+
+		__refill_stock(memcg, nr_pages);
+	}
 	list_del(&objcg->list);
 	mem_cgroup_put(memcg);
 	spin_unlock_irqrestore(&objcg_lock, flags);
@@ -2319,12 +2325,9 @@ static void drain_local_stock(struct work_struct *dummy)
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
  */
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
-
-	local_lock_irqsave(&memcg_stock.lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (stock->cached != memcg) { /* reset if necessary */
@@ -2336,7 +2339,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
+}
 
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	unsigned long flags;
+
+	local_lock_irqsave(&memcg_stock.lock, flags);
+	__refill_stock(memcg, nr_pages);
 	local_unlock_irqrestore(&memcg_stock.lock, flags);
 }
 
@@ -3179,7 +3189,11 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 				goto retry;
 			rcu_read_unlock();
 
-			__memcg_kmem_uncharge(memcg, nr_pages);
+			if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+				page_counter_uncharge(&memcg->kmem, nr_pages);
+
+			__refill_stock(memcg, nr_pages);
+
 			css_put(&memcg->css);
 		}
 

--
2.39.2

