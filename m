Return-Path: <cgroups+bounces-9790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F96B494B8
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 18:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A0D3B6D96
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C8630CD80;
	Mon,  8 Sep 2025 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9wrbha1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E967304984;
	Mon,  8 Sep 2025 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757347556; cv=none; b=eTjaStHk+jTEhkb2EERNcIFo1wnrtynyRXuh8CWUregiDCjztpidjGudQZg3ovmSiABbnCYNgQLiEjkkF+jM5mYd9q3+SFFI0jGWiOG2I/JbbAXnITG0S06AMQ7/kapnrZU4vWFwf8TqR1ZwETq0jYAP9mOtBYGSSDtd1FArF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757347556; c=relaxed/simple;
	bh=hpILFfysjeYEDcHilwuj7p/UZiawleN33Wn6w0LETXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UO4+qP4DvsUwbJDEz3/Bxeilvb828wvgfE3G1S+V5WezhYlNa+wbVsONNz4F7xOBkBL5G42pBGUEtW6oY3ed3Pqo18Mtd5+zVlDG6DqF83Y6J1XwbzFdTE8reBCOCaL91g5kKmlvhh64/XzplCqXXzPlrVWJ1g4eNr5aOP3Ap1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9wrbha1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE85C4CEF5;
	Mon,  8 Sep 2025 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757347554;
	bh=hpILFfysjeYEDcHilwuj7p/UZiawleN33Wn6w0LETXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9wrbha1B8v9uUGXqB3iKAIAJ8hE596IOt90yijhIYEV+vlAPyBsk7NqwfWW40uBg
	 +/IAI9mzkBvdKqpf81F0xqjOAi0JLbHTW6k29OC5WosuHQndkOMM3EJW9CLCutMN2Z
	 rQXclchifmgPX5Lyq1hposeYer//phdqTLE5HU6m2fl206M9WUz85Id2NPpVHt1I0X
	 UYksb4p04bWT9QCsPMFFi2jyxZx9GVVMYz4YDg3gI2DeFewI6g28zbkTb203I+UHeV
	 1P2oUmH2kHJWLeUv0CVjv6k2o4xLNIKJwFNwIDMIFpfmud2reEeN4n0I0VfQkDVS+P
	 3q9TI6wsgiB5g==
Date: Mon, 8 Sep 2025 06:05:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: replace global percpu_rwsem with per
 threadgroup resem when writing to cgroup.procs
Message-ID: <aL7-4XQxeFKtFWlq@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757326641.git.escape@linux.alibaba.com>
 <c202b463e176ef128c806e0040107ea16a101143.1757326641.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c202b463e176ef128c806e0040107ea16a101143.1757326641.git.escape@linux.alibaba.com>

Hello,

On Mon, Sep 08, 2025 at 06:20:27PM +0800, Yi Tao wrote:
...
> The static usage pattern of creating a cgroup, enabling controllers,
> and then seeding it with CLONE_INTO_CGROUP doesn't require write
> locking cgroup_threadgroup_rwsem and thus doesn't benefit from this
> patch.

Please bring this to the top, note that this is the default mode of
operation and the mechanism being introduced is thus an optional one.

> @@ -88,7 +88,8 @@ enum {
>  	/*
>  	 * Reduce latencies on dynamic cgroup modifications such as task
>  	 * migrations and controller on/offs by disabling percpu operation on
> -	 * cgroup_threadgroup_rwsem. This makes hot path operations such as
> +	 * cgroup_threadgroup_rwsem and taking per threadgroup rwsem when
> +	 * writing to cgroup.procs. This makes hot path operations such as
>  	 * forks and exits into the slow path and more expensive.

This comment is pointed to from all other places. Please expand on why
per-threadgroup rwsem is beneficial for what use cases.

>  	 * The static usage pattern of creating a cgroup, enabling controllers,
> @@ -828,16 +829,21 @@ struct cgroup_of_peak {
>  	struct list_head	list;
>  };
>  
> +extern int take_per_threadgroup_rwsem;

I think it needs cgroup in its name. Maybe something like
cgroup_enable_per_threadgroup_rwsem?

> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 312c6a8b55bb..8650ec394d0c 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1298,18 +1298,29 @@ struct cgroup_root *cgroup_root_from_kf(struct kernfs_root *kf_root)
>  	return root_cgrp->root;
>  }
>  
> +int take_per_threadgroup_rwsem;

Please put it where other global variables are and also note what it does
and that writes protected by cgroup_mutex and write-lock of
cgroup_threadgroup_rwsem and thus reads are protected by either.

>  void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
>  {
>  	bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
>  
> -	/* see the comment above CGRP_ROOT_FAVOR_DYNMODS definition */
> +	/*
> +	 * see the comment above CGRP_ROOT_FAVOR_DYNMODS definition.
> +	 * favordynmods can flip while task is between
> +	 * cgroup_threadgroup_change_begin and cgroup_threadgroup_change_end,
> +	 * so down_write global cgroup_threadgroup_rwsem to synchronize them.

Maybe: take_per_threadgroup_rwsem must not be flipped while threads are
between cgroup_threadgroup_change_begin and cgroup_threadgroup_change_end.
down_write global group_threadgroup_rwsem to exclude them.

But does this actually work? It works for turning it on. I don't think it'd
work for turning it off, right? Maybe make it enable only and trigger a
warning message when people try to turn it off?

> +	 */
> +	percpu_down_write(&cgroup_threadgroup_rwsem);
>  	if (favor && !favoring) {
> +		take_per_threadgroup_rwsem++;

Given that favoring is gating the switch, this can be a bool, right?

>  		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
>  		root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
>  	} else if (!favor && favoring) {
> +		take_per_threadgroup_rwsem--;

And here, you can trigger a warning that per_threadgroup opreation can't be
disabled once enabled instead of actually turning it off.

Another alternative would be using a task flag to track whether %current is
holding per_threadgroup_rwsem and then using that to decide whether to
unlock. Maybe that's cleaner but I don't think it really matters here.

..
> + * When favordynmods is enabled, take per threadgroup rwsem to reduce latencies
> + * on dynamic cgroup modifications. see the comment above
> + * CGRP_ROOT_FAVOR_DYNMODS definition.

This is more about scalability, right? Maybe just say overhead?

> @@ -2976,24 +3003,13 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>  	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>  		return ERR_PTR(-EINVAL);
>  
> -	/*
> -	 * If we migrate a single thread, we don't care about threadgroup
> -	 * stability. If the thread is `current`, it won't exit(2) under our
> -	 * hands or change PID through exec(2). We exclude
> -	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
> -	 * callers by cgroup_mutex.
> -	 * Therefore, we can skip the global lock.
> -	 */
> -	lockdep_assert_held(&cgroup_mutex);
> -	*threadgroup_locked = pid || threadgroup;
> -	cgroup_attach_lock(*threadgroup_locked);
> -
> +retry_find_task:
>  	rcu_read_lock();
>  	if (pid) {
>  		tsk = find_task_by_vpid(pid);
>  		if (!tsk) {
>  			tsk = ERR_PTR(-ESRCH);
> -			goto out_unlock_threadgroup;
> +			goto out_unlock_rcu;
>  		}
>  	} else {
>  		tsk = current;
> @@ -3010,15 +3026,42 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>  	 */
>  	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
>  		tsk = ERR_PTR(-EINVAL);
> -		goto out_unlock_threadgroup;
> +		goto out_unlock_rcu;
>  	}
> -
>  	get_task_struct(tsk);
> -	goto out_unlock_rcu;
>  
> -out_unlock_threadgroup:
> -	cgroup_attach_unlock(*threadgroup_locked);
> -	*threadgroup_locked = false;
> +	rcu_read_unlock();
> +
> +	/*
> +	 * If we migrate a single thread, we don't care about threadgroup
> +	 * stability. If the thread is `current`, it won't exit(2) under our
> +	 * hands or change PID through exec(2). We exclude
> +	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
> +	 * callers by cgroup_mutex.
> +	 * Therefore, we can skip the global lock.
> +	 */
> +	lockdep_assert_held(&cgroup_mutex);
> +	*threadgroup_locked = pid || threadgroup;
> +
> +	cgroup_attach_lock(*threadgroup_locked, tsk);
> +
> +	if (threadgroup) {
> +		if (!thread_group_leader(tsk)) {
> +			/*
> +			 * a race with de_thread from another thread's exec()
> +			 * may strip us of our leadership, if this happens,
> +			 * there is no choice but to throw this task away and
> +			 * try again; this is
> +			 * "double-double-toil-and-trouble-check locking".
> +			 */
> +			cgroup_attach_unlock(*threadgroup_locked, tsk);
> +			put_task_struct(tsk);
> +			goto retry_find_task;

This is subtle. Can you please separate this out to a spearate patch?

Thanks.

-- 
tejun

