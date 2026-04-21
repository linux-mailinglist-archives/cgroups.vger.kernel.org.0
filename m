Return-Path: <cgroups+bounces-15430-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oO3UFfE852no5QEAu9opvQ
	(envelope-from <cgroups+bounces-15430-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 11:01:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B06438894
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 11:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03711303CC31
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DED93A1D1C;
	Tue, 21 Apr 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9hJqfZt"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B43A16AD;
	Tue, 21 Apr 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761882; cv=none; b=VWXljeBEGgZtuPHXcVAuGFtJh2rMhBrCx9iaWUfF4T6XT4Z9tCohKojR8R8eDLGPiGPyrOZCkNmKbjQ9MAw8Z4n/Tb58KdSPlISvHNrcAty77C1BgWNmIt67MvTMz5wC3GjBIe7E38RvUDTYL0Lc1DpTvDXk/25/YhGoo3uRIi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761882; c=relaxed/simple;
	bh=TSkeoI3qklBTxZZWfX6zfoMJBxsxuw9f5WEwy+MHN2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QLJiBEQfu3u6g2Mkr5kpAa/MC//5xcQZk1EhAtTR2dEd/RJYFqLZo9T1MMWeKqgufBKVobZ0Ni/LVppx/XH7bSOukvOWP9iBEznjtHtyZFMOzeF6dFfk/z5UVB/36XKJhADNgTO96HddnUCKjtbX1CtGmExzPClAPgYn/mggt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9hJqfZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD158C2BCB0;
	Tue, 21 Apr 2026 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776761882;
	bh=TSkeoI3qklBTxZZWfX6zfoMJBxsxuw9f5WEwy+MHN2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f9hJqfZtxqy+vfMR3SD/zKLLoRfKY31sxwzAWNoQCH8sASJYhwjQoMwgdzGIr94Qd
	 Wy4elrFQyiZCGHho9MBe3u4+FnRXkIRG1gv9onz7iAqIfnNXHg2Dff+MNNyPkbrNhU
	 Hq7dIGoO8SjRj3gRSDRubChcSKr0vrGcemrS2mPDsbPeEVKuTcfWd5/CP2BTceiTVM
	 AMTJmh2r41UFTroXrEHTgRD8YvfXZmSqbBVAC37B3fpALoD6IITBktEJHRCx6m1e78
	 cwAqLfnszyYWmz7YtpMi4LEwPZAd4ncDPTGUZJy8OY/pNA7ZJR8UF0Qce/M61d2YDT
	 FiSeT374NN5Pw==
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
Subject: Re: [PATCH 10/23] cpu: Use RCU to protect access of HK_TYPE_TIMER
 cpumask
In-Reply-To: <20260421030351.281436-11-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-11-longman@redhat.com>
Date: Tue, 21 Apr 2026 10:57:58 +0200
Message-ID: <87wly0bsh5.ffs@tglx>
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
	TAGGED_FROM(0.00)[bounces-15430-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0B06438894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
> As HK_TYPE_TIMER cpumask is going to be changeable at run time, use
> RCU to protect access to the cpumask.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index bc4f7a9ba64e..0d02b5d7a7ba 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1890,6 +1890,8 @@ int freeze_secondary_cpus(int primary)
>  	cpu_maps_update_begin();
>  	if (primary == -1) {
>  		primary = cpumask_first(cpu_online_mask);
> +
> +		guard(rcu)();
>  		if (!housekeeping_cpu(primary, HK_TYPE_TIMER))
>  			primary = housekeeping_any_cpu(HK_TYPE_TIMER);

housekeeping_cpu() and housekeeping_any_cpu() can operate on two
different CPU masks once the runtime update is enabled.

Seriously?

