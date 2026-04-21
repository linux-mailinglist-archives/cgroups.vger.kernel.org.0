Return-Path: <cgroups+bounces-15427-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPJJN+M652no5QEAu9opvQ
	(envelope-from <cgroups+bounces-15427-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:52:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A15024386AD
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18BC6304EB91
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 08:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D3399345;
	Tue, 21 Apr 2026 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pR8Z523t"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3E933F8C2;
	Tue, 21 Apr 2026 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761405; cv=none; b=lOIGx6YXscpfqI0bLAOdsUshkLoHN1byaSH9z3pjDsR7p+jR1nZT7ZtPM8kLej4RadszpYD9vUwFVFDckxJlRp7tQAYkrsRk8mskvzxJsDa+ewGnqig3/6noJX949bsnLigGsUydoTNxoeR1DlazZJtsGYnSKScchMBVu4B/Coo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761405; c=relaxed/simple;
	bh=HaTQPXvOEJyusO788jGddOJOEFqrCuHs2/f3+g1Am18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T2cuOIyS0I6Iac9j8mdgjq7OuJsnpFJaXsWPHLMIACAEkKMsDHbmuPJ3rNSEjRkXRsRtGjfZOvDtP0dBGJH1TdcmWW4GULNUSw1/qwaEWA/SfsIPVgWPA29H50DY7ISjnhdmdO5x7IaND3HFuhtNI4igdfDGoIQ5c3kNwdu3AZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pR8Z523t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BB7C2BCB5;
	Tue, 21 Apr 2026 08:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776761405;
	bh=HaTQPXvOEJyusO788jGddOJOEFqrCuHs2/f3+g1Am18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pR8Z523tl/pYJTgna0TzpDJ97VzUhuDGpfMXUMlZSvJUP88/Uf6wwLL6TZpPWR05u
	 fD93UYvGK1Z22WuxegmEtlR4ePNUVX6G2eE2ADwU3KwsnRkrgv6KuslEMDj4RRqwRM
	 14skmyaN7pOCw5z4aXywKO7WdmtNgjWIjQBE7KBokI+Z8nr8LT+UnHedRP0w1FkO7/
	 PdygA/+aEmRmgNTyEpaQ4QOWy0df653T3ZV/1poX6L5HiEPSJxYDfp5OljRX0SkdFT
	 tqfeD8TETWZix6tWtCS922YGEo3mzAzhVFRtMGSFWkbCfLN9whd61bgc0fioeZwxZd
	 WIVg9roArtZ/w==
From: Thomas Gleixner <tglx@kernel.org>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Guenter Roeck <linux@roeck-us.net>, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Qiliang Yuan <realwujing@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 04/23] tick/nohz: Allow runtime changes in full dynticks
 CPUs
In-Reply-To: <20260421030351.281436-5-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-5-longman@redhat.com>
Date: Tue, 21 Apr 2026 10:50:00 +0200
Message-ID: <87340od7ev.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15427-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A15024386AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
> Full dynticks can only be enabled if "nohz_full" boot option has been
> been specified with or without parameter. Any change in the list of
> nohz_full CPUs have to be reflected in tick_nohz_full_mask. Introduce
> a new tick_nohz_full_update_cpus() helper that can be called to update
> the tick_nohz_full_mask at run time. The housekeeping_update() function
> is modified to call the new helper when the HK_TYPE_KERNEL_NOSIE cpumask
> is going to be changed.
>
> We also need to enable CPU context tracking for those CPUs that

We need nothing. Use passive voice for change logs as requested in
documentation.

> are in tick_nohz_full_mask. So remove __init from tick_nohz_init()
> and ct_cpu_track_user() so that they be called later when an isolated
> cpuset partition is being created. The __ro_after_init attribute is
> taken away from context_tracking_key as well.
>
> Also add a new ct_cpu_untrack_user() function to reverse the action of
> ct_cpu_track_user() in case we need to disable the nohz_full mode of
> a CPU.
>
> With nohz_full enabled, the boot CPU (typically CPU 0) will be the
> tick CPU which cannot be shut down easily. So the boot CPU should not
> be used in an isolated cpuset partition.
>
> With runtime modification of nohz_full CPUs, tick_do_timer_cpu can become
> TICK_DO_TIMER_NONE. So remove the two TICK_DO_TIMER_NONE WARN_ON_ONCE()
> checks in tick-sched.c to avoid unnecessary warnings.

in tick-sched.c? Describe the functions which contain that.

>  static inline void tick_nohz_task_switch(void)
> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
> index 925999de1a28..394e432630a3 100644
> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -411,7 +411,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/context_tracking.h>
>  
> -DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
> +DEFINE_STATIC_KEY_FALSE(context_tracking_key);
>  EXPORT_SYMBOL_GPL(context_tracking_key);
>  
>  static noinstr bool context_tracking_recursion_enter(void)
> @@ -674,9 +674,9 @@ void user_exit_callable(void)
>  }
>  NOKPROBE_SYMBOL(user_exit_callable);
>  
> -void __init ct_cpu_track_user(int cpu)
> +void ct_cpu_track_user(int cpu)
>  {
> -	static __initdata bool initialized = false;
> +	static bool initialized;
>  
>  	if (cpu == CONTEXT_TRACKING_FORCE_ENABLE) {
>  		static_branch_inc(&context_tracking_key);
> @@ -700,6 +700,15 @@ void __init ct_cpu_track_user(int cpu)
>  	initialized = true;
>  }
>  
> +void ct_cpu_untrack_user(int cpu)
> +{
> +	if (!per_cpu(context_tracking.active, cpu))
> +		return;
> +
> +	per_cpu(context_tracking.active, cpu) = false;
> +	static_branch_dec(&context_tracking_key);
> +}
> +

Why is this in a patch which makes tick/nohz related changes? This is a
preparatory change, so make it that way and do not bury it inside
something else.

> +/* Get the new set of run-time nohz CPU list & update accordingly */
> +void tick_nohz_full_update_cpus(struct cpumask *cpumask)
> +{
> +	int cpu;
> +
> +	if (!tick_nohz_full_running) {
> +		pr_warn_once("Full dynticks cannot be enabled without the nohz_full kernel boot parameter!\n");

That's the result of this enforced enable hackery. Make this work
properly.

> +		return;
> +	}
> +
> +	/*
> +	 * To properly enable/disable nohz_full dynticks for the affected CPUs,
> +	 * the new nohz_full CPUs have to be copied to tick_nohz_full_mask and
> +	 * ct_cpu_track_user/ct_cpu_untrack_user() will have to be called
> +	 * for those CPUs that have their states changed. Those CPUs should be
> +	 * in an offline state.
> +	 */
> +	for_each_cpu_andnot(cpu, cpumask, tick_nohz_full_mask) {
> +		WARN_ON_ONCE(cpu_online(cpu));
> +		ct_cpu_track_user(cpu);
> +		cpumask_set_cpu(cpu, tick_nohz_full_mask);
> +	}
> +
> +	for_each_cpu_andnot(cpu, tick_nohz_full_mask, cpumask) {
> +		WARN_ON_ONCE(cpu_online(cpu));
> +		ct_cpu_untrack_user(cpu);
> +		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
> +	}
> +}

So this writes to tick_nohz_full_mask while other CPUs can access
it. That's just wrong and I'm not at all interested in the resulting
KCSAN warnings.

tick_nohz_full_mask needs to become a RCU protected pointer, which is
updated once the new mask is established in a separately allocated one.

Thanks,

        tglx



