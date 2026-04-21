Return-Path: <cgroups+bounces-15446-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OpzJm/F52lCAgIAu9opvQ
	(envelope-from <cgroups+bounces-15446-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 20:43:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93643EC62
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 20:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A469230091F5
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CEF30E84B;
	Tue, 21 Apr 2026 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpF/xhOX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309C35DA5B;
	Tue, 21 Apr 2026 18:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797031; cv=none; b=RmlUIEqpTy3KlzM6lnsQnH1ELZvyXzKSH3VdOAFLenWugglmrrKitEmYgr7z40wSesXX8pFzsEMd6JLJHSQFgH/LAV6/tWFk1gOe1Gy3GZEZP3lfpotxDVzLNN8wVBoD3wImYYswiHszVZE2ghbMNxr0AToeljJ/o3KSc2Kkm2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797031; c=relaxed/simple;
	bh=D9bO5NnHt3R2eni60hYUUr/AeT3qN1GRnjRSK4y+ECo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NlEHqPaeA0yfzoWEwTYovb++l4+f2bHaqGK3A3fuCJkHn2KorX0GntUdD0gZ7OQB+BG87rM5otYU248RyHL8LY8Lq/KVyftpLzUT7NALAClSYU1VxJkBu/7TQQmmr0IjkyxiO6XFfrnygtopJp//NVfwjW7Ksq6xwI923I4OCn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpF/xhOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9561AC2BCB0;
	Tue, 21 Apr 2026 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776797030;
	bh=D9bO5NnHt3R2eni60hYUUr/AeT3qN1GRnjRSK4y+ECo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RpF/xhOXQwrMYmPF95ZzDOkYwTBWNJp3iUkcjfRBYB0LpyWrCCiuRDfKlFhymW1UQ
	 6TOuSdalH39Zxv7ZQj0G0IyHHEgaA/YF+XUbmu7gfNazbz8YnPHY3GE4rs8+AUGipz
	 aZirw4DaFoD6FMOWa06+XaDAkxRD9fx2FVaQ6XHO9mmSsiBXmsXBk9QH8hJPm+qaiP
	 rcq+F6yumdX2DEEQaNL6n35fcf+nS7eRqb69WDhQlRGqa/I7egYe3Ll2In972DbiZJ
	 eK2SF/BUcL85XKXUV9XBduFzTZV0k2a6OoYEIAJtmijoekrx9p1hnQP9Pxv9D1wIeb
	 yIxK0DMJuV7aA==
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
 Qiliang Yuan <realwujing@gmail.com>
Subject: Re: [PATCH 18/23] cpu/hotplug: Add a new cpuhp_offline_cb() API
In-Reply-To: <4a0ede3e-6e87-414f-a3a3-dd15c32f25ef@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-19-longman@redhat.com> <87o6jcb84w.ffs@tglx>
 <4a0ede3e-6e87-414f-a3a3-dd15c32f25ef@redhat.com>
Date: Tue, 21 Apr 2026 20:43:46 +0200
Message-ID: <87340ob1ct.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15446-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CA93643EC62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21 2026 at 13:29, Waiman Long wrote:
> On 4/21/26 12:17 PM, Thomas Gleixner wrote:
> Thanks for the great suggestions. I will certainly look into that.
>
> We actually have a cpu_active_mask that will be cleared early in 
> sched_cpu_deactivate(). In the CPUHP_AP_SCHED_WAIT_EMPTY state, the CPU 
> will still have online bit set but the active bit will be cleared. Or we 
> could add another cpumask that can be used to indicate CPUs that have 
> reached CPUHP_AP_SCHED_WAIT_EMPTY or below if necessary.

Right. Active mask is immediately cleared when a CPU goes down so that
the scheduler does not enqueue new tasks on it. But you can't use it for
interrupts because on CPU up the mask must be up to date when
irq_affinity_online_cpu() is invoked. The tick has the same constraints.

So for interrupts this should be handled in CPUHP_AP_IRQ_AFFINITY_ONLINE
both in the existing up and the new down callback. That can be a
interrupt core local CPU mask which is updated on the callbacks with the
sparse_irq_lock held.

Same for the tick handover magic.

Thanks,

        tglx

