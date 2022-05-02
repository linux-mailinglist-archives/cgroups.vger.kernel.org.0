Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0655176CC
	for <lists+cgroups@lfdr.de>; Mon,  2 May 2022 20:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355750AbiEBSud (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 May 2022 14:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242074AbiEBSuc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 May 2022 14:50:32 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D0FBE04
        for <cgroups@vger.kernel.org>; Mon,  2 May 2022 11:47:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f7c424c66cso158233387b3.1
        for <cgroups@vger.kernel.org>; Mon, 02 May 2022 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9wSiuSwEdY5mnTnkaPbFc68dMNs+2B7Kv3x/mlBROY=;
        b=B5EJ0yX/6p4KphD4mHUJ1Rf/ah2ZGGbyCj3/Fg8jz6NZgaKjFGHXri9nWa56usJkQV
         i315aF1sZwZQCXuqR1GAJi/UydKqqqyJKrMK8NO2ltYq2E6LzRLcZv32EwENsp7gEeoz
         iSHMNZvgfxxeDjj5++SiliEGaOkXpt+a8RHyXVhO5DpOnU48kj++PVL3oUiAbWHvgwWt
         /8Cr6IfX5ViwgwukGvi0D67RRVTS2aaUOaOIh181LsfJrySzqwochKRZSrWUxxtwgj0X
         utkbg7G1h+72m4iLsTXSquLZ7P0i2NJO3VNDlb1N0tn+bpBJNirD0jDtdQa9nWw8JgOP
         HsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9wSiuSwEdY5mnTnkaPbFc68dMNs+2B7Kv3x/mlBROY=;
        b=r80JJhMvTISByLObrqFP+SAHfWlbUVFFyNt5gK7kjxiMaWhNo6l8zcPf7GuA+PoynS
         FFREctkuj4pQQ2QkME42F6VjTSZugWqZ5PnJ3bxJ11iK/A0NeQpBUxt4aeBTvzdD6fOe
         7pOMDivATxOz9gDBSAcmjerApsvS4kfAeumCHw7FcahViO9CtQ3N8vp099DXUMAO+6Um
         MFU5gZ+qhOHyBy8o1jUP0MCOOJLlV00mBtssVE9mT3SiwcMTAzNqrEyoyHSK0+CtxtmA
         MgFhSc6mZwsP779snnh06K581kHO1uTONo3WKBnToJoRuBeiBrPWEz9m7qhaFWosMd3u
         idcA==
X-Gm-Message-State: AOAM530Se3u8b//gYuIyFbouZ9++pJ2oxfpUCGRK/JQ6mIC2/Ysaxac9
        NwVhGBp9Y0vKHklWH66uTAkCEolrOcEj6NPfhwGp2w==
X-Google-Smtp-Source: ABdhPJwxpqbxXyab8ESki88sczGcbJxWGMwzL5arJQ5jrtTs062e6/AT9v4MrGSdRY/uVxIocNtDe7xab3HHmq5sxbI=
X-Received: by 2002:a81:dd07:0:b0:2eb:f701:286e with SMTP id
 e7-20020a81dd07000000b002ebf701286emr11872882ywn.341.1651517222179; Mon, 02
 May 2022 11:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220429201131.3397875-1-yosryahmed@google.com>
 <20220429201131.3397875-2-yosryahmed@google.com> <87ilqoi77b.wl-maz@kernel.org>
In-Reply-To: <87ilqoi77b.wl-maz@kernel.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 2 May 2022 11:46:26 -0700
Message-ID: <CAJD7tkY7JF25XXUFq2mGroetMkfo-2zGOaQC94pjZE3D42+oaw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm: add NR_SECONDARY_PAGETABLE to count secondary
 page table uses.
To:     Marc Zyngier <maz@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Oliver Upton <oupton@google.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 2, 2022 at 3:01 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Fri, 29 Apr 2022 21:11:28 +0100,
> Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > Add NR_SECONDARY_PAGETABLE stat to count secondary page table uses, e.g.
> > KVM mmu. This provides more insights on the kernel memory used
> > by a workload.
> >
> > This stat will be used by subsequent patches to count KVM mmu
> > memory usage.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 5 +++++
> >  Documentation/filesystems/proc.rst      | 4 ++++
> >  drivers/base/node.c                     | 2 ++
> >  fs/proc/meminfo.c                       | 2 ++
> >  include/linux/mmzone.h                  | 1 +
> >  mm/memcontrol.c                         | 1 +
> >  mm/page_alloc.c                         | 6 +++++-
> >  mm/vmstat.c                             | 1 +
> >  8 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 69d7a6983f78..828cb6b6f918 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1312,6 +1312,11 @@ PAGE_SIZE multiple when read back.
> >         pagetables
> >                  Amount of memory allocated for page tables.
> >
> > +       secondary_pagetables
> > +             Amount of memory allocated for secondary page tables,
> > +             this currently includes KVM mmu allocations on x86
> > +             and arm64.
>
> Can you please explain what the rationale is for this? We already
> account for the (arm64) S2 PTs as a userspace allocation (see

This can be considered as continuation for that work. The mentioned
commit accounts S2 PTs to the VM process cgroup kernel memory. We have
stats for the total kernel memory, and some fine-grained categories of
that, like (pagetables, stack, slab, etc.).

This patch just adds another category to give further insights into
what exactly is using kernel memory.

> 115bae923ac8bb29ee635). You are saying that this is related to a
> 'workload', but given that the accounting is global, I fail to see how
> you can attribute these allocations on a particular VM.

The main motivation is having the memcg stats, which give attribution
to workloads. If you think it's more appropriate, we can add it as a
memcg-only stat, like MEMCG_VMALLOC (see 4e5aa1f4c2b4 ("memcg: add
per-memcg vmalloc stat")). The only reason I made this as a global
stat too is to be consistent with NR_PAGETABLE.

>
> What do you plan to do for IOMMU page tables? After all, they serve
> the exact same purpose, and I'd expect these to be handled the same
> way (i.e. why is this KVM specific?).

The reason this was named NR_SECONDARY_PAGTABLE instead of
NR_KVM_PAGETABLE is exactly that. To leave room to incrementally
account other types of secondary page tables to this stat. It is just
that we are currently interested in the KVM MMU usage.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
