Return-Path: <cgroups+bounces-15441-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJkFF32k52nX+gEAu9opvQ
	(envelope-from <cgroups+bounces-15441-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 18:23:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DB043D4C7
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C79330469AC
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24CA373BFE;
	Tue, 21 Apr 2026 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahhch9gB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E73B17A305;
	Tue, 21 Apr 2026 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788243; cv=none; b=be9+ceFdtGwKv4iVVAsu9/iJPsdsk0xvtRZoPkKfbWkLGXrhVFAcLePXoJA1Nop6DEO94R7HdnIgmK/G4gAHnqkSGtVXF9zj+gRCpdUZmWNlTZigNNuzrL7m1YadXmBBxGDtHGk0TN0j3t0UU5EEeJ6BJlm7lZfaAISF62oVCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788243; c=relaxed/simple;
	bh=Rx0BZ0cGJyVS+dN5uBo9yCytt0x7FN65QdU72qTNcHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=orZCmGlour1mf+Obfzyv0aILUvxr2SNusKRiiS2vhJ/o2GhmXB37KUjhKNCza0roS6J+oPTCyDG/3YFZ+s+W6sQclNxuYRbVOcfSo97MzvbhONoRpN0sWuYgQXi7a00S8jvccJTiQGgbWGgRWdfyobiK+NaacKRawa4xtCHDk+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahhch9gB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A94C2BCB0;
	Tue, 21 Apr 2026 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776788243;
	bh=Rx0BZ0cGJyVS+dN5uBo9yCytt0x7FN65QdU72qTNcHk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ahhch9gBqz/Ve5ejormjhbp/fGLuEMSKMeJvSPfKLgXSEsKtz89Vwup2jgYC8nLDe
	 Zp+lH2/C0AVFS1vzhG8gZzNZFgd3VusAuaIBSQKDxJw188DJJeMBdYDeakSvd7+oYe
	 6nKGi2J1lzsu/nfStubv7mMmHLU1WhEkLhAvS1rlYdogvbuTNbrXWXGhQqjGe4KgKY
	 zuufkAkWuhRPr1z7ETBcFDbYdhLraiWBpGNQsfFUzJHoXACSQ8T3aL5mVqRW8Fsc0J
	 ys6TVdVbj2sqmRLJZr+9J8jjmIn+pNevv3LUfTeNcnB9jfCtChovAUy01SomG7pYNJ
	 kqjI3wV4527+A==
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
Subject: Re: [PATCH 18/23] cpu/hotplug: Add a new cpuhp_offline_cb() API
In-Reply-To: <20260421030351.281436-19-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-19-longman@redhat.com>
Date: Tue, 21 Apr 2026 18:17:19 +0200
Message-ID: <87o6jcb84w.ffs@tglx>
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
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15441-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8DB043D4C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
> Add a new cpuhp_offline_cb() API that allows us to offline a set of
> CPUs one-by-one, run the given callback function and then bring those
> CPUs back online again while inhibiting any concurrent CPU hotplug
> operations from happening.

Please provide a properly structured change log which explains the
context, the problem and the solution in separate paragraphs and this
order. This is not new. It's documented...

> This new API can be used to enable runtime adjustment of nohz_full and
> isolcpus boot command line options. A new cpuhp_offline_cb_mode flag
> is also added to signal that the system is in this offline callback
> transient state so that some hotplug operations can be optimized out
> if we choose to.

We chose nothing.

> +#include <linux/cpumask_types.h>

What for? This header only needs a 'struct cpumask' forward declaration
so that the compiler can handle the pointer argument, no?

> +typedef int (*cpuhp_cb_t)(void *arg);

You couldn't come up with a more generic name for this, right?

>  struct device;
>  
>  extern int lockdep_is_cpus_held(void);
> @@ -29,6 +31,8 @@ void clear_tasks_mm_cpumask(int cpu);
>  int remove_cpu(unsigned int cpu);
>  int cpu_device_down(struct device *dev);
>  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu);
> +int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg);

Ditto.

> +extern bool cpuhp_offline_cb_mode;

Groan. The only users are in the cpusets code which invokes this muck
and should therefore know what's going on, no?

>  #else /* CONFIG_HOTPLUG_CPU */
>  
> @@ -43,6 +47,11 @@ static inline void cpu_hotplug_disable(void) { }
>  static inline void cpu_hotplug_enable(void) { }
>  static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
>  static inline void smp_shutdown_nonboot_cpus(unsigned int primary_cpu) { }
> +static inline int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg)
> +{
> +	return -EPERM;

-EPERM?

> +/**
> + * cpuhp_offline_cb - offline CPUs, invoke callback function & online CPUs afterward
> + * @mask: A mask of CPUs to be taken offline and then online
> + * @func: A callback function to be invoked while the given CPUs are offline
> + * @arg:  Argument to be passed back to the callback function
> + *
> + * Return: 0 if successful, an error code otherwise
> + */
> +int cpuhp_offline_cb(struct cpumask *mask, cpuhp_cb_t func, void *arg)
> +{
> +	int off_cpu, on_cpu, ret, ret2 = 0;
> +
> +	if (WARN_ON_ONCE(cpumask_empty(mask) ||
> +	   !cpumask_subset(mask, cpu_online_mask)))
> +		return -EINVAL;

No line break required. You have 100 characters.

But what's worse is that the access to cpu_online_mask is not protected
against a concurrent CPU hotplug operation.

> +
> +	pr_debug("%s: begin (CPU list = %*pbl)\n", __func__, cpumask_pr_args(mask));

Tracing?

> +	lock_device_hotplug();
> +	cpuhp_offline_cb_mode = true;
> +	/*
> +	 * If all offline operations succeed, off_cpu should become nr_cpu_ids.
> +	 */
> +	for_each_cpu(off_cpu, mask) {
> +		ret = device_offline(get_cpu_device(off_cpu));
> +		if (unlikely(ret))
> +			break;
> +	}
> +	if (!ret)
> +		ret = func(arg);
> +
> +	/* Bring previously offline CPUs back online */
> +	for_each_cpu(on_cpu, mask) {
> +		int retries = 0;
> +
> +		if (on_cpu == off_cpu)
> +			break;
> +
> +retry:
> +		ret2 = device_online(get_cpu_device(on_cpu));
> +
> +		/*
> +		 * With the unlikely event that CPU hotplug is disabled while
> +		 * this operation is in progress, we will need to wait a bit
> +		 * for hotplug to hopefully be re-enabled again. If not, print
> +		 * a warning and return the error.
> +		 *
> +		 * cpu_hotplug_disabled is supposed to be accessed while
> +		 * holding the cpu_add_remove_lock mutex. So we need to
> +		 * use the data_race() macro to access it here.
> +		 */
> +		while ((ret2 == -EBUSY) && data_race(cpu_hotplug_disabled) &&
> +		       (++retries <= 5)) {
> +			msleep(20);
> +			if (!data_race(cpu_hotplug_disabled))
> +				goto retry;
> +		}
> +		if (ret2) {
> +			pr_warn("%s: Failed to bring CPU %d back online!\n",
> +				__func__, on_cpu);

Provide a proper text and not this silly __func__ thing.

> +			break;
> +		}
> +	}

TBH. This is unreviewable gunk and the whole 'unlikely event that CPU
hotplug is disabled' is just a lazy hack.

All of this can be avoided including this made up callback function.

It's not rocket science to provide:

     1) A function which serializes against any other CPU hotplug
        related action.

     2) A function which brings the CPUs in a given CPU mask down

     3) A function which brings the CPUs in a given CPU mask up

     4) A function which undoes #1

Yeah I know, it's more work and not convoluted enough. But see below.

That brings me to that other hack namely cpuhp_offline_cb_mode, which
you self described as such in patch 21/23:

> +	/*
> +	 * Hack: In cpuhp_offline_cb_mode, pretend all partitions are empty
> +	 * to prevent unnecessary partition invalidation.
> +	 */
> +	if (cpuhp_offline_cb_mode)
> +		return false;
> +

We are not merging hacks. End of story. But you knew that already, no?

Let's take a step back and see what you really need to achieve:

  1) Update tick_nohz_full_mask
  2) Update the managed interrupt mask
  3) Update CPU sets

Independent of the direction of this update you need to ensure that the
affected functionality keeps working correctly.

You achieve that by bulk offlining the affected CPUs, invoking a magic
callback and then bulk onlining the affected CPUs again, which requires
that ill defined cpuhp_offline_cb_mode hackery and probably some more
hacks all over the place.

You can achieve the same by doing CPU by CPU operations in the right
order without this mode hack, when you establish proper limitations for
this:

  At no point in time it's allowed to empty a CPU set or a affected CPU
  mask, except when you completely undo the isolation of CPUs.

  That can be computed upfront w/o changing anything at all. Once the
  validity is established, the update can proceed. Or you can leave it
  to user space which can keep the pieces if it gets it wrong.

That's a reasonable limitation as there is absolutely zero justification
to support something like:

       housekeeping_cpus = [CPU 0], isolated_cpus = [CPU 1]
  ---> housekeeping_cpus = [CPU 1], isolated_cpus = [CPU 0]

just because we can with enough horrible hacks.

If you get that out of the way, then a CPU by CPU update becomes the
obvious and simplest solution. The ordering constraints can be computed
in user space upfront and there is no reason to do any of this in the
kernel itself except for an eventual validation step. It might be a tad
slower, but this is all but a hotpath operation.

Just for the record. I suggested exactly this more than a year ago and
it's still the right thing to do.

And of course neither your cover letter nor any of the patches give a
proper rationale why you think that your bulk hackery is better. For the
very simple reason that there is no rationale at all.

This bulk muck is doomed when your ultimate goal is to avoid the stop
machine dance. With a per CPU update it is actually doable without more
ill defined hacks all over the place.

   1) Bring down the CPU to CPUHP_AP_SCHED_WAIT_EMPTY, which is the last
      state before stop machine is invoked.

      At that point:

         - no user space thread is running on the CPU anymore

         - everything related to this CPU has been shut down or moved
           elsewhere

         - interrupt managed device queues are quiesced if the CPU was
           the last online one in the queue affinity mask. If not the
           interrupt might still be affine to the CPU, but there is at
           least one other CPU available in the mask.

   2) Update the tick NOHZ handover

      This can be done without going into stop machine by providing a
      hotplug callback right between CPUHP_AP_SMPBOOT_THREADS and
      CPUHP_AP_IRQ_AFFINITY_ONLINE.

      That's trivial enough to achieve and can work independently of
      NOHZ full.

   3) Rework the affinity management, so that interrupt affinities can
      be reassigned in the CPUHP_AP_IRQ_AFFINITY_ONLINE state.

      That needs a lot of thoughts, but there is no real reason why it
      can't work.

   4) Flip the housekeeping CPU masks in sched_cpu_wait_empty() after
      balance_hotplug_wait().

   5) Bring the CPU online again.

For #2 and #3 to work you need a separate CPU mask which avoids touching
CPU online mask. For #3 this needs some more work to avoid reassigning the
interrupts once sparse_irq_lock is dropped, but the bulk is achieved
with the separate CPU mask.

No?

Thanks,

        tglx


