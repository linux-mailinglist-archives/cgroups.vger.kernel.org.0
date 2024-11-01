Return-Path: <cgroups+bounces-5368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E006F9B8E99
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 11:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973F01F216D4
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 10:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B115990C;
	Fri,  1 Nov 2024 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZbCr/7GF"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C856F14F9F8;
	Fri,  1 Nov 2024 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730455599; cv=none; b=dRJX8+iYDQWT/ZL9+PZKkeaPX8Pr5KryKBn5qOk/itISQLPfhecUBErZQiXOjBKYkig5oPJua16DAICVPMaJxwfLCoSNMslSfhAkhdgOcZZkUgqbC0lAp+jQKJ92BCPa2McQOsqdwDxYs+CPHKn1l3A/iEyrdiKIoME8sANvZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730455599; c=relaxed/simple;
	bh=YVhSfI05XHIi1Dl9EmYvodItKEm9CBoIyMk/S4f2RMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGnOl3w6wL3zlHyqBC6981eJEGYDK7QVbWW0w2mk92vEPBj85NU5dcdg7jM6amaw332vMp/qo549P+vQx/1wVnxsaq/ILPVzuXkRt7ELb8Ivrmi38dzioKiExJnvFSLE24N+tb/h2MJY9Z/1wsSzE+MmShBEcqb8l0SltHMU81U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZbCr/7GF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cf5fEKqyg0JCHgtnclveqmepDTzyGOuykD6LHhl+fJE=; b=ZbCr/7GF2MOJ1weTB5sm/iGsCp
	ukjlXVB+BCo8hMOpOWMOIbb+7UMTGun2L6T5VUsz6s2R774ZWGu1/YHfexDwaoqGuV2a6cjxcBA5k
	YK2hNI27rQdRKPVFTfW+JsKElmpubX+IExaxLDMao864N+ZTh+jdDKTN8/17YW2sw65wnziSPm/DJ
	nxLuRqbnZ24C58repf/BC8hwrHlNwgsV0eQTefBvbqkxrDoKj+2FWXNt4LGFxH+pbQWrabbXPMJRe
	/f3GoMvZQLi1YCE646tt/7Hhc0Fe+zdQ/3dzeHZeED46AZgV6w5nDBnCnbio0jF6bRBKyfCXJB8JC
	oDVHMOQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6oXq-0000000Af1V-3cwN;
	Fri, 01 Nov 2024 10:06:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7525300359; Fri,  1 Nov 2024 11:06:17 +0100 (CET)
Date: Fri, 1 Nov 2024 11:06:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org,
	surenb@google.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] sched: Define sched_clock_irqtime as static key
Message-ID: <20241101100617.GV14555@noisy.programming.kicks-ass.net>
References: <20241101031750.1471-1-laoar.shao@gmail.com>
 <20241101031750.1471-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101031750.1471-2-laoar.shao@gmail.com>

On Fri, Nov 01, 2024 at 11:17:47AM +0800, Yafang Shao wrote:
> Since CPU time accounting is a performance-critical path, let's define
> sched_clock_irqtime as a static key to minimize potential overhead.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/sched/cputime.c | 16 +++++++---------
>  kernel/sched/sched.h   |  1 +
>  2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 0bed0fa1acd9..d0b6ea737d04 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -7,6 +7,8 @@
>   #include <asm/cputime.h>
>  #endif
>  
> +DEFINE_STATIC_KEY_FALSE(sched_clock_irqtime);
> +
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>  
>  /*
> @@ -22,16 +24,14 @@
>   */
>  DEFINE_PER_CPU(struct irqtime, cpu_irqtime);
>  
> -static int sched_clock_irqtime;
> -
>  void enable_sched_clock_irqtime(void)
>  {
> -	sched_clock_irqtime = 1;
> +	static_branch_enable(&sched_clock_irqtime);
>  }
>  
>  void disable_sched_clock_irqtime(void)
>  {
> -	sched_clock_irqtime = 0;
> +	static_branch_disable(&sched_clock_irqtime);
>  }
>  
>  static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
> @@ -57,7 +57,7 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
>  	s64 delta;
>  	int cpu;
>  
> -	if (!sched_clock_irqtime)
> +	if (!static_branch_likely(&sched_clock_irqtime))
>  		return;
>  
>  	cpu = smp_processor_id();
> @@ -90,8 +90,6 @@ static u64 irqtime_tick_accounted(u64 maxtime)
>  
>  #else /* CONFIG_IRQ_TIME_ACCOUNTING */
>  
> -#define sched_clock_irqtime	(0)
> -
>  static u64 irqtime_tick_accounted(u64 dummy)
>  {
>  	return 0;

This makes no sense... in the IRQ_TIME_ACCOUNTING=n case you shouldn't
be using the static key.

> @@ -478,7 +476,7 @@ void account_process_tick(struct task_struct *p, int user_tick)
>  	if (vtime_accounting_enabled_this_cpu())
>  		return;
>  
> -	if (sched_clock_irqtime) {
> +	if (static_branch_likely(&sched_clock_irqtime)) {
>  		irqtime_account_process_tick(p, user_tick, 1);
>  		return;
>  	}
> @@ -507,7 +505,7 @@ void account_idle_ticks(unsigned long ticks)
>  {
>  	u64 cputime, steal;
>  
> -	if (sched_clock_irqtime) {
> +	if (static_branch_likely(&sched_clock_irqtime)) {
>  		irqtime_account_idle_ticks(ticks);
>  		return;
>  	}
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 081519ffab46..038ce65d6635 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3179,6 +3179,7 @@ struct irqtime {
>  };
>  
>  DECLARE_PER_CPU(struct irqtime, cpu_irqtime);
> +DECLARE_STATIC_KEY_FALSE(sched_clock_irqtime);
>  
>  /*
>   * Returns the irqtime minus the softirq time computed by ksoftirqd.
> -- 
> 2.43.5
> 

