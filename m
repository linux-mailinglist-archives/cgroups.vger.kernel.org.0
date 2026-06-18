Return-Path: <cgroups+bounces-17078-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 86amAh8rNGrsQQYAu9opvQ
	(envelope-from <cgroups+bounces-17078-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 19:30:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 544FE6A1F21
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 19:30:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="LC50q/ot";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17078-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17078-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DA5830A6485
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1239F347521;
	Thu, 18 Jun 2026 17:27:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B82D97B8;
	Thu, 18 Jun 2026 17:27:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781803672; cv=none; b=eHC9/7hJ1d+E9dq3JzP65r6yJuMnEGh16phOpak0+yDCbTtoFkw2JiYOyYY+TvGIAx4nts4Z7ogo9z98uVY1jvoalUzKI130ckOAcGlgTmnFFl4/16ildehG1RlqqNjXQwuF5syv0X9m0asUapckWF7YPJVwXvajerxpePasB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781803672; c=relaxed/simple;
	bh=oVR93PrPVc7LUnW/vtBZyV0u97hbe+VJszCLmN/OiZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fVN+J28BgKoE4fb4TQr+v2BjhkaeM0lvrzIZYiRXu3sdIGg4z7xU9zZvegA3SmP7V7VJELuzIKwKKAGtHvAFIveYBjMKEG+n3NhKZz/mkz96bshVYJ/dWs2qGL8tXMfjUwo6SClvczhoFTP1/umzo4t/YXGsFNQDhCdghcpE7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LC50q/ot; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7631F000E9;
	Thu, 18 Jun 2026 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781803671;
	bh=bb9aacohe48OoqXNx5VI1f7nZbxT11rV0xlxmeRCcrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=LC50q/otrM1SWnf4Jd5uqmtanst0ABBqPCHvKDDevfejWyYnVvsY+DGcsxI6t2LRf
	 Y06Np4yx9t1e7KGB2zhe99PsyE1Ul1vxxfid5A/jVzTGH8IA7h2JO1se3xvPfhpffq
	 xI9kuvzhDP1MS6T1lmZ6ctmsF3mme0yy5Nya3dfeZyxgAZbsHagK2LJ+w1ZPWgFmG0
	 32pjLoT0M1flVxYzSBqULnQmxfGZebtvpnH8u1MttDa9bVYUV2Apw+XsxFuUooRhuY
	 UgSdfJGpARe66IqJTixJwXs3oA2kn6ml6z4ezQhyO2LFcact7pJHdvJ3C0AxX3RS/X
	 5daadv/yelWLg==
From: Thomas Gleixner <tglx@kernel.org>
To: Jing Wu <realwujing@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
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
 <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, Qiliang
 Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v3 06/13] tick/nohz, context_tracking: Prepare for
 runtime nohz_full updates
In-Reply-To: <20260618-wujing-dhm-v3-6-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
 <20260618-wujing-dhm-v3-6-28f1a4d83b68@gmail.com>
Date: Thu, 18 Jun 2026 19:27:48 +0200
Message-ID: <87ik7fep2j.ffs@fw13>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:realwujing@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17078-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,fw13:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 544FE6A1F21

On Thu, Jun 18 2026 at 11:11, Jing Wu wrote:
> Remove __init from ct_cpu_track_user() and __initdata from the
> initialized flag so context tracking can be activated on CPUs that
> join nohz_full at runtime.  Drop the __ro_after_init attribute from
> the context_tracking_key static key, allowing static_branch_dec()
> when a CPU leaves nohz_full.
>
> Add ct_cpu_untrack_user() to reverse ct_cpu_track_user(), decrementing
> the static key and clearing the per-CPU tracking state.

Please do not enumerate WHAT the patch is doing. Explain the context and
the WHY

  https://docs.kernel.org/process/maintainer-tip.html#changelog


>=20=20
>  #include <asm/irq_regs.h>
> @@ -653,11 +654,6 @@ void __init tick_nohz_init(void)
>  	if (!tick_nohz_full_running)
>  		return;
>=20=20
> -	/*
> -	 * Full dynticks uses IRQ work to drive the tick rescheduling on safe
> -	 * locking contexts. But then we need IRQ work to raise its own
> -	 * interrupts to avoid circular dependency on the tick.
> -	 */

This comment is removed because it's not longer correct? How is this
related to $Subject?

>  	if (!arch_irq_work_has_interrupt()) {
>  		pr_warn("NO_HZ: Can't run full dynticks because arch doesn't support I=
RQ work self-IPIs\n");
>  		cpumask_clear(tick_nohz_full_mask);
> @@ -676,6 +672,16 @@ void __init tick_nohz_init(void)
>  		}
>  	}
>=20=20
> +	/*
> +	 * Pre-initialize context tracking for all possible CPUs so
> +	 * ctx tracking is already active when a CPU is later added to
> +	 * nohz_full at runtime.  The tracking overhead is negligible
> +	 * because the static key is not incremented yet =E2=80=94 only per-CPU
> +	 * tracking state is set up.
> +	 */
> +	if (IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER_FORCE))
> +		context_tracking_init();

Seriously? Care to look where and when context_tracking_init() is invoked?

>  	for_each_cpu(cpu, tick_nohz_full_mask)
>  		ct_cpu_track_user(cpu);
>=20=20
> @@ -686,6 +692,147 @@ void __init tick_nohz_init(void)
>  	pr_info("NO_HZ: Full dynticks CPUs: %*pbl.\n",
>  		cpumask_pr_args(tick_nohz_full_mask));
>  }
> +
> +static int tick_nohz_hk_validate(enum hk_type type,
> +				 const struct cpumask *cur_mask,
> +				 const struct cpumask *new_mask)
> +{
> +	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
> +		return -EOPNOTSUPP;
> +	return 0;
> +}

Why is this code even compiled when CONFIG_NO_HZ_FULL is not enabled?

> +
> +static void tick_nohz_hk_apply(enum hk_type type)
> +{
> +	static DEFINE_SPINLOCK(tick_nohz_lock);
> +	cpumask_var_t nohz_full, added, removed;
> +	bool was_running;
> +	int cpu;
> +
> +	if (!alloc_cpumask_var(&nohz_full, GFP_KERNEL))
> +		return;

This looks more than wrong. If this fails then the core code will
happily proceed with the completely wrong state.

> +	if (!alloc_cpumask_var(&added, GFP_KERNEL)) {
> +		free_cpumask_var(nohz_full);
> +		return;
> +	}
> +	if (!alloc_cpumask_var(&removed, GFP_KERNEL)) {
> +		free_cpumask_var(added);
> +		free_cpumask_var(nohz_full);
> +		return;
> +	}

        cpumask_var_t __free(free_cpumask_var) a =3D CPUMASK_VAR_NULL;
        cpumask_var_t __free(free_cpumask_var) b =3D CPUMASK_VAR_NULL;
        cpumask_var_t __free(free_cpumask_var) c =3D CPUMASK_VAR_NULL;

        if (!alloc_cpumask_var(&a, GFP_KERNEL))
        	return -ENOMEM;
        ....

> +
> +	/*
> +	 * Snapshot the new HK_TYPE_KERNEL_NOISE mask under an RCU read lock.
> +	 * housekeeping_update_types() completes synchronize_rcu() before
> +	 * invoking apply(), so the new pointer is stable; however the lockdep
> +	 * annotation in housekeeping_cpumask() still requires an RCU read-side
> +	 * critical section for runtime-mutable types.

This comment is explaining the obvious: housekeeping_cpumask_rcu()

> +	 */
> +	rcu_read_lock();

        scoped_guard(rcu)


> +	cpumask_andnot(nohz_full, cpu_possible_mask,
> +		       housekeeping_cpumask_rcu(HK_TYPE_KERNEL_NOISE));
> +	rcu_read_unlock();
> +
> +	/*
> +	 * When "nohz_full=3D" was not passed at boot, tick_nohz_full_running is
> +	 * false and the full dynticks infrastructure (sched_tick_offload_init,
> +	 * RCU nohz quiescent-state reporting, context-tracking bootstrap) was
> +	 * never initialised.  In that case restrict the update to
> +	 * tick_nohz_full_mask so the /sys/devices/system/cpu/nohz_full sysfs
> +	 * attribute reflects DHM-isolated CPUs without enabling tick
> +	 * suppression, context tracking, or timer migration =E2=80=93 all of w=
hich
> +	 * require boot-time setup and would deadlock on the first
> +	 * synchronize_rcu() call after CPUs are offlined.

What? You tell user space that the CPUs are nohz_full by updating the
mask, which is exposed in sysfs, which is blatantly wrong.

> +	 */
> +	was_running =3D READ_ONCE(tick_nohz_full_running);

Q: This READ_ONCE() pairs with which WRITE_ONCE()?=20
A: With none, so it's just voodoo programming.

> +	spin_lock(&tick_nohz_lock);

This lock protects against the housekeeping core code invoking the apply
callback multiple times in parallel, right?

If that happens then there are bigger problems than corrupted masks.

> +	/*
> +	 * When nohz_full=3D was active at boot, compute the delta and update
> +	 * context tracking for CPUs joining or leaving the nohz_full set.
> +	 * Skip when !was_running: ct_cpu_track_user() calls
> +	 * static_branch_inc() which may sleep (jump_label_update on the
> +	 * 0=E2=86=921 transition) =E2=80=93 illegal inside a spinlock.

If you remove the pointless voodoo lock then this nonsense goes away too.

> +	 */
> +	if (IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER) &&
> +	    was_running &&
> +	    cpumask_available(tick_nohz_full_mask)) {

Why is this stuff even invoked when the mask is not available? If it's
not there then NOHZ full is not functional, period.

> +		cpumask_andnot(added, nohz_full, tick_nohz_full_mask);
> +		cpumask_andnot(removed, tick_nohz_full_mask, nohz_full);
> +		for_each_cpu(cpu, added)
> +			ct_cpu_track_user(cpu);
> +		for_each_cpu(cpu, removed)
> +			ct_cpu_untrack_user(cpu);
> +	}
> +
> +	/*
> +	 * Update tick_nohz_full_mask unconditionally: this is the snapshot
> +	 * read by the /sys/devices/system/cpu/nohz_full sysfs attribute and
> +	 * must reflect the current isolation set even in the DHM runtime case.
> +	 */
> +	if (cpumask_available(tick_nohz_full_mask))
> +		cpumask_copy(tick_nohz_full_mask, nohz_full);

Seriously?

> +	/*
> +	 * Only modify tick_nohz_full_running and migrate the global tick when
> +	 * nohz_full=3D was set at boot; without boot-time setup, setting
> +	 * tick_nohz_full_running would suppress ticks on isolated CPUs and
> +	 * prevent RCU quiescent-state reporting, causing synchronize_rcu()
> +	 * to stall permanently when a CPU is subsequently offlined.
> +	 */
> +	if (was_running) {

Again, why is any of this invoked when NOHZ full was never enabled and
initialized?

> +		tick_nohz_full_running =3D !cpumask_empty(nohz_full);

Brilliant. When NOHZ full was enabled on the command line, then changing
the mask can disable "running" and that makes it disabled forever. There
is no way to reenable it.

This 'was_running' check is just wrong. What you need is a
'tick_nohz_full_initialized' boolean, which is only true when nohz_full
was setup early on including the mask.

If that's not the case, then none of this code is supposed to run
ever. I.e. the callback is not installed in the first place.

> +	/*
> +	 * Ensure tick_nohz_full_mask is allocated so that tick_nohz_hk_apply()
> +	 * can update it (and the /sys/devices/system/cpu/nohz_full sysfs
> +	 * attribute) when CPUs are isolated at runtime via DHM.  If "nohz_full=
=3D"
> +	 * was passed at boot the mask is already allocated; allocate an empty
> +	 * one here for the runtime-only case.

What's the runtime only case? The fake exposure in sysfs which is just
misleading the user? Not going to happen. If it's not enabled on the
command line then it's disabled, end of story.

> +	 */
> +	if (!cpumask_available(tick_nohz_full_mask) &&
> +	    !zalloc_cpumask_var(&tick_nohz_full_mask, GFP_KERNEL))
> +		pr_warn("tick/nohz: failed to allocate nohz_full_mask for DHM\n");

ROTFL. If the allocation fails, then the apply callback becomes a
complete noop doing magic cpumask operations for nothing and pretending
to be successful.

Thanks,

        tglx

