Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B43437382
	for <lists+cgroups@lfdr.de>; Fri, 22 Oct 2021 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhJVINk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Oct 2021 04:13:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:40394 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232380AbhJVINj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 22 Oct 2021 04:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=eJF2bPLrfoGml4ORgOmoEHee/5o6h/70a4+fd/beNO0=; b=GJaMAcBDG07/QtFE6wl
        YEZpKgkBqBSPGv34ZLajUt1kV7fCReA6AvcZ5N7R9P6/0/iLZTyJzFXjjDFwCeFY1HL0f1xK5O9ST
        K6l8RBQzOdZpOZBPBqxkIP1Z3EC/kM3m2/rn+jY53Z7KY0/a91rdGQZKO3HP3dmnrqD7JoYsZmg=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdpe5-006oNB-E3; Fri, 22 Oct 2021 11:11:21 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg v2 1/2] mm, oom: do not trigger out_of_memory from the
 #PF
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
References: <YXGZoVhROdFG2Wym@dhcp22.suse.cz>
 <cover.1634889066.git.vvs@virtuozzo.com>
Message-ID: <91d9196e-842a-757f-a3f2-caeb4a89a0d8@virtuozzo.com>
Date:   Fri, 22 Oct 2021 11:11:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1634889066.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

Any allocation failure during the #PF path will return with VM_FAULT_OOM
which in turn results in pagefault_out_of_memory. This can happen for
2 different reasons. a) Memcg is out of memory and we rely on
mem_cgroup_oom_synchronize to perform the memcg OOM handling or b)
normal allocation fails.

The later is quite problematic because allocation paths already trigger
out_of_memory and the page allocator tries really hard to not fail
allocations. Anyway, if the OOM killer has been already invoked there
is no reason to invoke it again from the #PF path. Especially when the
OOM condition might be gone by that time and we have no way to find out
other than allocate.

Moreover if the allocation failed and the OOM killer hasn't been
invoked then we are unlikely to do the right thing from the #PF context
because we have already lost the allocation context and restictions and
therefore might oom kill a task from a different NUMA domain.

An allocation might fail also when the current task is the oom victim
and there are no memory reserves left and we should simply bail out
from the #PF rather than invoking out_of_memory.

This all suggests that there is no legitimate reason to trigger
out_of_memory from pagefault_out_of_memory so drop it. Just to be sure
that no #PF path returns with VM_FAULT_OOM without allocation print a
warning that this is happening before we restart the #PF.

[VvS: #PF allocation can hit into limit of cgroup v1 kmem controlle.
This is a local problem related to memcg, however, it causes unnecessary
global OOM kills that are repeated over and over again and escalate into
a real disaster.  It was broken long time ago, most likely since
6a1a0d3b625a ("mm: allocate kernel pages to the right memcg").
In upstream the problem will be fixed by removing the outdated kmem limit,
however stable and LTS kernels cannot do it and are still affected.
This patch fixes the problem and should be backported into stable.]

Fixes: 6a1a0d3b625a ("mm: allocate kernel pages to the right memcg")
Cc: stable@vger.kernel.org

Signed-off-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/oom_kill.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..f98954befafb 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1120,27 +1120,24 @@ bool out_of_memory(struct oom_control *oc)
 }
 
 /*
- * The pagefault handler calls here because it is out of memory, so kill a
- * memory-hogging task. If oom_lock is held by somebody else, a parallel oom
- * killing is already in progress so do nothing.
+ * The pagefault handler calls here because some allocation has failed. We have
+ * to take care of the memcg OOM here because this is the only safe context without
+ * any locks held but let the oom killer triggered from the allocation context care
+ * about the global OOM.
  */
 void pagefault_out_of_memory(void)
 {
-	struct oom_control oc = {
-		.zonelist = NULL,
-		.nodemask = NULL,
-		.memcg = NULL,
-		.gfp_mask = 0,
-		.order = 0,
-	};
+	static DEFINE_RATELIMIT_STATE(pfoom_rs, DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
 
 	if (mem_cgroup_oom_synchronize(true))
 		return;
 
-	if (!mutex_trylock(&oom_lock))
+	if (fatal_signal_pending(current))
 		return;
-	out_of_memory(&oc);
-	mutex_unlock(&oom_lock);
+
+	if (__ratelimit(&pfoom_rs))
+		pr_warn("Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF\n");
 }
 
 SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
-- 
2.32.0

