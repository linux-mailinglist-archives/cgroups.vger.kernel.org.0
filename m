Return-Path: <cgroups+bounces-8251-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A3ABAAE9
	for <lists+cgroups@lfdr.de>; Sat, 17 May 2025 17:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19391178931
	for <lists+cgroups@lfdr.de>; Sat, 17 May 2025 15:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C42207A2A;
	Sat, 17 May 2025 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATGkaD1y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51FF1F463A;
	Sat, 17 May 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747497038; cv=none; b=I5kx/Um+c1UXKd1icF0BWhWundpmAiZenox8wwlLImr9pCQl9nmU5oBknLdev5kszRwg8A4nDaW3wrIcj7GFEHisuZugwUv6Obrr7bIcFUtslxhWtUybLb1ji7cnFUa4+CXdbtaH4sLd4XWN9GGSidouai4+GY1u0RoZXxkNDi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747497038; c=relaxed/simple;
	bh=XZpIZNH9Ye1SFU2YgzNdnEpG9S1a+JCHTpEyymIpvbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKbGqGN6u2tmJKV6iQEwC1lwRbTmO0sioWmActi1LSWt9fb5+NrTJYUh+pVmtaILADVp0Lo5E8okbpkbDlfPGtljvnA+VTNkyr+csoSXKAhU6PWXx9u+Frd3crOn9w/TA5QUfkYd3TKNmzP2NpVKztB69uP2DjFmtoHVkLhjnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATGkaD1y; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so774998241.0;
        Sat, 17 May 2025 08:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747497035; x=1748101835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H1yH4AbSfMvCF5lDaIZcSmucQx4bL/RGtGJ0jzRozc=;
        b=ATGkaD1yPny9pb77ziOatENzog5YQvZDTegELUHJIhdXTWAgLqRilHDmH8BiyMde64
         2Gyce1peGSjQACd5V3dTFaWg/85+TKqHzcxsK1LEFL2DEDQOBaoxqn0+QlKDlp+5NHzg
         9xmq0CJ71tNxvfJJBzo8erWQ+cM35t2R1cRWBtt4Pj+p0ZEQZBDz+YXia33sj3iJQ1ER
         2dYMAGCt1MkZtPo8bbAvmOAX2jKbpuJFu1cZoF8QT9uk/NSVZRUgNjskBgcXs1P9DZKC
         /kqGgssg2SHeAoTRY7Y16bmUeG7EFQ0/5PVNuJqNzxQvYc5XDW6S9DzR4VP9q6RuCFcw
         D6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747497035; x=1748101835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H1yH4AbSfMvCF5lDaIZcSmucQx4bL/RGtGJ0jzRozc=;
        b=oTwFNOyhsVCC9axP0XBov1W7psZe+dm9+GIhi6/kT5Bf0G3cJWtKeBLfUoidcR5Fv7
         +X+e6MPhcD54UhQAmKfpjlAW5pP+MC3LjSoB4XEjHOMeqIUY7RR1YGDwxMJtmwN/NWI2
         Z6lrHZioRJbRyxQtfFFw9/LZzzcL6+6fAfERWCC/b81mLktWIc7RGzt25snxS3Q78Koh
         6FpGhmBj42I0gd29no2VyINXdsD5lGeBE0gRqkQxd3UMpaDICJeX4FgjdBeN7x+SQ1GX
         qLxRCcBs36cR5wjIXQSXk88Fa2SVU5r7FkOcCEUvnW9spYb1DK+L0B5WjjQ2aT5Le9C5
         lcQg==
X-Forwarded-Encrypted: i=1; AJvYcCUSzu/vzTJnauGQvTTQNDomDr2LtxnVKR5bkK8TA8UoSflMJ1RghS/PGtUZL9NmfYhUnAlrLnhkWg==@vger.kernel.org, AJvYcCXcoQGUsHvSmsQQdE3VfI8RKIZF8gSruuci8S4aCqzz7C8T4hNWWNxanoxu+1JPJfX1Uyk=@vger.kernel.org, AJvYcCXhX7ovnFdGuDYWJI5aEquBCCeTsKgi+sHgBO8zG5HP53/pleL6QW07FPNA3PCNFNtXH/8c33AMwHB8j6gj@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkKyg8JJeqoovD/S7sV/5EPrGJ/+wb4vc0Q1RjwxJtUBzTgyw
	7qzGz9Dbf8f+FrGmku26moBVZLAv5uIXXskqrfoQ/M+y887KzfcpcpHq08Dz4ipX+j/amBcjVGi
	GT51xyrmS/tAZDVHqK6J3HoqRU7C4lX4=
X-Gm-Gg: ASbGncs6+6njo9uhOZ48IUP9TdrPhub5jcNQPvokbNU0fjbMV3rI3UrR+Us/+p7t1TP
	gYe43TZ0wONcDEnA9dcjussDH3VTbJ84VPIr4RPlxxHBtH/XAoV4V9SdgF+jKt8Hqv8rpbCow4f
	q4tnVn7fRIWgVu2rGxeiM8OaUoR7/g9CgjA7Uw/x01ug==
X-Google-Smtp-Source: AGHT+IGPfaRkmLN5E2QpUx4OuFhuWdS+rY7He9e0e+Te3ATYw6mGidu5QaKvX13cASqWwLke8CCV21NpNOXW2AGxJ30=
X-Received: by 2002:a05:6102:570d:b0:4c1:9695:c7c with SMTP id
 ada2fe7eead31-4dfa6c56bffmr8650858137.24.1747497035264; Sat, 17 May 2025
 08:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516183231.1615590-1-shakeel.butt@linux.dev>
 <20250516183231.1615590-2-shakeel.butt@linux.dev> <20250517140613.GB104729@cmpxchg.org>
In-Reply-To: <20250517140613.GB104729@cmpxchg.org>
From: Shakeel Butt <shakeel.butt@gmail.com>
Date: Sat, 17 May 2025 08:50:24 -0700
X-Gm-Features: AX0GCFvybgsf65nJPdKxogM_gbxXN8TtbmaSBctrp2g5_gqMUzrZuFpFqdCIIqE
Message-ID: <CAGj-7pXtRMKmx0Qm6DX2W3=s5iuRTCFs311YtGOi4wreuviiBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] memcg: disable kmem charging in nmi for
 unsupported arch
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Harry Yoo <harry.yoo@oracle.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 17, 2025 at 7:06=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Fri, May 16, 2025 at 11:32:27AM -0700, Shakeel Butt wrote:
> > The memcg accounting and stats uses this_cpu* and atomic* ops. There ar=
e
> > archs which define CONFIG_HAVE_NMI but does not define
> > CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS and ARCH_HAVE_NMI_SAFE_CMPXCHG, s=
o
> > memcg accounting for such archs in nmi context is not possible to
> > support. Let's just disable memcg accounting in nmi context for such
> > archs.
> >
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> > Changes since v2:
> > - reorder the in_nmi() check as suggested by Vlastimil
> >
> >  include/linux/memcontrol.h |  5 +++++
> >  mm/memcontrol.c            | 15 +++++++++++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index f7848f73f41c..53920528821f 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -62,6 +62,11 @@ struct mem_cgroup_reclaim_cookie {
> >
> >  #ifdef CONFIG_MEMCG
> >
> > +#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || \
> > +     !defined(CONFIG_HAVE_NMI) || defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
>
>                                              CONFIG_ARCH_HAVE_NMI_SAFE_CM=
PXCHG?
>
> > +#define MEMCG_SUPPORTS_NMI_CHARGING
> > +#endif
>
> Since it's derived from config symbols, it's better to make this an
> internal symbol as well. Something like:
>
>         config MEMCG_NMI_UNSAFE
>                 bool
>                 depends on HAVE_NMI
>                 depends on !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !ARCH_HAVE_=
NMI_SAFE_CMPXCHG
>
> >  #define MEM_CGROUP_ID_SHIFT  16
> >
> >  struct mem_cgroup_id {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e17b698f6243..0f182e4a9da0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2647,11 +2647,26 @@ static struct obj_cgroup *current_objcg_update(=
void)
> >       return objcg;
> >  }
> >
> > +#ifdef MEMCG_SUPPORTS_NMI_CHARGING
> > +static inline bool nmi_charging_allowed(void)
> > +{
> > +     return true;
> > +}
> > +#else
> > +static inline bool nmi_charging_allowed(void)
> > +{
> > +     return false;
> > +}
> > +#endif
>
> ...drop these...
>
> > +
> >  __always_inline struct obj_cgroup *current_obj_cgroup(void)
> >  {
> >       struct mem_cgroup *memcg;
> >       struct obj_cgroup *objcg;
> >
> > +     if (!nmi_charging_allowed() && in_nmi())
> > +             return NULL;
>
> ..and finally do
>
>         if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE && in_nmi())
>                 return NULL;
>
> here.

Thanks Johannes, will do in the next version.

