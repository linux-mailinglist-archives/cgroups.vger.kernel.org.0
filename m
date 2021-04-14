Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3F535EA44
	for <lists+cgroups@lfdr.de>; Wed, 14 Apr 2021 03:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbhDNBVN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Apr 2021 21:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231983AbhDNBVL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Apr 2021 21:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618363250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=LSB88EC5/cfTeZcbFM6S4I7akVAT0dRwokU/dRHo8FE=;
        b=Kb7bEjJRcnEFtPIsAAQDwIa+4C0snTf6vlX6voGGIB3BqtxHIh+eP469Ephea+9wGsYsEO
        1YAkGqHWPxcnnFzIm7vlMFVJ5k4gdSZCOPjb5qhPaZcTsjqXUiKf6QCNtWoUY4lAqOf+ya
        UMz5x3rwPAA+4xWtkbx4zb3EkMFsqu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-IGhgiti5OH-v0rTB_gGvSg-1; Tue, 13 Apr 2021 21:20:48 -0400
X-MC-Unique: IGhgiti5OH-v0rTB_gGvSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C41251883520;
        Wed, 14 Apr 2021 01:20:45 +0000 (UTC)
Received: from llong.com (ovpn-113-4.rdu2.redhat.com [10.10.113.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C69751F056;
        Wed, 14 Apr 2021 01:20:37 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 0/5] mm/memcg: Reduce kmemcache memory accounting overhead
Date:   Tue, 13 Apr 2021 21:20:22 -0400
Message-Id: <20210414012027.5352-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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
kmem_cache_alloc() and kmem_cache_free() of a 64-byte object at module
init time is used for benchmarking. The test was run on a CascadeLake
server with turbo-boosting disable to reduce run-to-run variation.

With memory accounting disable, the run time was 2.848s. With memory
accounting enabled, the run times with the application of various
patches in the patchset were:

  Applied patches   Run time   Accounting overhead   Overhead %age
  ---------------   --------   -------------------   -------------
       None          10.800s         7.952s              100.0%
        1-2           9.140s         6.292s               79.1%
        1-3           7.641s         4.793s               60.3%
        1-5           6.801s         3.953s               49.7%

Note that this is the best case scenario where most updates happen only
to the percpu stocks. Real workloads will likely have a certain amount
of updates to the memcg charges and vmstats. So the performance benefit
will be less.

It was found that a big part of the memory accounting overhead
was caused by the local_irq_save()/local_irq_restore() sequences in
updating local stock charge bytes and vmstat array, at least in x86
systems. There are two such sequences in kmem_cache_alloc() and two
in kmem_cache_free(). This patchset tries to reduce the use of such
sequences as much as possible. In fact, it eliminates them in the common
case. Another part of this patchset to cache the vmstat data update in
the local stock as well which also helps.

[1] https://lore.kernel.org/linux-mm/20210408193948.vfktg3azh2wrt56t@gabell/T/#u
[2] https://lore.kernel.org/lkml/20210114025151.GA22932@xsang-OptiPlex-9020/

Waiman Long (5):
  mm/memcg: Pass both memcg and lruvec to mod_memcg_lruvec_state()
  mm/memcg: Introduce obj_cgroup_uncharge_mod_state()
  mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
  mm/memcg: Separate out object stock data into its own struct
  mm/memcg: Optimize user context object stock access

 include/linux/memcontrol.h |  14 ++-
 mm/memcontrol.c            | 199 ++++++++++++++++++++++++++++++++-----
 mm/percpu.c                |   9 +-
 mm/slab.h                  |  32 +++---
 4 files changed, 196 insertions(+), 58 deletions(-)

-- 
2.18.1

