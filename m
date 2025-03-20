Return-Path: <cgroups+bounces-7195-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BFA6A1D5
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 09:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26E93B2D1D
	for <lists+cgroups@lfdr.de>; Thu, 20 Mar 2025 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4532214A84;
	Thu, 20 Mar 2025 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1LCAJEG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327D20A5C2;
	Thu, 20 Mar 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460714; cv=none; b=CdfEPZLJme3gwN1wICtPXFANmJb/9pn2DKrxhkhFHz2OxKzP2LSMnFVVsrUOHt66K8hyhTkA/vlfx3w3Cy86R+mVgL/EjSbebKRPRciXMo7MYojpqDy6QmPapwG4PhU9lmaUssUa/UEIb+Sx3YV7bNYqJ45Czm+gLR5WFAazNR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460714; c=relaxed/simple;
	bh=JEn4uYfqgy1hwMa16f77GeBerOpIzElfoQuzWTbY7ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZHQG0JndGaWlgocgrOkGFV1SSMfGXv/tVnhx8PXH195Kdae+vx4EhhOr8M62NHtIhTaJkszOtQkiVv9yxSP6+NFDozQKU3BsaPIjOEVTgXyNC7/yI0+XNXkPY8+TkW1Yfh7vpBXPQPINmaB6Oa5KZjTW1DorngDZtFk35uHF0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1LCAJEG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3018c9c6b5fso699943a91.3;
        Thu, 20 Mar 2025 01:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742460712; x=1743065512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy4HBkZZvRDagqbLsSywJbH3++NCC91zzn12ux5OSLU=;
        b=l1LCAJEGwG4Wnis6Ewhgdz8ztomGbH3HtBJO4BxdIuc56cD9+BYLHpinGVJtscB6Xz
         /iTFn6uLHT7rZROW56k3W7YoHNG00id7UFKJYe3fjEgjvHnR+ii8KN0OrTN+k26imiDb
         m+lFB1YLmjSwyELDM0sw8Yr2K655233TAlKmlHPencbUEnrCjuXrbjtOhE405P8/9T9T
         Hs4FAfKz7bImt36cptVwnm0aIQy+Kp8YQbXscBSyogtQxxTSN4r3b/6hu45Lw98xqq4O
         ehSm7oQzi4oDinfOrAvEbzr75xeQLwWpdV5t7Piku/ECv+yW1yrsM6pqVyErG6aBCR51
         TEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460712; x=1743065512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jy4HBkZZvRDagqbLsSywJbH3++NCC91zzn12ux5OSLU=;
        b=hR34EfEHwr+qjNld6nmGGndQRD9wcukoy4kt+Lzr08wC+M9r8xtVgCAUXPyq6z1NRJ
         MxxcDhxtjwWklnwv53g4zejzQ4tusl7SHlZRu9maYMmFJ7Yb2yi//S/goCEOzIqztfsv
         QjwBqsdT/SBPJP8JAwx4s07UcduNC0DxKH8+J4uLdQiiDEmpR9y1v6ENwr+gXGxMjmI6
         PuzYEd9k2xd8BMlVLWiaHqfxBwkai+epKkUpMeFY7AGUwdxNCjR8P32YSAhdunuJeZ71
         gUDmd/y3h516A47sR0Uq9s3NVGprJxSMH1WKjjsXvj+v4y9+/S6D0PrqbpL8i9rsZSMD
         +SFA==
X-Forwarded-Encrypted: i=1; AJvYcCU4sKhaX2ObG1db6Ia0IsQCBy3nbZV7zM9D8uygwmP2we2c6SizR3qMV8wB8S1+5/ZTjkRLM8I8@vger.kernel.org, AJvYcCUG/VX9y6xMDHOR6ITEPfLbL3Vu9xv8Veeu0IeY8nsMXuUjUxVbqJTRmHexfon3oseqVscMLRyBxC6LDPZM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82GMR6L24TP0xCCy7yV1xxoEHgzFBiluCaQqSySbvdIgkDfGk
	9yyN9ZY8yOQEzVCa5FycTbM4i1cs8ur8cx/pCeyM8ewoELmMa95459o1DK+5ek2N8r48+ntl69D
	X5yTD2Sb+pl2dfBq2Jr2ScsXekkY=
X-Gm-Gg: ASbGnctDuLreAkVdbiwemgd7P3tKlFF3P7s8w9YyjjdM820mn6y7O9OiUvOyDnWtswa
	1A8CNz9xmLKm50qSZkWNGXzrT4RsFJzp8L2oYdE0UIqYzhknN5Vl5GFqXiv2iRkbLQlQf+Sfrgg
	VVWBlylbV5eCNDIdPd5k8XXw1/UA==
X-Google-Smtp-Source: AGHT+IFcTv5zxMN4aAEORMfw5s1lJSixMHFvZdzFD0Icd4durPS8AUAcV0rqgs5k1LiI7LJhwlaXZLg+9MC2KBknenQ=
X-Received: by 2002:a17:90b:528d:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-301bdf93ec6mr8177668a91.21.1742460712223; Thu, 20 Mar 2025
 01:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319064148.774406-3-jingxiangzeng.cas@gmail.com> <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
In-Reply-To: <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Thu, 20 Mar 2025 16:51:41 +0800
X-Gm-Features: AQ5f1JrO1NBPoxcwIjbhWOaF8a9XArLpBVqRj9GaRCyngTyRamtN9uYt73qeu0U
Message-ID: <CAJqJ8iicy9wOVDhfMu-VCQb-FEj_ECO=p5fywpWnL-U=OMCzew@mail.gmail.com>
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account on dfl
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jingxiang Zeng <linuszeng@tencent.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev, 
	kasong@tencent.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 03:34, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> On Wed, Mar 19, 2025 at 02:41:45PM +0800, Jingxiang Zeng wrote:
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> >
> > Added cgroup.memsw_account_on_dfl startup parameter, which
> > is off by default. When enabled in cgroupv2 mode, the memory
> > accounting mode of swap will be reverted to cgroupv1 mode.
> >
> > Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
> > ---
> >  include/linux/memcontrol.h |  4 +++-
> >  mm/memcontrol.c            | 11 +++++++++++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index dcb087ee6e8d..96f2fad1c351 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -62,10 +62,12 @@ struct mem_cgroup_reclaim_cookie {
> >
> >  #ifdef CONFIG_MEMCG
> >
> > +DECLARE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> >  /* Whether enable memory+swap account in cgroupv2 */
> >  static inline bool do_memsw_account_on_dfl(void)
> >  {
> > -     return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
> > +     return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL)
> > +                             || static_branch_unlikely(&memsw_account_on_dfl);
>
> Why || in above condition? Shouldn't it be && ?

It seems that changing it to && is better, Thanks.
>
> >  }
> >
> >  #define MEM_CGROUP_ID_SHIFT  16
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 768d6b15dbfa..c1171fb2bfd6 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5478,3 +5478,14 @@ static int __init mem_cgroup_swap_init(void)
> >  subsys_initcall(mem_cgroup_swap_init);
> >
> >  #endif /* CONFIG_SWAP */
> > +
> > +DEFINE_STATIC_KEY_FALSE(memsw_account_on_dfl);
> > +static int __init memsw_account_on_dfl_setup(char *s)
> > +{
> > +     if (!strcmp(s, "1"))
> > +             static_branch_enable(&memsw_account_on_dfl);
> > +     else if (!strcmp(s, "0"))
> > +             static_branch_disable(&memsw_account_on_dfl);
> > +     return 1;
> > +}
> > +__setup("cgroup.memsw_account_on_dfl=", memsw_account_on_dfl_setup);
>
> Please keep the above in memcontrol-v1.c
>
> > +
> > \ No newline at end of file
> > --
> > 2.41.1
> >
>

