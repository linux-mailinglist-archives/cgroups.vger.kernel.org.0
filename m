Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84C7B74C6
	for <lists+cgroups@lfdr.de>; Wed,  4 Oct 2023 01:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjJCXWz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 19:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjJCXWz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 19:22:55 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9850B7
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 16:22:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9b2f73e3af3so259381566b.3
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 16:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696375370; x=1696980170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z022+hD2oB//jAKqOrdZqf+zZSE40o5uTIGWJ6ucIE=;
        b=HAwn4xaKvmQHVasnSdKN6Drv6pwjaLzxIDORBEpExt2T4xv4cIcPyXzTMDjlSTd3Ta
         MXZaVbDiY6V3yVBEUWn5UcXFhSYt0bKRFy3nmKDfSQb2b1jXVmp82Olg69Vayhb3T82n
         2ICjT0jWDSnXzXf5ic7KA8h+0FXhqCHvgs1pL8geUjdxfeirdjkKx8p412K7Z2Z/HoU7
         Qr9TLpRlShS+cKtPznm5jrYFDEsAjFBU5yiJ3UAZx4pYU2SozsYtfmSNmzQuOdBAPaWk
         +d/xEQ/d7MdrVkP6+gp5S4EtgBd0FJftVJuw243TqhBfq8an446BFlfDLEJHBEFmCfcZ
         XI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375370; x=1696980170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z022+hD2oB//jAKqOrdZqf+zZSE40o5uTIGWJ6ucIE=;
        b=mGM5Tg60GHxoSUR4lbTHB8J2/V7HvB1otUxwg2zlhiy5NIlS0fVoKJEzop+IIx7ced
         HzcEHmOQ5T1y83eBLcOdMZDFM1SlTRhZZA6c/1ykuSlShSwCjP0fSha7MB2FmLy8Myxf
         IYy0iTl61DhZhBG+xR8HboB21VimpszwfzKDZA9RMgk9UaUnLbSbXbE1njboFFaUQ4QF
         Ji7JBcPe6FPy7ZJldvi8JsaItAw60X/ebSGOlTVJ9zhInG0nywJVLkHcekhrzwHDQSlO
         WRPCxqzeCIhGtIAIsREp/1Gsm0qqHOdpCmcBCGWJGC0XeFkNH3oQ34o1w7xK1p4dRCDn
         OdNA==
X-Gm-Message-State: AOJu0YyMG3VlJ3daxGFGhFLZGHn8N0KA1zNAT8oSxA8AkYYCRxFY3bP/
        lyC4njmAroEx8LzcfCe0EQp6VISC01wTkHPJhWUMlg==
X-Google-Smtp-Source: AGHT+IGAyGev7nf+zBtH4Km6sxjwtNzFlkUturz3cFMrNbSh0v1YhO7orCqpkZDnkSFsw8ajzWEUmfVvX5MRV4zjWmk=
X-Received: by 2002:a17:906:538f:b0:99e:f3b:2f78 with SMTP id
 g15-20020a170906538f00b0099e0f3b2f78mr610073ejo.67.1696375370218; Tue, 03 Oct
 2023 16:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231003171329.GB314430@monkey> <20231003231422.4046187-1-nphamcs@gmail.com>
In-Reply-To: <20231003231422.4046187-1-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 3 Oct 2023 16:22:10 -0700
Message-ID: <CAJD7tkZRH5-y-ux2hDt70JpmL5=YwRwrg_otiTbAei09x-GAJQ@mail.gmail.com>
Subject: Re: [PATCH] memcontrol: only transfer the memcg data for migration
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, fvdl@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 3, 2023 at 4:14=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> For most migration use cases, only transfer the memcg data from the old
> folio to the new folio, and clear the old folio's memcg data. No
> charging and uncharging will be done. These use cases include the new
> hugetlb memcg accounting behavior (which was not previously handled).
>
> This shaves off some work on the migration path, and avoids the
> temporary double charging of a folio during its migration.
>
> The only exception is replace_page_cache_folio(), which will use the old
> mem_cgroup_migrate() (now renamed to mem_cgroup_replace_folio). In that
> context, the isolation of the old page isn't quite as thorough as with
> migration, so we cannot use our new implementation directly.
>
> This patch is the result of the following discussion on the new hugetlb
> memcg accounting behavior:
>
> https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
>
> Reported-by: Mike Kravetz <mike.kravetz@oracle.com>
> Closes: https://lore.kernel.org/lkml/20231003171329.GB314430@monkey/
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Does this patch fit before or after your series? In both cases I think
there might be a problem for bisectability.

> ---
>  include/linux/memcontrol.h |  7 ++++++
>  mm/filemap.c               |  2 +-
>  mm/memcontrol.c            | 45 +++++++++++++++++++++++++++++++++++---
>  mm/migrate.c               |  3 +--
>  4 files changed, 51 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a827e2129790..e3eaa123256b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -711,6 +711,8 @@ static inline void mem_cgroup_uncharge_list(struct li=
st_head *page_list)
>
>  void mem_cgroup_cancel_charge(struct mem_cgroup *memcg, unsigned int nr_=
pages);
>
> +void mem_cgroup_replace_folio(struct folio *old, struct folio *new);
> +
>  void mem_cgroup_migrate(struct folio *old, struct folio *new);
>
>  /**
> @@ -1294,6 +1296,11 @@ static inline void mem_cgroup_cancel_charge(struct=
 mem_cgroup *memcg,
>  {
>  }
>
> +static inline void mem_cgroup_replace_folio(struct folio *old,
> +               struct folio *new)
> +{
> +}
> +
>  static inline void mem_cgroup_migrate(struct folio *old, struct folio *n=
ew)
>  {
>  }
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 9481ffaf24e6..673745219c82 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -819,7 +819,7 @@ void replace_page_cache_folio(struct folio *old, stru=
ct folio *new)
>         new->mapping =3D mapping;
>         new->index =3D offset;
>
> -       mem_cgroup_migrate(old, new);
> +       mem_cgroup_replace_folio(old, new);
>
>         xas_lock_irq(&xas);
>         xas_store(&xas, new);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6660684f6f97..cbaa26605b3d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7316,16 +7316,17 @@ void __mem_cgroup_uncharge_list(struct list_head =
*page_list)
>  }
>
>  /**
> - * mem_cgroup_migrate - Charge a folio's replacement.
> + * mem_cgroup_replace_folio - Charge a folio's replacement.
>   * @old: Currently circulating folio.
>   * @new: Replacement folio.
>   *
>   * Charge @new as a replacement folio for @old. @old will
> - * be uncharged upon free.
> + * be uncharged upon free. This is only used by the page cache
> + * (in replace_page_cache_folio()).
>   *
>   * Both folios must be locked, @new->mapping must be set up.
>   */
> -void mem_cgroup_migrate(struct folio *old, struct folio *new)
> +void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
>  {
>         struct mem_cgroup *memcg;
>         long nr_pages =3D folio_nr_pages(new);
> @@ -7364,6 +7365,44 @@ void mem_cgroup_migrate(struct folio *old, struct =
folio *new)
>         local_irq_restore(flags);
>  }
>
> +/**
> + * mem_cgroup_migrate - Transfer the memcg data from the old to the new =
folio.
> + * @old: Currently circulating folio.
> + * @new: Replacement folio.
> + *
> + * Transfer the memcg data from the old folio to the new folio for migra=
tion.
> + * The old folio's data info will be cleared. Note that the memory count=
ers
> + * will remain unchanged throughout the process.
> + *
> + * Both folios must be locked, @new->mapping must be set up.
> + */
> +void mem_cgroup_migrate(struct folio *old, struct folio *new)
> +{
> +       struct mem_cgroup *memcg;
> +
> +       VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
> +       VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
> +       VM_BUG_ON_FOLIO(folio_test_anon(old) !=3D folio_test_anon(new), n=
ew);
> +       VM_BUG_ON_FOLIO(folio_nr_pages(old) !=3D folio_nr_pages(new), new=
);
> +
> +       if (mem_cgroup_disabled())
> +               return;
> +
> +       memcg =3D folio_memcg(old);
> +       /*
> +        * Note that it is normal to see !memcg for a hugetlb folio.
> +        * It could have been allocated when memory_hugetlb_accounting wa=
s not
> +        * selected, for e.g.
> +        */
> +       VM_WARN_ON_ONCE_FOLIO(!memcg, old);
> +       if (!memcg)
> +               return;
> +
> +       /* Transfer the charge and the css ref */
> +       commit_charge(new, memcg);
> +       old->memcg_data =3D 0;
> +}
> +
>  DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
>  EXPORT_SYMBOL(memcg_sockets_enabled_key);
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7d1804c4a5d9..6034c7ed1d65 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -633,8 +633,7 @@ void folio_migrate_flags(struct folio *newfolio, stru=
ct folio *folio)
>
>         folio_copy_owner(newfolio, folio);
>
> -       if (!folio_test_hugetlb(folio))
> -               mem_cgroup_migrate(folio, newfolio);
> +       mem_cgroup_migrate(folio, newfolio);
>  }
>  EXPORT_SYMBOL(folio_migrate_flags);
>
> --
> 2.34.1
>
