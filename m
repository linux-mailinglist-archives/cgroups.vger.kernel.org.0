Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE91E7B5E2E
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 02:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjJCA0Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 20:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjJCA0Z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 20:26:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEE9A9;
        Mon,  2 Oct 2023 17:26:21 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-79fb78e297bso13209839f.0;
        Mon, 02 Oct 2023 17:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292781; x=1696897581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtwzMbnkwk1Ycku16jGRZBLlrcj7oMZqN4WS/Bw58LQ=;
        b=JAFEezHSX9qadfKw0FLF0MW8RaFFv7kTKo1pWWP/y9rkPK2tmQ5/ZuNo5pLAz9fovJ
         tSqpN8P/IGL0tCcUGd5pEQh+HbLXFJmrZMr8iRhIvxt/Jun0A29mcND96sox5gAbuA8I
         LonrJF6doyoviTbYkR+10CfhQIyDCKNyxAp4iatB1aNiQ0upDjHE7YH/ZUiGCobiVzk5
         +pFXtOWlS8rPwkuy05Vqc8Ioy7Z41VCCsQBjh2+He4py17nLA0SV6YutoOcHCn9tekWP
         5M+XXtHEvtboFIDoy+fGwCbZY79ef6hu8M+nXbhtNc4WFs8txCG3tpnUasy94msZ1wVi
         HIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292781; x=1696897581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtwzMbnkwk1Ycku16jGRZBLlrcj7oMZqN4WS/Bw58LQ=;
        b=wLysdzHfrzGJxNsFfmFR5j4DhL3YQOzvaNrBDZMetQIe459bTv9mHfXM2WUSrflqVr
         CfwaBUBgjpxdNSaBt3zR56rN2tbdyadc6A9GRNoQpNsu3kIdzMXyufNlaGpPi8JA2nAT
         1HgfLbg3cnmVK0wFcyrwce6JOiXOVnCRgqLGIzlEYpzTYsis1qMkz44JvuyS82nhhdEq
         psvcCbatslSUEiCYo0mBxo5vYHsklbP3rODrUuNbwhXo+Q+UDQ5HbGkw4sRzALKBXKqv
         obG4kjbDLHEKfA5hovimfyciIq8cJfHsEaRF1vjYhfPPQc6TkSVKfzsZjr5rezzuEC9u
         m5Vg==
X-Gm-Message-State: AOJu0YyxCHzYUM3IgfVayThyGspPgp9gtizjRCOWc871PO+GIMISOyZL
        v0u+Xv3er83XBYCFniVPDtz+24bbCd7oYwqxV2U=
X-Google-Smtp-Source: AGHT+IG1PSSu0aP8/1VKYYnP2HrdrNI3U5F6uukotkfOhRoRWmWPZ9Bb2A1gx/QudzWJTMupmqMPnMA4MLJvCxk0WEc=
X-Received: by 2002:a5d:87c1:0:b0:792:9416:9c7f with SMTP id
 q1-20020a5d87c1000000b0079294169c7fmr14602270ios.9.1696292780470; Mon, 02 Oct
 2023 17:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231003001828.2554080-1-nphamcs@gmail.com> <20231003001828.2554080-3-nphamcs@gmail.com>
In-Reply-To: <20231003001828.2554080-3-nphamcs@gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 2 Oct 2023 17:26:09 -0700
Message-ID: <CAKEwX=NaxbyPtC7=Y9OmfeM4XBtRr82cJm1xcjRbWUCWs7KuVw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     akpm@linux-foundation.org
Cc:     riel@surriel.com, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        fvdl@google.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 2, 2023 at 5:18=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Currently, hugetlb memory usage is not acounted for in the memory
> controller, which could lead to memory overprotection for cgroups with
> hugetlb-backed memory. This has been observed in our production system.
>
> For instance, here is one of our usecases: suppose there are two 32G
> containers. The machine is booted with hugetlb_cma=3D6G, and each
> container may or may not use up to 3 gigantic page, depending on the
> workload within it. The rest is anon, cache, slab, etc. We can set the
> hugetlb cgroup limit of each cgroup to 3G to enforce hugetlb fairness.
> But it is very difficult to configure memory.max to keep overall
> consumption, including anon, cache, slab etc. fair.
>
> What we have had to resort to is to constantly poll hugetlb usage and
> readjust memory.max. Similar procedure is done to other memory limits
> (memory.low for e.g). However, this is rather cumbersome and buggy.
> Furthermore, when there is a delay in memory limits correction, (for e.g
> when hugetlb usage changes within consecutive runs of the userspace
> agent), the system could be in an over/underprotected state.
>
> This patch rectifies this issue by charging the memcg when the hugetlb
> folio is utilized, and uncharging when the folio is freed (analogous to
> the hugetlb controller). Note that we do not charge when the folio is
> allocated to the hugetlb pool, because at this point it is not owned by
> any memcg.
>
> Some caveats to consider:
>   * This feature is only available on cgroup v2.
>   * There is no hugetlb pool management involved in the memory
>     controller. As stated above, hugetlb folios are only charged towards
>     the memory controller when it is used. Host overcommit management
>     has to consider it when configuring hard limits.
>   * Failure to charge towards the memcg results in SIGBUS. This could
>     happen even if the hugetlb pool still has pages (but the cgroup
>     limit is hit and reclaim attempt fails).
>   * When this feature is enabled, hugetlb pages contribute to memory
>     reclaim protection. low, min limits tuning must take into account
>     hugetlb memory.
>   * Hugetlb pages utilized while this option is not selected will not
>     be tracked by the memory controller (even if cgroup v2 is remounted
>     later on).
(special thanks to Michal Hocko, who pointed most of these out).
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst | 29 ++++++++++++++++++++
>  include/linux/cgroup-defs.h             |  5 ++++
>  include/linux/memcontrol.h              |  9 +++++++
>  kernel/cgroup/cgroup.c                  | 15 ++++++++++-
>  mm/hugetlb.c                            | 35 ++++++++++++++++++++-----
>  mm/memcontrol.c                         | 35 +++++++++++++++++++++++++
>  6 files changed, 120 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 622a7f28db1f..606b2e0eac4b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -210,6 +210,35 @@ cgroup v2 currently supports the following mount opt=
ions.
>          relying on the original semantics (e.g. specifying bogusly
>          high 'bypass' protection values at higher tree levels).
>
> +  memory_hugetlb_accounting
> +        Count HugeTLB memory usage towards the cgroup's overall
> +        memory usage for the memory controller (for the purpose of
> +        statistics reporting and memory protetion). This is a new
> +        behavior that could regress existing setups, so it must be
> +        explicitly opted in with this mount option.
> +
> +        A few caveats to keep in mind:
> +
> +        * There is no HugeTLB pool management involved in the memory
> +          controller. The pre-allocated pool does not belong to anyone.
> +          Specifically, when a new HugeTLB folio is allocated to
> +          the pool, it is not accounted for from the perspective of the
> +          memory controller. It is only charged to a cgroup when it is
> +          actually used (for e.g at page fault time). Host memory
> +          overcommit management has to consider this when configuring
> +          hard limits. In general, HugeTLB pool management should be
> +          done via other mechanisms (such as the HugeTLB controller).
> +        * Failure to charge a HugeTLB folio to the memory controller
> +          results in SIGBUS. This could happen even if the HugeTLB pool
> +          still has pages available (but the cgroup limit is hit and
> +          reclaim attempt fails).
> +        * Charging HugeTLB memory towards the memory controller affects
> +          memory protection and reclaim dynamics. Any userspace tuning
> +          (of low, min limits for e.g) needs to take this into account.
> +        * HugeTLB pages utilized while this option is not selected
> +          will not be tracked by the memory controller (even if cgroup
> +          v2 is remounted later on).
> +
>
>  Organizing Processes and Threads
>  --------------------------------
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index f1b3151ac30b..8641f4320c98 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -115,6 +115,11 @@ enum {
>          * Enable recursive subtree protection
>          */
>         CGRP_ROOT_MEMORY_RECURSIVE_PROT =3D (1 << 18),
> +
> +       /*
> +        * Enable hugetlb accounting for the memory controller.
> +        */
> +        CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING =3D (1 << 19),
>  };
>
>  /* cftype->flags */
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 42bf7e9b1a2f..a827e2129790 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -679,6 +679,9 @@ static inline int mem_cgroup_charge(struct folio *fol=
io, struct mm_struct *mm,
>         return __mem_cgroup_charge(folio, mm, gfp);
>  }
>
> +int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> +               long nr_pages);
> +
>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct=
 *mm,
>                                   gfp_t gfp, swp_entry_t entry);
>  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> @@ -1262,6 +1265,12 @@ static inline int mem_cgroup_charge(struct folio *=
folio,
>         return 0;
>  }
>
> +static inline int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg=
,
> +               gfp_t gfp, long nr_pages)
> +{
> +       return 0;
> +}
> +
>  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
>                         struct mm_struct *mm, gfp_t gfp, swp_entry_t entr=
y)
>  {
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 1fb7f562289d..f11488b18ceb 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1902,6 +1902,7 @@ enum cgroup2_param {
>         Opt_favordynmods,
>         Opt_memory_localevents,
>         Opt_memory_recursiveprot,
> +       Opt_memory_hugetlb_accounting,
>         nr__cgroup2_params
>  };
>
> @@ -1910,6 +1911,7 @@ static const struct fs_parameter_spec cgroup2_fs_pa=
rameters[] =3D {
>         fsparam_flag("favordynmods",            Opt_favordynmods),
>         fsparam_flag("memory_localevents",      Opt_memory_localevents),
>         fsparam_flag("memory_recursiveprot",    Opt_memory_recursiveprot)=
,
> +       fsparam_flag("memory_hugetlb_accounting", Opt_memory_hugetlb_acco=
unting),
>         {}
>  };
>
> @@ -1936,6 +1938,9 @@ static int cgroup2_parse_param(struct fs_context *f=
c, struct fs_parameter *param
>         case Opt_memory_recursiveprot:
>                 ctx->flags |=3D CGRP_ROOT_MEMORY_RECURSIVE_PROT;
>                 return 0;
> +       case Opt_memory_hugetlb_accounting:
> +               ctx->flags |=3D CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
> +               return 0;
>         }
>         return -EINVAL;
>  }
> @@ -1960,6 +1965,11 @@ static void apply_cgroup_root_flags(unsigned int r=
oot_flags)
>                         cgrp_dfl_root.flags |=3D CGRP_ROOT_MEMORY_RECURSI=
VE_PROT;
>                 else
>                         cgrp_dfl_root.flags &=3D ~CGRP_ROOT_MEMORY_RECURS=
IVE_PROT;
> +
> +               if (root_flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
> +                       cgrp_dfl_root.flags |=3D CGRP_ROOT_MEMORY_HUGETLB=
_ACCOUNTING;
> +               else
> +                       cgrp_dfl_root.flags &=3D ~CGRP_ROOT_MEMORY_HUGETL=
B_ACCOUNTING;
>         }
>  }
>
> @@ -1973,6 +1983,8 @@ static int cgroup_show_options(struct seq_file *seq=
, struct kernfs_root *kf_root
>                 seq_puts(seq, ",memory_localevents");
>         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT)
>                 seq_puts(seq, ",memory_recursiveprot");
> +       if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
> +               seq_puts(seq, ",memory_hugetlb_accounting");
>         return 0;
>  }
>
> @@ -7050,7 +7062,8 @@ static ssize_t features_show(struct kobject *kobj, =
struct kobj_attribute *attr,
>                         "nsdelegate\n"
>                         "favordynmods\n"
>                         "memory_localevents\n"
> -                       "memory_recursiveprot\n");
> +                       "memory_recursiveprot\n"
> +                       "memory_hugetlb_accounting\n");
>  }
>  static struct kobj_attribute cgroup_features_attr =3D __ATTR_RO(features=
);
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index de220e3ff8be..74472e911b0a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
>                                      pages_per_huge_page(h), folio);
>         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>                                           pages_per_huge_page(h), folio);
> +       mem_cgroup_uncharge(folio);
>         if (restore_reserve)
>                 h->resv_huge_pages++;
>
> @@ -3009,11 +3010,20 @@ struct folio *alloc_hugetlb_folio(struct vm_area_=
struct *vma,
>         struct hugepage_subpool *spool =3D subpool_vma(vma);
>         struct hstate *h =3D hstate_vma(vma);
>         struct folio *folio;
> -       long map_chg, map_commit;
> +       long map_chg, map_commit, nr_pages =3D pages_per_huge_page(h);
>         long gbl_chg;
> -       int ret, idx;
> +       int memcg_charge_ret, ret, idx;
>         struct hugetlb_cgroup *h_cg =3D NULL;
> +       struct mem_cgroup *memcg;
>         bool deferred_reserve;
> +       gfp_t gfp =3D htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> +
> +       memcg =3D get_mem_cgroup_from_current();
> +       memcg_charge_ret =3D mem_cgroup_hugetlb_try_charge(memcg, gfp, nr=
_pages);
> +       if (memcg_charge_ret =3D=3D -ENOMEM) {
> +               mem_cgroup_put(memcg);
> +               return ERR_PTR(-ENOMEM);
> +       }
>
>         idx =3D hstate_index(h);
>         /*
> @@ -3022,8 +3032,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area_s=
truct *vma,
>          * code of zero indicates a reservation exists (no change).
>          */
>         map_chg =3D gbl_chg =3D vma_needs_reservation(h, vma, addr);
> -       if (map_chg < 0)
> +       if (map_chg < 0) {
> +               if (!memcg_charge_ret)
> +                       mem_cgroup_cancel_charge(memcg, nr_pages);
> +               mem_cgroup_put(memcg);
>                 return ERR_PTR(-ENOMEM);
> +       }
>
>         /*
>          * Processes that did not create the mapping will have no
> @@ -3034,10 +3048,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_s=
truct *vma,
>          */
>         if (map_chg || avoid_reserve) {
>                 gbl_chg =3D hugepage_subpool_get_pages(spool, 1);
> -               if (gbl_chg < 0) {
> -                       vma_end_reservation(h, vma, addr);
> -                       return ERR_PTR(-ENOSPC);
> -               }
> +               if (gbl_chg < 0)
> +                       goto out_end_reservation;
>
>                 /*
>                  * Even though there was no reservation in the region/res=
erve
> @@ -3119,6 +3131,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_s=
truct *vma,
>                         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h=
),
>                                         pages_per_huge_page(h), folio);
>         }
> +
> +       if (!memcg_charge_ret)
> +               mem_cgroup_commit_charge(folio, memcg);
> +       mem_cgroup_put(memcg);
> +
>         return folio;
>
>  out_uncharge_cgroup:
> @@ -3130,7 +3147,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area_s=
truct *vma,
>  out_subpool_put:
>         if (map_chg || avoid_reserve)
>                 hugepage_subpool_put_pages(spool, 1);
> +out_end_reservation:
>         vma_end_reservation(h, vma, addr);
> +       if (!memcg_charge_ret)
> +               mem_cgroup_cancel_charge(memcg, nr_pages);
> +       mem_cgroup_put(memcg);
>         return ERR_PTR(-ENOSPC);
>  }
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0219befeae38..6660684f6f97 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7085,6 +7085,41 @@ int __mem_cgroup_charge(struct folio *folio, struc=
t mm_struct *mm, gfp_t gfp)
>         return ret;
>  }
>
> +/**
> + * mem_cgroup_hugetlb_try_charge - try to charge the memcg for a hugetlb=
 folio
> + * @memcg: memcg to charge.
> + * @gfp: reclaim mode.
> + * @nr_pages: number of pages to charge.
> + *
> + * This function is called when allocating a huge page folio to determin=
e if
> + * the memcg has the capacity for it. It does not commit the charge yet,
> + * as the hugetlb folio itself has not been obtained from the hugetlb po=
ol.
> + *
> + * Once we have obtained the hugetlb folio, we can call
> + * mem_cgroup_commit_charge() to commit the charge. If we fail to obtain=
 the
> + * folio, we should instead call mem_cgroup_cancel_charge() to undo the =
effect
> + * of try_charge().
> + *
> + * Returns 0 on success. Otherwise, an error code is returned.
> + */
> +int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
> +                       long nr_pages)
> +{
> +       /*
> +        * If hugetlb memcg charging is not enabled, do not fail hugetlb =
allocation,
> +        * but do not attempt to commit charge later (or cancel on error)=
 either.
> +        */
> +       if (mem_cgroup_disabled() || !memcg ||
> +               !cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
> +               !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTI=
NG))
> +               return -EOPNOTSUPP;
> +
> +       if (try_charge(memcg, gfp, nr_pages))
> +               return -ENOMEM;
> +
> +       return 0;
> +}
> +
>  /**
>   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for s=
wapin.
>   * @folio: folio to charge.
> --
> 2.34.1
