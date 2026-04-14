Return-Path: <cgroups+bounces-15301-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB89D2m43mkqHwAAu9opvQ
	(envelope-from <cgroups+bounces-15301-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 23:58:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D86553FEBA6
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 23:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A551302402C
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2026 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C638839D;
	Tue, 14 Apr 2026 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpO0O54J"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082A387566;
	Tue, 14 Apr 2026 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776203876; cv=none; b=RaICNizARuxFP47dUF+harhm2gm8/kmDVvLZff0ttvJCCkjDXBfxVxQCwswRaTyvU1GxKCT5/3K/MDGn/lL5/XrGIMDrkmbSY53mRvanqTtlkT0XcVsZrZUwq+riURnv1kfLucJLsk6/m+u+i1js+SBC9ynW/YJ6klLHAnur/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776203876; c=relaxed/simple;
	bh=ZUNzTicQgDcyFP5w0RI4Nrc7tmhjfuPP2YRMHTfeXHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=biQcYW6tYqJyKb5h0CSersXPTWthx+ZHfc6Qj+l7a4/9nY8+3p2M89t14c0th0uTDONXINd2OiKkdUXLe/oLjimbuKJsUfuAEJi+MlyL+k3goryBNRLuvZ1fMaCO3bmA/3d1FJ2oHr+GONLaPyMNx34Q355Vh05f7bn8FTnhB08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpO0O54J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA95EC19425;
	Tue, 14 Apr 2026 21:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776203875;
	bh=ZUNzTicQgDcyFP5w0RI4Nrc7tmhjfuPP2YRMHTfeXHw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bpO0O54J2tayfMK4LNj+PnNzYYE4jpf3X6/mDcNY+6rk5Iu3nuFLpco5R5ZzI0cqE
	 1FS2FTQ1hTF/HrWbhVai0pCIBDQh9x//cPwtiInWdpQwVH/0QW0vOVeXgnwFA27D+d
	 dWjnEJxD2jYfv0nRE7nM+UtQRYf+vR7EtCW2+fmlAGhtdC4+c+wLWqn3Skmb+M7S01
	 6qa3LyUdW91baafo8JAYu2iOSg2Dwsf0At3W/2Te4M3Jz+C6o7zoKelMpO3E8Hhy4O
	 vR5+74ONopnl8+XXC7oUb31d3nocIMR2Otp5hCvt3O/crKmRHOK2/WshfIcZ+gApy1
	 AkdHVnGu+8dDw==
From: Thomas Gleixner <tglx@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Tejun Heo
 <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil
 Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Waiman Long
 <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, Michal
 =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
Subject: Re: [PATCH v2 04/12] tick/nohz: Transition to dynamic full dynticks
 state management
In-Reply-To: <20260413-wujing-dhm-v2-4-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
 <20260413-wujing-dhm-v2-4-06df21caba5d@gmail.com>
Date: Tue, 14 Apr 2026 23:57:52 +0200
Message-ID: <87tstddx27.ffs@tglx>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15301-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[43];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D86553FEBA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13 2026 at 15:43, Qiliang Yuan wrote:

> Context:
> Full dynticks (NOHZ_FULL) is typically a static configuration determined
> at boot time. DHEI extends this to support runtime activation.

I have no idea what DHEI is. Provide proper information and not magic
acronyms.

> Problem:
> Switching to NOHZ_FULL at runtime requires careful synchronization
> of context tracking and housekeeping states. Re-invoking setup logic
> multiple times could lead to inconsistencies or warnings, and RCU
> dependency checks often prevented tick suppression in Zero-Conf setups.

And that careful synchronization is best achieved with an opaque
notifier callchain which relies on build time ordering. Impressive.

> Solution:
> - Replace the static tick_nohz_full_enabled() checks with a dynamic
>   tick_nohz_full_running state variable.

That variable existed before and you are telling the what and not why
this is required and how that is correct vs. the other checks in
tick_nohz_full_enabled(). Also what's static about that function aside
of being marked static inline?

> - Refactor tick_nohz_full_setup to be safe for runtime invocation,
>   adding guards against re-initialization and ensuring IRQ work
>   interrupt support.

Refactoring has to be done in a preparatory patch and not 

> - Implement boot-time pre-activation of context tracking (shadow
>   init) for all possible CPUs to avoid instruction flow issues during
>   dynamic transitions.

Again lot's of hand waving without a proper explanation.

> - Hook into housekeeping_notifier_list to update NO_HZ states dynamically.

See above.

> This provides the core state machine for reliable, on-demand tick
> suppression and high-performance isolation.

I can find a lot of hacks, but definitely not the slightest notion of a
state machine. Don't throw random buzzwords into a changelog if there is
no evidence for their existance.

> +static int tick_nohz_housekeeping_reconfigure(struct notifier_block *nb,
> +					     unsigned long action, void *data)
> +{
> +	struct housekeeping_update *upd = data;
> +	int cpu;
> +
> +	if (action == HK_UPDATE_MASK && upd->type == HK_TYPE_TICK) {
> +		cpumask_var_t non_housekeeping_mask;
> +
> +		if (!alloc_cpumask_var(&non_housekeeping_mask, GFP_KERNEL))
> +			return NOTIFY_BAD;
> +
> +		cpumask_andnot(non_housekeeping_mask, cpu_possible_mask, upd->new_mask);
> +
> +		if (!tick_nohz_full_mask) {
> +			if (!zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL)) {
> +				free_cpumask_var(non_housekeeping_mask);
> +				return NOTIFY_BAD;
> +			}
> +		}
> +
> +		/* Kick all CPUs to re-evaluate tick dependency before change */
> +		for_each_online_cpu(cpu)
> +			tick_nohz_full_kick_cpu(cpu);

That solves what?

> +		cpumask_copy(tick_nohz_full_mask, non_housekeeping_mask);

What's the exact point of this non_housekeeping_mask?

Why can't you simply do:

		cpumask_andnot(tick_nohz_full_mask, cpu_possible_mask, upd->new_mask);

That'd be too simple and comprehensible, right?

> +		tick_nohz_full_running = !cpumask_empty(tick_nohz_full_mask);
> +
> +		/*
> +		 * If nohz_full is running, the timer duty must be on a housekeeper.
> +		 * If the current timer CPU is not a housekeeper, or no duty is assigned,
> +		 * pick the first housekeeper and assign it.
> +		 */
> +		if (tick_nohz_full_running) {
> +			int timer_cpu = READ_ONCE(tick_do_timer_cpu);

New line between declaration and code.

> +			if (timer_cpu == TICK_DO_TIMER_NONE ||
> +			    !cpumask_test_cpu(timer_cpu, upd->new_mask)) {

No line break required. You have 100 characters

> +				int next_timer = cpumask_first(upd->new_mask);

next_timer? Please pick variable names which are comprehensible and self
explaining. Also why can't you re-use timer_cpu, which would be actually useful?


> +				if (next_timer < nr_cpu_ids)

How can upd->new_mask be empty? That'd be a bug, no?

> +					WRITE_ONCE(tick_do_timer_cpu, next_timer);
> +			}
> +		}
> +
> +		/* Kick all CPUs again to apply new nohz full state */
> +		for_each_online_cpu(cpu)
> +			tick_nohz_full_kick_cpu(cpu);

This whole thing lacks an explanation why it is even remotely correct.

> void __init tick_nohz_init(void)
...
> +	if (!tick_nohz_full_mask) {
> +		if (!slab_is_available())
> +			alloc_bootmem_cpumask_var(&tick_nohz_full_mask);
> +		else
> +			zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL);
>  	}

I've seen the same code sequence before. Copy & paste is simpler than
providing helper functions.....
  
> -	if (IS_ENABLED(CONFIG_PM_SLEEP_SMP) &&
> -			!IS_ENABLED(CONFIG_PM_SLEEP_SMP_NONZERO_CPU)) {
> -		cpu = smp_processor_id();
> +	housekeeping_register_notifier(&tick_nohz_housekeeping_nb);
>  
> -		if (cpumask_test_cpu(cpu, tick_nohz_full_mask)) {
> -			pr_warn("NO_HZ: Clearing %d from nohz_full range "
> -				"for timekeeping\n", cpu);
> -			cpumask_clear_cpu(cpu, tick_nohz_full_mask);
> +	if (tick_nohz_full_running) {

This indentation and the resulting goto mess can be completely avoided
if you actually refactor the code and not just claim to do so.

Again, this does too many things at once and then explains them badly,
which makes it unreviewable.

Thanks,

        tglx

