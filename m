Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB968A0FC
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjBCR4n (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 12:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjBCR4m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 12:56:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC1AE855
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 09:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675446944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IsT74lXaleAqNu3cG33QKLIiwscwT+dGYwdDteqTsJM=;
        b=C/gbdY1DwDHmRGYdR2kcrwPE9P6nz0IrVPnv3Bp7Md4YPBZXsStCM1wNvweJ7TNMQ+pvJI
        m451Nvc4Qq04leFlqjUEPBwBX6wFThThPxH3s7y7W8mryjbR2lpgW1J9iQUnnZHX8LQfYg
        J2T81pFxr+09q0zGgnUFc3UO89A+hHA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-Lojh2qUDO-SUQZCyS7X_nw-1; Fri, 03 Feb 2023 12:55:39 -0500
X-MC-Unique: Lojh2qUDO-SUQZCyS7X_nw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90BDD3C0D18C;
        Fri,  3 Feb 2023 17:55:38 +0000 (UTC)
Received: from [10.22.18.35] (unknown [10.22.18.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9F64112132C;
        Fri,  3 Feb 2023 17:55:37 +0000 (UTC)
Message-ID: <12eaf117-b455-1e81-50e2-e80a39d4f274@redhat.com>
Date:   Fri, 3 Feb 2023 12:55:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] cpuset: Call set_cpus_allowed_ptr() with appropriate
 mask for task
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-3-will@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230131221719.3176-3-will@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/23 17:17, Will Deacon wrote:
> set_cpus_allowed_ptr() will fail with -EINVAL if the requested
> affinity mask is not a subset of the task_cpu_possible_mask() for the
> task being updated. Consequently, on a heterogeneous system with cpusets
> spanning the different CPU types, updates to the cgroup hierarchy can
> silently fail to update task affinities when the effective affinity
> mask for the cpuset is expanded.
>
> For example, consider an arm64 system with 4 CPUs, where CPUs 2-3 are
> the only cores capable of executing 32-bit tasks. Attaching a 32-bit
> task to a cpuset containing CPUs 0-2 will correctly affine the task to
> CPU 2. Extending the cpuset to CPUs 0-3, however, will fail to extend
> the affinity mask of the 32-bit task because update_tasks_cpumask() will
> pass the full 0-3 mask to set_cpus_allowed_ptr().
>
> Extend update_tasks_cpumask() to take a temporary 'cpumask' paramater
> and use it to mask the 'effective_cpus' mask with the possible mask for
> each task being updated.
>
> Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>
> Note: We wondered whether it was worth calling guarantee_online_cpus()
> if the cpumask_and() returns 0 in update_tasks_cpumask(), but given that
> this path is only called when the effective mask changes, it didn't
> seem appropriate. Ultimately, if you have 32-bit tasks attached to a
> cpuset containing only 64-bit cpus, then the affinity is going to be
> forced.
>
>   kernel/cgroup/cpuset.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 8552cc2c586a..f15fb0426707 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1205,12 +1205,13 @@ void rebuild_sched_domains(void)
>   /**
>    * update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
>    * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
> + * @new_cpus: the temp variable for the new effective_cpus mask
>    *
>    * Iterate through each task of @cs updating its cpus_allowed to the
>    * effective cpuset's.  As this function is called with cpuset_rwsem held,
>    * cpuset membership stays stable.
>    */
> -static void update_tasks_cpumask(struct cpuset *cs)
> +static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>   {
>   	struct css_task_iter it;
>   	struct task_struct *task;
> @@ -1224,7 +1225,10 @@ static void update_tasks_cpumask(struct cpuset *cs)
>   		if (top_cs && (task->flags & PF_KTHREAD) &&
>   		    kthread_is_per_cpu(task))
>   			continue;
> -		set_cpus_allowed_ptr(task, cs->effective_cpus);
> +
> +		cpumask_and(new_cpus, cs->effective_cpus,
> +			    task_cpu_possible_mask(task));
> +		set_cpus_allowed_ptr(task, new_cpus);
>   	}
>   	css_task_iter_end(&it);
>   }
> @@ -1509,7 +1513,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
>   	spin_unlock_irq(&callback_lock);
>   
>   	if (adding || deleting)
> -		update_tasks_cpumask(parent);
> +		update_tasks_cpumask(parent, tmp->new_cpus);
>   
>   	/*
>   	 * Set or clear CS_SCHED_LOAD_BALANCE when partcmd_update, if necessary.
> @@ -1661,7 +1665,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   		WARN_ON(!is_in_v2_mode() &&
>   			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
>   
> -		update_tasks_cpumask(cp);
> +		update_tasks_cpumask(cp, tmp->new_cpus);
>   
>   		/*
>   		 * On legacy hierarchy, if the effective cpumask of any non-
> @@ -2309,7 +2313,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   		}
>   	}
>   
> -	update_tasks_cpumask(parent);
> +	update_tasks_cpumask(parent, tmpmask.new_cpus);
>   
>   	if (parent->child_ecpus_count)
>   		update_sibling_cpumasks(parent, cs, &tmpmask);
> @@ -3347,7 +3351,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
>   	 * as the tasks will be migrated to an ancestor.
>   	 */
>   	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
> -		update_tasks_cpumask(cs);
> +		update_tasks_cpumask(cs, new_cpus);
>   	if (mems_updated && !nodes_empty(cs->mems_allowed))
>   		update_tasks_nodemask(cs);
>   
> @@ -3384,7 +3388,7 @@ hotplug_update_tasks(struct cpuset *cs,
>   	spin_unlock_irq(&callback_lock);
>   
>   	if (cpus_updated)
> -		update_tasks_cpumask(cs);
> +		update_tasks_cpumask(cs, new_cpus);
>   	if (mems_updated)
>   		update_tasks_nodemask(cs);
>   }

Acked-by: Waiman Long <longman@redhat.com>

This change is good for backporting to stable releases. For the latest 
kernel, I will prefer to centralize the masking in 
__set_cpus_allowed_ptr() where a scratch_mask is already being used for 
masking purpose. Let get this patch merged now, I will send a patch to 
move off the masking afterward.

Cheers,
Longman


