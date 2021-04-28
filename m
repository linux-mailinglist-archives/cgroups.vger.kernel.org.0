Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1E636D293
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 08:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236371AbhD1Gy1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 02:54:27 -0400
Received: from relay.sw.ru ([185.231.240.75]:48726 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236357AbhD1Gy0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 02:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=JNK/tV8LgF3p4F8dPZczQO1z3bcUs4vufDHvwz2ZVgs=; b=KKo5bTR5ssb/1fPxbQh
        1pVYIS4AJeA+eBipR89M8XEn6J+ExxTv19OELBJOKDUsjG+qzCfcdHBVFfihqYjJ/CgFQxXCKx3hG
        bvJ6ysmqxVZA4qSYt9pUVARGEoKwhN61z9me0e/gxhcfSvz2A7CjSe8pxjUNNrhm+yrI+t9Rqtk=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lbe4r-001Vk4-8J; Wed, 28 Apr 2021 09:53:41 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v4 11/16] memcg: enable accounting for signals
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
Message-ID: <5567ec19-cd77-01cc-b019-c48f53beb930@virtuozzo.com>
Date:   Wed, 28 Apr 2021 09:53:40 +0300
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
index f271835..a7fa849 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4639,7 +4639,7 @@ void __init signals_init(void)
 {
 	siginfo_buildtime_checks();
 
-	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC);
+	sigqueue_cachep = KMEM_CACHE(sigqueue, SLAB_PANIC | SLAB_ACCOUNT);
 }
 
 #ifdef CONFIG_KGDB_KDB
-- 
1.8.3.1

