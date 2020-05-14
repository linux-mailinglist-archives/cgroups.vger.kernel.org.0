Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90A61D248A
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2020 03:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgENBQh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 21:16:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbgENBQh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 13 May 2020 21:16:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B7404DF910A9E833359C;
        Thu, 14 May 2020 09:16:34 +0800 (CST)
Received: from [10.133.206.78] (10.133.206.78) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 14 May
 2020 09:16:29 +0800
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg
 charging
To:     Roman Gushchin <guro@fb.com>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
Date:   Thu, 14 May 2020 09:16:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20200513161110.GA70427@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.206.78]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2020/5/14 0:11, Roman Gushchin wrote:
> On Wed, May 13, 2020 at 07:47:49PM +0800, Zefan Li wrote:
>> While trying to use remote memcg charging in an out-of-tree kernel module
>> I found it's not working, because the current thread is a workqueue thread.
>>
>> As we will probably encounter this issue in the future as the users of
>> memalloc_use_memcg() grow, it's better we fix it now.
>>
>> Signed-off-by: Zefan Li <lizefan@huawei.com>
>> ---
>>
>> v2: add a comment as sugguested by Michal. and add changelog to explain why
>> upstream kernel needs this fix.
>>
>> ---
>>
>>  mm/memcontrol.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index a3b97f1..43a12ed 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2802,6 +2802,9 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>>  
>>  static inline bool memcg_kmem_bypass(void)
>>  {
>> +	/* Allow remote memcg charging in kthread contexts. */
>> +	if (unlikely(current->active_memcg))
>> +		return false;
>>  	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
>>  		return true;
> 
> Shakeel is right about interrupts. How about something like this?
> 
> static inline bool memcg_kmem_bypass(void)
> {
> 	if (in_interrupt())
> 		return true;
> 
> 	if ((!current->mm || current->flags & PF_KTHREAD) && !current->active_memcg)
> 		return true;
> 
> 	return false;
> }
> 

I thought the user should ensure not do this, but now I think it makes sense to just bypass
the interrupt case.
