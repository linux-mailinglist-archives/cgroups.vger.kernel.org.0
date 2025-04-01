Return-Path: <cgroups+bounces-7277-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2984FA77949
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 13:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAE61889FEA
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 11:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C551F1505;
	Tue,  1 Apr 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQ967Y0m"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3211EB1AE;
	Tue,  1 Apr 2025 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743505516; cv=none; b=RZ5zx5UYfrLRJgO55rR3EcYrhE1p/GSKiWMzyoPWN36IbgXADDabje7jiZ5uRfpj8ubDR1QrCpEEcB+s+9eh3z6SI0kfFlSOZsox6HFbQJlRl700j0in/yhJkLmzTW/ofoPzeqzujQ/Jp4cZQDjmtw+SlWpgqtBU9lBIG14p4Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743505516; c=relaxed/simple;
	bh=ARTupcEEq6i2EC2i9wAPjXR/Yra+qXyu0HmpTEAhmss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByOMpqrSYhVCRh646COGlCA5BD2HK4ek3LrifJuco4bPo5qreltfAiGbqNFFB82DXvUfoCz1uezOMFMpEt02zXdx1byhTwnwlQf/2LNCPw419jGok1ZEfKHCk77slTGPSzTGeRa5CdL88BndEhPvnP7jJtAV1oSml/3rSjcm3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EQ967Y0m; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PeNjz/wIQdwEcnEqPbT7la4zvvEgpJe/lwAU4tRByNM=; b=EQ967Y0mThZx5krbbl7ew8Ufmn
	WQZ9QciGjd74+3sWhd+ifXi/dCPB67GYWAH0iMn/RcHVFgVx8WVKqM3FZ0mMXI3RJz6D99yiY+qfR
	t7GDQkGG5T5Y/KExtJB7Byf2YRuJ72Y3oSL2STynnU+L+tkfwzUyDCvrMDnIR+S72fz+sZ2a9OAB9
	BuxdCz8+Bk86jWlVStCxPgd/bkXwdI1Ev/+KBzxYtHuRw2gFe4n86HOVIKT5bDmd50RWuOunzvNvz
	fz8T3UzP+qWGkZdYYuSyLApt/GrW0b8W7j0wZlcesUROjVIWeTa9Kt5LloY2aE5jI4ffRSN2lRGJj
	OWyhW2LA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzZQa-00000007BLA-43Un;
	Tue, 01 Apr 2025 11:05:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5AD5630049D; Tue,  1 Apr 2025 13:05:08 +0200 (CEST)
Date: Tue, 1 Apr 2025 13:05:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 00/10] Add kernel cmdline option for rt_group_sched
Message-ID: <20250401110508.GH25239@noisy.programming.kicks-ass.net>
References: <20250310170442.504716-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>

On Mon, Mar 10, 2025 at 06:04:32PM +0100, Michal Koutný wrote:
> Despite RT_GROUP_SCHED is only available on cgroup v1, there are still
> some (v1-bound) users of this feature. General purpose distros (e.g.
> [1][2][3][4]) cannot enable CONFIG_RT_GROUP_SCHED easily:
> - since it prevents creation of RT tasks unless RT runtime is determined
>   and distributed into cgroup tree,
> - grouping of RT threads is not what is desired by default on such
>   systems,
> - it prevents use of cgroup v2 with RT tasks.
> 
> This changeset aims at deferring the decision whether to have
> CONFIG_RT_GROUP_SCHED or not up until the boot time.
> By default RT groups are available as originally but the user can
> pass rt_group_sched=0 kernel cmdline parameter that disables the
> grouping and behavior is like with !CONFIG_RT_GROUP_SCHED (with certain
> runtime overhead).
> 
> The series is organized as follows:

Right, so at OSPM we had a proposal for a cgroup-v2 variant of all this
that's based on deadline servers. And I am hoping we can eventually
either fully deprecate the v1 thing or re-implement it sufficiently
close without breaking the interface.

But this is purely about enabling cgroup-v1 usage, right?

You meantion some overhead of having this on, is that measured and in
the patches?

Anyway, I'll go have a peek now, finally :-)

