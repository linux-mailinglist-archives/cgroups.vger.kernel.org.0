Return-Path: <cgroups+bounces-8407-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B0ACA06A
	for <lists+cgroups@lfdr.de>; Sun,  1 Jun 2025 23:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F4C3B3B26
	for <lists+cgroups@lfdr.de>; Sun,  1 Jun 2025 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF1623504B;
	Sun,  1 Jun 2025 21:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI1fO+NK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1F2A1CA;
	Sun,  1 Jun 2025 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748812116; cv=none; b=nbyJt6cjbF3+Rv0d3RkMrpjm0VArIvJ0tN4DvMUIOuacKQJheQhv2aM8oVUoKMcjdCXQTMt9IMmDgWAEZ5ATBa63TSGMKmYvjwyYEqiwR7THcUYEYzPJJ668etlgphERiT9mB3uoMrQAUw55nUHgHHQBW4bKb37xsHGdoYSJ0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748812116; c=relaxed/simple;
	bh=+HqRsySLHHpU+vcsNbaQE3x/QwlJPhhRzshUpkjA/mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJyMhhnKsuhJvaB42P+WEAty/RtoInCO8+x8K4Pt3FUlZRGeC9QY7LGPC/58s4wWoC0MO5Vtm0KvWhJoQN7qIPrLjtfyN2nGPRe87nptUIhFPZj5/mG0aZznA0nDF0utXxZzIBDHnlJkbw5TGhcRsoHidFQj54GfcEoa4yPW+IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI1fO+NK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7cadd46ea9aso483671985a.1;
        Sun, 01 Jun 2025 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748812113; x=1749416913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NoP05Qsq2uZudieJiCRentyec71gQ2RU6SK/0NLWW0=;
        b=WI1fO+NK7YW8yVoXpkfemzG3sKkmnMo25SV8VhSINFRmNYyhFV6DnCYHXm20qlylcK
         jLSq7R82LP95J5LfnARFWufkjQUVw/kftZijsNW1qhk3DkuIT6blnecKCy8U/FPIAJVv
         vF5bPUELGER9T2A14R26r65Um7trypYHr3BV9tBeXuVZ0KPgG2Zp3JLmQ6U76ZuqkNc8
         kVoZXSVm34BhyA3N/WNeyHYOXBiUhLmwoPon59PhzBx30FgvNoTbA/xObnkm5l0c3ThJ
         xTNa2YTikEuOrxGebynFEx4NQa79+Y5th7WXPFJUw2HB7dwK/QYwvxqYZ/gxTaKlZB7A
         Z1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748812113; x=1749416913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NoP05Qsq2uZudieJiCRentyec71gQ2RU6SK/0NLWW0=;
        b=plp/b51S6v5Zwb+DeHReurekQAGVeJXs53acaQTKiO3RLqfa1HH2JLbKJjqawqiZEn
         y/bnFIDvRSl8d/RThEh+JcCDBs1bJmNOR2aA10GJuBvmfmj5q8SMfIXWYLpn37BvhWca
         bWH8X35KTFRRSrR2m9Go5rIAvuPKMmTQO7MPb2BbJBtsmHZUB9WTkUmGkzSzvudU2k5T
         V0eBZFl/tQCB41kwBFtJngbud9207QHwtRxxk3pMM9q+bw8NDhwhkCh6GeZwyyUY6lYz
         QqlgjWrt1oo+8UbPuPWR/BrC0kVhv+7vWEeAej2jVyY69G8sKu4argDj2hU2eDkzsCMm
         LBbA==
X-Forwarded-Encrypted: i=1; AJvYcCUdqDzRAexd+bnMe2l8do5WWV06tYeCTkLEmEmxqiJp2G1Xv7jthB7u8NtJaFsuC6+q+ukUU7xppYO4GQo2@vger.kernel.org, AJvYcCVNt/jBeB12NNAeJBcAbzAfvO5kFfMZ3XGvEDvWgkwIisks10uzEvrqXQQpViF9zVNRsP9IYsN+@vger.kernel.org, AJvYcCVmjtlmlT88fMOeCjlI7MgDrTgAsIKXrNecXKbTQFYd4bR7k6yCHsGe0xEcjT7el5CXxkNyBJRgBes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkfyza9xhA47O4xwXPXvS3OPvzGebRxgLokrf/Gyt5snDRj6S
	kVZfLg6eAXTVPZNzdmWmVUR70y2AepYOK2t6ZK8VUfE22MDATXQsbGvW+pg3tM9mF/x4LEbRjqn
	aFO8HzkgAFP16Cz/l8p8grkNJHkwKmvM=
X-Gm-Gg: ASbGncuG7AR9qolTGFWBxs3IW9DdypTYbL14CtjdolNqp7vWwqwJWhrqukRGwpRF91A
	RTCZYrtuBrXqQmOGQT0FTeZapcdPB4t9UKnkDV74slrwPkeLNtFV5zyLXXiTr46Rc+iq6/bW4DL
	Z/lsyr7Hv9I/ULyX97nm27k2JcKRNAyXSBPA==
X-Google-Smtp-Source: AGHT+IHxlNiEI48RrXYIzjtR+5FeE3qMDaF/VMFFLOZ37w2QgHT7hJKBRJx5ce9frjNKjtzDZPYHRGlUZGA6Q/zDpDE=
X-Received: by 2002:a05:620a:2a01:b0:7c7:827b:46bf with SMTP id
 af79cd13be357-7d0a4e3cc82mr1374737285a.39.1748812113011; Sun, 01 Jun 2025
 14:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429233848.3093350-1-nphamcs@gmail.com> <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
 <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com> <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330>
In-Reply-To: <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 1 Jun 2025 14:08:22 -0700
X-Gm-Features: AX0GCFtF6d0uXcv46vS-wy8bPQYtvuz0ynLLrUw6yssIOl32RhKsTE62_m874IM
Message-ID: <CAKEwX=NFrWyFkyd5XhXEb_qYtWBk4yPUMPPJN0qHPAvzPUq_Dg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, yosry.ahmed@linux.dev, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	len.brown@intel.com, chengming.zhou@linux.dev, kasong@tencent.com, 
	chrisl@kernel.org, huang.ying.caritas@gmail.com, ryan.roberts@arm.com, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de, 
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu, pavel@kernel.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-pm@vger.kernel.org, peterx@redhat.com, gunho.lee@lge.com, 
	taejoon.song@lge.com, iamjoonsoo.kim@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 5:56=E2=80=AFAM YoungJun Park <youngjun.park@lge.com=
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

Hmm, that can be a start. Right now, we have only 2 swap tiers
essentially, so memory.(z)swap.max and memory.zswap.writeback is
usually sufficient to describe the tiering interface. But if you have
an alternative use case in mind feel free to send a RFC to explore
this!

>
> We=E2=80=99ve explored several approaches and PoCs around this,
> and in the process of evaluating
> whether our direction could eventually be aligned
> with the upstream kernel,
> I came across your patchset and wanted to ask whether
> similar efforts have been discussed or attempted before.

I think it is occasionally touched upon in discussion, but AFAICS
there has not been really an actual upstream patch to add such an
interface.

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

Which less optimized form are you thinking of?

>
> > the physical swap location in PTEs means that changing the swap
> > backend requires a full page table walk to update all the PTEs that
> > refer to the old physical swap location. So you have to pick your
> > poison - either:
> > 1. Pick your backend at swap out time, and never change it. You might
> > not have sufficient information to decide at that time. It prevents
> > you from adapting to the change in workload dynamics and working set -
> > the access frequency of pages might change, so their physical location
> > should change accordingly.
> >
> > 2. Reserve the space in every tier, and associate them with the same
> > handle. This is kinda what zswap is doing. It is space efficient, and
> > create a lot of operational issues in production.
> >
> > 3. Bite the bullet and perform the page table walk. This is what
> > swapoff is doing, basically. Raise your hands if you're excited about
> > a full page table walk every time you want to evict a page from zswap
> > to disk swap. Booo.
> >
> > This new design will give us an efficient way to perform tier transfer
> > - you need to figure out how to obtain the right to perform the
> > transfer (for now, through the swap cache - but you can perhaps
> > envision some sort of locks), and then you can simply make the change
> > at the virtual layer.
> >
>
> One idea that comes to mind is whether the backend swap tier for
> a page could be lazily adjusted at runtime=E2=80=94either reactively
> or via an explicit interface=E2=80=94before the tier changes.
> Alternatively, if it's preferable to leave pages untouched
> when the tier configuration changes at runtime,
> perhaps we could consider making this behavior configurable as well.
>

I don't quite understand - could you expand on this?

