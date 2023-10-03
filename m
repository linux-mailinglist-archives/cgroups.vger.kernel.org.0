Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F2D7B74F7
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 01:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjJCXbk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 19:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjJCXbj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 19:31:39 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE7DAF;
        Tue,  3 Oct 2023 16:31:36 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79fa387fb96so59489939f.1;
        Tue, 03 Oct 2023 16:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696375895; x=1696980695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWh9xWbE/lRob82wHM79Ybcqr8dXbfEsVfLAHVc30CE=;
        b=BecUrob6F9wwEBnuigxVOe4PHhUCgsy9kou7mSiOC2jocx6wbNgZZAaK9S4ZhEGUpY
         Q/rvuBJ34pid+UMqPg2KwbRHxOo35N5YdVgv1YxWJc/6ODfWfb7Jyc/txhY39Wg0OkW9
         xgHkYL8r0zr9xqNaGXD2L1yVGWek8YX9a72ow768Ks+RV43rzcrAXsWgsFkJ1T3MfjER
         PeuVF5Do0W1wp70RaM0zYpGjrdVxJ0+qDqyF27twAZlvJsgvqF9PRWLTnx2XSjVhGmSC
         fRfcTgzJ+jJ1YQNVukOsyGQBD+SclSWTDjWkrA4ovgpaqctW1uc0H/Qde3XfMCtbJqAD
         v0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375895; x=1696980695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWh9xWbE/lRob82wHM79Ybcqr8dXbfEsVfLAHVc30CE=;
        b=MmVFP3SMxkJ/3mTrPV9f+3FlYUeDsB+Xx5rXa5a7F7phgfuwH+3PP6KN4q4grS9Vzr
         T27U/hoNBE7EwrFRcSqAmSgunYSr6vMGXebW2mdWSibTZ/V+b9ERl9Kshav7hZqjM07o
         0gtwK4ULN/1KWYcvkVtbu6Yp+nG8fxNXMDlT12w8Fg1eoh2Jd5UxkEJyxbcW+SxOdMpD
         NGlAO4TwnfXZqlxNMBX22oCzwPVshbT6KZgdAYiz0w+wZPUQPnKOQYRNRRS847p2qLdJ
         G/woSq0dSX56Kn2G48QkorgxjI7w0zeBmZFoIIFscf2X3pgDG/S+SGuAhAgRvvH4zA/Y
         MmwQ==
X-Gm-Message-State: AOJu0YxEysbGaXcayXs2pbH+arp9HQPq+vUiVGMyaWOxP6jG4hPSTvgc
        ISqmGXA/LIlt5mOVMAAYrTDLiFjav7gMv5axSxM=
X-Google-Smtp-Source: AGHT+IFBGdqs6v9jN2wQL6XcaflsZAowTlFvr3Qp5MrlYRDmQyM6SsxPPAhp7QS19ckhL11v3GmrPm9wccCKgn1EvN8=
X-Received: by 2002:a5d:9910:0:b0:780:c787:637b with SMTP id
 x16-20020a5d9910000000b00780c787637bmr934771iol.0.1696375895646; Tue, 03 Oct
 2023 16:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231003171329.GB314430@monkey> <20231003231422.4046187-1-nphamcs@gmail.com>
 <CAJD7tkZRH5-y-ux2hDt70JpmL5=YwRwrg_otiTbAei09x-GAJQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZRH5-y-ux2hDt70JpmL5=YwRwrg_otiTbAei09x-GAJQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 3 Oct 2023 16:31:22 -0700
Message-ID: <CAKEwX=M24ePo5CtLM6c9_APu9zaEgavDwWEDNTGKDRshkKp1PQ@mail.gmail.com>
Subject: Re: [PATCH] memcontrol: only transfer the memcg data for migration
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, fvdl@google.com,
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

On Tue, Oct 3, 2023 at 4:22=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Tue, Oct 3, 2023 at 4:14=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > For most migration use cases, only transfer the memcg data from the old
> > folio to the new folio, and clear the old folio's memcg data. No
> > charging and uncharging will be done. These use cases include the new
> > hugetlb memcg accounting behavior (which was not previously handled).
> >
> > This shaves off some work on the migration path, and avoids the
> > temporary double charging of a folio during its migration.
> >
> > The only exception is replace_page_cache_folio(), which will use the ol=
d
> > mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In that
> > context, the isolation of the old page isn't quite as thorough as with
> > migration, so we cannot use our new implementation directly.
> >
> > This patch is the result of the following discussion on the new hugetlb
> > memcg accounting behavior:
> >
> > https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> >
> > Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> > Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> Does this patch fit before or after your series? In both cases I think
> there might be a problem for bisectability.

Hmm my intention for this patch is as a fixlet.
(i.e it should be eventually squashed to the second patch of that series).
I just include the extra context on the fixlet for review purposes.

My apologies - should have been much clearer.
(Perhaps I should just send out v4 at this point?)

>
> > ---
> >  include/linux/memcontrol.h |  7 ++++++
> >  mm/filemap.c               |  2 +-
> >  mm/memcontrol.c            | 45 +++++++++++++++++++++++++++++++++++---
> >  mm/migrate.c               |  3 +--
> >  4 files changed, 51 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index a827e2129790..e3eaa123256b 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -711,6 +711,8 @@ static inline void mem_cgroup_uncharge_list(struct =
list_head *page_list)
> >
> >  void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int n=
r_pages);
> >
> > +void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
> > +
> >  void mem_cgroup_migrate(struct folio *old, struct folio *new);
> >
> >  /**
> > @@ -1294,6 +1296,11 @@ static inline void mem_cgroup_cancel_charge(stru=
ct mem_cgroup *memcg,
> >  {
> >  }
> >
> > +static inline void mem_cgroup_replace_folio(struct folio *old,
> > +               struct folio *new)
> > +{
> > +}
> > +
> >  static inline void mem_cgroup_migrate(struct folio *old, struct folio =
*new)
> >  {
> >  }
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 9481ffaf24e6..673745219c82 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -819,7 +819,7 @@ void replace_page_cache_folio(struct folio *old, st=
ruct folio *new)
> >         new->mapping =3D mapping;
> >         new->index =3D offset;
> >
> > -       mem_cgroup_migrate(old, new);
> > +       mem_cgroup_replace_folio(old, new);
> >
> >         xas_lock_irq(&xas);
> >         xas_store(&xas, new);
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 6660684f6f97..cbaa26605b3d 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7316,16 +7316,17 @@ void __mem_cgroup_uncharge_list(struct list_hea=
d *page_list)
> >  }
> >
> >  /**
> > - * mem_cgroup_migrate - Charge a folio's replacement.
> > + * mem_cgroup_replace_folio - Charge a folio's replacement.
> >   * @old: Currently circulating folio.
> >   * @new: Replacement folio.
> >   *
> >   * Charge @new as a replacement folio for @old. @old will
> > - * be uncharged upon free.
> > + * be uncharged upon free. This is only used by the page cache
> > + * (in replace_page_cache_folio()).
> >   *
> >   * Both folios must be locked, @new->mapping must be set up.
> >   */
> > -void mem_cgroup_migrate(struct folio *old, struct folio *new)
> > +void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
> >  {
> >         struct mem_cgroup *memcg;
> >         long nr_pages =3D folio_nr_pages(new);
> > @@ -7364,6 +7365,44 @@ void mem_cgroup_migrate(struct folio *old, struc=
t folio *new)
> >         local_irq_restore(flags);
> >  }
> >
> > +/**
> > + * mem_cgroup_migrate - Transfer the memcg data from the old to the ne=
w folio.
> > + * @old: Currently circulating folio.
> > + * @new: Replacement folio.
> > + *
> > + * Transfer the memcg data from the old folio to the new folio for mig=
ration.
> > + * The old folio's data info will be cleared. Note that the memory cou=
nters
> > + * will remain unchanged throughout the process.
> > + *
> > + * Both folios must be locked, @new->mapping must be set up.
> > + */
> > +void mem_cgroup_migrate(struct folio *old, struct folio *new)
> > +{
> > +       struct mem_cgroup *memcg;
> > +
> > +       VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
> > +       VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
> > +       VM_BUG_ON_FOLIO(folio_test_anon(old) !=3D folio_test_anon(new),=
 new);
> > +       VM_BUG_ON_FOLIO(folio_nr_pages(old) !=3D folio_nr_pages(new), n=
ew);
> > +
> > +       if (mem_cgroup_disabled())
> > +               return;
> > +
> > +       memcg =3D folio_memcg(old);
> > +       /*
> > +        * Note that it is normal to see !memcg for a hugetlb folio.
> > +        * It could have been allocated when memory_hugetlb_accounting =
was not
> > +        * selected, for e.g.
> > +        */
> > +       VM_WARN_ON_ONCE_FOLIO(!memcg, old);
> > +       if (!memcg)
> > +               return;
> > +
> > +       /* Transfer the charge and the css ref */
> > +       commit_charge(new, memcg);
> > +       old->memcg_data =3D 0;
> > +}
> > +
> >  DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
> >  EXPORT_SYMBOL(memcg_sockets_enabled_key);
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 7d1804c4a5d9..6034c7ed1d65 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -633,8 +633,7 @@ void folio_migrate_flags(struct folio *newfolio, st=
ruct folio *folio)
> >
> >         folio_copy_owner(newfolio, folio);
> >
> > -       if (!folio_test_hugetlb(folio))
> > -               mem_cgroup_migrate(folio, newfolio);
> > +       mem_cgroup_migrate(folio, newfolio);
> >  }
> >  EXPORT_SYMBOL(folio_migrate_flags);
> >
> > --
> > 2.34.1
> >
