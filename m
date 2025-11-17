Return-Path: <cgroups+bounces-12049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F948C666C4
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 23:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A7AD2354AB1
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 22:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252034C988;
	Mon, 17 Nov 2025 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/JAI73A"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913AD32C302
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 22:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763417878; cv=none; b=IJrNhaC4hAW771HVldOU44ODXoTvfTXdC/6RNs5rtc3jggUoi4RlEsPrHdpvZtHH3QSIazOsa2UpUfpJ+CBrOoYHj08OQGEIHxOUXcocuUTZ5tHV7ZdB/q1vuqCyavHEA2DrzZ5jY92qlkzU3+GpLFsmB7TITLxWPjvSB9KkWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763417878; c=relaxed/simple;
	bh=Iv3NFR3+Iu7BTy0EYf2sC8D85e61Z7PXncB5P+SpuqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUVetC/9L9b4POFMyB32u2ShWV2fhJcE0F3aVageSlKITS8Nlq+D+iphcJM8Iw301+9w5akL6e+wG61hADmWyrMBgB3uKBH/pTeXsFP9J8E7zgWODTOvlffWL8Vo09cAFvS3L1RtwFadKm//BVdE4FIKaSaw8S2mGId24E0Zvvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/JAI73A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096E7C4AF0F
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 22:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763417878;
	bh=Iv3NFR3+Iu7BTy0EYf2sC8D85e61Z7PXncB5P+SpuqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j/JAI73A3Url87p0yOhA4GnLmRiY/hwUsqIW0Im+c0MvGkdD3hZvS7Nm12jr5u/U1
	 hcXS0I+WPbIK5fTcqN8X4zKpzZ/1WYkDU/deCprl4rFR05E8yGv2KVMEFa40X/68s2
	 b4TmruhZqmdD75lRi5x7ziNGPm93x4jTcVEMZAtb6rkvstXXyyCjBeRliZf7U35aOz
	 EOP6nPrPSLYHnUuP78h86ApZwhYyFJ3u7duKGVjvM2OfmfDpb5rVE4yGfQVBXLKUqs
	 byQgEI8/nrpEp3DvncsQqhz3pzE0eQGpsHPxJ+Js6rnE+Vcg2Ef78WLm9v3vBA3BnF
	 z6CtrnZ9qbukw==
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso4049339d50.0
        for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 14:17:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUcwzlsnInJDKtbxz73BTwmAWgx50t1XycIBi+E00gdGs2Hy6B6WANFCYCzqWYN1t7FbFIbbzG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ne76d702J1lAhwWpzvxRJzG6Tg4SiS7tDAL8fWxX/0Z+vube
	PsAOF6u9loZcy2uOy2naDE7XcbnKXjS2jUL7kofZ+vKsrLJRnvnYfz/gxYGzZD/hF7lLz2A1U5h
	jMGUfM681wF6hK7QTOnwd/4TT/INyJ8k1FzUoRrfxsg==
X-Google-Smtp-Source: AGHT+IFC3T7bPUsKWDSyc/zJmJY47BiOoIQaYL1jmAtft8112JY1ZeeYBWqU8Y48NcMEHH3fevNY3w9fgaSuVPuG/8Q=
X-Received: by 2002:a05:690e:c45:b0:63f:b2ca:80e1 with SMTP id
 956f58d0204a3-641e727ff0cmr11828503d50.0.1763417875019; Mon, 17 Nov 2025
 14:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbUBEQsgoei=ykeM6uX_GWaFywZEXY7dGt+T6Pt4zhiGsA@mail.gmail.com>
 <20251115172431.83156-1-sj@kernel.org>
In-Reply-To: <20251115172431.83156-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 17 Nov 2025 14:17:43 -0800
X-Gmail-Original-Message-ID: <CACePvbVkBPJBaowW0tQrL0mPqSq5kM1hNx91BX_JroM8ruS7sQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmnY8z0jUWMzSN-Fi5TsGwGO41754NgluCVPEwQpNeRJicXbhNgs-x2yx0
Message-ID: <CACePvbVkBPJBaowW0tQrL0mPqSq5kM1hNx91BX_JroM8ruS7sQ@mail.gmail.com>
Subject: Re: [RFC] mm/swap, memcg: Introduce swap tiers for cgroup based swap control
To: SeongJae Park <sj@kernel.org>
Cc: Youngjun Park <youngjun.park@lge.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com, 
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com, 
	taejoon.song@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 9:24=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sat, 15 Nov 2025 07:13:49 -0800 Chris Li <chrisl@kernel.org> wrote:
> > Thank you for your interest. Please keep in mind that this patch
> > series is RFC. I suspect the current series will go through a lot of
> > overhaul before it gets merged in. I predict the end result will
> > likely have less than half of the code resemble what it is in the
> > series right  now.
>
> Sure, I belive this work will greatly evolve :)

Yes, we can use any eyes that can help to review or spot bugs.

> > > Nevertheless, I'm curious if there is simpler and more flexible ways =
to achieve
> > > the goal (control of swap device to use).  For example, extending exi=
sting
> > Simplicity is one of my primary design principles. The current design
> > is close to the simplest within the design constraints.
>
> I agree the concept is very simple.  But, I was thinking there _could_ be
> complexity for its implementation and required changes to existing code.
> Especially I'm curious about how the control logic for tiers maangement w=
ould
> be implemented in a simple but optimum and flexible way.  Hence I was laz=
ily
> thinking what if we just let users make the control.

The selection of the swap device will be at the swap allocator. The
good news is that we just rewrite the whole swap allocator so it is an
easier code base to work with for us than the previous swap allocator.
I haven't imagined how to implement swap file selection on the
previous allocator, I am just glad that I don't need to worry about
it.

Some feedback on the madvise API that selects one specific device.
That might sound simple, because you only need to remember one swap
file. However, the less than ideal part is that, you are pinned to one
swap file, if that swap file is full, you are stuck. If that swap file
has been swapoff, you are stuck.

I believe that allowing selection of a tier class, e.g. a QoS aspect
of the swap latency expectation, is better fit what the user really
wants to do. So I see selecting swapfile vs swap tier is a separate
issue of how to select the swap device (madvise vs memory.swap.tiers).
Your argument is that selecting a tier is more complex than selecting
a swap file directly. I agree from an implementation point of view.
However the tiers offer better flexibility and free users from the
swapfile pinning. e.g. round robin on a few swap files of the same
tier is better than pinning to one swap file. That has been proven
from Baoquan's test benchmark.

Another feedback is that user space isn't the primary one to perform
swap out by madivse PAGEOUT. A lot of swap happens due to the cgroup
memory usage hitting the memory cgroup limit, which triggers the swap
out from the memory cgroup that hit the limit. That is an existing
usage case and we have a need to select which swap file anyway. If we
extend the madvise for per swapfile selection, that is a question that
must have an answer for native swap out (by the kernel not madvise)
anyway.  I can see  the user space wants to set the POLICY about a VMA
if it ever gets swapped out, what speed of swap file it goes to. That
is a follow up after we have the swapfile selection at the memory
cgroup level.

> I'm not saying tiers approach's control part implementation will, or is,
> complex or suboptimum.  I didn't read this series thoroughly yet.
>
> Even if it is at the moment, as you pointed out, I believe it will evolve=
 to a
> simple and optimum one.  That's why I am willing to try to get time for r=
eading
> this series and learn from it, and contribute back to the evolution if I =
find
> something :)
>
> >
> > > proactive pageout features, such as memory.reclaim, MADV_PAGEOUT or
> > > DAMOS_PAGEOUT, to let users specify the swap device to use.  Doing su=
ch
> >
> > In my mind that is a later phase. No, per VMA swapfile is not simpler
> > to use, nor is the API simpler to code. There are much more VMA than
> > memcg in the system, no even the same magnitude. It is a higher burden
> > for both user space and kernel to maintain all the per VMA mapping.
> > The VMA and mmap path is much more complex to hack. Doing it on the
> > memcg level as the first step is the right approach.
> >
> > > extension for MADV_PAGEOUT may be challenging, but it might be doable=
 for
> > > memory.reclaim and DAMOS_PAGEOUT.  Have you considered this kind of o=
ptions?
> >
> > Yes, as YoungJun points out, that has been considered here, but in a
> > later phase. Borrow the link in his email here:
> > https://lore.kernel.org/linux-mm/CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T=
7GFsm9VDr2e_g@mail.gmail.com/
>
> Thank you for kindly sharing your opinion and previous discussion!  I
> understand you believe sub-cgroup (e.g., vma level) control of swap tiers=
 can
> be useful, but there is no expected use case, and you concern about its
> complexity in terms of implementation and interface.  That all makes sens=
e to
> me.

There is some usage request from Android wanting to protect some VMA
never getting swapped into slower tiers. Otherwise it can cause
jankiness. Still I consider the cgroup swap file selection is a more
common one.

> Nonetheless, I'm not saying about sub-cgroup control.  As I also replied =
[1] to
> Youngjun, memory.reclaim and DAMOS_PAGEOUT based extension would work in =
cgroup
> level.  And to my humble perspective, doing the extension could be doable=
, at
> least for DAMOS_PAGEOUT.

I would do it one thing at a time and start from the mem cgroup level
swap file selection e.g. "memory.swap.tiers". However, if you are
passionate about VMA level swap file selection, please feel free to
submit patches for it.

> Hmm, I feel like my mail might be read like I'm suggesting you to use
> DAMOS_PAGEOUT.  The decision is yours and I will respect it, of course.  =
I'm
> saying this though, because I am uncautiously but definitely biased as DA=
MON
> maintainer. ;)  Again, the decision is yours and I will respect it.
>
> [1] https://lore.kernel.org/20251115165637.82966-1-sj@kernel.org

Sorry I haven't read much about the DAMOS_PAGEOUT yet. After reading
the above thread, I still don't feel I have a good sense of
DAMOS_PAGEOUT. Who is the actual user that requested that feature and
what is the typical usage work flow and life cycle? BTW, I am still
considering the per VMA swap policy should happen after the
memory.swap.tiers given my current understanding.

Chris

