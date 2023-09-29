Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6474D7B394C
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjI2SBU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Sep 2023 14:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2SBT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Sep 2023 14:01:19 -0400
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135BCBE
        for <cgroups@vger.kernel.org>; Fri, 29 Sep 2023 11:01:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696010475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6tcTuWYRALIgJf3jd0QQAQe8tlt9e/aWb2Z4sY08mGQ=;
        b=SkOuMpvSIJQsX1dDkYHCau3cvj0O3IYvhitbxnrKAG2QyDLxJyA2P4OufwQXTxcFl3Nqf1
        hBwl2Nq2rZ+L+tq8JEqSRm6O9MoulQjBqZEZYio1AlRAkoXBirXAhyCeetKPYbHVW7NG0V
        EW1XF9qCTWMH8bocXcrlnOOLzPABKJM=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 0/5] mm: improve performance of accounted kernel memory allocations
Date:   Fri, 29 Sep 2023 11:00:50 -0700
Message-ID: <20230929180056.1122002-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

 include/linux/memcontrol.h |  24 ++++-
 include/linux/sched.h      |   4 +
 mm/memcontrol.c            | 184 ++++++++++++++++++++++++++++++++-----
 mm/percpu.c                |   8 +-
 mm/slab.h                  |  10 +-
 5 files changed, 192 insertions(+), 38 deletions(-)

-- 
2.42.0

