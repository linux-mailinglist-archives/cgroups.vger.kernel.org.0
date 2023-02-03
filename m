Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F5D68A62D
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 23:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjBCW1R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 17:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjBCW1L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 17:27:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08378B7E8
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675463180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rzqXvls55Lb3EZo0y3v4L8uFMO50qdSpk/N4RhFvVdI=;
        b=Cr5Xn5ZQbCemJ2p++pOKfeTAWazPOcOa8Dtg9dnhKMsdE3ga35Zf95A4YI+ZKhgwXVxmiS
        1Q2LxMlEOpDCVm7MfukP1UlX2qjJ2nOoLNLDqdfv5w5CtD5iq8LG3cZqZK5tid23LVn0zD
        72a/BcC5xNeebO1B3k+GopzfYxoBFpg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-y3oABivaM5WGaZRhMWCcNg-1; Fri, 03 Feb 2023 17:26:14 -0500
X-MC-Unique: y3oABivaM5WGaZRhMWCcNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B95D329AA39C;
        Fri,  3 Feb 2023 22:26:13 +0000 (UTC)
Received: from [10.22.8.92] (unknown [10.22.8.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12D4C2166B34;
        Fri,  3 Feb 2023 22:26:13 +0000 (UTC)
Message-ID: <1f7fc2a9-259c-8f97-2f0c-a315c0266138@redhat.com>
Date:   Fri, 3 Feb 2023 17:26:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
References: <20230203164040.213437-1-longman@redhat.com>
 <Y9116OLfP6GoZ0ez@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Y9116OLfP6GoZ0ez@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/3/23 16:00, Tejun Heo wrote:
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
>>
>> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
>> Reported-by: Will Deacon <will@kernel.org>
>> Originally-from: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> So, this is the replacement for the first patch[1] Will posted, right?

Yes, if Will and Peter has no objection. I think it is less risky and 
handle the partition case better.

With v1, Will's patch should get similar result as the existing 
guarantee_online_cpus() function since we can infer offline cpus from 
cpus_allowed. With v2, it does include offline cpus correctly, I 
believe, as long as no partition is enabled. However, the hotplug code 
is able to update the cpumasks when a CPU is onlined. So the presence of 
offline CPUs is nice to have, but not essential.

>
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
>> +	if ((cs == &top_cpuset) || cpumask_empty(pmask)) {
>> +		const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
>> +
>> +		/*
>> +		 * We first exclude cpus allocated to partitions. If there is no
>> +		 * allowable online cpu left, we fall back to all possible cpus.
>> +		 */
>> +		cpumask_andnot(pmask, possible_mask, top_cpuset.subparts_cpus);
> and the differences are that
>
> * It's only applied to the root cgroup.
>
> * Cpus taken up by partitions are excluded.
>
> Is my understanding correct?
Yes, that is correct.
>
>> +		if (!cpumask_intersects(pmask, cpu_online_mask))
>> +			cpumask_copy(pmask, possible_mask);
>> +	}
>> +
>> +	rcu_read_unlock();
>>   	spin_unlock_irqrestore(&callback_lock, flags);
> So, I suppose you're suggesting applying this patch instead of the one Will
> Deacon posted[1] and we need Will's second patch[2] on top, right?
Right. Let hear if Will and Peter agree with this plan. I have tested 
this patch and it passed Peter's reproducer test correctly. During 
testing, I uncovered another bug in the cpu affinity code which results 
in a separate scheduler patch to fix it.
>
> [1] http://lkml.kernel.org/r/20230131221719.3176-3-will@kernel.org
> [2] http://lkml.kernel.org/r/20230131221719.3176-3-will@kernel.org
>
> Thanks.
Cheers,
Longman

