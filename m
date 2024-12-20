Return-Path: <cgroups+bounces-5982-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DAE9F9CD3
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 23:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5CC188F933
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2024 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EAB21C180;
	Fri, 20 Dec 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EKV4BkfZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6481C07F7;
	Fri, 20 Dec 2024 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734734856; cv=none; b=udzXKJz0Ki4TMLJ72M7xQg+2+Od2TSH25x4QhiUK251iXhAp1Mdmd5W6FM1db+kRkH9E8Ev3uxOfBMiGxqVkgKBPu6Lde8ZFZMmzUdw0e/tI184xyDnSkM3bTy4EBoEgKTrhVKn5X+202nDkwunSVEYMQmqVK8nYJ6ONxxQGP2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734734856; c=relaxed/simple;
	bh=F5EV+LofP6MTjDTMFSvFg/fOr3EPg4ztNRV6LSxGgq8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iXnW28YlvV4WnqZgozGGiEvTyPMo2NGPmbNulXLptRqCq+Y7OE1VTzsxcAhFlkVNjEBFyF3fad1KIBvS1nx5pz5SvNyRUXcIdNbbLNGQinCUy9Fl5+ejoFvRcuwPYEW2WSGdZ7gmOevVj4VKnbFuMopHHKt8T5wnR8uRxPp0c/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EKV4BkfZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B72C4CECD;
	Fri, 20 Dec 2024 22:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734734855;
	bh=F5EV+LofP6MTjDTMFSvFg/fOr3EPg4ztNRV6LSxGgq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EKV4BkfZxIDTwzIEz9hKHZp/wbKXwx29zPj9wQSpSdtpkCeJlKF/D4Y0vDeEBRfG0
	 /EAd4l4sZ+mtmtVq3GIu4ohjlURL74OkjwxG/eEdSksBEgzqhfT1LQoglCuKEUBqzv
	 jeLYNZnnlX+3o5HjCh4+LH6mhZ9/YKWmp9w7+lRY=
Date: Fri, 20 Dec 2024 14:47:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: mhocko@kernel.org, hannes@cmpxchg.org, yosryahmed@google.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 davidf@vimeo.com, vbabka@suse.cz, handai.szj@taobao.com,
 rientjes@google.com, kamezawa.hiroyu@jp.fujitsu.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 chenridong@huawei.com, wangweiyang2@huawei.com
Subject: Re: [PATCH v2] memcg: fix soft lockup in the OOM process
Message-Id: <20241220144734.05d62ef983fa92e96e29470d@linux-foundation.org>
In-Reply-To: <20241220103123.3677988-1-chenridong@huaweicloud.com>
References: <20241220103123.3677988-1-chenridong@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 10:31:23 +0000 Chen Ridong <chenridong@huaweicloud.com> wrote:

> From: Chen Ridong <chenridong@huawei.com>
> 
> A soft lockup issue was found in the product with about 56,000 tasks were
> in the OOM cgroup, it was traversing them when the soft lockup was
> triggered.
> 
> ...
>
> This is because thousands of processes are in the OOM cgroup, it takes a
> long time to traverse all of them. As a result, this lead to soft lockup
> in the OOM process.
> 
> To fix this issue, call 'cond_resched' in the 'mem_cgroup_scan_tasks'
> function per 1000 iterations. For global OOM, call
> 'touch_softlockup_watchdog' per 1000 iterations to avoid this issue.
> 
> ...
>
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -14,6 +14,13 @@ struct notifier_block;
>  struct mem_cgroup;
>  struct task_struct;
>  
> +/* When it traverses for long time,  to prevent softlockup, call
> + * cond_resched/touch_softlockup_watchdog very 1000 iterations.
> + * The 1000 value  is not exactly right, it's used to mitigate the overhead
> + * of cond_resched/touch_softlockup_watchdog.
> + */
> +#define SOFTLOCKUP_PREVENTION_LIMIT 1000

If this is to have potentially kernel-wide scope, its name should
identify which subsystem it belongs to.  Maybe OOM_KILL_RESCHED or
something.

But I'm not sure that this really needs to exist.  Are the two usage
sites particularly related?

>  enum oom_constraint {
>  	CONSTRAINT_NONE,
>  	CONSTRAINT_CPUSET,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5c373d275e7a..f4c12d6e7b37 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1161,6 +1161,7 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  {
>  	struct mem_cgroup *iter;
>  	int ret = 0;
> +	int i = 0;
>  
>  	BUG_ON(mem_cgroup_is_root(memcg));
>  
> @@ -1169,8 +1170,11 @@ void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  		struct task_struct *task;
>  
>  		css_task_iter_start(&iter->css, CSS_TASK_ITER_PROCS, &it);
> -		while (!ret && (task = css_task_iter_next(&it)))
> +		while (!ret && (task = css_task_iter_next(&it))) {
>  			ret = fn(task, arg);
> +			if (++i % SOFTLOCKUP_PREVENTION_LIMIT)

And a modulus operation is somewhat expensive.

Perhaps a simple

		/* Avoid potential softlockup warning */
		if ((++i & 1023) == 0)

at both sites will suffice.  Opinions might vary...



