Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DAE6391A3
	for <lists+cgroups@lfdr.de>; Fri, 25 Nov 2022 23:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiKYWxF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Nov 2022 17:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKYWxC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Nov 2022 17:53:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B059532DD
        for <cgroups@vger.kernel.org>; Fri, 25 Nov 2022 14:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669416722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SzvRXW76btfy/JOc5ym9c3+SoFVqAx5jbHxLD+PWPus=;
        b=F/wXTedJEJJrQiq2y+J4yQ5KbW5t6AOjH0trgnFR9MU/25ZTyYitkcyR8HdY/BWuWWFrQo
        4qy+h12FT9muLIO6L7I993oXcqmUyWCkQKiFyhBj1+7Ir1gK08KryxL3LPtBpbxCl5N1W5
        CtBiXwhcanmuUgdYGhpMZd9K5F5CAtE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-CMzuFlNZO6C7D_bc4tueXA-1; Fri, 25 Nov 2022 17:51:57 -0500
X-MC-Unique: CMzuFlNZO6C7D_bc4tueXA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6410101A528;
        Fri, 25 Nov 2022 22:51:56 +0000 (UTC)
Received: from [10.22.16.41] (unknown [10.22.16.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18BA39E70;
        Fri, 25 Nov 2022 22:51:56 +0000 (UTC)
Message-ID: <991abacd-ba35-f06c-6f25-793d3e45926e@redhat.com>
Date:   Fri, 25 Nov 2022 17:51:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup/cpuset: Clean up cpuset_task_status_allowed
Content-Language: en-US
To:     "haifeng.xu" <haifeng.xu@shopee.com>
Cc:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125075133.12718-1-haifeng.xu@shopee.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221125075133.12718-1-haifeng.xu@shopee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/25/22 02:51, haifeng.xu wrote:
> cpuset_task_status_allowed just shows mems_allowed status, so
> rename it to task_mems_allowed. Moreover, it's only used in
> proc_pid_status, so move it to fs/proc/array.c. There is no
> intentional function change.
>
> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
> ---
>   fs/proc/array.c        | 13 +++++++++++--
>   include/linux/cpuset.h |  7 -------
>   kernel/cgroup/cpuset.c |  9 ---------
>   3 files changed, 11 insertions(+), 18 deletions(-)
>
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 49283b8103c7..e6cdef8387e6 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -80,7 +80,6 @@
>   #include <linux/file.h>
>   #include <linux/fdtable.h>
>   #include <linux/times.h>
> -#include <linux/cpuset.h>
>   #include <linux/rcupdate.h>
>   #include <linux/delayacct.h>
>   #include <linux/seq_file.h>
> @@ -413,6 +412,16 @@ static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
>   		   cpumask_pr_args(&task->cpus_mask));
>   }
>   
> +static void task_mems_allowed(struct seq_file *m, struct task_struct *task)
> +{
> +#ifdef CONFIG_CPUSETS
> +	seq_printf(m, "Mems_allowed:\t%*pb\n",
> +		   nodemask_pr_args(&task->mems_allowed));
> +	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
> +		   nodemask_pr_args(&task->mems_allowed));
> +#endif
> +}
> +
>   static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
>   {
>   	seq_put_decimal_ull(m, "CoreDumping:\t", !!task->signal->core_state);
> @@ -449,7 +458,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
>   	task_cap(m, task);
>   	task_seccomp(m, task);
>   	task_cpus_allowed(m, task);
> -	cpuset_task_status_allowed(m, task);
> +	task_mems_allowed(m, task);
>   	task_context_switch_counts(m, task);
>   	return 0;
>   }
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index d58e0476ee8e..30b91116dd2f 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -112,8 +112,6 @@ extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
>   extern int cpuset_memory_pressure_enabled;
>   extern void __cpuset_memory_pressure_bump(void);
>   
> -extern void cpuset_task_status_allowed(struct seq_file *m,
> -					struct task_struct *task);
>   extern int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>   			    struct pid *pid, struct task_struct *tsk);
>   
> @@ -246,11 +244,6 @@ static inline int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
>   
>   static inline void cpuset_memory_pressure_bump(void) {}
>   
> -static inline void cpuset_task_status_allowed(struct seq_file *m,
> -						struct task_struct *task)
> -{
> -}
> -
>   static inline int cpuset_mem_spread_node(void)
>   {
>   	return 0;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 589827ccda8b..5798d4231662 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4045,12 +4045,3 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>   	return retval;
>   }
>   #endif /* CONFIG_PROC_PID_CPUSET */
> -
> -/* Display task mems_allowed in /proc/<pid>/status file. */
> -void cpuset_task_status_allowed(struct seq_file *m, struct task_struct *task)
> -{
> -	seq_printf(m, "Mems_allowed:\t%*pb\n",
> -		   nodemask_pr_args(&task->mems_allowed));
> -	seq_printf(m, "Mems_allowed_list:\t%*pbl\n",
> -		   nodemask_pr_args(&task->mems_allowed));
> -}

It is just a minor cleanup. I think that is OK.

Acked-by: Waiman Long <longman@redhat.com>

