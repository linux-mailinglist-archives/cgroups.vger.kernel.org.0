Return-Path: <cgroups+bounces-3366-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21919917344
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 23:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C336F2894C9
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A28314A084;
	Tue, 25 Jun 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mYNbUn+B"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F83B12EBEA
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719350452; cv=none; b=hwZSUQFOCzUCbW+MfsMj9mg8L0j1ffXQQCmGmZ539zqZ7Tdvk1iQEfYn42VLmw2N6LKv0NEKeOwcJhLpQ0SeOoPxk7O0OQZyhp//EhuLsGPkYQ2qadQFSAa0aNfpxDyJhrdVC9pGw67lrhWbzGSvBnbp7Pwroq63hsaVUgfjY5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719350452; c=relaxed/simple;
	bh=bxudQhWRego45S9t0rtjz070vZ1pn1OnB9P/R69OqVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqHFV4nvZCFYQqAtmuqDNi15VGpZ9slvmhPfDtVGGIpe9g++muiOnpiDXjLlE1G6AftveXeZ/qsrUraYLKNbZ80bi1ljloAdpOuOnrLWwxHHvRVO9+Vs1aG5m+gFoVOaGXCFOBgkvG1/5siGR/4ZyGK4YN52+bg29Fqlo5SryRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mYNbUn+B; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719350447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSEq35mq+2liJqu8fhW0CLedotKEkg4vp/Y3QA9hLTo=;
	b=mYNbUn+BI0xiW3w9+MuLPEHsI3Z0TJjUg/rudWWYFZCW9OJ9Z6/+VcZeGtToiNrXdNSs8F
	l8ee/ddMnko4irYcFoESNE/u0730s/oEaIHgyohwi/WTjsy/PfSGR5zi3scbf22IMmLhE+
	IGCtVYRKj6ywAWNASzFS1MNWm3Hb9l8=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 25 Jun 2024 14:20:43 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
Message-ID: <ntpnm3kdpqexncc4hz4xmfliay3tmbasxl6zatmsauo3sruwf3@zcmgz7oq5huy>
References: <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
 <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
 <CAJD7tkaMeevj2TS_aRj_WXVi26CuuBrprYwUfQmszJnwqqJrHw@mail.gmail.com>
 <d3b5f10a-2649-446c-a6f9-9311f96e7569@kernel.org>
 <CAJD7tkZ0ReOjoioACyxQ848qNMh6a93hH616jNPgX3j72thrLg@mail.gmail.com>
 <zo6shlmgicfgqdjlfbeylpdrckpaqle7gk6ksdik7kqq7axgl6@65q4m73tgnp3>
 <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZ_aba9N9Qe8WeaLcp_ON_jQvuP9dg4tW0919QbCLLTMA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 25, 2024 at 01:45:00PM GMT, Yosry Ahmed wrote:
> On Tue, Jun 25, 2024 at 9:21 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Jun 25, 2024 at 09:00:03AM GMT, Yosry Ahmed wrote:
> > [...]
> > >
> > > My point is not about accuracy, although I think it's a reasonable
> > > argument on its own (a lot of things could change in a short amount of
> > > time, which is why I prefer magnitude-based ratelimiting).
> > >
> > > My point is about logical ordering. If a userspace program reads the
> > > stats *after* an event occurs, it expects to get a snapshot of the
> > > system state after that event. Two examples are:
> > >
> > > - A proactive reclaimer reading the stats after a reclaim attempt to
> > > check if it needs to reclaim more memory or fallback.
> > > - A userspace OOM killer reading the stats after a usage spike to
> > > decide which workload to kill.
> > >
> > > I listed such examples with more detail in [1], when I removed
> > > stats_flush_ongoing from the memcg code.
> > >
> > > [1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.com/
> >
> > You are kind of arbitrarily adding restrictions and rules here. Why not
> > follow the rules of a well established and battle tested stats infra
> > used by everyone i.e. vmstats? There is no sync flush and there are
> > frequent async flushes. I think that is what Jesper wants as well.
> 
> That's how the memcg stats worked previously since before rstat and
> until the introduction of stats_flush_ongoing AFAICT. We saw an actual
> behavioral change when we were moving from a pre-rstat kernel to a
> kernel with stats_flush_ongoing. This was the rationale when I removed
> stats_flush_ongoing in [1]. It's not a new argument, I am just
> reiterating what we discussed back then.

In my reply above, I am not arguing to go back to the older
stats_flush_ongoing situation. Rather I am discussing what should be the
best eventual solution. From the vmstats infra, we can learn that
frequent async flushes along with no sync flush, users are fine with the
'non-determinism'. Of course cgroup stats are different from vmstats
i.e. are hierarchical but I think we can try out this approach and see
if this works or not.

BTW it seems like this topic should be discussed be discussed
face-to-face over vc or LPC. What do you folks thing?

Shakeel

