Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D0A7B7073
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 20:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240712AbjJCSBn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240690AbjJCSBm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 14:01:42 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404A2AF;
        Tue,  3 Oct 2023 11:01:37 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79fe87cd74eso47088139f.3;
        Tue, 03 Oct 2023 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696356096; x=1696960896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRPRGCl334YYyAG6h9aCAG5kzsOBR2VDhX+FzPQHrPo=;
        b=QL6rtueaki3btpw5UwGNeCW0LlARsGniqAc8LRhM+GZYzXfvnB7yjDiW3XWxGkzC0R
         8GaYkNusLJx/2LzEB4sjK/pVdkFFuGhv4W8wm8WFLIvw8QiDQb4F6eS+HXgmlZFz8hP9
         Pkw/aghQlLAqZxUoF6yjrwSrfpKP+k8Rs+vTzwNDVX1BrDLulrk7aJTwVa+Uq8h1733B
         MIx0+qRnM5/Dua6F8ZZCtavSiGxpjCh7xq9z0iNyI+Haj0A0lnniDbrUwms4FKBNKU3K
         gQAxoQPRK6xGEGqahF+USU4kdSd+VPG13NUcBUdbJNnC6q4+VylIJIZOg69RkyjYFEuY
         wMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696356096; x=1696960896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRPRGCl334YYyAG6h9aCAG5kzsOBR2VDhX+FzPQHrPo=;
        b=f63G9HqnZoX2dHYvqxOL8V3RlIW5VsLyWC9uPRiCY7fbXx98EHIUL/eQjgXD4eDUeT
         A/yb3iZ4psnIKBqqs0K2YUa3TOnzQPykyVAZawwPQWWQO3K0RTV9YRwZno20US4GKALq
         VbQEq7vwhP+8Yg2Pwk70d3C9OH6gfqSH4mWVSddVkgBIDOkhlU3jQaQoDCCR/FET5pw2
         n937feWqCqw8UVXW5JEDSI23NWo8jBPmAgQmorT5Jbj8d843gZHPK0+KmLj9Zg35hDWp
         aQEo6pseal9zXVUYHCdv7wpaYx2762EYWbxqkSkifIWtOHwnTTdUw8kT6Skaiolfb/fj
         kLPQ==
X-Gm-Message-State: AOJu0YyNMnlb1uwOTBb7ofX7DXG8gKMglzkyavOgq0uxn5JEaTXccHJj
        MihuWn7kLzCTnfYn3KF0ZxAbx5eq5IXRbUXYMBY=
X-Google-Smtp-Source: AGHT+IEAc/VlTDM6G3+ejDdc28tcoNLhVuby1nYW07+fmrY/lmDdPL9J3sq+5bbFNqRJoa2Msb/n8nMOy1XwQd/F5Zk=
X-Received: by 2002:a5e:8809:0:b0:79a:b53c:d758 with SMTP id
 l9-20020a5e8809000000b0079ab53cd758mr230501ioj.1.1696356096375; Tue, 03 Oct
 2023 11:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231003001828.2554080-1-nphamcs@gmail.com> <20231003001828.2554080-3-nphamcs@gmail.com>
 <20231003171329.GB314430@monkey>
In-Reply-To: <20231003171329.GB314430@monkey>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 3 Oct 2023 11:01:24 -0700
Message-ID: <CAKEwX=POd1DZc2K5ym14R2DpU74DqV30_A6QGfsCAaOTMK2WJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, yosryahmed@google.com, fvdl@google.com,
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

On Tue, Oct 3, 2023 at 10:13=E2=80=AFAM Mike Kravetz <mike.kravetz@oracle.c=
om> wrote:
>
> On 10/02/23 17:18, Nhat Pham wrote:
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index de220e3ff8be..74472e911b0a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
> >                                    pages_per_huge_page(h), folio);
> >       hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> >                                         pages_per_huge_page(h), folio);
> > +     mem_cgroup_uncharge(folio);
> >       if (restore_reserve)
> >               h->resv_huge_pages++;
> >
> > @@ -3009,11 +3010,20 @@ struct folio *alloc_hugetlb_folio(struct vm_are=
a_struct *vma,
> >       struct hugepage_subpool *spool =3D subpool_vma(vma);
> >       struct hstate *h =3D hstate_vma(vma);
> >       struct folio *folio;
> > -     long map_chg, map_commit;
> > +     long map_chg, map_commit, nr_pages =3D pages_per_huge_page(h);
> >       long gbl_chg;
> > -     int ret, idx;
> > +     int memcg_charge_ret, ret, idx;
> >       struct hugetlb_cgroup *h_cg =3D NULL;
> > +     struct mem_cgroup *memcg;
> >       bool deferred_reserve;
> > +     gfp_t gfp =3D htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> > +
> > +     memcg =3D get_mem_cgroup_from_current();
> > +     memcg_charge_ret =3D mem_cgroup_hugetlb_try_charge(memcg, gfp, nr=
_pages);
> > +     if (memcg_charge_ret =3D=3D -ENOMEM) {
> > +             mem_cgroup_put(memcg);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> >
> >       idx =3D hstate_index(h);
> >       /*
> > @@ -3022,8 +3032,12 @@ struct folio *alloc_hugetlb_folio(struct vm_area=
_struct *vma,
> >        * code of zero indicates a reservation exists (no change).
> >        */
> >       map_chg =3D gbl_chg =3D vma_needs_reservation(h, vma, addr);
> > -     if (map_chg < 0)
> > +     if (map_chg < 0) {
> > +             if (!memcg_charge_ret)
> > +                     mem_cgroup_cancel_charge(memcg, nr_pages);
> > +             mem_cgroup_put(memcg);
> >               return ERR_PTR(-ENOMEM);
> > +     }
> >
> >       /*
> >        * Processes that did not create the mapping will have no
> > @@ -3034,10 +3048,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area=
_struct *vma,
> >        */
> >       if (map_chg || avoid_reserve) {
> >               gbl_chg =3D hugepage_subpool_get_pages(spool, 1);
> > -             if (gbl_chg < 0) {
> > -                     vma_end_reservation(h, vma, addr);
> > -                     return ERR_PTR(-ENOSPC);
> > -             }
> > +             if (gbl_chg < 0)
> > +                     goto out_end_reservation;
> >
> >               /*
> >                * Even though there was no reservation in the region/res=
erve
> > @@ -3119,6 +3131,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area=
_struct *vma,
> >                       hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h=
),
> >                                       pages_per_huge_page(h), folio);
> >       }
> > +
> > +     if (!memcg_charge_ret)
> > +             mem_cgroup_commit_charge(folio, memcg);
> > +     mem_cgroup_put(memcg);
> > +
> >       return folio;
> >
> >  out_uncharge_cgroup:
> > @@ -3130,7 +3147,11 @@ struct folio *alloc_hugetlb_folio(struct vm_area=
_struct *vma,
> >  out_subpool_put:
> >       if (map_chg || avoid_reserve)
> >               hugepage_subpool_put_pages(spool, 1);
> > +out_end_reservation:
> >       vma_end_reservation(h, vma, addr);
> > +     if (!memcg_charge_ret)
> > +             mem_cgroup_cancel_charge(memcg, nr_pages);
> > +     mem_cgroup_put(memcg);
> >       return ERR_PTR(-ENOSPC);
> >  }
> >
>
> IIUC, huge page usage is charged in alloc_hugetlb_folio and uncharged in
> free_huge_folio.  During migration, huge pages are allocated via
> alloc_migrate_hugetlb_folio, not alloc_hugetlb_folio.  So, there is no
> charging for the migration target page and we uncharge the source page.
> It looks like there will be no charge for the huge page after migration?
>

Ah I see! This is a bit subtle indeed.

For the hugetlb controller, it looks like they update the cgroup info
inside move_hugetlb_state(), which calls hugetlb_cgroup_migrate()
to transfer the hugetlb cgroup info to the destination folio.

Perhaps we can do something analogous here.

> If my analysis above is correct, then we may need to be careful about
> this accounting.  We may not want both source and target pages to be
> charged at the same time.

We can create a variant of mem_cgroup_migrate that does not double
charge, but instead just copy the mem_cgroup information to the new
folio, and then clear that info from the old folio. That way the memory
usage counters are untouched.

Somebody with more expertise on migration should fact check me
of course :)

> --
> Mike Kravetz
