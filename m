Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101E063C662
	for <lists+cgroups@lfdr.de>; Tue, 29 Nov 2022 18:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiK2R1s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Nov 2022 12:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiK2R1s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Nov 2022 12:27:48 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD64A453;
        Tue, 29 Nov 2022 09:27:46 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y17so6201030plp.3;
        Tue, 29 Nov 2022 09:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+nfXkLtHcbcHqvlWMT2FI5FkLy2T405brGAlDCc79rA=;
        b=kwu9geb/XZrQHY0mZJErmlKtIQ1zOENfXRBtEsAUufzgum2upmjcwtB5SuDbE5MEqv
         gIJVuG8Xm/LtmOahWY3XHgaqoGISeAWqhhypDjedtMMohjCVvXj0I5QyAKoqHmDfIiiX
         03x8iFaG1ZSPKfaGUmNiTMI4tTgC0afMbjRRvKcuuhV+6WCzkCahw2bxP1paRF+LjqEz
         2nk0o6nnd5T8UDdrZxQpo5+C9z1BATxOHdUGTM1tN5mMTstUnIjVnk9SqmdwUTAB/ufl
         mDe8257BkwTPA9lRa+GLqPonhEcZcBsiKZ+q3G7zjC8htvhg2dPI68Pkfy2Et8yYV3Uo
         n4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+nfXkLtHcbcHqvlWMT2FI5FkLy2T405brGAlDCc79rA=;
        b=ECkD/GDcXKvXB8xFs5ioxz36Qx6MlK1Jk3aFfO3dmgYODMv7ebcEL6RrXbGGuqGFsg
         MDGvUpb08e90o2VZxHRr9Fyr/xvewRFXHl3PvM6hGZlfD7E6vF8i+jCjhNMRKmzonX52
         l47Y5FpzOQo0WXlmBr6YhFPCrS6v5wrnPKQhCEqmcBig7ex7JnvzIeYtLur3k98GwBKc
         1WczloCPKq1VZ5hsFQjEvvl9VkQ9OEY65LbyPpLmi9joXmK7OybmwZfPtCya+bhVoydj
         MCCb0aY7k3Cgk9fbWr0mo4OQMc/DV2xSvlUkPA6ZIxRsXTtHiMmXXg0w+Dj48PjHWTCZ
         vsbw==
X-Gm-Message-State: ANoB5pnFqHxh3Ef+gTsUGp90dv+dcdRdaP7pIu1NbvaGC/Btads5GzId
        JR1m9+gfrnnSpvWMUaSpl2P4y/JWEIhFEcKzBkE=
X-Google-Smtp-Source: AA0mqf4zImlMiKjDrqJUkHXvzwMr9YMxo5+Qm2bctCGa3Qitgn/8MiJFhpHDGX4PZpJCIavmpsN2ckIwpQHV1Mbh3+E=
X-Received: by 2002:a17:903:22c4:b0:184:cb7e:ba36 with SMTP id
 y4-20020a17090322c400b00184cb7eba36mr37721305plg.57.1669742865590; Tue, 29
 Nov 2022 09:27:45 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org> <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkrmxyzH4R7a9sJQavrUyKCEiNYeA543+sdJLsgRPrwBwQ@mail.gmail.com> <87a64ad1iz.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a64ad1iz.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 29 Nov 2022 09:27:33 -0800
Message-ID: <CAHbLzkpVZf-3K0Ys8HG8x6D_XpPChB-H2XMYar7UwnNDeMiw8w@mail.gmail.com>
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Mina Almasry <almasrymina@google.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 28, 2022 at 4:54 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Wed, Nov 23, 2022 at 9:52 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Hi, Johannes,
> >>
> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> [...]
> >> >
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
> >
> > For the ideal case, I do agree with Johannes to demote the page tier
> > by tier rather than reclaiming them from the higher tiers. But I also
> > agree with your premature OOM concern.
> >
> >>
> >> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
> >>
> >> Do you know what is the next step plan for this patch?
> >>
> >> Should we do even more?
> >
> > In my initial implementation I implemented a simple throttle logic
> > when the demotion is not going to succeed if the demotion target has
> > not enough free memory (just check the watermark) to make migration
> > succeed without doing any reclamation. Shall we resurrect that?
>
> Can you share the link to your throttle patch?  Or paste it here?

I just found this on the mailing list.
https://lore.kernel.org/linux-mm/1560468577-101178-8-git-send-email-yang.shi@linux.alibaba.com/

But it didn't have the throttling logic, I may not submit that version
to the mailing list since we decided to drop this and merge mine and
Dave's.

Anyway it is not hard to add the throttling logic, we already have a
few throttling cases in vmscan, for example, "mm/vmscan: throttle
reclaim until some writeback completes if congested".
>
> > Waking kswapd sooner is fine to me, but it may be not enough, for
> > example, the kswapd may not keep up so remature OOM may happen on
> > higher tiers or reclaim may still happen. I think throttling the
> > reclaimer/demoter until kswapd makes progress could avoid both. And
> > since the lower tiers memory typically is quite larger than the higher
> > tiers, so the throttle should happen very rarely IMHO.
> >
> >>
> >> From another point of view, I still think that we can use falling back
> >> to reclaim as the last resort to avoid OOM in some special situations,
> >> for example, most pages in the lowest tier node are mlock() or too hot
> >> to be reclaimed.
> >>
> >> > So I'm hesitant to design cgroup controls around the current behavior.
>
> Best Regards,
> Huang, Ying
