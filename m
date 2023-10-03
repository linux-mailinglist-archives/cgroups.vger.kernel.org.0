Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335BB7B73F0
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 00:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjJCWJx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 18:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjJCWJx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 18:09:53 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384D2A7;
        Tue,  3 Oct 2023 15:09:48 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7a2a9e5451bso56160039f.1;
        Tue, 03 Oct 2023 15:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696370987; x=1696975787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsg9xzxqKGmu4TINwdzeQuCMMXAOdP/P1mEVIlXmoM0=;
        b=Oapo4L4jBMjEgub2mHqNs44R+aQ4qZzlBXim5K9x4rM6ReTH8Rl0B1olisrIxducRu
         eT1kKTRolL2HnTpd/jPc/S3dX3ExliS4LeEcalSHFdNpEO46IMTz7Ig5BIrb46ihStDQ
         7cNzwlsMr+7GHumXdFxgkIF5JiQd2FgeJaQgXiqffHf7veAakpefs10XsnPOHtyYbysQ
         n5KI7e45fXfme+98joKwlc528uwsNzLxyxgrckViws+xdkKOC6AxzuOF/UxtCFlMdmWq
         qC/0uX6CPtTMq04+2rLvMNzk3Zi0glSFyAfU/Cpj9Ye64BBicPBlFRmGbo/rMDm5uAnR
         NN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696370987; x=1696975787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsg9xzxqKGmu4TINwdzeQuCMMXAOdP/P1mEVIlXmoM0=;
        b=cnRVQS7tUw6rmJ/l5gv9UeSIoikYGd/rANutSBo7g4bfAQ99xwdHewBcxx9KE+jvbg
         ZByL5tZ1PXWlFMWEZRZtkmvbalwJqnhAvcSKQnb3JySXlHtfuP3FZsbrnV4q2bcszZWp
         6pUy5q+4FRVSsiupFFSIV0rdHLk3Ert7nkrEGkpUDOm2MnT21k9JOvGDg1Sk9getP9Cu
         xAfSuICcGcXTG/BxSsH1W+VlybFqTfADfmIfLkCKNsOdncN7aB4nGRiSwmh+u+P5dYFp
         xuyRgYSf9hg5Ta2gmms5g0BoRL9NGvJ+jY3xBTW2+MheL6eF4oqWofsi2T1L2BiXDaNp
         5g8w==
X-Gm-Message-State: AOJu0Yyr0K90eRfU2gxkmuHOjQGQPzg0DCrTdPsPkWbqPd5fzOVrwW3d
        PI365ASsi0DdQTEv948O2zI1cQgpQhB7sRcGhPY=
X-Google-Smtp-Source: AGHT+IEMO/yaZpQdQysYHNZTgoqLNX+ymIVVK4ORvqXdjSE5fddQDoxD5uVLChNCygNMBLcz43Xd8yv4Lv9XNi9Q0x4=
X-Received: by 2002:a5d:9954:0:b0:786:f4a0:d37e with SMTP id
 v20-20020a5d9954000000b00786f4a0d37emr765084ios.4.1696370987432; Tue, 03 Oct
 2023 15:09:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231003001828.2554080-1-nphamcs@gmail.com> <20231003001828.2554080-3-nphamcs@gmail.com>
 <20231003171329.GB314430@monkey> <CAKEwX=POd1DZc2K5ym14R2DpU74DqV30_A6QGfsCAaOTMK2WJA@mail.gmail.com>
 <20231003183928.GC20979@cmpxchg.org>
In-Reply-To: <20231003183928.GC20979@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 3 Oct 2023 15:09:36 -0700
Message-ID: <CAKEwX=O8X+ZRNEzzs+NYBAh9QJLObxKPOpmFo-ci4Aw=MR=0+Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org,
        riel@surriel.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev, tj@kernel.org,
        lizefan.x@bytedance.com, shuah@kernel.org, yosryahmed@google.com,
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

On Tue, Oct 3, 2023 at 11:39=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Oct 03, 2023 at 11:01:24AM -0700, Nhat Pham wrote:
> > On Tue, Oct 3, 2023 at 10:13=E2=80=AFAM Mike Kravetz <mike.kravetz@orac=
le.com> wrote:
> > >
> > > On 10/02/23 17:18, Nhat Pham wrote:
> > > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > > index de220e3ff8be..74472e911b0a 100644
> > > > --- a/mm/hugetlb.c
> > > > +++ b/mm/hugetlb.c
> > > > @@ -1902,6 +1902,7 @@ void free_huge_folio(struct folio *folio)
> > > >                                    pages_per_huge_page(h), folio);
> > > >       hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h),
> > > >                                         pages_per_huge_page(h), fol=
io);
> > > > +     mem_cgroup_uncharge(folio);
> > > >       if (restore_reserve)
> > > >               h->resv_huge_pages++;
> > > >
> > > > @@ -3009,11 +3010,20 @@ struct folio *alloc_hugetlb_folio(struct vm=
_area_struct *vma,
> > > >       struct hugepage_subpool *spool =3D subpool_vma(vma);
> > > >       struct hstate *h =3D hstate_vma(vma);
> > > >       struct folio *folio;
> > > > -     long map_chg, map_commit;
> > > > +     long map_chg, map_commit, nr_pages =3D pages_per_huge_page(h)=
;
> > > >       long gbl_chg;
> > > > -     int ret, idx;
> > > > +     int memcg_charge_ret, ret, idx;
> > > >       struct hugetlb_cgroup *h_cg =3D NULL;
> > > > +     struct mem_cgroup *memcg;
> > > >       bool deferred_reserve;
> > > > +     gfp_t gfp =3D htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL;
> > > > +
> > > > +     memcg =3D get_mem_cgroup_from_current();
> > > > +     memcg_charge_ret =3D mem_cgroup_hugetlb_try_charge(memcg, gfp=
, nr_pages);
> > > > +     if (memcg_charge_ret =3D=3D -ENOMEM) {
> > > > +             mem_cgroup_put(memcg);
> > > > +             return ERR_PTR(-ENOMEM);
> > > > +     }
> > > >
> > > >       idx =3D hstate_index(h);
> > > >       /*
> > > > @@ -3022,8 +3032,12 @@ struct folio *alloc_hugetlb_folio(struct vm_=
area_struct *vma,
> > > >        * code of zero indicates a reservation exists (no change).
> > > >        */
> > > >       map_chg =3D gbl_chg =3D vma_needs_reservation(h, vma, addr);
> > > > -     if (map_chg < 0)
> > > > +     if (map_chg < 0) {
> > > > +             if (!memcg_charge_ret)
> > > > +                     mem_cgroup_cancel_charge(memcg, nr_pages);
> > > > +             mem_cgroup_put(memcg);
> > > >               return ERR_PTR(-ENOMEM);
> > > > +     }
> > > >
> > > >       /*
> > > >        * Processes that did not create the mapping will have no
> > > > @@ -3034,10 +3048,8 @@ struct folio *alloc_hugetlb_folio(struct vm_=
area_struct *vma,
> > > >        */
> > > >       if (map_chg || avoid_reserve) {
> > > >               gbl_chg =3D hugepage_subpool_get_pages(spool, 1);
> > > > -             if (gbl_chg < 0) {
> > > > -                     vma_end_reservation(h, vma, addr);
> > > > -                     return ERR_PTR(-ENOSPC);
> > > > -             }
> > > > +             if (gbl_chg < 0)
> > > > +                     goto out_end_reservation;
> > > >
> > > >               /*
> > > >                * Even though there was no reservation in the region=
/reserve
> > > > @@ -3119,6 +3131,11 @@ struct folio *alloc_hugetlb_folio(struct vm_=
area_struct *vma,
> > > >                       hugetlb_cgroup_uncharge_folio_rsvd(hstate_ind=
ex(h),
> > > >                                       pages_per_huge_page(h), folio=
);
> > > >       }
> > > > +
> > > > +     if (!memcg_charge_ret)
> > > > +             mem_cgroup_commit_charge(folio, memcg);
> > > > +     mem_cgroup_put(memcg);
> > > > +
> > > >       return folio;
> > > >
> > > >  out_uncharge_cgroup:
> > > > @@ -3130,7 +3147,11 @@ struct folio *alloc_hugetlb_folio(struct vm_=
area_struct *vma,
> > > >  out_subpool_put:
> > > >       if (map_chg || avoid_reserve)
> > > >               hugepage_subpool_put_pages(spool, 1);
> > > > +out_end_reservation:
> > > >       vma_end_reservation(h, vma, addr);
> > > > +     if (!memcg_charge_ret)
> > > > +             mem_cgroup_cancel_charge(memcg, nr_pages);
> > > > +     mem_cgroup_put(memcg);
> > > >       return ERR_PTR(-ENOSPC);
> > > >  }
> > > >
> > >
> > > IIUC, huge page usage is charged in alloc_hugetlb_folio and uncharged=
 in
> > > free_huge_folio.  During migration, huge pages are allocated via
> > > alloc_migrate_hugetlb_folio, not alloc_hugetlb_folio.  So, there is n=
o
> > > charging for the migration target page and we uncharge the source pag=
e.
> > > It looks like there will be no charge for the huge page after migrati=
on?
> > >
> >
> > Ah I see! This is a bit subtle indeed.
> >
> > For the hugetlb controller, it looks like they update the cgroup info
> > inside move_hugetlb_state(), which calls hugetlb_cgroup_migrate()
> > to transfer the hugetlb cgroup info to the destination folio.
> >
> > Perhaps we can do something analogous here.
> >
> > > If my analysis above is correct, then we may need to be careful about
> > > this accounting.  We may not want both source and target pages to be
> > > charged at the same time.
> >
> > We can create a variant of mem_cgroup_migrate that does not double
> > charge, but instead just copy the mem_cgroup information to the new
> > folio, and then clear that info from the old folio. That way the memory
> > usage counters are untouched.
> >
> > Somebody with more expertise on migration should fact check me
> > of course :)
>
> The only reason mem_cgroup_migrate() double charges right now is
> because it's used by replace_page_cache_folio(). In that context, the
> isolation of the old page isn't quite as thorough as with migration,
> so it cannot transfer and uncharge directly. This goes back a long
> time: 0a31bc97c80c3fa87b32c091d9a930ac19cd0c40
>
> If you rename the current implementation to mem_cgroup_replace_page()
> for that one caller, you can add a mem_cgroup_migrate() variant which
> is charge neutral and clears old->memcg_data. This can be used for
> regular and hugetlb page migration. Something like this (totally
> untested):
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a4d3282493b6..17ec45bf3653 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7226,29 +7226,14 @@ void mem_cgroup_migrate(struct folio *old, struct=
 folio *new)
>         if (mem_cgroup_disabled())
>                 return;
>
> -       /* Page cache replacement: new folio already charged? */
> -       if (folio_memcg(new))
> -               return;
> -
>         memcg =3D folio_memcg(old);
>         VM_WARN_ON_ONCE_FOLIO(!memcg, old);
>         if (!memcg)
>                 return;
>
> -       /* Force-charge the new page. The old one will be freed soon */
> -       if (!mem_cgroup_is_root(memcg)) {
> -               page_counter_charge(&memcg->memory, nr_pages);
> -               if (do_memsw_account())
> -                       page_counter_charge(&memcg->memsw, nr_pages);
> -       }
> -
> -       css_get(&memcg->css);
> +       /* Transfer the charge and the css ref */
>         commit_charge(new, memcg);
> -
> -       local_irq_save(flags);
> -       mem_cgroup_charge_statistics(memcg, nr_pages);
> -       memcg_check_events(memcg, folio_nid(new));
> -       local_irq_restore(flags);
> +       old->memcg_data =3D 0;
>  }
>
>  DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
>

Ah, I like this. Will send a fixlet based on this :)
I was scratching my head trying to figure out why we were
doing the double charging in the first place. Thanks for the context,
Johannes!
