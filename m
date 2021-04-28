Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D1236D28F
	for <lists+cgroups@lfdr.de>; Wed, 28 Apr 2021 08:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhD1GyW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Apr 2021 02:54:22 -0400
Received: from relay.sw.ru ([185.231.240.75]:48638 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhD1GyV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 28 Apr 2021 02:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=7c123YSCTdMincmxsUMhI0gcAR3i6drsKgalA/feMPM=; b=hx3oiJ3GN0JTYyHXwUF
        piNkCm1/FGOH/eBSy+V2rRwKfmysCkGH23nji93+uvE5Ai8wTXwimlqFzu4Y7YnCthNcHu6WlO3Fl
        YvKQdyAw6KQYvlBk4RmmcQBGzzlsZ1yjE8/RJqo97C5YG5L2j3xRyTjx6/bUd1lGZkYrroLz0g0=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lbe4l-001Vjv-9I; Wed, 28 Apr 2021 09:53:35 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v4 10/16] memcg: enable accounting for pollfd and select bits
 arrays
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <8664122a-99d3-7199-869a-781b21b7e712@virtuozzo.com>
Message-ID: <aaf449c4-0932-2c9c-67b9-f214fe5d7a6f@virtuozzo.com>
Date:   Wed, 28 Apr 2021 09:53:34 +0300
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

User can call select/poll system calls with a large number of assigned
file descriptors and force kernel to allocate up to several pages of memory
till end of these sleeping system calls. We have here long-living
unaccounted per-task allocations.

It makes sense to account for these allocations to restrict the host's
memory consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/select.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 945896d..e83e563 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -655,7 +655,7 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 			goto out_nofds;
 
 		alloc_size = 6 * size;
-		bits = kvmalloc(alloc_size, GFP_KERNEL);
+		bits = kvmalloc(alloc_size, GFP_KERNEL_ACCOUNT);
 		if (!bits)
 			goto out_nofds;
 	}
@@ -1000,7 +1000,7 @@ static int do_sys_poll(struct pollfd __user *ufds, unsigned int nfds,
 
 		len = min(todo, POLLFD_PER_PAGE);
 		walk = walk->next = kmalloc(struct_size(walk, entries, len),
-					    GFP_KERNEL);
+					    GFP_KERNEL_ACCOUNT);
 		if (!walk) {
 			err = -ENOMEM;
 			goto out_fds;
-- 
1.8.3.1

