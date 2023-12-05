Return-Path: <cgroups+bounces-818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2913B805CC8
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 19:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C996E1F21555
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 18:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91816A34B;
	Tue,  5 Dec 2023 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K4NqijX6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B51BE
	for <cgroups@vger.kernel.org>; Tue,  5 Dec 2023 10:03:04 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c9ee6fed3eso53035521fa.0
        for <cgroups@vger.kernel.org>; Tue, 05 Dec 2023 10:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701799383; x=1702404183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2joey/D+/Fter5JFQfAZeSyog4t3NYaVzZzIbt4q+Y=;
        b=K4NqijX6vzRxeN5fCvsWetxzBFw6RHkzrjJOLDgmkOqrYLrnEQ3/IaQLc5h8M3pY5f
         ecFe6bfGAlf/0KNTUgYgUyfkxEcwKS2JJ+htNv87SnIIFuJVBUtxFm8z5u+sSmn+4mJO
         HzHcnfWtHdPReGa9Lf/QP4BHM4djMBauSIbj/0om0skuCWZpx5NAgFgnGBQFP5JMNe9b
         kFHfU8pQln5C/y3zicrHTUKNdj8KSaXOyvXAlPPvPV9r8GpmlzCVqQuijl0bOQRNObZU
         rIEETgW+gJw1a6+pNiBDHHVrjMWq4661p2eMHl6GBRybFHYu58CZI5gidxJmHp7ZYFgP
         IcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799383; x=1702404183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2joey/D+/Fter5JFQfAZeSyog4t3NYaVzZzIbt4q+Y=;
        b=TvhBGpU0i/AR4KmGqhjAL05gXpW3IOn8H0Dr6Tn0TEUPciR+fbDppX/TdcaTToZ8oF
         ygv1KbwDGSR6oOM1a5A439S5PGNIWw7k421gLpy6xbhKlQ/mAprnn2NRt0FWZ8uJq6F8
         U8v4WYfEAG4S+wEpFBKHnCkzY+2uKPvVxtBSCBwfAtw0THRP+3nxfoHZR7qwQelugokL
         /0HbkEKvBldnRyYO/c9Mi150Gf7igN1JYSqwAmSaJVR0bxhiEr0ElIPA0eUzeYc0Mt12
         ePo9LSosL/UJch4syu775C5RB6m3Vp6y9pQqzHnA2f9US199L3ZwM02cq/lkc03y0uqn
         plLA==
X-Gm-Message-State: AOJu0YzdZBNMpoQgwQum4qn/B6uUpyYOOe2pFLtO1xWJ09QYV3yn3Fb0
	NXnu+JVDpMhxmzdBKocNtA6WZ/TXUl2EXRnVGPG2gw==
X-Google-Smtp-Source: AGHT+IEXzOUK5t8bzip+5ZofybxHjbqPtQkvb0sQwnXT+0r4S9PaBhfe3FGVUffgOkL3/lvjFblZ2xbK3YEUDgy6Tw0=
X-Received: by 2002:a05:651c:1056:b0:2c9:f5ec:40ff with SMTP id
 x22-20020a05651c105600b002c9f5ec40ffmr2569169ljm.26.1701799382434; Tue, 05
 Dec 2023 10:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
In-Reply-To: <20231130194023.4102148-3-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 5 Dec 2023 10:02:23 -0800
Message-ID: <CAJD7tka+e-RWVN8qkCLv52z8G0KAXNO87CqV3p5Wgkx6BvneLw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com, 
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com, 
	muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> This patch implements a helper function that try to get a reference to
> an memcg's css, as well as checking if it is online. This new function
> is almost exactly the same as the existing mem_cgroup_tryget(), except
> for the onlineness check. In the !CONFIG_MEMCG case, it always returns
> true, analogous to mem_cgroup_tryget(). This is useful for e.g to the
> new zswap writeback scheme, where we need to select the next online
> memcg as a candidate for the global limit reclaim.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7bdcf3020d7a..2bd7d14ace78 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct mem_cgro=
up *memcg)
>         return !memcg || css_tryget(&memcg->css);
>  }
>
> +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> +{
> +       return !memcg || css_tryget_online(&memcg->css);
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>         if (memcg)
> @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct mem_cg=
roup *memcg)
>         return true;
>  }
>
> +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> +{
> +       return true;
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  }
> --
> 2.34.1

