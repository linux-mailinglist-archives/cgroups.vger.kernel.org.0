Return-Path: <cgroups+bounces-8405-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEC6AC9F51
	for <lists+cgroups@lfdr.de>; Sun,  1 Jun 2025 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8903AF957
	for <lists+cgroups@lfdr.de>; Sun,  1 Jun 2025 16:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60543FBA7;
	Sun,  1 Jun 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU5XQkn5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23A313FEE;
	Sun,  1 Jun 2025 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748794514; cv=none; b=A4aEHXp/VEcon3CE4vQYCtUZfn8vSheHmBlKTjYwCySfHGjS9OO7OdWY86x2akrv6slaUBEmQ8x0OmpNEGKCdZR1CLl4x6O3rF6f0L8f4OkFCwuPfY0IlvPC/EI3f3qBCtuPm7o0p6ykcXIaiLbbraWJGi0vZ4FVf1+MHmx5Ijk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748794514; c=relaxed/simple;
	bh=KLOX1Mr30pVxSDaB7Az1cYWafL+qmfSKTpjIPEvx8dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m0n3978yi1HE/Ioh6Oqc8k25bOxQPJn7FipsQkkXTKd27E5BL0o4/3HnZ9nPaFLvVCW88nPVZRbaO+wNd2+/OyBvsMpsMemeMWb1a9JQ6BEqGoKwtULnF0ik6wwRst5bk8eVHPA9SSHpMppR9g3bZSycDbDGn1/HWWmGv1TCZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU5XQkn5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54998f865b8so3453640e87.3;
        Sun, 01 Jun 2025 09:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748794511; x=1749399311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQLlsESJhJ9phvmdcgMlXF4zsR1S6bxe/CuZiRC6mSU=;
        b=MU5XQkn5137vGbmOhH9DZ186dUyYSqUeTVd7G42LgSk4KogJltFDw4SclJlIvb+jKE
         L8aY5NK2lef7pk19+Jw2rIQSYZq2W89aGAo88Hl7NBo1c2pPhMdEurDV0MPerNsSjQ+a
         hQHes4xCrBUdDcbMYpNkTbJm9vGjmBR/qrcBH92SEt7S24phtnlSSw18/4Lsa72Yov27
         zA7/VBtc6rjTvubx00hCrico8R0W5ryGlTbu4Lx8EStz5xWuCznAA0ZulrKLx+OAdBEJ
         37bni1iXwDNYtIpIZHkYKpJelTSD4J86yeFG6dwZqpKDzp0rm/B1nbCMgroRQgc39pDI
         v5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748794511; x=1749399311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQLlsESJhJ9phvmdcgMlXF4zsR1S6bxe/CuZiRC6mSU=;
        b=eYmhBabfP1XMPIjtu2NM10pcJq9unJdRnyp3WIQkqGDs/qHp7gk5etnMWrj4SaPugT
         z/YCu+A/Yji7auAS8IMujrN/rsMPzPw767GLSrp196RP40s+GOBy8BmvtS8wUDEBeIYs
         1sHud/uZ8GJR2r/2YbPGuFun4Z5EN3u17cdrKkOTB6oQD1uKZBcR8ubNWjzr6hG9DerT
         QHGVfKMlRKap8VeHwwdnRr/eTaZFQknpUxkQOlqFrgrNdbAuNow8yX0l7mU7Rz+Qd7kB
         EDn97URNecjtuVgaEKDfM8lxxSGDMYsi5e07L265wSnujIaTERoOersye4rFNEBEsAgy
         Fh4w==
X-Forwarded-Encrypted: i=1; AJvYcCUQAYBn2c41+HNsFOB/92a2vFgDSaOjC32bMkq1SgUINaTXBBHr5C1sMNWXEOjSWKRE27gsMMfZUkU=@vger.kernel.org, AJvYcCUb6Ww4+qRoOAFDIcOvMNQj1r2LePiqJzbBgxmG/TnZX8xmVCMvHz8lPYkTO89SCgYyxL8P4KorZYJaldeh@vger.kernel.org, AJvYcCXVOqVjNpZ8cMhOd2q/DPJ5oFnhaXF0QVB47zztT8Go+HkAz3v5TztTGT7wGw8a2f9MARPHQ+/M@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLR9FeaC97gWp++RTUc/7BJith3fAgQ7WiZ2zZuFrM+gKCQGA
	niWa1H5wRvnR5bBOmpKsSZ8FPlIrWWXZbXIlWRZZIBBuR4LKwXb2YHLsjUas76hvbaFTKV7G6T3
	8hx7mLkLNHE82vZ8p+7zmAJTmf2y9SOo=
X-Gm-Gg: ASbGnctDkvzYcHwD3QesSsBnQZ1m7dxpBWoRuBKa3hKMj9nXaxjRAJtOMrd/miglJSK
	aMZLZpynFQi9P6Q01zhs2U7YlpF3djvpWmdj3Tr9vHlRXeuxXlO8scX/StjHoan9j1b4uzJ47kS
	7+VdNNsi8nqU2PmxRaXW3PB/MD1vd4NmD+
X-Google-Smtp-Source: AGHT+IFdNhy2OZy82mzQxOlElki1qxGmIReqhiVsDHY2TVJeYmZBRjoft38OuNAc5iyG6X6hJ5HmYmaoQCVQzNX+scI=
X-Received: by 2002:a2e:9fc6:0:b0:32a:83b4:c146 with SMTP id
 38308e7fff4ca-32a8cd82a84mr43124451fa.23.1748794510443; Sun, 01 Jun 2025
 09:15:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429233848.3093350-1-nphamcs@gmail.com> <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
 <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com> <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330>
In-Reply-To: <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 2 Jun 2025 00:14:53 +0800
X-Gm-Features: AX0GCFtnVy1VaJBUnuhMS87vlYylrf1kWOEgnTUuEyzfo5tKbsO2Uz34wY5JsL4
Message-ID: <CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBkiwFHgy9uMk-F8Y-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
To: YoungJun Park <youngjun.park@lge.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, yosry.ahmed@linux.dev, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev, 
	muchun.song@linux.dev, len.brown@intel.com, chengming.zhou@linux.dev, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de, 
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu, pavel@kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, gunho.lee@lge.com, 
	taejoon.song@lge.com, iamjoonsoo.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:56=E2=80=AFPM YoungJun Park <youngjun.park@lge.com=
> wrote:
>
> On Fri, May 30, 2025 at 09:52:42AM -0700, Nhat Pham wrote:
> > On Thu, May 29, 2025 at 11:47=E2=80=AFPM YoungJun Park <youngjun.park@l=
ge.com> wrote:
> > >
> > > On Tue, Apr 29, 2025 at 04:38:28PM -0700, Nhat Pham wrote:
> > > > Changelog:
> > > > * v2:
> > > >       * Use a single atomic type (swap_refs) for reference counting
> > > >         purpose. This brings the size of the swap descriptor from 6=
4 KB
> > > >         down to 48 KB (25% reduction). Suggested by Yosry Ahmed.
> > > >       * Zeromap bitmap is removed in the virtual swap implementatio=
n.
> > > >         This saves one bit per phyiscal swapfile slot.
> > > >       * Rearrange the patches and the code change to make things mo=
re
> > > >         reviewable. Suggested by Johannes Weiner.
> > > >       * Update the cover letter a bit.
> > >
> > > Hi Nhat,
> > >
> > > Thank you for sharing this patch series.
> > > I=E2=80=99ve read through it with great interest.
> > >
> > > I=E2=80=99m part of a kernel team working on features related to mult=
i-tier swapping,
> > > and this patch set appears quite relevant
> > > to our ongoing discussions and early-stage implementation.
> >
> > May I ask - what's the use case you're thinking of here? Remote swappin=
g?
> >
>
> Yes, that's correct.
> Our usage scenario includes remote swap,
> and we're experimenting with assigning swap tiers per cgroup
> in order to improve specific scene of our target device performance.
>
> We=E2=80=99ve explored several approaches and PoCs around this,
> and in the process of evaluating
> whether our direction could eventually be aligned
> with the upstream kernel,
> I came across your patchset and wanted to ask whether
> similar efforts have been discussed or attempted before.
>
> > >
> > > I had a couple of questions regarding the future direction.
> > >
> > > > * Multi-tier swapping (as mentioned in [5]), with transparent
> > > >   transferring (promotion/demotion) of pages across tiers (see [8] =
and
> > > >   [9]). Similar to swapoff, with the old design we would need to
> > > >   perform the expensive page table walk.
> > >
> > > Based on the discussion in [5], it seems there was some exploration
> > > around enabling per-cgroup selection of multiple tiers.
> > > Do you envision the current design evolving in a similar direction
> > > to those past discussions, or is there a different direction you're a=
iming for?
> >
> > IIRC, that past design focused on the interface aspect of the problem,
> > but never actually touched the mechanism to implement a multi-tier
> > swapping solution.
> >
> > The simple reason is it's impossible, or at least highly inefficient
> > to do it in the current design, i.e without virtualizing swap. Storing
>
> As you pointed out, there are certainly inefficiencies
> in supporting this use case with the current design,
> but if there is a valid use case,
> I believe there=E2=80=99s room for it to be supported in the current mode=
l
> =E2=80=94possibly in a less optimized form=E2=80=94
> until a virtual swap device becomes available
> and provides a more efficient solution.
> What do you think about?

Hi All,

I'd like to share some info from my side. Currently we have an
internal solution for multi tier swap, implemented based on ZRAM and
writeback: 4 compression level and multiple block layer level. The
ZRAM table serves a similar role to the swap table in the "swap table
series" or the virtual layer here.

We hacked the BIO layer to let ZRAM be Cgroup aware, so it even
supports per-cgroup priority, and per-cgroup writeback control, and it
worked perfectly fine in production.

The interface looks something like this:
/sys/fs/cgroup/cg1/zram.prio: [1-4]
/sys/fs/cgroup/cg1/zram.writeback_prio [1-4]
/sys/fs/cgroup/cg1/zram.writeback_size [0 - 4K]

It's really nothing fancy and complex, the four priority is simply the
four ZRAM compression streams that's already in upstream, and you can
simply hardcode four *bdev in "struct zram" and reuse the bits, then
chain the write bio with new underlayer bio... Getting the priority
info of a cgroup is even simpler once ZRAM is cgroup aware.

All interfaces can be adjusted dynamically at any time (e.g. by an
agent), and already swapped out pages won't be touched. The block
devices are specified in ZRAM's sys files during swapon.

It's easy to implement, but not a good idea for upstream at all:
redundant layers, and performance is bad (if not optimized):
- it breaks SYNCHRONIZE_IO, causing a huge slowdown, so we removed the
SYNCHRONIZE_IO completely which actually improved the performance in
every aspect (I've been trying to upstream this for a while);
- ZRAM's block device allocator is just not good (just a bitmap) so we
want to use the SWAP allocator directly (which I'm also trying to
upstream with the swap table series);
- And many other bits and pieces like bio batching are kind of broken,
busy loop due to the ZRAM_WB bit, etc...
- Lacking support for things like effective migration/compaction,
doable but looks horrible.

So I definitely don't like this band-aid solution, but hey, it works.
I'm looking forward to replacing it with native upstream support.
That's one of the motivations behind the swap table series, which
I think it would resolve the problems in an elegant and clean way
upstreamly. The initial tests do show it has a much lower overhead
and cleans up SWAP.

But maybe this is kind of similar to the "less optimized form" you
are talking about? As I mentioned I'm already trying to upstream
some nice parts of it, and hopefully replace it with an upstream
solution finally.

I can try upstream other parts of it if there are people really
interested, but I strongly recommend that we should focus on the
right approach instead and not waste time on that and spam the
mail list.

I have no special preference on how the final upstream interface
should look like. But currently SWAP devices already have priorities,
so maybe we should just make use of that.

