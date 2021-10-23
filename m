Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8074383C6
	for <lists+cgroups@lfdr.de>; Sat, 23 Oct 2021 15:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhJWNWN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 23 Oct 2021 09:22:13 -0400
Received: from relay.sw.ru ([185.231.240.75]:56520 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhJWNWK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 23 Oct 2021 09:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=DX974UacjLa5B8lLKBDGYPr0ueCh9q/0PqGjv1EsfYw=; b=Qqybfz2pU+1i6qU1cl+
        n1/Ryq+c0MgrgrTKsIr+zAZ1FcRW64LaQxmTNiUdj22yblJrcLgq8hzUJ6nLnvPsVJAJt72LMbhfw
        +odGC3WfLkhI4RMty6rnyhpI2Nrq4jD4t5JdjGwt3X6OlFXMtqtk18+4yM2yEuiOzojbz5hH3hs=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1meGw9-006vQI-Bm; Sat, 23 Oct 2021 16:19:49 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg v3 1/3] mm, oom: pagefault_out_of_memory: don't force
 global OOM for dying tasks
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
Message-ID: <0828a149-786e-7c06-b70a-52d086818ea3@virtuozzo.com>
Date:   Sat, 23 Oct 2021 16:19:28 +0300
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

Any allocation failure during the #PF path will return with VM_FAULT_OOM
which in turn results in pagefault_out_of_memory which in own turn
executes out_out_memory() and can kill a random task.

An allocation might fail when the current task is the oom victim
and there are no memory reserves left. The OOM killer is already
handled at the page allocator level for the global OOM and at the
charging level for the memcg one. Both have much more information
about the scope of allocation/charge request. This means that
either the OOM killer has been invoked properly and didn't lead
to the allocation success or it has been skipped because it couldn't
have been invoked. In both cases triggering it from here is pointless
and even harmful.

It makes much more sense to let the killed task die rather than to
wake up an eternally hungry oom-killer and send him to choose a fatter
victim for breakfast.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/oom_kill.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..1deef8c7a71b 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1137,6 +1137,9 @@ void pagefault_out_of_memory(void)
 	if (mem_cgroup_oom_synchronize(true))
 		return;
 
+	if (fatal_signal_pending(current))
+		return;
+
 	if (!mutex_trylock(&oom_lock))
 		return;
 	out_of_memory(&oc);
-- 
2.32.0

