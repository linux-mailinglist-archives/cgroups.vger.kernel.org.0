Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72FD747CB8
	for <lists+cgroups@lfdr.de>; Wed,  5 Jul 2023 07:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGEF4M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jul 2023 01:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjGEF4M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jul 2023 01:56:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F70B2;
        Tue,  4 Jul 2023 22:56:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qwpjg0YM2ztQV4;
        Wed,  5 Jul 2023 13:53:11 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 13:56:02 +0800
Subject: Re: [PATCH] cgroup/cpuset: simplify the percpu kthreads check in
 update_tasks_cpumask()
To:     Waiman Long <longman@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tj@kernel.org>, <hannes@cmpxchg.org>, <lizefan.x@bytedance.com>
References: <20230704113049.1019118-1-linmiaohe@huawei.com>
 <bc8202fd-a31c-2b08-bd01-8b5868aab230@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <33c2bf85-6def-fce9-9ea7-3b3e80db67b7@huawei.com>
Date:   Wed, 5 Jul 2023 13:56:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bc8202fd-a31c-2b08-bd01-8b5868aab230@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2023/7/5 11:14, Waiman Long wrote:
> On 7/4/23 07:30, Miaohe Lin wrote:
>> kthread_is_per_cpu() can be called directly without checking whether
>> PF_KTHREAD is set in task->flags. So remove PF_KTHREAD check to make
>> code more concise.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 58e6f18f01c1..601c40da8e03 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1230,7 +1230,7 @@ static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>>               /*
>>                * Percpu kthreads in top_cpuset are ignored
>>                */
>> -            if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
>> +            if (kthread_is_per_cpu(task))
>>                   continue;
>>               cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
>>           } else {
> 
> The initial intention was to ignore only percpu kthreads. The current code likely ignore all the kthreads. Removing the PF_KTHREAD flag, however, may introduce unexpected regression at this point. I would like to hold off for now until more investigation are done.

IMHO, the current code will ignore only percpu kthreads:
  1.If PF_KTHREAD is set in task->flags, this patch doesn't make any difference.
  2.If PF_KTHREAD is not set in task->flags, kthread_is_per_cpu will *always return false*. So this patch doesn't make any functional change.

    bool kthread_is_per_cpu(struct task_struct *p)
    {
        struct kthread *kthread = __to_kthread(p);
	if (!kthread)
		return false;
        ....
    }

    static inline struct kthread *__to_kthread(struct task_struct *p)
    {
	void *kthread = p->worker_private;
	if (kthread && !(p->flags & PF_KTHREAD))
			 ^^^^^^^^^^^^^^^^^^^^^^
			 PF_KTHREAD is not set, so kthread = NULL.
		kthread = NULL;
	return kthread;
    }

Or am I miss something? Thanks for comment and review.

