Return-Path: <cgroups+bounces-5510-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 400FB9C423E
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2024 16:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AA61F25ADE
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2024 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686319E98C;
	Mon, 11 Nov 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYtpCZ2y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C725777;
	Mon, 11 Nov 2024 15:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340727; cv=none; b=t4Mmz9aR0LGZH/LDpd87KPCqhknOG/+VtVEwCGGcUhjwNSbPOn3LwBxaszo/LqkpEoMuJXGeBMefhn68B4/2vdrMzd5XCJIUUek9BiKUGKH4NfyTh/6lAU2WCYN/uU4sE06tV/wesoBMaxmAXtq6/qgTvSHw+LPNEc90jpFRr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340727; c=relaxed/simple;
	bh=D/YpkEfpManBPaAEXxiNweHwj+pGzqn0/nquf2ubY1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IaSNZJPH+BbzURgX7ppdKVqautqQRVIOwnKmkvp2iA9KOck3uoFJ28ETukJYMSKjne7L8Xn/py5vkC7hF7NxkVzQQRF3slTJGfRfWaIc1Wxe1zglR5PAxzkUAYzP2503HzdcAWTeZEKtX6EMILbwmRNlU8PQUEjlAq9m1NGeTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYtpCZ2y; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso232087166b.1;
        Mon, 11 Nov 2024 07:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731340724; x=1731945524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl9j2ZhDxQQ2YzSVFeZKFe/F9Df3fYpRcMcBflMuxFU=;
        b=NYtpCZ2y6Ys3uY522f+gEFPS+WW3piplkMJ5eoPuCGBRpKET7deGctsbcTrXiZDYX6
         IYvwgx3yd0Obk6sHOksNVkO+AthAFcjWVztO60ea3DMI/K1G35g5dAKMPNn9B4o9gNCo
         /xyCr60AW5Q+D1tbiXT7E/utyejGrEfRmcJ6Zyk5Nv5GH7A6L5XxuLIJE4ptKyLm5mDK
         rzVXnVgT3qy53dyxC8OUsy8ycwDAZNnDShrV6KD0UdZKNL/jEmw4ZkV1ZhvfNgRwmC8n
         GCNESaqhykzEKe3lnw6Rj2Gaa/3Mbyh2y+3d03Y8glpsGnUXsjRb0EeEkbmbV8SPlyxD
         N0YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340724; x=1731945524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl9j2ZhDxQQ2YzSVFeZKFe/F9Df3fYpRcMcBflMuxFU=;
        b=wIFHcQQSipSc9Uv4aFLJW8rWKxHjdvOgGbF3tfdhcRmQPnYKS4rtV0jpg4FqbuvyEm
         ExoJJe8AquAw/4C8TPDddqiJwQECv8K4ikZU2hX7eFJdy/KYnaF0qY2dilj0YEwVMb0D
         J33iicLAb0W4E9Q5HYJkQGdOJBJ8oxl7L9/p7o3HDNt+a1ZdjP/L/zHZXVPiOl/MwIoz
         LIrrhoTGy1/C4ENrQW0m9tVKjpzDsrkr9IQabDyzbtzEKylbbijbm2hW8ZX3diWHI0x6
         6i0+oQ2bUYMNM5wo6aWg2HpxyKi/Z2bIN2Hes1jHJ1w1FWmp6pIKCv1gPiljIAEVmLhC
         TCrw==
X-Forwarded-Encrypted: i=1; AJvYcCUqPA+LvBBHDDfOMInHPAanEPdeyPMgXxdWhv+3MxfkgPDd1ygZpDgmbxqvaourmDV+1JQxUiDHDowT@vger.kernel.org, AJvYcCVsP/f2b97FT4TMmbSLC4hnF4i9C7o6ZpoC9LRkdADXVejGz8IY1rwIdr/K2KEnCaTIkLuE2+JM@vger.kernel.org, AJvYcCWyx8kss0IweeKEbGWsasnrcJVkieAGRu2dENocIAjwTUC9+zBVSOXWCNrKGsgB6BQdHEW8hRF2ITSIcqmR@vger.kernel.org
X-Gm-Message-State: AOJu0YybMpb7aVKWZJvw9J8Np+btNxED9McqbYNPd0pH4O43D1T0wOx0
	0oF2itThCskH3d8Z3OMxNingH/0SHg/5fGH1lIMc/iZygOlJNjwzcid+hgNYhKNeiYWshZlOort
	YmMHGN1sKpWTLOWZl9O1k1wkM7kQ=
X-Google-Smtp-Source: AGHT+IFVWWt4lX8khmDtVZ2kVgUASNxC6iDiSfAVTyuaUSBaXtk0CtGDqWPITCIxLKL9+nMWHqxJWPrBH1EgnkwxP4s=
X-Received: by 2002:a17:907:84a:b0:a99:f887:ec1d with SMTP id
 a640c23a62f3a-a9ef001b40emr1312010466b.49.1731340723945; Mon, 11 Nov 2024
 07:58:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101204402.1885383-1-joshua.hahnjy@gmail.com> <72688d81-24db-70ba-e260-bd5c74066d27@google.com>
In-Reply-To: <72688d81-24db-70ba-e260-bd5c74066d27@google.com>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Mon, 11 Nov 2024 10:58:32 -0500
Message-ID: <CAN+CAwPSCiAuyO2o7z20NmVUeAUHsNQacV1JvdoLeyNB4LADsw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] memcg/hugetlb: Add hugeTLB counters to memcg
To: David Rientjes <rientjes@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com, 
	shakeel.butt@linux.dev, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	chris@chrisdown.name, tj@kernel.org, lizefan.x@bytedance.com, 
	mkoutny@suse.com, corbet@lwn.net, lnyng@meta.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 9:19=E2=80=AFPM David Rientjes <rientjes@google.com>=
 wrote:
>
> On Fri, 1 Nov 2024, Joshua Hahn wrote:
>
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 69af2173555f..bd7e81c2aa2b 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1646,6 +1646,11 @@ The following nested keys are defined.
> >         pgdemote_khugepaged
> >               Number of pages demoted by khugepaged.
> >
> > +       hugetlb
> > +             Amount of memory used by hugetlb pages. This metric only =
shows
> > +             up if hugetlb usage is accounted for in memory.current (i=
.e.
> > +             cgroup is mounted with the memory_hugetlb_accounting opti=
on).
> > +
> >    memory.numa_stat
> >       A read-only nested-keyed file which exists on non-root cgroups.
> >
>
> Definitely makes sense to include this.
>
> Any reason to not account different hugetlb page sizes separately in this
> stat, however?  IOW, should there be separate hugetlb_2048kB and
> hugetlb_1048576kB stats on x86?

Hello David, Thank you for reviewing my patch!

The reason that I opted not to include a breakdown of each hugetlb
size in memory.stat is only because I wanted to keep the addition that
this patch makes as minimal as possible, while still addressing
the goal of bridging the gap between memory.stat and memory.current.
Users who are curious about this breakdown can see how much memory
is used by each hugetlb size by enabling the hugetlb controller as well.

It's true that this is the case as well for total hugeltb usage, but
I felt that not including hugetlb memory usage in memory.stat when it
is accounted by memory.current would cause confusion for the users
not being able to see that memory.current =3D sum of memory.stat. On the
other hand, seeing the breakdown of how much each hugetlb size felt more
like an optimization, and not a solution that bridges a confusion.

I have not had a scenario where I had to look at the breakdown of the
hugetlb sizes (without the hugetlb controller), or a scenario where not
knowing this causes some sort of confusion. If others have had this
problem, I would love to hear about it, and perhaps work on a solution
that can address this point as well!

I hope you have a great day!
Joshua

