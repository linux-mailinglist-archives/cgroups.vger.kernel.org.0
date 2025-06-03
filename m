Return-Path: <cgroups+bounces-8421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E3ACC395
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 11:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EAC18834FD
	for <lists+cgroups@lfdr.de>; Tue,  3 Jun 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AB828151E;
	Tue,  3 Jun 2025 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEVlkqiE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F7664C6;
	Tue,  3 Jun 2025 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748944224; cv=none; b=c4H3n7GUq040sDxzWq7QMgsQBjVHyrpcv+PxzJZNhEZcxA8qZnhAxwk2+MK96U+bksgydmYY191bCP5N/zO1nt6ja+NyvK9uVgatj8cGp2tEkbS11Qm5ivecKQbQvI5peUUJbuWoKeoKfPkP9AgajId6hXnXizkxF0FugN000wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748944224; c=relaxed/simple;
	bh=bfgWS16/oHW3y3qqAgf4oxs16fetKvRUmJSlL6NTq7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcDm8oAjLP4TYDRBEW0GUqVwAUgjVb2F2RLQe3FkbFfIqAsHX+2RkElv8Ym0nju/Mel8CyG8GchX0gjdsFf67r64eX87dpKA6oEpjLdhq5aXBr4nQzn1b0M3D43THmMembj2Sxyk8ihPr/BNmgYpVIFwb+eH8ztu8s954Xc0jx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEVlkqiE; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-32a72e61a3fso67746411fa.0;
        Tue, 03 Jun 2025 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748944221; x=1749549021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfgWS16/oHW3y3qqAgf4oxs16fetKvRUmJSlL6NTq7k=;
        b=MEVlkqiE0Y6J0OppBkHFqVJwpRlAiPSHLpXhG4Y0FBAG5QfZOEjAUeRg/seOZnw+p8
         xAEyW+eEcBdUExZFYQh31NvRSsupxbrsI41m6Ry3WrvMN8DBZEEEpjTEQasc81Q1UXLZ
         xyoty7ORVZKWjHDvBv4oke00EYafXWGpUFvAm6IwoEA78oNb1CWu8gLvsRGpFSCVz62/
         4IShh+E91WnCTIlouOUBcfIfcCxne7qg0jr8MkOuzfVrV3EMQhZNtXJGW2y7m9Xp4afv
         DXq4NlvBOONluL2lIRjDKAFWNdknfZ6Edhe0OvAU4NgBQn1GVEEhqUNZfPFm+1AyMj3B
         S/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748944221; x=1749549021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfgWS16/oHW3y3qqAgf4oxs16fetKvRUmJSlL6NTq7k=;
        b=q/IpQYqtQlbuC9PfcnUNvlwye5leVu6smBwG+yTRe9Bn98RMQoOHy/HC2dawO1qH9N
         yijBc39XmD8EQsTESH6GdlXXkDp2w6TiygAS0ueFbsKT2smBmjthT22ZKU4x1+7pNOye
         e3ydA7cW7ISNq1ZofRVxB7cnBpODt8qEXdEO2suv1w2Rvrw0WVW5I/K0U92AC9VE1mYF
         oVnYrCs3saNmf5mT80pRWSAu8q9TUO0U/+e+HVr+OZnO5BOtO7f2WKA/dInzP7w96CJd
         dDPXcjjo/m/LMVGv2B0eFeUMBbAXhguYVG6UFyYjnT8uBzsOYyYMyvvX/RS3lWFQ8dBn
         Aj1g==
X-Forwarded-Encrypted: i=1; AJvYcCVOscaVJhz1ja/edg+90wBNtR+yMQsvyY3QtU77T2zdfNDiHrz4UPJOObCHpcnKKi9zlWuTgQEjPXo=@vger.kernel.org, AJvYcCVlpaIGam3tvFS/S6WhOZ072d7vRZSqKfFoAVZp5izU4y+Bse5qYfk93s2wuFmtuT8ScmjxtMz+@vger.kernel.org, AJvYcCX9K+84WojxoW0oA4q8tTGjzYs49vnbxSMtxNMUoNoUT5E/jG5ggExEmTc0QXba3mCC3Q6f2Iqi015/t9e3@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVaK2SMveeQOuKW6VdKiOjXqeiYjVYWkx5SJ4S/RN4hXUQSOJ
	k5ea7jbZcmhQbyYkSIpKUmLY7yFD4frsAg2cuEVnbT9Os24ziDw/7GxwXt7QfWWfIGBQR/GH6HJ
	Ei+LWOq89BcstDuQCGt0LODhmL239n7c=
X-Gm-Gg: ASbGnctk2DjY+v9VvCZGDya6w6NQJlziI5S4a1bQ3E7C7fh+BmC/VkiXdcqTTv7qUQQ
	L8vj16SUQHaqhmDekNDJxmBjobpaQGgbhfHPqkQFrhC3b/OGgNNrDj6Q//BI453m0lG3H2ohJ/S
	Iev0sSIi9uQZM7ErSrGQ9r6HvZM/C91WR/
X-Google-Smtp-Source: AGHT+IFbMWbmAjAWpDW+ugQQa4jB7qBaCa2WAMxYSJu0HZ9aWKD03FUQq0hLL3NX8CwLGm33BAU2lvNa/N2YVz+j/6c=
X-Received: by 2002:a05:651c:2204:b0:30d:c4c3:eafa with SMTP id
 38308e7fff4ca-32abf4f838bmr5347851fa.7.1748944220298; Tue, 03 Jun 2025
 02:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429233848.3093350-1-nphamcs@gmail.com> <aDlUgVFdA7rCUvHx@yjaykim-PowerEdge-T330>
 <CAKEwX=MjyEsoyDmMBCRr0QnBfgkTA5bfrshPbfSgNp887zaxVw@mail.gmail.com>
 <aDxN6oz86TD5H4IL@yjaykim-PowerEdge-T330> <CAMgjq7DGMS5A4t6nOQmwyLy5Px96aoejBkiwFHgy9uMk-F8Y-w@mail.gmail.com>
 <CAKEwX=P4Q6jNQAi+H3sMQ73z-F-rG5jz8jj1NeGgUi=Pem_ZTQ@mail.gmail.com>
In-Reply-To: <CAKEwX=P4Q6jNQAi+H3sMQ73z-F-rG5jz8jj1NeGgUi=Pem_ZTQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 3 Jun 2025 17:50:01 +0800
X-Gm-Features: AX0GCFs-IQz1kR-0WuzGFg4LJh-1KD3qVtLjG4T0xeN4cJ7JSdCZNhTOkw9EglY
Message-ID: <CAMgjq7D4gcOih3235DRBEOv4EaaV3YEKc6w2Ab-wTCgb7=sA6w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/18] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>
Cc: YoungJun Park <youngjun.park@lge.com>, linux-mm@kvack.org, akpm@linux-foundation.org, 
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

On Tue, Jun 3, 2025 at 2:30=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Sun, Jun 1, 2025 at 9:15=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> >
> > Hi All,
>
> Thanks for sharing your setup, Kairui! I've always been curious about
> multi-tier compression swapping.
>
> >
> > I'd like to share some info from my side. Currently we have an
> > internal solution for multi tier swap, implemented based on ZRAM and
> > writeback: 4 compression level and multiple block layer level. The
> > ZRAM table serves a similar role to the swap table in the "swap table
> > series" or the virtual layer here.
> >
> > We hacked the BIO layer to let ZRAM be Cgroup aware, so it even
>
> Hmmm this part seems a bit hacky to me too :-?

Yeah, terribly hackish :P

One of the reasons why I'm trying to retire it.

>
> > supports per-cgroup priority, and per-cgroup writeback control, and it
> > worked perfectly fine in production.
> >
> > The interface looks something like this:
> > /sys/fs/cgroup/cg1/zram.prio: [1-4]
> > /sys/fs/cgroup/cg1/zram.writeback_prio [1-4]
> > /sys/fs/cgroup/cg1/zram.writeback_size [0 - 4K]
>
> How do you do aging with multiple tiers like this? Or do you just rely
> on time thresholds, and have userspace invokes writeback in a cron
> job-style?

ZRAM already has a time threshold, and I added another LRU for swapped
out entries, aging is supposed to be done by userspace agents, I
didn't mention it here as things are becoming more irrelevant to
upstream implementation.

> Tbh, I'm surprised that we see performance win with recompression. I
> understand that different workloads might benefit the most from
> different points in the Pareto frontier of latency-memory saving:
> latency-sensitive workloads might like a fast compression algorithm,
> whereas other workloads might prefer a compression algorithm that
> saves more memory. So a per-cgroup compressor selection can make
> sense.
>
> However, would the overhead of moving a page from one tier to the
> other not eat up all the benefit from the (usually small) extra memory
> savings?

So far we are not re-compressing things, but per-cgroup compression /
writeback level is useful indeed. Compressed memory gets written back
to the block device, that's a large gain.

> > It's really nothing fancy and complex, the four priority is simply the
> > four ZRAM compression streams that's already in upstream, and you can
> > simply hardcode four *bdev in "struct zram" and reuse the bits, then
> > chain the write bio with new underlayer bio... Getting the priority
> > info of a cgroup is even simpler once ZRAM is cgroup aware.
> >
> > All interfaces can be adjusted dynamically at any time (e.g. by an
> > agent), and already swapped out pages won't be touched. The block
> > devices are specified in ZRAM's sys files during swapon.
> >
> > It's easy to implement, but not a good idea for upstream at all:
> > redundant layers, and performance is bad (if not optimized):
> > - it breaks SYNCHRONIZE_IO, causing a huge slowdown, so we removed the
> > SYNCHRONIZE_IO completely which actually improved the performance in
> > every aspect (I've been trying to upstream this for a while);
> > - ZRAM's block device allocator is just not good (just a bitmap) so we
> > want to use the SWAP allocator directly (which I'm also trying to
> > upstream with the swap table series);
> > - And many other bits and pieces like bio batching are kind of broken,
>
> Interesting, is zram doing writeback batching?

Nope, it even has a comment saying "XXX: A single page IO would be
inefficient for write". We managed to chain bio on the initial page
writeback but still not an ideal design.

> > busy loop due to the ZRAM_WB bit, etc...
>
> Hmmm, this sounds like something swap cache can help with. It's the
> approach zswap writeback is taking - concurrent assessors can get the
> page in the swap cache, and OTOH zswap writeback back off if it
> detects swap cache contention (since the page is probably being
> swapped in, freed, or written back by another thread).
>
> But I'm not sure how zram writeback works...

Yeah, any bit lock design suffers a similar problem (like
SWAP_HAS_CACHE), I think we should just use folio lock or folio
writeback in the long term, it works extremely well as a generic
infrastructure (which I'm trying to push upstream) and we don't need
any extra locking, minimizing memory / design overhead.

> > - Lacking support for things like effective migration/compaction,
> > doable but looks horrible.
> >
> > So I definitely don't like this band-aid solution, but hey, it works.
> > I'm looking forward to replacing it with native upstream support.
> > That's one of the motivations behind the swap table series, which
> > I think it would resolve the problems in an elegant and clean way
> > upstreamly. The initial tests do show it has a much lower overhead
> > and cleans up SWAP.
> >
> > But maybe this is kind of similar to the "less optimized form" you
> > are talking about? As I mentioned I'm already trying to upstream
> > some nice parts of it, and hopefully replace it with an upstream
> > solution finally.
> >
> > I can try upstream other parts of it if there are people really
> > interested, but I strongly recommend that we should focus on the
> > right approach instead and not waste time on that and spam the
> > mail list.
>
> I suppose a lot of this is specific to zram, but bits and pieces of it
> sound upstreamable to me :)
>
> We can wait for YoungJun's patches/RFC for further discussion, but perhap=
s:
>
> 1. A new cgroup interface to select swap backends for a cgroup.
>
> 2. Writeback/fallback order either designated by the above interface,
> or by the priority of the swap backends.

Fully agree, the final interface and features definitely need more
discussion and collab in upstream...

