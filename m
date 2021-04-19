Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774183638A0
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 02:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhDSABZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 18 Apr 2021 20:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231489AbhDSABZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 18 Apr 2021 20:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618790456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=yKxQATdGznhOXpI/AZM1Ukls2PIZ1+2c4XLkkNdNT6Q=;
        b=DvQGilwMpHgKY0Hn2ij8KN82HO2JMQmIjCfweIHUZFQyzdIbCBvzZ6X4sQMEijHrZze6NT
        V0+jxJ/pQX6In1WFJFmCc06G2C24l+t2a761xDWTti36zWHPk4vqgNuzLxOzsuny1Gku/M
        43RIY89Gj5ZmpPFLpdFSHsWEUJyubkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-wYgGpWivPJWdqZ5E3stNww-1; Sun, 18 Apr 2021 20:00:52 -0400
X-MC-Unique: wYgGpWivPJWdqZ5E3stNww-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60E2B817469;
        Mon, 19 Apr 2021 00:00:47 +0000 (UTC)
Received: from llong.com (ovpn-112-235.rdu2.redhat.com [10.10.112.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EE015D72E;
        Mon, 19 Apr 2021 00:00:39 +0000 (UTC)
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
Subject: [PATCH v4 0/5] mm/memcg: Reduce kmemcache memory accounting overhead
Date:   Sun, 18 Apr 2021 20:00:27 -0400
Message-Id: <20210419000032.5432-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v4:
  - Drop v3 patch 1 as well as modification to mm/percpu.c as the percpu
    vmstat update isn't frequent enough to worth caching it.
  - Add a new patch 1 to move Move mod_objcg_state() to memcontrol.c instead.
  - Combine v3 patches 4 & 5 into a single patch (patch 3).
  - Add a new patch 4 to cache both reclaimable & unreclaimable vmstat updates.
  - Add a new patch 5 to improve refill_obj_stock() performance.

 v3:
  - Add missing "inline" qualifier to the alternate mod_obj_stock_state()
    in patch 3.
  - Remove redundant current_obj_stock() call in patch 5.

 v2:
  - Fix bug found by test robot in patch 5.
  - Update cover letter and commit logs.

With the recent introduction of the new slab memory controller, we
eliminate the need for having separate kmemcaches for each memory
cgroup and reduce overall kernel memory usage. However, we also add
additional memory accounting overhead to each call of kmem_cache_alloc()
and kmem_cache_free().

For workloads that require a lot of kmemcache allocations and
de-allocations, they may experience performance regression as illustrated
in [1] and [2].

A simple kernel module that performs repeated loop of 100,000,000
kmem_cache_alloc() and kmem_cache_free() of either a small 32-byte object
or a big 4k object at module init time is used for benchmarking. The
test was run on a CascadeLake server with turbo-boosting disable to
reduce run-to-run variation.

With memory accounting disable, the run time was 2.848s with small object
and 2.890s for the big object. With memory accounting enabled, the run
times with the application of various patches in the patchset were:

  Applied patches   Run time   Accounting overhead   %age 1   %age 2
  ---------------   --------   -------------------   ------   ------

  Small 32-byte object:
       None          10.570s         7.722s          100.0%   271.1%
        1-2           8.560s         5.712s           74.0%   200.6%
        1-3           6.592s         3.744s           48.5%   131.5%
        1-4           7.154s         4.306s           55.8%   151.2%
	1-5           7.192s         4.344s           56.3%   152.5%

  Large 4k object:
       None          20.612s        17.722s          100.0%   613.2%
        1-2          20.354s        17.464s           98.5%   604.3%
        1-3          19.395s        16.505s           93.1%   571.1%
        1-4          19.094s        16.204s           91.4%   560.7%
	1-5          13.576s        10.686s           60.3%   369.8%

  N.B. %age 1 = overhead/unpatched overhead
       %age 2 = overhead/accounting disable time

The small object test exercises mainly the object stock charging and
vmstat update code paths. The large object test also exercises the
refill_obj_stock() and  __memcg_kmem_charge()/__memcg_kmem_uncharge()
code paths.

The vmstat data stock caching helps in the small object test,
but not so much on the large object test. Similarly, eliminating
irq_disable/irq_enable helps in the small object test and less so in
the large object test. Caching both reclaimable and non-reclaimable
vmstat data actually regresses performance a bit in this particular
small object test.

The final patch to optimize refill_obj_stock() has negligible impact
on the small object test as this code path isn't being exercised. The
large object test, however, sees a pretty good performance improvement
with this patch.

[1] https://lore.kernel.org/linux-mm/20210408193948.vfktg3azh2wrt56t@gabell/T/#u
[2] https://lore.kernel.org/lkml/20210114025151.GA22932@xsang-OptiPlex-9020/

Waiman Long (5):
  mm/memcg: Move mod_objcg_state() to memcontrol.c
  mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
  mm/memcg: Optimize user context object stock access
  mm/memcg: Save both reclaimable & unreclaimable bytes in object stock
  mm/memcg: Improve refill_obj_stock() performance

 mm/memcontrol.c | 199 +++++++++++++++++++++++++++++++++++++++++-------
 mm/slab.h       |  16 +---
 2 files changed, 175 insertions(+), 40 deletions(-)

-- 
2.18.1

