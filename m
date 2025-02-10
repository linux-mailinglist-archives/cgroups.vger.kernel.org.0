Return-Path: <cgroups+bounces-6488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CACA2F318
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E989B163BD4
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2025 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9CE2580E0;
	Mon, 10 Feb 2025 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpFPhpEh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C998F2580C8;
	Mon, 10 Feb 2025 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204413; cv=none; b=Um1ZGfdAvhKAy2z5hiG8ZhtXhFXGnf106W9VJgq3zAbyw/1msOhvDCqZoXR+5xUjkyz2TcEI4OdWt1Oqd+Mj2yWYbmwUVVdbG2BZkq3G9MFsBvVvmJ2Xs/uLcbBOu/5XPSB+pvdxwwhObDHmPVEjsscxxy336tDNr/1o0UxtJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204413; c=relaxed/simple;
	bh=PbUicCmIFdjpcUFcKr4bLsGE918h29ndeodZw27NPJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gco3dtXASrCYporuADyoB11uDdySS2rvcZnssZP1qc3fsvChMNX5+1ermD+lyfeAFpRFYuvX5s38d0CKR9OJFBuk3JFSZh7vRtjwcLH1EHDmSdbgaWM5i9rwQAWJA8coQv4mpaw7K7As65IZlDqugjARYG9hZBzVl6TmWclbkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpFPhpEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244C4C4CED1;
	Mon, 10 Feb 2025 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739204413;
	bh=PbUicCmIFdjpcUFcKr4bLsGE918h29ndeodZw27NPJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpFPhpEh2J59IPGvPI1ojhA3QxLZfDTuh0//7bIMogtvZzlLGPhrtpOBiH4lcbFIb
	 OPXAWvHq9AQJP2YyzVSSzP4z2GKw5TTEIyHpzzm4PL0b2qs1DU74P6Kku8p0LcBrDI
	 S7Iw+MYQPBha48hvlxbl5bcEVSVfAJsT6mzZGaQ1tO89eNfk999NEuH9GKc6P3Hc85
	 iPm/3ctXUfMW5RJsWsorF4vbGYQlkIwguhlWSmrS4N7c9xdKsma7wPTd1BDoXuzDy4
	 K5805Z3XtHiR/dfYBRFasIuCepp06tYt5ybMzeMtmoeqqf9oQnC5DJ+lbHRK7wlH1v
	 LYADDn1Cz2TNg==
Date: Mon, 10 Feb 2025 06:20:12 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yury Norov <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bitao Hu <yaoma@linux.alibaba.com>,
	Chen Ridong <chenridong@huawei.com>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] cgroup/rstat: Add run_delay accounting for cgroups
Message-ID: <Z6onPMIxS0ixXxj9@slm.duckdns.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <20250125052521.19487-4-wuyun.abel@bytedance.com>
 <3wqaz6jb74i2cdtvkv4isvhapiiqukyicuol76s66xwixlaz3c@qr6bva3wbxkx>
 <9515c474-366d-4692-91a7-a4c1a5fc18db@bytedance.com>
 <qt3qdbvmrqtbceeogo32bw2b7v5otc3q6gfh7vgsk4vrydcgix@33hepjadeyjb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qt3qdbvmrqtbceeogo32bw2b7v5otc3q6gfh7vgsk4vrydcgix@33hepjadeyjb>

On Mon, Feb 10, 2025 at 04:38:56PM +0100, Michal Koutný wrote:
...
> The challenge is with nr (assuming they're all runnable during Δt), that
> would need to be sampled from /sys/kernel/debug/sched/debug. But then
> you can get whatever load for individual cfs_rqs from there. Hm, does it
> even make sense to add up run_delays from different CPUs?

The difficulty in aggregating across CPUs is why some and full pressures are
defined the way they are. Ideally, we'd want full distribution of stall
states across CPUs but both aggregation and presentation become challenging,
so some/full provide the two extremes. Sum of all cpu_delay adds more
incomplete signal on top. I don't know how useful it'd be. At meta, we
depend on PSI a lot when investigating resource problems and we've never
felt the need for the sum time, so that's one data point with the caveat
that usually our focus is on mem and io pressures where some and full
pressure metrics usually seem to provide sufficient information.

As the picture provided by some and full metrics is incomplete, I can
imagine adding the sum being useful. That said, it'd help if Able can
provide more concrete examples on it being useful. Another thing to consider
is whether we should add this across resources monitored by PSI - cpu, mem
and io.

Thanks.

-- 
tejun

