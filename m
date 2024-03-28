Return-Path: <cgroups+bounces-2219-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC288F933
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 08:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E2EA1F2955E
	for <lists+cgroups@lfdr.de>; Thu, 28 Mar 2024 07:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EC94F8BB;
	Thu, 28 Mar 2024 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jY64V8eu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E1742A88
	for <cgroups@vger.kernel.org>; Thu, 28 Mar 2024 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612434; cv=none; b=FRsIiqDVyIpKGxXVZsZ8uC15Kz9ni0Skk5wMzG5yF5mil/+c/j9MMPSX2n1UZ2lYozmeaP5gU5HaScvMrCLcaeM5ov4s5r48u8/P8+Zc4lp5SkU9kEjXTvyHQvBJ3HuNnngxtj1g1Oy1eWZ1pOU0wHxAhOIAJhiG7+VoFUBS1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612434; c=relaxed/simple;
	bh=olePUAtoYrJF/0P8r5R+ztCH5eVkfZy4YQYKq1s1wjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZlfVCdXcPmZ5DGSAlDB8smdeG6ubzAOj1RaH/RH+NGZplSvQhbOR1uKLFw3apDeHFlywfjqxvcOkOf9pD7fwRWm3jWdJ4zGhnARQMFkeuZd3f7o+V3uiK3Ogfqqq6qS4Ey/OYZH/1B3PE9YLxgM4a+PgcWlSkJ88i86cQgCZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jY64V8eu; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbc6e51d0so423643b6e.3
        for <cgroups@vger.kernel.org>; Thu, 28 Mar 2024 00:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1711612430; x=1712217230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlROBJ4v2ZQ/0AKvJh2zExIymmelG3xIqAWINMM6Qwk=;
        b=jY64V8euM8rKisklyqgiI4/A5gJ7a/BKIpfZ/98xR2qsxAlo2spcImkxrxc6U3Z/A2
         0nrwLBG20wk+XNeiKfrxeXKBb4PRz/FU4kGopow7fPJxyL8rlm4isYh8Zrx9n16/Njaf
         ihjgdqZssLORgYdZ24zKv247eQfS45mt7Aj5656RM7UCDxaKZ2426Jk/jKkRPuI8qzgo
         ov94Xgjabkd3ggmgpePcBaskRlL9U6GmamphA/3dJqxuho6QIxFzTe0FRKuXsuypUNR/
         A9ZE3n8sshVSHJ8izsoHxR1Vr5deidoqVquwkwkdjDD+Gycwm1ORiMc+cYp1lvt+3vTO
         Uw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612430; x=1712217230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlROBJ4v2ZQ/0AKvJh2zExIymmelG3xIqAWINMM6Qwk=;
        b=ZFyBg8x3Xpdv+2BgAm/VO1gI9IBjgV0fhaNjpn2x2+JR/iJt0GYAz+k5nYTuqHL3f8
         3UQZeFGbv9XoFU2bu9b7fR694jPWdluve6bUD7BAFZ/K35CJqdC3YenQtWcqKRMxTUPH
         rBA1Kx8d6xSjOuysDD8D2QWewB/kp9zJxv9KuRf03GyfjhHaHngIajGCAuI//OJrSuoR
         MNohK+RtMBCz/EV4RAbTu/7V79/t7InRJKT7aVTX5b/b5RQwQfVlTEFZebXI0emQi5ov
         MDqhNxIjvEPIne+ytWus08N11D3w2edc9xIEZUSEX7aRKXHGcWzvKxKlWnyvR+/GarQB
         axBA==
X-Gm-Message-State: AOJu0Yw0BtikUJw0xd1DGiiUAS8W2a3JRcVDbp/iyoLKvTSAq3wvwmO8
	gjwM9gLHvSMEVzvCGdphtBOZxAjHCxwY3+sW8z0LL4EyyWSyGKfadGlAMgjVMRc=
X-Google-Smtp-Source: AGHT+IG7Zzkg2D6YNcvZDA7HtPxDR0ITP9FRIh0uDXaarusKpyFeuj0TwdwbF6ScYLN+AsngrC929Q==
X-Received: by 2002:a05:6808:3098:b0:3c3:be7d:3c6e with SMTP id bl24-20020a056808309800b003c3be7d3c6emr2284238oib.41.1711612430550;
        Thu, 28 Mar 2024 00:53:50 -0700 (PDT)
Received: from [10.84.154.230] ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id fb7-20020a056a002d8700b006eadf879a30sm20392pfb.179.2024.03.28.00.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:53:49 -0700 (PDT)
Message-ID: <232747d6-2c39-4e2b-879e-9ac12445d488@bytedance.com>
Date: Thu, 28 Mar 2024 15:53:30 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [problem] Hung task caused by memory migration when
 cpuset.mems changes
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: cgroups@vger.kernel.org, longman@redhat.com, tj@kernel.orgv,
 hughd@google.com, hezhongkun.hzk@bytedance.com,
 chenying.kernel@bytedance.com, zhanghaoyu.zhy@bytedance.com
References: <20240325144609.983333-1-zhouchuyi@bytedance.com>
 <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 1:26 AM, Tejun Heo Wrote:
> Hello,
> 
> On Mon, Mar 25, 2024 at 10:46:09PM +0800, Chuyi Zhou wrote:
>> In our production environment, we have observed several cases of hung tasks
>> blocked on the cgroup_mutex. The underlying cause is that when user modify
>> the cpuset.mems, memory migration operations are performed in the
>> work_queue. However, the duration of these operations depends on the memory
>> size of workloads and can consume a significant amount of time.
>>
>> In the __cgroup_procs_write operation, there is a flush_workqueue operation
>> that waits for the migration to complete while holding the cgroup_mutex.
>> As a result, most cgroup-related operations have the potential to
>> experience blocking.
>>
>> We have noticed the commit "cgroup/cpuset: Enable memory migration for
>> cpuset v2"[1]. This commit enforces memory migration when modifying the
>> cpuset. Furthermore, in cgroup v2, there is no option available for
>> users to disable CS_MEMORY_MIGRATE.
>>
>> In our scenario, we do need to perform memory migration when cpuset.mems
>> changes, while ensuring that other tasks are not blocked on cgroup_mutex
>> for an extended period of time.
>>
>> One feasible approach is to revert the commit "cgroup/cpuset: Enable memory
>> migration for cpuset v2"[1]. This way, modifying cpuset.mems will not
>> trigger memory migration, and we can manually perform memory migration
>> using migrate_pages()/move_pages() syscalls.
>>
>> Another solution is to use a lazy approach for memory migration[2]. In
>> this way we only walk through all the pages and sets pages to protnone,
>> and numa faults triggered by later touch will handle the movement. That
>> would significantly reduce the time spent in cpuset_migrate_mm_workfn.
>> But MPOL_MF_LAZY was disabled by commit 2cafb582173f ("mempolicy: remove
>> confusing MPOL_MF_LAZY dead code")
> 
> One approach we can take is pushing the cpuset_migrate_mm_wq flushing to
> task_work so that it happens after cpuset mutex is dropped. That way we
> maintain the operation synchronicity for the issuer while avoiding bothering
> anyone else.

Good idea!

> 
> Can you see whether the following patch fixes the issue for you? Thanks.

We use move_pages() when cpuset memory migration disabled, which is proved
fine. Given that the way you proposed is kind of like what we have done but
inside kernel before return to userspace, I think this patch will help.

> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ba36c073304a..8a8bd3f157ab 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -42,6 +42,7 @@
>   #include <linux/spinlock.h>
>   #include <linux/oom.h>
>   #include <linux/sched/isolation.h>
> +#include <linux/task_work.h>
>   #include <linux/cgroup.h>
>   #include <linux/wait.h>
>   #include <linux/workqueue.h>
> @@ -2696,6 +2697,26 @@ static void cpuset_migrate_mm_workfn(struct work_struct *work)
>   	kfree(mwork);
>   }
>   
> +static void flush_migrate_mm_task_workfn(struct callback_head *head)
> +{
> +	flush_workqueue(cpuset_migrate_mm_wq);
> +}
> +
> +static int schedule_flush_migrate_mm(void)
> +{
> +	struct callback_head *flush_cb;
> +
> +	flush_cb = kzalloc(sizeof(*flush_cb), GFP_KERNEL);
> +	if (!flush_cb)
> +		return -ENOMEM;
> +
> +	flush_cb->func = flush_migrate_mm_task_workfn;
> +	if (task_work_add(current, flush_cb, TWA_RESUME))
> +		kfree(flush_cb);

It seems we will lose track of flush_cb and causes memleak here. Did I miss
anything?

Thanks & BR,
	Abel

> +
> +	return 0;
> +}
> +
>   static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
>   							const nodemask_t *to)
>   {
> @@ -2718,11 +2739,6 @@ static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
>   	}
>   }
>   
> -static void cpuset_post_attach(void)
> -{
> -	flush_workqueue(cpuset_migrate_mm_wq);
> -}
> -
>   /*
>    * cpuset_change_task_nodemask - change task's mems_allowed and mempolicy
>    * @tsk: the task to change
> @@ -3276,6 +3292,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	bool cpus_updated, mems_updated;
>   	int ret;
>   
> +	ret = schedule_flush_migrate_mm();
> +	if (ret)
> +		return ret;
> +
>   	/* used later by cpuset_attach() */
>   	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
>   	oldcs = cpuset_attach_old_cs;
> @@ -3584,7 +3604,11 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   {
>   	struct cpuset *cs = css_cs(of_css(of));
>   	struct cpuset *trialcs;
> -	int retval = -ENODEV;
> +	int retval;
> +
> +	retval = schedule_flush_migrate_mm();
> +	if (retval)
> +		return retval;
>   
>   	buf = strstrip(buf);
>   
> @@ -3613,8 +3637,10 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   
>   	cpus_read_lock();
>   	mutex_lock(&cpuset_mutex);
> -	if (!is_cpuset_online(cs))
> +	if (!is_cpuset_online(cs)) {
> +		retval = -ENODEV;
>   		goto out_unlock;
> +	}
>   
>   	trialcs = alloc_trial_cpuset(cs);
>   	if (!trialcs) {
> @@ -3643,7 +3669,6 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	cpus_read_unlock();
>   	kernfs_unbreak_active_protection(of->kn);
>   	css_put(&cs->css);
> -	flush_workqueue(cpuset_migrate_mm_wq);
>   	return retval ?: nbytes;
>   }
>   
> @@ -4283,7 +4308,6 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
>   	.can_attach	= cpuset_can_attach,
>   	.cancel_attach	= cpuset_cancel_attach,
>   	.attach		= cpuset_attach,
> -	.post_attach	= cpuset_post_attach,
>   	.bind		= cpuset_bind,
>   	.can_fork	= cpuset_can_fork,
>   	.cancel_fork	= cpuset_cancel_fork,
> 

