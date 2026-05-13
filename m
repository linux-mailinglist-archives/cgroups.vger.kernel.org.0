Return-Path: <cgroups+bounces-15894-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Kg4CPB2BGqpKAIAu9opvQ
	(envelope-from <cgroups+bounces-15894-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 15:04:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1622533914
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 15:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDB5B3016788
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A1A2798EA;
	Wed, 13 May 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGsDWVW2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669925B094;
	Wed, 13 May 2026 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677478; cv=none; b=ZnXhbKtPenqi8aJSpt0GetKmMoN+Jqu0CWMvOqEMj9CLei5MavoceTI/2WRizZWt7O48gUQ4UTDqP8+FUv0t6WjcxdNJr4StTxnGSC/ltgUJ+WgqBBulbRxoFEpxM35AlwfmNq5ZpJMBIRgCpx/rBMyiZAoe3BzjFTDI3euisjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677478; c=relaxed/simple;
	bh=6LEu9DtzugsPgS9zY7ikDk3PNAySaXFJrErwGthAkfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDgAuUuuooH4DASttJopd8bADXLyLqxvHBVPZyLYTq2nrja9qkfhzuwy6fXnN6ps821Z+IAaER5vOCYTGmRy7SkIEdT1DlD/Qs5Fe7oetWSG9oD39/CE1OBDK3eTCKMmIigojT7zwfKeX0nb9oFBIGpgkiib9AfabTHsMdix9OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGsDWVW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9F9C2BCC7;
	Wed, 13 May 2026 13:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778677478;
	bh=6LEu9DtzugsPgS9zY7ikDk3PNAySaXFJrErwGthAkfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lGsDWVW2oR08PACx9KcRC8YMpUuN6oYYOvoOWllZtScTRbHp7+islHrOswbDz0e1U
	 Rd/2lD7xK6tofxdt3rjsHrXixgEE2cEIam/CmgAPO+rVJ0EqqFFymekAQgAVcROykG
	 /N7UobOXD+QLpx6gmP6NTOmHQYOBi0pny/Bp5nb7yAfX2fzkn+nP5WBB8+35vCpLep
	 jh4Y8TgC1kC/ozfdDPxCBHLqgSPMWYg5w/mYxRbWDqfzsPeOwoBvd1TnZH2MG/F2uI
	 pbR8JRRzktjhwXI6yger0M0d/hUI8h3I7h6ajlUBWmNi8Qu54RVQUXSLuoGBn6Z7hf
	 kXJB84AOZ4pfg==
Date: Wed, 13 May 2026 15:04:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Guenter Roeck <linux@roeck-us.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org, rcu@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Qiliang Yuan <realwujing@gmail.com>
Subject: Re: [PATCH 04/23] tick/nohz: Allow runtime changes in full dynticks
 CPUs
Message-ID: <agR241twxk9UdRrg@localhost.localdomain>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-5-longman@redhat.com>
 <87340od7ev.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87340od7ev.ffs@tglx>
X-Rspamd-Queue-Id: F1622533914
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-15894-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Action: no action

Le Tue, Apr 21, 2026 at 10:50:00AM +0200, Thomas Gleixner a écrit :
> On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
> > +	/*
> > +	 * To properly enable/disable nohz_full dynticks for the affected CPUs,
> > +	 * the new nohz_full CPUs have to be copied to tick_nohz_full_mask and
> > +	 * ct_cpu_track_user/ct_cpu_untrack_user() will have to be called
> > +	 * for those CPUs that have their states changed. Those CPUs should be
> > +	 * in an offline state.
> > +	 */
> > +	for_each_cpu_andnot(cpu, cpumask, tick_nohz_full_mask) {
> > +		WARN_ON_ONCE(cpu_online(cpu));
> > +		ct_cpu_track_user(cpu);
> > +		cpumask_set_cpu(cpu, tick_nohz_full_mask);
> > +	}
> > +
> > +	for_each_cpu_andnot(cpu, tick_nohz_full_mask, cpumask) {
> > +		WARN_ON_ONCE(cpu_online(cpu));
> > +		ct_cpu_untrack_user(cpu);
> > +		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
> > +	}
> > +}
> 
> So this writes to tick_nohz_full_mask while other CPUs can access
> it. That's just wrong and I'm not at all interested in the resulting
> KCSAN warnings.
> 
> tick_nohz_full_mask needs to become a RCU protected pointer, which is
> updated once the new mask is established in a separately allocated one.

How about just dropping tick_nohz_full_mask that is just
 ~housekeeping_cpumask(HK_TYPE_KERNEL_NOISE) which itself is becoming RCU
protected in this patchset?

Thanks.

> 
> Thanks,
> 
>         tglx
> 
> 

-- 
Frederic Weisbecker
SUSE Labs

