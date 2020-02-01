Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A09014F5F7
	for <lists+cgroups@lfdr.de>; Sat,  1 Feb 2020 04:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgBADDx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Jan 2020 22:03:53 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:45408 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgBADDx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Jan 2020 22:03:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580526232; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=g5YJIU6HDhXQS6ErNdq09HhEEvdNuOxlw+HNgly7NMk=; b=ta1Ei4Za54Ucb5OXUsg5q18ZTkdXBfHmq4AzUTSEtCyR4bvq32tlaAkyNyXgQifSsnUZmC4y
 NJH74Gjc1ybgMwKEsyTluUNbQulnIs2ZU8uJ0RpUvQy/Uz+vpKDJL7F2IDVeaeZaqpK3O+qu
 p0BjFWZD1sE3x8XST2hxynIP/KQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3MmZiMyIsICJjZ3JvdXBzQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e34ea94.7f83500eeed8-smtp-out-n01;
 Sat, 01 Feb 2020 03:03:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 971A8C433CB; Sat,  1 Feb 2020 03:03:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.3] (unknown [183.83.140.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 94EF4C43383;
        Sat,  1 Feb 2020 03:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94EF4C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH] cpuset: Make cpuset hotplug synchronous
To:     tj@kernel.org, peterz@infradead.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1579878449-10164-1-git-send-email-prsood@codeaurora.org>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <ee889f30-cb81-e0a8-6068-715ca3399fdd@codeaurora.org>
Date:   Sat, 1 Feb 2020 08:33:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1579878449-10164-1-git-send-email-prsood@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun & Peter,

Could you please share your feedback on this patch for making

cpuset_hotplug_workfn synchronous.


Thanks,

Prateek

On 1/24/2020 8:37 PM, Prateek Sood wrote:
> Hi Tejun & Peter,
>
> It seems that after following patch we can make cpuset_hotplug_workfn
> synchronous:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/kernel/cgroup/cpuset.c?h=v5.5-rc7&id=d74b27d63a8bebe2fe634944e4ebdc7b10db7a39
>
>
> Could you please share your opinion on the same and below patch.
>
> Thanks,
> Prateek
>
>> 8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8>8
> Convert cpuset_hotplug_workfn() into synchronous call for cpu hotplug
> path. For memory hotplug path it still gets queued as a work item.
>
> Since cpuset_hotplug_workfn() can be made synchronous for cpu hotplug
> path, it is not required to wait for cpuset hotplug while thawing
> processes.
>
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> ---
>   include/linux/cpuset.h |  3 ---
>   kernel/cgroup/cpuset.c | 31 +++++++++++++++++++------------
>   kernel/power/process.c |  2 --
>   3 files changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 04c20de66..cede4cb 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -54,7 +54,6 @@ static inline void cpuset_dec(void)
>   extern void cpuset_init_smp(void);
>   extern void cpuset_force_rebuild(void);
>   extern void cpuset_update_active_cpus(void);
> -extern void cpuset_wait_for_hotplug(void);
>   extern void cpuset_read_lock(void);
>   extern void cpuset_read_unlock(void);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
> @@ -176,8 +175,6 @@ static inline void cpuset_update_active_cpus(void)
>   	partition_sched_domains(1, NULL, NULL);
>   }
>   
> -static inline void cpuset_wait_for_hotplug(void) { }
> -
>   static inline void cpuset_read_lock(void) { }
>   static inline void cpuset_read_unlock(void) { }
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 58f5073..cafd4d2 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3101,7 +3101,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   }
>   
>   /**
> - * cpuset_hotplug_workfn - handle CPU/memory hotunplug for a cpuset
> + * cpuset_hotplug - handle CPU/memory hotunplug for a cpuset
>    *
>    * This function is called after either CPU or memory configuration has
>    * changed and updates cpuset accordingly.  The top_cpuset is always
> @@ -3116,7 +3116,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>    * Note that CPU offlining during suspend is ignored.  We don't modify
>    * cpusets across suspend/resume cycles at all.
>    */
> -static void cpuset_hotplug_workfn(struct work_struct *work)
> +static void cpuset_hotplug(bool use_cpu_hp_lock)
>   {
>   	static cpumask_t new_cpus;
>   	static nodemask_t new_mems;
> @@ -3201,25 +3201,32 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
>   	/* rebuild sched domains if cpus_allowed has changed */
>   	if (cpus_updated || force_rebuild) {
>   		force_rebuild = false;
> -		rebuild_sched_domains();
> +		if (use_cpu_hp_lock)
> +			rebuild_sched_domains();
> +		else {
> +			/* Acquiring cpu_hotplug_lock is not required.
> +			 * When cpuset_hotplug() is called in hotplug path,
> +			 * cpu_hotplug_lock is held by the hotplug context
> +			 * which is waiting for cpuhp_thread_fun to indicate
> +			 * completion of callback.
> +			*/
> +			percpu_down_write(&cpuset_rwsem);
> +			rebuild_sched_domains_locked();
> +			percpu_up_write(&cpuset_rwsem);
> +		}
>   	}
>   
>   	free_cpumasks(NULL, ptmp);
>   }
>   
> -void cpuset_update_active_cpus(void)
> +static void cpuset_hotplug_workfn(struct work_struct *work)
>   {
> -	/*
> -	 * We're inside cpu hotplug critical region which usually nests
> -	 * inside cgroup synchronization.  Bounce actual hotplug processing
> -	 * to a work item to avoid reverse locking order.
> -	 */
> -	schedule_work(&cpuset_hotplug_work);
> +	cpuset_hotplug(true);
>   }
>   
> -void cpuset_wait_for_hotplug(void)
> +void cpuset_update_active_cpus(void)
>   {
> -	flush_work(&cpuset_hotplug_work);
> +	cpuset_hotplug(false);
>   }
>   
>   /*
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index 4b6a54d..08f7019 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -204,8 +204,6 @@ void thaw_processes(void)
>   	__usermodehelper_set_disable_depth(UMH_FREEZING);
>   	thaw_workqueues();
>   
> -	cpuset_wait_for_hotplug();
> -
>   	read_lock(&tasklist_lock);
>   	for_each_process_thread(g, p) {
>   		/* No other threads should have PF_SUSPEND_TASK set */

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
