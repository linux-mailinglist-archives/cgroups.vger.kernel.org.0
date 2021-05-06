Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A51F375616
	for <lists+cgroups@lfdr.de>; Thu,  6 May 2021 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhEFPBc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 May 2021 11:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36534 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234918AbhEFPBb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 May 2021 11:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620313232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=x3Qd4etU7iC+w7jo+cUV80DwOdiZ+r+doYyGq4jz5NI=;
        b=CvrDwfCNWEbp3QX8CdZljmJin+xYiWrikLmxz+QLbteTPNTNzNBhuHIGv4AHXG4075UMqa
        spm/sDele9XaQsLPsMjci4oS6FpK/zjfO1DM72eWfrNsGQz7saY9kHPiVWsCbItbaT6wYz
        xgaUqRAawR9gU2hSLJX+tR6LZSFFG9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-EQVRvhWpO9OSHlpbEVmAKw-1; Thu, 06 May 2021 11:00:29 -0400
X-MC-Unique: EQVRvhWpO9OSHlpbEVmAKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 301098049D1;
        Thu,  6 May 2021 15:00:25 +0000 (UTC)
Received: from llong.com (ovpn-114-62.rdu2.redhat.com [10.10.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64F3A19100;
        Thu,  6 May 2021 15:00:16 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 0/4] mm/memcg: Reduce kmemcache memory accounting overhead
Date:   Thu,  6 May 2021 11:00:03 -0400
Message-Id: <20210506150007.16288-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v6:
  - Rebased on top the latest Linus's tree.
  - Add additional comments to patches 2 and 3 as suggested by reviewers.
  - Rename the additional parameter in refill_obj_stock() to allow_uncharge
    to indicate if page uncharge is allowed or not.

 v5:
  - Combine v4 patches 2 & 4 into a single patch with minor twisting.
  - Move the user context stock access optimization patch to the end
    of the series.
  - Incorporate some changes suggested by Johannes.

 v4:
  - Drop v3 patch 1 as well as modification to mm/percpu.c as the percpu
    vmstat update isn't frequent enough to worth caching it.
  - Add a new patch 1 to move Move mod_objcg_state() to memcontrol.c instead.
  - Combine v3 patches 4 & 5 into a single patch (patch 3).
  - Add a new patch 4 to cache both reclaimable & unreclaimable vmstat updates.
  - Add a new patch 5 to improve refill_obj_stock() performance.

With the recent introduction of the new slab memory controller, we
eliminate the need for having separate kmemcaches for each memory
cgroup and reduce overall kernel memory usage. However, we also add
additional memory accounting overhead to each call of kmem_cache_alloc()
and kmem_cache_free().

For workloads that require a lot of kmemcache allocations and
de-allocations, they may experience performance regression as illustrated
in [1] and [2].

A simple kernel module that performs repeated loop of 100,000,000
kmem_cache_alloc() and kmem_cache_free() of either a small 32-byte
object or a big 4k object at module init time with a batch size of 4
(4 kmalloc's followed by 4 kfree's) is used for benchmarking. The
benchmarking tool was run on a kernel based on linux-next-20210419.
The test was run on a CascadeLake server with turbo-boosting disable
to reduce run-to-run variation.

The small object test exercises mainly the object stock charging and
vmstat update code paths. The large object test also exercises the
refill_obj_stock() and  __memcg_kmem_charge()/__memcg_kmem_uncharge()
code paths.

With memory accounting disabled, the run time was 3.130s with both small
object big object tests.

With memory accounting enabled, both cgroup v1 and v2 showed similar
results in the small object test.  The performance results of the large
object test, however, differed between cgroup v1 and v2.

The execution times with the application of various patches in the
patchset were:

  Applied patches   Run time   Accounting overhead   %age 1   %age 2
  ---------------   --------   -------------------   ------   ------

  Small 32-byte object:
       None          11.634s         8.504s          100.0%   271.7%
        1-2           9.425s         6.295s           74.0%   201.1%
        1-3           9.708s         6.578s           77.4%   210.2%
        1-4           8.062s         4.932s           58.0%   157.6%

  Large 4k object (v2):
       None          22.107s        18.977s          100.0%   606.3%
        1-2          20.960s        17.830s           94.0%   569.6%
        1-3          14.238s        11.108s           58.5%   354.9%
        1-4          11.329s         8.199s           43.2%   261.9%

  Large 4k object (v1):
       None          36.807s        33.677s          100.0%  1075.9%
        1-2          36.648s        33.518s           99.5%  1070.9%
        1-3          22.345s        19.215s           57.1%   613.9%
        1-4          18.662s        15.532s           46.1%   496.2%

  N.B. %age 1 = overhead/unpatched overhead
       %age 2 = overhead/accounting disabled time

Patch 2 (vmstat data stock caching) helps in both the small object test
and the large v2 object test. It doesn't help much in v1 big object test.

Patch 3 (refill_obj_stock improvement) does help the small object test
but offer significant performance improvement for the large object test
(both v1 and v2).

Patch 4 (eliminating irq disable/enable) helps in all test cases.

To test for the extreme case, a multi-threaded kmalloc/kfree
microbenchmark was run on the 2-socket 48-core 96-thread system with
96 testing threads in the same memcg doing kmalloc+kfree of a 4k object
with accounting enabled for 10s. The total number of kmalloc+kfree done
in kilo operations per second (kops/s) were as follows:

  Applied patches   v1 kops/s   v1 change   v2 kops/s   v2 change
  ---------------   ---------   ---------   ---------   ---------
       None           3,520        1.00X      6,242        1.00X
        1-2           4,304        1.22X      8,478        1.36X
        1-3           4,731        1.34X    418,142       66.99X
        1-4           4,587        1.30X    438,838       70.30X

With memory accounting disabled, the kmalloc/kfree rate was 1,481,291
kop/s. This test shows how significant the memory accouting overhead
can be in some extreme situations.

For this multithreaded test, the improvement from patch 2 mainly
comes from the conditional atomic xchg of objcg->nr_charged_bytes in
mod_objcg_state(). By using an unconditional xchg, the operation rates
were similar to the unpatched kernel.

Patch 3 elminates the single highly contended cacheline of
objcg->nr_charged_bytes for cgroup v2 leading to a huge performance
improvement. Cgroup v1, however, still has another highly contended
cacheline in the shared page counter &memcg->kmem. So the improvement
is only modest.

Patch 4 helps in cgroup v2, but performs worse in cgroup v1 as
eliminating the irq_disable/irq_enable overhead seems to aggravate the
cacheline contention.

[1] https://lore.kernel.org/linux-mm/20210408193948.vfktg3azh2wrt56t@gabell/T/#u
[2] https://lore.kernel.org/lkml/20210114025151.GA22932@xsang-OptiPlex-9020/

Waiman Long (4):
  mm/memcg: Move mod_objcg_state() to memcontrol.c
  mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
  mm/memcg: Improve refill_obj_stock() performance
  mm/memcg: Optimize user context object stock access

 mm/memcontrol.c | 227 +++++++++++++++++++++++++++++++++++++++++-------
 mm/slab.h       |  16 +---
 2 files changed, 196 insertions(+), 47 deletions(-)

-- 
2.18.1

