Return-Path: <cgroups+bounces-17083-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pX91I7RcNGr0VwYAu9opvQ
	(envelope-from <cgroups+bounces-17083-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 23:01:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FA6A2B47
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 23:01:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O3QhKDvT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17083-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17083-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC06F301AF2D
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 21:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D2341AD6;
	Thu, 18 Jun 2026 21:01:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B42E06ED;
	Thu, 18 Jun 2026 21:01:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781816491; cv=none; b=pCasvH7SHLApoU0/PvO1tQASmm8CqVKrguTCKDdTrB613/0u0bys4C2aeyf5jkzwTtEo6rVJgAIXKPxQ+3dtFjdr1YAKRv0FfdCqwgrhjc+PGBpyRgPVXn5t3R2dyEr4JbYHSToc3NfO7YQdgfs0FlaFpVjHWUwRsz2MXhyECMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781816491; c=relaxed/simple;
	bh=sZ0YsnmAii4GUE3rEvNb3q8s9zGP0Km82q3SrqPALKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IPfxQJbngWgw+dAmkjmNmJr5eQdBeOA5jGLVvCzCIFgh0CHe+lLJ3j4aesiGpVnyzNL/6a/nYWS+pX3cxzwZEXiqxgP47EDInuGpDmiygc8Zag9ZqiCP5IHo7htFpNlMTnunc6eBzwcDApH4/3gWgu5egEQnBZ6kNnzlbF+Z7/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3QhKDvT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BD41F000E9;
	Thu, 18 Jun 2026 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781816490;
	bh=OcqBE6HGNxLABUAPdiGERKF3VjVKs+X2JL5EI1LlHO0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=O3QhKDvTbMFyRLz7vMEYvPy9x/fgkp+4gS66msLkSHNRlhzWZqlc9G2JCKX8lw2cg
	 +SHpnwwVTi5AG53xOnmHBQPHVDwwXOSao5DDsGm7JwZiwVFbAYdcyPgaHDF2aa8jO+
	 wFu8gS3Ew9XLi4bgBn0/YkRQDN1GZdBD6fFaNAcgRDFg/i0bKzlBSSdR+3XAkJonU3
	 1rF2GPWW85FLYROdllsL9c4hd3Iiq5k5odrjfBbo0xzXWAh13TrKFg6+7BPNVc3bkF
	 4HJO5VIdff8BmDNZk5YUu2Qos22VOZgM2+qVo7g8s7zlnFC8ez9pp9k1WDzMuMW5DC
	 dgY/c1t38y9Fg==
From: Thomas Gleixner <tglx@kernel.org>
To: Jing Wu <realwujing@gmail.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, Uladzislau
 Rezki <urezki@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Tejun Heo <tj@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
 <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jing Wu <realwujing@gmail.com>, Qiliang
 Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v3 05/13] cpu/hotplug: Reserve CPUHP states for
 nohz_full and managed IRQ down-paths
In-Reply-To: <871pe3de9b.ffs@fw13>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
 <20260618-wujing-dhm-v3-5-28f1a4d83b68@gmail.com> <871pe3de9b.ffs@fw13>
Date: Thu, 18 Jun 2026 23:01:27 +0200
Message-ID: <874iizef6g.ffs@fw13>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-17083-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 815FA6A2B47

On Thu, Jun 18 2026 at 18:06, Thomas Gleixner wrote:
> On Thu, Jun 18 2026 at 11:11, Jing Wu wrote:
>> Add CPUHP_AP_NO_HZ_FULL_DYING and CPUHP_AP_IRQ_AFFINITY_DYING to the
>> cpuhp_state enum.  These dying callbacks are invoked during CPU offline
>> before the tick is stopped, enabling clean tick handover and managed
>> IRQ migration when a CPU transitions between isolated and housekeeping
>> states.
>>
>> The existing CPUHP_AP_IRQ_AFFINITY_ONLINE already handles managed IRQ
>> restoration on CPU online.  The new dying callback completes the pair,
>> migrating managed interrupts away from the CPU before it goes down.
>
> What? They are migrated away today already when the CPU goes down unless
> the CPU is the last one in the affinity set of the interrupt. So why do
> you need a new step for something which already exists?

Aside of that these hotplug states are not used at all. So what is this
patch for?


