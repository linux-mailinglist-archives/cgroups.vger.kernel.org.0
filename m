Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC1367ECF
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhDVKh4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 06:37:56 -0400
Received: from relay.sw.ru ([185.231.240.75]:33620 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235634AbhDVKhz (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 06:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=7c123YSCTdMincmxsUMhI0gcAR3i6drsKgalA/feMPM=; b=Z9L33Ep8FwaCHxE+622
        A2ISGHqkijwLZ2a1EHSrtDAuOpgYZqSP2rztrJ7hiabCkhCHXFgkn2Fp1O8mTiYKrHbxQ8E7CFvuS
        qXnnI+2jC5bJwjszcNbh36wL5hYLNG0ePRlCjddrPLKskUv1dXhKx8jy3zhpdIBMRuCrPK9JsIA=
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZWhx-001AMZ-25; Thu, 22 Apr 2021 13:37:17 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v3 10/16] memcg: enable accounting for pollfd and select bits
 arrays
To:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
Message-ID: <02a9eed7-4067-da25-e305-696e511ee76b@virtuozzo.com>
Date:   Thu, 22 Apr 2021 13:37:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
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

