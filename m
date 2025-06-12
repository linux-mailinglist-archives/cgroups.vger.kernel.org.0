Return-Path: <cgroups+bounces-8509-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E660AD7BFA
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 22:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797331887C3C
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 20:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86B22D661B;
	Thu, 12 Jun 2025 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiHqwQkY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064F710957;
	Thu, 12 Jun 2025 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758902; cv=none; b=gRL5u3vw1aBYLwdUwLP6sTQ9XzGenM1sD/m/ThI1VqXJlCS0c4x6qEq/dk/UnDQjITquuC5OAiCqw6eA1v4OJ3jRwwNAOS+VULLBRWHKltVTFXmbLGi/Mz3sySqDKGkpidjfx/WVykasNIn1tjWWK3oHdAlSq3Kh7Rm88oD6pz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758902; c=relaxed/simple;
	bh=DiHz98Mxk+xvT9nSZ/1QhqW5iHTXOqSdDvRykpRGgyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJ/v1YK5P77iYcyXNXOH3NUhdnTqnw2wJZN24XM7ht/fyMdMk4huY+2XR5CbXbhDxP5v4RZXneyA5ft+2p9nQEaNteeIbJO8UrNTMMsH68zcj2H67fvK7eGHYj+GAtMOCVHgSwnJv6vYPbJO1dI0AisPVrFegRQCtsq4S0K1KKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiHqwQkY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso14413326d6.2;
        Thu, 12 Jun 2025 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758900; x=1750363700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiHz98Mxk+xvT9nSZ/1QhqW5iHTXOqSdDvRykpRGgyc=;
        b=MiHqwQkYTJzFsuTWyTAg7L/2HwUqx+RyLY1TLuUrEp8RueJO7VF+E6b+sjF4slnDie
         +qbOCy1TfqNJCcIspGbBz2yopEmyJW7CDMtDAqZMTTBbf26aUfafaxJrt9cHdCgg5wcm
         dloj/CO7fVz/9ot6jIyZckx7Be3mmGMOgk+iYuvrgMvoaIOchYdXA4CrNAzik7hsFgKA
         tnvIR0IS1gVKNB9nZeUrl/p2vjUyHMikloUtdLjAYvAFOShBXHSTpHcQgF+T9SygvIq9
         lXkZKGg/cJahaxKoOWwNrEcIFWyw9UDa/Srpb4Ty7N7l7yLZa1OKFx2D7kwWKXWA/y3z
         uYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758900; x=1750363700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiHz98Mxk+xvT9nSZ/1QhqW5iHTXOqSdDvRykpRGgyc=;
        b=RHHIlnGvjMwHs9aosz7HxzwvsEeiSfKMpPIirKzA73wKXab+mHx4SqIpAV/js7mHC9
         U8CJIsm9+zMNtJ+wV3OGC6ED1dFyKaa0Ft2zdJJA0iL2R3UkAB96DLWd1/zKPF9Ncz0I
         8jxhwFQpX/i2r+NzSYFarcbBxxS2kR6oQI86MA1q7imuYvZrHeoTwxF09di2WY5iFXq4
         y7+Ot7jlFivLhR4TGHqHbWnDcEl+BdSIhX/tWXFcwylDy/Lln0Q648V0m9Bkt+dlEN9O
         xsbgueBqHz23DRfRONorjeg37RekxWiGmFwyBIM9vrKGch+x4Hy1aNSMqixBQ/cUATkk
         3gNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGj1IRqIZJZAimuvSKgjCHKpHq4ZU9LHjkbLFbupqMFdA3e8QumPI17KzSN9Nhhygtgfm08a4u@vger.kernel.org, AJvYcCV9PonrnMaSIPCHhNAW+g7EU7bQ+p5ymHARwMHG472thtyXf2kqsaEgcF73xJchH5+8NVzUn8oZbFGCSuAs@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4QZ9Oixnh5qdo/4WW3Y/aezDVTd+JRSpDMH0ItaiDcyTUtrPx
	WOHtcggYdB7lAFzDXxI7mNMFo0DEKjbDttg74kEHyRh7fIfOkQrBFIGcDF99DPGxN/nRBz9m+jZ
	DK7t91Gg4/fXalDgll5OrtKbOCaDGJpU=
X-Gm-Gg: ASbGncs4trC1J/beToe2tWgk+RfoqfMUbc+dGPa57yvQaGQ39cFmWCnk/kkMSPIrO5C
	aVkxH3LlXan4lPHu/bg0c4WiHlxkY97NyoeIdhNHadte75DmeH7ciO+0sNxorsVESGkIp3YPdFO
	yax7/EcY24DiwaNe1BfzbTWwmH9QrchSLgjBcCBsCGmwsIalAckoTvh+Ai9gk=
X-Google-Smtp-Source: AGHT+IEgTPBLzBNJnVH9ZaUwKb5JS2x+1tjyT6kY3nP+PXMGesmHoi/z8hyu7vCxT4zfKCaPEPsY83F+n+zgiAUDO1I=
X-Received: by 2002:a05:6214:19e5:b0:6f8:d223:3c32 with SMTP id
 6a1803df08f44-6fb3e59bddemr3411996d6.10.1749758899634; Thu, 12 Jun 2025
 13:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-3-youngjun.park@lge.com> <CAMgjq7BJE9ALFG4N8wb-hdkC+b-8d1+ckXL9D6pbbfgiXfuzPA@mail.gmail.com>
 <CAKEwX=PsGKS5JHqQ-G29Fg8xLssPhM+E-4wV_QakhqrDOsV36g@mail.gmail.com> <CAMgjq7Aq1LW9wFgyQ4oCS5Su23X62S+5ZW_d5OydJj-pp2n21Q@mail.gmail.com>
In-Reply-To: <CAMgjq7Aq1LW9wFgyQ4oCS5Su23X62S+5ZW_d5OydJj-pp2n21Q@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Jun 2025 13:08:08 -0700
X-Gm-Features: AX0GCFstYwQPkydoxcIP3F_wXZqsbH2ZywGwO5bQiBiteJh5tFlf_0yxP0yKGKw
Message-ID: <CAKEwX=PD+P_wugkAJ83ti6YRo4-6QNM7HDFs+KDURVwx2JrnZg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority
 mechansim on swap layer
To: Kairui Song <ryncsn@gmail.com>
Cc: youngjun.park@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shikemeng@huaweicloud.com, bhe@redhat.com, baohua@kernel.org, 
	chrisl@kernel.org, muchun.song@linux.dev, iamjoonsoo.kim@lge.com, 
	taejoon.song@lge.com, gunho.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 11:20=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Fri, Jun 13, 2025 at 1:28=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Thu, Jun 12, 2025 at 4:14=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Thu, Jun 12, 2025 at 6:43=E2=80=AFPM <youngjun.park@lge.com> wrote=
:
> > > >
> > > > From: "youngjun.park" <youngjun.park@lge.com>
> > > >
> > >
> > > Hi, Youngjun,
> > >
> > > Thanks for sharing this series.
> > >
> > > > This patch implements swap device selection and swap on/off propaga=
tion
> > > > when a cgroup-specific swap priority is set.
> > > >
> > > > There is one workaround to this implementation as follows.
> > > > Current per-cpu swap cluster enforces swap device selection based s=
olely
> > > > on CPU locality, overriding the swap cgroup's configured priorities=
.
> > >
> > > I've been thinking about this, we can switch to a per-cgroup-per-cpu
> > > next cluster selector, the problem with current code is that swap
> >
> > What about per-cpu-per-order-per-swap-device :-? Number of swap
> > devices is gonna be smaller than number of cgroups, right?
>
> Hi Nhat,
>
> The problem is per cgroup makes more sense (I was suggested to use
> cgroup level locality at the very beginning of the implementation of
> the allocator in the mail list, but it was hard to do so at that
> time), for container environments, a cgroup is a container that runs
> one type of workload, so it has its own locality. Things like systemd
> also organize different desktop workloads into cgroups. The whole
> point is about cgroup.

Yeah I know what cgroup represents. Which is why I mentioned in the
next paragraph that are still making decisions based per-cgroup - we
just organize the per-cpu cache based on swap devices. This way, two
cgroups with similar/same priority list can share the clusters, for
each swapfile, in each CPU. There will be a lot less duplication and
overhead. And two cgroups with different priority lists won't
interfere with each other, since they'll target different swapfiles.

Unless we want to nudge the swapfiles/clusters to be self-partitioned
among the cgroups? :) IOW, each cluster contains pages mostly from a
single cgroup (with some stranglers mixed in). I suppose that will be
very useful for swap on rotational drives where read contiguity is
imperative, but not sure about other backends :-?

Anyway, no strong opinions to be completely honest :) Was just
throwing out some ideas. Per-cgroup-per-cpu-per-order sounds good to
me too, if it's easy to do.

