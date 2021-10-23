Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC414383C8
	for <lists+cgroups@lfdr.de>; Sat, 23 Oct 2021 15:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJWNXB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Oct 2021 09:23:01 -0400
Received: from relay.sw.ru ([185.231.240.75]:57620 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230230AbhJWNXB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 23 Oct 2021 09:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=AxIxgS5Zgx5Dv7xkNVoOHoVf+L4ocZrzhwvz5mTzh88=; b=cQNq11A5aFx4UAhxGGN
        cnAAMC/aSb0yZ3qBaxFUMcr36XaP+aXXQVY+4ZrC5LYCfug4p/scKAzhXlvBqhNF2l6MH3rxAlDbE
        xvXLaZIm4Gh3SWpdeWYZ2bk7dWFJbCHs/E5S6zFqn2Op0BcpzQlGU8Fbk+FidqIkfcEnjry/OcI=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1meGwx-006vQz-Ux; Sat, 23 Oct 2021 16:20:40 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg v3 2/3] mm, oom: do not trigger out_of_memory from the
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
References: <YXJ/63kIpTq8AOlD@dhcp22.suse.cz>
 <cover.1634994605.git.vvs@virtuozzo.com>
Message-ID: <f5fd8dd8-0ad4-c524-5f65-920b01972a42@virtuozzo.com>
Date:   Sat, 23 Oct 2021 16:20:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cover.1634994605.git.vvs@virtuozzo.com>
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

This all suggests that there is no legitimate reason to trigger
out_of_memory from pagefault_out_of_memory so drop it. Just to be sure
that no #PF path returns with VM_FAULT_OOM without allocation print a
warning that this is happening before we restart the #PF.

[VvS: #PF allocation can hit into limit of cgroup v1 kmem controller.
This is a local problem related to memcg, however, it causes unnecessary
global OOM kills that are repeated over and over again and escalate into
a real disaster. This has been broken since kmem accounting has been
introduced for cgroup v1 (3.8). There was no kmem specific reclaim
for the separate limit so the only way to handle kmem hard limit
was to return with ENOMEM.
In upstream the problem will be fixed by removing the outdated kmem limit,
however stable and LTS kernels cannot do it and are still affected.
This patch fixes the problem and should be backported into stable/LTS.]

Cc: stable@vger.kernel.org

Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
v2: hook with fatal_signal_pending() has beem moved into a separate patch,
    improved patch description, removed "Fixed" mark.
---
 mm/oom_kill.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1deef8c7a71b..f98954befafb 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1120,19 +1120,15 @@ bool out_of_memory(struct oom_control *oc)
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
@@ -1140,10 +1136,8 @@ void pagefault_out_of_memory(void)
 	if (fatal_signal_pending(current))
 		return;
 
-	if (!mutex_trylock(&oom_lock))
-		return;
-	out_of_memory(&oc);
-	mutex_unlock(&oom_lock);
+	if (__ratelimit(&pfoom_rs))
+		pr_warn("Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF\n");
 }
 
 SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
-- 
2.32.0

