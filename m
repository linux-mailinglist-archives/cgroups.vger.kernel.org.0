Return-Path: <cgroups+bounces-5094-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B9E997A25
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 03:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01788B20BB1
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 01:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E529CF6;
	Thu, 10 Oct 2024 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRUn6Ulp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13322094
	for <cgroups@vger.kernel.org>; Thu, 10 Oct 2024 01:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523536; cv=none; b=JkAQMil3vsVE68PTDoR/0BNClpHIx72bFx/yxLY//Sl2qPwIosR5voLclYYb5pXobZDIWBrfRYp8KuaAeBkrmSHXfyFD+bsSQX/chfz0AmVKptnKpWKr1sLP+dZ68cqrdNR/G/boLAz2m6UxJyx3D5A+IiydvxSoVfmh+hy5jXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523536; c=relaxed/simple;
	bh=vnCGgKJYrGMZYbOYSTon2Sv5wAakS0RMC5Ri0yS2Pzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NraRMmPug3ZbvUuxQ69vPWcwLram/PPmTP0xpzr6rU+Vhnz2SnlKeRsGXs+mLrHPGwBG1+Lg9yM4TVT8VPWnAJDlKRcJ8mw9OeG6C/QMxZZNn9Xxy/Q8rLjkDsqM1PnZKWFtH0YAVpBBwvDDl+L5RG7P1QKx1PJpaXCeCMgl7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRUn6Ulp; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a994c322aefso276429166b.1
        for <cgroups@vger.kernel.org>; Wed, 09 Oct 2024 18:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728523533; x=1729128333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKiguFOTd+v0Vef2ZB60THjvJjwTWlwVlkRcn5vfUYQ=;
        b=mRUn6Ulp/k3O6c5vmgPC3eFs84z5LguOE6dLJ+Oij+B6rDLHes9zMFKXJKO6PgfJoR
         Xit9u7dW21wayMPLmnMlMCX6kzJPqdS4B40av+dzNqV9PwjFtjQfekD+UG89+oMUGoSF
         6gha/T9kdS9PLgcuoe343fKC2j1hAKrF9ixPHK9G19vKxF3yrf2IlisYTB6YqJw+w2tf
         jL1tZt8dhhm6P5GY+25rhoXmO0Diu+u6Z+tsTsu+ozzO3PwqrHGdF2KnGEYJ8Nsy2bSv
         FDgUVdzfLDgPA7GJqhADIhfp5sse43QhPwhh+d8h3cDKqhnCHvlClz4jLi9XY/gtvDHK
         y7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523533; x=1729128333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKiguFOTd+v0Vef2ZB60THjvJjwTWlwVlkRcn5vfUYQ=;
        b=oIaayAlCNidSSUj3LQE2YV1ITUXXZzZUmcHAGhfxR5m5o1QtNYta4kvqtJ0uJ96hgc
         zGK+vlkVjyxESjuD7sINYbMina5ffdVUxmgaP+W06hecISQbATmwPb4Ln7Uaf9Sq0SaD
         d1Qe5oLeW/TopjJYmVJtYLCrDbo2kn9SRRuy+ka5ptdE/XPbcgV0eH/0l0bZUEpswaOD
         oWm08yBQjrTZWDC6T8/XhSu6rNlTdSrOqI8DmQJBXN5xcYAMvrUUnjPpoRVn7pT/Ogxf
         /eSWlalam6GmFnmj8eqiZZz4XGiyrWctlgonXigeegab2my2/sDLF4OeoMZkNaX72x77
         d25Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd1tV3FkTBvj2DSvKTCUUaKI1uiJG05tZHioyLO92kNq9UdJ+UXuyr7lEO70nULYa0Wx5JnsQ4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08EbrUBbin+/YzNWp+8WflAnogqzSc2eTsCNxrG4wePQ8VN93
	T2tcb5yhay2piD/6hL8pKAc+PX5fyjuLt1Fdvuy1xZVnmReMTAJrL/CVo2oJMOl1A08X3BWylG1
	+oAZTXHRLA6bCv1XDiBgENc/lFy6cvaTE/WVF
X-Google-Smtp-Source: AGHT+IG4B4hCqT4olRaXnT6JjYypmFyqCTl3wuaDHSO5u227fmToHL+A50GmEahWB/h8P3+FEgzbPANmN6ZbuUM6E3Q=
X-Received: by 2002:a17:907:60ce:b0:a99:4c71:704 with SMTP id
 a640c23a62f3a-a99a11192a1mr118207166b.26.1728523532881; Wed, 09 Oct 2024
 18:25:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkYq+dduc7+M=9TkR6ZAiBYrVyUsF_AuwPqaQNrsfH_qfg@mail.gmail.com> <20241009210848.43adb0c3@gandalf.local.home>
In-Reply-To: <20241009210848.43adb0c3@gandalf.local.home>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 9 Oct 2024 18:24:55 -0700
Message-ID: <CAJD7tkaLQwVphoLiwh8-NTyav36_gAVdzB=gC_qXzv7ti9TzmA@mail.gmail.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 6:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 9 Oct 2024 17:46:22 -0700
> Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > > +++ b/mm/memcontrol.c
> > > @@ -71,6 +71,10 @@
> > >
> > >  #include <linux/uaccess.h>
> > >
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/memcg.h>
> > > +#undef CREATE_TRACE_POINTS
> > > +
> > >  #include <trace/events/vmscan.h>
> > >
> > >  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> > > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, =
enum memcg_stat_item idx,
> > >                 return;
> > >
> > >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val)=
);
> > > +       val =3D memcg_state_val_in_pages(idx, val);
> > > +       memcg_rstat_updated(memcg, val);
> > > +       trace_mod_memcg_state(memcg, idx, val);
> >
> > Is it too unreasonable to include the stat name?
> >
> > The index has to be correlated with the kernel config and perhaps even
> > version. It's not a big deal, but if performance is not a concern when
> > tracing is enabled anyway, maybe we can lookup the name here (or in
> > TP_fast_assign()).
>
> What name? Is it looked up from idx? If so, you can do it on the reading =
of
> the trace event where performance is not an issue. See the __print_symbol=
ic()
> and friends in samples/trace_events/trace-events-sample.h

Yeah they can be found using idx. Thanks for referring us to
__print_symbolic(), I suppose for this to work we need to construct an
array of {idx, name}. I think we can replace the existing memory_stats
and memcg1_stats/memcg1_stat_names arrays with something that we can
reuse for tracing, so we wouldn't need to consume extra space.

Shakeel, what do you think?

