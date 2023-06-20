Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81373627A
	for <lists+cgroups@lfdr.de>; Tue, 20 Jun 2023 06:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjFTEDF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Jun 2023 00:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFTEDE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Jun 2023 00:03:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8FD133;
        Mon, 19 Jun 2023 21:03:02 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QlXzL28Jgz1HBJh;
        Tue, 20 Jun 2023 12:02:54 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 20 Jun 2023 12:02:59 +0800
Subject: Re: [PATCH] cgroup/cpuset: remove unneeded nodes_or() in
 cpuset_change_task_nodemask()
To:     Waiman Long <longman@redhat.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230617083043.2065556-1-linmiaohe@huawei.com>
 <c32a0bad-b20f-e53b-a38a-5da687b8a205@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6f3e30f7-8781-2cf3-07a5-b0635c7d9045@huawei.com>
Date:   Tue, 20 Jun 2023 12:02:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c32a0bad-b20f-e53b-a38a-5da687b8a205@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/6/19 22:37, Waiman Long wrote:
> On 6/17/23 04:30, Miaohe Lin wrote:
>> The tsk->mems_allowed is changed before calling mpol_rebind_task() and
>> being reassigned right after it. But tsk->mems_allowed is not needed
>> inside mpol_rebind_task(). So remove unneeded tsk->mems_allowed modify
>> via nodes_or() here.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 58e6f18f01c1..33a429c1179f 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1941,7 +1941,6 @@ static void cpuset_change_task_nodemask(struct task_struct *tsk,
>>       local_irq_disable();
>>       write_seqcount_begin(&tsk->mems_allowed_seq);
>>   -    nodes_or(tsk->mems_allowed, tsk->mems_allowed, *newmems);
>>       mpol_rebind_task(tsk, newmems);
>>       tsk->mems_allowed = *newmems;
>>   
> 
> That line was inserted by commit cc9a6c8776615 ("cpuset: mm: reduce large amounts of memory barrier related damage v3"). At first glance, it does looks like it is not necessary. However, I am not sure if a race is possible that will produce a false failure because of missing this line.
> 

Thanks for your comment. IMHO, the code is protected with mems_allowed_seq seqlock. So it should be fine even if there's a race.
I will take a closer look to make sure whether race exists.

> My 2 cents.

Thanks.

> 
> Cheers,
> Longman
> 
> .

