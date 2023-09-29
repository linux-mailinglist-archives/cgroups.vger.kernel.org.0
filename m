Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F407B2A15
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 03:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjI2BHv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Sep 2023 21:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI2BHu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Sep 2023 21:07:50 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453FFC1;
        Thu, 28 Sep 2023 18:07:48 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-79fa425855cso405665139f.2;
        Thu, 28 Sep 2023 18:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695949667; x=1696554467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5g8ip1Hfb6Fb3NLvr5JJcqhAnvl2wXLCCuGQvM5dTy0=;
        b=aZMaNBB56hwLoDZAbAjJssb6yrxwueuDkVF+0J/DSQRCxQGnQXzSAFTLvW5Rlw61gy
         3OOp1lLG7VkSk5RC9P2r4el2w88sIRm8SzNKqhWlVxpO4FRmI7q8DedbJ4O9pozwRubH
         JYmE0c0+awAK85I7sqjiwXEQUFlf690M4h2bLKFNqbLnT+g5mJrXCfElHdRKdSnCBq6G
         qHclB6KE6SqJiq5UF/3JK5FXL6O3zlKzg+uXD/UcqHsatDBVhWrjxqINuhRJ94k9UY8u
         1L6zbkz9lkqxHJXCaO69nm1cPZnxZj/Ptp9xVH5F1JgDnBlGcCU9y8T9LIacCsF3CXHh
         t6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695949667; x=1696554467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5g8ip1Hfb6Fb3NLvr5JJcqhAnvl2wXLCCuGQvM5dTy0=;
        b=lfNsa+9v2o3MR9VdC/FM5kSq2HO8btrc6kTCUxDHeaF6VmLrOwzfTwDChmRlQWgJxb
         r/AV8W96BH0obM/bbfWkVNAhRyTiLEd48dUUfq7dQ5ZTcFdqKvh4PExrBvDwMpgkFxaA
         1OFPi8235AcqQcuE6agfnkCxKxOeHevGvFmrN0lFyRJWWmJnEM4HwZzAxF26zycCfiIM
         HeeucAGzfTgqWHh4khzc2BLKBq898GuNngIxyPqT4RsxyCbOuQIkAIzzKEtOC9FHM94v
         XUIEYKxJfTcumzi5H4aVz6LDJ9zpmQjzOoxAmXnZsJUwrYuNAZIaR+c0z3VFi5EAtVzk
         jW/g==
X-Gm-Message-State: AOJu0YyNiXNavhZfO4ECXsJADodf4nzK63CUhOq5zNnTlMfJWZCZAkKU
        LBVMaQeMYN1FcKrRHsLnaMq/T8XHkrvu65JAy3E=
X-Google-Smtp-Source: AGHT+IHYOmQNQlpi393slH78HhN8EcL32BTVoQx5UJoNgS5sGhvztAxAWvp0lJmcD6QIUys0mqxI9uIuwt18ROhhlXM=
X-Received: by 2002:a6b:fd01:0:b0:792:6cb2:e92c with SMTP id
 c1-20020a6bfd01000000b007926cb2e92cmr3013736ioi.3.1695949667512; Thu, 28 Sep
 2023 18:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com> <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com>
In-Reply-To: <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 28 Sep 2023 18:07:36 -0700
Message-ID: <CAKEwX=Npb4mwZ2ibJkmD5GyqXazr7PH8UGLu+YSDY8acf152Eg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
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

On Thu, Sep 28, 2023 at 5:58=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Sep 28, 2023 at 5:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > <snip>
> >
> > >
> > > +
> > > +/**
> > > + * mem_cgroup_hugetlb_charge_folio - Charge a newly allocated hugetl=
b folio.
> > > + * @folio: folio to charge.
> > > + * @gfp: reclaim mode
> > > + *
> > > + * This function charges an allocated hugetlbf folio to the memcg of=
 the
> > > + * current task.
> > > + *
> > > + * Returns 0 on success. Otherwise, an error code is returned.
> > > + */
> > > +int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp)
> > > +{
> > > +       struct mem_cgroup *memcg;
> > > +       int ret;
> > > +
> > > +       if (mem_cgroup_disabled() ||
> > > +               !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCO=
UNTING))
> >
> > What happens if the memory controller is mounted in a cgroup v1
> > hierarchy? It appears to me that we *will* go through with hugetlb
> > charging in this case?
>
> Ah right, cgroup v1. Does it not work with mount flag guarding?
> What's the behavior of cgroup v1 when it comes to memory
> recursive protection for e.g (which this mount flag is based on)?
>
> If it doesn't work, we'll have to add a separate knob for v1 -
> no biggies.

But to be clear, my intention is that we're not adding this
feature to v1 (which, to my understanding, has been
deprecated).

If it's added by virtue of it sharing infrastructure with v2,
then it's fine, but only if the mount option still works to
guard against unintentional enablement (if not we'll
also short-circuit v1, or add knobs if ppl really want
it in v1 as well).

If it's not added at all, then I don't have any complaints :)

>
> Other than this concern, I don't have anything against cgroup v1
> having this feature per se - everything should still work. But let
> I know if it can break cgroupv1 accounting otherwise :)
>
> >
> > >
> > > +               return 0;
> > > +
> > > +       memcg =3D get_mem_cgroup_from_current();
> > > +       ret =3D charge_memcg(folio, memcg, gfp);
> > > +       mem_cgroup_put(memcg);
> > > +
> > > +       return ret;
> > > +}
> > > +
> > >  /**
> > >   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio f=
or swapin.
> > >   * @folio: folio to charge.
> > > --
> > > 2.34.1
