Return-Path: <cgroups+bounces-7733-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D46A97563
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 21:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D46C3BA4DF
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 19:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C62980B0;
	Tue, 22 Apr 2025 19:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Dai9It"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE88B666;
	Tue, 22 Apr 2025 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350163; cv=none; b=ufmv8/gIYYLDOY6ktI5T6aURo976gFBFy4BUPLI/wymRImdNVFqPpxiUTwKC8/3U+jmyXZ7IszzpfKORURvYozs0zEwv/435lx9yKnFF31W0ZKEqJSlVwehQMPHBS9U6sgbOaT0SH6uCB0CLLVSVBHXImzanKxlxATq49V428/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350163; c=relaxed/simple;
	bh=p0kdsvYEYrbvxL3gSgxSwf0Fq5IQ06R5Wh+VNVLqTpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ds2Zmjq4AgqLEtZ0PTscKHjjXffOasrXzbTz1c5caqusrGkgDH2ONih6OOH8SxB5nhOETny5oKqnEu9rvznt2tmre2pS1aE26f7+50OGyegFtzcnwKW7SOhgXd+qgAP5J62wX8Qndn7pHEt1lPOkGzTvC8yBfvHe1G3SCKMZE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/Dai9It; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e8efefec89so51631086d6.3;
        Tue, 22 Apr 2025 12:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745350160; x=1745954960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ndpKGQSvZ0aqLqjETeu44ATYoM5vYBNDUrHip9UxeY=;
        b=i/Dai9ItEWTvWa218QAfvIO/MTOGC1R1Nm89p2ZmX5t/QeCY2nqkfwRUZo8Kzm/M2q
         X0onE5zW/f0RW03Fxg0yr/yhGYFsxYT9VElZdFTbC11cHFYWchqDmTq3wahbZKrJ5BoY
         HiMLCDnJc7xFdEfA0vCtgNGRpPHVASXZeqVdkHzm8jbC2K5rY/Wq3u+vknIKaYBuHZYN
         KS0dL1qzTVMk9FVGrYQU4W7Ud+PPhyP3+EkGvu+RAdR7YRuvyVlh9JR7vT/PmpP4eX08
         SoAridXEFAWxE4XQe/pzlzwqTdAERJ3mJneZ4uAgaMm1K7XuURLuHDuynjXLVXwSgh60
         ArEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745350160; x=1745954960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ndpKGQSvZ0aqLqjETeu44ATYoM5vYBNDUrHip9UxeY=;
        b=xL7/nq1rlX590S6sLJjPFbuKlgy+3QaE7eiC/5FunWixUMjahpOnUQa9wQ8t6+et0c
         rbKLu1igDok1cUSGunzr8vJnprY9+oZuoDCIYTvZYB4pHjvrGVJ3qZ/DlcW8exnbRaoo
         D4X7oIvCslFdhxxZnh7jo3yppr9DPAk6n+ND9YCF4P21eeLkfx/tBDl8zj5X1rVzFggS
         hv3ztQO6io4/lanROFX4d9TKFy9+gTLYqlnSmZkbebU6KZox+0VBLBnOqy/fdc5m778B
         tMA/XBgAUEdjWCAF1ZkcGthC3Cq3GPv0cX8FjW1x6cTHrqtKTv+aWVwIndrI0G1ra2/O
         26iA==
X-Forwarded-Encrypted: i=1; AJvYcCV3p95974t8iVvyx7Om6sdw0vORW03A4KwQGDgYB7UmAE9OihKvVNMvplbcuKQ/a+AOPG4qZPfYBp0=@vger.kernel.org, AJvYcCWQelW82YL4HmTzye9cxLk71H8spWoggzdqI9t6VgnV1D9X5wxhlNqbcfnk7OagzH8yjwxR6qJd@vger.kernel.org, AJvYcCWmaz7sOtyJkwIQWKQRq3qQurqtWfHrOtU6DNvVL3okDqGO8uCU/BxUvOrItyvLSDlZnocFauRYgkeNgDpC@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTwOfiRWCPCgGi3h7i4EXaSeU6WS/ijgc9GxjiBP0Z9Ab0lnB
	/saSa/BnjFgRFSAoUPQYqCjU3ZvTQ89YpZwz/omn3QSWiKbJwkMwR8EEtw1wk20sm84JNPhyptS
	BsRAqfelsl+koI/ObqvpZARuh5o0=
X-Gm-Gg: ASbGncvexMajBw/62BIU3so/ApmH/aJk0wPoJtmM6KBbqRypT1VgC3qNBE4Z7tlTCli
	mjZ6BcKa/ibrsmAV8SChiTMlUoJT88drQbGtYKlUxaNDXul9m9ZyPFBlH6FGPfObs70rn2KqF8n
	wXjdyqkRG24T9F1P6zbYeUTps=
X-Google-Smtp-Source: AGHT+IGkSPCMeFkbaE7r9rhzr8WggAH+kF6OiQcpyNCNspqhZ0ybhXGaBNOVK+jQ3HgCZRgPGQgp1f3RLPGlBD4qBuk=
X-Received: by 2002:a05:6214:20a3:b0:6e4:4484:f354 with SMTP id
 6a1803df08f44-6f2c4671b1cmr334524676d6.38.1745350160485; Tue, 22 Apr 2025
 12:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407234223.1059191-1-nphamcs@gmail.com> <6807afd0.a70a0220.2ae8b9.e07cSMTPIN_ADDED_BROKEN@mx.google.com>
 <CAKEwX=NQyDqNBoS2kPePZO1iTkt88MgrtEKexxu7uLhaeA6rsQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NQyDqNBoS2kPePZO1iTkt88MgrtEKexxu7uLhaeA6rsQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 22 Apr 2025 12:29:08 -0700
X-Gm-Features: ATxdqUF5O_YtzRFDfeJ1JbJJt-RugNOBNDCB-M-afZovyBAPOYL5Iv1Eurn4SUU
Message-ID: <CAKEwX=OBC3n-+hPXGnpoZChCqjtQUt-nbBrjj0kRqsCdTcqghA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com, 
	chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org, 
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com, viro@zeniv.linux.org.uk, 
	baohua@kernel.org, osalvador@suse.de, lorenzo.stoakes@oracle.com, 
	christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 10:15=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Apr 22, 2025 at 8:03=E2=80=AFAM Yosry Ahmed <yosry.ahmed@linux.de=
v> wrote:
> >
> > On Mon, Apr 07, 2025 at 04:42:01PM -0700, Nhat Pham wrote:
> > It's exciting to see this proposal materilizing :)
> >
> > I didn't get a chance to look too closely at the code, but I have a few
> > high-level comments.
> >
> > Do we need separate refcnt and swap_count? I am aware that there are
> > cases where we need to hold a reference to prevent the descriptor from
> > going away, without an extra page table entry referencing the swap
> > descriptor -- but I am wondering if we can get away by just incrementin=
g
> > the swap count in these cases too? Would this mess things up?
>
> Actually, you're right - we might not even need a separate refcnt
> field at all :) Here's my original thought process:
>
> 1. We need something that keeps the virtual swap slot and its metadata
> data structure (the swap descriptor) valid while we work with it.
>
> 2. In the old design, this is all stored at the swap device, so we
> need to obtain a reference to the swap device itself.
>
> 3. In the new design, this is no longer even possible. The backend
> might change under us even! So the refcnting needs to be done at the
> virtual swap level.
>
> 3. The refcnting needs to be separate from the swap count field,
> because certain operations/optimizations do check for the actual swap
> count, and incrementing the swap count willy nilly like that might
> accidentally throw these off. Think readahead-induced swap reads, for
> example. So I need a separate refcnt field that takes into account 3
> sources: PTE references (swap count), swap cache, and "ephemeral" (i.e
> temporary) references, that replace the role of the swap device
> reference in the old design.
>
> However, I have thought more about it. I don't think I need to obtain
> any ephemeral reference. I do need a refcnting mechanism, but one
> atomic field (that stores both the swap count and swap cache pin)
> should suffice.
>
> Refcnt + RCU should already guarantee the existence of the swap
> descriptor while I work with it. So there won't be any UAF issue, as
> long as I am disciplined and check if the swap descriptor still exists
> etc. in the virtual swap implementation, which I already am doing
> anyway.
>
> This should be safe enough, even in the face of swapoff, because
> swapoff also relies on the same reference counting mechanism to free
> the virtual swap slot and its descriptor. It tries to swap_free() the
> virtual swap slot, as it unmaps the virtual swap slot from the page
> table entry, which will decrement the swap count. So we're all good on
> this front.
>
> We DO need to obtain a reference to the swap device in certain places
> though, if we want to use it down the line for some sort of
> optimizations (for example, to look at its swap device flags to check
> if it is a SWP_SYNCHRONOUS_IO device - see do_swap_page()). But this
> is a separate matter.
>
> The end result is I will reduce 4 fields:
>
> 1. swp_entry_t vswap
> 2. atomic_t in_swapcache
> 3. atomic_t swap_count
> 4. struct kref kref;
>
> Into a single swap_refs field.
>
>
> >
> > >
> > > This design allows us to:
> > > * Decouple zswap (and zeromapped swap entry) from backing swapfile:
> > >   simply associate the virtual swap slot with one of the supported
> > >   backends: a zswap entry, a zero-filled swap page, a slot on the
> > >   swapfile, or an in-memory page .
> > > * Simplify and optimize swapoff: we only have to fault the page in an=
d
> > >   have the virtual swap slot points to the page instead of the on-dis=
k
> > >   physical swap slot. No need to perform any page table walking.
> > >
> > > Please see the attached patches for implementation details.
> > >
> > > Note that I do not remove the old implementation for now. Users can
> > > select between the old and the new implementation via the
> > > CONFIG_VIRTUAL_SWAP build config. This will also allow us to land the
> > > new design, and iteratively optimize upon it (without having to inclu=
de
> > > everything in an even more massive patch series).
> >
> > I know this is easier, but honestly I'd prefer if we do an incremental
> > replacement (if possible) rather than introducing a new implementation
> > and slowly deprecating the old one, which historically doesn't seem to
> > go well :P
>
> I know, I know :P
>
> >
> > Once the series is organized as Johannes suggested, and we have better
> > insights into how this will be integrated with Kairui's work, it should
> > be clearer whether it's possible to incrementally update the current
> > implemetation rather than add a parallel implementation.
>
> Will take a look at Kairui's work when it's available :)
>
> >
> > >
> > > III. Future Use Cases
> > >
> > > Other than decoupling swap backends and optimizing swapoff, this new
> > > design allows us to implement the following more easily and
> > > efficiently:
> > >
> > > * Multi-tier swapping (as mentioned in [5]), with transparent
> > >   transferring (promotion/demotion) of pages across tiers (see [8] an=
d
> > >   [9]). Similar to swapoff, with the old design we would need to
> > >   perform the expensive page table walk.
> > > * Swapfile compaction to alleviate fragmentation (as proposed by Ying
> > >   Huang in [6]).
> > > * Mixed backing THP swapin (see [7]): Once you have pinned down the
> > >   backing store of THPs, then you can dispatch each range of subpages
> > >   to appropriate swapin handle.
> > > * Swapping a folio out with discontiguous physical swap slots (see [1=
0])
> > >
> > >
> > > IV. Potential Issues
> > >
> > > Here is a couple of issues I can think of, along with some potential
> > > solutions:
> > >
> > > 1. Space overhead: we need one swap descriptor per swap entry.
> > > * Note that this overhead is dynamic, i.e only incurred when we actua=
lly
> > >   need to swap a page out.
> > > * It can be further offset by the reduction of swap map and the
> > >   elimination of zeromapped bitmap.
> > >
> > > 2. Lock contention: since the virtual swap space is dynamic/unbounded=
,
> > > we cannot naively range partition it anymore. This can increase lock
> > > contention on swap-related data structures (swap cache, zswap=E2=80=
=99s xarray,
> > > etc.).
> > > * The problem is slightly alleviated by the lockless nature of the ne=
w
> > >   reference counting scheme, as well as the per-entry locking for
> > >   backing store information.
> > > * Johannes suggested that I can implement a dynamic partition scheme,=
 in
> > >   which new partitions (along with associated data structures) are
> > >   allocated on demand. It is one extra layer of indirection, but glob=
al
> > >   locking will only be done only on partition allocation, rather than=
 on
> > >   each access. All other accesses only take local (per-partition)
> > >   locks, or are completely lockless (such as partition lookup).
> > >
> > >
> > > V. Benchmarking
> > >
> > > As a proof of concept, I run the prototype through some simple
> > > benchmarks:
> > >
> > > 1. usemem: 16 threads, 2G each, memory.max =3D 16G
> > >
> > > I benchmarked the following usemem commands:
> > >
> > > time usemem --init-time -w -O -s 10 -n 16 2g
> > >
> > > Baseline:
> > > real: 33.96s
> > > user: 25.31s
> > > sys: 341.09s
> > > average throughput: 111295.45 KB/s
> > > average free time: 2079258.68 usecs
> > >
> > > New Design:
> > > real: 35.87s
> > > user: 25.15s
> > > sys: 373.01s
> > > average throughput: 106965.46 KB/s
> > > average free time: 3192465.62 usecs
> > >
> > > To root cause this regression, I ran perf on the usemem program, as
> > > well as on the following stress-ng program:
> > >
> > > perf record -ag -e cycles -G perf_cg -- ./stress-ng/stress-ng  --page=
swap $(nproc) --pageswap-ops 100000
> > >
> > > and observed the (predicted) increase in lock contention on swap cach=
e
> > > accesses. This regression is alleviated if I put together the
> > > following hack: limit the virtual swap space to a sufficient size for
> > > the benchmark, range partition the swap-related data structures (swap
> > > cache, zswap tree, etc.) based on the limit, and distribute the
> > > allocation of virtual swap slotss among these partitions (on a per-CP=
U
> > > basis):
> > >
> > > real: 34.94s
> > > user: 25.28s
> > > sys: 360.25s
> > > average throughput: 108181.15 KB/s
> > > average free time: 2680890.24 usecs
> > >
> > > As mentioned above, I will implement proper dynamic swap range
> > > partitioning in a follow up work.
> >
> > I thought there would be some improvements with the new design once the
> > lock contention is gone, due to the colocation of all swap metadata. Do
> > we know why this isn't the case?
>
> The lock contention is reduced on access, but increased on allocation
> and free step (because we have to go through a global lock now due to
> the loss of swap space partitioning).
>
> Virtual swap allocation optimization will be the next step, or it can
> be done concurrently, if we can figure out a way to make Kairui's work
> compatible with this.

To clarify a bit - what Kairui's proposal gives us (IIUC) is a dynamic
clustered approach on swap slot allocation. It's already done at the
physical level.

This is precisely what this RFC is missing. So if there is a way to
combine the work, I think it will go a long way in reducing the
regression.

That said, I haven't looked closely at his code yet, so I don't know
how easy/hard it is to combine the efforts :)

