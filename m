Return-Path: <cgroups+bounces-15429-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEoVA1M852no5QEAu9opvQ
	(envelope-from <cgroups+bounces-15429-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:58:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E604438805
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DF943051C84
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECFD3A16A2;
	Tue, 21 Apr 2026 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbpksxB6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9873A0B26;
	Tue, 21 Apr 2026 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761725; cv=none; b=Ktt6QSi8cX9iMazALWVVwxqE+fte193TaeGYWS56V6a1+khp0nkwMsqdYnIAzY73mJ6RQyIaR/ADTNxs8N9ctiaeKiu70umGDQaSudGT6qDMbqIQGghuUcdBypc6dXDBtDWfoxptn1/w6yAFE7YL0+P7Rca8YftAhVMEkp5T+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761725; c=relaxed/simple;
	bh=l8GZGmmqBDH1qGsf6cYl9us7elj7guWOOnOWIKaH7fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQXUIn2KRcNjQ/HU8n3IJnikYGldYrolaecUwIogYuR22wWG7ihZ1INIcSBQs2U/SlCzjaXOYgTH8Hf/xwavn+nypIlwEw/yppGp2/VbzGLXCxopfe3qVE/VvJM6daeruIiRQh+KBBWqPPBnvvFBlIngVOD84XTTUeIkcFueIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbpksxB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CDAC2BCB8;
	Tue, 21 Apr 2026 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776761724;
	bh=l8GZGmmqBDH1qGsf6cYl9us7elj7guWOOnOWIKaH7fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fbpksxB6uMfX5Z5L/PjhReWfZqK/gZWcUtb6VpyahD6lNkPwvC53AyuHNjTxumI8b
	 duF/nj30nw15WGdGP4wWI4cZJCvOgrppPsKLO6W+438xfzolOxyCQLWWtiYuogohr7
	 1GDeU1agc/WykWiBDwQk3/ghICVktpzs8vPBU7Tvr2uroNjLOAaVtsZ6e+UsS6+SR5
	 95XzgmP+zGCzUnqFAOB6rIyVPGOklw1+f4w+gBdEsc12hGeD/BpK2xSmQq0Zb+Rnza
	 sqCn0XnOQ9Fo3G6EZr6k66TGFrZQhFMgK4Uh4hpsPC1v1fOZ6Hq/roWwfxmW6uWky3
	 HX57nFht2oNNw==
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
Subject: Re: [PATCH 05/23] tick: Pass timer tick job to an online HK CPU in
 tick_cpu_dying()
In-Reply-To: <20260421030351.281436-6-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-6-longman@redhat.com>
Date: Tue, 21 Apr 2026 10:55:21 +0200
Message-ID: <87zf2wbsli.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15429-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 9E604438805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
> In tick_cpu_dying(), if the dying CPU is the current timekeeper,
> it has to pass the job over to another CPU. The current code passes
> it to another online CPU. However, that CPU may not be a timer tick
> housekeeping CPU.  If that happens, another CPU will have to manually
> take it over again later. Avoid this unnecessary work by directly
> assigning an online housekeeping CPU.
>
> Use READ_ONCE/WRITE_ONCE() to access tick_do_timer_cpu in case the
> non-HK CPUs may not be in stop machine in the future.

'may not be in the future' is yet more handwaving without
content. Please write your change logs in a way so that people who have
not spent months on this can follow.

> @@ -394,12 +395,19 @@ int tick_cpu_dying(unsigned int dying_cpu)
>  {
>  	/*
>  	 * If the current CPU is the timekeeper, it's the only one that can
> -	 * safely hand over its duty. Also all online CPUs are in stop
> -	 * machine, guaranteed not to be idle, therefore there is no
> +	 * safely hand over its duty. Also all online housekeeping CPUs are
> +	 * in stop machine, guaranteed not to be idle, therefore there is no
>  	 * concurrency and it's safe to pick any online successor.
>  	 */
> -	if (tick_do_timer_cpu == dying_cpu)
> -		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
> +	if (READ_ONCE(tick_do_timer_cpu) == dying_cpu) {
> +		unsigned int new_cpu;
> +
> +		guard(rcu)();

What's this guard for?

> +		new_cpu = cpumask_first_and(cpu_online_mask, housekeeping_cpumask(HK_TYPE_TICK));

Why has this to use housekeeping_cpumask() and does not use
tick_nohz_full_mask?

Thanks,

        tglx

