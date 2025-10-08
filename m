Return-Path: <cgroups+bounces-10613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B502BC6986
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 22:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6925319E4A87
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 20:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E03527A103;
	Wed,  8 Oct 2025 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le/qC5xJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3433315CD74;
	Wed,  8 Oct 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955674; cv=none; b=OzDj1l+N5ftDksnyFe/RT600sgWGuj2e3ieYmy1FWKTr6Zl5eKtmUurQvGlwkG7K/wDAxAE51hqUVfh94AtPUru2t+VFHvxEPptFBCc2HaN7RLZgjsRWHzIOerSwj8RSOPeMWGxEM6ndOn5wn2lpX9G42G1qmC4ZDN1lwiAuQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955674; c=relaxed/simple;
	bh=uOrnQlLlM/dsv+7QQ5bHgedTYfgtJ2zrymfXzVq6AFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY2TdMfL0c9bRaEJB0Ig31H5yaqAeD2nBv8RosOmmvDfRhH297f3GiJqTRS9pEMBy1ug+POUIBGITGTroEj3F/k1cfewNU3bmE3bsIiwGmAUm+1/hSoiO/CDE8vY8GV6JtAbNf1ikM5vCX/4Ih2xUrv0fRkOjCgD6KbLB8LNjkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le/qC5xJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85063C4CEE7;
	Wed,  8 Oct 2025 20:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759955673;
	bh=uOrnQlLlM/dsv+7QQ5bHgedTYfgtJ2zrymfXzVq6AFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Le/qC5xJF0vtw1r+NaxmhFBRG/BlENPk7cD6UDO3bfLGWG71v02OuYDWUMVPUzSfD
	 G1MAVd00R02q6iG2NoS2vbpfamzC4ZduSW+RuXmvLQ4bGGvDA010zONkTbh5DELMdP
	 RIaKgENya05Id10RkQcKOotWgLPZT8B6opuq+ncGav71sVm1e9xMsz7heeThwU14O8
	 tPCtzJAlm3gWi49szm+KhfTSDLbIVmfqCNAPR6wdDOWH/1Wx1FO+56H1KAIXhKC5YD
	 WQvMqcEfeNipOAjGpKP/yjKC+2pa8+dcUKeIshCm6wMmGKSfxYLoFLbgrF3ICAyx/P
	 WxSctpmE/RCzg==
Date: Wed, 8 Oct 2025 10:34:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	mingo@kernel.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
Message-ID: <aObK2MfxPyFcovwr@slm.duckdns.org>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
 <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
 <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>

Hello,

On Wed, Oct 08, 2025 at 05:22:42PM +0200, Vincent Guittot wrote:
> On Wed, 8 Oct 2025 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:
> >
> > > > +static struct task_struct *
> > > > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > > >  {
> > > > -       return pick_next_task_fair(rq, prev, NULL);
> > >
> > > The special case of a NULL rf pointer is used to skip
> > > sched_balance_newidle() at the end of pick_next_task_fair() in the
> > > pick_next_task() slo path when prev_balance has already it. This means
> > > that it will be called twice if prev is not a fair task.
> >
> > Oh right. I suppose we can simply remove balance_fair.
> 
> That was the option that I also had in mind but this will change from
> current behavior and I'm afraid that sched_ext people will complain.
> Currently, if prev is sched_ext, we don't call higher class.balance()
> which includes the fair class balance_fair->sched_balance_newidle.  If
> we now always call sched_balance_newidle() at the end
> pick_next_task_fair(), we will try to pull a fair task at each
> schedule between sched_ext tasks

If we pass in @prev into pick(), can't pick() decide whether to newidle
balance or not based on that?

Thanks.

-- 
tejun

