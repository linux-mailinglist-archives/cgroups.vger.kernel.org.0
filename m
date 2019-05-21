Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42C012585C
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2019 21:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfEUTf4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 15:35:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfEUTf4 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 21 May 2019 15:35:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02EA43078AAC;
        Tue, 21 May 2019 19:35:51 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26DA118786;
        Tue, 21 May 2019 19:35:46 +0000 (UTC)
Subject: Re: [PATCH v4 5/7] mm: rework non-root kmem_cache lifecycle
 management
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
References: <20190514213940.2405198-1-guro@fb.com>
 <20190514213940.2405198-6-guro@fb.com>
 <CALvZod6Zb_kYHyG02jXBY9gvvUn_gOug7kq_hVa8vuCbXdPdjQ@mail.gmail.com>
 <7d06354d-4542-af42-d83d-2bc4639b56f2@redhat.com>
 <20190521192320.GA6658@tower.DHCP.thefacebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e94301ee-b12d-597f-d195-6716b0af1363@redhat.com>
Date:   Tue, 21 May 2019 15:35:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521192320.GA6658@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 21 May 2019 19:35:55 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/21/19 3:23 PM, Roman Gushchin wrote:
> On Tue, May 21, 2019 at 02:39:50PM -0400, Waiman Long wrote:
>> On 5/14/19 8:06 PM, Shakeel Butt wrote:
>>>> @@ -2651,20 +2652,35 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
>>>>         struct mem_cgroup *memcg;
>>>>         struct kmem_cache *memcg_cachep;
>>>>         int kmemcg_id;
>>>> +       struct memcg_cache_array *arr;
>>>>
>>>>         VM_BUG_ON(!is_root_cache(cachep));
>>>>
>>>>         if (memcg_kmem_bypass())
>>>>                 return cachep;
>>>>
>>>> -       memcg = get_mem_cgroup_from_current();
>>>> +       rcu_read_lock();
>>>> +
>>>> +       if (unlikely(current->active_memcg))
>>>> +               memcg = current->active_memcg;
>>>> +       else
>>>> +               memcg = mem_cgroup_from_task(current);
>>>> +
>>>> +       if (!memcg || memcg == root_mem_cgroup)
>>>> +               goto out_unlock;
>>>> +
>>>>         kmemcg_id = READ_ONCE(memcg->kmemcg_id);
>>>>         if (kmemcg_id < 0)
>>>> -               goto out;
>>>> +               goto out_unlock;
>>>>
>>>> -       memcg_cachep = cache_from_memcg_idx(cachep, kmemcg_id);
>>>> -       if (likely(memcg_cachep))
>>>> -               return memcg_cachep;
>>>> +       arr = rcu_dereference(cachep->memcg_params.memcg_caches);
>>>> +
>>>> +       /*
>>>> +        * Make sure we will access the up-to-date value. The code updating
>>>> +        * memcg_caches issues a write barrier to match this (see
>>>> +        * memcg_create_kmem_cache()).
>>>> +        */
>>>> +       memcg_cachep = READ_ONCE(arr->entries[kmemcg_id]);
>>>>
>>>>         /*
>>>>          * If we are in a safe context (can wait, and not in interrupt
>>>> @@ -2677,10 +2693,20 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
>>>>          * memcg_create_kmem_cache, this means no further allocation
>>>>          * could happen with the slab_mutex held. So it's better to
>>>>          * defer everything.
>>>> +        *
>>>> +        * If the memcg is dying or memcg_cache is about to be released,
>>>> +        * don't bother creating new kmem_caches. Because memcg_cachep
>>>> +        * is ZEROed as the fist step of kmem offlining, we don't need
>>>> +        * percpu_ref_tryget() here. css_tryget_online() check in
>>> *percpu_ref_tryget_live()
>>>
>>>> +        * memcg_schedule_kmem_cache_create() will prevent us from
>>>> +        * creation of a new kmem_cache.
>>>>          */
>>>> -       memcg_schedule_kmem_cache_create(memcg, cachep);
>>>> -out:
>>>> -       css_put(&memcg->css);
>>>> +       if (unlikely(!memcg_cachep))
>>>> +               memcg_schedule_kmem_cache_create(memcg, cachep);
>>>> +       else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt))
>>>> +               cachep = memcg_cachep;
>>>> +out_unlock:
>>>> +       rcu_read_lock();
>> There is one more bug that causes the kernel to panic on bootup when I
>> turned on debugging options.
>>
>> [   49.871437] =============================
>> [   49.875452] WARNING: suspicious RCU usage
>> [   49.879476] 5.2.0-rc1.bz1699202_memcg_test+ #2 Not tainted
>> [   49.884967] -----------------------------
>> [   49.888991] include/linux/rcupdate.h:268 Illegal context switch in
>> RCU read-side critical section!
>> [   49.897950]
>> [   49.897950] other info that might help us debug this:
>> [   49.897950]
>> [   49.905958]
>> [   49.905958] rcu_scheduler_active = 2, debug_locks = 1
>> [   49.912492] 3 locks held by systemd/1:
>> [   49.916252]  #0: 00000000633673c5 (&type->i_mutex_dir_key#5){.+.+},
>> at: lookup_slow+0x42/0x70
>> [   49.924788]  #1: 0000000029fa8c75 (rcu_read_lock){....}, at:
>> memcg_kmem_get_cache+0x12b/0x910
>> [   49.933316]  #2: 0000000029fa8c75 (rcu_read_lock){....}, at:
>> memcg_kmem_get_cache+0x3da/0x910
>>
>> It should be "rcu_read_unlock();" at the end.
> Oops. Good catch, thanks Waiman!
>
> I'm somewhat surprised it didn't get up in my tests, neither any of test
> bots caught it. Anyway, I'll fix it and send v5.

In non-preempt kernel rcu_read_lock() is almost a no-op. So you probably
won't see any ill effect with this bug.

>
> Does the rest of the patchset looks sane to you?

I haven't done a full review of the patch, but it looks sane to me from
my cursory look at it. We hit similar problem in Red Hat. That is why I
am looking at your patch. Looking forward to your v5 patch.

Cheers,
Longman

