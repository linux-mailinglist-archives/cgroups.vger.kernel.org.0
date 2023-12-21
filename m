Return-Path: <cgroups+bounces-986-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E4381AC76
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 03:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4736A1F23462
	for <lists+cgroups@lfdr.de>; Thu, 21 Dec 2023 02:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F309474;
	Thu, 21 Dec 2023 02:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvl5fdhk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0619C945A;
	Thu, 21 Dec 2023 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7b7fdde8b54so12756439f.1;
        Wed, 20 Dec 2023 18:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703124085; x=1703728885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uprnz/jjYuy4jWp8M6YseVkbWg8KRWXhaIAky0jmfE=;
        b=fvl5fdhkGCMSY4JACtoE5vZEE0OZ5mvM5hc/zaI0tobA2ZmXV0w5QWqYAXIhfvhdR3
         qzee0RVDbtCM6+9YCwFYnS+/mP+MQdmFdg19YU15PCKZC+6VjmXgqkwL/g4KjsfW4Ibk
         0odUQKp38Rqic+FTfD+FLUUhzBq3F4lW1DGqJXJpLNI+/g85mA+D2qVwZECHiUhbtbjd
         1C4pxbpuBXD+u94iW/HadP649b/wmqI14iI1JJE0cr2YQr9QLdWc8bLcHPbxhF8ZUxQH
         xoKGZKIgzltMwZMGS6eRkB9B1CcmJkerTpE2ztDeV5dj1kBcszWdZSmXYX7gNDIj7/65
         l0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703124085; x=1703728885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uprnz/jjYuy4jWp8M6YseVkbWg8KRWXhaIAky0jmfE=;
        b=QmkDB2coY1A7hecqxdYSm8mnXFiM4d6nQDmU7iktU+AYFQPiQjuSxiGzPRXIyb2nn6
         E0r13MTApr1wtySm71cq0kTYVojFFlRjFb7yVfTqf2Oq7Vu6fCRrtXa+1cjB2j6dJwQT
         iP0hl1pUVFDg1H3mPCudWX6vnXRR25qwx2TI/aJU3xwjtH1wIrTAdAWyuOe4Zsdb4wpt
         IfAbBVnare7cGOAWHQ/dwnfaBV+rzi4Nj52epboRdRkUyFD+5TVi8WqkPZwO1POF0fvL
         3bbAUcw9gbI1KVCH8xAuT3b4eiZGRofXBGtttYVGjbLJmximCtfejLWYGJRvGpQYFtjU
         wsjA==
X-Gm-Message-State: AOJu0YxPh0MDMn7wQPtygLkLttPWqW/4j5+Znwrg3YO0Iz20hAsxTtq7
	ztzT3qrV6rf6lDYokq4K3l6PhDFMkU/zz0XMqX0=
X-Google-Smtp-Source: AGHT+IHR51LjiWdOebtbBexnDeSV//C/Noc4zDv9CvLklzYhekwRS6kGUobGMBJIQkMj3Tu/WQhPg+zbFBnbMgKV5YM=
X-Received: by 2002:a6b:3f56:0:b0:7b9:232c:eeb3 with SMTP id
 m83-20020a6b3f56000000b007b9232ceeb3mr2763300ioa.6.1703124084910; Wed, 20 Dec
 2023 18:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220152653.3273778-1-schatzberg.dan@gmail.com> <20231220152653.3273778-2-schatzberg.dan@gmail.com>
In-Reply-To: <20231220152653.3273778-2-schatzberg.dan@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 20 Dec 2023 18:01:14 -0800
Message-ID: <CAKEwX=NppvrRFLJzksQ5noHmWHEfWmyiVA2DyhMcY3Lh9dgJ3w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm: add defines for min/max swappiness
To: Dan Schatzberg <schatzberg.dan@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, SeongJae Park <sj@kernel.org>, 
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Yue Zhao <findns94@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:27=E2=80=AFAM Dan Schatzberg <schatzberg.dan@gmai=
l.com> wrote:
>
> We use the constants 0 and 200 in a few places in the mm code when
> referring to the min and max swappiness. This patch adds MIN_SWAPPINESS
> and MAX_SWAPPINESS #defines to improve clarity. There are no functional
> changes.
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> ---
>  include/linux/swap.h |  2 ++
>  mm/memcontrol.c      |  2 +-
>  mm/vmscan.c          | 14 +++++++-------
>  3 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f6dd6575b905..e2ab76c25b4a 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -407,6 +407,8 @@ extern unsigned long try_to_free_pages(struct zonelis=
t *zonelist, int order,
>
>  #define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
>  #define MEMCG_RECLAIM_PROACTIVE (1 << 2)
> +#define MIN_SWAPPINESS 0
> +#define MAX_SWAPPINESS 200
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *mem=
cg,
>                                                   unsigned long nr_pages,
>                                                   gfp_t gfp_mask,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b226090fd906..fbe9f02dd206 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4337,7 +4337,7 @@ static int mem_cgroup_swappiness_write(struct cgrou=
p_subsys_state *css,
>  {
>         struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
>
> -       if (val > 200)
> +       if (val > MAX_SWAPPINESS)
>                 return -EINVAL;
>
>         if (!mem_cgroup_is_root(memcg))
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9dd8977de5a2..d91963e2d47f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -183,7 +183,7 @@ struct scan_control {
>  #endif
>
>  /*
> - * From 0 .. 200.  Higher means more swappy.
> + * From 0 .. MAX_SWAPPINESS.  Higher means more swappy.
>   */
>  int vm_swappiness =3D 60;
>
> @@ -2403,7 +2403,7 @@ static void get_scan_count(struct lruvec *lruvec, s=
truct scan_control *sc,
>         ap =3D swappiness * (total_cost + 1);
>         ap /=3D anon_cost + 1;
>
> -       fp =3D (200 - swappiness) * (total_cost + 1);
> +       fp =3D (MAX_SWAPPINESS - swappiness) * (total_cost + 1);
>         fp /=3D file_cost + 1;
>
>         fraction[0] =3D ap;
> @@ -4400,7 +4400,7 @@ static int get_type_to_scan(struct lruvec *lruvec, =
int swappiness, int *tier_idx
>  {
>         int type, tier;
>         struct ctrl_pos sp, pv;
> -       int gain[ANON_AND_FILE] =3D { swappiness, 200 - swappiness };
> +       int gain[ANON_AND_FILE] =3D { swappiness, MAX_SWAPPINESS - swappi=
ness };
>
>         /*
>          * Compare the first tier of anon with that of file to determine =
which
> @@ -4436,7 +4436,7 @@ static int isolate_folios(struct lruvec *lruvec, st=
ruct scan_control *sc, int sw
>         /*
>          * Try to make the obvious choice first. When anon and file are b=
oth
>          * available from the same generation, interpret swappiness 1 as =
file
> -        * first and 200 as anon first.
> +        * first and MAX_SWAPPINESS as anon first.
>          */
>         if (!swappiness)
>                 type =3D LRU_GEN_FILE;
> @@ -4444,7 +4444,7 @@ static int isolate_folios(struct lruvec *lruvec, st=
ruct scan_control *sc, int sw
>                 type =3D LRU_GEN_ANON;
>         else if (swappiness =3D=3D 1)
>                 type =3D LRU_GEN_FILE;
> -       else if (swappiness =3D=3D 200)
> +       else if (swappiness =3D=3D MAX_SWAPPINESS)
>                 type =3D LRU_GEN_ANON;
>         else
>                 type =3D get_type_to_scan(lruvec, swappiness, &tier);
> @@ -5398,9 +5398,9 @@ static int run_cmd(char cmd, int memcg_id, int nid,=
 unsigned long seq,
>
>         lruvec =3D get_lruvec(memcg, nid);
>
> -       if (swappiness < 0)
> +       if (swappiness < MIN_SWAPPINESS)
>                 swappiness =3D get_swappiness(lruvec, sc);
> -       else if (swappiness > 200)
> +       else if (swappiness > MAX_SWAPPINESS)
>                 goto done;
>
>         switch (cmd) {
> --
> 2.39.3
>

Sorry for being late to the party :) Was preoccupied with zswap convos.

Hmm these are all the occurrences of 0 and 200 (in the context of
swappiness) I can dig out. So, FWIW:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

