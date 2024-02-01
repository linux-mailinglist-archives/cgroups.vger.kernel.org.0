Return-Path: <cgroups+bounces-1301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41935845F9A
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 19:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B631C27542
	for <lists+cgroups@lfdr.de>; Thu,  1 Feb 2024 18:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018218528C;
	Thu,  1 Feb 2024 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubEkjYIc"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438EE84FC1
	for <cgroups@vger.kernel.org>; Thu,  1 Feb 2024 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811042; cv=none; b=i1cq/seCE7yavSEDn/jbUxcFuH+U/JvubSke/ZgpDse2e+VzoyqQhbBqvcSQEr/vDf0PmQZW4OCrnS7Ca8Eep4m2qxnbm3bORBJYDUgHBmfokWYJsdj7sThGyD3XcbBK64b8Q2mOKyDeZdBxV7UaUQ5qPo6tez+8uNKRx5Abr3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811042; c=relaxed/simple;
	bh=ygaCEicSt3gW34jkFaYHRJ8iK0y2xGpVsgeFstll66Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3bvdNddv5OfAHtNXE5M2ECZtlje+BUZ8z5FCTdZSirS3hDjpg1HcVYftczeLivGbYbBlLNo9Gxk5ePkMgTe96/pj1a10LRQIXm6wZiYnSviULJhHseAgQG6Hcmz6y1sFAENJEGRQbcsISaN5DY5j+MtxWMSg3v7C4rdbyA7DDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubEkjYIc; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6da01f092so902553276.0
        for <cgroups@vger.kernel.org>; Thu, 01 Feb 2024 10:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706811040; x=1707415840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHfuYMEKwOkGfq9jIdDUbSlih9i80eEwJ6EkAPpJJng=;
        b=ubEkjYIcJaSL/42MxpDd6wLbTQ4NAuD5AJhGtPNyFVBG3Ormv2I0kA0QTCR7uHLkL7
         KFsOgilkvLFADGcsqT6SgWy31yIRG/XEGrQjdhEhNkcHNwsd5nsp2j9NcK6kVPbsCu5A
         AaBurVU4wCN61syaPbzzcZNPTZo5te6OAsUP+YV29Ib5iN0f4alkHTKH2nVvN01nSY1g
         Mo/kI73Rc5d+nJTtmGTZ2XbN+Os3cwAzbSrk2iyVAYtqjjqGqHcZ1IpFQC8WSAy3n5Co
         ccPTTC/LY1fTqY2YDBjqHU+uOZuO0nsFNvseZDAEYmxqaJH/7Z+qhppF1CL6okOCZ1Yc
         lkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811040; x=1707415840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHfuYMEKwOkGfq9jIdDUbSlih9i80eEwJ6EkAPpJJng=;
        b=uAgD37XXPKQolqzSYs3jAarZQf2AsA0szpgkMJunBL0X3a4fKcbZKbjGclhI8VAyjr
         Jz1NTv1F1jMPapFs+Xl6olMwo7paqiV6V+x/9qi7Pv8hNfjHn8368UOsoH2bKsg1jkVv
         tk3YyoAhyPTCcwiS0U2whccQ0RtSLdYWfDDlR7jyi3aHcvwecoRDOUkJDRgt5fbgZgDk
         hvbjTIqy9ooAmBSm3dLphUFbD1u0z61+Q8kWX+LVfNX5151ToYf61uwJwjAvZmEg4wnk
         CL3/3xgodqQ9ZaF9TnMtFhQIzYAEYbAjX9YrIHSmkl7GfWmJmlCHfKCZmY/TP4Banz0L
         kA6w==
X-Gm-Message-State: AOJu0YysYcNGqP0A0U/k3Yd3psURv8DFe1fLf1Yz+cD71Bqp6dCkjE8C
	NzB0nlwLaeGG+Ty4zKwRHJB4r3pEHOKzz0FXVyMDoiNWSNttiQPFnz16X6zNBdg5eeViYWW46GL
	XOkTvt30VbAEFq7lmr5Ey4M/ja3LOLQbeN09b
X-Google-Smtp-Source: AGHT+IFX6go0V30fwrlIueitJQAg1llY0QsQgiGHGUNldgZN6DNqY5vqrIPusWJFHRdFdDUbuQfm/f6tTKwgOgZguqU=
X-Received: by 2002:a25:aa14:0:b0:dbe:974:fb85 with SMTP id
 s20-20020a25aa14000000b00dbe0974fb85mr6028810ybi.22.1706811039987; Thu, 01
 Feb 2024 10:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131162442.3487473-1-tjmercier@google.com>
 <q3m42iuxahsjrskuio3ajz2edrisiw56cwy2etx2jyht5l7jzq@ttbsrvgu4mvl> <20240201153428.GA307226@cmpxchg.org>
In-Reply-To: <20240201153428.GA307226@cmpxchg.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 1 Feb 2024 10:10:28 -0800
Message-ID: <CABdmKX3fPRdh+Q0n43nXAexnJshPf3e2U6RgLyo5FW3b4T53iQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: Use larger chunks for proactive reclaim
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>, 
	android-mm@google.com, yuzhao@google.com, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:34=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Thu, Feb 01, 2024 at 02:57:22PM +0100, Michal Koutn=C3=BD wrote:
> > Hello.
> >
> > On Wed, Jan 31, 2024 at 04:24:41PM +0000, "T.J. Mercier" <tjmercier@goo=
gle.com> wrote:
> > >             reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > > -                                   min(nr_to_reclaim - nr_reclaimed,=
 SWAP_CLUSTER_MAX),
> > > +                                   max((nr_to_reclaim - nr_reclaimed=
) / 4,
> > > +                                       (nr_to_reclaim - nr_reclaimed=
) % 4),
> >
> > The 1/4 factor looks like magic.
>
> It's just cutting the work into quarters to balance throughput with
> goal accuracy. It's no more or less magic than DEF_PRIORITY being 12,
> or SWAP_CLUSTER_MAX being 32.

Using SWAP_CLUSTER_MAX is sort of like having a really large divisor
instead of 4 (or 1 like before).

I recorded the average number of iterations required to complete the
1G reclaim for the measurements I took and it looks like this:
pre-0388536ac291     : 1
post-0388536ac291    : 1814
(reclaim-reclaimed)/4: 17

Given the results with /4, I don't think the perf we get here is
particularly sensitive to the number we choose, but it's definitely a
tradeoff.

<snip>

> > Also IMO importantly, when nr_to_reclaim - nr_reclaimed is less than 8,
> > the formula gives arbitrary (unrelated to delta's magnitude) values.
>
> try_to_free_mem_cgroup_pages() rounds up to SWAP_CLUSTER_MAX. So the
> error margin is much higher at the smaller end of requests anyway.
> But practically speaking, users care much less if you reclaim 32 pages
> when 16 were requested than if you reclaim 2G when 1G was requested.

I like Johannes's suggestion of just a comment instead of the mod op.
It's easier to read, slightly less generated code, and even if we
didn't have the .nr_to_reclaim =3D max(nr_pages, SWAP_CLUSTER_MAX) in
try_to_free_mem_cgroup_pages, memory_reclaim would still get very
close to the target before running out of nr_retries.

