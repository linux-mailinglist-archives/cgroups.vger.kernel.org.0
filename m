Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB97B2A23
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 03:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjI2BTC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Sep 2023 21:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjI2BTC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Sep 2023 21:19:02 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8B194
        for <cgroups@vger.kernel.org>; Thu, 28 Sep 2023 18:19:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso1799870666b.2
        for <cgroups@vger.kernel.org>; Thu, 28 Sep 2023 18:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695950339; x=1696555139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZndDvjVADU6GuKHszhELnx+eP/DDe/5FgQazo+VWICo=;
        b=z3FhmGKVgykolqgvdknTpN5/d4XISRQQLaLPzv1L9yZWRob6rNpwH9CdLWsXQqMeW7
         ryWUIw7U4ygplh+FSVMYaUWk5OqtHnIzUw5N3jSfujcY13MOiwljnUgGBsB2E9fFRu/a
         YssNxuYcigcypnlJmxx48dajhqT7WyJSiX/Nnur+dybbLGAM7F4S7fw4T9kshOKmABBP
         G8wA7NnwK2qz3xMtQmA5XLf5AW+syuKlsKqCxT8aB3F4/j/PnbKmZ3ejh/VRsFv7nXVY
         GJ8nxL4ecfqpLg467oSFBaCW+QFLZbMDcd3Fh7O1+d8yCKTVS2Hb7sfWtDaGUw2atGuE
         uhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695950339; x=1696555139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZndDvjVADU6GuKHszhELnx+eP/DDe/5FgQazo+VWICo=;
        b=Iz2gMefVbCLRYUXzAPkwtbiVrMYogZimq8A1iu0errT22DyiMsbQDe6V7no/cGEDo7
         6uIN2jMjPCi/TB8JPiaU6hRhI4F0MSsAZ6BbecpwWoVzszQftYdJZAuZ7kMJ4rT5P3mD
         +oIQOQVrAnQ5f95x05qYs1CtWuDxfy+I/p0Pic+8P22PgNQa71VX92ts+t9cjPW3L1lT
         ybsu/YoBmFllZR/eEwQUlP2F136l4U2pqOmDHbOdQkJZcrsmjhZcHthvJ8HIR2ML3lqv
         Doh3g/PEZT9U0N9FeLiy+VA+CJWmQ53uTVxcC6loaHpqqrypGS1l5FcZcwDbcBH5NFi0
         dmKg==
X-Gm-Message-State: AOJu0Yz17kLJ9kzTyqpEvliRvklvNuXBKeHhgjXwjWX1i8OiRlkHRyvm
        d0WeNEEQjlmVdJfbXTmbLU1ngDnynXwo8zXthBZSnQ==
X-Google-Smtp-Source: AGHT+IFoqMyTpIfX6uaS77LPHDhJX8I+COqi1KAm9KTwagfqUaqSfprAUHibwy8HOVZyyMoMo2FVR53POoJHHT6q4hc=
X-Received: by 2002:a17:906:209e:b0:9ae:829e:d930 with SMTP id
 30-20020a170906209e00b009ae829ed930mr2742309ejq.9.1695950338777; Thu, 28 Sep
 2023 18:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
 <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com> <CAKEwX=Npb4mwZ2ibJkmD5GyqXazr7PH8UGLu+YSDY8acf152Eg@mail.gmail.com>
In-Reply-To: <CAKEwX=Npb4mwZ2ibJkmD5GyqXazr7PH8UGLu+YSDY8acf152Eg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 28 Sep 2023 18:18:19 -0700
Message-ID: <CAJD7tkaeDBTHC3UM91O56yrp8oCU-UBO6i_5HJMjVBDQAw0ipQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 28, 2023 at 6:07=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Sep 28, 2023 at 5:58=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Thu, Sep 28, 2023 at 5:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > <snip>
> > >
> > > >
> > > > +
> > > > +/**
> > > > + * mem_cgroup_hugetlb_charge_folio - Charge a newly allocated huge=
tlb folio.
> > > > + * @folio: folio to charge.
> > > > + * @gfp: reclaim mode
> > > > + *
> > > > + * This function charges an allocated hugetlbf folio to the memcg =
of the
> > > > + * current task.
> > > > + *
> > > > + * Returns 0 on success. Otherwise, an error code is returned.
> > > > + */
> > > > +int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp=
)
> > > > +{
> > > > +       struct mem_cgroup *memcg;
> > > > +       int ret;
> > > > +
> > > > +       if (mem_cgroup_disabled() ||
> > > > +               !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_AC=
COUNTING))
> > >
> > > What happens if the memory controller is mounted in a cgroup v1
> > > hierarchy? It appears to me that we *will* go through with hugetlb
> > > charging in this case?
> >
> > Ah right, cgroup v1. Does it not work with mount flag guarding?
> > What's the behavior of cgroup v1 when it comes to memory
> > recursive protection for e.g (which this mount flag is based on)?
> >
> > If it doesn't work, we'll have to add a separate knob for v1 -
> > no biggies.
>
> But to be clear, my intention is that we're not adding this
> feature to v1 (which, to my understanding, has been
> deprecated).
>
> If it's added by virtue of it sharing infrastructure with v2,
> then it's fine, but only if the mount option still works to
> guard against unintentional enablement (if not we'll
> also short-circuit v1, or add knobs if ppl really want
> it in v1 as well).
>
> If it's not added at all, then I don't have any complaints :)
>
> >
> > Other than this concern, I don't have anything against cgroup v1
> > having this feature per se - everything should still work. But let
> > I know if it can break cgroupv1 accounting otherwise :)
> >

My concern is the scenario where the memory controller is mounted in
cgroup v1, and cgroup v2 is mounted with memory_hugetlb_accounting.

In this case it seems like the current code will only check whether
memory_hugetlb_accounting was set on cgroup v2 or not, disregarding
the fact that cgroup v1 did not enable hugetlb accounting.

I obviously prefer that any features are also added to cgroup v1,
because we still didn't make it to cgroup v2, especially when the
infrastructure is shared. On the other hand, I am pretty sure the
maintainers will not like what I am saying :)
