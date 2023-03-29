Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65CD6CEBD0
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjC2OjN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjC2OjA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 10:39:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDC658D
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680100477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rg0hjjPhbd8bR4OyWVmG4r7qsayd0ZEyOdGiFaBs47s=;
        b=Nmphvaagz89Cdp6BCLC4igWdJMeDLqJl44XRVzJrCY5Nrv9oACwp73LeC/ACducgkxSmFE
        wsgI2URzlk5kPrjy7NmAB2GGHwPY1K2QSTsrbwtx1keybe6UjssZV9wVFzgcf8uY9mT0ye
        yWO4ptQkHKbneKundcqkHU1aeJDn+HQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-c3kauuTsND28J5VKTO15TQ-1; Wed, 29 Mar 2023 10:31:18 -0400
X-MC-Unique: c3kauuTsND28J5VKTO15TQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2534129AA3B3;
        Wed, 29 Mar 2023 14:31:17 +0000 (UTC)
Received: from [10.22.34.224] (unknown [10.22.34.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 053784020C83;
        Wed, 29 Mar 2023 14:31:15 +0000 (UTC)
Message-ID: <f8baea06-eeda-439a-3699-1cad7cde659e@redhat.com>
Date:   Wed, 29 Mar 2023 10:31:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/6] cgroup/cpuset: Free DL BW in case can_attach() fails
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329125558.255239-6-juri.lelli@redhat.com>
 <f8dfc30b-5079-2f44-7ab1-42ac25bd48b7@redhat.com>
In-Reply-To: <f8dfc30b-5079-2f44-7ab1-42ac25bd48b7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 3/29/23 10:25, Waiman Long wrote:
>
> On 3/29/23 08:55, Juri Lelli wrote:
>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>
>> cpuset_can_attach() can fail. Postpone DL BW allocation until all tasks
>> have been checked. DL BW is not allocated per-task but as a sum over
>> all DL tasks migrating.
>>
>> If multiple controllers are attached to the cgroup next to the cuset
> Typo: : "cuset" => "cpuset"
>> controller a non-cpuset can_attach() can fail. In this case free DL BW
>> in cpuset_cancel_attach().
>>
>> Finally, update cpuset DL task count (nr_deadline_tasks) only in
>> cpuset_attach().
>>
>> Suggested-by: Waiman Long <longman@redhat.com>
>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> ---
>>   include/linux/sched.h  |  2 +-
>>   kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++++++++++----
>>   kernel/sched/core.c    | 17 ++-----------
>>   3 files changed, 53 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 6f3d84e0ed08..50cbbfefbe11 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1847,7 +1847,7 @@ current_restore_flags(unsigned long orig_flags, 
>> unsigned long flags)
>>   }
>>     extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, 
>> const struct cpumask *trial);
>> -extern int task_can_attach(struct task_struct *p, const struct 
>> cpumask *cs_effective_cpus);
>> +extern int task_can_attach(struct task_struct *p);
>>   extern int dl_bw_alloc(int cpu, u64 dl_bw);
>>   extern void dl_bw_free(int cpu, u64 dl_bw);
>>   #ifdef CONFIG_SMP
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index eb0854ef9757..f8ebec66da51 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -198,6 +198,8 @@ struct cpuset {
>>        * know when to rebuild associated root domain bandwidth 
>> information.
>>        */
>>       int nr_deadline_tasks;
>> +    int nr_migrate_dl_tasks;
>> +    u64 sum_migrate_dl_bw;
>>         /* Invalid partition error code, not lock protected */
>>       enum prs_errcode prs_err;
>> @@ -2464,16 +2466,23 @@ static int fmeter_getrate(struct fmeter *fmp)
>>     static struct cpuset *cpuset_attach_old_cs;
>>   +static void reset_migrate_dl_data(struct cpuset *cs)
>> +{
>> +    cs->nr_migrate_dl_tasks = 0;
>> +    cs->sum_migrate_dl_bw = 0;
>> +}
>> +
>>   /* Called by cgroups to determine if a cpuset is usable; 
>> cpuset_mutex held */
>>   static int cpuset_can_attach(struct cgroup_taskset *tset)
>>   {
>>       struct cgroup_subsys_state *css;
>> -    struct cpuset *cs;
>> +    struct cpuset *cs, *oldcs;
>>       struct task_struct *task;
>>       int ret;
>>         /* used later by cpuset_attach() */
>>       cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
>> +    oldcs = cpuset_attach_old_cs;
>>       cs = css_cs(css);
>>         mutex_lock(&cpuset_mutex);
>> @@ -2491,7 +2500,7 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>           goto out_unlock;
>>         cgroup_taskset_for_each(task, css, tset) {
>> -        ret = task_can_attach(task, cs->effective_cpus);
>> +        ret = task_can_attach(task);
>>           if (ret)
>>               goto out_unlock;
>>           ret = security_task_setscheduler(task);
>> @@ -2499,11 +2508,31 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>               goto out_unlock;
>>             if (dl_task(task)) {
>> -            cs->nr_deadline_tasks++;
>> -            cpuset_attach_old_cs->nr_deadline_tasks--;
>> +            cs->nr_migrate_dl_tasks++;
>> +            cs->sum_migrate_dl_bw += task->dl.dl_bw;
>> +        }
>> +    }
>> +
>> +    if (!cs->nr_migrate_dl_tasks)
>> +        goto out_succes;
>> +
>> +    if (!cpumask_intersects(oldcs->effective_cpus, 
>> cs->effective_cpus)) {
>> +        int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
>> +
>> +        if (unlikely(cpu >= nr_cpu_ids)) {
>> +            reset_migrate_dl_data(cs);
>> +            ret = -EINVAL;
>> +            goto out_unlock;
>> +        }
>> +
>> +        ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
>> +        if (ret) {
>> +            reset_migrate_dl_data(cs);
>> +            goto out_unlock;
>>           }
>>       }
>>   +out_succes:
>>       /*
>>        * Mark attach is in progress.  This makes validate_change() fail
>>        * changes which zero cpus/mems_allowed.
>> @@ -2518,11 +2547,21 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>   static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>>   {
>>       struct cgroup_subsys_state *css;
>> +    struct cpuset *cs;
>>         cgroup_taskset_first(tset, &css);
>> +    cs = css_cs(css);
>>         mutex_lock(&cpuset_mutex);
>> -    css_cs(css)->attach_in_progress--;
>> +    cs->attach_in_progress--;
>> +
>> +    if (cs->nr_migrate_dl_tasks) {
>> +        int cpu = cpumask_any(cs->effective_cpus);
>> +
>> +        dl_bw_free(cpu, cs->sum_migrate_dl_bw);
>> +        reset_migrate_dl_data(cs);
>> +    }
>> +

Another nit that I have is that you may have to record also the cpu 
where the DL bandwidth is allocated in cpuset_can_attach() and free the 
bandwidth back into that cpu or there can be an underflow if another cpu 
is chosen.

Cheers,
Longman

