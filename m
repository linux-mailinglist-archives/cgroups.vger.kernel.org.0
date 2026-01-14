Return-Path: <cgroups+bounces-13209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F38D1F65E
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 15:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88D7130454A5
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4662D97BB;
	Wed, 14 Jan 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XueP6IYn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKjEwBc+"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEE21D585
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768400456; cv=none; b=MLiSOhyqUM4W+7nj32PC5jOAPKiRum0WbMt+ooWmrzUfx3PAYOrMsTPpvf5NR4r4IS2U5jlXLcIKr1Tvj+za8AdyUtfzSbF1VKoo8esnWLPSEs94zMGsM6AibNnAPmEJslwI2QCCdo4mOun14YNierIwjmTD0xoziCkeFsjQXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768400456; c=relaxed/simple;
	bh=XMj4ssOkyrzw5suqQ9n8OiEK3bHMp4fUmo//LSS0zBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYTndlM8WXXlCn+gOrWz4mkcWv1tvhKxK9ekX3zCHUuJ/hRGBYkFWUrt9pkjGgrxx43V8EfzSsz5JIWW59wmN1UjvQqKNUuEhMyJX2NVA0MnNfblmNYYqFD/yCBkd/Q5UTx5I0oBj8g3ADYE7Fs2u6nB1nfh6Mb5MfFRIKhycBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XueP6IYn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKjEwBc+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768400454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nAAVPKAhdXdYSTKcBmSZbQ487SONxLb+XK4TvVsSDGA=;
	b=XueP6IYnQU1FhWnVDl28TlR2t2QFgwL71xp0Z2mAj2o+G68M4tCyMnaCLMwLdiu3Q9ronA
	N0+dXLNIRhfplYFUl8nyQ8PTYgmKNcPMyf/mzisfPdOBLLWSDSUV2ewpLWqF295jXoEjdI
	z9RdQ2TaRNNXtYSWNEYxWwPKTuKQJi0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-yUGLCp3POB2CpOSU14vyXg-1; Wed, 14 Jan 2026 09:20:53 -0500
X-MC-Unique: yUGLCp3POB2CpOSU14vyXg-1
X-Mimecast-MFC-AGG-ID: yUGLCp3POB2CpOSU14vyXg_1768400452
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fc153d50so6458825f8f.1
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768400452; x=1769005252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nAAVPKAhdXdYSTKcBmSZbQ487SONxLb+XK4TvVsSDGA=;
        b=WKjEwBc+DpI6RF0VGtR5pUebMvX8hPtm/CYlh0EOVt1FAN907qFoOAEI4Enq9NcrkA
         C2Y/EYemCbiBhSb7xuFfHWL3k6mVsXdnO4hDIplMA52t4L5j1p3r91MswABmHOyuYxBY
         pY7+bgrQ04AY3No0B3K3RWGMPxgLcIj8+2Wj83vyozSMRQPQs2WKfaEyrpMV7wBAQ8bM
         uYR6w2Gv1QqYvG7kK6n4Lvp8XAaskGc1ZhNmDEPC6CMx0v2JmqtEvhvcLlVkmihwwR/f
         6pf+Z3AE0YEIXbxrKjd5I4Q2XdiO0464UzAoUcQ3XSQkfiqKQgm+XLWw/CTHgAIwW/d9
         QK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768400452; x=1769005252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nAAVPKAhdXdYSTKcBmSZbQ487SONxLb+XK4TvVsSDGA=;
        b=kWJFTPSMwODTSebhVXydChetIPsLY3VDvfG5ghzE4Kq6AU7hdJMWDMbdte2Igcf7w4
         hLFbr4Vp46QtQu6um2AiNSDQ18sfihnRF/IRdwWiafTReRET5ES9QBYJZgWLyUssZ2jW
         gyR05pmxgKnECiyg1R+cS/ldoiQdqFwIQ+W0QQqon6mfOMs0Yok+87IXe4S9zdp40JgT
         MPLlI09QOMssUUts8x19VhmZSWds806y8ZwddfWj/8acr3gkR2EIhoOEiYK0V4hNbu9Z
         mhkZWupc0HWS/k84e/EIzE7dUv7WZPNPHKN8Jut1BT7EcpZaDQsZroI/qLtbtZXgr/xt
         RUPA==
X-Forwarded-Encrypted: i=1; AJvYcCWqRmo2vcxVF3N1Ny2zJFWHqok6VgzJq+P3FCcTjgFnlVs+7jFxgDPn4FOAvjChH1j67ux/v60Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9OxTixYUnMh9k7fCZS4F5lz90xXPoEPfgIOZQ/7fipgwHWjll
	pNX0q7vqibiKN3OSc6Wa8KZElphdqVlp7hq1nqf1K1b3QNlShmzEyuCAgnPafaMsw2ADV2pnrRW
	OCU9V9D5u0hNCYzwIO0DF46CTScG1kICWh3k+2FeILWVu5eC83SGcVDMytck=
X-Gm-Gg: AY/fxX6Gd529dbiGfIj8kg2ONMP7K8WBaVkxcQ39JuhTFm8z0LdSebRz+vKUmqAjDYF
	KJU19Nton3TxexhGjddd0U3zzcvdofToIuvhLNDvcrIZO2QfZqQh3hzeO6C6VAVBPrfK6OjqDGS
	hBFO84AgQlIPDj1qbu8yPuEKTaZmVZIQCQ4lE7QtCfBB2mySzrzIK0f7HAAL7qF4vUAR1cvKoB4
	3KXQWYO5Qi4vx4WuaxG8ZJlgjbUWSGrPIOgL7X3chVV+AYQF70/5L8zs/+tOrupKbMwMYwuKyqP
	/bU+hTo/1EUTcvUj5IdN15YURPaw7Sl/fT3ZSWUxEmhDMR991X5t4wV7TeWUQIzPmZPnS573TSh
	onYhFWR8CP0IJTnyx5xS+MoDCqVVIBPcdvmyGzkzB
X-Received: by 2002:a05:6000:200d:b0:430:fd9f:e6e2 with SMTP id ffacd0b85a97d-4342c4ee846mr2866423f8f.9.1768400451817;
        Wed, 14 Jan 2026 06:20:51 -0800 (PST)
X-Received: by 2002:a05:6000:200d:b0:430:fd9f:e6e2 with SMTP id ffacd0b85a97d-4342c4ee846mr2866361f8f.9.1768400451309;
        Wed, 14 Jan 2026 06:20:51 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e180csm48924149f8f.10.2026.01.14.06.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 06:20:50 -0800 (PST)
Date: Wed, 14 Jan 2026 15:20:48 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Pierre Gondois <pierre.gondois@arm.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>,
	luca.abeni@santannapisa.it
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <aWemQDHyF2FpNU2P@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
 <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
 <20260114130528.GB831285@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114130528.GB831285@noisy.programming.kicks-ass.net>

On 14/01/26 14:05, Peter Zijlstra wrote:
> On Wed, Jan 14, 2026 at 11:23:36AM +0100, Peter Zijlstra wrote:
> 
> > Juri, Luca, I'm tempted to suggest to simply remove the replenish on
> > RESTORE entirely -- that would allow the task to continue as it had
> > been, irrespective of it being 'late'.
> > 
> > Something like so -- what would this break?
> > 
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -2214,10 +2214,6 @@ enqueue_dl_entity(struct sched_dl_entity
> >  		update_dl_entity(dl_se);
> >  	} else if (flags & ENQUEUE_REPLENISH) {
> >  		replenish_dl_entity(dl_se);
> > -	} else if ((flags & ENQUEUE_RESTORE) &&
> > -		   !is_dl_boosted(dl_se) &&
> > -		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
> > -		setup_new_dl_entity(dl_se);
> >  	}
> >  
> >  	/*
> 
> Ah, this is de-boost, right? Boosting allows one to break the CBS rules
> and then we have to rein in the excesses.
> 
> But we have {DE,EN}QUEUE_MOVE for this, that explicitly allows priority
> to change and is set for rt_mutex_setprio() (among others).
> 
> So doing s/RESTORE/MOVE/ above.
> 
> The corollary to all this is that everybody that sets MOVE must be able
> to deal with balance callbacks, so audit that too.
> 
> This then gives something like so.. which builds and boots for me, but
> clearly I haven't been able to trigger these funny cases.
> 
> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4969,9 +4969,13 @@ struct balance_callback *splice_balance_
>  	return __splice_balance_callbacks(rq, true);
>  }
>  
> -static void __balance_callbacks(struct rq *rq)
> +void __balance_callbacks(struct rq *rq, struct rq_flags *rf)
>  {
> +	if (rf)
> +		rq_unpin_lock(rq, rf);
>  	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
> +	if (rf)
> +		rq_repin_lock(rq, rf);
>  }
>  
>  void balance_callbacks(struct rq *rq, struct balance_callback *head)
> @@ -5018,7 +5022,7 @@ static inline void finish_lock_switch(st
>  	 * prev into current:
>  	 */
>  	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
> -	__balance_callbacks(rq);
> +	__balance_callbacks(rq, NULL);
>  	raw_spin_rq_unlock_irq(rq);
>  }
>  
> @@ -6901,7 +6905,7 @@ static void __sched notrace __schedule(i
>  			proxy_tag_curr(rq, next);
>  
>  		rq_unpin_lock(rq, &rf);
> -		__balance_callbacks(rq);
> +		__balance_callbacks(rq, NULL);
>  		raw_spin_rq_unlock_irq(rq);
>  	}
>  	trace_sched_exit_tp(is_switch);
> @@ -7350,7 +7354,7 @@ void rt_mutex_setprio(struct task_struct
>  	trace_sched_pi_setprio(p, pi_task);
>  	oldprio = p->prio;
>  
> -	if (oldprio == prio)
> +	if (oldprio == prio && !dl_prio(prio))
>  		queue_flag &= ~DEQUEUE_MOVE;
>  
>  	prev_class = p->sched_class;
> @@ -7396,9 +7400,7 @@ void rt_mutex_setprio(struct task_struct
>  out_unlock:
>  	/* Caller holds task_struct::pi_lock, IRQs are still disabled */
>  
> -	rq_unpin_lock(rq, &rf);
> -	__balance_callbacks(rq);
> -	rq_repin_lock(rq, &rf);
> +	__balance_callbacks(rq, &rf);
>  	__task_rq_unlock(rq, p, &rf);
>  }
>  #endif /* CONFIG_RT_MUTEXES */
> @@ -9167,6 +9169,8 @@ void sched_move_task(struct task_struct
>  
>  	if (resched)
>  		resched_curr(rq);
> +
> +	__balance_callbacks(rq, &rq_guard.rf);
>  }
>  
>  static struct cgroup_subsys_state *
> @@ -10891,6 +10895,9 @@ void sched_change_end(struct sched_chang
>  				resched_curr(rq);
>  		}
>  	} else {
> +		/*
> +		 * XXX validate prio only really changed when ENQUEUE_MOVE is set.
> +		 */
>  		p->sched_class->prio_changed(rq, p, ctx->prio);
>  	}
>  }
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2214,9 +2214,14 @@ enqueue_dl_entity(struct sched_dl_entity
>  		update_dl_entity(dl_se);
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se);
> -	} else if ((flags & ENQUEUE_RESTORE) &&
> +	} else if ((flags & ENQUEUE_MOVE) &&
>  		   !is_dl_boosted(dl_se) &&
>  		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
> +		/*
> +		 * Deals with the de-boost case, and ENQUEUE_MOVE explicitly
> +		 * allows us to change priority. Callers are expected to deal
> +		 * with balance_callbacks.
> +		 */
>  		setup_new_dl_entity(dl_se);
>  	}
>  
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -545,6 +545,7 @@ static void scx_task_iter_start(struct s
>  static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
>  {
>  	if (iter->locked_task) {
> +		__balance_callbacks(iter->rq, &iter->rf);
>  		task_rq_unlock(iter->rq, iter->locked_task, &iter->rf);
>  		iter->locked_task = NULL;
>  	}
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2430,7 +2430,8 @@ extern const u32		sched_prio_to_wmult[40
>   *                should preserve as much state as possible.
>   *
>   * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the location
> - *        in the runqueue.
> + *        in the runqueue. IOW the priority is allowed to change. Callers
> + *        must expect to deal with balance callbacks.
>   *
>   * NOCLOCK - skip the update_rq_clock() (avoids double updates)
>   *
> @@ -4019,6 +4020,8 @@ extern void enqueue_task(struct rq *rq,
>  extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
>  
>  extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
> +
> +extern void __balance_callbacks(struct rq *rq, struct rq_flags *rf);
>  extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
>  
>  /*
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
>  		 * itself.
>  		 */
>  		newprio = rt_effective_prio(p, newprio);
> -		if (newprio == oldprio)
> +		if (newprio == oldprio && !dl_prio(newprio))
>  			queue_flags &= ~DEQUEUE_MOVE;
>  	}

We have been using (improperly?) ENQUEUE_SAVE also to know when a new
entity gets setscheduled to DEADLINE (or its parameters are changed) and
it looks like this keeps that happening with DEQUEUE_MOVE. So, from a
quick first look, it does sound good to me.

Thanks!
Juri


