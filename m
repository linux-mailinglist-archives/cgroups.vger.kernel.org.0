Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7F360068
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 05:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhDOD1J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 23:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDOD1I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Apr 2021 23:27:08 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECAEC061574;
        Wed, 14 Apr 2021 20:26:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id i6so7567577qti.10;
        Wed, 14 Apr 2021 20:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7ELJgZAB0/MDsT4s31FFYWkqnQ9XSl76WVBBR9IJO1c=;
        b=t528pCYvS51nm/69P94WlzjraUcBRoYhV1mwN/WUsURBWiaUdqIiJW0x7GvN+c679B
         2FJpV0XfBUE7PthAYwdSXqkWAhsbL63OuuIrtaTeoO45oFfWY9FahsNxOsRY3lOEuSNU
         F4TD+03q5Lr6hIVk/ZLD7lx4CDn4DQQEzUul5FgRzHyEiV3WUzWysaKVpVfZLxq8j2u6
         pLxuQDhGeWAOSltbuPZ5uabQx9R0Qyor4AM/yD2MrU/KYb2Q7aAWP/PhI6KPt1zicqDP
         UMnt9Gvr1J50tMHcewLTfsUzZjJ5BZYT6OGfvc9HF0Ah2Prk/wB6O72tGHROYyY7CvyZ
         gE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ELJgZAB0/MDsT4s31FFYWkqnQ9XSl76WVBBR9IJO1c=;
        b=U+FFtvDNPUzSU0cgjb1s5WST/Aj1F5NsqpdS2rwkUG/Len0BnfOxOybWwehhzfpa4S
         M8JeMGE6T1Nnzu85+9+028g8G8FazuQ+AMVRRIS89WGDKaL9DVhUCjIPhnUEWl21hqY8
         KkdkPTD0hOMjAvdhvEKyKW3EoM3HExcLjFhb00ip/R6v+t+b2d/6Vctd4t4KKS7HM9Hs
         Vch7BBGv+Pthtfub1G103NKlpZLUrp0fYomJLQu8AbVFxFWoAXJnuIGaygVmBLLmli36
         ysPGd/iFUiL2l+llxsz2YPsKdORWItA3t3NW6mG0aSaNxLWKNglYEkG7yYtseYdlXN2p
         +1iQ==
X-Gm-Message-State: AOAM533Ks8zndw4f8dfWTvd9meSEp/9Zr1oLt1oqgcCMkmI5vu8HuIBB
        r0tU592z7dnGPflf9S3TAQ==
X-Google-Smtp-Source: ABdhPJx0Sk6gDpGnRm4Yjpl6DGfGoJFQT12r8vPTu63nbz+p7dTlOKQbUqPzTT/FgN3UNEfY5KpD0g==
X-Received: by 2002:ac8:1098:: with SMTP id a24mr1174748qtj.291.1618457205608;
        Wed, 14 Apr 2021 20:26:45 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id g3sm904049qth.66.2021.04.14.20.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 20:26:45 -0700 (PDT)
Date:   Wed, 14 Apr 2021 23:26:42 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 0/5] mm/memcg: Reduce kmemcache memory accounting
 overhead
Message-ID: <20210415032642.gfaevezaxoj4od3d@gabell>
References: <20210414012027.5352-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:22PM -0400, Waiman Long wrote:
>  v3:
>   - Add missing "inline" qualifier to the alternate mod_obj_stock_state()
>     in patch 3.
>   - Remove redundant current_obj_stock() call in patch 5.
> 
>  v2:
>   - Fix bug found by test robot in patch 5.
>   - Update cover letter and commit logs.
> 
> With the recent introduction of the new slab memory controller, we
> eliminate the need for having separate kmemcaches for each memory
> cgroup and reduce overall kernel memory usage. However, we also add
> additional memory accounting overhead to each call of kmem_cache_alloc()
> and kmem_cache_free().
> 
> For workloads that require a lot of kmemcache allocations and
> de-allocations, they may experience performance regression as illustrated
> in [1] and [2].
> 
> A simple kernel module that performs repeated loop of 100,000,000
> kmem_cache_alloc() and kmem_cache_free() of a 64-byte object at module
> init time is used for benchmarking. The test was run on a CascadeLake
> server with turbo-boosting disable to reduce run-to-run variation.
> 
> With memory accounting disable, the run time was 2.848s. With memory
> accounting enabled, the run times with the application of various
> patches in the patchset were:
> 
>   Applied patches   Run time   Accounting overhead   Overhead %age
>   ---------------   --------   -------------------   -------------
>        None          10.800s         7.952s              100.0%
>         1-2           9.140s         6.292s               79.1%
>         1-3           7.641s         4.793s               60.3%
>         1-5           6.801s         3.953s               49.7%
> 
> Note that this is the best case scenario where most updates happen only
> to the percpu stocks. Real workloads will likely have a certain amount
> of updates to the memcg charges and vmstats. So the performance benefit
> will be less.
> 
> It was found that a big part of the memory accounting overhead
> was caused by the local_irq_save()/local_irq_restore() sequences in
> updating local stock charge bytes and vmstat array, at least in x86
> systems. There are two such sequences in kmem_cache_alloc() and two
> in kmem_cache_free(). This patchset tries to reduce the use of such
> sequences as much as possible. In fact, it eliminates them in the common
> case. Another part of this patchset to cache the vmstat data update in
> the local stock as well which also helps.
> 
> [1] https://lore.kernel.org/linux-mm/20210408193948.vfktg3azh2wrt56t@gabell/T/#u

Hi Longman,

Thank you for your patches.
I rerun the benchmark with your patches, it seems that the reduction
is small... The total duration of sendto() and recvfrom() system call 
during the benchmark are as follows.

- sendto
  - v5.8 vanilla:                      2576.056 msec (100%)
  - v5.12-rc7 vanilla:                 2988.911 msec (116%)
  - v5.12-rc7 with your patches (1-5): 2984.307 msec (115%)

- recvfrom
  - v5.8 vanilla:                      2113.156 msec (100%)
  - v5.12-rc7 vanilla:                 2305.810 msec (109%)
  - v5.12-rc7 with your patches (1-5): 2287.351 msec (108%)

kmem_cache_alloc()/kmem_cache_free() are called around 1,400,000 times during
the benchmark. I ran a loop in a kernel module as following. The duration
is reduced by your patches actually.

  ---
  dummy_cache = KMEM_CACHE(dummy, SLAB_ACCOUNT);
  for (i = 0; i < 1400000; i++) {
	p = kmem_cache_alloc(dummy_cache, GFP_KERNEL);
	kmem_cache_free(dummy_cache, p);
  }
  ---

- v5.12-rc7 vanilla:                 110 msec (100%)
- v5.12-rc7 with your patches (1-5):  85 msec (77%)

It seems that the reduction is small for the benchmark though...
Anyway, I can see your patches reduce the overhead.
Please feel free to add:

	Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa

> [2] https://lore.kernel.org/lkml/20210114025151.GA22932@xsang-OptiPlex-9020/
> 
> Waiman Long (5):
>   mm/memcg: Pass both memcg and lruvec to mod_memcg_lruvec_state()
>   mm/memcg: Introduce obj_cgroup_uncharge_mod_state()
>   mm/memcg: Cache vmstat data in percpu memcg_stock_pcp
>   mm/memcg: Separate out object stock data into its own struct
>   mm/memcg: Optimize user context object stock access
> 
>  include/linux/memcontrol.h |  14 ++-
>  mm/memcontrol.c            | 199 ++++++++++++++++++++++++++++++++-----
>  mm/percpu.c                |   9 +-
>  mm/slab.h                  |  32 +++---
>  4 files changed, 196 insertions(+), 58 deletions(-)
> 
> -- 
> 2.18.1
> 
