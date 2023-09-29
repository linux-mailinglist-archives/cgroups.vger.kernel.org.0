Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32FF7B2999
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 02:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjI2Ad3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Sep 2023 20:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2Ad3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Sep 2023 20:33:29 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A958CF3;
        Thu, 28 Sep 2023 17:33:26 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-351250be257so36231615ab.0;
        Thu, 28 Sep 2023 17:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695947606; x=1696552406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNbnaLjNtFiIrRRS0pHdaiHbnS+IUz+O2MUXbjew1yQ=;
        b=S4Sbg1IQ1kRSgXB3uxZOkWdS91S9OaVBGqHnkv70QhQ3Cjey1INy5SxxYqdJjjueg9
         5ujw7CUtIDWo7qSFUWWcfz9oBF6KpiQhLZnB0kVs9DVXeaHTU2Hft+ezXYGecX/t0hzp
         rfAZ5z81/d6iApnDyzVlEHBO8Tlant2bVOeaFvJ0juby9qDKeRSWNg4fxosYKRALQwqr
         pSp+voJWD/flYkK+wDO29nBkBXow4rYxQ5wEErPu8vUxRMSDVvRYu1cenBjXCIPkenao
         JrJgB3L1qMQWMuV9lEQPqSc8f+9k/O/8uhISzzORX1wXo6wEGKql8jv5ShW4vDAel1XX
         BITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947606; x=1696552406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNbnaLjNtFiIrRRS0pHdaiHbnS+IUz+O2MUXbjew1yQ=;
        b=BCP9igBne5sZpTlIKsC53WuyuC/7LcBELhQpjqZKtUcm3jGwiCpnV/0RD6/ChN/l3K
         A/0QgQrCszgLjRlsCZ+qbz8gi2Zi6bJppVDMYbzqShe34vecnP2FHHC7yqnLCd+NAr1s
         oEUMWKvtkon91YyWZhi+AbiXyQRlQjgNseG/UmmnANYuZNK3ZXE0GG4/QpeXW9NAvZwt
         MGjwWipKli0oeebMCgh0R58AuuF0elbsI4sU/fAyrclkS775Gy2H85fz+XQagYGiBFhc
         IHhgk79qVutvm9PyZcilNLXk4Ed+iR6lHYr37M6oM3IQRE8IlFx8//sml/3dXapXQcuX
         26IQ==
X-Gm-Message-State: AOJu0YyO0xUGarNW49QOZLm18L7Y1CuMym5eROHOiVIpY+IH3zcLskGf
        XlJk3XeRHlE0qjMgXWenbV0xP0wNvXla4HefqDw=
X-Google-Smtp-Source: AGHT+IEYVK29lACB2o/eVMYuiqfP9Z4Dv8VjAhD3GPuuM6DLrJFWS23Sfg8kAJ7AlpLXZ9FZSdrYTJnt2Fv9Jyoxopg=
X-Received: by 2002:a05:6e02:1b8b:b0:351:5acb:281 with SMTP id
 h11-20020a056e021b8b00b003515acb0281mr3206172ili.31.1695947605832; Thu, 28
 Sep 2023 17:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAPTztWY4YnyFF3fVFZt-EbkUM3SSJ1rMgrgtjZGe5W-+v3tVGQ@mail.gmail.com>
In-Reply-To: <CAPTztWY4YnyFF3fVFZt-EbkUM3SSJ1rMgrgtjZGe5W-+v3tVGQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 28 Sep 2023 17:33:14 -0700
Message-ID: <CAKEwX=OQPcE_nRtM4imWx6uwk+n=OPEo1LAtp7T6DBu5cqk_HQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Frank van der Linden <fvdl@google.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
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

On Thu, Sep 28, 2023 at 3:59=E2=80=AFPM Frank van der Linden <fvdl@google.c=
om> wrote:
>
> On Wed, Sep 27, 2023 at 5:57=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
>>
>> Currently, hugetlb memory usage is not acounted for in the memory
>> controller, which could lead to memory overprotection for cgroups with
>> hugetlb-backed memory. This has been observed in our production system.
>>
>> This patch rectifies this issue by charging the memcg when the hugetlb
>> folio is allocated, and uncharging when the folio is freed (analogous to
>> the hugetlb controller).
>>
>> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst |  9 ++++++
>>  fs/hugetlbfs/inode.c                    |  2 +-
>>  include/linux/cgroup-defs.h             |  5 +++
>>  include/linux/hugetlb.h                 |  6 ++--
>>  include/linux/memcontrol.h              |  8 +++++
>>  kernel/cgroup/cgroup.c                  | 15 ++++++++-
>>  mm/hugetlb.c                            | 23 ++++++++++----
>>  mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
>>  8 files changed, 99 insertions(+), 10 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/adm=
in-guide/cgroup-v2.rst
>> index 622a7f28db1f..e6267b8cbd1d 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -210,6 +210,15 @@ cgroup v2 currently supports the following mount op=
tions.
>>          relying on the original semantics (e.g. specifying bogusly
>>          high 'bypass' protection values at higher tree levels).
>>
>> +  memory_hugetlb_accounting
>> +        Count hugetlb memory usage towards the cgroup's overall
>> +        memory usage for the memory controller. This is a new behavior
>> +        that could regress existing setups, so it must be explicitly
>> +        opted in with this mount option. Note that hugetlb pages
>> +        allocated while this option is not selected will not be
>> +        tracked by the memory controller (even if cgroup v2 is
>> +        remounted later on).
>> +
>>
>>  Organizing Processes and Threads
>>  --------------------------------
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 60fce26ff937..034967319955 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -902,7 +902,7 @@ static long hugetlbfs_fallocate(struct file *file, i=
nt mode, loff_t offset,
>>                  * to keep reservation accounting consistent.
>>                  */
>>                 hugetlb_set_vma_policy(&pseudo_vma, inode, index);
>> -               folio =3D alloc_hugetlb_folio(&pseudo_vma, addr, 0);
>> +               folio =3D alloc_hugetlb_folio(&pseudo_vma, addr, 0, true=
);
>>                 hugetlb_drop_vma_policy(&pseudo_vma);
>>                 if (IS_ERR(folio)) {
>>                         mutex_unlock(&hugetlb_fault_mutex_table[hash]);
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index f1b3151ac30b..8641f4320c98 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -115,6 +115,11 @@ enum {
>>          * Enable recursive subtree protection
>>          */
>>         CGRP_ROOT_MEMORY_RECURSIVE_PROT =3D (1 << 18),
>> +
>> +       /*
>> +        * Enable hugetlb accounting for the memory controller.
>> +        */
>> +        CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING =3D (1 << 19),
>>  };
>>
>>  /* cftype->flags */
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index a30686e649f7..9b73db1605a2 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -713,7 +713,8 @@ struct huge_bootmem_page {
>>
>>  int isolate_or_dissolve_huge_page(struct page *page, struct list_head *=
list);
>>  struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>> -                               unsigned long addr, int avoid_reserve);
>> +                               unsigned long addr, int avoid_reserve,
>> +                               bool restore_reserve_on_memcg_failure);
>>  struct folio *alloc_hugetlb_folio_nodemask(struct hstate *h, int prefer=
red_nid,
>>                                 nodemask_t *nmask, gfp_t gfp_mask);
>>  struct folio *alloc_hugetlb_folio_vma(struct hstate *h, struct vm_area_=
struct *vma,
>> @@ -1016,7 +1017,8 @@ static inline int isolate_or_dissolve_huge_page(st=
ruct page *page,
>>
>>  static inline struct folio *alloc_hugetlb_folio(struct vm_area_struct *=
vma,
>>                                            unsigned long addr,
>> -                                          int avoid_reserve)
>> +                                          int avoid_reserve,
>> +                                          bool restore_reserve_on_memcg=
_failure)
>>  {
>>         return NULL;
>>  }
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index e0cfab58ab71..8094679c99dd 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -677,6 +677,8 @@ static inline int mem_cgroup_charge(struct folio *fo=
lio, struct mm_struct *mm,
>>         return __mem_cgroup_charge(folio, mm, gfp);
>>  }
>>
>> +int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp);
>> +
>>  int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struc=
t *mm,
>>                                   gfp_t gfp, swp_entry_t entry);
>>  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
>> @@ -1251,6 +1253,12 @@ static inline int mem_cgroup_charge(struct folio =
*folio,
>>         return 0;
>>  }
>>
>> +static inline int mem_cgroup_hugetlb_charge_folio(struct folio *folio,
>> +               gfp_t gfp)
>> +{
>> +       return 0;
>> +}
>> +
>>  static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
>>                         struct mm_struct *mm, gfp_t gfp, swp_entry_t ent=
ry)
>>  {
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 1fb7f562289d..f11488b18ceb 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -1902,6 +1902,7 @@ enum cgroup2_param {
>>         Opt_favordynmods,
>>         Opt_memory_localevents,
>>         Opt_memory_recursiveprot,
>> +       Opt_memory_hugetlb_accounting,
>>         nr__cgroup2_params
>>  };
>>
>> @@ -1910,6 +1911,7 @@ static const struct fs_parameter_spec cgroup2_fs_p=
arameters[] =3D {
>>         fsparam_flag("favordynmods",            Opt_favordynmods),
>>         fsparam_flag("memory_localevents",      Opt_memory_localevents),
>>         fsparam_flag("memory_recursiveprot",    Opt_memory_recursiveprot=
),
>> +       fsparam_flag("memory_hugetlb_accounting", Opt_memory_hugetlb_acc=
ounting),
>>         {}
>>  };
>>
>> @@ -1936,6 +1938,9 @@ static int cgroup2_parse_param(struct fs_context *=
fc, struct fs_parameter *param
>>         case Opt_memory_recursiveprot:
>>                 ctx->flags |=3D CGRP_ROOT_MEMORY_RECURSIVE_PROT;
>>                 return 0;
>> +       case Opt_memory_hugetlb_accounting:
>> +               ctx->flags |=3D CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING;
>> +               return 0;
>>         }
>>         return -EINVAL;
>>  }
>> @@ -1960,6 +1965,11 @@ static void apply_cgroup_root_flags(unsigned int =
root_flags)
>>                         cgrp_dfl_root.flags |=3D CGRP_ROOT_MEMORY_RECURS=
IVE_PROT;
>>                 else
>>                         cgrp_dfl_root.flags &=3D ~CGRP_ROOT_MEMORY_RECUR=
SIVE_PROT;
>> +
>> +               if (root_flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
>> +                       cgrp_dfl_root.flags |=3D CGRP_ROOT_MEMORY_HUGETL=
B_ACCOUNTING;
>> +               else
>> +                       cgrp_dfl_root.flags &=3D ~CGRP_ROOT_MEMORY_HUGET=
LB_ACCOUNTING;
>>         }
>>  }
>>
>> @@ -1973,6 +1983,8 @@ static int cgroup_show_options(struct seq_file *se=
q, struct kernfs_root *kf_root
>>                 seq_puts(seq, ",memory_localevents");
>>         if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_RECURSIVE_PROT)
>>                 seq_puts(seq, ",memory_recursiveprot");
>> +       if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING)
>> +               seq_puts(seq, ",memory_hugetlb_accounting");
>>         return 0;
>>  }
>>
>> @@ -7050,7 +7062,8 @@ static ssize_t features_show(struct kobject *kobj,=
 struct kobj_attribute *attr,
>>                         "nsdelegate\n"
>>                         "favordynmods\n"
>>                         "memory_localevents\n"
>> -                       "memory_recursiveprot\n");
>> +                       "memory_recursiveprot\n"
>> +                       "memory_hugetlb_accounting\n");
>>  }
>>  static struct kobj_attribute cgroup_features_attr =3D __ATTR_RO(feature=
s);
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index de220e3ff8be..ff88ea4df11a 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
>>                                      pages_per_huge_page(h), folio);
>>         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
>>                                           pages_per_huge_page(h), folio)=
;
>> +       mem_cgroup_uncharge(folio);
>>         if (restore_reserve)
>>                 h->resv_huge_pages++;
>>
>> @@ -3004,7 +3005,8 @@ int isolate_or_dissolve_huge_page(struct page *pag=
e, struct list_head *list)
>>  }
>>
>>  struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>> -                                   unsigned long addr, int avoid_reserv=
e)
>> +                                       unsigned long addr, int avoid_re=
serve,
>> +                                       bool restore_reserve_on_memcg_fa=
ilure)
>>  {
>>         struct hugepage_subpool *spool =3D subpool_vma(vma);
>>         struct hstate *h =3D hstate_vma(vma);
>> @@ -3119,6 +3121,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area_=
struct *vma,
>>                         hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(=
h),
>>                                         pages_per_huge_page(h), folio);
>>         }
>> +
>> +       /* undo allocation if memory controller disallows it. */
>> +       if (mem_cgroup_hugetlb_charge_folio(folio, GFP_KERNEL)) {
>> +               if (restore_reserve_on_memcg_failure)
>> +                       restore_reserve_on_error(h, vma, addr, folio);
>> +               folio_put(folio);
>> +               return ERR_PTR(-ENOMEM);
>> +       }
>> +
>>         return folio;
>>
>>  out_uncharge_cgroup:
>> @@ -5179,7 +5190,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst,=
 struct mm_struct *src,
>>                                 spin_unlock(src_ptl);
>>                                 spin_unlock(dst_ptl);
>>                                 /* Do not use reserve as it's private ow=
ned */
>> -                               new_folio =3D alloc_hugetlb_folio(dst_vm=
a, addr, 1);
>> +                               new_folio =3D alloc_hugetlb_folio(dst_vm=
a, addr, 1, false);
>>                                 if (IS_ERR(new_folio)) {
>>                                         folio_put(pte_folio);
>>                                         ret =3D PTR_ERR(new_folio);
>> @@ -5656,7 +5667,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm,=
 struct vm_area_struct *vma,
>>          * be acquired again before returning to the caller, as expected=
.
>>          */
>>         spin_unlock(ptl);
>> -       new_folio =3D alloc_hugetlb_folio(vma, haddr, outside_reserve);
>> +       new_folio =3D alloc_hugetlb_folio(vma, haddr, outside_reserve, t=
rue);
>>
>>         if (IS_ERR(new_folio)) {
>>                 /*
>> @@ -5930,7 +5941,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct=
 *mm,
>>                                                         VM_UFFD_MISSING)=
;
>>                 }
>>
>> -               folio =3D alloc_hugetlb_folio(vma, haddr, 0);
>> +               folio =3D alloc_hugetlb_folio(vma, haddr, 0, true);
>>                 if (IS_ERR(folio)) {
>>                         /*
>>                          * Returning error will result in faulting task =
being
>> @@ -6352,7 +6363,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>>                         goto out;
>>                 }
>>
>> -               folio =3D alloc_hugetlb_folio(dst_vma, dst_addr, 0);
>> +               folio =3D alloc_hugetlb_folio(dst_vma, dst_addr, 0, true=
);
>>                 if (IS_ERR(folio)) {
>>                         ret =3D -ENOMEM;
>>                         goto out;
>> @@ -6394,7 +6405,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>>                         goto out;
>>                 }
>>
>> -               folio =3D alloc_hugetlb_folio(dst_vma, dst_addr, 0);
>> +               folio =3D alloc_hugetlb_folio(dst_vma, dst_addr, 0, fals=
e);
>>                 if (IS_ERR(folio)) {
>>                         folio_put(*foliop);
>>                         ret =3D -ENOMEM;
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index d1a322a75172..d5dfc9b36acb 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7050,6 +7050,47 @@ int __mem_cgroup_charge(struct folio *folio, stru=
ct mm_struct *mm, gfp_t gfp)
>>         return ret;
>>  }
>>
>> +static struct mem_cgroup *get_mem_cgroup_from_current(void)
>> +{
>> +       struct mem_cgroup *memcg;
>> +
>> +again:
>> +       rcu_read_lock();
>> +       memcg =3D mem_cgroup_from_task(current);
>> +       if (!css_tryget(&memcg->css)) {
>> +               rcu_read_unlock();
>> +               goto again;
>> +       }
>> +       rcu_read_unlock();
>> +       return memcg;
>> +}
>> +
>> +/**
>> + * mem_cgroup_hugetlb_charge_folio - Charge a newly allocated hugetlb f=
olio.
>> + * @folio: folio to charge.
>> + * @gfp: reclaim mode
>> + *
>> + * This function charges an allocated hugetlbf folio to the memcg of th=
e
>> + * current task.
>> + *
>> + * Returns 0 on success. Otherwise, an error code is returned.
>> + */
>> +int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp)
>> +{
>> +       struct mem_cgroup *memcg;
>> +       int ret;
>> +
>> +       if (mem_cgroup_disabled() ||
>> +               !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNT=
ING))
>> +               return 0;
>> +
>> +       memcg =3D get_mem_cgroup_from_current();
>> +       ret =3D charge_memcg(folio, memcg, gfp);
>> +       mem_cgroup_put(memcg);
>> +
>> +       return ret;
>> +}
>> +
>>  /**
>>   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for =
swapin.
>>   * @folio: folio to charge.
>> --
>> 2.34.1
>>
>
> With the mount option added, I'm fine with this. There are reasons to wan=
t and reasons not to want this, so everybody's happy!

And the default is no accounting, so this should be safe on impact!

>
> Out of curiosity: is anyone aware of any code that may behave badly when =
folio_memcg(hugetlb_folio) !=3D NULL, not expecting it?

Good point. My understanding of the memory controller mechanism
is that it should be fine - we're just essentially storing some memcg
metadata in the struct folio, and then charging values towards the
memcg counters. I don't think we fiddle with anything else in
the folio itself that could be ruinous?

I also did my best to trace the code paths that go through
alloc_hugetlb_folio and free_huge_folio (the places where charging
and uncharging happens) to make sure no funny business is going
on, and it seems a lot of these paths have special, dedicated handling
for hugetlb folio. The usual pattern is checking if the folio is a hugetlb
one first, so we're unlikely to even call folio_memcg on a hugetlb
folio in existing code in the first place.

But if anyone knows something I missed please let me know!
And feel free to loop more people in if there's anyone I miss in
the cc list :)

>
> - Frank
