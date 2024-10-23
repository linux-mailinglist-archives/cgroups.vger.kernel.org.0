Return-Path: <cgroups+bounces-5208-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C173C9AD675
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 23:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40BA21F210DB
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 21:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681951E7C2C;
	Wed, 23 Oct 2024 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yaCaL6Ph"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC215746E
	for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718145; cv=none; b=C8XYjHVsL6MbywRlCAMxVYDiVConEHOrUUroDD3/EkrynpHM4SigYs+QJi2nykjx9EcPOoGEwEqx/vWT9d9kX3H4JCQO0zTitBT5w7xRYvZGjXJz1l9w9CJO47C05DYVgGDM5A9KKE5uII7PAcyK69CzrHWcHAAQPj13QCC+4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718145; c=relaxed/simple;
	bh=mejuS79PWibdDF1coAfY4DFXGGdv+xeDJ51cwSSV/bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6O2dKPPpU5ZylpSEtzS2wBLcehR8SgZNaZ13wFOhMEz7SL1RjOXUQP8GM2oqObnTn3JKRsaVzAC7Q2ZTtrpFJ+kTBeEJwIA4XO3SiyLHjpxUQ72sIjJgCQMW2ar/3vIE+GGlnW+QsH3tWF0+nhcOsSc2RgIyMDBbv3jE9Uhous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yaCaL6Ph; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539fbbadf83so294577e87.0
        for <cgroups@vger.kernel.org>; Wed, 23 Oct 2024 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729718141; x=1730322941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbvtG8V73vNOGF6JVv7N7fReShbn/axZArr81YzDE/o=;
        b=yaCaL6PhdrnynlAw21FJHKUzccLmzzSWId+OeyTkGm7t5cLka755JLXhVOqYpc5ffN
         hpGX2luQHK6ca/EsqBeXWQld+vuzpaxaR0W6vzU67SFkJGynbGq0DJuWx7ommmgEDWq6
         3hEWSs35G4T8gIfKowbjamj13dIP88CqJ1TTfpdB/qOcEM3SCBdXqEB5YEEBoSrgaXZd
         lzARLG4KyJmQcDMwTIan9PgufPDgVijce2Rs2rUktwgJUGEAc9enQi5I+FDR4a+mcoi9
         XjjIDCRYlFkbG34+3TZXspH3o5hXS8IeHkLyghC/oYhpxqFCiEb1CxGIpgoU0EA7yBHH
         pWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718141; x=1730322941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbvtG8V73vNOGF6JVv7N7fReShbn/axZArr81YzDE/o=;
        b=M7k05AHgV3xkOtmL84mFGzxAK4IjxoYdTVPgwA8Yt7MQw+iM+IekSGniiKyCT3zHSt
         kgJpxt2BdI6BFwMniLj7wXt1mgU4kfi2r4PWbWe54VqV5VKV+Pzc9eilTen44IKgIrgb
         5ZB7JvD8d7EEdpXaYb/dLn5V8iTBZ480KGCewSbJtUEfFR7MwaO07nLOnYlM6yckF8WQ
         ERTlj1nXa/g6f+lvLVWRZKxrcX2ICWwo3BKhnIwbbyjMU+Us0a1tNMACDGWpPOIAhot9
         yQBeMN4yB9xR0gHsqWDVFYF1nn0xkG37xW5jyitfvxDJwx39lYC8Cmu8gN3MpwTFgrhF
         ASAA==
X-Forwarded-Encrypted: i=1; AJvYcCXKgCpsaeES3/s/Hk3piX/WcA59gOFbxOm5EpuObXC1CTuj0sbJ6tb3aIf2pg12jSSpiFWKpaOe@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMZ9iHRWjcTGul1ls4NHOrNoLinQAEEBnQik+Y3snPtTRdADO
	qnHgM1dx1d08TCYHS10/vJKP3M3zFkIp4U9L+/H0KdEmqtdxkX22R2cqyr8xKmlPD4kLPoOIn/+
	cyWi2K3wmHLIRV6rMtJWG2Lfm0UC4tp2e6EMq
X-Google-Smtp-Source: AGHT+IHLKp76I34upGgGXEu+gry/H7oC2mHJybDf/x3GsnoL+KWk4vIHewnK/z7vQgbvKONirpXQytMSHT06ePeP+ZE=
X-Received: by 2002:a05:6512:6cc:b0:539:fb49:c489 with SMTP id
 2adb3069b0e04-53b1a2fac47mr2354575e87.9.1729718140379; Wed, 23 Oct 2024
 14:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>
In-Reply-To: <20241023203433.1568323-1-joshua.hahnjy@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 23 Oct 2024 14:15:04 -0700
Message-ID: <CAJD7tkaxKG4P-DLEHQGTad1vbgZgf7nVJq6=824MRWxJ1si19A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] memcg/hugetlb: Adding hugeTLB counters to memcg
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, nphamcs@gmail.com, mhocko@kernel.org, 
	roman.gushcin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	lnyng@meta.com, akpm@linux-foundation.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Wed, Oct 23, 2024 at 1:34=E2=80=AFPM Joshua Hahn <joshua.hahnjy@gmail.co=
m> wrote:
>
> Changelog
> v2:
>   * Enables the feature only if memcg accounts for hugeTLB usage
>   * Moves the counter from memcg_stat_item to node_stat_item
>   * Expands on motivation & justification in commitlog
>   * Added Suggested-by: Nhat Pham

Changelogs usually go at the end, after ---, not as part of the commit
log itself.

>
> This patch introduces a new counter to memory.stat that tracks hugeTLB
> usage, only if hugeTLB accounting is done to memory.current. This
> feature is enabled the same way hugeTLB accounting is enabled, via
> the memory_hugetlb_accounting mount flag for cgroupsv2.
>
> 1. Why is this patch necessary?
> Currently, memcg hugeTLB accounting is an opt-in feature [1] that adds
> hugeTLB usage to memory.current. However, the metric is not reported in
> memory.stat. Given that users often interpret memory.stat as a breakdown
> of the value reported in memory.current, the disparity between the two
> reports can be confusing. This patch solves this problem by including
> the metric in memory.stat as well, but only if it is also reported in
> memory.current (it would also be confusing if the value was reported in
> memory.stat, but not in memory.current)
>
> Aside from the consistentcy between the two files, we also see benefits

consistency*

> in observability. Userspace might be interested in the hugeTLB footprint
> of cgroups for many reasons. For instance, system admins might want to
> verify that hugeTLB usage is distributed as expected across tasks: i.e.
> memory-intensive tasks are using more hugeTLB pages than tasks that
> don't consume a lot of memory, or is seen to fault frequently. Note that

are* seen

> this is separate from wanting to inspect the distribution for limiting
> purposes (in which case, hugeTLB controller makes more sense).
>
> 2. We already have a hugeTLB controller. Why not use that?
> It is true that hugeTLB tracks the exact value that we want. In fact, by
> enabling the hugeTLB controller, we get all of the observability
> benefits that I mentioned above, and users can check the total hugeTLB
> usage, verify if it is distributed as expected, etc.
>
> With this said, there are 2 problems:
>   (a) They are still not reported in memory.stat, which means the
>       disparity between the memcg reports are still there.
>   (b) We cannot reasonably expect users to enable the hugeTLB controller
>       just for the sake of hugeTLB usage reporting, especially since
>       they don't have any use for hugeTLB usage enforcing [2].
>
> [1] https://lore.kernel.org/all/20231006184629.155543-1-nphamcs@gmail.com=
/
> [2] Of course, we can't make a new patch for every feature that can be
>     duplicated. However, since the exsting solution of enabling the

existing*

>     hugeTLB controller is an imperfect solution that still leaves a
>     discrepancy between memory.stat and memory.curent, I think that it
>     is reasonable to isolate the feature in this case.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>

You should also CC linux-mm on such patches.

>
> ---
>  include/linux/mmzone.h |  3 +++
>  mm/hugetlb.c           |  4 ++++
>  mm/memcontrol.c        | 11 +++++++++++
>  mm/vmstat.c            |  3 +++
>  4 files changed, 21 insertions(+)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 17506e4a2835..d3ba49a974b2 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -215,6 +215,9 @@ enum node_stat_item {
>  #ifdef CONFIG_NUMA_BALANCING
>         PGPROMOTE_SUCCESS,      /* promote successfully */
>         PGPROMOTE_CANDIDATE,    /* candidate pages to promote */
> +#endif
> +#ifdef CONFIG_HUGETLB_PAGE
> +       HUGETLB_B,

Why '_B'?

>  #endif
>         /* PGDEMOTE_*: pages demoted */
>         PGDEMOTE_KSWAPD,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 190fa05635f4..055bc91858e4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1925,6 +1925,8 @@ void free_huge_folio(struct folio *folio)
>                                      pages_per_huge_page(h), folio);
>         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>                                           pages_per_huge_page(h), folio);
> +       if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)

I think we already have a couple of these checks and this patch adds a
few more, perhaps we should add a helper at this point to improve
readability? Maybe something like memcg_accounts_hugetlb()?

> +               lruvec_stat_mod_folio(folio, HUGETLB_B, -pages_per_huge_p=
age(h));
>         mem_cgroup_uncharge(folio);
>         if (restore_reserve)
>                 h->resv_huge_pages++;
> @@ -3094,6 +3096,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_st=
ruct *vma,
>         if (!memcg_charge_ret)
>                 mem_cgroup_commit_charge(folio, memcg);
>         mem_cgroup_put(memcg);
> +       if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
> +               lruvec_stat_mod_folio(folio, HUGETLB_B, pages_per_huge_pa=
ge(h));
>
>         return folio;
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7845c64a2c57..de5899eb8203 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -306,6 +306,9 @@ static const unsigned int memcg_node_stat_items[] =3D=
 {
>  #endif
>  #ifdef CONFIG_NUMA_BALANCING
>         PGPROMOTE_SUCCESS,
> +#endif
> +#ifdef CONFIG_HUGETLB_PAGE
> +       HUGETLB_B,
>  #endif
>         PGDEMOTE_KSWAPD,
>         PGDEMOTE_DIRECT,
> @@ -1327,6 +1330,9 @@ static const struct memory_stat memory_stats[] =3D =
{
>  #ifdef CONFIG_ZSWAP
>         { "zswap",                      MEMCG_ZSWAP_B                   }=
,
>         { "zswapped",                   MEMCG_ZSWAPPED                  }=
,
> +#endif
> +#ifdef CONFIG_HUGETLB_PAGE
> +       { "hugeTLB",                    HUGETLB_B                       }=
,

nit: I think we usually use lowercase letters when naming stats.

>  #endif
>         { "file_mapped",                NR_FILE_MAPPED                  }=
,
>         { "file_dirty",                 NR_FILE_DIRTY                   }=
,
> @@ -1441,6 +1447,11 @@ static void memcg_stat_format(struct mem_cgroup *m=
emcg, struct seq_buf *s)
>         for (i =3D 0; i < ARRAY_SIZE(memory_stats); i++) {
>                 u64 size;
>
> +#ifdef CONFIG_HUGETLB_PAGE
> +               if (unlikely(memory_stats[i].idx =3D=3D HUGETLB_B) &&
> +                               !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_=
HUGETLB_ACCOUNTING))
> +                       continue;
> +#endif
>                 size =3D memcg_page_state_output(memcg, memory_stats[i].i=
dx);
>                 seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size=
);
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index b5a4cea423e1..466c40cffeb0 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1269,6 +1269,9 @@ const char * const vmstat_text[] =3D {
>  #ifdef CONFIG_NUMA_BALANCING
>         "pgpromote_success",
>         "pgpromote_candidate",
> +#endif
> +#ifdef CONFIG_HUGETLB_PAGE
> +       "hugeTLB",
>  #endif
>         "pgdemote_kswapd",
>         "pgdemote_direct",
> --
> 2.43.5
>
>

