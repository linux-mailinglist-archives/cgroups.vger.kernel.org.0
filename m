Return-Path: <cgroups+bounces-7993-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9BAA7C96
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 01:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AA684C6DA0
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 23:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70F221D88;
	Fri,  2 May 2025 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYw4ls3w"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBC13D2B2;
	Fri,  2 May 2025 23:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746227024; cv=none; b=I5CCfs8WdidUMrFc9I+sOZoefFinSn9ElR7tRGRsVrujEgmygCBQw6kE/tT6Oh/h+0O8mktmaHHriNs4Q72ZSVCWYeXdCyq0pJLCL5ktgImgXG4YJXXwbF+i50gea9o4B6haL3WH0gU8/IhYXkHwMwYpapibm7etozcXSY4/WI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746227024; c=relaxed/simple;
	bh=AA77U6GaO4Q5u74/L2BeK+b6h057OPxO33+46ch81wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbPC596NwRHVxhAU+6hNhw859n+A3MrFD2HEezdWnJcuNB5a9oGZibT+p83PS4ql13h17S+bDqB2FQfJcbRkMdWM584BEvEHq/eZo7rr0izdvSRsPyJcWxMAEDc3iQ722j0Iuez96GxjnmBvQ7V3W4vU3ca26OX/F9Z/s19UrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYw4ls3w; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523eb86b31aso750415e0c.0;
        Fri, 02 May 2025 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746227021; x=1746831821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn6B3AHvvMcr6eolpyjW+81XwXKNxRn60ZK+73/n3uo=;
        b=FYw4ls3wnphprKwaQDtsSOVoX/YwdnWUXUAyFfbLOIWT7vRD0M797blbD/a4319X3X
         90ApRQ4pwfwnijEbYbkJ/qiDUQbfLSCcdQub11kFqyfTEX1iN4KwCr0qdwDXLnQlhxqd
         ejmUwoSIwZ0fHPN+m6d0Bx8IBfvZ4aLGHFd3nZQXb2C5+uApp06fOJEL6R/GcBXI1Uzg
         tv8pR0mwbkgrfVYzfkjRI2XKvJ3AhodLMsB2rIb7Q2pF8vy8Xcd1VByrJ47MCxSQQqSY
         PwYO4zsPv09YRSYsyQK2SXJ/C9BnISG1R49lNC0OtSutOGBiukKXM1LxKIDq8yQ7Rasa
         I2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746227021; x=1746831821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn6B3AHvvMcr6eolpyjW+81XwXKNxRn60ZK+73/n3uo=;
        b=aPZey9i4XHTHoC15qK5NwpajK4qtUVUJsVp8ZkrOUwgdHdE22xmhu4HCsBOBQoe7A8
         GlyefX7/HyQIkXjMqDszrJp7BiESVmPBJisF8NnEO+lRHJa5Qe3LRiMauwzBvgwVi7vm
         edKEi0vYg5wL9lu8iXp7C6HOwU9rt03amLvw/I5NdIibYDzNAB5kc0i7XoTDp8BWiRWa
         pvmP/5CQ2oTKQK/oKeqlW11ZnG+u6eMc/uXaqw8GU1WgP5n4VZgwuwoIfbSwTn61b2vD
         4okJMQ7vy3OK6YV0CX9K5JKkGJs1RQx4D6F/cyT+qVN/E/7twsVqFkL5cxJrf+XyEqRi
         v/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUPh9SgrxzaMH66zi0+heO4RaZBKw4PPTdURBO7Z9uaDNvWop0x1qNC5c9unLOd3jtLqHc=@vger.kernel.org, AJvYcCV/GCWbMXVD8tixODDzIXoes6EQ7B3y6XSYj4P+5Q+jseDBkwW483e9/YExtV/pKP8dwr1tvy+vhM3MWbTS@vger.kernel.org, AJvYcCX4Vxs2Qy4W4/wdW/foPYTzeJJytRnTLTOOXf5y9TbW0DzIpfbn+67zkbcTfhDKFa/93Z3WbxnLtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/sPFzQg9TzxqHsXiRdmHHdK2Sa1LyYVEQIslVxpq83tutwHD
	+X9xkdPJ592da09dn3qhFVmEx89grnunsb+JfZ0fALId4B+yB42v0AFBPrgyMrMuwr0whSZTeLu
	K+fjBV8lsCPFIKJSqpsGG9VvOr06etBpD
X-Gm-Gg: ASbGncsxedOxQuJku1hRFk1qYAHZ/MmHOjMWE/CNmG7mk1R5Go06FZDAcsOTdR9wbJa
	d8VQp0Y0Ma4qj9oFGJToKQrlNPcDYpWzjGWbGYaMMOnfuWHGL8pqFIqdDNxEv529cuYk0bxID5u
	ucaslId+FqkbHxIUmN6opu
X-Google-Smtp-Source: AGHT+IH0G2Id9h8FEqIRpgtn2ZoY4qQbTOve2FCfTKv5oCcss4LUJcLa2DiY24B4LnysMDQ6AB3BXkTiLNNCUDvEeIc=
X-Received: by 2002:a05:6102:2c02:b0:4c1:8e07:40b8 with SMTP id
 ada2fe7eead31-4dafb50ae95mr3743942137.6.1746227021087; Fri, 02 May 2025
 16:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
 <20250502001742.3087558-4-shakeel.butt@linux.dev> <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
In-Reply-To: <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
From: Shakeel Butt <shakeel.butt@gmail.com>
Date: Fri, 2 May 2025 16:03:30 -0700
X-Gm-Features: ATxdqUGOxZaBfVWDvGw-HOQP1Qz6sM7a4hg3SGcagADyQ1g6wE-GXDaWYVMh1tc
Message-ID: <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memcg: no irq disable for memcg stock lock
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Meta kernel team <kernel-team@meta.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 11:29=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, May 1, 2025 at 5:18=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
> >
> > There is no need to disable irqs to use memcg per-cpu stock, so let's
> > just not do that. One consequence of this change is if the kernel while
> > in task context has the memcg stock lock and that cpu got interrupted.
> > The memcg charges on that cpu in the irq context will take the slow pat=
h
> > of memcg charging. However that should be super rare and should be fine
> > in general.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > ---
> >  mm/memcontrol.c | 17 +++++++----------
> >  1 file changed, 7 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index cd81c70d144b..f8b9c7aa6771 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1858,7 +1858,6 @@ static bool consume_stock(struct mem_cgroup *memc=
g, unsigned int nr_pages,
> >  {
> >         struct memcg_stock_pcp *stock;
> >         uint8_t stock_pages;
> > -       unsigned long flags;
> >         bool ret =3D false;
> >         int i;
> >
> > @@ -1866,8 +1865,8 @@ static bool consume_stock(struct mem_cgroup *memc=
g, unsigned int nr_pages,
> >                 return ret;
> >
> >         if (gfpflags_allow_spinning(gfp_mask))
> > -               local_lock_irqsave(&memcg_stock.lock, flags);
> > -       else if (!local_trylock_irqsave(&memcg_stock.lock, flags))
> > +               local_lock(&memcg_stock.lock);
> > +       else if (!local_trylock(&memcg_stock.lock))
> >                 return ret;
>
> I don't think it works.
> When there is a normal irq and something doing regular GFP_NOWAIT
> allocation gfpflags_allow_spinning() will be true and
> local_lock() will reenter and complain that lock->acquired is
> already set... but only with lockdep on.

Yes indeed. I dropped the first patch and didn't fix this one
accordingly. I think the fix can be as simple as checking for
in_task() here instead of gfp_mask. That should work for both RT and
non-RT kernels.

