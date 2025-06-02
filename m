Return-Path: <cgroups+bounces-8413-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FCDACB6EA
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E8E7A8C85
	for <lists+cgroups@lfdr.de>; Mon,  2 Jun 2025 15:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D4229B1F;
	Mon,  2 Jun 2025 15:18:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECC228CB8
	for <cgroups@vger.kernel.org>; Mon,  2 Jun 2025 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877482; cv=none; b=t1ibWPNkYrb3cdJ27iY9YkPZlJ3m16Mn1asjK5HM0U3d9Vqkoz3QaywSrsy8JWkrINbgQ3qIcrrxQUZZ4QtTX7T43pTygt66n2rASDCaJVg+M4H1WMhzUKyoVb1LHExRrrrm6lQXI5/htvH83TmjGYCiOQ3sjjQoVG+7qRZuw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877482; c=relaxed/simple;
	bh=fRjKqdfi/jmJw5tjnf/CKTWSP54t2Ex+l05wCk9TSfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXXRTDgi8b7N1Sjvy7j10kl6D8rxONy8NfFy0e3yeDAuXVjNejy10S8spt9nWrwhrPA/haKYlgPrCYyNclWRRKVjkyHzjVHtdy894zChitQmm6jsHHLZp+JuUrf7TlnXzIBm8+jcYckA7HwsgDDbSruZMqf0fBGBfkb01UD4Q7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 3 Jun 2025 00:17:58 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 3 Jun 2025 00:17:58 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
	yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org, peterx@redhat.com, gunho.lee@lge.com,
	taejoon.song@lge.com, iamjoonsoo.kim@lge.com
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
Message-ID: <aD3Apu+sz9Na+65B@yjaykim-PowerEdge-T330>
References: <20250429233848.3093350-1-nphamcs@gmail.com>
 <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
 <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>
 <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330>
 <CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBkiwFHgy9uMk-F8Y-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBkiwFHgy9uMk-F8Y-w@mail.gmail.com>

On Mon, Jun 02, 2025 at 12:14:53AM +0800, Kairui Song wrote:
> On Sun, Jun 1, 2025 at 8:56 PM YoungJun Park <youngjun.park@lge.com> wrote:
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
> >
> > We’ve explored several approaches and PoCs around this,
> > and in the process of evaluating
> > whether our direction could eventually be aligned
> > with the upstream kernel,
> > I came across your patchset and wanted to ask whether
> > similar efforts have been discussed or attempted before.
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
> Hi All,
> 
> I'd like to share some info from my side. Currently we have an
> internal solution for multi tier swap, implemented based on ZRAM and
> writeback: 4 compression level and multiple block layer level. The
> ZRAM table serves a similar role to the swap table in the "swap table
> series" or the virtual layer here.
> 
> We hacked the BIO layer to let ZRAM be Cgroup aware, so it even
> supports per-cgroup priority, and per-cgroup writeback control, and it
> worked perfectly fine in production.
> 
> The interface looks something like this:
> /sys/fs/cgroup/cg1/zram.prio: [1-4]
> /sys/fs/cgroup/cg1/zram.writeback_prio [1-4]
> /sys/fs/cgroup/cg1/zram.writeback_size [0 - 4K]
> 
> It's really nothing fancy and complex, the four priority is simply the
> four ZRAM compression streams that's already in upstream, and you can
> simply hardcode four *bdev in "struct zram" and reuse the bits, then
> chain the write bio with new underlayer bio... Getting the priority
> info of a cgroup is even simpler once ZRAM is cgroup aware.
> 
> All interfaces can be adjusted dynamically at any time (e.g. by an
> agent), and already swapped out pages won't be touched. The block
> devices are specified in ZRAM's sys files during swapon.
> 
> It's easy to implement, but not a good idea for upstream at all:
> redundant layers, and performance is bad (if not optimized):
> - it breaks SYNCHRONIZE_IO, causing a huge slowdown, so we removed the
> SYNCHRONIZE_IO completely which actually improved the performance in
> every aspect (I've been trying to upstream this for a while);
> - ZRAM's block device allocator is just not good (just a bitmap) so we
> want to use the SWAP allocator directly (which I'm also trying to
> upstream with the swap table series);
> - And many other bits and pieces like bio batching are kind of broken,
> busy loop due to the ZRAM_WB bit, etc...
> - Lacking support for things like effective migration/compaction,
> doable but looks horrible.
> 

That's interesting — we've explored a similar idea as well, 
although not by attaching it to ZRAM.
Instead, our concept involved creating a separate block device 
capable of performing the tiering functionality, and using it as follows:

1. Prepare a block device that can manage multiple backend block devices.
2. Perform swapon on this block device.
3. Within the block device, use cgroup awareness 
to carry out tiered swap operations across the prepared backend devices.

However, we ended up postponing this approach as a second-tier option, mainly 
due to the following concerns:

1. The idea of allocating physical slots but managing them internally 
as logical slots felt inefficient.
2. Embedding cgroup awareness within a block device 
seemed like a layer violation.

> So I definitely don't like this band-aid solution, but hey, it works.
> I'm looking forward to replacing it with native upstream support.
> That's one of the motivations behind the swap table series, which
> I think it would resolve the problems in an elegant and clean way
> upstreamly. The initial tests do show it has a much lower overhead
> and cleans up SWAP.
> But maybe this is kind of similar to the "less optimized form" you
> are talking about? As I mentioned I'm already trying to upstream
> some nice parts of it, and hopefully replace it with an upstream
> solution finally.
> 
> I can try upstream other parts of it if there are people really
> interested, but I strongly recommend that we should focus on the
> right approach instead and not waste time on that and spam the
> mail list.

I am in agreement with the points you’ve made.
 
> I have no special preference on how the final upstream interface
> should look like. But currently SWAP devices already have priorities,
> so maybe we should just make use of that.

I have been exploring an interface design 
that leverages the existing swap priority mechanism,
and I believe it would be valuable 
to share this for further discussion and feedback.
As mentioned in my earlier response to Nhat,
I intend to submit this as an RFC to solicit broader input from the community. 

Best regards,
YoungJun Park

