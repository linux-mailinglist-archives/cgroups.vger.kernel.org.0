Return-Path: <cgroups+bounces-8172-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DDCAB5F47
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 00:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD2A4A1F8E
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 22:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD7120CCE4;
	Tue, 13 May 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W94iHPgP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4B20C461;
	Tue, 13 May 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747175145; cv=none; b=B4W6i/gqrO2QucwRcHntEahYd3tXoaeXV97Hs0eu+fcX9LcJkpPs8XosPshY2+jxbeREOV5bQkniuggHS6KSRi45L+dEN2C22kD0MQhuBNB8sIbdzRyZPnudLlFLvOkftotVCvGygQuYnXpD5g08R37UhTrY1TGtydE2MNwp/KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747175145; c=relaxed/simple;
	bh=rf3JppW/78wO/r4B/y0eX4WT7rbL9KH6NSFoGLZ/3Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZF5qupP4w3u3CRCVHgBiSWy0sGOCg5I96L/jwyFVZ06Lc2xDpcc3b+mZ+lbqtT8YQpuvM48rFcO796Xzs/FDjTwdCZgKQtadkIEac77AfS4BrL1CQtXHw/rLrjDEIW9fqaNUSQ2x00cKPa8kCfuQlAM/imRYZlVM7gfBd9NEOk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W94iHPgP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a108684f90so3753202f8f.1;
        Tue, 13 May 2025 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747175142; x=1747779942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAwr1O0koPzIlKh8epOygSIaJtugVEfkRrBmy7awSbw=;
        b=W94iHPgPJz/INngo0cRpnhtWyjCUrDSuU969bPC3SZCkg4QLlB4bUabuaMGw9vB2YL
         rFZXONTEsy/ATGwR8a3B0C1vEeNvHQdu6JroeCBXsU5Axsfgc88XkaCZKDcvY/ycc/RS
         FW0lA72pKufLy+rIikDlmaYdhGzy7r5mEIWSwrcoPdSGY3CAc7dZeGJ5Tg8PQEmiA/xx
         rklBm4KvN6ZJZcwBc4ApKGCUMPIIR7URNvN1sIh8qcOLuQeKB2ogbGwcpJpMUDd6ZAhe
         Czjl8Smd3cosAGUXYrCcLWJL2+zGsmVRDfRdlEGWfTMkZNr5WZnqbXJom2X7GdoQRfqP
         FMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747175142; x=1747779942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAwr1O0koPzIlKh8epOygSIaJtugVEfkRrBmy7awSbw=;
        b=PkFg+ktOKngMwKFbBoitHafYWlJUpYTexVzvdmIe7fym0XYQRysgR8drK3tGHn+XBe
         zISSDcH5Yx/LX5leYlJkYoZI0nAbNcvOx2ahXcVeaOsCBQSJliW2iLHKBQHoVTI8z33w
         W3FONirhkdjBnLQRStIRGhjUrGXTA9nhodz/+1XCFx2dtrGChhApDQXmbWlYpFt16pSC
         s0kWcUnmzocM+iPjLA7eMXHy1zv3Jz06tdrvL7WdEd7JUQowbkHDtx/sI3yKTu4Ssq3v
         vgZHwS1TMN+p1ivxQUzifg5n9p4WyczDqDLUxk1JrmJ5NYXNBiYSot0jMkF3jw1j82l4
         Do+A==
X-Forwarded-Encrypted: i=1; AJvYcCUSTbNd9SGY1uEFZNzWEpoZPQWNDpjTtWUDQ7/p4g5TLcumPsuzF5zrV8Cp9QJPZgytaTA=@vger.kernel.org, AJvYcCUh8SmE56CWg0Z3wY61BPIIYPhoSZdT5n//iDeuBmGhndOVBEl40EmVXi5Q8pF2cGr00uSs+Pw2Og==@vger.kernel.org, AJvYcCXZ6RgE7ONlGdYLS4uKSjDapGRe43cntP+dD1960Vx55jSj24wb0/V+yxE3Ecp6fHylR/95tS6qjHbERopB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+2xpPKY9cXwGFyl/aEKVU05ACEJiOAjzQlYGCDp8BaDVkYP/P
	p7HNUeWbidrjiXeRlSppAqKMPuWSyIkAWJF3cUkxmUeldO5kFlHaCvM8WU/sLq24YYvZH8xXmAZ
	Kl6dd3lEAXDXF4jmSWsk5D2UUcPk=
X-Gm-Gg: ASbGncvGrKpNRVcFWOOtilzbFfw0ERNRN4jL8Gt3CygJGqqqmbptKCFGH1UhHHHOBMF
	DZSLVyAf/Bmjl5h3aOjsSXhwCTQ5i5l7qAN1GjUaPzq+KB5iv6gYPKOoCOxD8M9Plg+2WvLC3rC
	pbpXQKd7H18KOwTOKgpw90dwPf/GhpJOzpGBRcb6GALe7WeHH7ZfzhHZNYZ1Bv8w==
X-Google-Smtp-Source: AGHT+IGCSV1CW2V8g3e0buvKmCKp4+U6DS5ChJ8qy9B6coY/qGEWuanukGv1ONA7/0rEN2Xci8nFgq7f5PO+enTp454=
X-Received: by 2002:a05:6000:430d:b0:3a0:b4f1:8bd1 with SMTP id
 ffacd0b85a97d-3a3499532b6mr669366f8f.52.1747175141983; Tue, 13 May 2025
 15:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509232859.657525-1-shakeel.butt@linux.dev> <20250509232859.657525-5-shakeel.butt@linux.dev>
In-Reply-To: <20250509232859.657525-5-shakeel.butt@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 May 2025 15:25:31 -0700
X-Gm-Features: AX0GCFu-xAuvef9BfHGE2CGCgnqITmOEvaYA7dWvW7qUfVnFWb0NhsjFDSFfKcA
Message-ID: <CAADnVQ+8w7huzJFqqm40KVetnQC-SoFKSMjq2uJHEHuAkCR7YA@mail.gmail.com>
Subject: Re: [PATCH 4/4] memcg: make objcg charging nmi safe
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 4:29=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> To enable memcg charged kernel memory allocations from nmi context,
> consume_obj_stock() and refill_obj_stock() needs to be nmi safe. With
> the simple in_nmi() check, take the slow path of the objcg charging
> which handles the charging and memcg stats updates correctly for the nmi
> context.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/memcontrol.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index bba549c1f18c..6cfa3550f300 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2965,6 +2965,9 @@ static bool consume_obj_stock(struct obj_cgroup *ob=
jcg, unsigned int nr_bytes,
>         unsigned long flags;
>         bool ret =3D false;
>
> +       if (unlikely(in_nmi()))
> +               return ret;
> +
>         local_lock_irqsave(&obj_stock.lock, flags);
>
>         stock =3D this_cpu_ptr(&obj_stock);
> @@ -3068,6 +3071,15 @@ static void refill_obj_stock(struct obj_cgroup *ob=
jcg, unsigned int nr_bytes,
>         unsigned long flags;
>         unsigned int nr_pages =3D 0;
>
> +       if (unlikely(in_nmi())) {
> +               if (pgdat)
> +                       __mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
> +               nr_pages =3D nr_bytes >> PAGE_SHIFT;
> +               nr_bytes =3D nr_bytes & (PAGE_SIZE - 1);
> +               atomic_add(nr_bytes, &objcg->nr_charged_bytes);
> +               goto out;
> +       }


Now I see what I did incorrectly in my series and how this patch 4
combined with patch 3 is doing accounting properly.

The only issue here and in other patches is that in_nmi() is
an incomplete condition to check for.
The reentrance is possible through kprobe or tracepoint.
In PREEMP_RT we will be fully preemptible, but
obj_stock.lock will be already taken by the current task.
To fix it you need to use local_lock_is_locked(&obj_stock.lock)
instead of in_nmi() or use local_trylock_irqsave(&obj_stock.lock).

local_trylock_irqsave() is cleaner and works today,
while local_lock_is_locked() hasn't landed yet, but if we go
is_locked route we can decouple reentrant obj_stock operation vs normal.
Like the if (!local_lock_is_locked(&obj_stock.lock))
can be done much higher up the stack from
__memcg_slab_post_alloc_hook() the way I did in my series,
and if locked it can do atomic_add()-style charging.
So refill_obj_stock() and friends won't need to change.

