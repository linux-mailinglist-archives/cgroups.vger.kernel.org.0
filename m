Return-Path: <cgroups+bounces-11995-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 427AAC607C1
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 16:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9E5735BB40
	for <lists+cgroups@lfdr.de>; Sat, 15 Nov 2025 15:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C629B789;
	Sat, 15 Nov 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIRNEOYD"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701E155326
	for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763219641; cv=none; b=tJ7eRjk8taOf4UQ+SU+1FVUy3PQGwcwCJ610GLlWH2b9+bEv3mOUbq0idAeoOvk/8eI6L4TnciTl4LNoECEkl2ivBzwQ8S8H/0NnjTsJuOKobaxWpk/8FXQHmpEX70uhDtt/hlKPoOtGHPWSIkULnETzS7nhpLezXuuW9ybc4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763219641; c=relaxed/simple;
	bh=/Po9rhXBcisyw1Z/KeQrWHbPXqjNgSyu9tnQaTBxNec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HauntL7M2t2KwOBIFOrWLOM2ZwcE6AiIq+F+Mrdb5rXdAywGAga4BS5tvQMcs9K1aNQ+qpIia4px2KfeGs4mzFOHg4S+DbgUNcCgf459qTAL+as3r6a3M2Dwr/ve7CjJBu/6N3PvIlYEPV7+D4PY3Kogc7++7iIhSUI/ahYONFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIRNEOYD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A90C4AF09
	for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763219640;
	bh=/Po9rhXBcisyw1Z/KeQrWHbPXqjNgSyu9tnQaTBxNec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZIRNEOYDlISacP3LRzj/bJSfFlw+UdHvbtM4kqx8z4Q0dl60KUY44cmihU4is8mYl
	 3XDj0vOX1F78A9NfmioA38+NAm+Ovvb/IXBWJA70kpq290PMPpKBvOnstbXf5I6GDy
	 sRFy34MsLjQWxi1y7ZA5ZqYYqqW9A5UkXkt8/2rNpHUnxtcMsQHNm3QJzk4V4PPi78
	 zMRjEhPhWGaQi+At5kKXY5uClp0WKsi1Dy4eBgErJ9j9N0BhEziXA2RP9PKdUkVlb2
	 6BWcpOtmAZwFFBgNztjWzSMD5Uc/21ls2uzP8VxqD9SROFH2ncwiiPi9nfOjixHI/G
	 vRiXMSu2Ii6Tg==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-787e7aa1631so42105997b3.1
        for <cgroups@vger.kernel.org>; Sat, 15 Nov 2025 07:14:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcTmtVVEGZ2WvUkuik6ccrD2HIF/b08w65M+W2thQLPb3yF5QgGOH99n6ys35YYWqVDRgo1lYo@vger.kernel.org
X-Gm-Message-State: AOJu0YwoanXU/Nn/G8aSk3YXxMx6cPzk1V1mtcKHFnK1V+gz4ACmcntZ
	LxcmDSllYPNzK59y9UZzOgrBPQsLhkgjUMDg/suZ6QqRqSiqJp/KO2rEazHWW/2Rhc6QqIv7Yfl
	vPIw6eLQaN54HqLgsyV1UPKsxV8QFnhXhpPN6TdLI8w==
X-Google-Smtp-Source: AGHT+IH1JnpV5QKEs/WPjJU+XSrEnxlODjDSrdDJ/I+MeluASZGuG3v0xBn9frSM87UKfnLcK7THvuciP15/1mEzvps=
X-Received: by 2002:a05:690e:1289:b0:63f:b988:4a91 with SMTP id
 956f58d0204a3-6410d1387f1mr8288888d50.24.1763219639903; Sat, 15 Nov 2025
 07:13:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109124947.1101520-1-youngjun.park@lge.com> <20251115012247.78999-1-sj@kernel.org>
In-Reply-To: <20251115012247.78999-1-sj@kernel.org>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 15 Nov 2025 07:13:49 -0800
X-Gmail-Original-Message-ID: <CACePvbUBEQsgoei=ykeM6uX_GWaFywZEXY7dGt+T6Pt4zhiGsA@mail.gmail.com>
X-Gm-Features: AWmQ_bmkrQnsLWN6zZqLHzRrez2-Aopu9cRG6qIT8b5U9CsZP5z3d3-jlWOzyqQ
Message-ID: <CACePvbUBEQsgoei=ykeM6uX_GWaFywZEXY7dGt+T6Pt4zhiGsA@mail.gmail.com>
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

On Fri, Nov 14, 2025 at 5:22=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote=
:
>
> On Sun,  9 Nov 2025 21:49:44 +0900 Youngjun Park <youngjun.park@lge.com> =
wrote:
>
> > Hi all,
> >
> > In constrained environments, there is a need to improve workload
> > performance by controlling swap device usage on a per-process or
> > per-cgroup basis. For example, one might want to direct critical
> > processes to faster swap devices (like SSDs) while relegating
> > less critical ones to slower devices (like HDDs or Network Swap).
> >
> > Initial approach was to introduce a per-cgroup swap priority
> > mechanism [1]. However, through review and discussion, several
> > drawbacks were identified:
> >
> > a. There is a lack of concrete use cases for assigning a fine-grained,
> >    unique swap priority to each cgroup.
> > b. The implementation complexity was high relative to the desired
> >    level of control.
> > c. Differing swap priorities between cgroups could lead to LRU
> >    inversion problems.
> >
> > To address these concerns, I propose the "swap tiers" concept,
> > originally suggested by Chris Li [2] and further developed through
> > collaborative discussions. I would like to thank Chris Li and
> > He Baoquan for their invaluable contributions in refining this
> > approach, and Kairui Song, Nhat Pham, and Michal Koutn=C3=BD for their
> > insightful reviews of earlier RFC versions.
>
> I think the tiers concept is a nice abstraction.  I'm also interested in =
how
> the in-kernel control mechanism will deal with tiers management, which is=
 not
> always simple.  I'll try to take a time to read this series thoroughly.  =
Thank
> you for sharing this nice work!

Thank you for your interest. Please keep in mind that this patch
series is RFC. I suspect the current series will go through a lot of
overhaul before it gets merged in. I predict the end result will
likely have less than half of the code resemble what it is in the
series right  now.

> Nevertheless, I'm curious if there is simpler and more flexible ways to a=
chieve
> the goal (control of swap device to use).  For example, extending existin=
g
Simplicity is one of my primary design principles. The current design
is close to the simplest within the design constraints.

> proactive pageout features, such as memory.reclaim, MADV_PAGEOUT or
> DAMOS_PAGEOUT, to let users specify the swap device to use.  Doing such

In my mind that is a later phase. No, per VMA swapfile is not simpler
to use, nor is the API simpler to code. There are much more VMA than
memcg in the system, no even the same magnitude. It is a higher burden
for both user space and kernel to maintain all the per VMA mapping.
The VMA and mmap path is much more complex to hack. Doing it on the
memcg level as the first step is the right approach.

> extension for MADV_PAGEOUT may be challenging, but it might be doable for
> memory.reclaim and DAMOS_PAGEOUT.  Have you considered this kind of optio=
ns?

Yes, as YoungJun points out, that has been considered here, but in a
later phase. Borrow the link in his email here:
https://lore.kernel.org/linux-mm/CACePvbW_Q6O2ppMG35gwj7OHCdbjja3qUCF1T7GFs=
m9VDr2e_g@mail.gmail.com/

Chris

