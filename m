Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2511C426FA3
	for <lists+cgroups@lfdr.de>; Fri,  8 Oct 2021 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbhJHRhd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 Oct 2021 13:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhJHRha (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 Oct 2021 13:37:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2279FC061755
        for <cgroups@vger.kernel.org>; Fri,  8 Oct 2021 10:35:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u18so42009224lfd.12
        for <cgroups@vger.kernel.org>; Fri, 08 Oct 2021 10:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VPAeexfeOB6o98JRDi1ACJzyuQXs5JhkfM02uJqTm0=;
        b=FP13VZlniV+IoAFJLmoJcHDk8TtBwY9o9QaWTcNjuF8LFUXGyt1e/yMPp3IoW8c2gR
         h2tWPVg9GWcbfFqHlFtA/6vMWP722nIhlOQQsfcKCkHlOVBYGfHb7KCX2OvGmygbbPA6
         F2OmrLBLWpZx4Z6RLVeQuQmUDaUduMxFGdKKqAXBlegzGQ+WiQqNONZf8JCekyjfyQpG
         739Ax5rs3sQkenq+RyBXTG78iNV/QEP71fwJtzKfR7BS5CtcFUjreZrNjOGRj2HtvebZ
         9z4sTg9p9sZXq/V3B16Gt/puPG+04xXdXW66RHRfeZf2+aik86F6qhonX2ZN10Qyo3H8
         ugUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VPAeexfeOB6o98JRDi1ACJzyuQXs5JhkfM02uJqTm0=;
        b=SKIpVHeq3GPm+DCkt7ycXQF2JHfAxCXIZ/Cai2c4b2wr15xrmQTJkRnPycZTSpvRUm
         0vW0TNDmO035FrwhA4bG0LzTBDZTCh1Pib6LmocoF/OHDeoGPNimK85Y5RYck+G31i8p
         eVchYUT56GwZD2sGOAaUaQRa1EKnFvbM/6JQAyB4xPaBwYbGdvm1EG0LycaiFd42p28l
         4QK/ERGygwkSTYsDc50cv2xCtkv8dtz5P/nckNu4M4iDOxYqds+1DBmncD041jpTpLPo
         RtFvr3dXXSCLHEmKfYgAuTV9UslG+xqvszzIQ4cxo6iKuUDbt3vjjvMpELvdjgd+3RTY
         2AKA==
X-Gm-Message-State: AOAM533/nsiEMUxmLdtOE5nMtdJRmTEuAV7zoU705SBthGnuckA4/dJe
        4YX+t9nxH1biava7pTiKd/+8uIImlJjq6HhVzDFbrA==
X-Google-Smtp-Source: ABdhPJxTtyAXfkAipUU4ESl6gqg/Ep1F4KNHDSMcJQ8tpbjaqzt14nLv+k4NrYKPJyLs75yL8bFgsN8pHG51/LwsIow=
X-Received: by 2002:a05:651c:1793:: with SMTP id bn19mr4749093ljb.475.1633714533204;
 Fri, 08 Oct 2021 10:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <6411d3f7-b3a4-23a8-14fc-fcf6b9c5b73a@virtuozzo.com> <bf3b1364-2c48-533f-9dae-22470074a037@virtuozzo.com>
In-Reply-To: <bf3b1364-2c48-533f-9dae-22470074a037@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 8 Oct 2021 10:35:22 -0700
Message-ID: <CALvZod7_fhgV39HXmmMApubW-39CjJ5t+WjmkyA_DNGF7b5O+w@mail.gmail.com>
Subject: Re: [PATCH memcg] memcg: enable memory accounting in __alloc_pages_bulk
To:     Vasily Averin <vvs@virtuozzo.com>, Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Roman

On Fri, Oct 8, 2021 at 2:23 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Enable memory accounting for bulk page allocator.
>
> Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  mm/page_alloc.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..602819a232e5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5172,6 +5172,55 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
>         return true;
>  }
>

Please move the following memcg functions to memcontrol.[h|c] files.

> +#ifdef CONFIG_MEMCG_KMEM
> +static bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
> +                                       unsigned int nr_pages)
> +{
> +       struct obj_cgroup *objcg = NULL;
> +
> +       if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
> +               return true;
> +
> +       objcg = get_obj_cgroup_from_current();
> +
> +       if (objcg && obj_cgroup_charge(objcg, gfp, nr_pages << PAGE_SHIFT)) {

Please use obj_cgroup_charge_pages() when you move this code to memcontrol.c

> +               obj_cgroup_put(objcg);
> +               return false;
> +       }
> +       obj_cgroup_get_many(objcg, nr_pages);
> +       *objcgp = objcg;
> +       return true;
> +}
> +
> +static void memcg_bulk_charge_hook(struct obj_cgroup *objcg,
> +                                       struct page *page)
> +{
> +       page->memcg_data = (unsigned long)objcg | MEMCG_DATA_KMEM;
> +}
> +
> +static void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
> +                                       unsigned int nr_pages)
> +{
> +       obj_cgroup_uncharge(objcg, nr_pages << PAGE_SHIFT);
> +       percpu_ref_put_many(&objcg->refcnt, nr_pages + 1);

Introduce the obj_cgroup_put_many() and you don't need to keep the
extra ref from the pre hook i.e. put the ref in the pre hook.

> +}
> +#else
> +static bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
> +                                       unsigned int nr_pages)
> +{
> +       return true;
> +}
> +
> +static void memcg_bulk_charge_hook(struct obj_cgroup *objcgp,
> +                                       struct page *page)
> +{
> +}
> +
> +static void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
> +                                       unsigned int nr_pages)
> +{
> +}
> +#endif
>  /*
>   * __alloc_pages_bulk - Allocate a number of order-0 pages to a list or array
>   * @gfp: GFP flags for the allocation
> @@ -5207,6 +5256,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>         gfp_t alloc_gfp;
>         unsigned int alloc_flags = ALLOC_WMARK_LOW;
>         int nr_populated = 0, nr_account = 0;
> +       unsigned int nr_pre_charge = 0;
> +       struct obj_cgroup *objcg = NULL;
>
>         /*
>          * Skip populated array elements to determine if any pages need
> @@ -5275,6 +5326,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>         if (unlikely(!zone))
>                 goto failed;
>
> +       nr_pre_charge = nr_pages - nr_populated;
> +       if (!memcg_bulk_pre_charge_hook(&objcg, gfp, nr_pre_charge))
> +               goto failed;
> +
>         /* Attempt the batch allocation */
>         local_lock_irqsave(&pagesets.lock, flags);
>         pcp = this_cpu_ptr(zone->per_cpu_pageset);
> @@ -5287,9 +5342,9 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>                         nr_populated++;
>                         continue;
>                 }
> -
>                 page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
>                                                                 pcp, pcp_list);
> +
>                 if (unlikely(!page)) {
>                         /* Try and get at least one page */
>                         if (!nr_populated)
> @@ -5297,6 +5352,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>                         break;
>                 }
>                 nr_account++;
> +               if (objcg)
> +                       memcg_bulk_charge_hook(objcg, page);

Logically this above should be after prep_new_page().

>
>                 prep_new_page(page, 0, gfp, 0);
>                 if (page_list)
> @@ -5310,13 +5367,16 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>
>         __count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
>         zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
> +       if (objcg)
> +               memcg_bulk_post_charge_hook(objcg, nr_pre_charge - nr_account);
>
>  out:
>         return nr_populated;
>
>  failed_irq:
>         local_unlock_irqrestore(&pagesets.lock, flags);
> -
> +       if (objcg)
> +               memcg_bulk_post_charge_hook(objcg, nr_pre_charge);
>  failed:
>         page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
>         if (page) {
> --
> 2.31.1
>
