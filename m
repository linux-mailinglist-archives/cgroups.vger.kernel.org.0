Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7604D713241
	for <lists+cgroups@lfdr.de>; Sat, 27 May 2023 05:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjE0D4E (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 May 2023 23:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjE0D4C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 May 2023 23:56:02 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914FA116
        for <cgroups@vger.kernel.org>; Fri, 26 May 2023 20:56:00 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f5d651170so485427766b.1
        for <cgroups@vger.kernel.org>; Fri, 26 May 2023 20:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159759; x=1687751759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIU3ApG2t6G3Om8A3cojlnR0RAZfWHqg0wkrw6J9EhQ=;
        b=7anKzrx54MpIV/vXgrNEGJ+XZ3nR4S6+xWVOb3/Tt5YzVkbt7WPWY4f/AUP5W2UVr9
         K530DnGhnTIFcYiYmBbo+tPqqc0Ukj9QD1CkrX7XYrabbntH5JpVHcroD+SlRHKtx3Rc
         kY9L1c3K7NoOo4hOq0VERwTXnGOaLU2O0SqU/NyahwGPOOUbS5EUDCZArHOouWnL9tEg
         LeojmsUC/tR7MDeCs6MFcte8HBoOGbF4eHruYHv8bCvGelALDHxcGpq7H+s6hSYEOfkY
         E9QwDQeUZPLWNJY8DCUHU9Ztj6DnJmr57JCEklUa3J76GNHAbm8Up0Y+fc+yiJ39usxW
         MKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159759; x=1687751759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIU3ApG2t6G3Om8A3cojlnR0RAZfWHqg0wkrw6J9EhQ=;
        b=HKpecms6zmRXVCPd+59mct1gDmAVjGoUwbsAMgQmZqJ1oD2clFgB7+uPAFU/lCufS8
         OLnc3d/JHxbX/8x/L/ykkePzhcGUA4Bc+V5CwQhoXH/5myKq9AlHZbxHhiHzK4FvFWwd
         NWi5d0eNvJSRfU3DZudzNnFEhV9vGi8MF4BwkzEl5SqIft5SyGXtjaoDhbdeCHZv+WnS
         8pthHY8SsFcbPunvuLEs5Rn73yGmEmJxis2hLVPB2qP0f3Q0xOwidAy6jk91Z2Hkycjq
         5QYZXf/l8qpA8wgVT5kNDThlp2X/D5bKxEH+QrjjGPw/AcjOMq1OB9FkFNR7VHLR0cTr
         D98Q==
X-Gm-Message-State: AC+VfDxYkt/nJI0VjK5zp6w7H5OS1GEdQ8YEQL1++gVAWHsSV0+PqMRo
        BJUjyLbjyNMOBuq1XV9B6+Tr/pPxCJweHofsttWpxQ==
X-Google-Smtp-Source: ACHHUZ7SopEnz/q4gRtKqNlLV+UWGEEECBRV2t4umB2KkFa2iCrFA+Z7MsdbSgcdVxUu8YqiHjj2qSfN4oUKBpBNgPI=
X-Received: by 2002:a17:906:9751:b0:971:5a79:29f2 with SMTP id
 o17-20020a170906975100b009715a7929f2mr981232ejy.15.1685159758897; Fri, 26 May
 2023 20:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230527103126.398267-1-linmiaohe@huawei.com>
In-Reply-To: <20230527103126.398267-1-linmiaohe@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 26 May 2023 20:55:22 -0700
Message-ID: <CAJD7tkZhUB9N6R-1mWAPGV=awEO0Y0cmi9OmGiVhjSfdFBCirQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: remove unused mem_cgroup_from_obj()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 26, 2023 at 7:40=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> The function mem_cgroup_from_obj() is not used anymore. Remove it and
> clean up relevant comments.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/memcontrol.h |  6 ------
>  mm/memcontrol.c            | 31 -------------------------------
>  2 files changed, 37 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 00a88cf947e1..ce8c2355ed9f 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1813,7 +1813,6 @@ static inline int memcg_kmem_id(struct mem_cgroup *=
memcg)
>         return memcg ? memcg->kmemcg_id : -1;
>  }
>
> -struct mem_cgroup *mem_cgroup_from_obj(void *p);
>  struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
>
>  static inline void count_objcg_event(struct obj_cgroup *objcg,
> @@ -1876,11 +1875,6 @@ static inline int memcg_kmem_id(struct mem_cgroup =
*memcg)
>         return -1;
>  }
>
> -static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
> -{
> -       return NULL;
> -}
> -
>  static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
>  {
>         return NULL;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6a3d4ce87b8a..532b29c9a0fe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2972,37 +2972,6 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struc=
t folio *folio, void *p)
>  /*
>   * Returns a pointer to the memory cgroup to which the kernel object is =
charged.
>   *
> - * A passed kernel object can be a slab object, vmalloc object or a gene=
ric
> - * kernel page, so different mechanisms for getting the memory cgroup po=
inter
> - * should be used.
> - *
> - * In certain cases (e.g. kernel stacks or large kmallocs with SLUB) the=
 caller
> - * can not know for sure how the kernel object is implemented.
> - * mem_cgroup_from_obj() can be safely used in such cases.
> - *
> - * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lo=
ck(),
> - * cgroup_mutex, etc.
> - */
> -struct mem_cgroup *mem_cgroup_from_obj(void *p)
> -{
> -       struct folio *folio;
> -
> -       if (mem_cgroup_disabled())
> -               return NULL;
> -
> -       if (unlikely(is_vmalloc_addr(p)))
> -               folio =3D page_folio(vmalloc_to_page(p));
> -       else
> -               folio =3D virt_to_folio(p);
> -
> -       return mem_cgroup_from_obj_folio(folio, p);
> -}
> -
> -/*
> - * Returns a pointer to the memory cgroup to which the kernel object is =
charged.
> - * Similar to mem_cgroup_from_obj(), but faster and not suitable for obj=
ects,
> - * allocated using vmalloc().

Perhaps keep the line about not being suitable for objects allocated
using vmalloc()? To be fair it's obvious from the function name, but I
am guessing whoever added it did for a reason.

I don't feel strongly either way, LGTM. I can't see any references in
Linus's tree or mm-unstable.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>


> - *
>   * A passed kernel object must be a slab object or a generic kernel page=
.
>   *
>   * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lo=
ck(),
> --
> 2.27.0
>
