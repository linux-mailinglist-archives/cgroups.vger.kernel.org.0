Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1276D7CB675
	for <lists+cgroups@lfdr.de>; Tue, 17 Oct 2023 00:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbjJPWT0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Oct 2023 18:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjJPWTZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Oct 2023 18:19:25 -0400
Received: from out-209.mta1.migadu.com (out-209.mta1.migadu.com [95.215.58.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7148F9B
        for <cgroups@vger.kernel.org>; Mon, 16 Oct 2023 15:19:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697494761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=me+EtXsO4OQNKVxpXtZoBKeIB+zeonfL/v0A4vdt7vw=;
        b=UerryqrHGKvuW2aa+eacApzC4j9BLgQ297VVhGO3cJayVal+++VpmtupMGR/y5uY5xhzLn
        4pT1IG4+1slJUAqTXFz6w8YCrOwL/ErDBejwExf7A+gSs8JY6Bs25PkBJLSkskM0n53L7j
        Ju6egteINuuAxB10wAujofYeB9m+rck=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Shakeel@vger.kernel.org,
        Butt@vger.kernel.org, shakeelb@google.com,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v3 0/5] mm: improve performance of accounted kernel memory allocations
Date:   Mon, 16 Oct 2023 15:18:55 -0700
Message-ID: <20231016221900.4031141-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patchset improves the performance of accounted kernel memory allocations
by ~30% as measured by a micro-benchmark [1]. The benchmark is very
straightforward: 1M of 64 bytes-large kmalloc() allocations.

Below are results with the disabled kernel memory accounting, the original state
and with this patchset applied.

|             | Kmem disabled | Original | Patched |  Delta |
|-------------+---------------+----------+---------+--------|
| User cgroup |         29764 |    84548 |   59078 | -30.0% |
| Root cgroup |         29742 |    48342 |   31501 | -34.8% |

As we can see, the patchset removes the majority of the overhead when there is
no actual accounting (a task belongs to the root memory cgroup) and almost
halves the accounting overhead otherwise.

The main idea is to get rid of unnecessary memcg to objcg conversions and switch
to a scope-based protection of objcgs, which eliminates extra operations with
objcg reference counters under a rcu read lock. More details are provided in
individual commit descriptions.

v3:
	- fixed a bug spotted by Shakeel
	- added some comments, per Shakeel
v2:
	- fixed a bug discovered by Naresh Kamboju
	- code changes asked by Johannes (added comments, open-coded bit ops)
	- merged in a couple of small fixes
v1:
	- made the objcg update fully lockless
	- fixed !CONFIG_MMU build issues
rfc:
	https://lwn.net/Articles/945722/

--
[1]:

static int memory_alloc_test(struct seq_file *m, void *v)
{
       unsigned long i, j;
       void **ptrs;
       ktime_t start, end;
       s64 delta, min_delta = LLONG_MAX;

       ptrs = kvmalloc(sizeof(void *) * 1000000, GFP_KERNEL);
       if (!ptrs)
               return -ENOMEM;

       for (j = 0; j < 100; j++) {
               start = ktime_get();
               for (i = 0; i < 1000000; i++)
                       ptrs[i] = kmalloc(64, GFP_KERNEL_ACCOUNT);
               end = ktime_get();

               delta = ktime_us_delta(end, start);
               if (delta < min_delta)
                       min_delta = delta;

               for (i = 0; i < 1000000; i++)
                       kfree(ptrs[i]);
       }

       kvfree(ptrs);
       seq_printf(m, "%lld us\n", min_delta);

       return 0;
}

--

Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>


Roman Gushchin (5):
  mm: kmem: optimize get_obj_cgroup_from_current()
  mm: kmem: add direct objcg pointer to task_struct
  mm: kmem: make memcg keep a reference to the original objcg
  mm: kmem: scoped objcg protection
  percpu: scoped objcg protection

 include/linux/memcontrol.h |  17 +++-
 include/linux/sched.h      |   4 +
 include/linux/sched/mm.h   |   4 +
 mm/memcontrol.c            | 204 ++++++++++++++++++++++++++++++++-----
 mm/percpu.c                |   8 +-
 mm/slab.h                  |  15 +--
 6 files changed, 214 insertions(+), 38 deletions(-)

-- 
2.42.0

