Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7036922A
	for <lists+cgroups@lfdr.de>; Fri, 23 Apr 2021 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242507AbhDWMcz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Apr 2021 08:32:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:52526 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242491AbhDWMcv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 23 Apr 2021 08:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=R3m4pVHRhL2mIR6ypt7iJreGEiDdyMSHemfDUd6NDlY=; b=bQBiHSB5vbUYH32wz
        AAYVsQNDtTNMObyz5GPJvdkA4EtY+HYz9EELeX9OUTA7rb4wf1g+akbOoVZkt9u9fudbEHLItwUWz
        3kjDnlpYG6oKryqW9QKrBYUWup4kX70eoF6LfdcF7EHFvQyBaKKwEWGh7y6K/iFnXXAXKpTmZ8QfU
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZuyY-001Ehb-7s; Fri, 23 Apr 2021 15:32:02 +0300
Subject: Re: [PATCH v3 08/16] memcg: enable accounting of ipc resources
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <4ed65beb-bda3-1c93-fadf-296b760a32b2@virtuozzo.com>
 <YIK6ttdnfjOo6XCN@localhost.localdomain>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <dd9b1767-55e0-6754-3ac5-7e01de12f16e@virtuozzo.com>
Date:   Fri, 23 Apr 2021 15:32:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIK6ttdnfjOo6XCN@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/23/21 3:16 PM, Alexey Dobriyan wrote:
> On Thu, Apr 22, 2021 at 01:37:02PM +0300, Vasily Averin wrote:
>> When user creates IPC objects it forces kernel to allocate memory for
>> these long-living objects.
>>
>> It makes sense to account them to restrict the host's memory consumption
>> from inside the memcg-limited container.
>>
>> This patch enables accounting for IPC shared memory segments, messages
>> semaphores and semaphore's undo lists.
> 
>> --- a/ipc/msg.c
>> +++ b/ipc/msg.c
>> @@ -147,7 +147,7 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
>>  	key_t key = params->key;
>>  	int msgflg = params->flg;
>>  
>> -	msq = kvmalloc(sizeof(*msq), GFP_KERNEL);
>> +	msq = kvmalloc(sizeof(*msq), GFP_KERNEL_ACCOUNT);
> 
> Why this requires vmalloc? struct msg_queue is not big at all.
> 
>> --- a/ipc/shm.c
>> +++ b/ipc/shm.c
>> @@ -619,7 +619,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>>  			ns->shm_tot + numpages > ns->shm_ctlall)
>>  		return -ENOSPC;
>>  
>> -	shp = kvmalloc(sizeof(*shp), GFP_KERNEL);
>> +	shp = kvmalloc(sizeof(*shp), GFP_KERNEL_ACCOUNT);
> 
> Same question.
> Kmem caches can be GFP_ACCOUNT by default.

It is side effect: previously all these objects was allocated via ipc_alloc/ipc_alloc_rcu
function called kvmalloc inside.

Should I replace it to kmalloc right in this patch?

Thank you,
	Vasily Averin

