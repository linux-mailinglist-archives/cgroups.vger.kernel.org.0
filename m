Return-Path: <cgroups+bounces-17081-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YA3LBihaNGrCVgYAu9opvQ
	(envelope-from <cgroups+bounces-17081-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 22:50:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9082F6A2AC2
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 22:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QtuFBKzM;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17081-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17081-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C0B230234EB
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403F332BF5D;
	Thu, 18 Jun 2026 20:50:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E602E737B;
	Thu, 18 Jun 2026 20:50:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815840; cv=none; b=h4kEk4NCupS/70zuFTokjsEbQW8YW4QxrspzjiHdPThhzoe2HnIjadBUfw3vmTUE0dSJTOcuEkJSZuK4ZKnp9gJYwd/7qW/nZaVK8p46N4JXgZbDpObJcaIugymfk/sTSrlNZgzglKxqrOCalN1Qznu6hnjnuQ+ckYLZ2Jd2FQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815840; c=relaxed/simple;
	bh=bE4mxSV42B/qGzQEP+mK50Iv1fi3dCKSirbPlybje2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F71EzKmKi1ABI//wraOBSwWshS0KS/uJ8BAdr+MLHnNTcx82bBb7hqgpy+rzZLkmnCZIpB9tQS8EoSo0013FxXd97dvPXjtBnG775cfH6jf/KRqxtwD9wuhvvnQkGXTPRuma+yz9ckaphppzVTKGVa1necvQ951aDMEgTqvDUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtuFBKzM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7551F000E9;
	Thu, 18 Jun 2026 20:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781815838;
	bh=NjQaXqvd1MgaodW0+ZFLqVF9VrwJ8j/HY7edbbcJLaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QtuFBKzMTQLJ1nETSLiku2/CNkkt28qCy2g9RnRSTE/3LtcF7dVD0IN+sh3QThuCQ
	 YdOdeDqayKgOw7Jv1UHeEV6kG0eZqOHmhxDdDNhAEwh992DeDAK1SD2d7JDe8vcUw5
	 PFWRIHC7UtxICjdTqaMaC0W92ETR5TCucCP0YQ0JuRxEFEeb3m79cXWsPzudCCoSx/
	 AeAOxbEOmAIG6zpasuvKTIO8ms7Fz6jXA9Ln0IdASp/1IDHQFS4l9U4uOQZx6KT6uo
	 PKSCh5iTafCgk5i7TGC5F9oJ2LvBwFO15QGWLvErQJZ7nwPAmVQdaDhI2WPLBZBRLv
	 KDzrBgj8CjNYQ==
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
Subject: Re: [PATCH v3 10/13] sched: Guard sched_tick_start/stop against
 uninitialized tick_work_cpu
In-Reply-To: <20260618-wujing-dhm-v3-10-28f1a4d83b68@gmail.com>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
 <20260618-wujing-dhm-v3-10-28f1a4d83b68@gmail.com>
Date: Thu, 18 Jun 2026 22:50:35 +0200
Message-ID: <87a4srefok.ffs@fw13>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:realwujing@gmail.com,m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:paulmck@kernel.org,m:frederic@kernel.org,m:neeraj.upadhyay@kernel.org,m:joelagnelf@nvidia.com,m:josh@joshtriplett.org,m:boqun@kernel.org,m:urezki@gmail.com,m:mathieu.desnoyers@efficios.com,m:jiangshanlai@gmail.com,m:qiang.zhang@linux.dev,m:anna-maria@linutronix.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,kernel.org,nvidia.com,joshtriplett.org,efficios.com,linux.dev,linutronix.de,lwn.net,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-17081-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,chinatelecom.cn];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fw13:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9082F6A2AC2

On Thu, Jun 18 2026 at 11:11, Jing Wu wrote:
> sched_tick_start() and sched_tick_stop() are called during CPU hotplug
> for CPUs not in the HK_TYPE_KERNEL_NOISE set.  They dereference
> tick_work_cpu, which is allocated by sched_tick_offload_init() and only
> called from housekeeping_init() when nohz_full= is present at boot.
>
> When the DHM subsystem first-enables HK_TYPE_KERNEL_NOISE at runtime via
> housekeeping_update_types(), tick_work_cpu remains NULL because
> sched_tick_offload_init() is __init-only and cannot be re-invoked.  A
> subsequent CPU offline/online cycle for an isolated CPU triggers
> WARN_ON_ONCE(!tick_work_cpu) followed by a NULL-pointer dereference in
> per_cpu_ptr(tick_work_cpu, cpu), crashing the kernel.
>
> Since nohz_full= was not active at boot, tick_nohz_full_running remains
> false and the tick-offload infrastructure is never activated; isolated
> CPUs continue to receive their own ticks.  Guard both helpers with an
> additional !tick_work_cpu check so they become no-ops in this case.

This is the same fake functionality as with the tick itself. Seriously?

> -	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
> +	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) || !tick_work_cpu)
>  		return;
>  
>  	WARN_ON_ONCE(!tick_work_cpu);
> @@ -5799,7 +5799,7 @@ static void sched_tick_stop(int cpu)
>  	struct tick_work *twork;
>  	int os;
>  
> -	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
> +	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE) || !tick_work_cpu)
>  		return;
>  
>  	WARN_ON_ONCE(!tick_work_cpu);

Brilliant stuff that. Guard against tick_work_cpu == NULL and then keep
the WARN_ON() there, which became completely pointless.

But that's all just mindless tinkering and fixing the symptoms.

If all of this is runtime managed, then all the initialization needs to
be made unconditional. Yes, that wastes a few bytes of memory per CPU if
it's not used, but avoids these completely inconsistent hacks all over
the place and provides a coherent user interface.

Stop trying to duct tape this in. This needs more thoughts than just
sprinkling works a few works for me hacks all over the place.

Thanks,

        tglx

