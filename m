Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614FD6D06D7
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjC3Nea (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 09:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjC3Ne3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 09:34:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AFA2AF02;
        Thu, 30 Mar 2023 06:34:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D589B2F4;
        Thu, 30 Mar 2023 06:34:55 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA3FC3F663;
        Thu, 30 Mar 2023 06:34:07 -0700 (PDT)
Message-ID: <67eeb47c-ae23-1389-bb52-f9cfb3206741@arm.com>
Date:   Thu, 30 Mar 2023 15:34:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6/7] cgroup/cpuset: Protect DL BW data against parallel
 cpuset_attach()
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
 <20230329160240.2093277-1-longman@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230329160240.2093277-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 29/03/2023 18:02, Waiman Long wrote:
> It is possible to have parallel attach operations to the same cpuset in
> progress. To avoid possible corruption of single set of DL BW data in
> the cpuset structure, we have to disallow parallel attach operations if
> DL tasks are present. Attach operations can still proceed in parallel
> as long as no DL tasks are involved.
> 
> This patch also stores the CPU where DL BW is allocated and free that BW
> back to the same CPU in case cpuset_can_attach() is called.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 05c0a1255218..555a6b1a2b76 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -199,6 +199,7 @@ struct cpuset {
>  	 */
>  	int nr_deadline_tasks;
>  	int nr_migrate_dl_tasks;
> +	int dl_bw_cpu;

Like I mentioned in
https://lkml.kernel.org/r/cdede77a-5dc5-8933-a444-a2046b074b12@arm.com
IMHO any CPU of the cpuset is fine since exclusive cpuset and related
root_domain (as the container for DL BW accounting data) are congruent
in terms of cpumask.

>  	u64 sum_migrate_dl_bw;
>  
>  	/* Invalid partition error code, not lock protected */
> @@ -2502,6 +2503,16 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	if (cpumask_empty(cs->effective_cpus))
>  		goto out_unlock;
>  
> +	/*
> +	 * If there is another parallel attach operations in progress for
> +	 * the same cpuset, the single set of DL data there may get
> +	 * incorrectly overwritten. So parallel operations are not allowed
> +	 * if DL tasks are present.
> +	 */
> +	ret = -EBUSY;
> +	if (cs->nr_migrate_dl_tasks)
> +		goto out_unlock;

(1)

>  	cgroup_taskset_for_each(task, css, tset) {
>  		ret = task_can_attach(task);
>  		if (ret)
> @@ -2511,6 +2522,9 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  			goto out_unlock;
>  
>  		if (dl_task(task)) {
> +			if (cs->attach_in_progress)
> +				goto out_unlock;

(2)

Just to check if I get this right, 2 bail-out conditions are necessary
because:

(1) is to prevent any new cs attach if there is already a DL cs attach
and (2) is to prevent a new DL cs attach if there is already a non-DL cs
attach.

>  			cs->nr_migrate_dl_tasks++;
>  			cs->sum_migrate_dl_bw += task->dl.dl_bw;
>  		}

[...]

