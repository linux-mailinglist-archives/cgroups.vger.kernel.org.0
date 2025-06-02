Return-Path: <cgroups+bounces-8411-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F849ACB7FE
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC79F1C228F9
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1E6226CF1;
	Mon,  2 Jun 2025 15:04:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA755221FC3
	for <cgroups@vger.kernel.org>; Mon,  2 Jun 2025 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748876643; cv=none; b=Nkt7PcGPJzSqIxrPo1sezVynMfBAk0x8RMPKUl7wA0cNZ0xDxKzshTM2zhETnnlfI5B7YmZkN0lKtHnJrKObLvbe16YUuhWalFVXrp4zsCtSFeq7SyYQIXMoSoi5nOVP9Sc5aPPEsUSC2Dm9upDUarKroNXNgHL6Ueh8WjEmYg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748876643; c=relaxed/simple;
	bh=boJhymIaaEQ9M7ltEnszNrAVcAVirzSEjRdlBJp11ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoA5jVrLT7uFUsPo3B3hF/L322UT3XmnxccRJukrkVBH6YLuMdg8ZkTjVucAqAHsB5YZaZlNUTajbQsCLFWNwElwPiMbAOjWVIqeL2UrEhkTgLJ0ZEIP3u9/53ME3COPOEEVskEkABcTzUVdf8P5rsdgTy7uCQz1sppPuatioCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 3 Jun 2025 00:03:52 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 3 Jun 2025 00:03:52 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, gunho.lee@lge.com,
	taejoon.song@lge.com, iamjoonsoo.kim@lge.com
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
Message-ID: <aD29WJLms0CJVh8A@yjaykim-PowerEdge-T330>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
 <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
 <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>
 <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330>
 <CAKEwX=NFrWyFkyd5XhXEb_qYtWBk4yPUMPPJN0qHPAvzPUq_Dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=NFrWyFkyd5XhXEb_qYtWBk4yPUMPPJN0qHPAvzPUq_Dg@mail.gmail.com>

On Sun, Jun 01, 2025 at 02:08:22PM -0700, Nhat Pham wrote:
> On Sun, Jun 1, 2025 at 5:56 AM YoungJun Park <youngjun.park@lge.com> wrote:
> >
> > On Fri, May 30, 2025 at 09:52:42AM -0700, Nhat Pham wrote:
> > > On Thu, May 29, 2025 at 11:47 PM YoungJun Park <youngjun.park@lge.com> wrote:
> > > >
> > > > On Tue, Apr 29, 2025 at 04:38:28PM -0700, Nhat Pham wrote:
> > > > > Changelog:
> > > > > * v2:
> > > > >       * Use a single atomic type (swap_refs) for reference counting
> > > > >         purpose. This brings the size of the swap descriptor from 64 KB
> > > > >         down to 48 KB (25% reduction). Suggested by Yosry Ahmed.
> > > > >       * Zeromap bitmap is removed in the virtual swap implementation.
> > > > >         This saves one bit per phyiscal swapfile slot.
> > > > >       * Rearrange the patches and the code change to make things more
> > > > >         reviewable. Suggested by Johannes Weiner.
> > > > >       * Update the cover letter a bit.
> > > >
> > > > Hi Nhat,
> > > >
> > > > Thank you for sharing this patch series.
> > > > I’ve read through it with great interest.
> > > >
> > > > I’m part of a kernel team working on features related to multi-tier swapping,
> > > > and this patch set appears quite relevant
> > > > to our ongoing discussions and early-stage implementation.
> > >
> > > May I ask - what's the use case you're thinking of here? Remote swapping?
> > >
> >
> > Yes, that's correct.
> > Our usage scenario includes remote swap,
> > and we're experimenting with assigning swap tiers per cgroup
> > in order to improve specific scene of our target device performance.
> 
> Hmm, that can be a start. Right now, we have only 2 swap tiers
> essentially, so memory.(z)swap.max and memory.zswap.writeback is
> usually sufficient to describe the tiering interface. But if you have
> an alternative use case in mind feel free to send a RFC to explore
> this!
>

Yes, sounds good.
I've organized the details of our swap tiering approach 
including the specific use case we are trying to solve.
This approach is based on leveraging 
the existing priority mechanism in the swap subsystem.
I’ll be sharing it as an RFC shortly.
 
> >
> > We’ve explored several approaches and PoCs around this,
> > and in the process of evaluating
> > whether our direction could eventually be aligned
> > with the upstream kernel,
> > I came across your patchset and wanted to ask whether
> > similar efforts have been discussed or attempted before.
> 
> I think it is occasionally touched upon in discussion, but AFAICS
> there has not been really an actual upstream patch to add such an
> interface.
> 
> >
> > > >
> > > > I had a couple of questions regarding the future direction.
> > > >
> > > > > * Multi-tier swapping (as mentioned in [5]), with transparent
> > > > >   transferring (promotion/demotion) of pages across tiers (see [8] and
> > > > >   [9]). Similar to swapoff, with the old design we would need to
> > > > >   perform the expensive page table walk.
> > > >
> > > > Based on the discussion in [5], it seems there was some exploration
> > > > around enabling per-cgroup selection of multiple tiers.
> > > > Do you envision the current design evolving in a similar direction
> > > > to those past discussions, or is there a different direction you're aiming for?
> > >
> > > IIRC, that past design focused on the interface aspect of the problem,
> > > but never actually touched the mechanism to implement a multi-tier
> > > swapping solution.
> > >
> > > The simple reason is it's impossible, or at least highly inefficient
> > > to do it in the current design, i.e without virtualizing swap. Storing
> >
> > As you pointed out, there are certainly inefficiencies
> > in supporting this use case with the current design,
> > but if there is a valid use case,
> > I believe there’s room for it to be supported in the current model
> > —possibly in a less optimized form—
> > until a virtual swap device becomes available
> > and provides a more efficient solution.
> > What do you think about?
> 
> Which less optimized form are you thinking of?
>

Just mentioning current swap design would be less optimized regardless 
of the form of tiering applied.
Not meaninig my approach is less optimized.
That may have come across differently than I intended.
Please feel free to disregard that assumption — 
I believe it would be more appropriate 
to evaluate this based on the RFC I plan to share soon.
 
> >
> > > the physical swap location in PTEs means that changing the swap
> > > backend requires a full page table walk to update all the PTEs that
> > > refer to the old physical swap location. So you have to pick your
> > > poison - either:
> > > 1. Pick your backend at swap out time, and never change it. You might
> > > not have sufficient information to decide at that time. It prevents
> > > you from adapting to the change in workload dynamics and working set -
> > > the access frequency of pages might change, so their physical location
> > > should change accordingly.
> > >
> > > 2. Reserve the space in every tier, and associate them with the same
> > > handle. This is kinda what zswap is doing. It is space efficient, and
> > > create a lot of operational issues in production.
> > >
> > > 3. Bite the bullet and perform the page table walk. This is what
> > > swapoff is doing, basically. Raise your hands if you're excited about
> > > a full page table walk every time you want to evict a page from zswap
> > > to disk swap. Booo.
> > >
> > > This new design will give us an efficient way to perform tier transfer
> > > - you need to figure out how to obtain the right to perform the
> > > transfer (for now, through the swap cache - but you can perhaps
> > > envision some sort of locks), and then you can simply make the change
> > > at the virtual layer.
> > >
> >
> > One idea that comes to mind is whether the backend swap tier for
> > a page could be lazily adjusted at runtime—either reactively
> > or via an explicit interface—before the tier changes.
> > Alternatively, if it's preferable to leave pages untouched
> > when the tier configuration changes at runtime,
> > perhaps we could consider making this behavior configurable as well.
> >
> 
> I don't quite understand - could you expand on this?
>

Regarding your point, 
my understanding was that you were referring
to an immediate migration once a new swap tier is selected at runtime. 
I was suggesting whether a lazy migration approach
—or even skipping migration altogether—might 
be worth considering as alternatives.
I only mentioned it because, from our use case perspective, 
immediate migration is not strictly necessary.

Best regards,
YoungJun Park

