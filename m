Return-Path: <cgroups+bounces-10605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A97BC5553
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 15:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125133C11B6
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 13:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964F9288C34;
	Wed,  8 Oct 2025 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SdaM1Ygh"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0BD235C01;
	Wed,  8 Oct 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931921; cv=none; b=AulX8vsVUvlvDt6FUWOY6ekak0csyCtpBoFROnjlWwRxsKrkacUAFE4ezGEtxfPjxgXIcpuBWY5+0IX+wKXa7uU7WU4q2brCsMf/IYsVO05/LZgRzNQMMYrAE2ko3RjuQ+kbksbXZnqtkkFOstysLyEolCNvpIFMLXzYh++SsD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931921; c=relaxed/simple;
	bh=bIS3CECsL9SwkAipfM5moGJaHurPrBbwODg4g5wtQHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJN1pqGDUlW1zyewzIOS7QOpwo3d9KLns7HGlb4IZGZXfVW21fAnFb92SLdEvpG8xD9hJV0RTJ5svUcC6XTf2D70Clxc1cIQdB5Blx0XBxjvPCkZhmJMSkTFajL3kAujhYSNox4djpz2ALuG+GXeS3efXEl2D6Gxa1Krt7yeISs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SdaM1Ygh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ipkIo97WbfBXRfA6Awwdt/Zt8vCBI383wL+H18F9oN8=; b=SdaM1Ygh/wofs08waEwgi2Ygfh
	aowIUPM0qhNBaW7nEsPjVFpsZLgqsDebSdN4+zgzNR51oTyD08eYfhgDK++m5T3vPg6V1off2CPYA
	HyIS+grnasQCBoViBmGQz/Lv5cOfikc8MYJ5jJ1JiBeXef4FJR4tuuqcl0OtOvdQJbaHo1iuv37iT
	cDw71CqJyI3IxwSe+PSwjV9uXMQM1o1QdumtEQQMoLcR1mcMbak4i/XhQ4ACOO3KLOTKAIXUS4Wtx
	wrjx+lMFVd+oTOiFa03/v8NCxYSgG7nlfMAF9xnJm4UIjK7bCFNp9yg5o7p/mNRSZm7cb6SSIfvdj
	Sve5RPZw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6UgY-00000006LBg-03HX;
	Wed, 08 Oct 2025 13:58:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBA19300400; Wed, 08 Oct 2025 15:58:30 +0200 (CEST)
Date: Wed, 8 Oct 2025 15:58:30 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
Message-ID: <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com>

On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:

> > +static struct task_struct *
> > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> >  {
> > -       return pick_next_task_fair(rq, prev, NULL);
> 
> The special case of a NULL rf pointer is used to skip
> sched_balance_newidle() at the end of pick_next_task_fair() in the
> pick_next_task() slo path when prev_balance has already it. This means
> that it will be called twice if prev is not a fair task.

Oh right. I suppose we can simply remove balance_fair.

> While reviewing this series, I also noticed an older issue that we
> have with check pelt lost idle time [1]
> [1] https://lore.kernel.org/all/20251008131214.3759798-1-vincent.guittot@linaro.org/

Let me go have a look.

