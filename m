Return-Path: <cgroups+bounces-9708-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E970B442C6
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 18:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED9AA08593
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE0230BFD;
	Thu,  4 Sep 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md/ghe+b"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A82202F71;
	Thu,  4 Sep 2025 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003482; cv=none; b=ZIDFqcTvbepi+lUVha+oQyaLEK/ebyMPSOn9nDBabFj1Bh37Y9f1urVUyTaffEzdjf3KCexh67fQps+oOvj2j68OaO3oOE0bFFieh0QeJrfskWltwA6I4C6wP5C1J7Syoatx7BUiDvVpufgyRt8SlEgysoKsVvuiqs9Fsp5RLOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003482; c=relaxed/simple;
	bh=kqQwbDXXQF4P2jHFoQGE1gTtX/4I+rWArvV7YFqReek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDUzAJIVk/NMZbKs/6WbDByLPsYh3JnC8l8qHqco5Y0wnIAEgp+6F024UPGI6rLam00SMRa8KkgNI9+2rLwmWlA7nTPnxW7WpJEGcO61lNwhwnwtqWqEc9ChAqIDd146haSafLKM0EUnm6ueY8sOzt2X2JK/UlNQHmuedGEByfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md/ghe+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9716C4CEF0;
	Thu,  4 Sep 2025 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003481;
	bh=kqQwbDXXQF4P2jHFoQGE1gTtX/4I+rWArvV7YFqReek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=md/ghe+bvpopfvq2D0PKcjjn9nYpr7MpdPvXfCQiRzMoJmhxi2xQBH6NoDeNafY6j
	 PAP6BzCih7rdVdx02/3JDlRzjeItdy7JBFHt49fjd3CdOnPxKhe+HAmBOQy3WVXk4+
	 v2XFf2mToLD2DRE7tLZpMSeD5HlbfCA6wapQBs8huy93AX7CGcvsdbJTynI8+/UuLo
	 c5cQklKBuBWalFgPlx/6h5r01l2Aw7PDMMjLG29Hbz5iBWjKq8kLiADPD8lIe5xJgx
	 i9OAYa8/fTdX4I0XLXC2d69Y7QQAi4FAh4BLQ6cZckFgcr7zfEfyGcBkRKA5vVQpzk
	 u7jEioSFTuDNQ==
Date: Thu, 4 Sep 2025 06:31:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <aLm-2Lcnu602AB85@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1756985260.git.escape@linux.alibaba.com>
 <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>

Hello,

On Thu, Sep 04, 2025 at 07:39:32PM +0800, Yi Tao wrote:
...
> To avoid affecting other users, the per-thread-group rwsem is only used
> when the `favordynmods` flag is enabled.

Can you please:

- Note that this isn't necessary for cgroup2's recommended workflow and is
  thus gated behind favordynmods.

- Include performance numbers briefly.

> +extern bool have_favordynmods;
> +
>  /**
>   * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
>   * @tsk: target task
> @@ -838,6 +840,8 @@ struct cgroup_of_peak {
>  static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>  {
>  	percpu_down_read(&cgroup_threadgroup_rwsem);
> +	if (have_favordynmods)
> +		down_read(&tsk->signal->group_rwsem);
>  }
>  
>  /**
> @@ -848,6 +852,8 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
>   */
>  static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
>  {
> +	if (have_favordynmods)
> +		up_read(&tsk->signal->group_rwsem);
>  	percpu_up_read(&cgroup_threadgroup_rwsem);

Hmm... I wonder whether turning on/off the flag is racy. ie. what prevents
have_favordynmods flipping while a task is between change_begin and end?

> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 1ef1edbaaf79..86fbc99a9174 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -226,6 +226,10 @@ struct signal_struct {
>  	struct tty_audit_buf *tty_audit_buf;
>  #endif
>  
> +#ifdef CONFIG_CGROUPS
> +	struct rw_semaphore group_rwsem;
> +#endif

Maybe name it more specific - e.g. cgroup_threadgroup_rwsem?

>  /**
>   * cgroup_attach_lock - Lock for ->attach()
> - * @lock_threadgroup: whether to down_write cgroup_threadgroup_rwsem
> + * @tsk: thread group to lock
> + * @lock_threadgroup: whether to down_write rwsem
>   *
>   * cgroup migration sometimes needs to stabilize threadgroups against forks and
>   * exits by write-locking cgroup_threadgroup_rwsem. However, some ->attach()
> @@ -2480,21 +2481,30 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
>   * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
>   * CPU hotplug is disabled on entry.
>   */

Please expand the function comment to explain what's going on and why and
maybe point to it from a comment on top of favor_dynmods.

> -void cgroup_attach_lock(bool lock_threadgroup)
> +void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup)

As @tsk is an optional argument, it'd probably make more sense to put it at
the end.

> @@ -3010,15 +3008,27 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
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
> +	cgroup_attach_lock(tsk, *threadgroup_locked);

I'm not sure this relocation is safe. What prevents e.g. @tsk changing its
group leader or signal struct before lock is grabbed?

Thanks.

-- 
tejun

