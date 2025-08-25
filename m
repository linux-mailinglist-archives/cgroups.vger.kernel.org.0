Return-Path: <cgroups+bounces-9394-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2277B34B0F
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 21:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0163F3BFB6B
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 19:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F706284B25;
	Mon, 25 Aug 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Od9hXyeB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E328467B
	for <cgroups@vger.kernel.org>; Mon, 25 Aug 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150888; cv=none; b=bBTiWSkUoJE6n3lmZS+U/HC5uox9OjTHWVuiLQn9jP9heZb6lJZeaKdw7JmhpLYyOHe+JCqsN7GUePZvIZ1isP/sl98ZdPgr3HbHXhhYnNI9mlVEIYpCquh0gz99Fsak0yaoHBoCYUVsBMR5B7KD3rE/+DZWwKARhBcYt4EOxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150888; c=relaxed/simple;
	bh=CNa5SrO9Ozj2K5TKBavGu1RD1M87DzO8+0POFqXJ18o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ5R0UdB+AecIiv9E5fZydt64UMqXvAqiy8yfQmrP0pUu+C5IXGAw+nax4bfm4cqbAy8/UJXGNHQNkCas0moGv8PvNu1QZrVDmc9n0fFcqMNIx7VzU6LaIpbv3wqnYkERY+s5T50MNnnxAlbw2k4CP4r+WGq7AMWG8HnTSiUMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Od9hXyeB; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Aug 2025 12:41:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756150874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DaBOeTNdTjLlU52HNYXZjxccsI5utUG+maXgRXm46HY=;
	b=Od9hXyeBDyV69Pof8vMx+qvOo82ai07aCUAO1EJ1QkJzqhMLQ7bfgvI6AibxQBCAOpJxGb
	WLboMc9Gu9foPdbGmBM5RmDRFzvBJ789zQQN1qv5isxftajqdtgxKQCH1ZnZubGJLQkbUL
	KU2Dx4eXZN2eWKIX8jCubinBW/wd4gA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: zhongjinji <zhongjinji@honor.com>
Cc: mhocko@suse.com, rientjes@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, 
	liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, liulu.liu@honor.com, 
	feng.han@honor.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 1/2] mm/oom_kill: Do not delay oom reaper when the
 victim is frozen
Message-ID: <jzzdeczuyraup2zrspl6b74muf3bly2a3acejfftcldfmz4ekk@s5mcbeim34my>
References: <20250825133855.30229-1-zhongjinji@honor.com>
 <20250825133855.30229-2-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825133855.30229-2-zhongjinji@honor.com>
X-Migadu-Flow: FLOW_OUT

+cgroups

On Mon, Aug 25, 2025 at 09:38:54PM +0800, zhongjinji wrote:
> The OOM reaper can quickly reap a process's memory when the system
> encounters OOM, helping the system recover. If the victim process is
> frozen and cannot be unfrozen in time, the reaper delayed by two seconds
> will cause the system to fail to recover quickly from the OOM state.
> 
> When an OOM occurs, if the victim is not unfrozen, delaying the OOM reaper
> will keep the system in a bad state for two seconds. Before scheduling the
> oom_reaper task, check whether the victim is in a frozen state. If the
> victim is frozen, do not delay the OOM reaper.
> 
> Signed-off-by: zhongjinji <zhongjinji@honor.com>
> ---
>  mm/oom_kill.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 25923cfec9c6..4b4d73b1e00d 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -683,6 +683,41 @@ static void wake_oom_reaper(struct timer_list *timer)
>  	wake_up(&oom_reaper_wait);
>  }
>  
> +/*
> + * When the victim is frozen, the OOM reaper should not be delayed, because
> + * if the victim cannot be unfrozen promptly, it may block the system from
> + * quickly recovering from the OOM state.
> + */
> +static bool should_delay_oom_reap(struct task_struct *tsk)
> +{
> +	struct mm_struct *mm = tsk->mm;
> +	struct task_struct *p;
> +	bool ret;
> +

On v2, shouldn't READ_ONCE(tsk->frozen) be enough instead of mm check
and checks insode for_each_process()?

> +	if (!mm)
> +		return true;
> +
> +	if (!frozen(tsk))
> +		return true;
> +
> +	if (atomic_read(&mm->mm_users) <= 1)
> +		return false;
> +
> +	rcu_read_lock();
> +	for_each_process(p) {
> +		if (!process_shares_mm(p, mm))
> +			continue;
> +		if (same_thread_group(tsk, p))
> +			continue;
> +		ret = !frozen(p);
> +		if (ret)
> +			break;
> +	}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
>  /*
>   * Give the OOM victim time to exit naturally before invoking the oom_reaping.
>   * The timers timeout is arbitrary... the longer it is, the longer the worst
> @@ -694,13 +729,16 @@ static void wake_oom_reaper(struct timer_list *timer)
>  #define OOM_REAPER_DELAY (2*HZ)
>  static void queue_oom_reaper(struct task_struct *tsk)
>  {
> +	bool delay;
> +
>  	/* mm is already queued? */
>  	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
>  		return;
>  
>  	get_task_struct(tsk);
> +	delay = should_delay_oom_reap(tsk);
>  	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
> -	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> +	tsk->oom_reaper_timer.expires = jiffies + (delay ? OOM_REAPER_DELAY : 0);
>  	add_timer(&tsk->oom_reaper_timer);
>  }
>  
> -- 
> 2.17.1
> 

