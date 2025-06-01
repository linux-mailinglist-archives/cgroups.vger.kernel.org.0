Return-Path: <cgroups+bounces-8404-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C876EAC9E8B
	for <lists+cgroups@lfdr.de>; Sun,  1 Jun 2025 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0417597A
	for <lists+cgroups@lfdr.de>; Sun,  1 Jun 2025 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00E1D54EE;
	Sun,  1 Jun 2025 12:56:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3E2DCBFC
	for <cgroups@vger.kernel.org>; Sun,  1 Jun 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748782581; cv=none; b=kIY+UEgpPKa7MOJNZYui6bOaguDKzjQhl507RgvGlvwBQPqeF/Si8ExL4QSxp2c/RtZtSy7y7JeVLmnmy0YLX5IV/uZMEl5Lz+7On3k2Ws7ZInccw4dxLTEMO1PdqHiHD1UEHhMdmw00R64/PmrukBUdgsklJCUVejXcyL56BcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748782581; c=relaxed/simple;
	bh=cvrtNIWyrmKBib2SZoOx+LHxXS7ime+bJoCGWvN0elo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcwGfoEyvn+jq+xcWptEMe2KUN/Mk3BTv1oDCF3lfiposvgwHk4poEkGqOvHcMiB4R4367M1YUwHuGTO7wJfQ8N/skWTMlBDE43QmDFICDeq7R+o1M/lsBqiQIDdxAuHEnl2OKlU8Myp2J4OZiXWQ0/8+x+oLLkuQT3PCyRNJ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 1 Jun 2025 21:56:10 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 1 Jun 2025 21:56:10 +0900
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
Message-ID: <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
 <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
 <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>

On Fri, May 30, 2025 at 09:52:42AM -0700, Nhat Pham wrote:
> On Thu, May 29, 2025 at 11:47 PM YoungJun Park <youngjun.park@lge.com> wrote:
> >
> > On Tue, Apr 29, 2025 at 04:38:28PM -0700, Nhat Pham wrote:
> > > Changelog:
> > > * v2:
> > >       * Use a single atomic type (swap_refs) for reference counting
> > >         purpose. This brings the size of the swap descriptor from 64 KB
> > >         down to 48 KB (25% reduction). Suggested by Yosry Ahmed.
> > >       * Zeromap bitmap is removed in the virtual swap implementation.
> > >         This saves one bit per phyiscal swapfile slot.
> > >       * Rearrange the patches and the code change to make things more
> > >         reviewable. Suggested by Johannes Weiner.
> > >       * Update the cover letter a bit.
> >
> > Hi Nhat,
> >
> > Thank you for sharing this patch series.
> > I’ve read through it with great interest.
> >
> > I’m part of a kernel team working on features related to multi-tier swapping,
> > and this patch set appears quite relevant
> > to our ongoing discussions and early-stage implementation.
> 
> May I ask - what's the use case you're thinking of here? Remote swapping?
> 

Yes, that's correct.  
Our usage scenario includes remote swap, 
and we're experimenting with assigning swap tiers per cgroup 
in order to improve specific scene of our target device performance.

We’ve explored several approaches and PoCs around this, 
and in the process of evaluating 
whether our direction could eventually be aligned 
with the upstream kernel, 
I came across your patchset and wanted to ask whether 
similar efforts have been discussed or attempted before.

> >
> > I had a couple of questions regarding the future direction.
> >
> > > * Multi-tier swapping (as mentioned in [5]), with transparent
> > >   transferring (promotion/demotion) of pages across tiers (see [8] and
> > >   [9]). Similar to swapoff, with the old design we would need to
> > >   perform the expensive page table walk.
> >
> > Based on the discussion in [5], it seems there was some exploration
> > around enabling per-cgroup selection of multiple tiers.
> > Do you envision the current design evolving in a similar direction
> > to those past discussions, or is there a different direction you're aiming for?
> 
> IIRC, that past design focused on the interface aspect of the problem,
> but never actually touched the mechanism to implement a multi-tier
> swapping solution.
> 
> The simple reason is it's impossible, or at least highly inefficient
> to do it in the current design, i.e without virtualizing swap. Storing

As you pointed out, there are certainly inefficiencies 
in supporting this use case with the current design, 
but if there is a valid use case,
I believe there’s room for it to be supported in the current model
—possibly in a less optimized form—
until a virtual swap device becomes available 
and provides a more efficient solution.
What do you think about?

> the physical swap location in PTEs means that changing the swap
> backend requires a full page table walk to update all the PTEs that
> refer to the old physical swap location. So you have to pick your
> poison - either:
> 1. Pick your backend at swap out time, and never change it. You might
> not have sufficient information to decide at that time. It prevents
> you from adapting to the change in workload dynamics and working set -
> the access frequency of pages might change, so their physical location
> should change accordingly.
> 
> 2. Reserve the space in every tier, and associate them with the same
> handle. This is kinda what zswap is doing. It is space efficient, and
> create a lot of operational issues in production.
> 
> 3. Bite the bullet and perform the page table walk. This is what
> swapoff is doing, basically. Raise your hands if you're excited about
> a full page table walk every time you want to evict a page from zswap
> to disk swap. Booo.
> 
> This new design will give us an efficient way to perform tier transfer
> - you need to figure out how to obtain the right to perform the
> transfer (for now, through the swap cache - but you can perhaps
> envision some sort of locks), and then you can simply make the change
> at the virtual layer.
>

One idea that comes to mind is whether the backend swap tier for
a page could be lazily adjusted at runtime—either reactively 
or via an explicit interface—before the tier changes.  
Alternatively, if it's preferable to leave pages untouched
when the tier configuration changes at runtime, 
perhaps we could consider making this behavior configurable as well. 

> >
> > >   This idea is very similar to Kairui's work to optimize the (physical)
> > >   swap allocator. He is currently also working on a swap redesign (see
> > >   [11]) - perhaps we can combine the two efforts to take advantage of
> > >   the swap allocator's efficiency for virtual swap.
> >
> > I noticed that your patch appears to be aligned with the work from Kairui.
> > It seems like the overall architecture may be headed toward introducing
> > a virtual swap device layer.
> > I'm curious if there’s already been any concrete discussion
> > around this abstraction, especially regarding how it might be layered over
> > multiple physical swap devices?
> >
> > From a naive perspective, I imagine that while today’s swap devices
> > are in a 1:1 mapping with physical devices,
> > this virtual layer could introduce a 1:N relationship —
> > one virtual swap device mapped to multiple physical ones.
> > Would this virtual device behave as a new swappable block device
> > exposed via `swapon`, or is the plan to abstract it differently?
> 
> That was one of the ideas I was thinking of. Problem is this is a very
> special "device", and I'm not entirely sure opting in through swapon
> like that won't cause issues. Imagine the following scenario:
> 
> 1. We swap on a normal swapfile.
> 
> 2. Users swap things with the swapfile.
> 
> 2. Sysadmin then swapon a virtual swap device.
> 
> It will be quite nightmarish to manage things - we need to be extra
> vigilant in handling a physical swap slot for e.g, since it can back a
> PTE or a virtual swap slot. Also, swapoff becomes less efficient
> again. And the physical swap allocator, even with the swap table
> change, doesn't quite work out of the box for virtual swap yet (see
> [1]).
> 
> I think it's better to just keep it separate, for now, and adopt
> elements from Kairui's work to make virtual swap allocation more
> efficient. Not a hill I will die on though,
> 
> [1]: https://lore.kernel.org/linux-mm/CAKEwX=MmD___ukRrx=hLo7d_m1J_uG_Ke+us7RQgFUV2OSg38w@mail.gmail.com/
> 

I also appreciate your thoughts on keeping the virtual 
and physical swap paths separate for now. 
Thanks for sharing your perspective
—it was helpful to understand the design direction.

Best regards,  
YoungJun Park

