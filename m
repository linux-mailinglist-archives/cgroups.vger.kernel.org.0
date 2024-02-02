Return-Path: <cgroups+bounces-1324-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BAC847C8C
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 23:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751D3B24C8A
	for <lists+cgroups@lfdr.de>; Fri,  2 Feb 2024 22:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B195126F2C;
	Fri,  2 Feb 2024 22:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ohurt49G"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1FD83A07
	for <cgroups@vger.kernel.org>; Fri,  2 Feb 2024 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914299; cv=none; b=kE72J/uUDR6hV5iglx4CfPWmZEAe0jmGwiOwAEDoDGGijjns/cDupFC6YkwdTTCfCJnPNVGghUZQfTFMoAyxFIVnOS/Y2MP1DT4CPNYUOn/eR8exuvzUi0svdcmiMkvISXK1s2UmwjisNFS5uKE/xgYd9sFuIm4aFG2Ah+pyjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914299; c=relaxed/simple;
	bh=dvL8AMkHNUJ9h6plzTePt6PRULh3QxRknkGeOO9N/50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTIZZKJKpLU90HJTllwXh79mHG5XhW6eNVA6zzJNqnMl00TuZOfZivd+l9AQve3XRhaN7ofgnljzAFzD+obfJppBDIgmMUCjkmHq4bpsC7mitT3AFPAjY7BYo7Q9kghSfqpNhA/8W+XbaZWb0JLyzWV6H3bg/NHWFSxI78elzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ohurt49G; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6002317a427so23329047b3.2
        for <cgroups@vger.kernel.org>; Fri, 02 Feb 2024 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706914296; x=1707519096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n92Fu6TwisuAtTr7JJdYG/vygZsi6nTJ2ebXGYpQOpg=;
        b=Ohurt49GVRSkpZWzNyuV/aVLUGlyS9DsihpV+KW+Yq1EGDX1TynsOcTBQSbt2hc15e
         eM3/c05k8x1e2Xqf/TpwNI6KNrZ5yubM3wfHjRMtEHtsxEdKpCH4j94TfvO0Vb3l6S7g
         t3Ay9ZQqbfFq//eDoXChFSRrI4oGdFX22CJYfxq3MpIHByN25EAmw5ag+CBAQNvWI3t1
         IS4YlZ5tCw6A8j5DzqdoVQWgwEiiIVKFZEjaTI3klss5eWy/apJxCkQbHU75Y4+0YWJ5
         NkPrcJ12+w3P+tM6VcXIQxo/aY6B2djpzuFLGmoEYGYiB5GbxS58Vn0NOwUlwsZzJS0y
         ZiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706914296; x=1707519096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n92Fu6TwisuAtTr7JJdYG/vygZsi6nTJ2ebXGYpQOpg=;
        b=wwx1OMTLaioOqfkBAJCDv0mUvBTgyG80x2R5ICyHy1wvQTlRW/UxZK0SaDnvdQMklE
         OrNtifRAVXrLI4A5ZMsjDOm2R33IP4w09kW/CRpFkxqbBaXlsKaP+n3fFxO5jqBrF5c5
         ygA0OU74jXr2WUdLqsI428Sr9LbB1UzkvMSAOolvQUUOqI+22JCbio2XYjPcai8K8zjm
         pxbkjbWO3D9EW/Kzl8km1mfP3pJunxGAvA+rCcDqlWkOUFW5LdHIpQtg75rGlvjGZuLb
         geTZ10IDVChhMP7UJOqDLYrDbmlglVed4r/g13NOhnjrT6t76kr8kvswAgr4TgR/sori
         OCAA==
X-Gm-Message-State: AOJu0YxpmcwYqin51B/saYai2Ai/P4aHgjdoew+i5LYZ1wLMcH/lcsnz
	SbsZvQepDqQznIHCMeTUNvjG6yG/dctx5hLy5i5J6l/OjOIuQJGXewcO7NbY3p4sPegJXyudyiE
	YbeWMOkATlQzFGUz7QMyKUr7dNpor9WPENnaJ
X-Google-Smtp-Source: AGHT+IEiVfBlMxC3GtvgGhWtev4FkimbTiFm2fzVIKEWCb6b/ncuAwnXufqqodRaSYF3KOPCIkg5YGPZLdo/AOKMaW0=
X-Received: by 2002:a81:af55:0:b0:602:c0d0:d4e6 with SMTP id
 x21-20020a81af55000000b00602c0d0d4e6mr9730577ywj.0.1706914296497; Fri, 02 Feb
 2024 14:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202221026.1055122-1-tjmercier@google.com>
 <CAJD7tkZh=M58Avfwx_D+UEXy6mm18Zx_hVKn8Gb8-+8-JQQfWw@mail.gmail.com> <20240202224117.GA341862@cmpxchg.org>
In-Reply-To: <20240202224117.GA341862@cmpxchg.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 2 Feb 2024 14:51:24 -0800
Message-ID: <CABdmKX3hqxd_0n1Rr=SL8V2HbsjjcCUQaGCQ85E72OHmZp-O_w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg: Use larger batches for proactive reclaim
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Efly Young <yangyifei03@kuaishou.com>, android-mm@google.com, yuzhao@google.com, 
	mkoutny@suse.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 2:41=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Feb 02, 2024 at 02:13:20PM -0800, Yosry Ahmed wrote:
> > On Fri, Feb 2, 2024 at 2:10=E2=80=AFPM T.J. Mercier <tjmercier@google.c=
om> wrote:
> > > @@ -6965,6 +6965,9 @@ static ssize_t memory_reclaim(struct kernfs_ope=
n_file *of, char *buf,
> > >         while (nr_reclaimed < nr_to_reclaim) {
> > >                 unsigned long reclaimed;
> > >
> > > +               /* Will converge on zero, but reclaim enforces a mini=
mum */
> > > +               unsigned long batch_size =3D (nr_to_reclaim - nr_recl=
aimed) / 4;
> > > +
> > >                 if (signal_pending(current))
> > >                         return -EINTR;
> > >
> > > @@ -6977,7 +6980,7 @@ static ssize_t memory_reclaim(struct kernfs_ope=
n_file *of, char *buf,
> > >                         lru_add_drain_all();
> > >
> > >                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > > -                                       min(nr_to_reclaim - nr_reclai=
med, SWAP_CLUSTER_MAX),
> > > +                                       batch_size,
> > >                                         GFP_KERNEL, reclaim_options);
> >
> > I think the above two lines should now fit into one.
>
> Yeah might as well compact that again. The newline in the declarations
> is a bit unusual for this codebase as well, and puts the comment sort
> of away from the "reclaim" it refers to. This?
>
>                 /* Will converge on zero, but reclaim enforces a minimum =
*/
>                 batch_size =3D (nr_to_reclaim - nr_reclaimed) / 4;
>
>                 reclaimed =3D try_to_free_mem_cgroup_pages(memcg, batch_s=
ize,
>                                         GFP_KERNEL, reclaim_options);
>
> But agreed, it's all just nitpickety nickpicking. :)
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

-std=3Dgnu11 to the rescue

+               /* Will converge on zero, but reclaim enforces a minimum */
+               unsigned long batch_size =3D (nr_to_reclaim - nr_reclaimed)=
 / 4;
                reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
-                                       min(nr_to_reclaim -
nr_reclaimed, SWAP_CLUSTER_MAX),
+                                       batch_size,
                                        GFP_KERNEL, reclaim_options);

