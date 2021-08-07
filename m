Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C7F3E341A
	for <lists+cgroups@lfdr.de>; Sat,  7 Aug 2021 10:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhHGI26 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Aug 2021 04:28:58 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13400 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhHGI25 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Aug 2021 04:28:57 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Ghb4Y4s95zcfX3;
        Sat,  7 Aug 2021 16:25:01 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sat, 7 Aug
 2021 16:28:37 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <guro@fb.com>, <songmuchun@bytedance.com>
CC:     <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <cgroups@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 3/3] mm, memcg: get rid of percpu_charge_mutex lock
Date:   Sat, 7 Aug 2021 16:28:35 +0800
Message-ID: <20210807082835.61281-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210807082835.61281-1-linmiaohe@huawei.com>
References: <20210807082835.61281-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We should get rid of percpu_charge_mutex lock as Johannes Weiner said,
""
 It doesn't seem like we need the lock at all.

 The comment says it's so we don't spawn more workers when flushing is
 already underway. But a work cannot be queued more than once - if it
 were just about that, we'd needlessly duplicate the
 test_and_set_bit(WORK_STRUCT_PENDING_BIT) in queue_work_on().

 git history shows we tried to remove it once:

 Commit 8521fc50d433 ("memcg: get rid of percpu_charge_mutex lock")
 tried to do it, but it turned out that the lock did in fact protect
 a data structure: the stock itself. Specifically stock->cached:

 Commit 9f50fad65b87 ("Revert "memcg: get rid of percpu_charge_mutex
 lock"") reverted above removal and explained:

 The patch incorrectly assumes that using atomic FLUSHING_CACHED_CHARGE
 bit operations is sufficient but that is not true.  Johannes Weiner
 has reported a crash during parallel memory cgroup removal:

      BUG: unable to handle kernel NULL pointer dereference at
 0000000000000018
      IP: [<ffffffff81083b70>] css_is_ancestor+0x20/0x70
      Oops: 0000 [#1] PREEMPT SMP
      Pid: 19677, comm: rmdir Tainted: G        W
3.0.0-mm1-00188-gf38d32b #35 ECS MCP61M-M3/MCP61M-M3
      RIP: 0010:[<ffffffff81083b70>]  css_is_ancestor+0x20/0x70
      RSP: 0018:ffff880077b09c88  EFLAGS: 00010202
      Process rmdir (pid: 19677, threadinfo ffff880077b08000, task
ffff8800781bb310)
      Call Trace:
       [<ffffffff810feba3>] mem_cgroup_same_or_subtree+0x33/0x40
       [<ffffffff810feccf>] drain_all_stock+0x11f/0x170
       [<ffffffff81103211>] mem_cgroup_force_empty+0x231/0x6d0
       [<ffffffff811036c4>] mem_cgroup_pre_destroy+0x14/0x20
       [<ffffffff81080559>] cgroup_rmdir+0xb9/0x500
       [<ffffffff81114d26>] vfs_rmdir+0x86/0xe0
       [<ffffffff81114e7b>] do_rmdir+0xfb/0x110
       [<ffffffff81114ea6>] sys_rmdir+0x16/0x20
       [<ffffffff8154d76b>] system_call_fastpath+0x16/0x1b

 We are crashing because we try to dereference cached memcg when we are
 checking whether we should wait for draining on the cache.  The cache
 is already cleaned up, though.

 There is also a theoretical chance that the cached memcg gets freed
 between we test for the FLUSHING_CACHED_CHARGE and dereference it in
 mem_cgroup_same_or_subtree:

            CPU0                    CPU1                         CPU2
      mem=stock->cached
      stock->cached=NULL
                                  clear_bit
                                                           test_and_set_bit
      test_bit()                    ...
      <preempted>             mem_cgroup_destroy
      use after free

 The percpu_charge_mutex protected from this race because sync
 draining is exclusive.

 It is safer to revert now and come up with a more parallel
 implementation later.

 I didn't remember this one at all!

 However, when you look at the codebase from back then, there was no
 rcu-protection for memcg lifetime, and drain_stock() didn't double
 check stock->cached inside the work. Hence the crash during a race.

 The drain code is different now: drain_local_stock() disables IRQs
 which holds up rcu, and then calls drain_stock() and drain_obj_stock()
 which both check stock->cached one more time before the deref.

 With workqueue managing concurrency, and rcu ensuring memcg lifetime
 during the drain, this lock indeed seems unnecessary now.

 Unless I'm missing something, it should just be removed instead.
""

The quote is slightly modified to pass the checkpatch. Please see
https://lore.kernel.org/linux-mm/YQlPiLY0ieRb704V@cmpxchg.org/
for unmodified version.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7fe242d92802..711f1f60faa2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
-static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
 static void drain_obj_stock(struct obj_stock *stock);
@@ -2211,9 +2210,6 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
 	int cpu, curcpu;
 
-	/* If someone's already draining, avoid adding running more workers. */
-	if (!mutex_trylock(&percpu_charge_mutex))
-		return;
 	/*
 	 * Notify other cpus that system-wide "drain" is running
 	 * We do not care about races with the cpu hotplug because cpu down
@@ -2244,7 +2240,6 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		}
 	}
 	put_cpu();
-	mutex_unlock(&percpu_charge_mutex);
 }
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
-- 
2.23.0

