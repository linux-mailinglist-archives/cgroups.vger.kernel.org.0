Return-Path: <cgroups+bounces-4268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ACF95245B
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 22:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C69F1F2447D
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 20:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C51C5792;
	Wed, 14 Aug 2024 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6qAyX8X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C41BC069
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669171; cv=none; b=YrX9l75ALGrXTKuRKkwwRsif3uO2ueUSvNHlsIJ8LArG9NHBVbq7rKn/rJFBMoEnhfx/CtgxtAz2CSEi/b6BYuyVo3tCcj/cievmdtZKANjlDnrinCYRJg2znOt5vX74i/91FPDw5eAV+AvKSsUo71X0HDc3QfBYOMpi2jB1SN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669171; c=relaxed/simple;
	bh=z/++biqcPLbdFhnEZO3OZrkvvr7TgPxYik694Y2Qbm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqn2nm6u2Nbu22St4QDcjxjyYcbubT9dOy22xYERYC0me6VjOEKqLAgZqZP9KUDdXshUpJqT9S9+D007n1d93MrgfcRS+HveL1oyyI9tib+6say96DDT43libvlK3tEeVYQyqKKNya/yLsd1NmhnGilrhbN8ZYuO+jWP0gvBPlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6qAyX8X; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e116b591e15so387185276.3
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723669167; x=1724273967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KLTTn/hjmzFSkfe2zHJsLIOkpo44yYFx9b8AKrmGa4=;
        b=T6qAyX8XPpWSab7vsTRL+nThcPGMpMQwjoaer4d6d5P1rGGgXDmIj8a9mgYjS+gNV+
         fU2VYmzoV9qwTZbumLu5Imlwz8yMCbJjG0PtWcVEGDo/daZek0eR8GR5uPBGjBGRn8FK
         0n1tT/RRLgJsgz/jb7qbN6CZ+8FzR2w826eSmIoV0zDl+icRlRJtzi7zGo0u7TRN4j84
         Aki5Xcscojj3G3RSFOSWfuXF2ibGjn7njNcpFDLRahxgruUo6wLFlLF04ak6wSUfOzJj
         tgGxYhsnLUIH6cXAxdXNERg7QNPrdE3PksZCI5wt0DqGeGluTj6gFSI+8miRVo3XXjTx
         z4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669167; x=1724273967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KLTTn/hjmzFSkfe2zHJsLIOkpo44yYFx9b8AKrmGa4=;
        b=PTJbCEhuiRoMkxriM2QaQV+J8X9pOcsH8iUKrWBTKzQwMqLFFn3ldI/6cs/iGjq5x7
         TtbQ9zZSsLA+snNgnLcF+jCraCyY0ctdc+QfLQMyX/dccrFrbh9IJmsA0SdAsuf3PQkh
         La6JZwluwvYUKoiMczAam1TQE+GUtNp012yz89RYz2EUr6tleWiNb/bsW8JMRfkmwya1
         pOVbE+GPx0F6jKuC4zhPGr3nGf6OqrAfIrv0i/q2TmeNo6+ap4j4VMhS5yH8vPZ+vfI6
         IUVCWlXjISc8KgC705t7JdwE8w3+8u+Vt8m5plsEumNaLBrG4Ak6J38gK3RwTxHnOUYA
         L4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCWeHs9GDa/OzN2/8/LQ6YqCLagWq2j9VXox8ap2oO79ZIZcwFHZF1ky7IkgiItWDUPo5+vv2ZOWFK3yYJ61E93YXXaqNBuoIg==
X-Gm-Message-State: AOJu0Ywqye/+Wc5gkxaYMdcKVP0xKnXqNqai5cNVQSvLU3b55W+4VqMv
	gHaORvBJSVOBZz9N+WvBok0WG6XgeZkMqs6FcUiNeeLTCu1a0Y/UeYluHB+4pbFcmYuIxPioCgf
	pimfktj5NWekyeMz2jVhk9sgWG8E2HuX9TPjJ
X-Google-Smtp-Source: AGHT+IG6u9xXVM5sR6V6akfNNtSjFrQtV99kTT+jKruHC8y3/HDjw2NnRNFY4ZhQmcIEGdS9c4P0PYvFzO2HxMdto5A=
X-Received: by 2002:a05:6902:2804:b0:e0b:9412:328f with SMTP id
 3f1490d57ef6-e1155bd1112mr3928570276.56.1723669167090; Wed, 14 Aug 2024
 13:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814202825.2694077-1-shakeel.butt@linux.dev> <20240814202825.2694077-2-shakeel.butt@linux.dev>
In-Reply-To: <20240814202825.2694077-2-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 14 Aug 2024 13:59:15 -0700
Message-ID: <CABdmKX07o8ywPNoTDL_tM6qn46TXeLbhHoQEtBpFBXJkWdAc7A@mail.gmail.com>
Subject: Re: [PATCH 1/4] memcg: initiate deprecation of v1 tcp accounting
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:28=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> Memcg v1 provides opt-in TCP memory accounting feature. However it is
> mostly unused due to its performance impact on the network traffic. In
> v2, the TCP memory is accounted in the regular memory usage and is
> transparent to the users but they can observe the TCP memory usage
> through memcg stats.
>
> Let's initiate the deprecation process of memcg v1's tcp accounting
> functionality and add warnings to gather if there are any users and if
> there are, collect how they are using it and plan to provide them better
> alternative in v2.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++++
>  mm/memcontrol-v1.c                             | 3 +++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentati=
on/admin-guide/cgroup-v1/memory.rst
> index 9cde26d33843..fb6d3e2a6395 100644
> --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> @@ -105,10 +105,18 @@ Brief summary of control files.
>   memory.kmem.max_usage_in_bytes      show max kernel memory usage record=
ed
>
>   memory.kmem.tcp.limit_in_bytes      set/show hard limit for tcp buf mem=
ory
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>   memory.kmem.tcp.usage_in_bytes      show current tcp buf memory allocat=
ion
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>   memory.kmem.tcp.failcnt             show the number of tcp buf memory u=
sage
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>                                      hits limits

Looks like you split the description (that has weird grammar) here.

>   memory.kmem.tcp.max_usage_in_bytes  show max tcp buf memory usage recor=
ded
> +                                     This knob is deprecated and shouldn=
't be
> +                                     used.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
>  1. History
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 9725c731fb21..b8e2ee454eaa 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2447,6 +2447,9 @@ static ssize_t mem_cgroup_write(struct kernfs_open_=
file *of,
>                         ret =3D 0;
>                         break;
>                 case _TCP:
> +                       pr_warn_once("kmem.tcp.limit_in_bytes is deprecat=
ed and will be removed. "
> +                                    "Please report your usecase to linux=
-mm@kvack.org if you "
> +                                    "depend on this functionality.\n");
>                         ret =3D memcg_update_tcp_max(memcg, nr_pages);
>                         break;
>                 }
> --
> 2.43.5
>
Otherwise LGTM
Reviewed-by: T.J. Mercier <tjmercier@google.com>

