Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458BE21D525
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2020 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgGMLmh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jul 2020 07:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgGMLmh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jul 2020 07:42:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34986C061755
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:42:37 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so16671937ejb.2
        for <cgroups@vger.kernel.org>; Mon, 13 Jul 2020 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=asIUMaHIscmVUOt9O3PjjLWYy2UNKC6B4ByL+UWtDFY=;
        b=e1FeX0GR+KD623Ybe45d+HmtHhrVBq/5lHLV88DeXVo5dTMNF7JFmFa8IE/NcRmlIM
         kW3MDiMLjPHtp+vFl/UhNCB7LrIgkpwbXdS7xi3bcM5jqM5WCnz/tfSLQFDQeb0Awkg6
         FF7K4opZLmhkbQILg412dwpU2CrRZiOpa9ceg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=asIUMaHIscmVUOt9O3PjjLWYy2UNKC6B4ByL+UWtDFY=;
        b=YumuAy+j9aPIb0d8wLvV6VQCbC+QIBYCDrn0pYbFL7fVkCppsoIw/FVAm8GGPj6mn4
         k2SNtTC7lMZYSpZrExZh0GmnUo2S056yQKjR76yLdwKZfkHkyorAeMiTjJYjAICpB7KQ
         Ye44dsLIQLlutG2K9BkWiOc6GAU0Hs2TQVubvNtRDNhMvq3T3PVv50azktq8hsvmApM2
         OFHmYJz2iTp6utj4WSit711eOeIXF0L4KxkbyBk9n4m4+HAiuPXupeQLvnNcxI+Uyx57
         smQ3wlWPOLWpxhWI4lt7YVc/TvvIEbshjmz5IRbDGBS4JEBDGsomCSRsa7c9uK+UgohR
         no4A==
X-Gm-Message-State: AOAM532DbA4DsPWhZ+tZDUOtszCunaQOoxmJoIEg3bcXzSnlyLb0PIAe
        IwsC9E6AsZN0N5n0bmcGdluMqw==
X-Google-Smtp-Source: ABdhPJyEII+P/2ZM/6AJWX/HZTCj9WuOpxMw0/9G1G/WCLiRXlRknK18NtlPg7X4YJGjehL2raIBIA==
X-Received: by 2002:a17:906:27c9:: with SMTP id k9mr71713920ejc.74.1594640555870;
        Mon, 13 Jul 2020 04:42:35 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:ef88])
        by smtp.gmail.com with ESMTPSA id bs18sm11363158edb.38.2020.07.13.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:42:35 -0700 (PDT)
Date:   Mon, 13 Jul 2020 12:42:35 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 1/2] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <a4e23b59e9ef499b575ae73a8120ee089b7d3373.1594640214.git.chris@chrisdown.name>
References: <cover.1594640214.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594640214.git.chris@chrisdown.name>
User-Agent: Mutt/1.14.5 (2020-06-23)
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
 mm/memcontrol.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0145a77aa074..d4b0d8af3747 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -73,6 +73,7 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
 
+/* The number of times we should retry reclaim failures before giving up. */
 #define MEM_CGROUP_RECLAIM_RETRIES	5
 
 /* Socket memory accounting disabled? */
@@ -2365,18 +2366,23 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
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
 		if (page_counter_read(&memcg->memory) <=
 		    READ_ONCE(memcg->memory.high))
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
@@ -2532,16 +2538,32 @@ void mem_cgroup_handle_over_high(void)
 {
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
+	unsigned long nr_reclaimed;
 	unsigned int nr_pages = current->memcg_nr_pages_over_high;
+	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
 	struct mem_cgroup *memcg;
+	bool in_retry = false;
 
 	if (likely(!nr_pages))
 		return;
 
 	memcg = get_mem_cgroup_from_mm(current->mm);
-	reclaim_high(memcg, nr_pages, GFP_KERNEL);
 	current->memcg_nr_pages_over_high = 0;
 
+retry_reclaim:
+	/*
+	 * The allocating task should reclaim at least the batch size, but for
+	 * subsequent retries we only want to do what's necessary to prevent oom
+	 * or breaching resource isolation.
+	 *
+	 * This is distinct from memory.max or page allocator behaviour because
+	 * memory.high is currently batched, whereas memory.max and the page
+	 * allocator run every time an allocation is made.
+	 */
+	nr_reclaimed = reclaim_high(memcg,
+				    in_retry ? SWAP_CLUSTER_MAX : nr_pages,
+				    GFP_KERNEL);
+
 	/*
 	 * memory.high is breached and reclaim is unable to keep up. Throttle
 	 * allocators proactively to slow down excessive growth.
@@ -2568,6 +2590,16 @@ void mem_cgroup_handle_over_high(void)
 	if (penalty_jiffies <= HZ / 100)
 		goto out;
 
+	/*
+	 * If reclaim is making forward progress but we're still over
+	 * memory.high, we want to encourage that rather than doing allocator
+	 * throttling.
+	 */
+	if (nr_reclaimed || nr_retries--) {
+		in_retry = true;
+		goto retry_reclaim;
+	}
+
 	/*
 	 * If we exit early, we're guaranteed to die (since
 	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
-- 
2.27.0

