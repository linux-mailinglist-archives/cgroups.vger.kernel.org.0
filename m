Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24CD434AFD
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 14:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhJTMRG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 08:17:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:44326 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhJTMRE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Oct 2021 08:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=vKfgRv2zJEAoAS/QMp8Ojy3ytr5x5Kwda6HCzY+o9dY=; b=piFq4YJOVCzthmB9i6b
        NgU9AF9sxMXuXUshwNGUqc8UUt7jOsEyjWpz7crmMVUVecu7tMqQloOLCOHVflMvVpfVsy94enpjs
        38aVbuXoEwvwIBMuS1SZMSPcfMeMLX5W7o9phEpjbW/bnnHEfFKouHYb3wZ6hDngTOJJSojLDVQ=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdAUa-006bCw-9o; Wed, 20 Oct 2021 15:14:48 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg 3/3] memcg: handle memcg oom failures
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YW/WoJDFM3ddHn7Y@dhcp22.suse.cz>
 <cover.1634730787.git.vvs@virtuozzo.com>
Message-ID: <fb33f4bd-34cd-2187-eff4-7c1c11d5ae94@virtuozzo.com>
Date:   Wed, 20 Oct 2021 15:14:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1634730787.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_oom() can fail if current task was marked unkillable
and oom killer cannot find any victim.

Currently we force memcg charge for such allocations,
however it allow memcg-limited userspace task in to overuse assigned limits
and potentially trigger the global memory shortage.

Let's fail the memory charge in such cases.

This failure should be somehow recognised in #PF context,
so let's use current->memcg_in_oom == (struct mem_cgroup *)OOM_FAILED

ToDo: what is the best way to notify pagefault_out_of_memory() about 
    mem_cgroup_out_of_memory failure ?

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/memcontrol.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 74a7379dbac1..b09d3c64f63f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1810,11 +1810,21 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
 		mem_cgroup_oom_notify(memcg);
 
 	mem_cgroup_unmark_under_oom(memcg);
-	if (mem_cgroup_out_of_memory(memcg, mask, order))
+	if (mem_cgroup_out_of_memory(memcg, mask, order)) {
 		ret = OOM_SUCCESS;
-	else
+	} else {
 		ret = OOM_FAILED;
-
+		/*
+		 * In some rare cases mem_cgroup_out_of_memory() can return false.
+		 * If it was called from #PF it forces handle_mm_fault()
+		 * return VM_FAULT_OOM and executes pagefault_out_of_memory().
+		 * memcg_in_oom is set here to notify pagefault_out_of_memory()
+		 * that it was a memcg-related failure and not allow to run
+		 * global OOM.
+		 */
+		if (current->in_user_fault)
+			current->memcg_in_oom = (struct mem_cgroup *)ret;
+	}
 	if (locked)
 		mem_cgroup_oom_unlock(memcg);
 
@@ -1848,6 +1858,15 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	if (!memcg)
 		return false;
 
+	/* OOM is memcg, however out_of_memory() found no victim */
+	if (memcg == (struct mem_cgroup *)OOM_FAILED) {
+		/*
+		 * Should be called from pagefault_out_of_memory() only,
+		 * where it is used to prevent false global OOM.
+		 */
+		current->memcg_in_oom = NULL;
+		return true;
+	}
 	if (!handle)
 		goto cleanup;
 
@@ -2633,15 +2652,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
 		       get_order(nr_pages * PAGE_SIZE));
-	switch (oom_status) {
-	case OOM_SUCCESS:
+	if (oom_status == OOM_SUCCESS) {
 		passed_oom = true;
 		nr_retries = MAX_RECLAIM_RETRIES;
 		goto retry;
-	case OOM_FAILED:
-		goto force;
-	default:
-		goto nomem;
 	}
 nomem:
 	if (!(gfp_mask & __GFP_NOFAIL))
-- 
2.32.0

