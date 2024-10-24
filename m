Return-Path: <cgroups+bounces-5228-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2B99AECC7
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ADC01C20D3B
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0BA1BD504;
	Thu, 24 Oct 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="owGyNocO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381216A94B
	for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789059; cv=none; b=Tq4EI9cBrd+VGPtX4JLRj/0HcDlYfgEbW1KuqLdRidntng9a4VRROWG0IupJ2CQMJlEhIogZ6UYAF06+JnGShy2SPfBAh97677qC1jWgCdqkxZar9jxPCE4MreVeEirfZ3Xb94DQg1DuLXNfGiUDh1NREoVkoIN1sdNTAXVR1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789059; c=relaxed/simple;
	bh=u0r2elEmcf82RWuFLhwW1IcF2hs+YQTwCXtM+8iBfQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2ZexLXN1yRdNz9C2muGhVsDcFij3ukCH94a188syDfEGhQKS4FxwIRMLBxr0rLR0ABAmevS6D+Z6wCdY9M3MWZHlH/Xyee6pP66flYYfQKbXOarIZWlvyJ7rSxOidx9fJecU0bM7tlDheATeOHGnLsQnWg8dhrcp7bmASNrMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=owGyNocO; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Oct 2024 16:57:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729789054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCaGX0Dw13JORqruLEi+QcIAeT5FeKkNU9QsvnDs0Ww=;
	b=owGyNocOmKSVHndKkPQkRarsyaMiVDCo+cYrm4e8VsM6Ua7BhfNk7K780dDlcqRylSF/Fd
	uiFsup97K9z37za6QroPa6BJESknmXZNhbD9xygQ0tAyZlX3epA9UXOi3UjuesIcXEyaf9
	BYOxxR0MWINLCNUKGADYvUETZn8C4mM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hannes@cmpxchg.org,
	nphamcs@gmail.com, mhocko@kernel.org, roman.gushcin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, lnyng@meta.com,
	akpm@linux-foundation.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
Message-ID: <Zxp8eUk7ELSSP-B0@google.com>
References: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>
 <CAJD7tkaxKG4P-DLEHQGTad1vbgZgf7nVJq6=824MRWxJ1si19A@mail.gmail.com>
 <CAJD7tkak6F4nwZLWxNK8zKN5z6y=0MPCCHwfW7kOVKDmn08Ytg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkak6F4nwZLWxNK8zKN5z6y=0MPCCHwfW7kOVKDmn08Ytg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 23, 2024 at 02:17:27PM -0700, Yosry Ahmed wrote:
> On Wed, Oct 23, 2024 at 2:15 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Hi Joshua,
> >
> > On Wed, Oct 23, 2024 at 1:34 PM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> > >
> > > Changelog
> > > v2:
> > >   * Enables the feature only if memcg accounts for hugeTLB usage
> > >   * Moves the counter from memcg_stat_item to node_stat_item
> > >   * Expands on motivation & justification in commitlog
> > >   * Added Suggested-by: Nhat Pham
> >
> > Changelogs usually go at the end, after ---, not as part of the commit
> > log itself.
> >
> > >
> > > This patch introduces a new counter to memory.stat that tracks hugeTLB
> > > usage, only if hugeTLB accounting is done to memory.current. This
> > > feature is enabled the same way hugeTLB accounting is enabled, via
> > > the memory_hugetlb_accounting mount flag for cgroupsv2.
> > >
> > > 1. Why is this patch necessary?
> > > Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
> > > hugeTLB usage to memory.current. However, the metric is not reported in
> > > memory.stat. Given that users often interpret memory.stat as a breakdown
> > > of the value reported in memory.current, the disparity between the two
> > > reports can be confusing. This patch solves this problem by including
> > > the metric in memory.stat as well, but only if it is also reported in
> > > memory.current (it would also be confusing if the value was reported in
> > > memory.stat, but not in memory.current)
> > >
> > > Aside from the consistentcy between the two files, we also see benefits
> >
> > consistency*
> >
> > > in observability. Userspace might be interested in the hugeTLB footprint
> > > of cgroups for many reasons. For instance, system admins might want to
> > > verify that hugeTLB usage is distributed as expected across tasks: i.e.
> > > memory-intensive tasks are using more hugeTLB pages than tasks that
> > > don't consume a lot of memory, or is seen to fault frequently. Note that
> >
> > are* seen
> >
> > > this is separate from wanting to inspect the distribution for limiting
> > > purposes (in which case, hugeTLB controller makes more sense).
> > >
> > > 2. We already have a hugeTLB controller. Why not use that?
> > > It is true that hugeTLB tracks the exact value that we want. In fact, by
> > > enabling the hugeTLB controller, we get all of the observability
> > > benefits that I mentioned above, and users can check the total hugeTLB
> > > usage, verify if it is distributed as expected, etc.
> > >
> > > With this said, there are 2 problems:
> > >   (a) They are still not reported in memory.stat, which means the
> > >       disparity between the memcg reports are still there.
> > >   (b) We cannot reasonably expect users to enable the hugeTLB controller
> > >       just for the sake of hugeTLB usage reporting, especially since
> > >       they don't have any use for hugeTLB usage enforcing [2].
> > >
> > > [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com/
> > > [2] Of course, we can't make a new patch for every feature that can be
> > >     duplicated. However, since the exsting solution of enabling the
> >
> > existing*
> >
> > >     hugeTLB controller is an imperfect solution that still leaves a
> > >     discrepancy between memory.stat and memory.curent, I think that it
> > >     is reasonable to isolate the feature in this case.
> > >
> > > Suggested-by: Nhat Pham <nphamcs@gmail.com>
> > > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >
> > You should also CC linux-mm on such patches.
> 
> +roman.gushchin@linux.dev
> 
> CCing Roman's correct email.


Funny enough I suggested a similar functionality back to 2017:
https://lkml.iu.edu/hypermail/linux/kernel/1711.1/04891.html ,
but it was rejected at that time.
So yeah, it still sounds like a good idea to me.

As I understand, there is a new version of this patchset pending,
I'll wait for it for the review.

Thank you for looping me in!

