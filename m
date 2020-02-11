Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFBA158D70
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2020 12:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgBKLUf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Feb 2020 06:20:35 -0500
Received: from relay.sw.ru ([185.231.240.75]:53864 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgBKLUe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 11 Feb 2020 06:20:34 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1j1TaN-0007J1-JY; Tue, 11 Feb 2020 14:20:12 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] memcg: lost css_put in memcg_expand_shrinker_maps()
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Message-ID: <c98414fb-7e1f-da0f-867a-9340ec4bd30b@virtuozzo.com>
Date:   Tue, 11 Feb 2020 14:20:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

for_each_mem_cgroup() increases css reference counter for memory cgroup
and requires to use mem_cgroup_iter_break() if the walk is cancelled.

Cc: stable@vger.kernel.org
Fixes commit 0a4465d34028("mm, memcg: assign memcg-aware shrinkers bitmap to memcg")

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/memcontrol.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6c83cf4..e2da615 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -409,8 +409,10 @@ int memcg_expand_shrinker_maps(int new_id)
 		if (mem_cgroup_is_root(memcg))
 			continue;
 		ret = memcg_expand_one_shrinker_map(memcg, size, old_size);
-		if (ret)
+		if (ret) {
+			mem_cgroup_iter_break(NULL, memcg);
 			goto unlock;
+		}
 	}
 unlock:
 	if (!ret)
-- 
1.8.3.1

