Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4733DEB43
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhHCKwG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 06:52:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:12439 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbhHCKum (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 06:50:42 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GfBQ80YYQzckM6;
        Tue,  3 Aug 2021 18:46:56 +0800 (CST)
Received: from [10.174.179.25] (10.174.179.25) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 3 Aug 2021 18:50:28 +0800
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
To:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>
CC:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com> <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
 <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
 <YQi6lOT6j2DtOGlT@carbon.dhcp.thefacebook.com>
 <95629d91-6ae8-b445-e7fc-b51c888cad59@huawei.com>
 <CAMZfGtUChsJO1UrgmP6M274UwiHap0_yzCBL+mDq1OosP7JNsA@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <702c05c6-fd8b-e1de-21e7-4be5b206958a@huawei.com>
Date:   Tue, 3 Aug 2021 18:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAMZfGtUChsJO1UrgmP6M274UwiHap0_yzCBL+mDq1OosP7JNsA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/8/3 17:33, Muchun Song wrote:
> On Tue, Aug 3, 2021 at 2:29 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2021/8/3 11:40, Roman Gushchin wrote:
>>> On Sat, Jul 31, 2021 at 10:29:52AM +0800, Miaohe Lin wrote:
>>>> On 2021/7/30 14:50, Michal Hocko wrote:
>>>>> On Thu 29-07-21 20:06:45, Roman Gushchin wrote:
>>>>>> On Thu, Jul 29, 2021 at 08:57:52PM +0800, Miaohe Lin wrote:
>>>>>>> Since percpu_charge_mutex is only used inside drain_all_stock(), we can
>>>>>>> narrow the scope of percpu_charge_mutex by moving it here.
>>>>>>>
>>>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>>>> ---
>>>>>>>  mm/memcontrol.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>>>> index 6580c2381a3e..a03e24e57cd9 100644
>>>>>>> --- a/mm/memcontrol.c
>>>>>>> +++ b/mm/memcontrol.c
>>>>>>> @@ -2050,7 +2050,6 @@ struct memcg_stock_pcp {
>>>>>>>  #define FLUSHING_CACHED_CHARGE   0
>>>>>>>  };
>>>>>>>  static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
>>>>>>> -static DEFINE_MUTEX(percpu_charge_mutex);
>>>>>>>
>>>>>>>  #ifdef CONFIG_MEMCG_KMEM
>>>>>>>  static void drain_obj_stock(struct obj_stock *stock);
>>>>>>> @@ -2209,6 +2208,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>>>>>>   */
>>>>>>>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>>>>>>>  {
>>>>>>> + static DEFINE_MUTEX(percpu_charge_mutex);
>>>>>>>   int cpu, curcpu;
>>>>>>
>>>>>> It's considered a good practice to protect data instead of code paths. After
>>>>>> the proposed change it becomes obvious that the opposite is done here: the mutex
>>>>>> is used to prevent a simultaneous execution of the code of the drain_all_stock()
>>>>>> function.
>>>>>
>>>>> The purpose of the lock was indeed to orchestrate callers more than any
>>>>> data structure consistency.
>>>>>
>>>>>> Actually we don't need a mutex here: nobody ever sleeps on it. So I'd replace
>>>>>> it with a simple atomic variable or even a single bitfield. Then the change will
>>>>>> be better justified, IMO.
>>>>>
>>>>> Yes, mutex can be replaced by an atomic in a follow up patch.
>>>>>
>>>>
>>>> Thanks for both of you. It's a really good suggestion. What do you mean is something like below？
>>>>
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index 616d1a72ece3..508a96e80980 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -2208,11 +2208,11 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>>>   */
>>>>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>>>>  {
>>>> -       static DEFINE_MUTEX(percpu_charge_mutex);
>>>>         int cpu, curcpu;
>>>> +       static atomic_t drain_all_stocks = ATOMIC_INIT(-1);
>>>>
>>>>         /* If someone's already draining, avoid adding running more workers. */
>>>> -       if (!mutex_trylock(&percpu_charge_mutex))
>>>> +       if (!atomic_inc_not_zero(&drain_all_stocks))
>>>>                 return;
>>>
>>> It should work, but why not a simple atomic_cmpxchg(&drain_all_stocks, 0, 1) and
>>> initialize it to 0? Maybe it's just my preference, but IMO (0, 1) is easier
>>> to understand than (-1, 0) here. Not a strong opinion though, up to you.
>>>
>>
>> I think this would improve the readability. What you mean is something like below ?
>>
>> Many thanks.
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 616d1a72ece3..6210b1124929 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2208,11 +2208,11 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>>   */
>>  static void drain_all_stock(struct mem_cgroup *root_memcg)
>>  {
>> -       static DEFINE_MUTEX(percpu_charge_mutex);
>>         int cpu, curcpu;
>> +       static atomic_t drainer = ATOMIC_INIT(0);
>>
>>         /* If someone's already draining, avoid adding running more workers. */
>> -       if (!mutex_trylock(&percpu_charge_mutex))
>> +       if (atomic_cmpxchg(&drainer, 0, 1) != 0)
> 
> I'd like to use atomic_cmpxchg_acquire() here.
> 
>>                 return;
>>         /*
>>          * Notify other cpus that system-wide "drain" is running
>> @@ -2244,7 +2244,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>>                 }
>>         }
>>         put_cpu();
>> -       mutex_unlock(&percpu_charge_mutex);
>> +       atomic_set(&drainer, 0);
> 
> So use atomic_set_release() here to cooperate with
> atomic_cmpxchg_acquire().

I think this will work well. Many thanks!

> 
> Thanks.
> 
>>  }
>>
>>> Thanks!
>>> .
>>>
>>
> .
> 

