Return-Path: <cgroups+bounces-8725-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7ACB039B2
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 10:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C773BAA0C
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 08:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD6F23BCED;
	Mon, 14 Jul 2025 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0Fex4el"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C348572600;
	Mon, 14 Jul 2025 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482482; cv=none; b=aHcVeLfmr8O8sj3vPmiHsmbrV/27Cvq3e598aBjOae1hxhFpjy5tTw6duP1gr/3ywZFWqJnOOJKj9yx+UbERJVl63yq/MvNvEEw1ieOHB5d1eBnFDpMTLmeBix+uIzUA3Tyue1tEdyzepXtsacG7Mf6L4gxs/RRUxHGZjqacf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482482; c=relaxed/simple;
	bh=AFPbbQKmFQzEKr3gkNtMVTXj/EvD9hFsVfOvP1+bCnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na+Las4VrcO1SYdHVTb8zmo7GuG+LPT6jlsYSH7hQnkOXggNtmmD3h3MVIgH5DlrKH+NYh7fbcYP9R1V9bGYP5d+iYV9uLcldNOUwbwNx9LGIurGzX2rNzqbIDn8swOe7PMwwDea4OMky+q2C1/sWDQ82/xqADjpQM/iibb3qWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m0Fex4el; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ntm/LBdN0S4A30B4dtjj6Gi3D4WZTRJ/GjFERQMn/X8=; b=m0Fex4elzthcxje6BpwIB1OJFt
	DxAnz00XadX762HYwhvoDGS6bm7yg0uDfun42d7VpkLat3Xl169ONIioag1snENPlMRwfkGhsOMNz
	17x+6k3MlOuZtKK6kkFmBxANAcw70r3FLWsXyoqqjeuydnL7Fghd93cbbDjasSA8au5yaQRjJW4nA
	TTvcpivhmtCBf5lJNSLD1SJbOKJ0X+01d/l15y1uwm5KQBqwZ0yeMrhVfCMY41bEgO4bPQRX93l26
	KnMR60RbOQ5G0nyqmg2vuferp+dFzxYxy/Z46ooLINuBqoTgkT+HNH3nm7KEzQXgQd7DeX2/x48Fe
	6ZH9OJoQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubEkJ-00000009iX6-27Og;
	Mon, 14 Jul 2025 08:41:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1EAD93001AA; Mon, 14 Jul 2025 10:41:10 +0200 (CEST)
Date: Mon, 14 Jul 2025 10:41:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] cpuset: fix warning when attaching tasks with
 offline CPUs
Message-ID: <20250714084109.GK905792@noisy.programming.kicks-ass.net>
References: <20250714032311.3570157-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714032311.3570157-1-chenridong@huaweicloud.com>

On Mon, Jul 14, 2025 at 03:23:11AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A kernel warning was observed in the cpuset migration path:
> 
>     WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
>     cgroup_migrate_execute+0x8df/0xf30
>     Call Trace:
>      cgroup_transfer_tasks+0x2f3/0x3b0
>      cpuset_migrate_tasks_workfn+0x146/0x3b0
>      process_one_work+0x5ba/0xda0
>      worker_thread+0x788/0x1220
> 
> The issue can be reliably reproduced with:
> 
>     # Setup test cpuset
>     mkdir /sys/fs/cgroup/cpuset/test
>     echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
>     echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
> 
>     # Start test process
>     sleep 100 &
>     pid=$!
>     echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
>     taskset -p 0xC $pid  # Bind to CPUs 2-3
> 
>     # Take CPUs offline
>     echo 0 > /sys/devices/system/cpu/cpu3/online
>     echo 0 > /sys/devices/system/cpu/cpu2/online
> 
> Root cause analysis:
> When tasks are migrated to top_cpuset due to CPUs going offline,
> cpuset_attach_task() sets the CPU affinity using cpus_attach which
> is initialized from cpu_possible_mask. This mask may include offline
> CPUs. When __set_cpus_allowed_ptr() computes the intersection between:
> 1. cpus_attach (possible CPUs, may include offline)
> 2. p->user_cpus_ptr (original user-set mask)
> The resulting new_mask may contain only offline CPUs, causing the
> operation to fail.
> 
> The fix changes cpus_attach initialization to use cpu_active_mask
> instead of cpu_possible_mask, ensuring we only consider online CPUs
> when setting the new affinity. This prevents the scenario where
> the intersection would result in an invalid CPU set.
> 
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Reported-by: Yang Lijin <yanglijin@huawei.com>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index f74d04429a29..5401adbdffa6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3121,7 +3121,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>  	if (cs != &top_cpuset)
>  		guarantee_active_cpus(task, cpus_attach);
>  	else
> -		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
> +		cpumask_andnot(cpus_attach, cpu_active_mask,
>  			       subpartitions_cpus);

This breaks things. Any task mask must be a subset of
task_cpu_possible_mask() at all times. It might not be able to run
outside of that mask.

