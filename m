Return-Path: <cgroups+bounces-2183-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA9388EC4B
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 18:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2F71F28825
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 17:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23155130AFC;
	Wed, 27 Mar 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha/ONp3w"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60A535A4
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559698; cv=none; b=Sr4/cBjE9x3aluKHEhWmz0XVXg5F2gBG4NexnHghjGWUZ/hsfHEjp6RANc/ocCYftQ1CMvCdINa9YLV8mqXvZLWevc/rHXSGUyteRzNc1bY6f6mhdgr2aNHNjbAL4ju9Xc7/48cbTgvw33hsny3zOGiMpbcCkpMqhwVW/xdoNgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559698; c=relaxed/simple;
	bh=WQ9b9W+K1cr0PaDz8CdCDwfTuAdl9qIcWO3q1kLH7/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzorOX6fJCXWrhvD15PU97x+wqt2cdN0RbcNXnypE9Mj+mEhg0KSvQ+uAeD/trc/lV2DIypB3MizkWLI30n0EDRgEjn5CHlw/iwBcZwSC0FIc1ilEJiFE4FNPoIgEbmypEWDSXS2tdKcKu3wRMoeGR8foyKjI1olYVSee/J4SWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ha/ONp3w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711559696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/ehU8cycNoqYZCNxtm79uKP+Ubo74kxYeqF1hCvXwk=;
	b=Ha/ONp3wJGQhQh/Ka9lG+U5W4nAUASYUwhIhpP2scWGj8CzPmfFuCQOTVt52ANiqz4tbe/
	Cb5yudwlYia6ey1FKdYOsSMTaaSTWd40yYGI4ZgmJ4VH9GX2qSaLBj2PHcDPq1ugFv4Z6U
	odO3JxK3rdD4BtxUuVrxEG3cfl9wVfM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-oWr9LjkmPcGIqwKMTbV4-w-1; Wed,
 27 Mar 2024 13:14:50 -0400
X-MC-Unique: oWr9LjkmPcGIqwKMTbV4-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49AF53C000A5;
	Wed, 27 Mar 2024 17:14:50 +0000 (UTC)
Received: from [10.22.33.225] (unknown [10.22.33.225])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D5FAE492BD0;
	Wed, 27 Mar 2024 17:14:49 +0000 (UTC)
Message-ID: <d8e8b000-7d09-4747-82ec-bf99a73607ee@redhat.com>
Date: Wed, 27 Mar 2024 13:14:49 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [problem] Hung task caused by memory migration when cpuset.mems
 changes
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: cgroups@vger.kernel.org, hughd@google.com, wuyun.abel@bytedance.com,
 hezhongkun.hzk@bytedance.com, chenying.kernel@bytedance.com,
 zhanghaoyu.zhy@bytedance.com
References: <20240325144609.983333-1-zhouchuyi@bytedance.com>
 <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZgMFPMjZRZCsq9Q-@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 3/26/24 13:26, Tejun Heo wrote:
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
> One approach we can take is pushing the cpuset_migrate_mm_wq flushing to
> task_work so that it happens after cpuset mutex is dropped. That way we
> maintain the operation synchronicity for the issuer while avoiding bothering
> anyone else.
I think it is a good idea to use task_work() to wait for mm migration to 
finish before returning to user space.
>
> Can you see whether the following patch fixes the issue for you? Thanks.
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

It may be too early to initiate the task_work at cpuset_can_attach() as 
no mm migration may happen. My suggestion is to do it at cpuset_attach() 
with at least one cpuset_migrate_mm() call.

Cheers,
Longman

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


