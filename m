Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39711D1113
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 13:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbgEMLUC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 07:20:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4779 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732645AbgEMLUC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 13 May 2020 07:20:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5866B8E1CE9EE32307A9;
        Wed, 13 May 2020 19:20:00 +0800 (CST)
Received: from [10.133.206.78] (10.133.206.78) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 13 May
 2020 19:19:57 +0800
Subject: Re: [PATCH] memcg: Fix memcg_kmem_bypass() for remote memcg charging
To:     Michal Hocko <mhocko@kernel.org>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
Date:   Wed, 13 May 2020 19:19:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20200513090502.GV29153@dhcp22.suse.cz>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.206.78]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/5/13 17:05, Michal Hocko wrote:
> On Wed 13-05-20 15:28:28, Li Zefan wrote:
>> While trying to use remote memcg charging in an out-of-tree kernel module
>> I found it's not working, because the current thread is a workqueue thread.
>>
>> Signed-off-by: Zefan Li <lizefan@huawei.com>
>> ---
>>
>> No need to queue this for v5.7 as currently no upstream users of this memcg
>> feature suffer from this bug.
>>
>> ---
>>  mm/memcontrol.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index a3b97f1..db836fc 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2802,6 +2802,8 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>>  
>>  static inline bool memcg_kmem_bypass(void)
>>  {
>> +	if (unlikely(current->active_memcg))
>> +		return false;
> 
> I am confused. Why the check below is insufficient? It checks for both mm
> and PF_KTHREAD?
> 

memalloc_use_memcg(memcg);
alloc_page(GFP_KERNEL_ACCOUNT);
memalloc_unuse_memcg();

If we run above code in a workqueue thread the memory won't be charged to the specific
memcg, because memcg_kmem_bypass() returns true in this case.

>>  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
>>  		return true;
>>  	return false;
