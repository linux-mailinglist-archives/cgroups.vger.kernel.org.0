Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6EF35A927
	for <lists+cgroups@lfdr.de>; Sat, 10 Apr 2021 01:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhDIXTr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Apr 2021 19:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234880AbhDIXTr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Apr 2021 19:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618010372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=PsIsstixQZmp09N5dzfFC9lZcQcKbivYZNxi99QL8gg=;
        b=HgLF1QyLx9FG7mAGhr4HoI0e6gYlXfnm2Wfst25ybw0ip0icrGv3A6zWLInJ2//uHarkqf
        FboDvWipb3r5EHdHXUqA3SMu5GUBR3BnHYqpEpIX9Gn1bn4k1P9IM/WPphjy3LBp0dWX7i
        IFnU+GSsMajaPoCNhchnyTfIZsuwqaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-NuTI7DlQNsGWx8R-aRzgiw-1; Fri, 09 Apr 2021 19:19:29 -0400
X-MC-Unique: NuTI7DlQNsGWx8R-aRzgiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73462107ACC7;
        Fri,  9 Apr 2021 23:19:25 +0000 (UTC)
Received: from llong.com (ovpn-113-226.rdu2.redhat.com [10.10.113.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A4A31B400;
        Fri,  9 Apr 2021 23:19:19 +0000 (UTC)
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
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/5] mm/memcg: Reduce kmemcache memory accounting overhead
Date:   Fri,  9 Apr 2021 19:18:37 -0400
Message-Id: <20210409231842.8840-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With the recent introduction of the new slab memory controller, we
eliminate the need for having separate kmemcaches for each memory
cgroup and reduce overall kernel memory usage. However, we also add
additional memory accounting overhead to each call of kmem_cache_alloc()
and kmem_cache_free().

For workloads that require a lot of kmemcache allocations and
de-allocations, they may experience performance regression as illustrated
in [1].

With a simple kernel module that performs repeated loop of 100,000,000
kmem_cache_alloc() and kmem_cache_free() of 64-byte object at module
init. The execution time to load the kernel module with and without
memory accounting were:

  with accounting = 6.798s
  w/o  accounting = 1.758s

That is an increase of 5.04s (287%). With this patchset applied, the
execution time became 4.254s. So the memory accounting overhead is now
2.496s which is a 50% reduction.

It was found that a major part of the memory accounting overhead
is caused by the local_irq_save()/local_irq_restore() sequences in
updating local stock charge bytes and vmstat array, at least in x86
systems. There are two such sequences in kmem_cache_alloc() and two
in kmem_cache_free(). This patchset tries to reduce the use of such
sequences as much as possible. In fact, it eliminates them in the common
case. Another part of this patchset to cache the vmstat data update in
the local stock as well which also helps.

[1] https://lore.kernel.org/linux-mm/20210408193948.vfktg3azh2wrt56t@gabell/T/#u

Waiman Long (5):
  mm/memcg: Pass both memcg and lruvec to mod_memcg_lruvec_state()
  mm/memcg: Introduce obj_cgroup_uncharge_mod_state()
  mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
  mm/memcg: Separate out object stock data into its own struct
  mm/memcg: Optimize user context object stock access

 include/linux/memcontrol.h |  14 ++-
 mm/memcontrol.c            | 198 ++++++++++++++++++++++++++++++++-----
 mm/percpu.c                |   9 +-
 mm/slab.h                  |  32 +++---
 4 files changed, 195 insertions(+), 58 deletions(-)

-- 
2.18.1

