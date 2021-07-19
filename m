Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4023CD299
	for <lists+cgroups@lfdr.de>; Mon, 19 Jul 2021 12:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbhGSKFV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jul 2021 06:05:21 -0400
Received: from relay.sw.ru ([185.231.240.75]:44884 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236557AbhGSKFG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 19 Jul 2021 06:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=97E+pWsg1fRqSD4/pNq55qMVP3zQsBJJmg0TKYUHtmA=; b=bnoy8snEG7YOPop/cLE
        SrCz+IbDfRt+DLvfyz7GmopfWE/LrVQkLivZnhkP95Xtv8pqb/21NR9hTAvAO6/7dJcYolEFF8sie
        PAdNZRg0HRjv90KRRiZAPD+/Dea0VaGeaqXcqSM2mZ9lBFWNhyZiLwNOItaKjBTRLgQ+X6FLnXs=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m5QmP-004RiA-LA; Mon, 19 Jul 2021 13:45:45 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v5 13/16] memcg: enable accounting for signals
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
 <cover.1626688654.git.vvs@virtuozzo.com>
Message-ID: <b19f065e-f3c9-2b20-2798-b60f0fc6b05f@virtuozzo.com>
Date:   Mon, 19 Jul 2021 13:45:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1626688654.git.vvs@virtuozzo.com>
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
Moreover, an untrusted admin inside container can increase the limit or
create new fake users and force them to sent signals.

It makes sense to account for these allocations to restrict the host's
memory consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
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

