Return-Path: <cgroups+bounces-4280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A148695260B
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 00:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC90A1C21045
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8412F14BFA8;
	Wed, 14 Aug 2024 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kA6Rl2fB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C0214AD0A
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 22:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723676292; cv=none; b=RSSm8NZ5g9xKCNy8dfnCQkZXhTglyFnCScXRV6nmKL1z6xTrdLzk68cwsMR+RA6ZFpHhLC2q496BvCmRhaHnYvvJAIhP/azM6sIU3ZJUUAz+WWTfz391tWTTavz6GrqfGMYNYuYUgVmR4n5Pq5NY+8yR0n2wJ559exyXIqi2+AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723676292; c=relaxed/simple;
	bh=ZbemgLhJAX6z8KMdqIkuMFWmASPybqBsO3ODhsdJFeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YH0BM1btk1uejWhnL6zbzv2M5gdkhHkwBY6NZl1SdwkvZrV/5XmmqYhxBNzFwNyt299+115hXq/bLWCoO/hKZfIxQJJ5q+ESvkyen3iufeuRR6KgFbiol4b4Z+Gjl39goZ9cCI5Si58e0YssGvxtZd0Q9B6i5ohPqWoQij1KWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kA6Rl2fB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-664b4589b1aso12111717b3.1
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 15:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723676287; x=1724281087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg2m0Y0MLRB7Avk9yfRLo8H0fSSwKpXrdO3LFcvmAyE=;
        b=kA6Rl2fBTVXaSGfVqL116pPDP9qSaTkIB6Uedft/I1WBwOw1+F9Vm7/ZofWFqQ6fSK
         FOs8HVDFwM1wwhL0Nt6aqwzs5rrZyD7zwpaeS9Z1WLvhSQs7pEHKkyrRczQWJJsjmX2X
         YqiB5K9xQyqbGH6eZ3KRKyBXUmYsMx0L0LvKnM5TfAWj3lwfLaT8FDVKxsoGEipFNhLO
         zNfgDx5OwYTC5uQuG1eynVwcGuoBVHJ/7IhN1eAU1PjcKtVkLxa5jd1zvZ5stGqMulyo
         q94AYQJ1DIhHFeh6Xv6WtFFZkXnQBUlkK0VyYwj8vy7mTZ/RNJNjx+gRJqnljJp1JlD4
         358w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723676287; x=1724281087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg2m0Y0MLRB7Avk9yfRLo8H0fSSwKpXrdO3LFcvmAyE=;
        b=ak4sMUxdDxtrgLMil3Xfj6usMSNC1vDIGx9p136isj1HMg8/JM1WBVoxPqb3F55guC
         R+M1YgdUtOT7OvqkL23Qz/rEgWUEiurcF3uh98Gl6IT6QIe4G7V5Dl0guCUJuGWfcpwb
         +ixAaVJB36Qj58bCUNiCeBPhqaKD9rNsI5EBYNFkgOBAgoe0LSI2Sa8DfnD09v6pJwFT
         KglrhOmf35X6TNjtl2GP1x9yMl3jJ7CZeyseQPOOKDrxZLQPasilG0i2oaukXOP2mFM0
         3C6vpu1Lay5qNzq3VidAwt0dFUW1oO6J9DYolMWTKKKdnpWdYvSXkfrTm3wW3SmedDB8
         cnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFYPeYA4R9D2MxtX/oYLPPKwrFwvRLwb+wkGh6ctJq5Y8Ne5Dy2hMEYUT5aCSzitkIJaDNevp8wcY/roVIDY/gcRFevmsdTQ==
X-Gm-Message-State: AOJu0YzR/c+Gfdmt0aAHCjgvqom84C26L/d80ka7yBMXfAbUt8AqWHF2
	ipa8hCOt+QClh6y1LA9qDvOy3jKe6KFzlUYj+LwJNjDgx20UlYhBrBccADpBm8p4b13DiSd03fs
	zl3b6F7wt0Y7QzHUr8EMo4aTTTgYcoMo0BCNM
X-Google-Smtp-Source: AGHT+IGE3OvVYyMYXkHkGJ1LSwjpNsAdugkc/con7/60JcJ4IkohU717cj0tGtSNLqUJ8SRDWSiXbwmKw4ZrDuLrhI0=
X-Received: by 2002:a05:6902:d4a:b0:e11:48d6:a437 with SMTP id
 3f1490d57ef6-e116cc4aee0mr1359570276.2.1723676286771; Wed, 14 Aug 2024
 15:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814220021.3208384-1-shakeel.butt@linux.dev> <20240814220021.3208384-3-shakeel.butt@linux.dev>
In-Reply-To: <20240814220021.3208384-3-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 15:57:54 -0700
Message-ID: <CABdmKX3cYEqBoL=x8dpynwQenJZ8u=EPWaXXa6FHU_vXj2j2DA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] memcg: initiate deprecation of v1 soft limit
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 3:00=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Memcg v1 provides soft limit functionality for the best effort memory
> sharing between multiple workloads on a system. It is usually triggered
> through kswapd and at the moment does not reclaim kernel memory.
>
> Memcg v2 provide more straightforward best effort (memory.low) and hard

"provides"

> protection (memory.min) functionalities. Let's initiate the deprecation
> of soft limit from v1 and gather if v2 needs something more to move the
> existing v1 users to v2 regarding soft limit.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: T.J. Mercier <tjmercier@google.com>



> ---
> Changes since v1:
> - N/A
>
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
>  mm/memcontrol-v1.c                             | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 0114d758beab..6831c6c16e3f 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -78,6 +78,8 @@ Brief summary of control files.
>   memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
>   memory.soft_limit_in_bytes         set/show soft limit of memory usage
>                                      This knob is not available on CONFIG=
_PREEMPT_RT systems.
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>   memory.stat                        show various statistics
>   memory.use_hierarchy               set/show hierarchical account enable=
d
>                                       This knob is deprecated and shouldn=
't be
> @@ -701,8 +703,10 @@ For compatibility reasons writing 1 to memory.use_hi=
erarchy will always pass::
>
>         # echo 1 > memory.use_hierarchy
>
> -7. Soft limits
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +7. Soft limits (DEPRECATED)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> +
> +THIS IS DEPRECATED!
>
>  Soft limits allow for greater sharing of memory. The idea behind soft li=
mits
>  is to allow control groups to use as much of the memory as needed, provi=
ded
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index b8e2ee454eaa..e0bb54e42011 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2458,6 +2458,9 @@ static ssize_t mem_cgroup_write(struct kernfs_open_=
file *of,
>                 if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>                         ret =3D -EOPNOTSUPP;
>                 } else {
> +                       pr_warn_once("soft_limit_in_bytes is deprecated a=
nd will be removed. "
> +                                    "Please report your usecase to linux=
-mm@kvack.org if you "
> +                                    "depend on this functionality.\n");
>                         WRITE_ONCE(memcg->soft_limit, nr_pages);
>                         ret =3D 0;
>                 }
> --
> 2.43.5
>

