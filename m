Return-Path: <cgroups+bounces-15425-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKeEEKA252mg5QEAu9opvQ
	(envelope-from <cgroups+bounces-15425-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:34:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3334383B6
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 10:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D864F30347A2
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2026 08:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39973876A0;
	Tue, 21 Apr 2026 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfS7qPKo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB432D7FA;
	Tue, 21 Apr 2026 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760344; cv=none; b=g6ew15eNpWA4kL8Ojz9YjIR+fclu6no+w1rCsVkPZAhgzDY2FGxGpqxnUQBhrLf7dZLaJKVzF9Zat45ydaGZgGodgUu3wG3R/DDVLmiDZkdjS3pztkmBGjHdNe0RASdrtP88LFd5IQT4nV3vgzTH9/f4xbcDDlwHYt9WecXAgqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760344; c=relaxed/simple;
	bh=3AcEuu4rBoAM4PHRXKIwJtTm21PzPN71Sn/og8FiSjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2buC8+P5Um3fBM3H1QmBw/WNzCWHO5zcR2K9OesTE39O0NspQ1w039vOT4TGplansGnshhzRi4wemmseO5e8tIpO+CJVP6Mny4u2jr8Ha9oZg4O7mB7ie9lrnfs44+93kAwDofJV1Q55Z+7ga+vEGPlgW27N7csmCwkb7DQ1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfS7qPKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2555DC2BCB6;
	Tue, 21 Apr 2026 08:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776760344;
	bh=3AcEuu4rBoAM4PHRXKIwJtTm21PzPN71Sn/og8FiSjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PfS7qPKozeqAUB5Zl+iQ1lO9PY0zsrU6jMDx05jt62pS21tKlPO+joZxotJ/8wwMy
	 klgJ3OKt3Zxt2/su+CMy+xAXgJySWhzXsLNJ+rreFdIFmdH2TiB+U6m0ckRtew7qeY
	 iu+DBPVxYXmx7t+eFXiJCy19r9mWhbfRIZPdgaMVKJGlvNLFdRJGHJ93A5dIp8Nry1
	 TkiFkUBMfjzQVt2uV6h/itwg2w8YlRvOe2XhljJzkrArkr5UFh3ZPUP/XFiZxGY8J5
	 ohfT37dU3CgucSqG2Fb5q3IxMgIjOZD3sUpAWZC6Qe0RhpRH861xqLXTyBPYJz7Dap
	 Uy3MffWfNb8hQ==
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
Subject: Re: [PATCH 03/23] tick/nohz: Make nohz_full parameter optional
In-Reply-To: <20260421030351.281436-4-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-4-longman@redhat.com>
Date: Tue, 21 Apr 2026 10:32:18 +0200
Message-ID: <875x5kd88d.ffs@tglx>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-15425-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DF3334383B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
> To provide nohz_full tick support, there is a set of tick dependency
> masks that need to be evaluated on every IRQ and context switch.

s/IRQ/interrupt/

This is a changelog and not a SMS service.

> Switching on nohz_full tick support at runtime will be problematic
> as some of the tick dependency masks may not be properly set causing
> problem down the road.

That's useless blurb with zero content.

> Allow nohz_full boot option to be specified without any
> parameter to force enable nohz_full tick support without any
> CPU in the tick_nohz_full_mask yet. The context_tracking_key and
> tick_nohz_full_running flag will be enabled in this case to make
> tick_nohz_full_enabled() return true.

I kinda can crystal-ball what you are trying to say here, but that does
not make it qualified as a proper change log.

> There is still a small performance overhead by force enable nohz_full
> this way. So it should only be used if there is a chance that some
> CPUs may become isolated later via the cpuset isolated partition
> functionality and better CPU isolation closed to nohz_full is desired.

Why has this key to be enabled on boot if there are no CPUs in the
isolated mask?

If you want to manage this dynamically at runtime then enable the key
once CPUs are isolated. Yes, it's more work, but that avoids the "should
only be used" nonsense and makes this more robust down the road.

Thanks,

        tglx



