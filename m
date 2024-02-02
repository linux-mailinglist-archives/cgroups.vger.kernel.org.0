Return-Path: <cgroups+bounces-1320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC694847C52
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 23:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FED61F22615
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 22:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531083CDF;
	Fri,  2 Feb 2024 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObyChgnL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D183A10
	for <cgroups@vger.kernel.org>; Fri,  2 Feb 2024 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912971; cv=none; b=PBz0nGf0yO4B//6HgzBUfk05VLoQ3aArwyjlyY0xTjJsjtZZSxCXM9mzX5gk+XrvPAYJmBGug/oZnYOAp48SYg643MkQ0LKFGaIFtpKZl9UakNxI+Gx3pKKP1JJBxwfQYJ6OXYz5InfTozsKgiCxIHjBbzYvPczCiajF2iHn47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912971; c=relaxed/simple;
	bh=gGYdrmSY27L3UMwdCd7M/7PkJCyNNxq/d8aVNPYJujs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qh05Hw4WAWSrI4TPya3myF8Io5V8zFx2uO0xk6i8qoDdmsgwJEz1H6Trq1B3q54tNMq+74DpN+omPNttml5DED7L84ObC5ezvjieFmDUXrc1LoSm26h9v4qvwS/0XJM8uketLpKt/UnqqYNUmNtjU1UJXxuL9yVukVy47IkNI04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObyChgnL; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d5267cceso2409731276.1
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 14:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706912969; x=1707517769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOziTImG/ai1TC8yybGKYzwUPfzkDvlxfAgJr9HGCcs=;
        b=ObyChgnLIT1fomKZUNFzQ5t87f7KnySvn4628AAkakN7JWIbhou1uFodPprdhdulKH
         YXNCpzDO1VO3EglWOJnir+bKqZcqscvTVocXAMWdlsxVWGDwI2uwWDNZoktRYdOJCrwN
         TicznRKWtlf0Rp2nQY8XVX09VCEwBEfWKfquJJQ8ZM6iQ5+hQ/eJDN/dIJI8xq59yYv8
         X0pzVp8uaVrhoXCUtpVF9naVXgtzc4z0d88Ds6tKKeKOvkFfDgo2Yb0D31BhAGG1EGCy
         hIECLaE9fC+N68q+yRF+5Xkv2dsCwiGXvEmf73qdmHyF7kbqDLpC9uP/AmJV/v1HAohJ
         rI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912969; x=1707517769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BOziTImG/ai1TC8yybGKYzwUPfzkDvlxfAgJr9HGCcs=;
        b=DTDnBp6C95W4WEIZ454tfZfFyw7e8DAiKmaMPStwmNm5XCF9q+UhKKCelYDm8ZLNm+
         +MFW8bLkJ3V80cy+6qRm5Xh+6a27ljkqjcpqBb8SxRrTjwHMTRnn0lu6Zh99Vf9Zib3Y
         hUezOUB5QKEZ28DQeu+Fori+WvOjlBJsRSNtQYhDNF2Xxr/CRf0ni8x0lLRq6iXWlnkC
         0Ja75/1ShFApRP2TRxslPxw52SYu27P15sIk+mh/0Sr3Or20V5Siaze/iznkz7ljm8mI
         EdiK0yV6BS2TnZ+ZIvXK7tJg0zxGd42OgmUv0LTaCh9MxYwmf4Zl8Cok0tX5jwW+PxtH
         i5Og==
X-Gm-Message-State: AOJu0YwMB5sWnQr+wNtUk5SpYGi62dkdHnzw7I4QSJZktVI4WUOXOcsT
	JyocvnH1zPlVqzsU81uFmSkGiGaSYjQNAxjhhcfccfn+GHI+e7YhQbDmDn32zkPULwsmvPCq/RN
	IZill4LUXFe+4k9si0/D0usBi7oplAyxy8LRj
X-Google-Smtp-Source: AGHT+IHm1T1hxvOrmJW4bWTmfAkGpLs9hkfM+xa0FRzsB9jyyZq8NjorSKfDZQnnpX2iQAQV2Mm3Gq+2/oj1qjuwi+E=
X-Received: by 2002:a25:81cc:0:b0:dc6:e72b:99b4 with SMTP id
 n12-20020a2581cc000000b00dc6e72b99b4mr5279741ybm.29.1706912968819; Fri, 02
 Feb 2024 14:29:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202221026.1055122-1-tjmercier@google.com> <CAJD7tkZh=M58Avfwx_D+UEXy6mm18Zx_hVKn8Gb8-+8-JQQfWw@mail.gmail.com>
In-Reply-To: <CAJD7tkZh=M58Avfwx_D+UEXy6mm18Zx_hVKn8Gb8-+8-JQQfWw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 2 Feb 2024 14:29:17 -0800
Message-ID: <CABdmKX3_jCjZdOQeinKCKBS3m4XS8heE9WMDU-z1oFpCcPc5fg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: Use larger batches for proactive reclaim
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com, yuzhao@google.com, 
	mkoutny@suse.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:14=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Fri, Feb 2, 2024 at 2:10=E2=80=AFPM T.J. Mercier <tjmercier@google.com=
> wrote:
> >
> > Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactive
> > reclaim") we passed the number of pages for the reclaim request directl=
y
> > to try_to_free_mem_cgroup_pages, which could lead to significant
> > overreclaim. After 0388536ac291 the number of pages was limited to a
> > maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overreclaim.
> > However such a small batch size caused a regression in reclaim
> > performance due to many more reclaim start/stop cycles inside
> > memory_reclaim.
> >
> > Reclaim tries to balance nr_to_reclaim fidelity with fairness across
> > nodes and cgroups over which the pages are spread. As such, the bigger
> > the request, the bigger the absolute overreclaim error. Historic
> > in-kernel users of reclaim have used fixed, small sized requests to
> > approach an appropriate reclaim rate over time. When we reclaim a user
> > request of arbitrary size, use decaying batch sizes to manage error whi=
le
> > maintaining reasonable throughput.
> >
> > root - full reclaim       pages/sec   time (sec)
> > pre-0388536ac291      :    68047        10.46
> > post-0388536ac291     :    13742        inf
> > (reclaim-reclaimed)/4 :    67352        10.51
> >
> > /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (MiB)
> > pre-0388536ac291      :    258822       1.12            107.8
> > post-0388536ac291     :    105174       2.49            3.5
> > (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> >
> > /uid_0 - full reclaim     pages/sec   time (sec)
> > pre-0388536ac291      :    72334        7.09
> > post-0388536ac291     :    38105        14.45
> > (reclaim-reclaimed)/4 :    72914        6.96
> >
> > Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during proactiv=
e reclaim")
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> LGTM with a nit below:
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Thanks

> >
> > ---
> > v2: Simplify the request size calculation per Johannes Weiner and Micha=
l Koutn=C3=BD
> >
> >  mm/memcontrol.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 46d8d02114cf..e6f921555e07 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6965,6 +6965,9 @@ static ssize_t memory_reclaim(struct kernfs_open_=
file *of, char *buf,
> >         while (nr_reclaimed < nr_to_reclaim) {
> >                 unsigned long reclaimed;
> >
> > +               /* Will converge on zero, but reclaim enforces a minimu=
m */
> > +               unsigned long batch_size =3D (nr_to_reclaim - nr_reclai=
med) / 4;
> > +
> >                 if (signal_pending(current))
> >                         return -EINTR;
> >
> > @@ -6977,7 +6980,7 @@ static ssize_t memory_reclaim(struct kernfs_open_=
file *of, char *buf,
> >                         lru_add_drain_all();
> >
> >                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > -                                       min(nr_to_reclaim - nr_reclaime=
d, SWAP_CLUSTER_MAX),
> > +                                       batch_size,
> >                                         GFP_KERNEL, reclaim_options);
>
> I think the above two lines should now fit into one.

It goes out to 81 characters. I wasn't brave enough, even though the
80 char limit is no more. :)

This takes it out to 100 but gets rid of batch_size if folks are ok with it=
:

                reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
-                                       min(nr_to_reclaim -
nr_reclaimed, SWAP_CLUSTER_MAX),
+                                       /* Will converge on zero, but
reclaim enforces a minimum */
+                                       (nr_to_reclaim - nr_reclaimed) / 4,
                                        GFP_KERNEL, reclaim_options);

