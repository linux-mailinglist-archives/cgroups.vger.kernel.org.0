Return-Path: <cgroups+bounces-5233-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 594AB9AEF73
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 20:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050071F2129C
	for <lists+cgroups@lfdr.de>; Thu, 24 Oct 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF20201012;
	Thu, 24 Oct 2024 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDL253JJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6484B2003A6
	for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729793602; cv=none; b=AD8p/jA7AYXRXA3GgMg5olDXKd2IX2ds2tGAG64A7EltwG/lqUtgVZIiS6YVdi+rjIcJqrjAVMejrnhqgC/2yWtyEs238RolI11rdkRf0i/Ox/1DNfTFAYZ2mkMJPs0VanPyIDn6VQxxiydhcr376emYPQwvWSpm2jItQpqMHsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729793602; c=relaxed/simple;
	bh=aRFhjnyjBm1r6uOHmV9w0GPpcM/w280U9YXPK2C/bT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHtxAk93zfwEb/N6bZYoYFxzfaNCBydHuPWDLP+BskeQNvoXPARH7p4kMJnRm7tAuBPGU97Q4sSXkVdD3GwLmB2t/iDmJUSVkrIm38MgBC581sM0IBqjY4swaHtoqwz4JQ9T83Vez282f9iNICecGgegdUbK3C2ffJUA3wmLvYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDL253JJ; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a2209bd7fso150637166b.2
        for <cgroups@vger.kernel.org>; Thu, 24 Oct 2024 11:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729793599; x=1730398399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSD0fIyOTQZR8lNGm4AYlf7tJrIJ+5Lh5gkFHvJKOME=;
        b=QDL253JJMRNTUfoAjXvLIoyBVYiZQnVYpqA0qh5QgZhaWO3tdYk/rlxUS1gOXpNvxT
         AuV0oF/Vh6Lfm+yDGLezVuqgoSlfA7RX+74sKXzHz/4t2KQDmh+WTTRSlH0VE0exJfYC
         SDVdGzEcNetOLu8UPmhzeuf3kuhd51klaFLMiFrAE7IxunkJelLeUPeZl+d+/+CS5gE9
         ApneDmdCTbCA0Q44atz2GEUshylZiT82tC3+LQTtWq3i3ErSmk+cuA4SY4ftxtE0Y7sF
         9ZhCChHeSapOman9V7nRTbeMAqmrRoEmBGhTqsUpvc/Nqh9jzwhrFTsTeWlT5lwYcW31
         7qlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729793599; x=1730398399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSD0fIyOTQZR8lNGm4AYlf7tJrIJ+5Lh5gkFHvJKOME=;
        b=KYBBQSxnIjl0o35KHRHa0SzVx3VtQTT9nxoXZ1Gn2r8Ds1+/xZmnbrHXiUJ2r3DmmL
         meeV8ABy8ZeymgWazjh/azEKH5Qdx3eEIgGEw1FGA36zODQlIsiWK4pbExHiHVwAQ7gk
         PcLReNs8VCCMBak56wT4fSNc4oYwXTj1iwoPvy29P1qDVZmPYegPs771D5u6BUqsm+gM
         fuqO3wymh6eV9ZBgQUqVwAJon7sGf9geAOw3mEoiZiDqzYN3Xs4aCw6NOHqQOqq4Y6h8
         ojtfyNb8j5Y84v9LscJt2zljL0GrJAAAnvri2qKmRkpb75aJO1NgiDZsyPmxVFF/ODoZ
         jedA==
X-Forwarded-Encrypted: i=1; AJvYcCWe+B2NMaYA89PY+QVcdsOiV75Q+gO9bThXpQvIppkyQs1PEOFDnkkadXwiMKsD/7FfRPe42Wbr@vger.kernel.org
X-Gm-Message-State: AOJu0YwLD8Ccvg3PnMee5ShxKwDL8em6x96DbVw9jOciqpqSXhNkapUg
	2RKZjDR/x3xi11aEdDll2R2yYI8C9pktv6UT8kAPBmZQgehmFMQlmJ/1DU4xI+tPR/ZIqjmrsYF
	ZydqtBLT2BBl9ZoQw7JdipWNo/3k=
X-Google-Smtp-Source: AGHT+IHwpdWGrm5cwE3MDd10enkaEKS7FBx5yk6RlXvajfi+8crmDbU1GDTxwPZEczkdhBXrS/wrLbzg7SwJj4E1Ljg=
X-Received: by 2002:a17:907:6d0f:b0:a99:ebcc:bfbe with SMTP id
 a640c23a62f3a-a9ad2757d0amr235369466b.27.1729793598441; Thu, 24 Oct 2024
 11:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023203433.1568323-1-joshua.hahnjy@gmail.com> <acaahpfoyy3rci6ekfw2l3i2k5jpww6uzmc7dintpird7b4ayq@6cgrsqyy3xg6>
In-Reply-To: <acaahpfoyy3rci6ekfw2l3i2k5jpww6uzmc7dintpird7b4ayq@6cgrsqyy3xg6>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Thu, 24 Oct 2024 14:13:07 -0400
Message-ID: <CAN+CAwMkfBVnLqHX7HBJ4gEw96mUXaSydE+Qu5OH+6CSL_G5pw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	roman.gushcin@linux.dev, muchun.song@linux.dev, lnyng@meta.com, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 6:17=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Wed, Oct 23, 2024 at 01:34:33PM GMT, Joshua Hahn wrote:
> >  include/linux/mmzone.h |  3 +++
> >  mm/hugetlb.c           |  4 ++++
> >  mm/memcontrol.c        | 11 +++++++++++
> >  mm/vmstat.c            |  3 +++
> >  4 files changed, 21 insertions(+)
> >
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 17506e4a2835..d3ba49a974b2 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -215,6 +215,9 @@ enum node_stat_item {
> >  #ifdef CONFIG_NUMA_BALANCING
> >       PGPROMOTE_SUCCESS,      /* promote successfully */
> >       PGPROMOTE_CANDIDATE,    /* candidate pages to promote */
> > +#endif
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +     HUGETLB_B,
>
> As Yosry pointed out, this is in pages, not bytes. There is already
> functionality to display this bin ytes for the readers of the memory
> stats.

Ah I see. I misunderstood what the _B meant, I didn't realize that it's
used to denote what the units of accounting were, not for exporting. I just
checked the functions that Yosry mentioned, and it makes a lot more sense.
(I also should have known, the method that I'm using to do the accounting
is called "pages"_per_huge_page)

> Also you will need to update Documentation/admin-guide/cgroup-v2.rst to
> include the hugetlb stats.

Thank you for pointing this out, I'll update the doc to include hugetlb sta=
ts.

> >  #endif
> >       /* PGDEMOTE_*: pages demoted */
> >       PGDEMOTE_KSWAPD,
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 190fa05635f4..055bc91858e4 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1925,6 +1925,8 @@ void free_huge_folio(struct folio *folio)
> >                                    pages_per_huge_page(h), folio);
> >       hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> >                                         pages_per_huge_page(h), folio);
> > +     if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
> > +             lruvec_stat_mod_folio(folio, HUGETLB_B, -pages_per_huge_p=
age(h));
>
> Please note that by you are adding this stat not only in memcg but also
> in global and per-node vmstat. This check will break those interfaces
> when this mount option is not used. You only need the check at the
> charging time. The uncharging and stats update functions will do the
> right thing as they check memcg_data attached to the folio.

Sounds good. I'll go back to make sure which other parts of the code
I'm touching
with this patch. Thank you for your feedback!

Joshua

