Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD0568AE58
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 06:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBEFBX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 00:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBEFBW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 00:01:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE9D2197D
        for <cgroups@vger.kernel.org>; Sat,  4 Feb 2023 21:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675573230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/39ZHnJJrBjqpsMrRv1iOmOjWEeCnAqD8v2VDFeVHc=;
        b=ICIjr6Y8E5+wSSj2stDF+gkUc3S6CRYLxcleYtqK3aSUGIudG8ceppaGUHLZ3xjxxYOmFG
        MLOk2ak0C6fYJj3OHdNn1TwAb2FhdnR4ACEaAk94mO2fJrMZOTURHsxVld156ddubKibDT
        hgImll1fqaSGwD9UnQklCboMlqoLGgs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-364-VGQ7nkP8N9unxD8_e27KAA-1; Sun, 05 Feb 2023 00:00:27 -0500
X-MC-Unique: VGQ7nkP8N9unxD8_e27KAA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87ADA29AA2DB;
        Sun,  5 Feb 2023 05:00:26 +0000 (UTC)
Received: from [10.22.16.69] (unknown [10.22.16.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4E4C15BA0;
        Sun,  5 Feb 2023 05:00:25 +0000 (UTC)
Message-ID: <f356b916-1c10-1565-73fb-34027c6c510a@redhat.com>
Date:   Sun, 5 Feb 2023 00:00:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
References: <20230203164040.213437-1-longman@redhat.com>
 <Y94s8mzrE9VyUJLa@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y94s8mzrE9VyUJLa@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/4/23 05:01, Peter Zijlstra wrote:
> On Fri, Feb 03, 2023 at 11:40:40AM -0500, Waiman Long wrote:
>> Since commit 8f9ea86fdf99 ("sched: Always preserve the user
>> requested cpumask"), relax_compatible_cpus_allowed_ptr() is calling
>> __sched_setaffinity() unconditionally. This helps to expose a bug in
>> the current cpuset hotplug code where the cpumasks of the tasks in
>> the top cpuset are not updated at all when some CPUs become online or
>> offline. It is likely caused by the fact that some of the tasks in the
>> top cpuset, like percpu kthreads, cannot have their cpu affinity changed.
>>
>> One way to reproduce this as suggested by Peter is:
>>   - boot machine
>>   - offline all CPUs except one
>>   - taskset -p ffffffff $$
>>   - online all CPUs
>>
>> Fix this by allowing cpuset_cpus_allowed() to return a wider mask that
>> includes offline CPUs for those tasks that are in the top cpuset. For
>> tasks not in the top cpuset, the old rule applies and only online CPUs
>> will be returned in the mask since hotplug events will update their
>> cpumasks accordingly.
> So you get the task_cpu_possible_mask() interaction vs cpusets horribly
> wrong here, but given the very sorry state of task_cpu_possible_mask()
> correctness of cpuset as a whole that might just not matter at this
> point.
>
> I do very much hate how you add exceptions on exceptions instead of
> looking to do something right :-(
>
> Fixing that parition case in my patch is 1 extra line and then I think
> it fundamentally does the right thing and can serve as a basis for
> fixing cpuset as a whole.

I am not saying that your patch is incorrect other than handling the 
partition case. However, it is rather complex and is hard to understand 
especially for those that are not that familiar with the cpuset code. 
 From the maintainability point of view, a simpler solution that is 
easier to understand is better.

If we want to get it into the next merge windows, there isn't much time 
left for linux-next testing. So a lower risk solution is better from 
that perspective too.

>> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
>> Reported-by: Will Deacon <will@kernel.org>
>> Originally-from: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 207bafdb05e8..11554e5845f7 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3707,15 +3707,38 @@ void __init cpuset_init_smp(void)
>>    * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
>>    * attached to the specified @tsk.  Guaranteed to return some non-empty
>>    * subset of cpu_online_mask, even if this means going outside the
>> - * tasks cpuset.
>> + * tasks cpuset, except when the task is in the top cpuset.
>>    **/
>>   
>>   void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>>   {
>>   	unsigned long flags;
>> +	struct cpuset *cs;
>>   
>>   	spin_lock_irqsave(&callback_lock, flags);
>> -	guarantee_online_cpus(tsk, pmask);
>> +	rcu_read_lock();
>> +
>> +	cs = task_cs(tsk);
>> +	if (cs != &top_cpuset)
>> +		guarantee_online_cpus(tsk, pmask);
>> +	/*
>> +	 * TODO: Tasks in the top cpuset won't get update to their cpumasks
>> +	 * when a hotplug online/offline event happens. So we include all
>> +	 * offline cpus in the allowed cpu list.
>> +	 */
> I don't like TODO there, I really don't think CPUSET should update root
> tasks, that means yet another fundamental difference between
> CPUSET={y,n}.
OK, I can remove the "TODO". I have no objection to that.
>
>> +	if ((cs == &top_cpuset) || cpumask_empty(pmask)) {
>> +		const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
>> +
>> +		/*
>> +		 * We first exclude cpus allocated to partitions. If there is no
>> +		 * allowable online cpu left, we fall back to all possible cpus.
>> +		 */
>> +		cpumask_andnot(pmask, possible_mask, top_cpuset.subparts_cpus);
>> +		if (!cpumask_intersects(pmask, cpu_online_mask))
>> +			cpumask_copy(pmask, possible_mask);
>> +	}
>> +
>> +	rcu_read_unlock();
>>   	spin_unlock_irqrestore(&callback_lock, flags);
>>   }
> I really detest this patch, but if you insist it might just do :-/

If we decide that we should always try to keep possible offline cpus in 
a task's cpumask. We could adopt your solution or we can try to keep 
that information in the cpuset structure itself. At this point, I don't 
see any advantage in doing that except for tasks in the top cpuset 
because the hotplug code won't update their cpumasks. Also inferring 
offline cpus that should be in the cpuset is only possible with cgroup 
v2. It does not work for v1. So it is also not a complete solution. To 
be complete, we may need keep this information in the cpuset.

Cheers,
Longman

