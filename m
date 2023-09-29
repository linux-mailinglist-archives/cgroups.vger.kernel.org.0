Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB927B2A0A
	for <lists+cgroups@lfdr.de>; Fri, 29 Sep 2023 02:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjI2A6y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Sep 2023 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2A6x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Sep 2023 20:58:53 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A6FB4;
        Thu, 28 Sep 2023 17:58:52 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fe612beabso189512739f.3;
        Thu, 28 Sep 2023 17:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695949131; x=1696553931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQhR8ua9u0kwxviXq1bg935rieHu4O72pOc1/rhQSOM=;
        b=DUpkI5G0Vp4ars7WWhOe+ejsqtQ9FjXVZ/cpg/F4hGsqsBNbMtnCc7FDSXzPYvhECB
         6LG4as/LarJxQvvvjPsJ51Bkb/S7laycR3TIqqpnpyZdvKqA/fww9W20wuVG9cLLBrB5
         6DtNOYsFlJRY7De7dZbAoHx/Zp75oh4cZMoocXsBZKQ6jFmEtA29Yc4Ds3rchxfnd64u
         ncn/pLWKzsAfRSwiHcUI4/R7dgnh9YcipccuD1hfRtbcEGqwHP9btvnPZzFWb33DP6G4
         SUkiuMcDXU12MbU8il8cnFumMlxXPIrNqlmpSUfV5NcGYSzgxv7ztQEfTRwFCkRCAoFk
         +HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695949131; x=1696553931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQhR8ua9u0kwxviXq1bg935rieHu4O72pOc1/rhQSOM=;
        b=VF/V2dapWg3eIz8h9Cq60hr2VoxclrZTYBkaFK2W6wFoJ9SzLI+1RUa/Xk5ifEb8vq
         hnV+Gaadd3+j13x06IEcYBsjdyHjrx9xmXNMwUf010u4/lBPHoZtV7IpkNTtkL5OteVz
         p992pwEn4vxSrf8a2dVBnmxp9nIyzq8psAOoZOnTm3E4oTAG0Ah03gj4UBxnLii9KaCd
         kNk9U6ZL+KJsYdCANcJYczdFn+pywcRWEvMpjIzwZM/JLDjxT5MNLlDvI3ymAKa/UTMR
         gn4bJnkxGhgWVI29D0RYhjXVqmHSdsvzUi9dW4k7Xo521X+i6X3iWihdP16EVRqkxHuP
         1Agw==
X-Gm-Message-State: AOJu0YzAcRkLS/0nL+1MptfstGvpBII0wYCwZigfAKBoSAV3wTcyzcby
        gGUceJdH4HYdgYgxc6brupHra1dW5CIQycUkXU8=
X-Google-Smtp-Source: AGHT+IHinTu386Q3JuFdZBoiwhCEpmnImaJNx1XG73Tt/N3OsVKpe0IeK9BKL3QLHC01R3kxGnIrCCrbnJwW8a26J6Q=
X-Received: by 2002:a5e:dc44:0:b0:78b:d0a9:34fb with SMTP id
 s4-20020a5edc44000000b0078bd0a934fbmr2937625iop.20.1695949131499; Thu, 28 Sep
 2023 17:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
 <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
In-Reply-To: <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 28 Sep 2023 17:58:40 -0700
Message-ID: <CAKEwX=M=8KYqvBTz9z1csrsFUpGf2tgWj-oyu96dSpRjn3ZnUQ@mail.gmail.com>
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

On Thu, Sep 28, 2023 at 5:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> <snip>
>
> >
> > +
> > +/**
> > + * mem_cgroup_hugetlb_charge_folio - Charge a newly allocated hugetlb =
folio.
> > + * @folio: folio to charge.
> > + * @gfp: reclaim mode
> > + *
> > + * This function charges an allocated hugetlbf folio to the memcg of t=
he
> > + * current task.
> > + *
> > + * Returns 0 on success. Otherwise, an error code is returned.
> > + */
> > +int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp)
> > +{
> > +       struct mem_cgroup *memcg;
> > +       int ret;
> > +
> > +       if (mem_cgroup_disabled() ||
> > +               !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUN=
TING))
>
> What happens if the memory controller is mounted in a cgroup v1
> hierarchy? It appears to me that we *will* go through with hugetlb
> charging in this case?

Ah right, cgroup v1. Does it not work with mount flag guarding?
What's the behavior of cgroup v1 when it comes to memory
recursive protection for e.g (which this mount flag is based on)?

If it doesn't work, we'll have to add a separate knob for v1 -
no biggies.

Other than this concern, I don't have anything against cgroup v1
having this feature per se - everything should still work. But let
I know if it can break cgroupv1 accounting otherwise :)

>
> >
> > +               return 0;
> > +
> > +       memcg =3D get_mem_cgroup_from_current();
> > +       ret =3D charge_memcg(folio, memcg, gfp);
> > +       mem_cgroup_put(memcg);
> > +
> > +       return ret;
> > +}
> > +
> >  /**
> >   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for=
 swapin.
> >   * @folio: folio to charge.
> > --
> > 2.34.1
