Return-Path: <cgroups+bounces-15309-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFUxDRhr32niSgAAu9opvQ
	(envelope-from <cgroups+bounces-15309-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:40:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D424B403596
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 12:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B428E302BE93
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50834750F;
	Wed, 15 Apr 2026 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGe4oo+R"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAE54774;
	Wed, 15 Apr 2026 10:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249552; cv=none; b=j5RRJztYG4oQwtMofNTxBxrK8oI5R54zFmRMBuJWo/6xTsyBRHa2kp9Maxr5QliIudqzc5bi+HUXuYH5goM4J6HETWK4cyFYh6IG5ZbOUkoLL/VAYiqCDFnIM9IjIjyCK4lelJD356V3JeT0BpoE0P3SJpCu40l4TB8Y64kuSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249552; c=relaxed/simple;
	bh=aheK/gwMEHe63duzE1RlMxnosDOaR8fFPomYOSoLjoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2Cs49xcuqwrkfq3xX8STUTq6OWFfrygLqGwoxt9D3NBQ+gdkQbR2N3TkaAXkc341O59/OHjmp9IEsHodTcsbktSTqaImzxq/xYLMIQY9YZm5YYPUbZILsoAw+INLDI4shZSeM+8UXBucdWB3X+icTFFlT5r5NPMagi2uCT4bMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGe4oo+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06538C2BCB3;
	Wed, 15 Apr 2026 10:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776249552;
	bh=aheK/gwMEHe63duzE1RlMxnosDOaR8fFPomYOSoLjoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGe4oo+Rr6efnJSmuEhBX+8+oci2s7TXrD5SAWzJAgUDrNqIZUeYYJa0E8QnfxweL
	 mJkuSi14CLX1B+D4k7vrsP/EjDztM4ALt7A8qRxFy+WRwQbnQKfKcnYNMUt9NCwuBY
	 LS4WjGrlJhJQgOYUdb5nMedpcZ20GSGY8Yjjgzt1cM4mdLcaero9rGoiwOds/QPtlV
	 mOh3tP04HhFrWRTtwssAJwOwmLoQn1F1Bs9guHDbjmRjfO3XWpgOUzeOGpbAsO4PB+
	 3duhimw3Vj44ywaZQIWg5//grARbOZy4Lt6DBUwxk/0uDBqggy2CUnKERkvyz28C50
	 b/4pQqyTYyx1Q==
Date: Wed, 15 Apr 2026 12:39:09 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 03/12] rcu: Support runtime NOCB initialization and
 dynamic offloading
Message-ID: <ad9qzVGrcgVL9SQk@localhost.localdomain>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
 <20260413-wujing-dhm-v2-3-06df21caba5d@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413-wujing-dhm-v2-3-06df21caba5d@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15309-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,gmail.com,efficios.com,linux.dev,linutronix.de,linux-foundation.org,suse.com,cmpxchg.org,huaweicloud.com,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D424B403596
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le Mon, Apr 13, 2026 at 03:43:09PM +0800, Qiliang Yuan a écrit :
> Context:
> The RCU Non-Callback (NOCB) infrastructure traditionally requires
> boot-time parameters (e.g., rcu_nocbs) to allocate masks and spawn
> management kthreads (rcuog/rcuo). This prevents systems from activating
> offloading on-demand without a reboot.
> 
> Problem:
> Dynamic Housekeeping Management requires CPUs to transition to
> NOCB mode at runtime when they are newly isolated. Without boot-time
> setup, the NOCB masks are unallocated, and critical kthreads are missing,
> preventing effective tick suppression and isolation.
> 
> Solution:
> Refactor RCU initialization to support dynamic on-demand setup.
> - Introduce rcu_init_nocb_dynamic() to allocate masks and organize
>   kthreads if the system wasn't initially configured for NOCB.
> - Introduce rcu_housekeeping_reconfigure() to iterate over CPUs and
>   perform safe offload/deoffload transitions via hotplug sequences
>   (cpu_down -> offload -> cpu_up) when a housekeeping cpuset triggers
>   a notifier event.
> - Remove __init from rcu_organize_nocb_kthreads to allow runtime
>   reconfiguration of the callback management hierarchy.
> 
> This enables a true "Zero-Conf" isolation experience where any CPU
> can be fully isolated at runtime regardless of boot parameters.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
>  kernel/rcu/rcu.h       |  4 +++
>  kernel/rcu/tree.c      | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/rcu/tree.h      |  2 +-
>  kernel/rcu/tree_nocb.h | 31 +++++++++++++--------
>  4 files changed, 100 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 9b10b57b79ada..282874443c96b 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -663,8 +663,12 @@ unsigned long srcu_batches_completed(struct srcu_struct *sp);
>  #endif // #else // #ifdef CONFIG_TINY_SRCU
>  
>  #ifdef CONFIG_RCU_NOCB_CPU
> +void rcu_init_nocb_dynamic(void);
> +void rcu_spawn_cpu_nocb_kthread(int cpu);
>  void rcu_bind_current_to_nocb(void);
>  #else
> +static inline void rcu_init_nocb_dynamic(void) { }
> +static inline void rcu_spawn_cpu_nocb_kthread(int cpu) { }
>  static inline void rcu_bind_current_to_nocb(void) { }
>  #endif
>  
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 55df6d37145e8..84c8388cf89a1 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4928,4 +4928,79 @@ void __init rcu_init(void)
>  #include "tree_stall.h"
>  #include "tree_exp.h"
>  #include "tree_nocb.h"
> +
> +#ifdef CONFIG_SMP
> +static int rcu_housekeeping_reconfigure(struct notifier_block *nb,
> +					unsigned long action, void *data)
> +{
> +	struct housekeeping_update *upd = data;
> +	struct task_struct *t;
> +	int cpu;
> +
> +	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_RCU)
> +		return NOTIFY_OK;
> +
> +	rcu_init_nocb_dynamic();
> +
> +	for_each_possible_cpu(cpu) {
> +		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +		bool isolated = !cpumask_test_cpu(cpu, upd->new_mask);
> +		bool offloaded = rcu_rdp_is_offloaded(rdp);
> +
> +		if (isolated && !offloaded) {
> +			/* Transition to NOCB */
> +			pr_info("rcu: CPU %d transitioning to NOCB mode\n", cpu);
> +			if (cpu_online(cpu)) {
> +				remove_cpu(cpu);

We plan to assume that the CPU is offline while updating HK_TYPE_KERNEL_NOISE
through cpusets. So you shouldn't need to care about offlining here.


> +				rcu_spawn_cpu_nocb_kthread(cpu);
> +				rcu_nocb_cpu_offload(cpu);
> +				add_cpu(cpu);
> +			} else {
> +				rcu_spawn_cpu_nocb_kthread(cpu);
> +				rcu_nocb_cpu_offload(cpu);
> +			}
> +		} else if (!isolated && offloaded) {
> +			/* Transition to CB */
> +			pr_info("rcu: CPU %d transitioning to CB mode\n", cpu);
> +			if (cpu_online(cpu)) {
> +				remove_cpu(cpu);
> +				rcu_nocb_cpu_deoffload(cpu);
> +				add_cpu(cpu);
> +			} else {
> +				rcu_nocb_cpu_deoffload(cpu);
> +			}
> +		}
> +	}
> +
> +	t = READ_ONCE(rcu_state.gp_kthread);
> +	if (t)
> +		housekeeping_affine(t, HK_TYPE_RCU);
> +
> +#ifdef CONFIG_TASKS_RCU
> +	t = get_rcu_tasks_gp_kthread();
> +	if (t)
> +		housekeeping_affine(t, HK_TYPE_RCU);
> +#endif
> +
> +#ifdef CONFIG_TASKS_RUDE_RCU
> +	t = get_rcu_tasks_rude_gp_kthread();
> +	if (t)
> +		housekeeping_affine(t, HK_TYPE_RCU);
> +#endif

No need to handle kthreads affinities. This is already taken care of by isolated
cpuset partitions.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

