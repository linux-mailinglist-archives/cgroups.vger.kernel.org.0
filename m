Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3349F7B592F
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjJBR2x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 13:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJBR2w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 13:28:52 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7592FB4;
        Mon,  2 Oct 2023 10:28:48 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79fa5d9f3a2so516464539f.3;
        Mon, 02 Oct 2023 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696267728; x=1696872528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+gPI7karCGwOfvdi9At0XF2O3t7B4eyDINiSd4rikE=;
        b=DMci7H0fOPQCtwnpg2AHotRw3yF/vPTyh6yn7qrnfE3p5bo3AY2xN4VQB3I+1gCREZ
         v9eDCuqN1yzbmIM0Zu9mtiSk99LfyLkN1y8yx4awr1QBBGIAINVH8psrZOU8af0VdbfW
         LfZf98SeAdh8MtQu3A9XEhF/w6dxsUILz60E/ZyU/D0IGyJbpG/eaco9Bwz9DmzBQANM
         63MEuMoKvHDFzoiFK1gpbeHay4ODiJQkkhIjQrzbyGJ68yBec6tBZbaH14RbLQvSCLQk
         yRo7Xgr6bpJAsOkukZ4QcUs3Zz9g8bq169Rm1eysglUGaOHNr64vzrgzl1y/VL5wfS7D
         oC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696267728; x=1696872528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+gPI7karCGwOfvdi9At0XF2O3t7B4eyDINiSd4rikE=;
        b=gpqSFRJGxDBiG7lcsfKNgTmVFikYc2Txo/paF+f4UUKjgA+c4YFm+P9u6CG3vLBW3j
         Lxa+U8qi2FewPMtW268fQ4+brWxczzCwUQyJLYGtDyyA9TN8cg+jWQotkh+CmxqZh/e8
         9erxEswqm9GOqU2PuvTnnrIMUG66pJfmdCR+qlhPEATfbBcHu6WpNtd32+hTYCZIxp/X
         AP0vSCxHblop9YpcOsCxTwUkuyf+kKaBLTxqkqExidYkjbXIrBV4RSJSODEorEw6Dgn2
         Odc+C5JQLre/BDEq9VlEW6VDVbGGV72Vc76tBN8FuTWGtaY7yBKjTPUn7Zq5Mqbjb1vf
         AseQ==
X-Gm-Message-State: AOJu0Yz6zKU8W0mxchevlpq9Ier8OrOS4UrFdfzQsx7zIxwy4FQgZj/7
        58EwFYL0Y7ASqcDCxfJG5PbTL0o/22dwD0uJy8Q=
X-Google-Smtp-Source: AGHT+IED9P/sdhWflPI5nZpkF9sxImJVIZAlrYm2HirkirDwKllAD69cNEDugkzKyvrzn1PiwUA8gd/WJCRrppMRfNk=
X-Received: by 2002:a6b:7318:0:b0:79f:a3ac:71dc with SMTP id
 e24-20020a6b7318000000b0079fa3ac71dcmr12901656ioh.8.1696267727558; Mon, 02
 Oct 2023 10:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
 <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
In-Reply-To: <ZRrI90KcRBwVZn/r@dhcp22.suse.cz>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 2 Oct 2023 10:28:36 -0700
Message-ID: <CAKEwX=OwrMNMAvve9a965mBJm8as+njtXE993VcnKXdccd5GEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
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

On Mon, Oct 2, 2023 at 6:43=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Wed 27-09-23 17:57:22, Nhat Pham wrote:
> > Currently, hugetlb memory usage is not acounted for in the memory
> > controller, which could lead to memory overprotection for cgroups with
> > hugetlb-backed memory. This has been observed in our production system.
> >
> > This patch rectifies this issue by charging the memcg when the hugetlb
> > folio is allocated, and uncharging when the folio is freed (analogous t=
o
> > the hugetlb controller).
>
> This changelog is missing a lot of information. Both about the usecase
> (we do not want to fish that out from archives in the future) and the
> actual implementation and the reasoning behind that.
>
> AFAICS you have decided to charge on the hugetlb use rather than hugetlb
> allocation to the pool. I suspect the underlying reasoning is that pool
> pages do not belong to anybody. This is a deliberate decision and it
> should be documented as such.

Yep that was the intention behind placing the charging of the hugetlb folio
in alloc_hugetlb_folio(). I'll document this in the changelog and/or code.

>
> It is also very important do describe subtle behavior properties that
> might be rather unintuitive to users. Most notably

If you don't mind, I'll summarize these into the next version of
the patch's changelog :)

> - there is no hugetlb pool management involved in the memcg
>   controller. One has to use hugetlb controller for that purpose.
>   Also the pre allocated pool as such doesn't belong to anybody so the
>   memcg host overcommit management has to consider it when configuring
>   hard limits.
> - memcg limit reclaim doesn't assist hugetlb pages allocation when
>   hugetlb overcommit is configured (i.e. pages are not consumed from the
>   pool) which means that the page allocation might disrupt workloads
>   from other memcgs.
> - failure to charge a hugetlb page results in SIGBUS rather
>   than memcg oom killer. That could be the case even if the
>   hugetlb pool still has pages available and there is
>   reclaimable memory in the memcg.

Ah yes that should be documented indeed.

> - hugetlb pages are contributing to memory reclaim protection
>   implicitly. This means that the low,min limits tunning has to consider
>   hugetlb memory as well.

This was the original inspiration for this change. I'll expand on it
in the new version's changelog.

>
> I suspect there is more than the above. To be completely honest I am
> still not convinced this is a good idea.
>
> I do recognize that this might work in a very limited environments but
> hugetlb management is quite challenging on its own and this just adds
> another layer of complexity which is really hard to see through without
> an intimate understanding of both memcg and hugetlb. The reason that
> hugetlb has been living outside of the core MM (and memcg) is not just
> because we like it that way. And yes I do fully understand that users
> shouldn't really care about that because this is just a memory to them.
>
> We should also consider the global control for this functionality. I am
> especially worried about setups where a mixed bag of workloads
> (containers) is executed. While some of them will be ready for the new
> accounting mode many will leave in their own world without ever being
> modified. How do we deal with that situation?

Johannes already responded to this, but I also think this hypothetical
situation isn't super urgent to handle right now. That said, we can
always revisit it if/when it proves to be an issue and add appropriate
memcg-specific control for this feature as a follow-up.

>
> All that being said, I am not going to ack nor nack this but I really do
> prefer to be much more explicit about the motivation and current
> implementation specifics so that we can forward users to something
> they can digest.
>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> [...]
>
> a minor implementation detail below. I couldn't spot anything obviously
> broken with the rest of the hugetlb specific code. restore_reserve_on_mem=
cg_failure
> is rather clumsy and potentially error prone but I will leave that out
> to Mike as he is much more familiar with that behavior than me.

That part irks me too, but I'm trying to follow the error handling logic
that follows each alloc_hugetlb_folio() call site.

If anyone has any suggestions, I'd be happy to listen!

>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index de220e3ff8be..ff88ea4df11a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> [...]
> > @@ -3119,6 +3121,15 @@ struct folio *alloc_hugetlb_folio(struct vm_area=
_struct *vma,
> >                       hugetlb_cgroup_uncharge_folio_rsvd(hstate_index(h=
),
> >                                       pages_per_huge_page(h), folio);
> >       }
> > +
> > +     /* undo allocation if memory controller disallows it. */
> > +     if (mem_cgroup_hugetlb_charge_folio(folio, GFP_KERNEL)) {
>
> htlb_alloc_mask(h) rather than GFP_KERNEL. Ideally with
> __GFP_RETRY_MAYFAIL which is a default allocation policy.

Oh I wasn't aware of htlb_alloc_mask(h). So I'll fix this to:

htlb_alloc_mask(h) | __GFP_RETRY_MAYFAIL

>
> > +             if (restore_reserve_on_memcg_failure)
> > +                     restore_reserve_on_error(h, vma, addr, folio);
> > +             folio_put(folio);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> > +
> >       return folio;
> >
> >  out_uncharge_cgroup:
>
> --
> Michal Hocko
> SUSE Labs
