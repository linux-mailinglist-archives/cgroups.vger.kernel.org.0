Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F12E434AE9
	for <lists+cgroups@lfdr.de>; Wed, 20 Oct 2021 14:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJTMO4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Oct 2021 08:14:56 -0400
Received: from relay.sw.ru ([185.231.240.75]:42218 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhJTMO4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 20 Oct 2021 08:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=zCii9TAKFxPwpgbC2GK8kQRHiFyLfuYpBkR6wq1K544=; b=YA4A3B4VF1+nFZ0rGP3
        RW6fx/vlidgUELNJqxLSSMjROlO+5ORXrIjobCBiutx+Rzi4Gpj3dIChnj9ANaIk8UuoaQugEQs2H
        mmO+fyIjeY6wEK2Y8m/P2+a4GbOJnRlVPqjWTPDKKR1Lh5aR54tEKAritk9BQ46GWDnQYzj5ng4=;
Received: from [172.29.1.17]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mdASW-006b94-0Q; Wed, 20 Oct 2021 15:12:40 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH memcg 1/3] mm: do not firce global OOM from inside dying tasks
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
Message-ID: <2c13c739-7282-e6f4-da0a-c0b69e68581e@virtuozzo.com>
Date:   Wed, 20 Oct 2021 15:12:19 +0300
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

There is no sense to force global OOM if current task is dying.

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

