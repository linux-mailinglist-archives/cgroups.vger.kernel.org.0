Return-Path: <cgroups+bounces-8397-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAC2AC93FB
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 18:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC6817FC22
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 16:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A007422FE10;
	Fri, 30 May 2025 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdKEqozp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1A1DC075;
	Fri, 30 May 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623977; cv=none; b=mv2kXFbskZsST4V2nJhZ+Vm3DjLwWqy61SHGdIp9HOkolbnfK14LRBl3BmSzBftDOO3fJaS/VLbkoG1b38ZR8F48gKKh+YLVd8C2p4scJROUYNdsJeN8BgF7PovyAEiobpIU+vtDt8RGkPTqBFu7hdyTjzQ6Ir5znrYtC3lN2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623977; c=relaxed/simple;
	bh=9LVFN+EyjgnLAEk+R9OrUHQ0xryx4vozSIoV9ziH0Pc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTcpI70mVJf/VPbqZ4NJtyZtBTGdy4SLgsd2dtk8JOx8q5xMeV2RBgPw8gZCSnSihQI+nrIOWRhs4ci/Emks91DLqUsuzMzTd95gvgX9G1pERVak0O07HVtonw2+1NSCK3MKlpk7zuzEUPsssUzlkUYGypJ6HLiwPeOYHctsAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdKEqozp; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6face367320so14161046d6.3;
        Fri, 30 May 2025 09:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748623973; x=1749228773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6ceonNyxc//yae0QTPj5bc1vLf7f1njr9qW4dTFnws=;
        b=EdKEqozp4njBrTmecsueD2tlCqrujwWO5XMB6P3nCjrA8EWOCbZC11/WvBylPC09aN
         ckVUY8RgxpICdduuLBzaCduhZ04BJJrf5h3qzWkaW1cnT+3y3O+dRCPhLQi0ywbB9M/e
         cjJPEYKGK2kht7En0bNzAsFMU2wV6AooIdxfj2/p5ZztfLdfwN9pBBpCNhjG31Tt0GWN
         +2OxCbG8XmJh8s5lESiI3uCMeBQrxg8aLwP5fD5q2eOfbRGStqyAZa5Oi2r03omcDqMd
         0HcT8OnJHx6Xl7VVb/Hrjh8c0x+vpp6hntQ4mWMbncQ2PrGQoiKJsP3xhXY5/conJEGF
         zq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748623973; x=1749228773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6ceonNyxc//yae0QTPj5bc1vLf7f1njr9qW4dTFnws=;
        b=lLM0ZyL/F7UXR2HjSaqOzQJA6KkpuWdWsFY3ooYrujjAHGVAyws8PV1E0ioGJWVySG
         19+LyAIutPxa4CZl087SJql9m4dM2s6iy7y6JX0+gTi5e/xd3ILdzlwYoDZXCtO4Bgbm
         XDVoL+FzW+HKQYXOy1PaVNRJ9SNDvlJXJ9oz19owG9PaTQK3swCDMSi1ILhdo8Fclj5d
         f/rx6IlU38AQsy+f2apxAuT86vzeAgccBkx5cwGAYlDMrEfUp0J4V8c+VzKJwTBviQQM
         G62JYubxPbeHTgIrq7TLT1KnxDT6/atbXbJMiIXF8MAmPkZnw18fpQ3nZyHklKntzwIa
         ODow==
X-Forwarded-Encrypted: i=1; AJvYcCUoVyxsXRFId4ENZkRYwpk4gXzn8z7SWsQ7v0yvz3ySdobaXRxdAEzd7zZS/F7SdiEZVMe/S1+WvLEwP0el@vger.kernel.org, AJvYcCWZ+I25+YmMY8Pb9InV7PNsm1KXpbj8Hw7IF9K0p6WW8PS2/PseLWjadeIAKJHqZLI0K5dDzzir@vger.kernel.org, AJvYcCXjGDVfseGrYnowvzDbgGxLAvQwduWjAXoQuFmjO3tVpIRyhadA/rfWPRtAlqivEgTl5D8Wa6bZ6TU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSLF/JX+j6O3mZH/jr+3RNFBt/66MormyQnSIAggJajTyCgIJ
	f2phlFkjZbH1BdtIwWWrd6J0PD94Tw+gxVzkFW6gCOE48guwJQi1kFYlVkc4ieqmQkbnBScojhI
	1vF3pm9lDHfI4r2Ph2qQnOYnOHF52DME=
X-Gm-Gg: ASbGncvO7Yxgt4aNUgrkPjRqXCZZvccceP7x7Mnq4MKSVMDilxwMlxcK0LcCHXOuKx0
	wxFyKzasISaD9k0vFN9qKZ6P7QD4xVcsWd41nIwPh2q9FS4tQzG7A03RQ6rYfM9eDYjsFeN4jq2
	0Bcf5QI8ncYhHK2jdDj6cAMyyOQ1oV12kUrsm0RxdW5MGC
X-Google-Smtp-Source: AGHT+IHoTU8m4OB7wecTn9blPTc4VRTJ944sSaekMzsq1udHX0CGv9f8K0w3JZqp7Phzxa8vH39KHZr9pZZW9bpjbZA=
X-Received: by 2002:a05:6214:300b:b0:6fa:ce87:2302 with SMTP id
 6a1803df08f44-6fad1ac72acmr41551796d6.40.1748623973310; Fri, 30 May 2025
 09:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429233848.3093350-1-nphamcs@gmail.com> <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
In-Reply-To: <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 30 May 2025 09:52:42 -0700
X-Gm-Features: AX0GCFtz4cKX2BeWIy2JZWlB5tliwPvoCYexZVuGP618T9LnyL05hYBxApuOXM0
Message-ID: <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>
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

On Thu, May 29, 2025 at 11:47=E2=80=AFPM YoungJun Park <youngjun.park@lge.c=
om> wrote:
>
> On Tue, Apr 29, 2025 at 04:38:28PM -0700, Nhat Pham wrote:
> > Changelog:
> > * v2:
> >       * Use a single atomic type (swap_refs) for reference counting
> >         purpose. This brings the size of the swap descriptor from 64 KB
> >         down to 48 KB (25% reduction). Suggested by Yosry Ahmed.
> >       * Zeromap bitmap is removed in the virtual swap implementation.
> >         This saves one bit per phyiscal swapfile slot.
> >       * Rearrange the patches and the code change to make things more
> >         reviewable. Suggested by Johannes Weiner.
> >       * Update the cover letter a bit.
>
> Hi Nhat,
>
> Thank you for sharing this patch series.
> I=E2=80=99ve read through it with great interest.
>
> I=E2=80=99m part of a kernel team working on features related to multi-ti=
er swapping,
> and this patch set appears quite relevant
> to our ongoing discussions and early-stage implementation.

May I ask - what's the use case you're thinking of here? Remote swapping?

>
> I had a couple of questions regarding the future direction.
>
> > * Multi-tier swapping (as mentioned in [5]), with transparent
> >   transferring (promotion/demotion) of pages across tiers (see [8] and
> >   [9]). Similar to swapoff, with the old design we would need to
> >   perform the expensive page table walk.
>
> Based on the discussion in [5], it seems there was some exploration
> around enabling per-cgroup selection of multiple tiers.
> Do you envision the current design evolving in a similar direction
> to those past discussions, or is there a different direction you're aimin=
g for?

IIRC, that past design focused on the interface aspect of the problem,
but never actually touched the mechanism to implement a multi-tier
swapping solution.

The simple reason is it's impossible, or at least highly inefficient
to do it in the current design, i.e without virtualizing swap. Storing
the physical swap location in PTEs means that changing the swap
backend requires a full page table walk to update all the PTEs that
refer to the old physical swap location. So you have to pick your
poison - either:

1. Pick your backend at swap out time, and never change it. You might
not have sufficient information to decide at that time. It prevents
you from adapting to the change in workload dynamics and working set -
the access frequency of pages might change, so their physical location
should change accordingly.

2. Reserve the space in every tier, and associate them with the same
handle. This is kinda what zswap is doing. It is space efficient, and
create a lot of operational issues in production.

3. Bite the bullet and perform the page table walk. This is what
swapoff is doing, basically. Raise your hands if you're excited about
a full page table walk every time you want to evict a page from zswap
to disk swap. Booo.

This new design will give us an efficient way to perform tier transfer
- you need to figure out how to obtain the right to perform the
transfer (for now, through the swap cache - but you can perhaps
envision some sort of locks), and then you can simply make the change
at the virtual layer.

>
> >   This idea is very similar to Kairui's work to optimize the (physical)
> >   swap allocator. He is currently also working on a swap redesign (see
> >   [11]) - perhaps we can combine the two efforts to take advantage of
> >   the swap allocator's efficiency for virtual swap.
>
> I noticed that your patch appears to be aligned with the work from Kairui=
.
> It seems like the overall architecture may be headed toward introducing
> a virtual swap device layer.
> I'm curious if there=E2=80=99s already been any concrete discussion
> around this abstraction, especially regarding how it might be layered ove=
r
> multiple physical swap devices?
>
> From a naive perspective, I imagine that while today=E2=80=99s swap devic=
es
> are in a 1:1 mapping with physical devices,
> this virtual layer could introduce a 1:N relationship =E2=80=94
> one virtual swap device mapped to multiple physical ones.
> Would this virtual device behave as a new swappable block device
> exposed via `swapon`, or is the plan to abstract it differently?

That was one of the ideas I was thinking of. Problem is this is a very
special "device", and I'm not entirely sure opting in through swapon
like that won't cause issues. Imagine the following scenario:

1. We swap on a normal swapfile.

2. Users swap things with the swapfile.

2. Sysadmin then swapon a virtual swap device.

It will be quite nightmarish to manage things - we need to be extra
vigilant in handling a physical swap slot for e.g, since it can back a
PTE or a virtual swap slot. Also, swapoff becomes less efficient
again. And the physical swap allocator, even with the swap table
change, doesn't quite work out of the box for virtual swap yet (see
[1]).

I think it's better to just keep it separate, for now, and adopt
elements from Kairui's work to make virtual swap allocation more
efficient. Not a hill I will die on though,

[1]: https://lore.kernel.org/linux-mm/CAKEwX=3DMmD___ukRrx=3DhLo7d_m1J_uG_K=
e+us7RQgFUV2OSg38w@mail.gmail.com/

>
> Thanks again for your work,
> and I would greatly appreciate any insights you could share.
>
> Best regards,
> YoungJun Park
>

