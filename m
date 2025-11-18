Return-Path: <cgroups+bounces-12051-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3AC66CC9
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 02:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2215029A84
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 01:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C72D94B9;
	Tue, 18 Nov 2025 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhMV3shW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365C030217B;
	Tue, 18 Nov 2025 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763428280; cv=none; b=qqlIiC9525+N00po7UeNoEHZrUUW56DlIMPl3Y5GOlNszuunpL4/d1ZL3LabChsZODFWfg7tfhjpGsCjrf4IlAk3BShZYOG6L3alRx3VOlwoOvMFbg0rcntzQFQbzkTTNmw06q0eZ/w01UGI6jY1pO7UwBCoFqifz60aXjWsyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763428280; c=relaxed/simple;
	bh=KR7lSvTBx1GYbntfD6LTgnw4OVTqKdduvephCIMgmDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vk7DzUzHgPrDPjzwF51cd8EutwJ+GyB3Ra4ap1U/N914WK9FmG15APvA9cCeOL3kCFl6jHhcjM8SL4nkJ1LngkpIK5lJTAL/Mk+tyxfc4ttyI11UnaLtU4Y0LfFej6hXg/CkyF5UT8PNaOzGf6OmPpuA6FhBTcP0f0enBWeDous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhMV3shW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FE0C4CEF5;
	Tue, 18 Nov 2025 01:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763428279;
	bh=KR7lSvTBx1GYbntfD6LTgnw4OVTqKdduvephCIMgmDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhMV3shWof4q6bAoyPBHcglc8GPA7dKJogXivez6cVvJ1Ugisb1r9suEHgYKgPBTy
	 XU38ZzWxcUriNn9AxgRZorDzQY0MQDYLlcnBQVUTTJIivPg/wKKIrfeN/SnX5egH7Z
	 kvziTnRTNuTEfX1Sjam+VHzWvDAHMbr8A84rcJgEPqe0wdTY9DG7FqZ2tSQtVpm+jv
	 vBLhM/ABS4tNU5O3crtmkaeZ63tBKVZ3PdZX6PA4CRCcK6uBH9uQZBbDaf/LXckfQ9
	 lzRyp8gMVA5FoZbQ0zUsOd6PUW8mMNRe1tg8d5xiGOqog2lC66a8OmNrZBn64SDlW4
	 r+Qwnxbda+ZHg==
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
Date: Mon, 17 Nov 2025 17:11:07 -0800
Message-ID: <20251118011109.75484-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CACePvbVkBPJBaowW0tQrL0mPqSq5kM1hNx91BX_JroM8ruS7sQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 17 Nov 2025 14:17:43 -0800 Chris Li <chrisl@kernel.org> wrote:

TLDR: my idea was only for proactive reclaim use cases, while you want to cover
reactive swap use cases.  I agree my idea cannot work for that.

I added more detailed comments below.

> On Sat, Nov 15, 2025 at 9:24 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Sat, 15 Nov 2025 07:13:49 -0800 Chris Li <chrisl@kernel.org> wrote:
> > > Thank you for your interest. Please keep in mind that this patch
> > > series is RFC. I suspect the current series will go through a lot of
> > > overhaul before it gets merged in. I predict the end result will
> > > likely have less than half of the code resemble what it is in the
> > > series right  now.
> >
> > Sure, I belive this work will greatly evolve :)
> 
> Yes, we can use any eyes that can help to review or spot bugs.
> 
> > > > Nevertheless, I'm curious if there is simpler and more flexible ways to achieve
> > > > the goal (control of swap device to use).  For example, extending existing
> > > Simplicity is one of my primary design principles. The current design
> > > is close to the simplest within the design constraints.
> >
> > I agree the concept is very simple.  But, I was thinking there _could_ be
> > complexity for its implementation and required changes to existing code.
> > Especially I'm curious about how the control logic for tiers maangement would
> > be implemented in a simple but optimum and flexible way.  Hence I was lazily
> > thinking what if we just let users make the control.
> 
> The selection of the swap device will be at the swap allocator. The
> good news is that we just rewrite the whole swap allocator so it is an
> easier code base to work with for us than the previous swap allocator.
> I haven't imagined how to implement swap file selection on the
> previous allocator, I am just glad that I don't need to worry about
> it.
> 
> Some feedback on the madvise API that selects one specific device.
> That might sound simple, because you only need to remember one swap
> file. However, the less than ideal part is that, you are pinned to one
> swap file, if that swap file is full, you are stuck. If that swap file
> has been swapoff, you are stuck.

I agree about the problem.

My idea was, however, letting each madvise() call to decide which swap device
to use.  In the case, if a swap device is full, the user may try other swap
device, so no such stuck would happen.

And because of the madivse() interface, I was saying doing such extension for
madvise() could be challenging, while such extensions for memory.reclaim or
DAMOS_PAGEOUT may be much more doable.

> 
> I believe that allowing selection of a tier class, e.g. a QoS aspect
> of the swap latency expectation, is better fit what the user really
> wants to do. So I see selecting swapfile vs swap tier is a separate
> issue of how to select the swap device (madvise vs memory.swap.tiers).
> Your argument is that selecting a tier is more complex than selecting
> a swap file directly. I agree from an implementation point of view.
> However the tiers offer better flexibility and free users from the
> swapfile pinning. e.g. round robin on a few swap files of the same
> tier is better than pinning to one swap file. That has been proven
> from Baoquan's test benchmark.

I agree the problem of pinning.  Nonetheless my idea was not pinning, but just
letting users select the swap device whenever they want to swap.  That is, the
user may be able to do the round robin selection.  And in a case, they might
want and be able to do an advanced selection that optimized for their special
case.

> 
> Another feedback is that user space isn't the primary one to perform
> swap out by madivse PAGEOUT. A lot of swap happens due to the cgroup
> memory usage hitting the memory cgroup limit, which triggers the swap
> out from the memory cgroup that hit the limit. That is an existing
> usage case and we have a need to select which swap file anyway. If we
> extend the madvise for per swapfile selection, that is a question that
> must have an answer for native swap out (by the kernel not madvise)
> anyway.  I can see  the user space wants to set the POLICY about a VMA
> if it ever gets swapped out, what speed of swap file it goes to. That
> is a follow up after we have the swapfile selection at the memory
> cgroup level.

I fully agreed.  My idea is basically extending proactive reclamation features.
It cannot cover this reactive reclaim cases.

I think this perfectly answers my question!

> 
> > I'm not saying tiers approach's control part implementation will, or is,
> > complex or suboptimum.  I didn't read this series thoroughly yet.
> >
> > Even if it is at the moment, as you pointed out, I believe it will evolve to a
> > simple and optimum one.  That's why I am willing to try to get time for reading
> > this series and learn from it, and contribute back to the evolution if I find
> > something :)
> >
> > >
> > > > proactive pageout features, such as memory.reclaim, MADV_PAGEOUT or
> > > > DAMOS_PAGEOUT, to let users specify the swap device to use.  Doing such
> > >
> > > In my mind that is a later phase. No, per VMA swapfile is not simpler
> > > to use, nor is the API simpler to code. There are much more VMA than
> > > memcg in the system, no even the same magnitude. It is a higher burden
> > > for both user space and kernel to maintain all the per VMA mapping.
> > > The VMA and mmap path is much more complex to hack. Doing it on the
> > > memcg level as the first step is the right approach.
> > >
> > > > extension for MADV_PAGEOUT may be challenging, but it might be doable for
> > > > memory.reclaim and DAMOS_PAGEOUT.  Have you considered this kind of options?
> > >
> > > Yes, as YoungJun points out, that has been considered here, but in a
> > > later phase. Borrow the link in his email here:
> > > https://lore.kernel.org/linux-mm/CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFsm9VDr2e_g@mail.gmail.com/
> >
> > Thank you for kindly sharing your opinion and previous discussion!  I
> > understand you believe sub-cgroup (e.g., vma level) control of swap tiers can
> > be useful, but there is no expected use case, and you concern about its
> > complexity in terms of implementation and interface.  That all makes sense to
> > me.
> 
> There is some usage request from Android wanting to protect some VMA
> never getting swapped into slower tiers. Otherwise it can cause
> jankiness. Still I consider the cgroup swap file selection is a more
> common one.

Thank you for sharing this interesting usage request!  And I agree cgroup level
requirements would be more common.

> 
> > Nonetheless, I'm not saying about sub-cgroup control.  As I also replied [1] to
> > Youngjun, memory.reclaim and DAMOS_PAGEOUT based extension would work in cgroup
> > level.  And to my humble perspective, doing the extension could be doable, at
> > least for DAMOS_PAGEOUT.
> 
> I would do it one thing at a time and start from the mem cgroup level
> swap file selection e.g. "memory.swap.tiers".

Makes sense, please proceed on your schedule :)

> However, if you are
> passionate about VMA level swap file selection, please feel free to
> submit patches for it.

I have no plan to do that at the moment.  I just wanted to hear your opinion on
my naive ideas :)  Thank you for sharing the opinions!

> 
> > Hmm, I feel like my mail might be read like I'm suggesting you to use
> > DAMOS_PAGEOUT.  The decision is yours and I will respect it, of course.  I'm
> > saying this though, because I am uncautiously but definitely biased as DAMON
> > maintainer. ;)  Again, the decision is yours and I will respect it.
> >
> > [1] https://lore.kernel.org/20251115165637.82966-1-sj@kernel.org
> 
> Sorry I haven't read much about the DAMOS_PAGEOUT yet. After reading
> the above thread, I still don't feel I have a good sense of
> DAMOS_PAGEOUT. Who is the actual user that requested that feature and
> what is the typical usage work flow and life cycle?

In short, DAMOS_PAGEOUT is a proactive reclaim mechanism.  Users can ask a
kernel thread (called kdamond) to monitor the access pattern of the system and
reclaim pages of specific access pattern (e.g., not accessed for >=2 minutes)
as soon as found.  Some users including AWS are using it as a proactive
reclamation mechanism.

As I mentioned above, since it is a sort of proactive method, it wouldn't cover
the reactive reclamation use case and cannot be an alternative of your swap
tiers work.

> BTW, I am still
> considering the per VMA swap policy should happen after the
> memory.swap.tiers given my current understanding.

I have no strong opinion, and that also makes sense to me :)


Thanks,
SJ

[...]

