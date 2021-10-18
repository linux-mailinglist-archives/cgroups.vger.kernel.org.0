Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7704311F6
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJRIQp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 04:16:45 -0400
Received: from relay.sw.ru ([185.231.240.75]:57036 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231249AbhJRIQp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 18 Oct 2021 04:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=o6kTDCIX8m/7vi/Fj7ESJCu9Hrbtu/S6QWfa9zBOu9w=; b=Yui58D6boe8f6wHqXme
        h9QuiSqbjd6C/vRXzdxWFiv5XKKzCzsSb+sDTmMl1DAPFXjkGljm/MRffisA8iVymhySz/zoc+Gim
        QdMZOSg101MvhtW6KSn6qsBOV5eyql/UKp9ozis5XS07u/Ny2fKMdLtfOBFNrdme+wIaZKCAbiM=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mcNmz-006KDj-0X; Mon, 18 Oct 2021 11:14:33 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg 1/1] memcg: prevent false global OOM triggered by memcg
 limited task
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <cover.1634543503.git.vvs@virtuozzo.com>
Message-ID: <fbc4a7f4-faf8-bb82-9df4-925543cc73ca@virtuozzo.com>
Date:   Mon, 18 Oct 2021 11:14:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1634543503.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently memcg-limited userspace can trigger false global OOM.

A user space task inside memcg-limited container generates a page fault,
its handler do_user_addr_fault() calls handle_mm_fault(),
which cannot allocate the page due to exceeding the memcg limit 
and returns VM_FAULT_OOM.
Then do_user_addr_fault() calls pagefault_out_of_memory()
which finally executes out_of_memory() without set of memcg
and triggers a false global OOM.

At present do_user_addr_fault() does not know why page allocation was failed,
i.e. was it global or memcg OOM.

Let's use new flag on task struct to save this information,
it will be set in obj_cgroup_charge_pages (for memory controller)
and in try_charge_memcg (for kmem controller), 
and will be used in mem_cgroup_oom_synchronize() 
called inside pagefault_out_of_memory():
in case of memcg-related restrictions it does not allow to generate a
false global OOM and will silently return to user space which will either
retry the fault or kill the process if it got a fatal signal.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 include/linux/sched.h |  1 +
 mm/memcontrol.c       | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c1a927ddec64..62d186fffb26 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -910,6 +910,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_MEMCG
 	unsigned			in_user_fault:1;
+	unsigned			is_over_memcg_limit:1;
 #endif
 #ifdef CONFIG_COMPAT_BRK
 	unsigned			brk_randomized:1;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 87e41c3cac10..c977d75bcc5f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1846,7 +1846,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
 
 	/* OOM is global, do not handle */
 	if (!memcg)
-		return false;
+		return current->is_over_memcg_limit;
 
 	if (!handle)
 		goto cleanup;
@@ -2535,6 +2535,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool drained = false;
 	unsigned long pflags;
 
+	if (current->in_user_fault)
+		current->is_over_memcg_limit = false;
 retry:
 	if (consume_stock(memcg, nr_pages))
 		return 0;
@@ -2639,8 +2641,11 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		goto retry;
 	}
 nomem:
-	if (!(gfp_mask & __GFP_NOFAIL))
+	if (!(gfp_mask & __GFP_NOFAIL)) {
+		if (current->in_user_fault)
+			current->is_over_memcg_limit = true;
 		return -ENOMEM;
+	}
 force:
 	/*
 	 * The allocation either can't fail or will lead to more memory
@@ -2964,10 +2969,11 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 		}
 		cancel_charge(memcg, nr_pages);
 		ret = -ENOMEM;
+		if (current->in_user_fault)
+			current->is_over_memcg_limit = true;
 	}
 out:
 	css_put(&memcg->css);
-
 	return ret;
 }
 
-- 
2.32.0

