Return-Path: <cgroups+bounces-1111-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3A2829118
	for <lists+cgroups@lfdr.de>; Wed, 10 Jan 2024 00:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9484285B3F
	for <lists+cgroups@lfdr.de>; Tue,  9 Jan 2024 23:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2BF3E494;
	Tue,  9 Jan 2024 23:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HXgeRiua"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478843E483
	for <cgroups@vger.kernel.org>; Tue,  9 Jan 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d5097150fso9365e9.1
        for <cgroups@vger.kernel.org>; Tue, 09 Jan 2024 15:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704844705; x=1705449505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TbM8AUIgVHEHSPyXQawjQZn1xoKY8+QruQ6ShVahao=;
        b=HXgeRiuapsx3bAgHsqfSjzwUR/dp1E1w7Ofd1949Ng56ao2utcdd+r5OrwKIkHFqtK
         osJ2jNRxouZiqjrwiKmz48nUCndnY9JfzEjZx3uxJc9p1RpsoznJSdRfvBF8zGwGX9dZ
         exYKWXFPO5M0t4mkGcs1t02xGOvtRga33n1p4J/q+Vfqmf+bGK9oOmbZ+z1LysNN6Hq+
         wpAspA4cakimhTP9gCZGakd1FL5LQgUxhMJyR4N+x+13xoDYh2yixDZN4kUA/E3vbqwx
         9kudYkVSdZetD997BzpdAsq0mewL2oaFhVWvnv56Gdeg42ffSp1wBqGSZlx/B5BYm6yx
         7wwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704844705; x=1705449505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TbM8AUIgVHEHSPyXQawjQZn1xoKY8+QruQ6ShVahao=;
        b=l6tXnnFCcMI73WVOGZqqw5uid44VEqabqTyER0H6gTqX2ajW527a2WyXHEbU9NeqFc
         d0aY+6ubpjDEqfKn2evLIKQO5xlIEWrnCVrfnVRjntaKnqkt3bqAgjpWyJDciwQuClTQ
         wh1OQtX71yheTWEmckSUwT09LwTL5Q8r5h+079ZDky2JAqWlSBDrnUHU0Zs6n0l775OA
         x8JZo+QI6J8UVJMYx7tj5dhrIUiN2uysyRICNXf5jgbL4YpKsmaRcp/V4V2z7O811I7w
         CIesAMAnAs588030+xW03HgLERvX+BZoy75E95D/rfydzZYIorXed2+lJh19ogCxTMJu
         ounQ==
X-Gm-Message-State: AOJu0YyLKRKT2djSiwagRJypUmmFExYygS7y3h2z0scYEG84ryGuo2kU
	/O/37gO8vSgDtq+KJn+ssGuYQdZPhnH1LJOGNpC5DlRIwLQ0
X-Google-Smtp-Source: AGHT+IG71+3cRooAKrqxm1VJWVGzbnaAqyLyBFYdVbiOZ8yx1Z+1XoVoTpDoxpSli0ie7XCw/qJW5RRnS4Yy3b4RU88=
X-Received: by 2002:a05:600c:3c82:b0:40e:5274:e2ba with SMTP id
 bg2-20020a05600c3c8200b0040e5274e2bamr103211wmb.4.1704844705267; Tue, 09 Jan
 2024 15:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103164841.2800183-1-schatzberg.dan@gmail.com>
 <20240103164841.2800183-3-schatzberg.dan@gmail.com> <ZZaDw1Fak_q9BnW-@tiehlicka>
In-Reply-To: <ZZaDw1Fak_q9BnW-@tiehlicka>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 9 Jan 2024 16:57:49 -0700
Message-ID: <CAOUHufZsf0WYQcUyMz7EcyvFYpaL4wLDZBW8oz9CgB5qZqSGAQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: add swapiness= arg to memory.reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	Yosry Ahmed <yosryahmed@google.com>, David Rientjes <rientjes@google.com>, 
	Chris Li <chrisl@kernel.org>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 3:09=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 03-01-24 08:48:37, Dan Schatzberg wrote:
> [...]
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index d91963e2d47f..394e0dd46b2e 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -92,6 +92,11 @@ struct scan_control {
> >       unsigned long   anon_cost;
> >       unsigned long   file_cost;
> >
> > +#ifdef CONFIG_MEMCG
> > +     /* Swappiness value for proactive reclaim. Always use sc_swappine=
ss()! */
> > +     int *proactive_swappiness;
> > +#endif
> > +
> >       /* Can active folios be deactivated as part of reclaim? */
> >  #define DEACTIVATE_ANON 1
> >  #define DEACTIVATE_FILE 2
> > @@ -227,6 +232,13 @@ static bool writeback_throttling_sane(struct scan_=
control *sc)
> >  #endif
> >       return false;
> >  }
> > +
> > +static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *m=
emcg)
> > +{
> > +     if (sc->proactive && sc->proactive_swappiness)
> > +             return *sc->proactive_swappiness;
> > +     return mem_cgroup_swappiness(memcg);
> > +}
>
> If you really want to make this sc->proactive bound then do not use
> CONFIG_MEMCG as sc->proactive is not guarded either.
>
> I do not think that sc->proactive check is really necessary. A pure NULL
> check is sufficient to have a valid and self evident code that is future
> proof. But TBH this is not the most important aspect of the patch to
> spend much more time discussing. Either go with sc->proactive but make
> it config space consistent or simply rely on NULL check (with or without
> MEMCG guard as both are valid options).

Now you see why I replied. That "hybrid" if statement is just neither
of what was suggested.

