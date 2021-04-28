Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8B36D297
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 08:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236474AbhD1Gyj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 02:54:39 -0400
Received: from relay.sw.ru ([185.231.240.75]:49026 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236695AbhD1Gyg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 02:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=H0noirhKtsT3ob/bQZzage/23G1aDpfbqyt85TTlwvk=; b=YO7/P+zYQR7QMA7wtft
        Lwt5Agutug3h9xvAyjiLiTlNYVkz787Kv4d8uvP64XwEqPonM7VZysqUs34/FdiAXYl0bXVUcIq0i
        V535a0jBOdkZUH16ga0a+5JOLLOGvvjxE0oezLikSXcLG+qkZe5DXF5QgmnDnx1dk+BEEeFC2X4=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lbe50-001VkF-FZ; Wed, 28 Apr 2021 09:53:50 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v4 12/16] memcg: enable accounting for posix_timers_cache slab
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
Message-ID: <41e1ebc8-4f95-4a3f-3665-3fe139786d8e@virtuozzo.com>
Date:   Wed, 28 Apr 2021 09:53:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
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
---
 kernel/time/posix-timers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index bf540f5a..2eee615 100644
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

