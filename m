Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE03836A0D3
	for <lists+cgroups@lfdr.de>; Sat, 24 Apr 2021 13:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhDXLSj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 24 Apr 2021 07:18:39 -0400
Received: from relay.sw.ru ([185.231.240.75]:42780 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhDXLSi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 24 Apr 2021 07:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=UXNNUoARoOvWpr054pjURR+Eo7jDmpH/x3SEVXjHYTY=; b=Lgaj2Nk/GvJVU6saH
        HCLOMYFtPDUPzRqUgGaeQNDlqnyl7+1ggqETMO2v1EszcBjPZ25oMERu1gM4e/LAYHKM4lgGVFAqc
        Jn3JWjdmzDxkkNZ09FnSdSGxrmz8yx9Pgvc3LFaGTPtnbVfO8cgzRoLGfQn7GOhPonqWZOvKD7Eks
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1laGII-001ILg-Hg; Sat, 24 Apr 2021 14:17:50 +0300
Subject: Re: [PATCH v3 08/16] memcg: enable accounting of ipc resources
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <4ed65beb-bda3-1c93-fadf-296b760a32b2@virtuozzo.com>
 <YIK6ttdnfjOo6XCN@localhost.localdomain>
 <dd9b1767-55e0-6754-3ac5-7e01de12f16e@virtuozzo.com>
 <YILOab0/h83egjUw@dhcp22.suse.cz> <YILQa1qas7veJaCq@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <e67f2a95-4b01-9db2-fe47-0b2210f0b138@virtuozzo.com>
Date:   Sat, 24 Apr 2021 14:17:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YILQa1qas7veJaCq@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/23/21 4:49 PM, Michal Hocko wrote:
> On Fri 23-04-21 15:40:58, Michal Hocko wrote:
>> On Fri 23-04-21 15:32:01, Vasily Averin wrote:
>>> On 4/23/21 3:16 PM, Alexey Dobriyan wrote:
>>>> On Thu, Apr 22, 2021 at 01:37:02PM +0300, Vasily Averin wrote:
>>>>> When user creates IPC objects it forces kernel to allocate memory for
>>>>> these long-living objects.
>>>>>
>>>>> It makes sense to account them to restrict the host's memory consumption
>>>>> from inside the memcg-limited container.
>>>>>
>>>>> This patch enables accounting for IPC shared memory segments, messages
>>>>> semaphores and semaphore's undo lists.
>>>>
>>>>> --- a/ipc/msg.c
>>>>> +++ b/ipc/msg.c
>>>>> @@ -147,7 +147,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
>>>>>  	key_t key = params->key;
>>>>>  	int msgflg = params->flg;
>>>>>  
>>>>> -	msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
>>>>> +	msq = kvmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
>>>>
>>>> Why this requires vmalloc? struct msg_queue is not big at all.
>>>>
>>>>> --- a/ipc/shm.c
>>>>> +++ b/ipc/shm.c
>>>>> @@ -619,7 +619,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>>>>>  			ns->shm_tot + numpages > ns->shm_ctlall)
>>>>>  		return -ENOSPC;
>>>>>  
>>>>> -	shp = kvmalloc(sizeof(*shp), GFP_KERNEL);
>>>>> +	shp = kvmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
>>>>
>>>> Same question.
>>>> Kmem caches can be GFP_ACCOUNT by default.
>>>
>>> It is side effect: previously all these objects was allocated via ipc_alloc/ipc_alloc_rcu
>>> function called kvmalloc inside.
>>>
>>> Should I replace it to kmalloc right in this patch?
>>
>> I would say those are two independent things. I would agree that
>> kvmalloc is bogus here. The allocation would try SLAB allocator first
>> but if it fails (as kvmalloc doesn't try really hard) then it would
>> fragment memory without a good reason which looks like a bug to me.
> 
> I have dug into history and this all seems to be just code pattern
> copy&paste thing. In the past it was ipc_alloc_rcu which was a common
> code for all IPCs and that code was conditional on rcu_use_vmalloc
> (HDRLEN_KMALLOC + size > PAGE_SIZE). Later changed to kvmalloc and then
> helper removed and all users to use kvmalloc. It seems that only
> semaphores can grow large enough to care about kvmalloc though.

I have one more cleanup for ipc, 
so if no one objects, I'll fix this case, add my patch and send them together
as a separate patch set a bit later.

Thank you,
	Vasily Averin
