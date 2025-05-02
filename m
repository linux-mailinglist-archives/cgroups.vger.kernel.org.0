Return-Path: <cgroups+bounces-7994-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6567AA7CAC
	for <lists+cgroups@lfdr.de>; Sat,  3 May 2025 01:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD5F7A3F79
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 23:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4C6223DDC;
	Fri,  2 May 2025 23:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBTKg/a+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754ED21A435;
	Fri,  2 May 2025 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746228536; cv=none; b=aKLFqHEzxJrEZhq7E0om/hKkfX2ABO4a3cHc0UTa0+kvGzU5G3NaQqaR1yTNF0oYxBBTJPfNlFD5Clbiu4vGeYCtClXkMeEbkFexCqCFa55IUD7PWBF0gZYSx8yFLpHa04vS9kv4ZYIpjTxVhU2s1RLprUHAcfoinkvNGX7nEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746228536; c=relaxed/simple;
	bh=nvcnVxQ8mkmBuPkKOUM1JReoQkJkbcWkplexO2snD4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rv8YhATCIyjotQZ18ThSbgRMwjhB3Jpzxd6kUDf/gTJmv/QDkSMN9W1La4O4pg2EotzjNWH6gqhh7QCF67KhQghDK/f9ZKnvKMd9uXeYwPrNgzpHbLmOHnXBMymQACaPjxQ+KbXp+mvg77oyYShviPblKmxfUT7k985G2E+hToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBTKg/a+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso1586764f8f.1;
        Fri, 02 May 2025 16:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746228533; x=1746833333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5Y/kDAPZ2CZYOoK7lx97X9msDYYLQQQiBCs0XHK4jM=;
        b=fBTKg/a+yyr+G7UGFsf82hLhbtv1cHJtV0kWJNDRTtT/Prd+TT9b0VS1+4PuusUDzb
         BTVlZ4fLh8IOnlcYCPz2j7TC8E2n98LUHyixh3Wg0vs7TqfVCsVitgkxPVAKwrXSrVhX
         DzweQElcRPUbWugjC94MZHWj8x6RLnyEnBP7G7zVEOmUn5oYUN4qMx54xlpv/dEwHulC
         UJek98hxWElrdR5MvklHfiVSvikGoFexq4yPfxz0zFcO6u24VJ/aMyzAQ1NS8be0XqPd
         xVuUEI23l2ENqt9d2GsmuA+LWJglPwUbn/YUDHLtG9O083rK7GnqMZgS/PPDp/LPVb9s
         9EjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746228533; x=1746833333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5Y/kDAPZ2CZYOoK7lx97X9msDYYLQQQiBCs0XHK4jM=;
        b=PTlCKwgSuk0B7Esfk70vxVIHuCDucDRer+1AoE4XCiLaWuBqzq+zJpDU0AdjZNFFWj
         l7AbjSu9pXjyNRzwHZd4Rrj3z5nTU+YpC3/yWBNL7uXaUF0jvcdKoUN5il/qs73NgPcP
         liaqIJCcn7Hmk53hgrlrBkZKSejZRlV1bFbmAVO3A/IKuFUUrACzfjnbT9UmcDaMjOXO
         gUxHqm5KJKfGTms0LXylru6O1voys8dpH0BV4qAo+TZOwb9yXpEJIqOrzKUmEhGjwFJ6
         UHngRj+UAQd46LVsnZb+n18kN8kMajdRNADQWogEzfqxCts9RaXqWNFtMUmE1NGqN40U
         xuaw==
X-Forwarded-Encrypted: i=1; AJvYcCVSSdD/wJQHrBcmk8iz5QKQLmHN65okMMVovN3CPNoqf16QJgOyPeYmKxy+I7ovr+984956jkic9w==@vger.kernel.org, AJvYcCW3EIjpCK/xYo9LbOZKLRdCIx4U8wRIwN5UrRP2Y61IeigD9wzGJhNEBvXkI+ClSS5dbKKFl4p9yo4fHVJ+@vger.kernel.org, AJvYcCXsrssxwmZbxgJ0Rmr47Y5HvB0qLL82UN7fOgyiTBeU3H697jF53ai1O2eVrvBUFnieLbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cPhanYjGpk+Bfu6TQrC3cW1zqraD1jrRDCCjaxUZeRrhRVPb
	vNQzUvfjNkLLfUZwNP2w6Qjdx4OCljsfUL6r+wZ7xHR9plP8jDmI7VLqgQHkuNj5jGDirpm0vLg
	cK0KyixOFhd5EZKZ6UAm9uroNXko=
X-Gm-Gg: ASbGncsAYcFEDOY9+pLnaTHLjFvrq/nMFWK381PTW8yniv3oNGz+O56XeFH3bKxOydB
	uIiByaJjFR7yFNFT0UyDxNb28VXN7xuPMwFZTNTFMfI8dwV8kTq+V005k5Wm0DmeQ7SXWqJmUrG
	ZtEoVtM66ySZBC/K8vpMo/jCJ/8NI+Vd11iMuhTaUCtgkR2HmxdQ==
X-Google-Smtp-Source: AGHT+IHahTU3EsKjJS4KqWDLrHSw8tBkBTgO/rSSEgaMpl4WxL15g4KW6c6VsUGT/meziHY4zl3UdemkSxNBn99UoQ0=
X-Received: by 2002:a05:6000:4009:b0:39c:2678:302b with SMTP id
 ffacd0b85a97d-3a099ae972amr3369768f8f.45.1746228532438; Fri, 02 May 2025
 16:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
 <20250502001742.3087558-4-shakeel.butt@linux.dev> <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
 <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com>
In-Reply-To: <CAGj-7pWqvtWj2nSOaQwoLbwUrVcLfKc0U2TcmxuSB87dWmZcgQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 16:28:41 -0700
X-Gm-Features: ATxdqUHDXke86Kdeln5DJ1QQfuaMZgpak68ymkpjleDqI7ms9r9I1efg5Nota0k
Message-ID: <CAADnVQ+dhiuvrmTiKeGCnjDk9=4ygETJXR+E4zQr5H2MzBLBCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memcg: no irq disable for memcg stock lock
To: Shakeel Butt <shakeel.butt@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Meta kernel team <kernel-team@meta.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 4:03=E2=80=AFPM Shakeel Butt <shakeel.butt@gmail.com=
> wrote:
>
> On Fri, May 2, 2025 at 11:29=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, May 1, 2025 at 5:18=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> > >
> > > There is no need to disable irqs to use memcg per-cpu stock, so let's
> > > just not do that. One consequence of this change is if the kernel whi=
le
> > > in task context has the memcg stock lock and that cpu got interrupted=
.
> > > The memcg charges on that cpu in the irq context will take the slow p=
ath
> > > of memcg charging. However that should be super rare and should be fi=
ne
> > > in general.
> > >
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  mm/memcontrol.c | 17 +++++++----------
> > >  1 file changed, 7 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index cd81c70d144b..f8b9c7aa6771 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1858,7 +1858,6 @@ static bool consume_stock(struct mem_cgroup *me=
mcg, unsigned int nr_pages,
> > >  {
> > >         struct memcg_stock_pcp *stock;
> > >         uint8_t stock_pages;
> > > -       unsigned long flags;
> > >         bool ret =3D false;
> > >         int i;
> > >
> > > @@ -1866,8 +1865,8 @@ static bool consume_stock(struct mem_cgroup *me=
mcg, unsigned int nr_pages,
> > >                 return ret;
> > >
> > >         if (gfpflags_allow_spinning(gfp_mask))
> > > -               local_lock_irqsave(&memcg_stock.lock, flags);
> > > -       else if (!local_trylock_irqsave(&memcg_stock.lock, flags))
> > > +               local_lock(&memcg_stock.lock);
> > > +       else if (!local_trylock(&memcg_stock.lock))
> > >                 return ret;
> >
> > I don't think it works.
> > When there is a normal irq and something doing regular GFP_NOWAIT
> > allocation gfpflags_allow_spinning() will be true and
> > local_lock() will reenter and complain that lock->acquired is
> > already set... but only with lockdep on.
>
> Yes indeed. I dropped the first patch and didn't fix this one
> accordingly. I think the fix can be as simple as checking for
> in_task() here instead of gfp_mask. That should work for both RT and
> non-RT kernels.

Like:
if (in_task())
  local_lock(...);
else if (!local_trylock(...))

Most of the networking runs in bh, so it will be using
local_trylock() path which is probably ok in !PREEMPT_RT,
but will cause random performance issues in PREEMP_RT,
since rt_spin_trylock() will be randomly failing and taking
slow path of charging. It's not going to cause permanent
nginx 3x regression :), but unlucky slowdowns will be seen.
A task can grab that per-cpu rt_spin_lock and preempted
by network processing.

