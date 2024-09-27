Return-Path: <cgroups+bounces-4962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D31B0987CBB
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 03:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948972851B7
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 01:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517341667F1;
	Fri, 27 Sep 2024 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ/KMT5o"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F15614A60D;
	Fri, 27 Sep 2024 01:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727401973; cv=none; b=KHcrLV1CxadFKnEZuSeOus4EHs8FTJNwwo6CVZH/xztEpUonpuoeYk6a4f4heCDlfKwoMzKJwCOFBnTxLwiYYnKJaBbPaAMAHWM2L5yA5Y4ibK87Df+AxEnkWoOpDB96nZ/zq9T8POCoZGJ0EH+Ch5ewrBTmDHJNS4H6H7ye3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727401973; c=relaxed/simple;
	bh=xAnrZRaJyD7HBPI7XnenJ3MGc9tNIxZl2rrNgLUBi3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyG5RHiDicUho7YivKIXLNLzqlwX4S3byO643urlzene4iDt3+6PhwwtN9nrI2q4tto4S6w49ipPx4gR9FDE4c6j1me1rcUHmCj9rBjIfT9BJL+wb8TrPdvEA9NlWKX3aiePWUTzdlR3YSKk/JDanESxunRRHZYxrTVrwUmAF+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ/KMT5o; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2c5128d5so11175136d6.0;
        Thu, 26 Sep 2024 18:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727401970; x=1728006770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAnrZRaJyD7HBPI7XnenJ3MGc9tNIxZl2rrNgLUBi3g=;
        b=nQ/KMT5oaw578zvC8rNyPhWfeMoLYAlyEgU/9MacV7pOHnhDX0UmggCZAjAvx1ySUG
         kCOHv1LokU/flAEjGMXzqTs7EM4vbQB/BegPm27NYJeLsiDdjQ5B+Oofp8raENoEqn7s
         O5c1EQF0sY8ULqq0vjFnkbwW00yjT149kLE7ACCNusQCZXnde6tKHjI9QsDtQLvDvpZ0
         TcDcyXfJJXK8k56uFXqHa1ha/EYsXlBwzUv7FMgsYUrZ4V1cxe7NbE84+MEc8AIqFiLE
         eEcGHcwof7U0RF/Sr+cemjF4v3cKI66fBFoI5UyAAlHlywg73DYbqoCbr+vOdJ3iAINh
         l7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727401970; x=1728006770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAnrZRaJyD7HBPI7XnenJ3MGc9tNIxZl2rrNgLUBi3g=;
        b=vyDe5hwNbuqyS+LP6enNhTzpNeVDo2LHoZoOfSilV3LVSiomgmA1UpXSBiG1V5Fg+5
         DPolIxy/FVeWCC9CJ853zFxph36bBJriGj/ZbXdCl2LSiXVjUY85wf4lzMt0Fbfi7X5u
         UKiZKAKot6hqmApXLATvwZ3atCGCToSHRaC85W3EhlOy0NdC/vmcCSwDad5NSXttSNoN
         HqrzkIjpHEFzR9jYX2q2as08xB6S2Gqh3kWp379e930fcL6T9q3eHZUJzDtmAWusRrTy
         A0XKyKXfOC61Cl+pfA8Lip9oh7o22Tz4eEBEeImBzk2zZ47+4bGl7Hy2mitP36JSct4a
         UuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjGDxQLdTGh+RAhRlU/tiBPBVKJXIm5p2RxI6zGnM/EOwBrTcWlaD6KCmJCF22PF15p+Dd+g/Uipxu@vger.kernel.org, AJvYcCX6H6Xp+ZHivEE1R7gM8z/7t/62MPh+qyvglo7Vlo9Jr2Db1c57FkpnxrlTapP9b2/Qpd1w4ZIz@vger.kernel.org
X-Gm-Message-State: AOJu0YzJdBq7cSBmqHau2Bb0c2if1MjBnWKQiQSCMqxXQAnHq2D+BU5/
	OnrBiR59t7ZP72v1ZE3H4Hu9ylQEdYx+vXHnkM4KRL6NIRvqI22HLBCv+3lUtO8fLlEFTr4zpl6
	znTDMozQx5OhsJ8GItlZR5bR9gng=
X-Google-Smtp-Source: AGHT+IHCPKsx7efhs3k311WYqpjW68lnnDe97yjX9qnvjdLXn0K9KjZ7hrrKjK7KTeq6a5vgyQ5IgQgX4WMdpOgg9FQ=
X-Received: by 2002:ad4:4450:0:b0:6cb:3ba3:8eab with SMTP id
 6a1803df08f44-6cb3ba38f1amr20584326d6.31.1727401970400; Thu, 26 Sep 2024
 18:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926225531.700742-1-intelfx@intelfx.name> <CAKEwX=MmCKrOkvDO5Yc_M8EB+k5U9AZ3boEiu4u2HUb7p0z+Kw@mail.gmail.com>
 <dba9d7d9542d4f3d979a89f88253418c1d8a9775.camel@intelfx.name>
In-Reply-To: <dba9d7d9542d4f3d979a89f88253418c1d8a9775.camel@intelfx.name>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 26 Sep 2024 18:52:39 -0700
Message-ID: <CAKEwX=N3m3cTkyh3ebA+79_oOEe4QMDbU2BxjEJCgfRanX9g9Q@mail.gmail.com>
Subject: Re: [PATCH] zswap: improve memory.zswap.writeback inheritance
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-kernel@vger.kernel.org, Mike Yuan <me@yhndnzj.com>, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:40=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> On 2024-09-26 at 16:12 -0700, Nhat Pham wrote:
> > On Thu, Sep 26, 2024 at 3:55=E2=80=AFPM Ivan Shapovalov <intelfx@intelf=
x.name> wrote:
> > >
> > > Improve the inheritance behavior of the `memory.zswap.writeback` cgro=
up
> > > attribute introduced during the 6.11 cycle. Specifically, in 6.11 we
> > > walk the parent cgroups until we find a _disabled_ writeback, which d=
oes
> > > not allow the user to selectively enable zswap writeback while having=
 it
> > > disabled by default.
> >
> > Is there an actual need for this? This is a theoretical use case I
> > thought of (and raised), but I don't think anybody actually wants
> > this...?
>
> This is of course anecdata, but yes, it does solve a real use-case that
> I'm having right now, as well as a bunch of my colleagues who recently
> complained to me (in private) about pretty much the same use-case.
>
> The use-case is following: it turns out that it could be beneficial for
> desktop systems to run with a pretty high swappiness and zswap
> writeback globally disabled, to nudge the system to compress cold pages
> but not actually write them back to the disk (which would happen pretty
> aggressively if it was not disabled) to reduce I/O and latencies.
> However, under this setup it is sometimes needed to re-enable zswap
> writeback for specific memory-heavy applications that allocate a lot of
> cold pages, to "allow" the kernel to actually swap those programs out.

Out of pure curiosity (and to make sure I fully grasp the problem at
hand), is this the capacity-based zswap writeback (i.e the one
triggered by limits), or the memory pressure based dynamic shrinker?

If you disable the latter and only rely on the former, it should not
"write pages aggressively". Limits are rarely reached (IIUC, zswap.max
are frequently used as binary knobs, and global limits are hard to
reach), so usually pages that are going to disk swap are just pages
zswap reject (i.e mostly just pages that fail to compress). This
should be a very small category. You will still see "swap" usage due
to a quirk in zswap architecture (which I'm working to fix), but there
should rarely be any IOs. So the setup itself is not super necessary.

If it's the latter then yeah I can kinda see the need for the setup.

>
> >
> > Besides, most people who want this can just:
> >
> > 1. Enable zswap writeback on root cgroup (and all non-leaf cgroups).
> >
> > 2. Disable zswap writeback on leaf cgroups on creation by default.
> >
> > 3. Selectively enable zswap writeback for the leaf cgroups.
> >
> > All of this is quite doable in userspace. It's not even _that_ racy -
> > just do this before adding tasks etc. to the cgroup?
>
> Well, yes, it is technically doable from userspace, just like it was
> technically doable prior to commit e39925734909 to have userspace
> explicitly control the entire hierarchy of writeback settings.
> However it _is_ pretty painful, and the flow you described would
> essentially negate any benefits of that patch (it would require
> userspace to, once again, manage the entire hierarchy explicitly
> without any help from the kernel).

I think it's a tad different. In the case of the commit e39925734909,
the hierarchical behavior of zswap.writeback knob is quite
semantically confusing, almost counter-intuitive (and does not conform
to the convention of other cgroup knobs, which use the most
restrictive limit - check out zswap.max limit checking for example).
That commit arguably fixes it for the "common" case (i.e you want the
hierarchical enforcement to hold for the most part). That's why there
were even conversations about cc-ing the stable mailing list for
backporting it to older kernels.

This is more of a "new use case" patch. It complicates the API, for
something readily doable in userspace - the kernel does not do
anything that userspace cannot achieve. So it should undergo stricter
scrutiny. :)

Anyway, Yosry, Johannes, how do you feel about this?

