Return-Path: <cgroups+bounces-8253-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34BABB503
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 08:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2915E3A9D5A
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 06:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B4243364;
	Mon, 19 May 2025 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDlKHHTr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982A223DC4
	for <cgroups@vger.kernel.org>; Mon, 19 May 2025 06:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635533; cv=none; b=r5Jap20RInWPwl7/7hpQl0OK6XciWSeoc2gMRmss5DHU2oT15SvD4YrE8TmWptdCFCJT3myhh+nPYVrMTqBYLRhEE/Ekcu9xZyLHo8EryA5wY2VGsf6A+cPOLuEaH/3AKDT3ao7VIHuEJ3fVSVMXA6oB0Zq54YlwJ/xGIUYTZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635533; c=relaxed/simple;
	bh=vK0gx1ykqEks3iig04qjuy13U8xSjbAqQzrJA0P4uP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtsansFPS6BjQmJUXczjOqTIzoqyhttNaFaGTiXu2f/RLHKLMNazMdIMhGbASIyfBJMEUkXSYxyRbb7c3YH8r6FwPCbBo25BNAy5rIILUX5WUHHbVr6JgwTowEp7f53ZeeAQPfMFYd/ZC9pFGwpZUu/TxXG62d65MdxKG0NTGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDlKHHTr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad563b69908so133307966b.3
        for <cgroups@vger.kernel.org>; Sun, 18 May 2025 23:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747635530; x=1748240330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vK0gx1ykqEks3iig04qjuy13U8xSjbAqQzrJA0P4uP4=;
        b=EDlKHHTrcXx7r98EwB+U8Ua6RrL1azUuS/OYDnZuPuzVN1QWI9C5KeLC6Nzhb5blHP
         W+EV9oySWMwebyHeIoI4+krAvmhqPAa6eeQ+V35RLP5BSXg29anffCgGWDlS3gHcvpcQ
         3dyQQnQlzdENv4UCES4MuvhBi893NgImi0LwZ0UNnqaI8jh9TWIrWnQKTjvJ9/YXNKF9
         EKAAvHi4yIEJGTdZ40dMaWKYayqpygu1kCManYrosJBXDd1klwXUAxXB5g/OOw+fQlD2
         bDJgYuAdfUyyFMzn1EOSQPEdTt7Fz3NMo77aKpbP/tyLyIEHYQTow2xNWMUfdljl7bCj
         56dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747635530; x=1748240330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vK0gx1ykqEks3iig04qjuy13U8xSjbAqQzrJA0P4uP4=;
        b=fdVgV6fBWOZ7hr2zi+p8UNvR25Rnt/i2SyxnZr4B/Ar1TJSHw2eC8ho06bRG2uhNEl
         QcSw3JUk5J5PgJFxGSWgnloR9RpkORULQsP7zpNPZ7NGxSYz8D1d8slYMF8fUBwyMRfv
         xTcwMXRVS9rM9Bfvj2OUdZ03RUl6vJO1Xs2kb1sn/zCGvnGrOqgpcn5Puqa2bmqY81ES
         7n1q34w6ZbiurDVyLdwGBgmVqsxFHw/H0i+c5tLrKJ04uo6grTGjRTzV6fUahK4E01rC
         b0mtLwu26Tkqr6v+cJ15f4LgtQWgrpzT4In2BLJatLBgLwQBuAoeIUu7oSyDoXx9jiqW
         MwxA==
X-Forwarded-Encrypted: i=1; AJvYcCU/NMS/UjQU2pTEPjsqrguFwQ3jM9E9fCX/udVQUv358z/0cec9wvCcSwLcRJE0yCFI9AyHh8Pw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgdd3wc0GSVlCN5LUFasWHZZXz0+A+Y/vFX5fUSzRHKqS53y53
	Pgs2qcCp4fmOxx9YOSZxdIB4qOg17jDe2cNHy/WMQbaBPuBhPlxZdBRiui7QNqT5roGdOB6S0wa
	RwfF3+oQAVvAeODd/2VaVVaQBd1HmQCk=
X-Gm-Gg: ASbGncvEgDAgRJDTeRH1JjpkCOs3IYNzn+cWQSIcG1v/bbqkuDzqlAjBs0dDMVZ1d0h
	3pcR9IdRP6IAv3OsE4ADwXqSNj16LDXDvogCxD4N/ziW89uKHLEMrq4+bndPZe7MTawQ4BZ+YIK
	J0RgTBnQ5NxXVVyQ/zgZls3cFn601JOVI=
X-Google-Smtp-Source: AGHT+IED1MGrTJUgDiXAUoxy2ZS37P5iCwFTBvVZgDuAbwR2oTt4wpSQ5cSDfGjdU1nNJ3yVKy67BGxv6DklZhbROQ0=
X-Received: by 2002:a17:907:1c2a:b0:ad2:3fa9:751f with SMTP id
 a640c23a62f3a-ad536dce3demr987314466b.38.1747635529329; Sun, 18 May 2025
 23:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org> <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
 <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com> <20250515160842.GA720744@cmpxchg.org>
 <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com> <20250516145318.GB720744@cmpxchg.org>
 <5000d284-162c-4e63-9883-7e6957209b95@amd.com> <20250516164150.GD720744@cmpxchg.org>
 <eff07695-3de2-49b7-8cde-19a1a6cf3161@amd.com> <20250516200423.GE720744@cmpxchg.org>
 <CAPM=9txLaTjfjgC_h9PLR4H-LKpC9_Fet7=HYBpyeoCL6yAQJg@mail.gmail.com> <5c0df728-2100-4078-8020-4aac8eb31d2b@amd.com>
In-Reply-To: <5c0df728-2100-4078-8020-4aac8eb31d2b@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 19 May 2025 16:18:37 +1000
X-Gm-Features: AX0GCFuphdrkbUIehiBml6CnXJWdoRvQjaJ47FArohPiypk3t12x3bE1pnOOt84
Message-ID: <CAPM=9tysB4iNkGViN1iaGXjPC7y=YwB05ReHdUVR_-4zHahEFg@mail.gmail.com>
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, dri-devel@lists.freedesktop.org, tj@kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 May 2025 at 02:28, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> On 5/16/25 22:25, Dave Airlie wrote:
> > On Sat, 17 May 2025 at 06:04, Johannes Weiner <hannes@cmpxchg.org> wrot=
e:
> >>> The memory properties are similar to what GFP_DMA or GFP_DMA32
> >>> provide.
> >>>
> >>> The reasons we haven't moved this into the core memory management is
> >>> because it is completely x86 specific and only used by a rather
> >>> specific group of devices.
> >>
> >> I fully understand that. It's about memory properties.
> >>
> >> What I think you're also saying is that the best solution would be
> >> that you could ask the core MM for pages with a specific property, and
> >> it would hand you pages that were previously freed with those same
> >> properties. Or, if none such pages are on the freelists, it would grab
> >> free pages with different properties and convert them on the fly.
> >>
> >> For all intents and purposes, this free memory would then be trivially
> >> fungible between drm use, non-drm use, and different cgroups - except
> >> for a few CPU cycles when converting but that's *probably* negligible?
> >> And now you could get rid of the "hack" in drm and didn't have to hang
> >> on to special-property pages and implement a shrinker at all.
> >>
> >> So far so good.
> >>
> >> But that just isn't the implementation of today. And the devil is very
> >> much in the details with this:
> >>
> >> Your memory attribute conversions are currently tied to a *shrinker*.
> >>
> >> This means the conversion doesn't trivially happen in the allocator,
> >> it happens from *reclaim context*.
>
> Ah! At least I now understand your concern here.
>
> >> Now *your* shrinker is fairly cheap to run, so I do understand when
> >> you're saying in exasperation: We give this memory back if somebody
> >> needs it for other purposes. What *is* the big deal?
> >>
> >> The *reclaim context* is the big deal. The problem is *all the other
> >> shrinkers that run at this time as well*. Because you held onto those
> >> pages long enough that they contributed to a bonafide, general memory
> >> shortage situation. And *that* has consequences for other cgroups.
>
> No it doesn't, or at least not as much as you think.
>
> We have gone back and forth on this multiple times already when discussio=
n the shrinker implementations. See the DRM mailing list about both the TTM=
 and the GEM shared mem shrinker.
>
> The TTM pool shrinker is basically just a nice to have feature which is u=
sed to avoid deny of service attacks and allows to kick in when use cases c=
hange. E.g. between installing software (gcc) and running software (Blender=
, ROCm etc..).
>
> In other words the TTM shrinker is not even optimized and spends tons of =
extra CPU cycles because the expectation is that it never really triggers i=
n practice.
>
> > I think this is where we have 2 options:
> > (a) moving this stuff into core mm and out of shrinker context
> > (b) fix our shrinker to be cgroup aware and solve that first.
>
> (c) give better priorities to the shrinker API.
>
> E.g. the shrinker for example assumes that the users of the API must scan=
 the pages to be able to clean them up.

Well my again naive approach is to just add simpler low-overhead
shrinkers to the start of the shrinker list and if they free up enough
memory then win, otherwise we were in reclaim anyways,

however this asks the question if just going into reclaim and having
to touch any shrinkers at all is bad, if the overheads of just doing
that aren't acceptable then we would need to come up with a better way
I suspect?

adding a single shrinker flag to put the ttm shrinker at the top of
the list is pretty trivial.

Thanks for use-cases that probably matter, I can see the online gaming
workloads being useful overhead reduction.

There probably isn't much appetite to just migrate the ttm pools into
the core mm, I see a couple of other users like sound do set_memory_*
calls, but I doubt they are on the radar for how much it costs.

Dave.

