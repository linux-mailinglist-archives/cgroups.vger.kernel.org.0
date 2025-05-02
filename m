Return-Path: <cgroups+bounces-7991-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E11BAA7945
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 20:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A894602E4
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F44A1DDA24;
	Fri,  2 May 2025 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO6IWdf8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B663C15350B;
	Fri,  2 May 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746210571; cv=none; b=oKgQPQQ2KdgiKUEJ0cs1L4nAHDcG1ZnHOO8W82rmE3v2X1ktN2yOwHLNi++piItLIesat89wNt7pxU0vCr0FCD1fpS58auy17mIzS6VUic4BPRCobjuOvl07XsDptUytYXsb5rX2vLqktLLCiJybhFuU45QvUHEL6Hf03TKcQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746210571; c=relaxed/simple;
	bh=mQDY/AJR/89Z2jexEMxyjLo7VznybV3SxIwQ6cA0Cl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6U36SatgYwMqCVOlRCwINpmAUrVtGpgbAJXOveoWj5qsYt466K5SnlTlfYwKeT0J3mROTMQNbCXp+my6ZENzofXxUPDAiLaXJ+fjZpjav9nZyusPq6BoAqdghmH4aP8LfR5DtOHHoby5LJURAvr8EJWmlrHuMGUfHr2mkxINz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO6IWdf8; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so1379521f8f.3;
        Fri, 02 May 2025 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746210567; x=1746815367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFHm1tfv35vyjBSvb7AN3OxjMGjn0tT8+FpYF9gx+rc=;
        b=CO6IWdf8gARLteDIxormqgTLFueeulguIjXR4CQ0CnGKiD/fodsI8DzFKJO5yt+rjQ
         CI2YMD9YE1DPtK+/qoIHm6xNQLLIYZLI5zge/WAvIimlrX+k5wtlt3kLfUoOHyyMEL8+
         qgL+0/oJhCBxxvFlzZSeMFpMVA9hpahmjjsoptIds7QiMncrrY3AQbgmVVvtHURwE/Fd
         vW4Sgw1i1UdnD1TcPevyi/mOmlaRq8aWI3Qkbw7PQU7hd/h+3Lj/gzLMBOwygqwU4InR
         Sv+4aSarK+jA/Oc7Aak7nf+Fg635+/OIAXhW4rPy2MSjwIaTuFbO+TvNb85JgKLbC0w+
         9vEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746210567; x=1746815367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFHm1tfv35vyjBSvb7AN3OxjMGjn0tT8+FpYF9gx+rc=;
        b=P8kTxn6a1+/KuDszcw+XXlFHg954PBbHVdwUihsFdY9N2AXDD1nu2vQgerSLMXH6ge
         xbhPVLeFAi0Qpmg7ETh3bE7g6Y5j1EZniUNoGO+nPK7HHd7WrKB08BNc1vZrvC4FGFgl
         NtSapb0x0u6zR8ILA3CyNiGht188dGQgmYWo3rMipKMqBj3Fnp5oImXbVrG7kNodiETI
         MHwyRcubz9GiqLwVItbFpWBRAqX0bXUpyuBFfsKsCrcOGpH9pGr54vLiTnEeupOodwUK
         kJuSHsAN6L9E0fjrG7dEPlTorC33sK6kazhKgWHwn1mF0TTYhejh2stRKA3Gg8OdIz0/
         U/dg==
X-Forwarded-Encrypted: i=1; AJvYcCU185cVMm+M6y52mmCiJPHCqzbMIfCESXK71udifi+r2677VTRY/Fm288z8iIc5hWsQob0lOCHKjg==@vger.kernel.org, AJvYcCUm3w5zmKCm1yLB4YnwsWmU7lxCEAYKelbIORzwK6eJome8OwxnbWqtPim5jvy1rvHYylo=@vger.kernel.org, AJvYcCVBVXEusKS2CaoPUze5bSBE84uKXh6/NmBvDo2AaO5l2ZkMWARXbZCVVL24I9YihhzfYv7fqf44WaspSzpZ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywttq/gCdx2McM95OUsmsh77RIdbvVNc5z8LZqBah9ZhmKwAc+F
	e7wKiKr3myTLRoApEPS6iVr30Ce1bPC1+D0KxHOXloDaSPC1/8jz0X9ANGqiNVhQDrrH9yFgLKe
	N/rJnccbch8veTN1uc+q/Ho8FIXg=
X-Gm-Gg: ASbGnctuNh074oKK3JuPpKOGMHxq+BDacB63BYrCEiC3zk6JCz2OS/R04N4yeFAHQNg
	9zL5JyNYup5saTh1ZU1OSo/US+6Of13q6Da8km6O8fCUO5esDLyTDlIcu3Z/o9r1h674vztp4DS
	bphqKs4b6ybakHRTSBwge5+JWvCLjHu0IstbfpSA==
X-Google-Smtp-Source: AGHT+IGZDVjNbQY0k7XiguUPy1qRwoEN4lzehDc7xAB6HtEldTcvHbiAVFR6uTiVw4aghdr0oalOFquu/9roPKdUkII=
X-Received: by 2002:a5d:5984:0:b0:3a0:99e9:bcd7 with SMTP id
 ffacd0b85a97d-3a09cea72c1mr184420f8f.5.1746210566946; Fri, 02 May 2025
 11:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502001742.3087558-1-shakeel.butt@linux.dev> <20250502001742.3087558-4-shakeel.butt@linux.dev>
In-Reply-To: <20250502001742.3087558-4-shakeel.butt@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 2 May 2025 11:29:16 -0700
X-Gm-Features: ATxdqUHqug0Pj9O_29hq5eWY4vn7NLIM1dbUiX1mC592l5Jn0vudNn1sTCMtTQE
Message-ID: <CAADnVQJ-XEEwVppk-qY2mmGB4R18_nqH-wdv5nuJf2LST5=Aaw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memcg: no irq disable for memcg stock lock
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Meta kernel team <kernel-team@meta.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 5:18=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> There is no need to disable irqs to use memcg per-cpu stock, so let's
> just not do that. One consequence of this change is if the kernel while
> in task context has the memcg stock lock and that cpu got interrupted.
> The memcg charges on that cpu in the irq context will take the slow path
> of memcg charging. However that should be super rare and should be fine
> in general.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/memcontrol.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cd81c70d144b..f8b9c7aa6771 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1858,7 +1858,6 @@ static bool consume_stock(struct mem_cgroup *memcg,=
 unsigned int nr_pages,
>  {
>         struct memcg_stock_pcp *stock;
>         uint8_t stock_pages;
> -       unsigned long flags;
>         bool ret =3D false;
>         int i;
>
> @@ -1866,8 +1865,8 @@ static bool consume_stock(struct mem_cgroup *memcg,=
 unsigned int nr_pages,
>                 return ret;
>
>         if (gfpflags_allow_spinning(gfp_mask))
> -               local_lock_irqsave(&memcg_stock.lock, flags);
> -       else if (!local_trylock_irqsave(&memcg_stock.lock, flags))
> +               local_lock(&memcg_stock.lock);
> +       else if (!local_trylock(&memcg_stock.lock))
>                 return ret;

I don't think it works.
When there is a normal irq and something doing regular GFP_NOWAIT
allocation gfpflags_allow_spinning() will be true and
local_lock() will reenter and complain that lock->acquired is
already set... but only with lockdep on.

