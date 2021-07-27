Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF81C3D6E26
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 07:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhG0FeZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 01:34:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:40322 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235307AbhG0FeJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Jul 2021 01:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=bJzD/4dookOedoazAyDMd9sbQFHTEV2nMBxfajFsEmQ=; b=F8u/2HH6GVK7BiAMTh4
        UI0q9Oib8B+Uz/X45qHzhevS+2/memaWtcUC0mj35gZZKWLjzPoRuB3a35oHfiXAwDBEbJm5xB7n1
        cATa8GkK6DM+OCyDP17uLbgBNrb0e14qMtnEFih4ZIEPspyMuu+a9O2ZCp/FVbk2VRKJJiSF3iE=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m8FjE-005LYs-6G; Tue, 27 Jul 2021 08:34:08 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v7 08/10] memcg: enable accounting for posix_timers_cache slab
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
Message-ID: <57795560-025c-267c-6b1a-dea852d95530@virtuozzo.com>
Date:   Tue, 27 Jul 2021 08:34:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627362057.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

A program may create multiple interval timers using timer_create().
For each timer the kernel preallocates a "queued real-time signal",
Consequently, the number of timers is limited by the RLIMIT_SIGPENDING
resource limit. The allocated object is quite small, ~250 bytes,
but even the default signal limits allow to consume up to 100 megabytes
per user.

It makes sense to account for them to limit the host's memory consumption
from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index dd5697d..7363f81 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -273,8 +273,8 @@ static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 static __init int init_posix_timers(void)
 {
 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
-					sizeof (struct k_itimer), 0, SLAB_PANIC,
-					NULL);
+					sizeof(struct k_itimer), 0,
+					SLAB_PANIC | SLAB_ACCOUNT, NULL);
 	return 0;
 }
 __initcall(init_posix_timers);
-- 
1.8.3.1

