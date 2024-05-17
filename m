Return-Path: <cgroups+bounces-2950-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0358A8C8DCF
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 23:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF69F1F23F9A
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 21:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0276E1420A8;
	Fri, 17 May 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pbL1P25V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljOPtLVG"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D11419AA;
	Fri, 17 May 2024 21:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981881; cv=none; b=rQQxlzVFP9ZL8PMBBCgeCervdEkwt7mp38FZRKOZW5gHChbkpK/WzZYLwWhhRvjJFxGausybQEAInqbHc+6LBQpxz5McnMKWO5IWfhmT/DBCT7U+9UGqJkq0lh4ZVBzsHA3Owkmq9XnlwYjlhjOUWRTPi3JTB+J2teKZjX2VrLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981881; c=relaxed/simple;
	bh=O59K4hbDSsfiQU0mSa0j9lbI6l1M9YPmNCHJAuUsARc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IXOaKBCKpx+vuMd+F9Cw6tGll//1OW+GrZJVhaw28BVziC+JqwESaRjTMv/eIFn+CMU6JRmvGRlOfEiJ6sMB1A5GcZT9p6V0mAjpnJiFyozHySX/B+Nql++uSU3Q4ccC/jsVJzNiBGYKQ/AHWGmDgfF2rRAQAIciQbxilW1g0MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pbL1P25V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljOPtLVG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715981878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXtrA5LLFohLOjGP/edadyudWrEZRBECLedxJJ0rcYI=;
	b=pbL1P25VT61HHZRS50rO5Gwpx0znpq5MQBGNgqKMYKYleyJZOtQx/eoVHjlw/zuCRaSnJC
	ULNr2b2vZQ7C8CJO34JuGGF5mWaWHGTOB2t2RNmso+xBL8Oo4zlEbAlXHkIMwS4hFtwlIz
	2wdHQ3Wf3U5sCusbJzVXSrZnf+mQuntB6pjpF1nXhmp14eCOWy3OUCsyCOsLF0HUtsTcNI
	+E11XF1xFIS/0YWOW1JlCrgmm706qH6lj3GAIaEkqqEZhydbpekZh6nnAMxIuWVhc8WcFe
	dRco29ASa07t9RPrZ//V0G43K+YJ4zFOSZWBUnempkruDisMuCKTTuBP3LHF7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715981878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DXtrA5LLFohLOjGP/edadyudWrEZRBECLedxJJ0rcYI=;
	b=ljOPtLVGpxmk0jU3L4UqfG5IrEz0yayhXyrM3c/ZgIIHuhN+I+V36vHKQAxVndVuIuwDKX
	O1HriLIZJtakL3Bw==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 pauld@redhat.com, juri.lelli@redhat.com, prarit@redhat.com,
 vschneid@redhat.com, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Yoann Congal <yoann.congal@smile.fr>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Costa
 Shulyupin <costa.shul@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v1 1/7] sched/isolation: Add infrastructure to adjust
 affinity for dynamic CPU isolation
In-Reply-To: <20240516190437.3545310-2-costa.shul@redhat.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
 <20240516190437.3545310-2-costa.shul@redhat.com>
Date: Fri, 17 May 2024 23:37:57 +0200
Message-ID: <877cfsjf0q.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 16 2024 at 22:04, Costa Shulyupin wrote:
> Introduce infrastructure function housekeeping_update() to change
> housekeeping_cpumask during runtime and adjust affinities of depended
> subsystems.
>
> Affinity adjustments of subsystems follow in subsequent patches.
>
> Parent patch:
> "sched/isolation: Exclude dynamically isolated CPUs from housekeeping masks"
> https://lore.kernel.org/lkml/20240229021414.508972-2-longman@redhat.com/
>
> Test example for cgroup2:
>
> cd /sys/fs/cgroup/
> echo +cpuset > cgroup.subtree_control
> mkdir test
> echo isolated > test/cpuset.cpus.partition
> echo $isolate > test/cpuset.cpus

This changelog is not telling me anything. Please see
Documentation/process/ what changelogs should contain.

> +/*
> + * housekeeping_update - change housekeeping.cpumasks[type] and propagate the
> + * change.
> + *
> + * Assuming cpuset_mutex is held in sched_partition_write or
> + * cpuset_write_resmask.

Locking cannot be assumed. lockdep_assert_held() is there to document
and enforce such requirements.

> + */
> +static int housekeeping_update(enum hk_type type, cpumask_var_t update)

Please us 'struct cpumask *update' as it makes it clear what this is
about. cpumask_var_t is a hack to make onstack and embedded cpumask and
their allocated counterparts possible without #ifdeffery in the code.

But any function which is not related to alloc/free of cpumask_var_t
should simply use 'struct cpumask *' as argument type.

> +	housekeeping.flags |= BIT(type);

The existing code uses WRITE_ONCE() probably for a reason. Why is that
not longer required here?

>  static int __init housekeeping_setup(char *str, unsigned long flags)
>  {
>  	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
> @@ -314,9 +347,12 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
>  		/*
>  		 * Reset housekeeping to bootup default
>  		 */
> -		for_each_set_bit(type, &housekeeping_boot.flags, HK_TYPE_MAX)
> -			cpumask_copy(housekeeping.cpumasks[type],
> -				     housekeeping_boot.cpumasks[type]);
> +		for_each_set_bit(type, &housekeeping_boot.flags, HK_TYPE_MAX) {
> +			int err = housekeeping_update(type, housekeeping_boot.cpumasks[type]);
> +
> +			if (err)
> +				return err;
> +		}
>  
>  		WRITE_ONCE(housekeeping.flags, housekeeping_boot.flags);
>  		if (!housekeeping_boot.flags &&
> @@ -344,9 +380,11 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
>  		cpumask_andnot(tmp_mask, src_mask, isolcpus);
>  		if (!cpumask_intersects(tmp_mask, cpu_online_mask))
>  			return -EINVAL;	/* Invalid isolated CPUs */
> -		cpumask_copy(housekeeping.cpumasks[type], tmp_mask);
> +		int err = housekeeping_update(type, tmp_mask);
> +
> +		if (err)
> +			return err;

Do we really need two places to define 'int err' or might it be possible
to have one instance defined at function scope?

Thanks,

        tglx

