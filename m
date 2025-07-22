Return-Path: <cgroups+bounces-8855-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B46DB0E063
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 17:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34F061C81977
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 15:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AEB267F57;
	Tue, 22 Jul 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hhnQxlgP"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2C82676DE;
	Tue, 22 Jul 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197817; cv=none; b=eDZG92+lAnVzPepoWczq48GQ7wHFZrIj0X5rP4sqMqaZjvD2ijvEhgFt2eQnjwCtjs1RS1Y3IMxG6XGWGUFKQ/rM+RRDq8zwOezUN+7Krk4Ums/JYTarFlQ6jUxG5rTP4W6GKVNWh4bL1Pko2iJrkoFT7jjvbKqo6npvzFKlNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197817; c=relaxed/simple;
	bh=9mlVoc3FBEEl8p+6THtWnbca020TDv8vCT/WiX31YsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpcak/FhMmfeFmoXRZ78oxb0Udc32sAsLkZj114v0f1yoOqqhznr+KWWDO3YJTuQgCacFP6gEoThcThPkw5nc+6KdsZ9KcKB/wG7aFuFjramr+VKmNE0q0c0V3ZFO4GbskBsJmHWMGGXjXriaeEKq1/7ql81fvJ/QiCmY/cJfsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hhnQxlgP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 08:23:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753197813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJ44111fXBsN53btMRZyg0rLI9oEOEb3H/UhOmLZ8Xc=;
	b=hhnQxlgPfoBZVlQNNtu63+Y1MGfeHcKtacEGPpNK67sipf3w8MwCobZu9QLhmY74ZdqFiq
	yUuOanicbtX5Tr793ySr96EFpMksvJJ5gJdjxdO8N9rsYKOHE48EcDu8QLCliSbaF3rq8u
	zbpYFxY1Tb+8I7MJbd3KoalmNZqV/w4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Bertrand Wlodarczyk <bertrand.wlodarczyk@intel.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, 
	edumazet@google.com, gthelen@google.com, yosry.ahmed@linux.dev, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, inwardvessel@gmail.com
Subject: Re: [PATCH] cgroup/rstat: move css_rstat_lock outside cpu loop
Message-ID: <oxe2ksih27igcstfgyyvbzirn5i55qlxkrsfdtitlx6ltpdp4s@vax2vt5433yh>
References: <20250722124317.2698497-3-bertrand.wlodarczyk@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722124317.2698497-3-bertrand.wlodarczyk@intel.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 02:43:19PM +0200, Bertrand Wlodarczyk wrote:
> By moving the lock outside the CPU loop, we reduce the frequency
> of costly lock acquisition.
> This adjustment slightly improves performance in scenarios where
> multiple CPUs concurrently attempt to acquire the lock for
> the same css.

Did you see the commit 0efc297a3c497 ("cgroup/rstat: avoid disabling
irqs for O(num_cpu)") for the reasoning on why we are doing this?

> 
> The cpu argument passed to __css_rstat_lock, which was utilized
> by the event system, has been removed because it is no longer in use.
> ---
> Results:
>  
> QEMU vm
> +-------+---------+
> | main  | patched |
> +-------+---------+
> | 9.17s | 2.36s   |
> +-------+---------+
> ext4 raw image with debian:
> qemu-system-x86_64 -enable-kvm -cpu host -smp 102 -m 16G -kernel linux-cgroup/arch/x86/boot/bzImage -drive file=rootfs.ext4,if=virtio,format=raw -append "rootwait root=/dev/vda console=tty1 console=ttyS0 nokaslr cgroup_enable=memory cgroup_memory=1" -net nic,model=virtio -net user -nographic
> 
> Benchmark code: https://gist.github.com/bwlodarcz/c955b36b5667f0167dffcff23953d1da
> musl-gcc -o benchmark -static -g3 -DNUM_THREADS=10 -DNUM_ITER=10000 -O2 -Wall benchmark.c -pthread
> ---
>  include/trace/events/cgroup.h | 22 ++++++++++------------
>  kernel/cgroup/rstat.c         | 20 +++++++++-----------
>  2 files changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
> index ba9229af9a34..eb674eef8b99 100644
> --- a/include/trace/events/cgroup.h
> +++ b/include/trace/events/cgroup.h
> @@ -206,15 +206,14 @@ DEFINE_EVENT(cgroup_event, cgroup_notify_frozen,
>  
>  DECLARE_EVENT_CLASS(cgroup_rstat,
>  
> -	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +	TP_PROTO(struct cgroup *cgrp, bool contended),
>  
> -	TP_ARGS(cgrp, cpu, contended),
> +	TP_ARGS(cgrp, contended),
>  
>  	TP_STRUCT__entry(
>  		__field(	int,		root			)
>  		__field(	int,		level			)
>  		__field(	u64,		id			)
> -		__field(	int,		cpu			)
>  		__field(	bool,		contended		)
>  	),
>  
> @@ -222,13 +221,12 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
>  		__entry->root = cgrp->root->hierarchy_id;
>  		__entry->id = cgroup_id(cgrp);
>  		__entry->level = cgrp->level;
> -		__entry->cpu = cpu;
>  		__entry->contended = contended;
>  	),
>  
> -	TP_printk("root=%d id=%llu level=%d cpu=%d lock contended:%d",
> +	TP_printk("root=%d id=%llu level=%d lock contended:%d",
>  		  __entry->root, __entry->id, __entry->level,
> -		  __entry->cpu, __entry->contended)
> +		  __entry->contended)
>  );
>  
>  /*
> @@ -238,23 +236,23 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
>   */
>  DEFINE_EVENT(cgroup_rstat, cgroup_rstat_lock_contended,
>  
> -	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +	TP_PROTO(struct cgroup *cgrp, bool contended),
>  
> -	TP_ARGS(cgrp, cpu, contended)
> +	TP_ARGS(cgrp, contended)
>  );
>  
>  DEFINE_EVENT(cgroup_rstat, cgroup_rstat_locked,
>  
> -	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +	TP_PROTO(struct cgroup *cgrp, bool contended),
>  
> -	TP_ARGS(cgrp, cpu, contended)
> +	TP_ARGS(cgrp, contended)
>  );
>  
>  DEFINE_EVENT(cgroup_rstat, cgroup_rstat_unlock,
>  
> -	TP_PROTO(struct cgroup *cgrp, int cpu, bool contended),
> +	TP_PROTO(struct cgroup *cgrp, bool contended),
>  
> -	TP_ARGS(cgrp, cpu, contended)
> +	TP_ARGS(cgrp, contended)
>  );
>  
>  #endif /* _TRACE_CGROUP_H */
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index c8a48cf83878..dd312fe1896d 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -326,8 +326,7 @@ __bpf_hook_end();
>   * value -1 is used when obtaining the main lock else this is the CPU
>   * number processed last.
>   */
> -static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
> -		int cpu_in_loop)
> +static inline void __css_rstat_lock(struct cgroup_subsys_state *css)
>  	__acquires(ss_rstat_lock(css->ss))
>  {
>  	struct cgroup *cgrp = css->cgroup;
> @@ -337,21 +336,20 @@ static inline void __css_rstat_lock(struct cgroup_subsys_state *css,
>  	lock = ss_rstat_lock(css->ss);
>  	contended = !spin_trylock_irq(lock);
>  	if (contended) {
> -		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
> +		trace_cgroup_rstat_lock_contended(cgrp, contended);
>  		spin_lock_irq(lock);
>  	}
> -	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
> +	trace_cgroup_rstat_locked(cgrp, contended);
>  }
>  
> -static inline void __css_rstat_unlock(struct cgroup_subsys_state *css,
> -				      int cpu_in_loop)
> +static inline void __css_rstat_unlock(struct cgroup_subsys_state *css)
>  	__releases(ss_rstat_lock(css->ss))
>  {
>  	struct cgroup *cgrp = css->cgroup;
>  	spinlock_t *lock;
>  
>  	lock = ss_rstat_lock(css->ss);
> -	trace_cgroup_rstat_unlock(cgrp, cpu_in_loop, false);
> +	trace_cgroup_rstat_unlock(cgrp, false);
>  	spin_unlock_irq(lock);
>  }
>  
> @@ -381,11 +379,11 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
>  		return;
>  
>  	might_sleep();
> +	__css_rstat_lock(css);
>  	for_each_possible_cpu(cpu) {
>  		struct cgroup_subsys_state *pos;
>  
>  		/* Reacquire for each CPU to avoid disabling IRQs too long */
> -		__css_rstat_lock(css, cpu);
>  		pos = css_rstat_updated_list(css, cpu);
>  		for (; pos; pos = pos->rstat_flush_next) {
>  			if (is_self) {
> @@ -395,10 +393,10 @@ __bpf_kfunc void css_rstat_flush(struct cgroup_subsys_state *css)
>  			} else
>  				pos->ss->css_rstat_flush(pos, cpu);
>  		}
> -		__css_rstat_unlock(css, cpu);
>  		if (!cond_resched())

cond_resched() with the spin lock held?

>  			cpu_relax();
>  	}
> +	__css_rstat_unlock(css);
>  }
>  
>  int css_rstat_init(struct cgroup_subsys_state *css)
> @@ -685,11 +683,11 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
>  
>  	if (cgroup_parent(cgrp)) {
>  		css_rstat_flush(&cgrp->self);
> -		__css_rstat_lock(&cgrp->self, -1);
> +		__css_rstat_lock(&cgrp->self);
>  		bstat = cgrp->bstat;
>  		cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
>  			       &bstat.cputime.utime, &bstat.cputime.stime);
> -		__css_rstat_unlock(&cgrp->self, -1);
> +		__css_rstat_unlock(&cgrp->self);
>  	} else {
>  		root_cgroup_cputime(&bstat);
>  	}
> -- 
> 2.49.0
> 

