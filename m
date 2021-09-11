Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3783407575
	for <lists+cgroups@lfdr.de>; Sat, 11 Sep 2021 09:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhIKHlZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 11 Sep 2021 03:41:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:43196 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235384AbhIKHlY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 11 Sep 2021 03:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=Sj1B4dxxEgCYUObVr5tn3EBz2yvfW+//sFIcOOUDc5U=; b=SUiOHBCKVqMzFtBCHuo
        +yEezW7VXZzWxFfxvZosB5l1ohptlc/j68xDJ/3kIXPlYJhoBSeNVe4QD0JhinidYSrsN4t7/7h5P
        gb8CBcZz1ZoSDepWoa+IZWpsc2wLZd0Mj3DFK0TK2g3mhmgH48DiFhaiJVGWM9v6VZ4Nt1uMKUs=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mOxcP-001awD-Ot; Sat, 11 Sep 2021 10:40:09 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] ipc: remove memcg accounting for sops objects in
 do_semtimedop()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        cgroups@vger.kernel.org
Message-ID: <90e254df-0dfe-f080-011e-b7c53ee7fd20@virtuozzo.com>
Date:   Sat, 11 Sep 2021 10:40:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Linus proposes to revert an accounting for sops objects in
do_semtimedop() because it's really just a temporary buffer
for a single semtimedop() system call.

This object can consume up to 2 pages, syscall is sleeping one,
size and duration can be controlled by user, and this allocation
can be repeated by many thread at the same time.

However Shakeel Butt pointed that there are much more popular objects
with the same life time and similar memory consumption, the accounting
of which was decided to be rejected for performance reasons.

In addition, any usual task consumes much more accounted memory,
so 2 pages of this temporal buffer can be safely ignored.

Link: https://patchwork.kernel.org/project/linux-fsdevel/patch/20171005222144.123797-1-shakeelb@google.com/

Fixes: 18319498fdd4 ("memcg: enable accounting of ipc resources")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 ipc/sem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index f833238df1ce..6693daf4fe11 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2238,7 +2238,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		return -EINVAL;
 
 	if (nsops > SEMOPM_FAST) {
-		sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL_ACCOUNT);
+		sops = kvmalloc_array(nsops, sizeof(*sops), GFP_KERNEL);
 		if (sops == NULL)
 			return -ENOMEM;
 	}
-- 
2.25.1

