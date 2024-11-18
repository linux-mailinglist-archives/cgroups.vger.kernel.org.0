Return-Path: <cgroups+bounces-5607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09619D0DE2
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 11:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790561F216A9
	for <lists+cgroups@lfdr.de>; Mon, 18 Nov 2024 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40929193409;
	Mon, 18 Nov 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IPI1gr6I"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32090193071;
	Mon, 18 Nov 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924632; cv=none; b=sHrKe7JbJEHvk2uRfMpldQyWs+PJYZFB4lK7chNOTQkM9BALnYvA97LhCGAtXOSs105wF+h1mBJaFQeUGP8y34mMRJNKg39GlzlY5WlB+mVpzoYyJ14PZqtpVbvmn+qt5lTN4Ghos/qzMdA+adQwPrliexgBXIoqGTfq/1ipM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924632; c=relaxed/simple;
	bh=VT3MocuM8iVtea2DfkImyHdM0ECQhC+eoTcrkAWWu7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPxECbAd5faf2Cv6/xG5vvjU/c9QwpK6hkOer2MqCaKPkQeQFv8KnMjPv00D07IwGS2n8Amg4ZMXu0oDpz+f4WCRta8fcLD/BbmP3iiG1FwgWqXrSuiES3qq12PxyhHmd3g0sTt6My7lokdN8iiWz5mpvIy/YXI3ocYIy/bmjI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IPI1gr6I; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oBC2RAZHZE5tY2EgMgmKFBOrYGolwmLsreVLSDBJ/Ds=; b=IPI1gr6IH12pFfqdw+IT8Eq31M
	Bo03y/GXq5gaG1MmNUwwQBDS4i4Fkny3IGKyyDwWsKJJ0jUfrGBZk6BTbFsvkq9cFrRyMNXaK8EAf
	EJ1QgTVcyIlDEffPwmgx5XE/MuTC38W6HvPQwUTKCGWvfSJ9lV1kymEtoBVILw0SOtu4ggpLPVSmm
	z9hmKq/lo3CfY9bZbSG1p+lAgz1fH/8OrBwN2bx5xgR98Cw4aQasIQsSRMig4ecayomgigjTjuacg
	x4+O2EBoRvrNVQu41cdqGYJzLwanjWaDTQUhYYo/ptTw2NnOw5wzsNBqPHXiTbHnsyeNlXgHeyjBj
	9EMUQv/A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tCyi7-00000002onA-2NS1;
	Mon, 18 Nov 2024 10:10:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B216A30049D; Mon, 18 Nov 2024 11:10:23 +0100 (CET)
Date: Mon, 18 Nov 2024 11:10:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org,
	surenb@google.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] sched: Fix missing irq time when
 CONFIG_IRQ_TIME_ACCOUNTING is enabled
Message-ID: <20241118101023.GI39245@noisy.programming.kicks-ass.net>
References: <20241108132904.6932-1-laoar.shao@gmail.com>
 <dmibxkog4sdbuddotjslmyv6zgyptgbq5voujhfnitdag2645m@bl4jphfz3xzg>
 <CALOAHbC54QZ6ZrRBHHKKz8F79C1J8fYcA1q59iwotuBBKtFGmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbC54QZ6ZrRBHHKKz8F79C1J8fYcA1q59iwotuBBKtFGmA@mail.gmail.com>

On Sun, Nov 17, 2024 at 10:56:21AM +0800, Yafang Shao wrote:
> On Fri, Nov 15, 2024 at 9:41 PM Michal Koutný <mkoutny@suse.com> wrote:

> > > The load balancer is malfunctioning due to the exclusion of IRQ time from
> > > CPU utilization calculations.
> >
> > Could this be fixed by subtracting (global) IRQ time from (presumed
> > total) system capacity that the balancer uses for its decisions? (i.e.
> > without exact per-cgroup breakdown of IRQ time)
> 
> The issue here is that the global IRQ time may include the interrupted
> time of tasks outside the target cgroup. As a result, I don't believe
> it's possible to find a reliable solution without modifying the
> kernel.

Since there is no relation between the interrupt and the interrupted
task (and through that its cgroup) -- all time might or might not be
part of your cgroup of interest. Consider it a random distribution if
you will.

What Michael suggests seems no less fair, and possible more fair than
what you propose:

 \Sum cgroup = total - IRQ

As opposed to what you propose:

 \Sum (cgroup + cgroup-IRQ) = total - remainder-IRQ

Like I argued earlier, if you have two cgroups, one doing a while(1)
loop (proxy for doing computation) and one cgroup doing heavy IO or
networking, then per your accounting the computation cgroup will get a
significant amount of IRQ time 'injected', even though it is effidently
not of that group.

Injecting 'half' of the interrupts in the computation group, and missing
'half' of the interrupts from the network group will get 'wrong'
load-balance results too.

I remain unconvinced that any of this makes sense.

