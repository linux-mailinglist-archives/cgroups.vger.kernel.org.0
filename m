Return-Path: <cgroups+bounces-17079-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ch3EDN1LNGqTUAYAu9opvQ
	(envelope-from <cgroups+bounces-17079-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 21:49:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED26A2668
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 21:49:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kzClxa3b;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17079-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17079-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44BC1301F7CF
	for <lists+cgroups@lfdr.de>; Thu, 18 Jun 2026 19:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562FC33262B;
	Thu, 18 Jun 2026 19:49:44 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE117A2F6;
	Thu, 18 Jun 2026 19:49:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781812184; cv=none; b=Gb+KlrnAo9UWiK2kTy39UAmnAmy0qI3b3AXfVm+7GBkpYdbraA59LN306N4Ps43ojB7OGsXpx8+6IsazBAey+83w2yDv+FbFiO+2MNsDzB3OY88y+obDTevcN0Tgua3BPfdVyl4KUDVMHZWDWVR3mOmt/kqnxvI2ttFKFqRgLB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781812184; c=relaxed/simple;
	bh=V8ppcrVCR+AH4dpZ3fmksxIZ/nZYlUy0y027NLtpvdI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1sW603qI8zS685Gvr1ezo6wjHVpAZS973cQm3A6u648KUNZrIPQUY0LtE9KGaFKO/qbW1h80fmnIMBAhFuAJ91jl2eZJLToXWfL6YITNcTvbY12sliuZWVQlPlzFoO+W7dKsZGk2mT7oCI7qYqG9eIzp0XE0Wj+5MDidyjJEdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzClxa3b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5711B1F000E9;
	Thu, 18 Jun 2026 19:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781812183;
	bh=vBkcS6rlXa3Mc6LJBo3bIbi51glgCWUH1Ymj1PNXpAU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kzClxa3bE2V+TB8Vx48D9lgilu48B12FhPg0tOFM269QwoRxfD4Uqc2zWcKoUjDGv
	 Q2T7NKvPZKm3l3dIZl85pEMF8D+J2cOtnVTsRXRlvx/Gct7nFRdGmP8mWUR1Df6yer
	 ZAgJNWp6fxt6PlyashZFt7i9QkJmqlHfkveWXjkoKdYrksyIrGw967pK8/DkIr6FgF
	 Y2pB+i8FH2MF0wx+CkU9dK/DmP8OIlOe2Yf7RG2DDVZVEAZI5PTk4qO/O5l0vIP4Mz
	 LeJOnJp1Gpr6SA/Vyn77C1QT2ClgHO3CtDkHI0102vj2/Mqxoro/FDi+iuPJgNkgBS
	 1zZil3AV/rKKA==
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
Subject: Re: [PATCH v3 06/13] tick/nohz, context_tracking: Prepare for
 runtime nohz_full updates
In-Reply-To: <87ik7fep2j.ffs@fw13>
References: <20260618-wujing-dhm-v3-0-28f1a4d83b68@gmail.com>
 <20260618-wujing-dhm-v3-6-28f1a4d83b68@gmail.com> <87ik7fep2j.ffs@fw13>
Date: Thu, 18 Jun 2026 21:49:40 +0200
Message-ID: <87eci3eii3.ffs@fw13>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
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
	TAGGED_FROM(0.00)[bounces-17079-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fw13:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7ED26A2668

On Thu, Jun 18 2026 at 19:27, Thomas Gleixner wrote:
> On Thu, Jun 18 2026 at 11:11, Jing Wu wrote:
>> Remove __init from ct_cpu_track_user() and __initdata from the
>> initialized flag so context tracking can be activated on CPUs that
>> join nohz_full at runtime.  Drop the __ro_after_init attribute from
>> the context_tracking_key static key, allowing static_branch_dec()
>> when a CPU leaves nohz_full.
>>
>> Add ct_cpu_untrack_user() to reverse ct_cpu_track_user(), decrementing
>> the static key and clearing the per-CPU tracking state.
>
> Please do not enumerate WHAT the patch is doing. Explain the context and
> the WHY
>
>   https://docs.kernel.org/process/maintainer-tip.html#changelog

Just for the record. I told your colleague the same thing already....

