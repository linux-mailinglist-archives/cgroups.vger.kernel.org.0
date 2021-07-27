Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5163F3D6E1E
	for <lists+cgroups@lfdr.de>; Tue, 27 Jul 2021 07:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbhG0FeS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 01:34:18 -0400
Received: from relay.sw.ru ([185.231.240.75]:40314 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233553AbhG0FeD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 27 Jul 2021 01:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=m1Yqt1TCkby1yY+UxZYHx7vylpAQ4AaVAE17J3Ni/4s=; b=ZVp29BLbPsEbGmFDCr1
        vlcF/qa3L/6YTTSIbhjpIM/YenBGgWZgDM+FidVYuoJNHR49HsgoOzO4G72XZhPRcpZJ+m5A0gV4P
        R6wMfrS/8iEx7nbOzEeydq/dwPmxS283jiPq9+wwXIfiGeu0WisdCwawnEUPGcuONgqSL5HefeM=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m8Fj7-005LYm-Ln; Tue, 27 Jul 2021 08:34:01 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v7 07/10] memcg: enable accounting for signals
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
Message-ID: <e34e958c-e785-712e-a62a-2c7b66c646c7@virtuozzo.com>
Date:   Tue, 27 Jul 2021 08:34:01 +0300
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

When a user send a signal to any another processes it forces the kernel
to allocate memory for 'struct sigqueue' objects. The number of signals
is limited by RLIMIT_SIGPENDING resource limit, but even the default
settings allow each user to consume up to several megabytes of memory.

It makes sense to account for these allocations to restrict the host's
memory consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index a3229ad..8921c4a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4663,7 +4663,7 @@ void __init signals_init(void)
 {
 	siginfo_buildtime_checks();
 
-	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC);
+	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC | SLAB_ACCOUNT);
 }
 
 #ifdef CONFIG_KGDB_KDB
-- 
1.8.3.1

