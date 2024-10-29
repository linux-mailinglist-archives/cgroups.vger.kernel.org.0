Return-Path: <cgroups+bounces-5305-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233C29B4098
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 03:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5539282F4A
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2024 02:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAC81DFE24;
	Tue, 29 Oct 2024 02:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eAK86i5b"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D523FBF0
	for <cgroups@vger.kernel.org>; Tue, 29 Oct 2024 02:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730169824; cv=none; b=jJxuadxhZg26FbNKbty4btl39wzMaGjzJ8ocCorflhNug7ODUzd07GFOeIwiCcF52pRaY8qHDJG4cPQVUWjYc774ZE+XY5IAPZc/NaNx1W89s9HGs4v4A7OTGwKrOvNE0dha7BvgmqWIYlsO+httVUJkEHZpjuf/o/00mAMCzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730169824; c=relaxed/simple;
	bh=vM4Tj8f/QUb6PrJ3UJsaisB6N6p+FM22CmVOQ5aSIqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIxsSSVVewws9RxBbs6mK4cdYzBF14VaJAozTX6LlBeXnlh/HkhfNWKxcjVKJhQ9SGx+G+oGb8++Bqqf1WqhbSestGDXPqRdgeL/GcdRLlX4/xiuVGABOBhZRIWJ/mBjgvv2MZC9zrHSdHCkuAnA5G5zwndyNGpBUALwzKsJbAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eAK86i5b; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6cbf2fc28feso31715446d6.0
        for <cgroups@vger.kernel.org>; Mon, 28 Oct 2024 19:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730169821; x=1730774621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0r0u/BybG7849PH2O8N2VQGNwjrvyp+wg7FV5E19Pv0=;
        b=eAK86i5bS3i1AgxNPzJbpI/C9QCNnvTmjjPt+lepflRE/uUveYdaNoMaZ5TObekp5F
         vtez1C/NSMitWHeQydvKlLTyoj1i1x+Kez4Jn9ff6INK93woy9NSlq/jWXcFn6s8bOoA
         EQuhqFQWnmDiV1JAa3A68yJabtymfZSUUKywDMyGE2Hxy+MHhGe4m6Txtqs2mnzYwNJ2
         qvTnMr4hesaaCXNZ1MFW3FSW/Jykb7Fa5/bO9iokCZajf/vuKJxWT2k32VKywULgZPTb
         qwWXPuFgYuUbhvLKHUgF5h17bQ59fZaoLMxqeQ+ZUP6N8hXYGbcd9wv+CBkbrlFOghe+
         Iajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730169821; x=1730774621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0r0u/BybG7849PH2O8N2VQGNwjrvyp+wg7FV5E19Pv0=;
        b=ei10pCQChteYPnhz3riHfVc27Mgtf8zVFhZtJYE4Xfd9BNuOBNhQ0nCHO0Au5+f7yq
         ilSkxyktIgVkTH2aQaj9EAME81RK1XBY12kzUeuyrbSgjZjgK0OVOL46lGi2Zq65kpEO
         emrawlmfHjMK4niGPlnsuW5V69lMhe3B5UxaRKA0UVDg3O/LTyruWl854goZiStjDsQW
         EnTC2K9q/BLxYde0enuM8xuDdv41vyyP0oSrOnfZrZWOfUGtMg2x5nwKRlpHyQwNT/9i
         IY0Avib63LH5UAGFzxNFBGrnacNAM+RIbU6OHFsFEeCB7g5+W0BS8BEF1O246llh5TBR
         Dgmg==
X-Forwarded-Encrypted: i=1; AJvYcCXjnwRKEfL0aRNKySz/ZBSl1ffqD0FQ2Mt+HeeSzskzfonpFOdXKTA1lqTF0tzhhJtC+Avbv1ye@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Dy8NtmB9AebjPNPQDZO5STGh7Vc7BO9RgnY86xaqDiTrZcka
	rwrvxeDZxLKsC1/d3QER20Cr0B76AW4ZQi7lElcxK7o3KlH6/QbIv9mR4MumkFiOLKGh523hN+N
	LAsH+UAeAVcMT+Oa9KeCUN9G+4/Pl4cCl1/ZG
X-Google-Smtp-Source: AGHT+IGYQ9AudrdXVaFld8PnZP3WMiTL5Ndbl97BDIv4DLNb3oqHt0DqRhLWLRP5dANnBHtCRZb3R3esCAEjmN+Dcv0=
X-Received: by 2002:a05:6214:5f03:b0:6cb:f7c7:803a with SMTP id
 6a1803df08f44-6d18585e936mr179900696d6.46.1730169820716; Mon, 28 Oct 2024
 19:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029021106.25587-1-inwardvessel@gmail.com> <20241029021106.25587-2-inwardvessel@gmail.com>
In-Reply-To: <20241029021106.25587-2-inwardvessel@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 28 Oct 2024 19:43:04 -0700
Message-ID: <CAJD7tkZo0oAh1L7OVGZkLi+EDw0pjQ8dpsC1oQbLQS6KNvymKw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v3] memcg: rename do_flush_stats and add force flag
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, linux-mm@kvack.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 7:11=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> Change the name to something more consistent with others in the file and
> use double unders to signify it is associated with the
> mem_cgroup_flush_stats() API call. Additionally include a new flag that
> call sites use to indicate a forced flush; skipping checks and flushing
> unconditionally. There are no changes in functionality.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/memcontrol.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 18c3f513d766..59f6f247fc13 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -588,8 +588,11 @@ static inline void memcg_rstat_updated(struct mem_cg=
roup *memcg, int val)
>         }
>  }
>
> -static void do_flush_stats(struct mem_cgroup *memcg)
> +static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool forc=
e)
>  {
> +       if (!force && !memcg_vmstats_needs_flush(memcg->vmstats))
> +               return;
> +
>         if (mem_cgroup_is_root(memcg))
>                 WRITE_ONCE(flush_last_time, jiffies_64);
>
> @@ -613,8 +616,7 @@ void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
>         if (!memcg)
>                 memcg =3D root_mem_cgroup;
>
> -       if (memcg_vmstats_needs_flush(memcg->vmstats))
> -               do_flush_stats(memcg);
> +       __mem_cgroup_flush_stats(memcg, false);
>  }
>
>  void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
> @@ -630,7 +632,7 @@ static void flush_memcg_stats_dwork(struct work_struc=
t *w)
>          * Deliberately ignore memcg_vmstats_needs_flush() here so that f=
lushing
>          * in latency-sensitive paths is as cheap as possible.
>          */
> -       do_flush_stats(root_mem_cgroup);
> +       __mem_cgroup_flush_stats(root_mem_cgroup, true);
>         queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_T=
IME);
>  }
>
> @@ -5281,11 +5283,8 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg=
)
>                         break;
>                 }
>
> -               /*
> -                * mem_cgroup_flush_stats() ignores small changes. Use
> -                * do_flush_stats() directly to get accurate stats for ch=
arging.
> -                */
> -               do_flush_stats(memcg);
> +               /* Force flush to get accurate stats for charging */
> +               __mem_cgroup_flush_stats(memcg, true);
>                 pages =3D memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_S=
IZE;
>                 if (pages < max)
>                         continue;
> --
> 2.47.0
>

