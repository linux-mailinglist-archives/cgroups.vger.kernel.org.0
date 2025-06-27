Return-Path: <cgroups+bounces-8646-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AE4AEBF62
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 21:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A053ACA72
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C81FA178;
	Fri, 27 Jun 2025 19:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7gAnHqu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFE31F473C;
	Fri, 27 Jun 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751050894; cv=none; b=H1e2x5z9HQwahKHwsEmS08KxdCaNeVuOEFBYKm8rgdfc7r95iOHU0hgH+3h46RSzbBHXvLhnNpvEJ/P5th4dV+JsOJAqp8v8o7kncf8uj5wjTmOOcaSmzGvUYG5mddAL8P5RTr6HQOdUmCGdaYjAjX0S3iL/WzW2207jBJeTFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751050894; c=relaxed/simple;
	bh=+Z2dOnNvbRwQSRsG3QSBXopAVTxVsPdAeLmcJniGFe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwwWqfUQaN5cf27CfZelg2TRH9BlSoHjAh3Y0Ov3+8Wslaw2IZlF52E643kLeDUXRb7kfjwmcPH1X6n7CDcG6MpZulpqBgZP+dkfwkGmiv+dkp/9XBnOKM8aLHZdd4EG9xx3Chk4QVVBy/iwd4b/noq1WZBva9U1favrikvizEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7gAnHqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0BBC4CEE3;
	Fri, 27 Jun 2025 19:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751050893;
	bh=+Z2dOnNvbRwQSRsG3QSBXopAVTxVsPdAeLmcJniGFe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R7gAnHquxOHVtG5p5NGkfjGDzC62fDfpV/uWOn4o+TOULgIue20tQQarfy3898/tX
	 S7bx2GGcTs6nEmtzWf7YsXYQjIDbD5CbzDB/t6CWFxaMM1LbYnQyyFkTcw1PSKOhJ+
	 WAtc+TasJhy+dRHOuktM1SSOiAqIchtpXrROoW4w5SDkHkuEg5B2f3Ed3V1txTTFJK
	 kSo72YTQ3SwLdNSmUurBO7SAQDUGfkGGKzf13wa0AOByd/f5fTiQPdzjn+Rzvr4LFQ
	 R9OCHykZA2A8Jgk6nj12NNhaJA1OnoPsY/DC6jXJ/s0SDQhnHQhEPo/aIK4e+rP/0O
	 YLzPrK2xJhJIA==
Date: Fri, 27 Jun 2025 09:01:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	kernel-team@android.com, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chen Ridong <chenridong@huawei.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
Message-ID: <aF7qjAkwXhjTVmT-@slm.duckdns.org>
References: <20250603224304.3198729-3-ynaffit@google.com>
 <aD9_V1rSqqESFekK@slm.duckdns.org>
 <dbx8y0u7i9e6.fsf@ynaffit-andsys.c.googlers.com>
 <aEDM_s7y8xMKJHph@slm.duckdns.org>
 <dbx8y0tej595.fsf@ynaffit-andsys.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbx8y0tej595.fsf@ynaffit-andsys.c.googlers.com>

Hello,

On Thu, Jun 26, 2025 at 07:19:18PM -0700, Tiffany Yang wrote:
...
> Fortunately, since this same latency is present when we
> unfreeze a cgroup and each member task, it's effectively canceled out
> when we look at the freezing duration for tasks in cgroups that are not
> currently frozen. For a running task, the measurement of how long it had
> spent frozen in the past was within 1-2 ticks of its cgroup's. Our use
> case does not look at this accounting until after a task has become
> unfrozen, so the per-cgroup values seem like a reasonable substitution
> for our purposes!

Glad that worked out, but I'm curious what are the involved time scales.
Let's say you get things off by some tens of msecs, or maybe even hundreds,
does that matter for your purpose?

> That being said, I realized from Michal's reply that the tracked value
> doesn't have to be as narrow as the cgroup v2 freezing time. Basically,
> we just want to give userspace some measure of time that a task cannot
> run when it expects to be running. It doesn't seem practical to give an
> exact accounting, but maybe tracking the time that each task spends in
> some combination of stopped or frozen would provide a useful estimate.

While it's not my call, I'm not necessarily against. However, as you noted
in another reply, the challenge is that there are multiple states and it's
not clear what combinations would be useful for whom. When/if we encounter
more real world use cases tha twould require these numbers, they may shed
light on what the right combination / interface is. IOW, I'm not sure this
is a case where adding something preemptively is a good idea.

Thanks.

-- 
tejun

