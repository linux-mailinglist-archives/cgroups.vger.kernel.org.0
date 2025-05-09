Return-Path: <cgroups+bounces-8103-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B29AB14FB
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 15:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20E1A21019
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA7D29671C;
	Fri,  9 May 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDfo1z0S"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97AF29375A;
	Fri,  9 May 2025 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796700; cv=none; b=FBjWXIOm9Paovq7ucxz+4t3HdiZ24ifOxVLncZ41zYtP5d+5UsM//KKMWM6DBuyncj/GEysj7deQ8MaSOXjrju5YfhygzORTTMSNTZ/sxXFyJ1zfZlxtEES8q8SeG1DDBQxewOu+XOF3cs8tc0t9JHQ2HsPrX5ebqYDcGiEGsso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796700; c=relaxed/simple;
	bh=u0KhINI0YhCaw7x4o4t2KmY7tH8jFbQqrmNdRuvwe6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYQ2OCvLE09EPIRr39IllzvpUOu9VWuM6QReN4B6r+ZztfmldJPmxtDbKryh3hFxjT8nEbeXkegyDmYoO1mRAYpA/IhJTUDCWldEh8O6xsX1rKskQyjUHVyaCvrUKumlB34XpP7qUAXNQ2dzTCEzo26nyncHPDAXFKIFP6KcESk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDfo1z0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3160C4CEEB;
	Fri,  9 May 2025 13:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746796700;
	bh=u0KhINI0YhCaw7x4o4t2KmY7tH8jFbQqrmNdRuvwe6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDfo1z0SKP/X0hJkPuVqoKVaBYGHIGz9on0dtLQJw8qMLI3wwOfjFg0HdWTmWN3h8
	 eC4DDzcBOg+F0vuwtKxTFGBz0GMkWIcwjOrru+hJ3Mke5ai7MmzPJPYtWqyqOh3xOS
	 dz5xFT9slLw8TFknGWAodbF/YdTfFXPh1oQVPEMH/rlqzQMfU66eJxM9uoK80t67Tc
	 F36EXAmAXlagOIUMem4rdkh3qfFx4/fjp9+euabvFgdRGv6OK5NdgEFRKSdTbEfXgQ
	 zr5Jogjiw8BOb5FMvwZ2GoUPkYZOyoBx7Wvxx0VhY9lonBUBuQd6H46JioilHeqPcB
	 MTJ1skiSMGaeA==
Date: Fri, 9 May 2025 15:18:17 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xi Wang <xii@google.com>
Subject: Re: [PATCH v2] cgroup/cpuset: Extend kthread_is_per_cpu() check to
 all PF_NO_SETAFFINITY tasks
Message-ID: <aB4AmUtEM-qQ1Xoa@localhost.localdomain>
References: <20250508192413.615512-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250508192413.615512-1-longman@redhat.com>

Le Thu, May 08, 2025 at 03:24:13PM -0400, Waiman Long a écrit :
> Commit ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask()
> on top_cpuset") enabled us to pull CPUs dedicated to child partitions
> from tasks in top_cpuset by ignoring per cpu kthreads. However, there
> can be other kthreads that are not per cpu but have PF_NO_SETAFFINITY
> flag set to indicate that we shouldn't mess with their CPU affinity.
> For other kthreads, their affinity will be changed to skip CPUs dedicated
> to child partitions whether it is an isolating or a scheduling one.
> 
> As all the per cpu kthreads have PF_NO_SETAFFINITY set, the
> PF_NO_SETAFFINITY tasks are essentially a superset of per cpu kthreads.
> Fix this issue by dropping the kthread_is_per_cpu() check and checking
> the PF_NO_SETAFFINITY flag instead.
> 
> Fixes: ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d0143b3dce47..967603300ee3 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1130,9 +1130,11 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>  
>  		if (top_cs) {
>  			/*
> -			 * Percpu kthreads in top_cpuset are ignored
> +			 * PF_NO_SETAFFINITY tasks are ignored.
> +			 * All per cpu kthreads should have PF_NO_SETAFFINITY
> +			 * flag set, see kthread_set_per_cpu().
>  			 */
> -			if (kthread_is_per_cpu(task))
> +			if (task->flags & PF_NO_SETAFFINITY)
>  				continue;
>  			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);

Acked-by: Frederic Weisbecker <frederic@kernel.org>

But this makes me realize I overlooked that when I introduced the unbound kthreads
centralized affinity.

cpuset_update_tasks_cpumask() seem to blindly affine to subpartitions_cpus
while unbound kthreads might have their preferences (per-nodes or random cpumasks).

So I need to make that pass through kthread API.

It seems that subpartition_cpus doesn't contain nohz_full= CPUs.
But it excludes isolcpus=. And it's usually sane to assume that
nohz_full= CPUs are isolated.

I think I can just rename update_unbound_workqueue_cpumask()
to update_unbound_kthreads_cpumask() and then handle unbound
kthreads from there along with workqueues. And then completely
ignore kthreads from cpuset_update_tasks_cpumask().

Let me think about it (but feel free to apply the current patch meanwhile).

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

