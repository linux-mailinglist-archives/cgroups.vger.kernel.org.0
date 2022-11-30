Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E591363DFAF
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 19:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiK3Stk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 13:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiK3St3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 13:49:29 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993031DC5;
        Wed, 30 Nov 2022 10:49:27 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h33so11941042pgm.9;
        Wed, 30 Nov 2022 10:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IJBORR57XCU3YHwAEY1sBiHydghPuO3AB7bOwtnJSV8=;
        b=Zyy7efYIFmdVY592UdgrRWz6tkO7F/h5RFzDEb2dVN3gEw9KR4hW6FdfyhjFooNMzP
         gRK0YI7BDJP6ICqBl3fh98vl3mbY5/ohe7zzTmTJ0XHHC6tqSzfEIQ9+nPLuWVFmMB+r
         YjucT7t4eeCjOUx1TWXtKrgKxsyoun/UcBgxMUGBYx01GZgznBIFlbtzU5wl8/0gMLzQ
         Zr8AiL1aloLFsDzXJFedaAXu1I9Hylzsrc9VZa+gvTplZuECajIaW/2vS5wHls7tYosj
         cy3TcQL7gUEGdV5yI5HMC4bKGVxk+X/Rk19i4eL5P3tOtM7ZSVzGf3URlta2IHYMH6n1
         qPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJBORR57XCU3YHwAEY1sBiHydghPuO3AB7bOwtnJSV8=;
        b=3HIxqek/0ehonjwfS+8tUybxaKu05l25ktXFyxWV3L6oQcdMvh5F14JN8bn1912bhe
         P65NMTc9a0hmOafssQyQ//y7/1JAiPIWIWFPnwAhPgNrikFbJMde40UpIXAAP/f54Ie/
         iL17m071tschUfd/SjHvgLBKau7vsXtGD64ThBkln2qK5EnyfJy2CDqPQu4ccJCEm9Bx
         t4eto+nTUhUuSCYeDH3aRzi/DDl7SVbqm89484DWjmvuvftLd0XRDrKINcxrK5VUYqKx
         fPEGhcgUuYN4TBTEwgkuqdqR8sZM6AAOOnhiW9wspIOW0oPiK1s4WTiQUkgtouGTakhp
         g9OQ==
X-Gm-Message-State: ANoB5pkDRCXSoJO3PnU4FfiMQuWeXrFG22mgPY+Sr6fW3rDVOhVXao61
        Dd0snV6/xnuzVcyvx1de19VnCzwsaoCY5GB+h9I=
X-Google-Smtp-Source: AA0mqf73a+OFuwlwmC4zJLeQAZuXio6JeHRzVbI8mKEOkeMfP9QQgUTmZ3bJJZuN6Vm+YVbr69x9Q6JyEyaC65Z0AWA=
X-Received: by 2002:a05:6a00:1696:b0:53e:6656:d829 with SMTP id
 k22-20020a056a00169600b0053e6656d829mr65746088pfc.63.1669834167390; Wed, 30
 Nov 2022 10:49:27 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org> <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkrmxyzH4R7a9sJQavrUyKCEiNYeA543+sdJLsgRPrwBwQ@mail.gmail.com>
 <87a64ad1iz.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHbLzkpVZf-3K0Ys8HG8x6D_XpPChB-H2XMYar7UwnNDeMiw8w@mail.gmail.com>
 <87ilixatyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ilixatyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 30 Nov 2022 10:49:15 -0800
Message-ID: <CAHbLzkr_njh2xtAf6RME_Fe0TgTKdC4mcsUe24orqVScjibUrA@mail.gmail.com>
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

On Tue, Nov 29, 2022 at 9:33 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Mon, Nov 28, 2022 at 4:54 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Yang Shi <shy828301@gmail.com> writes:
> >>
> >> > On Wed, Nov 23, 2022 at 9:52 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> Hi, Johannes,
> >> >>
> >> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> >> [...]
> >> >> >
> >> >> > The fallback to reclaim actually strikes me as wrong.
> >> >> >
> >> >> > Think of reclaim as 'demoting' the pages to the storage tier. If we
> >> >> > have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
> >> >> > CXL and from CXL to storage. If we reclaim a page from RAM, it means
> >> >> > we 'demote' it directly from RAM to storage, bypassing potentially a
> >> >> > huge amount of pages colder than it in CXL. That doesn't seem right.
> >> >> >
> >> >> > If demotion fails, IMO it shouldn't satisfy the reclaim request by
> >> >> > breaking the layering. Rather it should deflect that pressure to the
> >> >> > lower layers to make room. This makes sure we maintain an aging
> >> >> > pipeline that honors the memory tier hierarchy.
> >> >>
> >> >> Yes.  I think that we should avoid to fall back to reclaim as much as
> >> >> possible too.  Now, when we allocate memory for demotion
> >> >> (alloc_demote_page()), __GFP_KSWAPD_RECLAIM is used.  So, we will trigger
> >> >> kswapd reclaim on lower tier node to free some memory to avoid fall back
> >> >> to reclaim on current (higher tier) node.  This may be not good enough,
> >> >> for example, the following patch from Hasan may help via waking up
> >> >> kswapd earlier.
> >> >
> >> > For the ideal case, I do agree with Johannes to demote the page tier
> >> > by tier rather than reclaiming them from the higher tiers. But I also
> >> > agree with your premature OOM concern.
> >> >
> >> >>
> >> >> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
> >> >>
> >> >> Do you know what is the next step plan for this patch?
> >> >>
> >> >> Should we do even more?
> >> >
> >> > In my initial implementation I implemented a simple throttle logic
> >> > when the demotion is not going to succeed if the demotion target has
> >> > not enough free memory (just check the watermark) to make migration
> >> > succeed without doing any reclamation. Shall we resurrect that?
> >>
> >> Can you share the link to your throttle patch?  Or paste it here?
> >
> > I just found this on the mailing list.
> > https://lore.kernel.org/linux-mm/1560468577-101178-8-git-send-email-yang.shi@linux.alibaba.com/
>
> Per my understanding, this patch will avoid demoting if there's no free
> space on demotion target?  If so, I think that we should trigger kswapd
> reclaiming on demotion target before that.  And we can simply avoid to
> fall back to reclaim firstly, then avoid to scan as an improvement as
> that in your patch above.

Yes, it should. The rough idea looks like:

if (the demote target is contended)
    wake up kswapd
    reclaim_throttle(VMSCAN_THROTTLE_DEMOTION)
    retry demotion

The kswapd is responsible for clearing the contention flag.

>
> Best Regards,
> Huang, Ying
>
> > But it didn't have the throttling logic, I may not submit that version
> > to the mailing list since we decided to drop this and merge mine and
> > Dave's.
> >
> > Anyway it is not hard to add the throttling logic, we already have a
> > few throttling cases in vmscan, for example, "mm/vmscan: throttle
> > reclaim until some writeback completes if congested".
> >>
> >> > Waking kswapd sooner is fine to me, but it may be not enough, for
> >> > example, the kswapd may not keep up so remature OOM may happen on
> >> > higher tiers or reclaim may still happen. I think throttling the
> >> > reclaimer/demoter until kswapd makes progress could avoid both. And
> >> > since the lower tiers memory typically is quite larger than the higher
> >> > tiers, so the throttle should happen very rarely IMHO.
> >> >
> >> >>
> >> >> From another point of view, I still think that we can use falling back
> >> >> to reclaim as the last resort to avoid OOM in some special situations,
> >> >> for example, most pages in the lowest tier node are mlock() or too hot
> >> >> to be reclaimed.
> >> >>
> >> >> > So I'm hesitant to design cgroup controls around the current behavior.
> >>
> >> Best Regards,
> >> Huang, Ying
