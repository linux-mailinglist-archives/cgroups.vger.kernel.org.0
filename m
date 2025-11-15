Return-Path: <cgroups+bounces-12000-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872D7C60925
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 18:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B26C3B795C
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134183019A1;
	Sat, 15 Nov 2025 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0opQtSr"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8232FBDFE;
	Sat, 15 Nov 2025 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227481; cv=none; b=IH74glOyQJuqi7viIYNfZJqldbGW2FmdSpniLw8xq8Nw2wEJ17uZLKq+Q4gkltisYfnl/8JDSuUpOLMb8/0BtBVUcou+/Xv2RDEFJE7xmfwI2fWYEgjLj+fpLUjLdmpM+dlFyE6csoklrrZif5/kkm547ex1DcL8WAvjWRE26VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227481; c=relaxed/simple;
	bh=qflNL+o4u7ZS4s+sN0dF13IvClzqLsiakctOn+2j+Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU0Va+QCP+IwkpNtVG/oVU974tXlQerT3W+iIAkrUKlSSRf3Q2q4vvxu/Ugzgw40K8MasQLQBuBqP2TY3doy55rWEqmZ10bGFWYA3Dbz5uoq4nGX3KHigwPTf/lax4VmIF7OTX2Zz8Jy7GHPFllUpFf5m+2zQ4PtAQld1JbQZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0opQtSr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D101C19423;
	Sat, 15 Nov 2025 17:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763227481;
	bh=qflNL+o4u7ZS4s+sN0dF13IvClzqLsiakctOn+2j+Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0opQtSrljGMEXfGx3lu0Ui88SpOIFxaCWiAHegbkZS0iZDgOekiHXFYy2u3SgAML
	 oEQVFHga+HUeR4ar0sKLoI97SlKHnbQUIst+vnpdXtKq0V/EqFyeBzpRXndaGMT2KC
	 7zsxcsY6hkXeacRjcYykl+MuHWB2DXTAp7jlXk9QTkeTPYCzQBlwg4gAgIF0BoeRqP
	 NvSd9hYdgqtf5bDIh/jqahGAVXcy43AjW/+/2ms1YHUcNilRZq0noU6Tr3+NpzJsW7
	 v/61/70aVkgMizF5dgia2uPp2GbvkrP1Nvcs0aY7RLs+w4g2u6wpmLwu2Q0/L1Ni5f
	 MPY8cdyVcKUww==
From: SeongJae Park <sj@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: Re: [RFC] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
Date: Sat, 15 Nov 2025 09:24:30 -0800
Message-ID: <20251115172431.83156-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CACePvbUBEQsgoei=ykeM6uX_GWaFywZEXY7dGt+T6Pt4zhiGsA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 15 Nov 2025 07:13:49 -0800 Chris Li <chrisl@kernel.org> wrote:

> On Fri, Nov 14, 2025 at 5:22 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Sun,  9 Nov 2025 21:49:44 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > > Hi all,
> > >
> > > In constrained environments, there is a need to improve workload
> > > performance by controlling swap device usage on a per-process or
> > > per-cgroup basis. For example, one might want to direct critical
> > > processes to faster swap devices (like SSDs) while relegating
> > > less critical ones to slower devices (like HDDs or Network Swap).
> > >
> > > Initial approach was to introduce a per-cgroup swap priority
> > > mechanism [1]. However, through review and discussion, several
> > > drawbacks were identified:
> > >
> > > a. There is a lack of concrete use cases for assigning a fine-grained,
> > >    unique swap priority to each cgroup.
> > > b. The implementation complexity was high relative to the desired
> > >    level of control.
> > > c. Differing swap priorities between cgroups could lead to LRU
> > >    inversion problems.
> > >
> > > To address these concerns, I propose the "swap tiers" concept,
> > > originally suggested by Chris Li [2] and further developed through
> > > collaborative discussions. I would like to thank Chris Li and
> > > He Baoquan for their invaluable contributions in refining this
> > > approach, and Kairui Song, Nhat Pham, and Michal Koutný for their
> > > insightful reviews of earlier RFC versions.
> >
> > I think the tiers concept is a nice abstraction.  I'm also interested in how
> > the in-kernel control mechanism will deal with tiers management, which is not
> > always simple.  I'll try to take a time to read this series thoroughly.  Thank
> > you for sharing this nice work!
> 
> Thank you for your interest. Please keep in mind that this patch
> series is RFC. I suspect the current series will go through a lot of
> overhaul before it gets merged in. I predict the end result will
> likely have less than half of the code resemble what it is in the
> series right  now.

Sure, I belive this work will greatly evolve :)

> 
> > Nevertheless, I'm curious if there is simpler and more flexible ways to achieve
> > the goal (control of swap device to use).  For example, extending existing
> Simplicity is one of my primary design principles. The current design
> is close to the simplest within the design constraints.

I agree the concept is very simple.  But, I was thinking there _could_ be
complexity for its implementation and required changes to existing code.
Especially I'm curious about how the control logic for tiers maangement would
be implemented in a simple but optimum and flexible way.  Hence I was lazily
thinking what if we just let users make the control.

I'm not saying tiers approach's control part implementation will, or is,
complex or suboptimum.  I didn't read this series thoroughly yet.

Even if it is at the moment, as you pointed out, I believe it will evolve to a
simple and optimum one.  That's why I am willing to try to get time for reading
this series and learn from it, and contribute back to the evolution if I find
something :)

> 
> > proactive pageout features, such as memory.reclaim, MADV_PAGEOUT or
> > DAMOS_PAGEOUT, to let users specify the swap device to use.  Doing such
> 
> In my mind that is a later phase. No, per VMA swapfile is not simpler
> to use, nor is the API simpler to code. There are much more VMA than
> memcg in the system, no even the same magnitude. It is a higher burden
> for both user space and kernel to maintain all the per VMA mapping.
> The VMA and mmap path is much more complex to hack. Doing it on the
> memcg level as the first step is the right approach.
> 
> > extension for MADV_PAGEOUT may be challenging, but it might be doable for
> > memory.reclaim and DAMOS_PAGEOUT.  Have you considered this kind of options?
> 
> Yes, as YoungJun points out, that has been considered here, but in a
> later phase. Borrow the link in his email here:
> https://lore.kernel.org/linux-mm/CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com/

Thank you for kindly sharing your opinion and previous discussion!  I
understand you believe sub-cgroup (e.g., vma level) control of swap tiers can
be useful, but there is no expected use case, and you concern about its
complexity in terms of implementation and interface.  That all makes sense to
me.

Nonetheless, I'm not saying about sub-cgroup control.  As I also replied [1] to
Youngjun, memory.reclaim and DAMOS_PAGEOUT based extension would work in cgroup
level.  And to my humble perspective, doing the extension could be doable, at
least for DAMOS_PAGEOUT.

Hmm, I feel like my mail might be read like I'm suggesting you to use
DAMOS_PAGEOUT.  The decision is yours and I will respect it, of course.  I'm
saying this though, because I am uncautiously but definitely biased as DAMON
maintainer. ;)  Again, the decision is yours and I will respect it.

[1] https://lore.kernel.org/20251115165637.82966-1-sj@kernel.org


Thanks,
SJ

[...]

