Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028401DB72E
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 16:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgETOhP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 10:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETOhO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 10:37:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D63CC061A0E
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 07:37:14 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s3so4085569eji.6
        for <cgroups@vger.kernel.org>; Wed, 20 May 2020 07:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=k9a4yj0MuIquiuHcgLAuITw21En7MJN+VIITP5CpbD4=;
        b=I+Q6F55Hv3hJbZ274sPb2I5KbpzXe2i29v/p+ck+988HySt5+6rJ3ADVXWWXkkAi0Y
         7IC/Lfq0M9titHf/akcKXX3zsJ/TKYVDJVT196lf10ijRoYQN7cnGSWWvkfIXnXVVfAj
         LDzPef6T7ZoMTtBUVPREtCsYhez7+WUwBHlcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=k9a4yj0MuIquiuHcgLAuITw21En7MJN+VIITP5CpbD4=;
        b=F/INOuke7fEWDnjDC3gg0MKiWGgZ4c6cEpztilYejOeaZqYA3V66TGn36jEQR52ero
         fsElhtagByPNdCqiJSKeeyatZ6neLBu2gN76TbiABZaOcDREZZa8WKueAeTNo+/2y7q0
         2xb0EEN5LEOBbDlM0HDbqnxZqgmKzdm/WGfe0e6SUH5P3HglayJyP2JXHALRM1ZQki1F
         uZAYANolEs3mn8080zg1gRr41te4PbB0qzfuiQYrZAMq5Jbfj+5J1JNO+6hbK+faazTG
         PC9uqtz1G5oZmTkasyEojyj7IJreiZgK3W9g4kOO+oOg+IoYpWOro1k6CzEyrEv9G6NR
         fLsw==
X-Gm-Message-State: AOAM5313k/rQyDRKH1ag+zIzhy3pvMRFKs/5zihWWmT5oEcwZ+Wa8wiN
        vS56GsYw/SzcvXg/FDvoRV3LuQ==
X-Google-Smtp-Source: ABdhPJzxIHGgH9nM6vQEvQqzcIrfRNGFqaqKcb9nqpgf8jN7KzaQ9t8o4DHx4z91ww3+I5uqZxSYGw==
X-Received: by 2002:a17:906:f103:: with SMTP id gv3mr3868508ejb.226.1589985432937;
        Wed, 20 May 2020 07:37:12 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:758d])
        by smtp.gmail.com with ESMTPSA id s20sm2060359eju.96.2020.05.20.07.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 07:37:12 -0700 (PDT)
Date:   Wed, 20 May 2020 15:37:12 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm, memcg: reclaim more aggressively before high allocator
 throttling
Message-ID: <20200520143712.GA749486@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In Facebook production, we've seen cases where cgroups have been put
into allocator throttling even when they appear to have a lot of slack
file caches which should be trivially reclaimable.

Looking more closely, the problem is that we only try a single cgroup
reclaim walk for each return to usermode before calculating whether or
not we should throttle. This single attempt doesn't produce enough
pressure to shrink for cgroups with a rapidly growing amount of file
caches prior to entering allocator throttling.

As an example, we see that threads in an affected cgroup are stuck in
allocator throttling:

    # for i in $(cat cgroup.threads); do
    >     grep over_high "/proc/$i/stack"
    > done
    [<0>] mem_cgroup_handle_over_high+0x10b/0x150
    [<0>] mem_cgroup_handle_over_high+0x10b/0x150
    [<0>] mem_cgroup_handle_over_high+0x10b/0x150

...however, there is no I/O pressure reported by PSI, despite a lot of
slack file pages:

    # cat memory.pressure
    some avg10=78.50 avg60=84.99 avg300=84.53 total=5702440903
    full avg10=78.50 avg60=84.99 avg300=84.53 total=5702116959
    # cat io.pressure
    some avg10=0.00 avg60=0.00 avg300=0.00 total=78051391
    full avg10=0.00 avg60=0.00 avg300=0.00 total=78049640
    # grep _file memory.stat
    inactive_file 1370939392
    active_file 661635072

This patch changes the behaviour to retry reclaim either until the
current task goes below the 10ms grace period, or we are making no
reclaim progress at all. In the latter case, we enter reclaim throttling
as before.

To a user, there's no intuitive reason for the reclaim behaviour to
differ from hitting memory.high as part of a new allocation, as opposed
to hitting memory.high because someone lowered its value. As such this
also brings an added benefit: it unifies the reclaim behaviour between
the two.

There's precedent for this behaviour: we already do reclaim retries when
writing to memory.{high,max}, in max reclaim, and in the page allocator
itself.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
---
 mm/memcontrol.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2df9510b7d64..b040951ccd6b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -73,6 +73,7 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
 
+/* The number of times we should retry reclaim failures before giving up. */
 #define MEM_CGROUP_RECLAIM_RETRIES	5
 
 /* Socket memory accounting disabled? */
@@ -2228,17 +2229,22 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
-static void reclaim_high(struct mem_cgroup *memcg,
-			 unsigned int nr_pages,
-			 gfp_t gfp_mask)
+static unsigned long reclaim_high(struct mem_cgroup *memcg,
+				  unsigned int nr_pages,
+				  gfp_t gfp_mask)
 {
+	unsigned long nr_reclaimed = 0;
+
 	do {
 		if (page_counter_read(&memcg->memory) <= READ_ONCE(memcg->high))
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
-		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
+		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
+							     gfp_mask, true);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
+
+	return nr_reclaimed;
 }
 
 static void high_work_func(struct work_struct *work)
@@ -2378,16 +2384,20 @@ void mem_cgroup_handle_over_high(void)
 {
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
+	unsigned long nr_reclaimed;
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
+	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
 	struct mem_cgroup *memcg;
 
 	if (likely(!nr_pages))
 		return;
 
 	memcg = get_mem_cgroup_from_mm(current->mm);
-	reclaim_high(memcg, nr_pages, GFP_KERNEL);
 	current->memcg_nr_pages_over_high = 0;
 
+retry_reclaim:
+	nr_reclaimed = reclaim_high(memcg, nr_pages, GFP_KERNEL);
+
 	/*
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
 	 * allocators proactively to slow down excessive growth.
@@ -2403,6 +2413,14 @@ void mem_cgroup_handle_over_high(void)
 	if (penalty_jiffies <= HZ / 100)
 		goto out;
 
+	/*
+	 * If reclaim is making forward progress but we're still over
+	 * memory.high, we want to encourage that rather than doing allocator
+	 * throttling.
+	 */
+	if (nr_reclaimed || nr_retries--)
+		goto retry_reclaim;
+
 	/*
 	 * If we exit early, we're guaranteed to die (since
 	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
-- 
2.26.2

