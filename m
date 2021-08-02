Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955D53DD379
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhHBKAX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Aug 2021 06:00:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7913 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhHBKAW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Aug 2021 06:00:22 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GdYLF5kG6z82wG;
        Mon,  2 Aug 2021 17:56:21 +0800 (CST)
Received: from [10.174.179.25] (10.174.179.25) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 2 Aug 2021 18:00:10 +0800
Subject: Re: [PATCH 4/5] mm, memcg: avoid possible NULL pointer dereferencing
 in mem_cgroup_init()
To:     Michal Hocko <mhocko@suse.com>
CC:     Roman Gushchin <guro@fb.com>, <hannes@cmpxchg.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-5-linmiaohe@huawei.com> <YQNuK+jN7pZLJTvT@carbon.lan>
 <YQOf0TKOXpGRQFHF@dhcp22.suse.cz>
 <f7a22702-cd08-6b15-48c7-68523c38060b@huawei.com>
 <YQeUATTCVMd1D7Ra@dhcp22.suse.cz>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <47daf062-f510-edb3-6ec7-f8e7615ad8a0@huawei.com>
Date:   Mon, 2 Aug 2021 18:00:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YQeUATTCVMd1D7Ra@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/8/2 14:43, Michal Hocko wrote:
> On Sat 31-07-21 10:05:51, Miaohe Lin wrote:
>> On 2021/7/30 14:44, Michal Hocko wrote:
>>> On Thu 29-07-21 20:12:43, Roman Gushchin wrote:
>>>> On Thu, Jul 29, 2021 at 08:57:54PM +0800, Miaohe Lin wrote:
>>>>> rtpn might be NULL in very rare case. We have better to check it before
>>>>> dereferencing it. Since memcg can live with NULL rb_tree_per_node in
>>>>> soft_limit_tree, warn this case and continue.
>>>>>
>>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>>> ---
>>>>>  mm/memcontrol.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>>> index 5b4592d1e0f2..70a32174e7c4 100644
>>>>> --- a/mm/memcontrol.c
>>>>> +++ b/mm/memcontrol.c
>>>>> @@ -7109,6 +7109,8 @@ static int __init mem_cgroup_init(void)
>>>>>  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
>>>>>  				    node_online(node) ? node : NUMA_NO_NODE);
>>>>>  
>>>>> +		if (WARN_ON_ONCE(!rtpn))
>>>>> +			continue;
>>>>
>>>> I also really doubt that it makes any sense to continue in this case.
>>>> If this allocations fails (at the very beginning of the system's life, it's an __init function),
>>>> something is terribly wrong and panic'ing on a NULL-pointer dereference sounds like
>>>> a perfect choice.
>>>
>>> Moreover this is 24B allocation during early boot. Kernel will OOM and
>>> panic when not being able to find any victim. I do not think we need to
>>
>> Agree with you. But IMO it may not be a good idea to leave the rtpn without NULL check. We should defend
>> it though it could hardly happen. But I'm not insist on this check. I will drop this patch if you insist.
> 
> It is not that I would insist. I just do not see any point in the code
> churn. This check is not going to ever trigger and there is nothing you
> can do to recover anyway so crashing the kernel is likely the only
> choice left.
> 

I hope I get the point now. What you mean is nothing we can do to recover and panic'ing on a
NULL-pointer dereference is a perfect choice ? Should we declare that we leave the rtpn without
NULL check on purpose like below ?

Many thanks.

@@ -7109,8 +7109,12 @@ static int __init mem_cgroup_init(void)
                rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
                                    node_online(node) ? node : NUMA_NO_NODE);

-               if (WARN_ON_ONCE(!rtpn))
-                       continue;
+               /*
+                * If this allocation fails (at the very beginning of the
+                * system's life, it's an __init function), something is
+                * terribly wrong and panic'ing on a NULL-pointer
+                * dereference sounds like a perfect choice.
+                */
                rtpn->rb_root = RB_ROOT;
                rtpn->rb_rightmost = NULL;
                spin_lock_init(&rtpn->lock);

