Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B07E3DB39D
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 08:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhG3GaE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 02:30:04 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:12334 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237264AbhG3GaE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 02:30:04 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gbcp03TGXz7ylT;
        Fri, 30 Jul 2021 14:25:12 +0800 (CST)
Received: from [10.174.178.209] (10.174.178.209) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Jul 2021 14:29:57 +0800
Subject: Re: [PATCH 4/5] mm, memcg: avoid possible NULL pointer dereferencing
 in mem_cgroup_init()
To:     Roman Gushchin <guro@fb.com>
CC:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <vdavydov.dev@gmail.com>, <akpm@linux-foundation.org>,
        <shakeelb@google.com>, <willy@infradead.org>, <alexs@kernel.org>,
        <richard.weiyang@gmail.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <cgroups@vger.kernel.org>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-5-linmiaohe@huawei.com> <YQNuK+jN7pZLJTvT@carbon.lan>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2a9353e0-9ece-d8d5-1387-202b01b0fdad@huawei.com>
Date:   Fri, 30 Jul 2021 14:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YQNuK+jN7pZLJTvT@carbon.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.209]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021/7/30 11:12, Roman Gushchin wrote:
> On Thu, Jul 29, 2021 at 08:57:54PM +0800, Miaohe Lin wrote:
>> rtpn might be NULL in very rare case. We have better to check it before
>> dereferencing it. Since memcg can live with NULL rb_tree_per_node in
>> soft_limit_tree, warn this case and continue.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memcontrol.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 5b4592d1e0f2..70a32174e7c4 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7109,6 +7109,8 @@ static int __init mem_cgroup_init(void)
>>  		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL,
>>  				    node_online(node) ? node : NUMA_NO_NODE);
>>  
>> +		if (WARN_ON_ONCE(!rtpn))
>> +			continue;
> 
> I also really doubt that it makes any sense to continue in this case.
> If this allocations fails (at the very beginning of the system's life, it's an __init function),
> something is terribly wrong and panic'ing on a NULL-pointer dereference sounds like
> a perfect choice.
> 
> Is this a real world problem? Do I miss something?

No, this is a theoretical bug, a very race case but not impossible IMO.
Since we can't live with NULL rb_tree_per_node in soft_limit_tree, I thinks
simply continue or break here without panic is also acceptable. Or is it
more proper to choose panic here?

Thanks.

> .
> 

