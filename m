Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A715463F948
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 21:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiLAUkb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 15:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLAUka (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 15:40:30 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4375BA431B
        for <cgroups@vger.kernel.org>; Thu,  1 Dec 2022 12:40:29 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id e10so1435963vkk.0
        for <cgroups@vger.kernel.org>; Thu, 01 Dec 2022 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8+d/Y6QGxzCRwo466zPM3VyCOXSKLx8dJYK4YlExqPw=;
        b=kHhd1lJNN1/QkG4w2PtJZDkbCFG9xjthR8OUDLqRnbAHospcNfy5OCNh/Hx2uf59HM
         3qsa2ra3nVtmktTsWSpx/1wvizTHK+f3yfNmfer9LBmr8CEl1HXS+QrleH8ngBBUzh9Z
         j/S3wnaSCMBs88wZ12gX2Tl2YnYGx0RvGtCyumY/GZrCVo0Ubo7Qh7pkOijxaXFiSlBO
         yDYGD00ryih7qUIdL2O4BXMriKUaxq5pSMbLv+d1aFQPjlTdpFx/KILSJQ35wFxwd8BE
         slEz+13gdl9RT5DNs0PqkQ+RHSePka0GLdwfP1MFajg3gB+QyI9oX+p+Kfz2JenxgPDb
         9g7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+d/Y6QGxzCRwo466zPM3VyCOXSKLx8dJYK4YlExqPw=;
        b=1gbF0wIcTiqq40sMswJOlN9NhWU9e0gkoQOApme1Pc0IOgImt9BxL8QkJmYAa9jFi/
         2LG6FmqNomWHrpj/glufAkVqWa8ts4KoMizzoua+EnAAgrhEpc2nXvqDzMB4UJ96yikx
         cuLHoxFi8nzXXozXdTIpZmKVHpkMQHrHvedAXn/LodIJ6XZv/HnYbVrhe9L1E6kRgkOs
         Iox4cwRfickQZ6HJuQTSYBBUSJkQCRpqOQdhC6SVqetwKNw7EFLT0JBoTEMk9jJ6GZiJ
         U1kTn9E1wFNVM3kK9y0b05WfOMdHVObQBaNB88+W/JWNS6a3naQBzZl+JN4p7zp0DDOB
         CU6Q==
X-Gm-Message-State: ANoB5pkcdU3nIV1ZGDsDdHS5Hf6nJmlILNpiU3HL0lUElYSRIBsjeoco
        DFlLsBqhMAftGbPikDwU0bmP6MbgeiwLH477yjeRSg==
X-Google-Smtp-Source: AA0mqf7vbPk0q9HDNwJryKLFrpFpMSN/fajOGVbvLf3ajA8ApvPQWKfnkG+PQ//esM2Efw/J/HAk/mqT3Y0pz1xE+zE=
X-Received: by 2002:a1f:2a49:0:b0:3bc:61cb:e4fa with SMTP id
 q70-20020a1f2a49000000b003bc61cbe4famr29011961vkq.15.1669927228271; Thu, 01
 Dec 2022 12:40:28 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org> <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Y4ZKgXdUXZ3ycMp4@cmpxchg.org> <87wn7dayfz.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wn7dayfz.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 1 Dec 2022 12:40:16 -0800
Message-ID: <CAHS8izNc=NeMcNudOB0r4aYbZURpU+Y9xpek_KpO=55R+7ec5g@mail.gmail.com>
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
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

On Tue, Nov 29, 2022 at 7:56 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Johannes Weiner <hannes@cmpxchg.org> writes:
>
> > Hello Ying,
> >
> > On Thu, Nov 24, 2022 at 01:51:20PM +0800, Huang, Ying wrote:
> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> > The fallback to reclaim actually strikes me as wrong.
> >> >
> >> > Think of reclaim as 'demoting' the pages to the storage tier. If we
> >> > have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
> >> > CXL and from CXL to storage. If we reclaim a page from RAM, it means
> >> > we 'demote' it directly from RAM to storage, bypassing potentially a
> >> > huge amount of pages colder than it in CXL. That doesn't seem right.
> >> >
> >> > If demotion fails, IMO it shouldn't satisfy the reclaim request by
> >> > breaking the layering. Rather it should deflect that pressure to the
> >> > lower layers to make room. This makes sure we maintain an aging
> >> > pipeline that honors the memory tier hierarchy.
> >>
> >> Yes.  I think that we should avoid to fall back to reclaim as much as
> >> possible too.  Now, when we allocate memory for demotion
> >> (alloc_demote_page()), __GFP_KSWAPD_RECLAIM is used.  So, we will trigger
> >> kswapd reclaim on lower tier node to free some memory to avoid fall back
> >> to reclaim on current (higher tier) node.  This may be not good enough,
> >> for example, the following patch from Hasan may help via waking up
> >> kswapd earlier.
> >>
> >> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
> >>
> >> Do you know what is the next step plan for this patch?
> >>
> >> Should we do even more?
> >>
> >> From another point of view, I still think that we can use falling back
> >> to reclaim as the last resort to avoid OOM in some special situations,
> >> for example, most pages in the lowest tier node are mlock() or too hot
> >> to be reclaimed.
> >
> > If they're hotter than reclaim candidates on the toptier, shouldn't
> > they get promoted instead and make room that way? We may have to tweak
> > the watermark logic a bit to facilitate that (allow promotions where
> > regular allocations already fail?). But this sort of resorting would
> > be preferable to age inversions.
>
> Now it's legal to enable demotion and disable promotion.  Yes, this is
> wrong configuration in general.  But should we trigger OOM for these
> users?
>
> And now promotion only works for default NUMA policy (and MPOL_BIND to
> both promotion source and target nodes with MPOL_F_NUMA_BALANCING).  If
> we use some other NUMA policy, the pages cannot be promoted too.
>
> > The mlock scenario sounds possible. In that case, it wouldn't be an
> > aging inversion, since there is nothing colder on the CXL node.
> >
> > Maybe a bypass check should explicitly consult the demotion target
> > watermarks against its evictable pages (similar to the file_is_tiny
> > check in prepare_scan_count)?
>
> Yes.  This sounds doable.
>
> > Because in any other scenario, if there is a bug in the promo/demo
> > coordination, I think we'd rather have the OOM than deal with age
> > inversions causing intermittent performance issues that are incredibly
> > hard to track down.
>
> Previously, I thought that people will always prefer performance
> regression than OOM.  Apparently, I am wrong.
>
> Anyway, I think that we need to reduce the possibility of OOM or falling
> back to reclaim as much as possible firstly.  Do you agree?
>

I've been discussing this with a few folks here. I think FWIW general
feeling here is that demoting from top tier nodes is preferred, except
in extreme circumstances we would indeed like to run with a
performance issue rather than OOM a customer VM. I wonder if there is
another way to debug mis-tiered pages rather than trigger an oom to
debug.

One thing I think/hope we can trivially agree on is that proactive
reclaim/demotion is _not_ an extreme circumstance. I would like me or
someone from the team to follow up with a patch that disables fallback
to reclaim on proactive reclaim/demotion (sc->proactive).

> One possibility, can we fall back to reclaim only if the sc->priority is
> small enough (even 0)?
>

This makes sense to me.

> Best Regards,
> Huang, Ying
>
