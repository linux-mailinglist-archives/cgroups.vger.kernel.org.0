Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16176374ABA
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 23:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbhEEVmo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 May 2021 17:42:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:33014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229893AbhEEVmo (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 5 May 2021 17:42:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55DE8B13E;
        Wed,  5 May 2021 21:41:46 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505200610.13943-1-longman@redhat.com>
 <20210505200610.13943-3-longman@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <935031de-f177-b49f-2a1d-2af2b519a270@suse.cz>
Date:   Wed, 5 May 2021 23:41:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210505200610.13943-3-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/5/21 10:06 PM, Waiman Long wrote:
> There are currently two problems in the way the objcg pointer array
> (memcg_data) in the page structure is being allocated and freed.
> 
> On its allocation, it is possible that the allocated objcg pointer
> array comes from the same slab that requires memory accounting. If this
> happens, the slab will never become empty again as there is at least
> one object left (the obj_cgroup array) in the slab.
> 
> When it is freed, the objcg pointer array object may be the last one
> in its slab and hence causes kfree() to be called again. With the
> right workload, the slab cache may be set up in a way that allows the
> recursive kfree() calling loop to nest deep enough to cause a kernel
> stack overflow and panic the system.
> 
> One way to solve this problem is to split the kmalloc-<n> caches
> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
> (KMALLOC_NORMAL) caches for unaccounted objects only and a new set of
> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
> the other caches can still allow a mix of accounted and unaccounted
> objects.
> 
> With this change, all the objcg pointer array objects will come from
> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
> both the recursive kfree() problem and non-freeable slab problem are
> gone.
> 
> Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer have
> mixed accounted and unaccounted objects, this will slightly reduce the
> number of objcg pointer arrays that need to be allocated and save a bit
> of memory. On the other hand, creating a new set of kmalloc caches does
> have the effect of reducing cache utilization. So it is properly a wash.
> 
> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
> will include the newly added caches without change.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

A last nitpick: the new caches -cg should perhaps not be created when
cgroup_memory_nokmem == true because kmemcg was disabled by the respective boot
param.
