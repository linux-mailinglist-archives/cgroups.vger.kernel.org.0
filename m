Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C2C1D4804
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 10:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgEOIUL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 04:20:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727838AbgEOIUK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 May 2020 04:20:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 549A62D7613678341757;
        Fri, 15 May 2020 16:20:08 +0800 (CST)
Received: from [10.133.206.78] (10.133.206.78) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 15 May
 2020 16:20:05 +0800
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
To:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
 <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz>
 <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
 <20200513161110.GA70427@carbon.DHCP.thefacebook.com>
 <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
 <20200514225259.GA81563@carbon.dhcp.thefacebook.com>
 <20200515065645.GD29153@dhcp22.suse.cz>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <bad0e16b-7141-94c0-45f6-6ed03926b5f8@huawei.com>
Date:   Fri, 15 May 2020 16:20:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20200515065645.GD29153@dhcp22.suse.cz>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.206.78]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/5/15 14:56, Michal Hocko wrote:
> On Thu 14-05-20 15:52:59, Roman Gushchin wrote:
>> On Thu, May 14, 2020 at 09:16:29AM +0800, Zefan Li wrote:
>>> On 2020/5/14 0:11, Roman Gushchin wrote:
>>>> On Wed, May 13, 2020 at 07:47:49PM +0800, Zefan Li wrote:
>>>>> While trying to use remote memcg charging in an out-of-tree kernel module
>>>>> I found it's not working, because the current thread is a workqueue thread.
>>>>>
>>>>> As we will probably encounter this issue in the future as the users of
>>>>> memalloc_use_memcg() grow, it's better we fix it now.
>>>>>
>>>>> Signed-off-by: Zefan Li <lizefan@huawei.com>
>>>>> ---
>>>>>
>>>>> v2: add a comment as sugguested by Michal. and add changelog to explain why
>>>>> upstream kernel needs this fix.
>>>>>
>>>>> ---
>>>>>
>>>>>  mm/memcontrol.c | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>> index a3b97f1..43a12ed 100644
>>>>> --- a/mm/memcontrol.c
>>>>> +++ b/mm/memcontrol.c
>>>>> @@ -2802,6 +2802,9 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>>>>>  
>>>>>  static inline bool memcg_kmem_bypass(void)
>>>>>  {
>>>>> +	/* Allow remote memcg charging in kthread contexts. */
>>>>> +	if (unlikely(current->active_memcg))
>>>>> +		return false;
>>>>>  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
>>>>>  		return true;
>>>>
>>>> Shakeel is right about interrupts. How about something like this?
>>>>
>>>> static inline bool memcg_kmem_bypass(void)
>>>> {
>>>> 	if (in_interrupt())
>>>> 		return true;
>>>>
>>>> 	if ((!current->mm || current->flags & PF_KTHREAD) && !current->active_memcg)
>>>> 		return true;
>>>>
>>>> 	return false;
>>>> }
>>>>
>>>
>>> I thought the user should ensure not do this, but now I think it makes sense to just bypass
>>> the interrupt case.
>>
>> I think now it's mostly a legacy of the opt-out kernel memory accounting.
>> Actually we can relax this requirement by forcibly overcommit the memory cgroup
>> if the allocation is happening from the irq context, and punish it afterwards.
>> Idk how much we wanna this, hopefully nobody is allocating large non-temporarily
>> objects from an irq.
> 
> I do not think we want to pretend that remote charging from the IRQ
> context is supported. Why don't we simply WARN_ON(in_interrupt()) there?
> 

How about:

static inline bool memcg_kmem_bypass(void)
{
        if (in_interrupt()) {
                WARN_ON(current->active_memcg);
                return true;
        }

        /* Allow remote memcg charging in kthread contexts. */
        if ((!current->mm || (current->flags & PF_KTHREAD)) && !current->active_memcg)
                return true;
        return false;
}

