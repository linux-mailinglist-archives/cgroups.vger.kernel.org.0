Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2027B07AF
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 17:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjI0PI4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjI0PIz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 11:08:55 -0400
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [95.215.58.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959C4F5
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 08:08:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695827332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mx7CtH6cHJrUFBld37HGiK3WgeHY8tZGKc2c0Drcq2M=;
        b=aLkDt9Aw9FniFt3rZ02X3yb2uiZuG/fL/+LQZnLtgdENgBt2TpkfsBmplfKZfgORJ+Car3
        FEM2u00QMiFqgQB6NVNoz46iFA+hTFjpudzfEev+erU6A6CGIannFcgCjhBHXP22g1XPGb
        mkbfVuaA4mWkfj14/0wiM4V+WP8fH+g=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 0/5] mm: improve performance of kernel memory accounting
Date:   Wed, 27 Sep 2023 08:08:27 -0700
Message-ID: <20230927150832.335132-1-roman.gushchin@linux.dev>
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

This patchset improves the performance of the kernel memory accounting by ~30%
as measured by a micro-benchmark [1]. The benchmark is very straightforward:
1M of 64 bytes-large kmalloc() allocations.

Below are results with the disabled kernel memory accounting, the original state
and with this patchset applied.

|             | Kmem disabled | Original | Patched |  Delta |
|-------------+---------------+----------+---------+--------|
| User cgroup |         29764 |    84435 |   59385 | -29.6% |
| Root cgroup |         29742 |    48425 |   31573 | -34.8% |

As we can see, the patchset removes the majority of the overhead when there is
no actual accounting (a task belongs to the root memory cgroup) and almost
halves the accounting overhead. Overall it improves the speed of accounted
allocations by ~30%.

The main idea is to get rid of unnecessary memcg->objcg conversions and switch
to a scope-based protection of objcgs, which eliminates extra operations with
objcg reference counters under a rcu read lock. More details are provided in
individual commit descriptions.

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
 mm/memcontrol.c            | 178 ++++++++++++++++++++++++++++++++-----
 mm/percpu.c                |   8 +-
 mm/slab.h                  |  10 +--
 5 files changed, 187 insertions(+), 37 deletions(-)

-- 
2.42.0

