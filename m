Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AACE6CDCB9
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjC2Ofv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 10:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjC2Of1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 10:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A2DB465
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680100180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kx85hyXfvvLNqL0NEid1RaaN8H67N4c0vjreeRx/a58=;
        b=VOB7jqug9zujbWGRyZg3Qnh93ATvuevYkfPSF0qktnUocSfsaXej95BNDn1VpM1YBl7q96
        lQ+qjPyyGxr3bgw9gpPsqsSxXjb8KCzTTMECfko5XM7xBZuRYlDnY1avJS8yWomoavJdRj
        33wNWb5GPFNsnasvqhFLTsbzZuGL2/E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-0dop_cEXNCS7w8AzU7mZlQ-1; Wed, 29 Mar 2023 10:26:16 -0400
X-MC-Unique: 0dop_cEXNCS7w8AzU7mZlQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C234A185A7AC;
        Wed, 29 Mar 2023 14:24:18 +0000 (UTC)
Received: from [10.22.34.224] (unknown [10.22.34.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B1302166B33;
        Wed, 29 Mar 2023 14:24:14 +0000 (UTC)
Message-ID: <1d08d661-fbd1-bd94-d6f0-94941ba7a0e2@redhat.com>
Date:   Wed, 29 Mar 2023 10:24:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 4/6] sched/deadline: Create DL BW alloc, free & check
 overflow interface
Content-Language: en-US
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
 <20230329125558.255239-5-juri.lelli@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230329125558.255239-5-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 3/29/23 08:55, Juri Lelli wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> Rework the existing dl_cpu_busy() interface which offers DL BW overflow
> checking and per-task DL BW allocation.
>
> Add dl_bw_free() as an interface to be able to free DL BW.
> It will be used to allow freeing of the DL BW request done during
> cpuset_can_attach() in case multiple controllers are attached to the
> cgroup next to the cpuset controller and one of the non-cpuset
> can_attach() fails.
>
> dl_bw_alloc() (and dl_bw_free()) now take a `u64 dl_bw` parameter
> instead of `struct task_struct *p` used in dl_cpu_busy().  This allows
> to allocate DL BW for a set of tasks too rater than only for a single
Typo: "rater" => "rather"
> task.
>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>   include/linux/sched.h   |  2 ++
>   kernel/sched/core.c     |  4 ++--
>   kernel/sched/deadline.c | 53 +++++++++++++++++++++++++++++++----------
>   kernel/sched/sched.h    |  2 +-
>   4 files changed, 45 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6d654eb4cabd..6f3d84e0ed08 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1848,6 +1848,8 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
>   
>   extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
>   extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
> +extern int dl_bw_alloc(int cpu, u64 dl_bw);
> +extern void dl_bw_free(int cpu, u64 dl_bw);
>   #ifdef CONFIG_SMP
>   extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
>   extern int set_cpus_allowed_ptr(struct task_struct *p, const struct cpumask *new_mask);
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 179266ff653f..c83dae6b8586 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9294,7 +9294,7 @@ int task_can_attach(struct task_struct *p,
>   
>   		if (unlikely(cpu >= nr_cpu_ids))
>   			return -EINVAL;
> -		ret = dl_cpu_busy(cpu, p);
> +		ret = dl_bw_alloc(cpu, p->dl.dl_bw);
>   	}
>   
>   out:
> @@ -9579,7 +9579,7 @@ static void cpuset_cpu_active(void)
>   static int cpuset_cpu_inactive(unsigned int cpu)
>   {
>   	if (!cpuhp_tasks_frozen) {
> -		int ret = dl_cpu_busy(cpu, NULL);
> +		int ret = dl_bw_check_overflow(cpu);
>   
>   		if (ret)
>   			return ret;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8f92f0f87383..5b6965e0e537 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3057,26 +3057,38 @@ int dl_cpuset_cpumask_can_shrink(const struct cpumask *cur,
>   	return ret;
>   }
>   
> -int dl_cpu_busy(int cpu, struct task_struct *p)
> +enum dl_bw_request {
> +	dl_bw_req_check_overflow = 0,
> +	dl_bw_req_alloc,
> +	dl_bw_req_free
> +};
> +
> +static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
>   {
> -	unsigned long flags, cap;
> +	unsigned long flags;
>   	struct dl_bw *dl_b;
> -	bool overflow;
> +	bool overflow = 0;
>   
>   	rcu_read_lock_sched();
>   	dl_b = dl_bw_of(cpu);
>   	raw_spin_lock_irqsave(&dl_b->lock, flags);
> -	cap = dl_bw_capacity(cpu);
> -	overflow = __dl_overflow(dl_b, cap, 0, p ? p->dl.dl_bw : 0);
>   
> -	if (!overflow && p) {
> -		/*
> -		 * We reserve space for this task in the destination
> -		 * root_domain, as we can't fail after this point.
> -		 * We will free resources in the source root_domain
> -		 * later on (see set_cpus_allowed_dl()).
> -		 */
> -		__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
> +	if (req == dl_bw_req_free) {
> +		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
> +	} else {
> +		unsigned long cap = dl_bw_capacity(cpu);
> +
> +		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
> +
> +		if (req == dl_bw_req_alloc && !overflow) {
> +			/*
> +			 * We reserve space in the destination
> +			 * root_domain, as we can't fail after this point.
> +			 * We will free resources in the source root_domain
> +			 * later on (see set_cpus_allowed_dl()).
> +			 */
> +			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
> +		}
>   	}
>   
>   	raw_spin_unlock_irqrestore(&dl_b->lock, flags);
> @@ -3084,6 +3096,21 @@ int dl_cpu_busy(int cpu, struct task_struct *p)
>   
>   	return overflow ? -EBUSY : 0;
>   }
> +
> +int dl_bw_check_overflow(int cpu)
> +{
> +	return dl_bw_manage(dl_bw_req_check_overflow, cpu, 0);
> +}
> +
> +int dl_bw_alloc(int cpu, u64 dl_bw)
> +{
> +	return dl_bw_manage(dl_bw_req_alloc, cpu, dl_bw);
> +}
> +
> +void dl_bw_free(int cpu, u64 dl_bw)
> +{
> +	dl_bw_manage(dl_bw_req_free, cpu, dl_bw);
> +}
>   #endif
>   
>   #ifdef CONFIG_SCHED_DEBUG
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 060616944d7a..81ecfd1a1a48 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -330,7 +330,7 @@ extern void __getparam_dl(struct task_struct *p, struct sched_attr *attr);
>   extern bool __checkparam_dl(const struct sched_attr *attr);
>   extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *attr);
>   extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
> -extern int  dl_cpu_busy(int cpu, struct task_struct *p);
> +extern int  dl_bw_check_overflow(int cpu);
>   
>   #ifdef CONFIG_CGROUP_SCHED
>   

