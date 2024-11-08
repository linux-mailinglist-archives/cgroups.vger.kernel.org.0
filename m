Return-Path: <cgroups+bounces-5491-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 397939C27F0
	for <lists+cgroups@lfdr.de>; Sat,  9 Nov 2024 00:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE351C217D4
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 23:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74F1E0E0C;
	Fri,  8 Nov 2024 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1ZV3BwA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB51C460C
	for <cgroups@vger.kernel.org>; Fri,  8 Nov 2024 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731107038; cv=none; b=lDFGqouTTkCgCgpBgZyRG+x2SEWxhZHgObng4ckbqfbfAJLQARhF1LmW7bUvU7jj/Ri0VIRPi1X9a75eZDmnN4nREMfQPJpjY22nJS1cfih9koflOd+tejTKz5hMwk/eH3P5GxhJOUHllT9+M5obJpYhDGZxqVmwjpw8PfOmRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731107038; c=relaxed/simple;
	bh=tAof7IQjpc2xBY0BwO3XIiETUoZLglRA9amWx00FDHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFoHnRKwtZLfKSR9UhUK4uHZ4Kx0EiJ0eIFQTdzHof2/MbYyJcIz0ZHwcd0z4sEreCWQtO1cXdGcgezAh0+ZHwH+kmEyIz6Nc+USpZTIVVCI03uALZmsHAw1n0exlK1ggIBX4mChvG8ODIJOjfPLNJ++/bl+UNk0uWggmGrKiz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1ZV3BwA; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbf0769512so17119386d6.3
        for <cgroups@vger.kernel.org>; Fri, 08 Nov 2024 15:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731107036; x=1731711836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIqNr8n5Q+6xVneCWLzpkwEOR9ImhdwgHevVJ+8laqQ=;
        b=n1ZV3BwAhRlYBJZY123IKVW0GPfvhPd4RLQdQPMRF41kRJxi6l+2nm+5g8majpA7Y2
         8gThqZt0vMmzO5TtSbc7P2DVmkJE3DlA19D9wgfnNas7pR3G7xpVQrBpqB2nDvYXld2F
         XLPZpscD9l8Lseso8tfUCKcGeSJUizOBn19jYzEVggD+CmlazWN6nF6gFbyc4xgKXafo
         731rEecFFqt8g2ATLZcf62Uwn5LWVh+6IJa4mJGgB+3RrbS77m29lyE4ik00h+JRirRH
         VuLKUBYWdTYoeAouYqtU5k7ae92ceMXf6o6BaOJpJ1lK/dfxMilQxnYnyC+xMbX+zsD8
         rRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731107036; x=1731711836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIqNr8n5Q+6xVneCWLzpkwEOR9ImhdwgHevVJ+8laqQ=;
        b=SiQNNimVJAayYpCmQ1bbtXGjc7nncaBE7tsKqLm7elbjc7UnVDQm4PR2riFFY5BXHt
         Z4fepGPc0e+UycNA0FbTBsTAkExCmyUl1Kym9sqsbnNkSFlC4VduHqPY/XjT5YmQLgC1
         EUD6TLah/4VpBtPs/a0fdu6QokQ6fPnNyAzCLZ8P0M8LfL+xUPBCiMjMO2BMa1uC9mU7
         tcnC9d6kQIU4nolUmHfn9EZguk/FzRDHeVdfsuu40+cycVmxUPXlFMt6q8kBoFU4yJXW
         r1XKF3xEaGaSykrmEV+EzB+HUutm0DEmuN40t0atyUpAN65JPOvpH6dZSq2cmi09Aza7
         h+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVib9KPhGqHNtBYrow0OC8Kplxy03iapC10j/PiNDjI9qK4FYl1Iei95EL8p8WpjUaM9OeHnVmT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+y5ioeqDzgIY+rk7SRLBTEWx52/qM2eoki1/0o1DfZSeAXc/Z
	8gDar0MTS6AmKcJaQ75VG/pLHu4utiSwEGyXdy0s05OlyAEu68WbrgsrimYUp5sNCSAUCVOqV4p
	lmV9xIdUrwzxYtJ+6flV4TELQnA/QdZDlIX7W
X-Google-Smtp-Source: AGHT+IF0DcHtAtl0/LV2MseLtaG4KI0F/nNF7x0b+EhqMH4axwCSZr+1OVbL8i5Uxp8n4TbecwCEjPgVxXNXusRey7o=
X-Received: by 2002:a05:6214:3287:b0:6cb:d1ae:27a6 with SMTP id
 6a1803df08f44-6d39e150719mr51722326d6.24.1731107035523; Fri, 08 Nov 2024
 15:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
 <20241108212946.2642085-2-joshua.hahnjy@gmail.com> <elww7lzpj4htuhgdeu2e3j5mhogi54x6w75fk5sodaptletk3x@r2fnnh7gz72h>
In-Reply-To: <elww7lzpj4htuhgdeu2e3j5mhogi54x6w75fk5sodaptletk3x@r2fnnh7gz72h>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 8 Nov 2024 15:03:18 -0800
Message-ID: <CAJD7tkYdSeBDnR7rxpTJ5ZGVvLKbMcv_yH_U05Z_ycDWn8AQOg@mail.gmail.com>
Subject: Re: [PATCH 1/3] memcg/hugetlb: Introduce memcg_accounts_hugetlb
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:21=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> On Fri, Nov 08, 2024 at 01:29:44PM -0800, Joshua Hahn wrote:
> > This patch isolates the check for whether memcg accounts hugetlb.
> > This condition can only be true if the memcg mount option
> > memory_hugetlb_accounting is on, which includes hugetlb usage
> > in memory.current.
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> >
> > ---
> >  mm/memcontrol.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index f3a9653cef0e..97f63ec9c9fb 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1425,6 +1425,9 @@ unsigned long memcg_page_state_local_output(struc=
t mem_cgroup *memcg, int item)
> >               memcg_page_state_output_unit(item);
> >  }
> >
> > +/* Forward declaration */
> > +bool memcg_accounts_hugetlb(void);
>
> No need for forward declaration. Just define it here and make it static.

Also please pull the #ifdef outside the function definition, e.g.

#ifdef CONFIG_HUGETLB_PAGE
static bool memcg_accounts_hugetlb(void)
{
     return cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
}
#else /* CONFIG_HUGETLB_PAGE */
static bool memcg_accounts_hugetlb(void) { return false; }
{
     return false;
}
#endif /* CONFIG_HUGETLB_PAGE */

>
> > +
> >  static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf=
 *s)
> >  {
> >       int i;
> > @@ -1446,7 +1449,7 @@ static void memcg_stat_format(struct mem_cgroup *=
memcg, struct seq_buf *s)
> >
> >  #ifdef CONFIG_HUGETLB_PAGE
> >               if (unlikely(memory_stats[i].idx =3D=3D NR_HUGETLB) &&
> > -                 !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCO=
UNTING))
> > +                     !memcg_accounts_hugetlb())
> >                       continue;
> >  #endif
> >               size =3D memcg_page_state_output(memcg, memory_stats[i].i=
dx);
> > @@ -4483,6 +4486,15 @@ int __mem_cgroup_charge(struct folio *folio, str=
uct mm_struct *mm, gfp_t gfp)
> >       return ret;
> >  }
> >
> > +bool memcg_accounts_hugetlb(void)
> > +{
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +     return cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
> > +#else
> > +     return false;
> > +#endif
> > +}
> > +
> >  /**
> >   * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a huget=
lb folio
> >   * @memcg: memcg to charge.
> > @@ -4508,8 +4520,7 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgro=
up *memcg, gfp_t gfp,
> >        * but do not attempt to commit charge later (or cancel on error)=
 either.
> >        */
> >       if (mem_cgroup_disabled() || !memcg ||
> > -             !cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
> > -             !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTI=
NG))
> > +             !cgroup_subsys_on_dfl(memory_cgrp_subsys) || !memcg_accou=
nts_hugetlb())
> >               return -EOPNOTSUPP;
> >
> >       if (try_charge(memcg, gfp, nr_pages))
> > --
> > 2.43.5
> >
>

