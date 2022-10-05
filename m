Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9038B5F57E5
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJEP4N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJEP4M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 11:56:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF5E7969F
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 08:56:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so1284544wmq.1
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 08:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7a/LoYvpCfoolYwQAKh6JCAxVB7pDgsUOT/7iK/WTWA=;
        b=oatM/DuzZqdzxPdmhesMOJTCOHkKQGc14RUqIgdihrzrd6CfHIa6r3nXHN+2iKe9vp
         OpQRH9oRNrvvfa/zRsB+qWD7adGbskLl31VKTezR6LLg0nXT4E+A38BspZ5G28RYbjAY
         YEknG8XvaPZVXP9b7yZWVEH9n/QH2kV6NNeZ7r23NalWKjpkqnkC0hGd2qk1A4LGcI8H
         cipvVTQP2t4nhsfBCwM/xQqdfgR+2y3CskyIfMkGozej8NdY/6qtdpXGosCcGYrTkds/
         a+NTULObkeiYlG3d3ptMyOijxKdy1su6oiVirLzBOhKN5aQj1mBQapv9WNEd1Ent93l9
         vd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7a/LoYvpCfoolYwQAKh6JCAxVB7pDgsUOT/7iK/WTWA=;
        b=wULuOiyos0VLIsfGaXXeRodSK2UlGffW4d29FbtaYnblqNAMZsUopyKEui8oixsYuS
         5sP12qHm1QuQuFf8N48Govoa3dan7k+ii9D3nW6Kx3nyi/srZEIuZPjsPa1p+dAtmPPG
         Y90DtMXeDese3o2jnxieSaNVbMS+vJU5ELHhlvvaWNGBa5la9TR8tT0sdNKML3ybrDZW
         syCEA4Z1UXNA2n840fS1UkLDaPgBcdpx5aFHNKUeA2dRReAAQJF3cypPaJZ5W5H1NjNT
         zlFdrY0sOgpMJQxvae7p31xrNd6UuHzyGJVDmSDroy7RYbeN5OH7MlronZ5ydtS1ceFc
         a5Lg==
X-Gm-Message-State: ACrzQf2UtxjKVC4X/j1aOOUB/LbhlmIbv2qKL/WfpgF1bKANEmNOSB2y
        9PlDtZEMrvwEkF50PVT3gnI1btTn5lwdBG/ENBwryQ==
X-Google-Smtp-Source: AMsMyM4NzpApVCSaeSrqVfB0BIHl7CGUiDtHyAfG/+pwqTtYM8YfYREzw1B3JoiHg4VRqpRqwJ4ihZLf4SQ9abKcq28=
X-Received: by 2002:a7b:ce97:0:b0:3b3:4136:59fe with SMTP id
 q23-20020a7bce97000000b003b3413659femr199314wmj.24.1664985368254; Wed, 05 Oct
 2022 08:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221004233446.787056-1-yosryahmed@google.com>
 <Yz2O1dGeBGBTh6SM@cmpxchg.org> <CAJD7tkbMtHEN_1zGP=V1X4YGFCxEXv_j2Fqe8TFdOTy-ykiVUg@mail.gmail.com>
 <Yz2oAjIRZKKwe8tY@cmpxchg.org>
In-Reply-To: <Yz2oAjIRZKKwe8tY@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Oct 2022 08:55:31 -0700
Message-ID: <CAJD7tkYc2hTdOXedjfK60=Q=HAbHp6ch5cLH=C3GDakc6MdBmA@mail.gmail.com>
Subject: Re: [PATCH] mm/vmscan: check references from all memcgs for
 swapbacked memory
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 5, 2022 at 8:51 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Oct 05, 2022 at 07:54:25AM -0700, Yosry Ahmed wrote:
> > On Wed, Oct 5, 2022 at 7:04 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > Would you mind moving this to folio_referenced() directly? There is
> > > already a comment and branch in there that IMO would extend quite
> > > naturally to cover the new exception:
> > >
> > >         /*
> > >          * If we are reclaiming on behalf of a cgroup, skip
> > >          * counting on behalf of references from different
> > >          * cgroups
> > >          */
> > >         if (memcg) {
> > >                 rwc.invalid_vma = invalid_folio_referenced_vma;
> > >         }
> > >
> > > That would keep the decision-making and doc in one place.
> >
> > Hi Johannes,
> >
> > Thanks for taking a look!
> >
> > I originally wanted to make the change in folio_referenced(). My only
> > concern was that it wouldn't be clear for people looking at reclaim
> > code in mm/vmscan.c. It would appear as if we are passing in the
> > target memcg to folio_referenced(), and only if you look within you
> > would realize that sometimes it ignores the passed memcg.
> >
> > It seemed to me that deciding whether we want to check references from
> > one memcg or all of them is a reclaim decision, while
> > folio_referenced() is just an rmap API that does what it is told: "if
> > I am passed a memcg, I only look at references coming from this
> > memcg". On the other hand, it looks like the doc has always lived in
> > folio_referenced()/page_referenced(), so I might be overthinking this
> > (I have been known to do this).
>
> I agree it would be nicer to have this policy in vmscan.c. OTOH it's a
> policy that applies to all folio_referenced() callers, and it's
> fragile to require them to opt into it individually.
>
> Vmscan is the only user of the function, so it's not the worst thing
> to treat it as an extension of the reclaim code.
>
> If it helps convince you, there is another, actually quite similar
> reclaim policy already encoded in folio_referenced():
>
>                         if (ptep_clear_flush_young_notify(vma, address,
>                                                 pvmw.pte)) {
>                                 /*
>                                  * Don't treat a reference through
>                                  * a sequentially read mapping as such.
>                                  * If the folio has been used in another mapping,
>                                  * we will catch it; if this other mapping is
>                                  * already gone, the unmap path will have set
>                                  * the referenced flag or activated the folio.
>                                  */
>                                 if (likely(!(vma->vm_flags & VM_SEQ_READ)))
>                                         referenced++;
>                         }

Thanks for clarifying. Will send v2 later today :)
