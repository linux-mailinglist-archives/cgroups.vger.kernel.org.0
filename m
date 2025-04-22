Return-Path: <cgroups+bounces-7708-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D6AA9642A
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 11:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E92A1886C93
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E071FAC4B;
	Tue, 22 Apr 2025 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3H3Cwwa"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418B1F3B98;
	Tue, 22 Apr 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313804; cv=none; b=pIuJyzhnzNPUNOcVqNfLv9w8BATsTH1s+a+EtE1sPiH3eq2sqFWGPu+5070xWEGZLeJCBC5xV6kGa0WV/ZKnYS6gZPN+wszqnjhMLjMmHfqj003eelOtgKV3Z9iNc511qmbeRXHY89YS0tScMYP3Ml4SueZYPRX7UVRGpY7SeE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313804; c=relaxed/simple;
	bh=1I31TMfaIyDHfwOWMX/uBcvIKjblAc3bvEHx9bVoZnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnvgPe6gjsKzH5vo7OsybNw8xnWT00uXRdIgPWOX7sdekl3pcCFXaiGfVGj3pGmVBVsrRSQmSSzZ6tRQpWOeTbQbhR32Sm7ljelRPH/acPu9IpFPegbwpUOxP0I8MCxdLALxSDH3HcDBMsSHBBMz1s2izKrkhbJR6MK0xbjXHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3H3Cwwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532E2C4CEE9;
	Tue, 22 Apr 2025 09:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313803;
	bh=1I31TMfaIyDHfwOWMX/uBcvIKjblAc3bvEHx9bVoZnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3H3CwwajuUi+FwVqkRsXIHP/6guw/UjoiZBWihMnWUqAhZ5efisYHogcBe0DHHTz
	 w8Rogdmc9Uj2kAbYXHND5eHRPkIMkQ34/oa4ueMjdKo47+U8lhgDD0YlMQnWTWxj9Q
	 ddC5VUOmdU9MI12RdnMcKWOSohEZnit7VmOCcpcepTAmyCPK2axv63dQbARtf0KfFJ
	 8ekstAqpUgeIr+wcTLTr8r0Pmm5GcBgaHjzuaR88czqqXlWGwASSJSh6006FPJ4bML
	 DRdXU4dcYLuWgUbfvQhnvgTN8UZYJmk+su4bfv8Wdx6yMXg5wvURqSNUJ9xpGK6QBZ
	 BRAVusRcTwNCw==
Date: Tue, 22 Apr 2025 11:23:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Greg Thelen <gthelen@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] memcg: introduce non-blocking limit setting option
Message-ID: <20250422-daumen-ozonbelastung-93d90ca81dfa@brauner>
References: <20250419183545.1982187-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250419183545.1982187-1-shakeel.butt@linux.dev>

On Sat, Apr 19, 2025 at 11:35:45AM -0700, Shakeel Butt wrote:
> Setting the max and high limits can trigger synchronous reclaim and/or
> oom-kill if the usage is higher than the given limit. This behavior is
> fine for newly created cgroups but it can cause issues for the node
> controller while setting limits for existing cgroups.
> 
> In our production multi-tenant and overcommitted environment, we are
> seeing priority inversion when the node controller dynamically adjusts
> the limits of running jobs of different priorities. Based on the system
> situation, the node controller may reduce the limits of lower priority
> jobs and increase the limits of higher priority jobs. However we are
> seeing node controller getting stuck for long period of time while
> reclaiming from lower priority jobs while setting their limits and also
> spends a lot of its own CPU.
> 
> One of the workaround we are trying is to fork a new process which sets
> the limit of the lower priority job along with setting an alarm to get
> itself killed if it get stuck in the reclaim for lower priority job.
> However we are finding it very unreliable and costly. Either we need a
> good enough time buffer for the alarm to be delivered after setting
> limit and potentialy spend a lot of CPU in the reclaim or be unreliable
> in setting the limit for much shorter but cheaper (less reclaim) alarms.
> 
> Let's introduce new limit setting option which does not trigger
> reclaim and/or oom-kill and let the processes in the target cgroup to
> trigger reclaim and/or throttling and/or oom-kill in their next charge
> request. This will make the node controller on multi-tenant
> overcommitted environment much more reliable.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
> Changes since v1:
> - Instead of new interfaces use O_NONBLOCK flag (Greg, Roman & Tejun)
> 
>  Documentation/admin-guide/cgroup-v2.rst | 14 ++++++++++++++
>  mm/memcontrol.c                         | 10 ++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 8fb14ffab7d1..c14514da4d9a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1299,6 +1299,13 @@ PAGE_SIZE multiple when read back.
>  	monitors the limited cgroup to alleviate heavy reclaim
>  	pressure.
>  
> +        If memory.high is opened with O_NONBLOCK then the synchronous
> +        reclaim is bypassed. This is useful for admin processes that

As written this isn't restricted to admin processes though, no? So any
unprivileged container can open that file O_NONBLOCK and avoid
synchronous reclaim?

Which might be fine I have no idea but it's something to explicitly
point out (The alternative is to restrict opening with O_NONBLOCK
through a relevant capability check when the file is opened or use a
write-time check.).

> +        need to dynamically adjust the job's memory limits without
> +        expending their own CPU resources on memory reclamation. The
> +        job will trigger the reclaim and/or get throttled on its
> +        next charge request.
> +
>    memory.max
>  	A read-write single value file which exists on non-root
>  	cgroups.  The default is "max".
> @@ -1316,6 +1323,13 @@ PAGE_SIZE multiple when read back.
>  	Caller could retry them differently, return into userspace
>  	as -ENOMEM or silently ignore in cases like disk readahead.
>  
> +        If memory.max is opened with O_NONBLOCK, then the synchronous
> +        reclaim and oom-kill are bypassed. This is useful for admin
> +        processes that need to dynamically adjust the job's memory limits
> +        without expending their own CPU resources on memory reclamation.
> +        The job will trigger the reclaim and/or oom-kill on its next
> +        charge request.
> +
>    memory.reclaim
>  	A write-only nested-keyed file which exists for all cgroups.
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5e2ea8b8a898..6f7362a7756a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4252,6 +4252,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  
>  	page_counter_set_high(&memcg->memory, high);
>  
> +	if (of->file->f_flags & O_NONBLOCK)
> +		goto out;
> +
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
>  		unsigned long reclaimed;
> @@ -4274,7 +4277,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  		if (!reclaimed && !nr_retries--)
>  			break;
>  	}
> -
> +out:
>  	memcg_wb_domain_size_changed(memcg);
>  	return nbytes;
>  }
> @@ -4301,6 +4304,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  
>  	xchg(&memcg->memory.max, max);
>  
> +	if (of->file->f_flags & O_NONBLOCK)
> +		goto out;
> +
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
>  
> @@ -4328,7 +4334,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  			break;
>  		cond_resched();
>  	}
> -
> +out:
>  	memcg_wb_domain_size_changed(memcg);
>  	return nbytes;
>  }
> -- 
> 2.47.1
> 

