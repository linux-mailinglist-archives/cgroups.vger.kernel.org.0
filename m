Return-Path: <cgroups+bounces-15499-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG5fFgaT62m7OgAAu9opvQ
	(envelope-from <cgroups+bounces-15499-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 17:57:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C45461130
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 17:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CEC9300AD68
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23273D6487;
	Fri, 24 Apr 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajfozHwD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E24F1DED5B;
	Fri, 24 Apr 2026 15:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046267; cv=none; b=fHlddOl9rDzcTI3iweNdh2/A0a3gcyDUwndX0+yYkehoFwPlG394VWDZsxJ4oY79w9JUsx8zRpsJJfsqCF7KcTNfaaXfxByFk2H6jI8GFw5RPl5mswihr2Ei83UqmHgDOJWkKjF1QwNrU7wTw/cnLiIWfscyjU8t+9I3xc79edU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046267; c=relaxed/simple;
	bh=qO/MAUTAHfRFlyhPD2rItuN3QmG4P8rtxuTLbkxNwL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmsT/jq26HBpxr2QofPWP7j6OCG74VoZYZYRz0K8pR7nNuSaHcDzA8ABv1ZVHOTwZO/ncQpwAIY0Ff1mUGMSWhXRFfVjSKN7Ihq+S0sZZAc4JslppF/gpgS3FR+4jIbnoJUYJY8lXWFUoS50mYdlf1xk0YCqPyMPcu308pk15dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajfozHwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C95C2BCB6;
	Fri, 24 Apr 2026 15:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046267;
	bh=qO/MAUTAHfRFlyhPD2rItuN3QmG4P8rtxuTLbkxNwL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ajfozHwD1fCyxVIfcezb1FBnsxwPft4s+SO1HNKvMY5sayIllGVwXOVtVSslBiMZF
	 iBATPF8Gcw9+n7ropEBl/64VF34ptpNInOVsEsJkrETPnxJJKygFlN1VYMgsTk/aYJ
	 gYUvbgp7JalTMlmRCPOXSELTijM0xY26ZJKLVNhvwHiNjYbLxtQV/g5iAlxMKVWK29
	 RGgC4BQzNUj5QUpG0M5muBCkcgoXJy+cqEnzLKsOM+NOcQcatVhMlBI26zUciOzkDE
	 k9Zm/lBjzIrlUV4Mjw8X3a4NKdoQ0/dEMltXuRb3fUxMSZ+xWpW5L0buiDsXXrS+bR
	 AlN0XSo5XZv8Q==
Date: Fri, 24 Apr 2026 17:57:43 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Tejun Heo <tj@kernel.org>,
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
Subject: Re: [PATCH 03/23] tick/nohz: Make nohz_full parameter optional
Message-ID: <aeuS98a-u899PBmR@pavilion.home>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-4-longman@redhat.com>
 <875x5kd88d.ffs@tglx>
 <3b796360-81e4-4f90-9b19-8a9f21cbac07@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b796360-81e4-4f90-9b19-8a9f21cbac07@redhat.com>
X-Rspamd-Queue-Id: 65C45461130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-15499-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Le Tue, Apr 21, 2026 at 10:14:09AM -0400, Waiman Long a écrit :
11;rgb:2e2e/3434/3636> On 4/21/26 4:32 AM, Thomas Gleixner wrote:
> > On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
> > > To provide nohz_full tick support, there is a set of tick dependency
> > > masks that need to be evaluated on every IRQ and context switch.
> > s/IRQ/interrupt/
> > 
> > This is a changelog and not a SMS service.
> > > Switching on nohz_full tick support at runtime will be problematic
> > > as some of the tick dependency masks may not be properly set causing
> > > problem down the road.
> > That's useless blurb with zero content.
> > 
> > > Allow nohz_full boot option to be specified without any
> > > parameter to force enable nohz_full tick support without any
> > > CPU in the tick_nohz_full_mask yet. The context_tracking_key and
> > > tick_nohz_full_running flag will be enabled in this case to make
> > > tick_nohz_full_enabled() return true.
> > I kinda can crystal-ball what you are trying to say here, but that does
> > not make it qualified as a proper change log.
> > 
> > > There is still a small performance overhead by force enable nohz_full
> > > this way. So it should only be used if there is a chance that some
> > > CPUs may become isolated later via the cpuset isolated partition
> > > functionality and better CPU isolation closed to nohz_full is desired.
> > Why has this key to be enabled on boot if there are no CPUs in the
> > isolated mask?
> > 
> > If you want to manage this dynamically at runtime then enable the key
> > once CPUs are isolated. Yes, it's more work, but that avoids the "should
> > only be used" nonsense and makes this more robust down the road.
> 
> OK, I will try to make it fully dynamic. Of course, it will be more work.

Since the target CPUs will be offline, it should be fine to just enable/disable
the static key and masks on runtime. The only issue I see right now is posix
CPU timers because the tick dependency is per task/process group. And those
tasks could migrate to nohz_full CPUs by careless users (even though that's
nonsense) once the target become online. So the per task/process tick dependency
must be set up unconditionally. I don't think this should bring much noticeable
overhead though.

Oh and the other way to go, that is removing TICK_DEP_BIT_POSIX_TIMER and forbid to
run posix cpu timers on nohz_full CPUs, would be even more painful to implement
so I don't have a better idea.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

