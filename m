Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA5E7A0BDE
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 19:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbjINRhn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbjINRhm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 13:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B42EF2100
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694713012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4hzn4St1hDKvPdOxDMBMmAGTrFFy2dEQTx58ZE1Vlo=;
        b=G3nwAX6WFOKzZFD94Pcw9ggWzj0P0xMszJzK4Iyx+iyndBDCc06icjpKRbtwV64PugzpfT
        y+8SgKxPhzEJzZyNY3VKrV/p8zJFWzZZJKEljs5Uov56324ABl4ZO0c7H2vD5jHJyXjmku
        OChYbRCBhGWFeKGw2OcaF325ol7A/rE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-K-EPic2lNueZ9FA-gCtQLA-1; Thu, 14 Sep 2023 13:36:47 -0400
X-MC-Unique: K-EPic2lNueZ9FA-gCtQLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F0C181D7A7;
        Thu, 14 Sep 2023 17:36:46 +0000 (UTC)
Received: from [10.22.34.133] (unknown [10.22.34.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D28721B20B1;
        Thu, 14 Sep 2023 17:36:45 +0000 (UTC)
Message-ID: <a58d757d-00a1-9872-9698-f613ff210ff5@redhat.com>
Date:   Thu, 14 Sep 2023 13:36:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and
 accuracy
Content-Language: en-US
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        kernel-team@cloudflare.com, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com>
 <cbad0762-892f-229e-280e-1faafbcb36b8@redhat.com>
 <CAJD7tkYGaVVbMpd6RC7QreLGCWpvMEmwJ9LJAZHKqdsTGM22-Q@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <CAJD7tkYGaVVbMpd6RC7QreLGCWpvMEmwJ9LJAZHKqdsTGM22-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 9/14/23 13:23, Yosry Ahmed wrote:
> On Thu, Sep 14, 2023 at 10:19 AM Waiman Long <longman@redhat.com> wrote:
>>
>> On 9/13/23 03:38, Yosry Ahmed wrote:
>>> Stats flushing for memcg currently follows the following rules:
>>> - Always flush the entire memcg hierarchy (i.e. flush the root).
>>> - Only one flusher is allowed at a time. If someone else tries to flush
>>>     concurrently, they skip and return immediately.
>>> - A periodic flusher flushes all the stats every 2 seconds.
>>>
>>> The reason this approach is followed is because all flushes are
>>> serialized by a global rstat spinlock. On the memcg side, flushing is
>>> invoked from userspace reads as well as in-kernel flushers (e.g.
>>> reclaim, refault, etc). This approach aims to avoid serializing all
>>> flushers on the global lock, which can cause a significant performance
>>> hit under high concurrency.
>>>
>>> This approach has the following problems:
>>> - Occasionally a userspace read of the stats of a non-root cgroup will
>>>     be too expensive as it has to flush the entire hierarchy [1].
>>> - Sometimes the stats accuracy are compromised if there is an ongoing
>>>     flush, and we skip and return before the subtree of interest is
>>>     actually flushed. This is more visible when reading stats from
>>>     userspace, but can also affect in-kernel flushers.
>>>
>>> This patch aims to solve both problems by reworking how flushing
>>> currently works as follows:
>>> - Without contention, there is no need to flush the entire tree. In this
>>>     case, only flush the subtree of interest. This avoids the latency of a
>>>     full root flush if unnecessary.
>>> - With contention, fallback to a coalesced (aka unified) flush of the
>>>     entire hierarchy, a root flush. In this case, instead of returning
>>>     immediately if a root flush is ongoing, wait for it to finish
>>>     *without* attempting to acquire the lock or flush. This is done using
>>>     a completion. Compared to competing directly on the underlying lock,
>>>     this approach makes concurrent flushing a synchronization point
>>>     instead of a serialization point. Once  a root flush finishes, *all*
>>>     waiters can wake up and continue at once.
>>> - Finally, with very high contention, bound the number of waiters to the
>>>     number of online cpus. This keeps the flush latency bounded at the tail
>>>     (very high concurrency). We fallback to sacrificing stats freshness only
>>>     in such cases in favor of performance.
>>>
>>> This was tested in two ways on a machine with 384 cpus:
>>> - A synthetic test with 5000 concurrent workers doing allocations and
>>>     reclaim, as well as 1000 readers for memory.stat (variation of [2]).
>>>     No significant regressions were noticed in the total runtime.
>>>     Note that if concurrent flushers compete directly on the spinlock
>>>     instead of waiting for a completion, this test shows 2x-3x slowdowns.
>>>     Even though subsequent flushers would have nothing to flush, just the
>>>     serialization and lock contention is a major problem. Using a
>>>     completion for synchronization instead seems to overcome this problem.
>>>
>>> - A synthetic stress test for concurrently reading memcg stats provided
>>>     by Wei Xu.
>>>     With 10k threads reading the stats every 100ms:
>>>     - 98.8% of reads take <100us
>>>     - 1.09% of reads take 100us to 1ms.
>>>     - 0.11% of reads take 1ms to 10ms.
>>>     - Almost no reads take more than 10ms.
>>>     With 10k threads reading the stats every 10ms:
>>>     - 82.3% of reads take <100us.
>>>     - 4.2% of reads take 100us to 1ms.
>>>     - 4.7% of reads take 1ms to 10ms.
>>>     - 8.8% of reads take 10ms to 100ms.
>>>     - Almost no reads take more than 100ms.
>>>
>>> [1] https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/
>>> [2] https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com/
>>> [3] https://lore.kernel.org/lkml/CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com/
>>>
>>> [weixugc@google.com: suggested the fallback logic and bounding the
>>> number of waiters]
>>>
>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>>> ---
>>>    include/linux/memcontrol.h |   4 +-
>>>    mm/memcontrol.c            | 100 ++++++++++++++++++++++++++++---------
>>>    mm/vmscan.c                |   2 +-
>>>    mm/workingset.c            |   8 ++-
>>>    4 files changed, 85 insertions(+), 29 deletions(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index 11810a2cfd2d..4453cd3fc4b8 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -1034,7 +1034,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>>>        return x;
>>>    }
>>>
>>> -void mem_cgroup_flush_stats(void);
>>> +void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
>>>    void mem_cgroup_flush_stats_ratelimited(void);
>>>
>>>    void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>>> @@ -1519,7 +1519,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>>>        return node_page_state(lruvec_pgdat(lruvec), idx);
>>>    }
>>>
>>> -static inline void mem_cgroup_flush_stats(void)
>>> +static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>>>    {
>>>    }
>>>
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index d729870505f1..edff41e4b4e7 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -588,7 +588,6 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>>>    static void flush_memcg_stats_dwork(struct work_struct *w);
>>>    static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
>>>    static DEFINE_PER_CPU(unsigned int, stats_updates);
>>> -static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
>>>    /* stats_updates_order is in multiples of MEMCG_CHARGE_BATCH */
>>>    static atomic_t stats_updates_order = ATOMIC_INIT(0);
>>>    static u64 flush_last_time;
>>> @@ -639,36 +638,87 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>>>        }
>>>    }
>>>
>>> -static void do_flush_stats(void)
>>> +/*
>>> + * do_flush_stats - flush the statistics of a memory cgroup and its tree
>>> + * @memcg: the memory cgroup to flush
>>> + * @wait: wait for an ongoing root flush to complete before returning
>>> + *
>>> + * All flushes are serialized by the underlying rstat global lock. If there is
>>> + * no contention, we try to only flush the subtree of the passed @memcg to
>>> + * minimize the work. Otherwise, we coalesce multiple flushing requests into a
>>> + * single flush of the root memcg. When there is an ongoing root flush, we wait
>>> + * for its completion (unless otherwise requested), to get fresh stats. If the
>>> + * number of waiters exceeds the number of cpus just skip the flush to bound the
>>> + * flush latency at the tail with very high concurrency.
>>> + *
>>> + * This is a trade-off between stats accuracy and flush latency.
>>> + */
>>> +static void do_flush_stats(struct mem_cgroup *memcg, bool wait)
>>>    {
>>> +     static DECLARE_COMPLETION(root_flush_done);
>>> +     static DEFINE_SPINLOCK(root_flusher_lock);
>>> +     static DEFINE_MUTEX(subtree_flush_mutex);
>>> +     static atomic_t waiters = ATOMIC_INIT(0);
>>> +     static bool root_flush_ongoing;
>>> +     bool root_flusher = false;
>>> +
>>> +     /* Ongoing root flush, just wait for it (unless otherwise requested) */
>>> +     if (READ_ONCE(root_flush_ongoing))
>>> +             goto root_flush_or_wait;
>>> +
>>>        /*
>>> -      * We always flush the entire tree, so concurrent flushers can just
>>> -      * skip. This avoids a thundering herd problem on the rstat global lock
>>> -      * from memcg flushers (e.g. reclaim, refault, etc).
>>> +      * Opportunistically try to only flush the requested subtree. Otherwise
>>> +      * fallback to a coalesced flush below.
>>>         */
>>> -     if (atomic_read(&stats_flush_ongoing) ||
>>> -         atomic_xchg(&stats_flush_ongoing, 1))
>>> +     if (!mem_cgroup_is_root(memcg) && mutex_trylock(&subtree_flush_mutex)) {
>>> +             cgroup_rstat_flush(memcg->css.cgroup);
>>> +             mutex_unlock(&subtree_flush_mutex);
>>>                return;
>>> +     }
>> If mutex_trylock() is the only way to acquire subtree_flush_mutex, you
>> don't really need a mutex. Just a simple integer flag with xchg() call
>> should be enough.

Equivalently test_and_set_bit() will work too.

Cheers,
Longman

> Thanks for pointing this out. Agreed.
>
> If we keep this approach I will drop that mutex.
>

