Return-Path: <cgroups+bounces-4376-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD0B958B3C
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 17:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71143283E33
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4210197A66;
	Tue, 20 Aug 2024 15:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evl0JXxW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152AF19409C;
	Tue, 20 Aug 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167630; cv=none; b=t9y4z9FDqdMAZAlCqIwH7V1ns1bZs7adJS5DXmHdLS0IW89G7rLEOO0UTdneTP7u3tE9Y5QrLaaW9pkZNaVlKBIEXVHZV7SM31TFXsj3c+aCAJDpQjkmREJ1dSV63lCdoh+DJrGsMSwE5EsZhgqxCm/NI49mtkYa4qCE/tshaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167630; c=relaxed/simple;
	bh=gZP+IJ2zgHHBibjUhw3Vpr0Nbnah+hAk4qlNy/gqYBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOCv4ytIFQ3cqA7WjIRadh17cxSapjL4lad1/s6OCaGo/I000+ULKM0vogGQDd6Nz/yrghiLWPZNh1qI97X2jqeiUxsVtm/pvH+BtoOJ6UUv/IEaxC5rDHkcs8nDTCmjmyKPnVxzj1crjYQx2W7J5pwGqRhM0XkVHNVIOY05jmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evl0JXxW; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5b850d969so3508871eaf.0;
        Tue, 20 Aug 2024 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724167628; x=1724772428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x1BJW8t+s9H7pLyi6ggUxbHvpTGKY4XdDmJLQ/HTPg=;
        b=evl0JXxWLV9WZ+4X/IY8IW4xhODV2XtDFm1DOoeCgt44w/26Ti6WOcdGLv0NNyhT1p
         pHdOS/pxeNpaIAZJpxJZRAiZZ2kePrsS6AAJQMUSqEQY4VXHoqpT7W/sMkZNK5ABtlCF
         VuNMkGJC0GO56cAOlFVwXl9KJxIKf0O1uB+o7MISgCVyaoVbtD6VCWAQmkIzgYP84Ada
         zl/BN3mKzZXw8pDhAL0T9C0hPW8sctkxgYztmxOPPgBXHFQOrU+RdO9Z2sJO2dCRQRfU
         DnsSE6UNCgyw+lQQKR0JKWNa0DvY7xIeNaZOR//BDvP4LAFXsZ9+wEW3NEhs7mzPHT4K
         JUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167628; x=1724772428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x1BJW8t+s9H7pLyi6ggUxbHvpTGKY4XdDmJLQ/HTPg=;
        b=Q5POPnGmvmx0PD3c63uAgC83eTmsMCjUSP81QlsBHrM5lgMg8qBgTHq8LLHrbGIMFV
         MCambxHb8Kuf6uo+/Vh0zD4IcCS8sdgbsvFHAJViiPWc8cGgvd54R0uIHMfPqaTFnspB
         CCQC2URd+mFYjXmx8175clXeiYWk5SibuaU0gALRa+GVESqS8dM3vl2IYRT+6/vHJquz
         f3wwXu0KSExXQXEPzH12hRDLiWIhrYfNANZ5Jsr6K1kYiceiB0y2VQ3WIZ0/Jnb6jrpM
         Dcuz1TYDHmyuZPMsU3SfgKy9K9aRIU9rdygSDUkLr15qmBKKoD1m8waGxLZGHG9M3rIE
         domA==
X-Forwarded-Encrypted: i=1; AJvYcCWIvnF7IW5d6Su/cY4tqq1JxROhHMHbvfDzeFIeCArZdV+13xdBlE/6otUh2rZBE4oFsV6ajuRaCmyeLFKiO9dyYblgmDY4EYpRjOyNPW7IegFseXRem80PqUJbeQn0uPdAJ/V7hA==
X-Gm-Message-State: AOJu0YzE/SxmY3B9HUx1ukz9D8Ds3/mVB3MVSG22qhcfdWPkxS52QdnR
	X+2ix/rLL+oZzyVP5+YhUgFhN6e7D83PU+PHNKjLQ05o+4FfYZ6ZmlpLTQUvr+9aoPxF0YKpKRG
	C4Vj+Q8FVWA+GzGh+XQXn/5c2BeAxmu3K
X-Google-Smtp-Source: AGHT+IFksjA3k9jsKzRmzSa22c9HN/Mi5jzk0E6JpH+6wVtL0SHwf/SVqbuloWKkvFiLGvAZzft3WOUDryAw+ze2w0c=
X-Received: by 2002:a05:6358:7f13:b0:1ac:f058:f714 with SMTP id
 e5c5f4694b2df-1b393291125mr2086011455d.21.1724167627860; Tue, 20 Aug 2024
 08:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816144344.18135-1-me@yhndnzj.com> <CAJD7tkajuiBDV9Hk8Z+f_-f4ZZf81o4CP3LFLVbfZbrvn4RrUA@mail.gmail.com>
 <45e2c372f59748262b6e4390dc5548f8ebf6c41a.camel@yhndnzj.com>
In-Reply-To: <45e2c372f59748262b6e4390dc5548f8ebf6c41a.camel@yhndnzj.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 20 Aug 2024 11:26:56 -0400
Message-ID: <CAKEwX=Mhbwhh-=xxCU-RjMXS_n=RpV3Gtznb2m_3JgL+jzz++g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/memcontrol: respect zswap.writeback setting
 from parent cg too
To: Mike Yuan <me@yhndnzj.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 5:38=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote:
>
> On 2024-08-19 at 12:09 -0700, Yosry Ahmed wrote:
> > On Fri, Aug 16, 2024 at 7:44=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrot=
e:
> > >
> > > Currently, the behavior of zswap.writeback wrt.
> > > the cgroup hierarchy seems a bit odd. Unlike zswap.max,
> > > it doesn't honor the value from parent cgroups. This
> > > surfaced when people tried to globally disable zswap writeback,
> > > i.e. reserve physical swap space only for hibernation [1] -
> > > disabling zswap.writeback only for the root cgroup results
> > > in subcgroups with zswap.writeback=3D1 still performing writeback.
> > >
> > > The inconsistency became more noticeable after I introduced
> > > the MemoryZSwapWriteback=3D systemd unit setting [2] for
> > > controlling the knob. The patch assumed that the kernel would
> > > enforce the value of parent cgroups. It could probably be
> > > workarounded from systemd's side, by going up the slice unit
> > > tree and inheriting the value. Yet I think it's more sensible
> > > to make it behave consistently with zswap.max and friends.
> > >
> > > [1]
> > > https://wiki.archlinux.org/title/Power_management/Suspend_and_hiberna=
te#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
> > > [2] https://github.com/systemd/systemd/pull/31734
> > >
> > > Changes in v2:
> > > - Actually base on latest tree (is_zswap_enabled() ->
> > > zswap_is_enabled())
> > > - Updated Documentation/admin-guide/cgroup-v2.rst to reflect the
> > > change
> > >
> > > Link to v1:
> > > https://lore.kernel.org/linux-kernel/20240814171800.23558-1-me@yhndnz=
j.com/
> > >
> > > Cc: Nhat Pham <nphamcs@gmail.com>
> > > Cc: Yosry Ahmed <yosryahmed@google.com>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > >
> > > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> > > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> >
> > LGTM,
> > Acked-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst | 5 ++++-
> > >  mm/memcontrol.c                         | 9 ++++++++-
> > >  2 files changed, 12 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst
> > > b/Documentation/admin-guide/cgroup-v2.rst
> > > index 86311c2907cd..80906cea4264 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1719,7 +1719,10 @@ The following nested keys are defined.
> > >    memory.zswap.writeback
> > >         A read-write single value file. The default value is "1".
> > > The
> > >         initial value of the root cgroup is 1, and when a new
> > > cgroup is
> > > -       created, it inherits the current value of its parent.
> > > +       created, it inherits the current value of its parent. Note
> > > that
> > > +       this setting is hierarchical, i.e. the writeback would be
> > > +       implicitly disabled for child cgroups if the upper
> > > hierarchy
> > > +       does so.
> > >
> > >         When this is set to 0, all swapping attempts to swapping
> > > devices
> > >         are disabled. This included both zswap writebacks, and
> > > swapping due
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index f29157288b7d..327b2b030639 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -5320,7 +5320,14 @@ void obj_cgroup_uncharge_zswap(struct
> > > obj_cgroup *objcg, size_t size)
> > >  bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > >  {
> > >         /* if zswap is disabled, do not block pages going to the
> > > swapping device */
> > > -       return !zswap_is_enabled() || !memcg || READ_ONCE(memcg-
> > > >zswap_writeback);
> > > +       if (!zswap_is_enabled())
> > > +               return true;
> >
> > This is orthogonal to this patch, but I just realized that we
> > completely ignore memory.zswap_writeback if zswap is disabled. This
> > means that if a cgroup has disabled writeback, then zswap is globally
> > disabled for some reason, we stop respecting the cgroup knob. I guess
> > the rationale could be that we want to help get pages out of zswap as
> > much as possible to honor zswap's disablement? Nhat, did I get that
> > right?
>
> Hmm, I think the current behavior makes more sense. If zswap is
> completely
> disabled, it seems intuitive that zswap-related knobs lose their
> effect.

Mike is right here. It's less of a behavioral decision, but more of a
this-can-confuse-users kind of thing :) At least that's my rationale
when I wrote this.

If users want to disable swap still, they can still do that with
memory.swap.max =3D 0, which is probably better because it would fail
earlier at the swap slot allocation step.

>
> > I feel like it's a little bit odd to be honest, but I don't have a
> > strong opinion on it. Maybe we should document this behavior better.
>
> But clarify this in the documentation certainly sounds good :)

But yes, better documentation =3D=3D happy Nhat :)

