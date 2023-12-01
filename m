Return-Path: <cgroups+bounces-752-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A08E1800163
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 03:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36109B20E6D
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF017D2;
	Fri,  1 Dec 2023 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opodncZm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D082DC4
	for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 18:05:42 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a187cd4eb91so187536666b.3
        for <cgroups@vger.kernel.org>; Thu, 30 Nov 2023 18:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701396341; x=1702001141; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPAyt2cpj8YitcbF/ZXsY/VZI0FRxkT2rx6bb0Jhrv0=;
        b=opodncZmY3ip+uRvFDRDbPFMkNJG0xC9PLYjg9GY3swEJQT9NhrNwkTny2jAH8yFly
         xwntoNuOp+XO448jmwHBpijOzExb5KdbS28WcFVlCqSJlGvHPsY/5i7RWMiv/Grlvtj6
         gBdHoPE7BcxRSTZs8QW3pEbOufEQLSgsEJ+0MnmLl2q0FdeI5L/i8ZYloDkEot+ERa9S
         ixhrLaRg1tfei7RAIPugBFx1hSzA1890T3XIgWGA9iAxlxph7yN3ZCFBNydwktYQWLoo
         1PjWc7op8bQ/0V4sXHH4R0TfLOxP31jWojEHL2QoqSA/ihTd6zdg7RwIoh/8/7t9yYVj
         mCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701396341; x=1702001141;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPAyt2cpj8YitcbF/ZXsY/VZI0FRxkT2rx6bb0Jhrv0=;
        b=l6k57S86BRIrbj8NJyTV4zi5hGSQjj6eKxvFkwB2cQr/ajCciu4B0+1Iu7mTswZPWa
         L51gEGLt5//Y09rMIzfUqWHUk7sPpG0juU1dwbigGlEAYwjIss1PZrlVcQR3Xk3j7W74
         dLQMmAGHPLHyvWvFqkmo7AOgIJhqekqRGcllyvGPpWbb7o0/T8FL/MRfEXLilQdwetLs
         qTkp6sM7FKeGR+hYPJCibJevlb5RFFEE8lJ1B6QdWfTvPRU530HXBhTODydb/kmScnO8
         IsFS2dZ3z2fXY3i/bUBwy0LxTHbhwoeB23MeN4XUHsJkDQBi195wnxPEgeh4SReFZ442
         xq1g==
X-Gm-Message-State: AOJu0YyB/ycOmLteLfqHuiTCgVwceYVkF4WA9dy3MLgLraxSj5+txK2C
	TuID0c3pTrlp/9Lxu6Q4tOnOU40YmB9AP78q1egkyQ==
X-Google-Smtp-Source: AGHT+IHCWvetEn5bIjknsZ5SNFidPRGBu7iJZJNJAX9WtyEXizm24lRATxkMRAfd1FM3w1m3E6lh7LQtXHeGYezWHO4=
X-Received: by 2002:a17:906:108f:b0:a19:4a1d:e5d4 with SMTP id
 u15-20020a170906108f00b00a194a1de5d4mr275873eju.59.1701396341082; Thu, 30 Nov
 2023 18:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <20231130153658.527556-2-schatzberg.dan@gmail.com> <ec8abbff-8e17-43b3-a210-fa615e71217d@vivo.com>
In-Reply-To: <ec8abbff-8e17-43b3-a210-fa615e71217d@vivo.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 30 Nov 2023 18:05:02 -0800
Message-ID: <CAJD7tkY-npqRXmwJU6kH1srG0c+suiDfffsoc44ngP4x9H0kLA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: add swapiness= arg to memory.reclaim
To: Huan Yang <11133793@vivo.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Peter Xu <peterx@redhat.com>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>, 
	Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"

> @@ -2327,7 +2330,8 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>         struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>         struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>         unsigned long anon_cost, file_cost, total_cost;
> -       int swappiness = mem_cgroup_swappiness(memcg);
> +       int swappiness = sc->swappiness ?
> +               *sc->swappiness : mem_cgroup_swappiness(memcg);
>
> Should we use "unlikely" here to indicate that sc->swappiness is an unexpected behavior?
> Due to current use case only apply in proactive reclaim.

On a system that is not under memory pressure, the rate of proactive
reclaim could be higher than reactive reclaim. We should only use
likely/unlikely when it's obvious a scenario will happen most of the
time. I don't believe that's the case here.

>
>         u64 fraction[ANON_AND_FILE];
>         u64 denominator = 0;    /* gcc */
>         enum scan_balance scan_balance;
> @@ -2608,6 +2612,9 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
>             mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
>                 return 0;
>
> +       if (sc->swappiness)
> +               return *sc->swappiness;
>
> Also there.
>
> +
>         return mem_cgroup_swappiness(memcg);
>  }
>
> @@ -6433,7 +6440,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                                            unsigned long nr_pages,
>                                            gfp_t gfp_mask,
> -                                          unsigned int reclaim_options)
> +                                          unsigned int reclaim_options,
> +                                          int *swappiness)
>  {
>         unsigned long nr_reclaimed;
>         unsigned int noreclaim_flag;
> @@ -6448,6 +6456,7 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>                 .may_unmap = 1,
>                 .may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
>                 .proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
> +               .swappiness = swappiness,
>         };
>         /*
>          * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> --
> 2.34.1
>
> My previous patch attempted to ensure fully deterministic semantics under extreme swappiness.
> For example, when swappiness is set to 200, only anonymous pages will be reclaimed.
> Due to code in MGLRU isolate_folios will try scan anon if no scanned, will try other type.(We do not want
> it to attempt this behavior.)
> How do you think about extreme swappiness scenarios?

I think having different semantics between swappiness passed to
proactive reclaim and global swappiness can be confusing. If it's
needed to have a swappiness value that says "anon only no matter
what", perhaps we should introduce such a new value and make it
supported by both global and proactive reclaim swappiness? We could
support writing "max" or something similar instead of a special value
to mean that.

Writing such value to global swappiness may cause problems and
premature OOMs IIUC, but that would be misconfiguration. If we think
that's dangerous, we can introduce this new value but make it valid
only for proactive reclaim for now.

