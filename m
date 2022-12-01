Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9463FACE
	for <lists+cgroups@lfdr.de>; Thu,  1 Dec 2022 23:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiLAWpv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Dec 2022 17:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiLAWpt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Dec 2022 17:45:49 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4AE65FF;
        Thu,  1 Dec 2022 14:45:48 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 62so2881256pgb.13;
        Thu, 01 Dec 2022 14:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mz67COhiP2LIOSR/RjOjcqP515AruE68ATdaRH6nni8=;
        b=Oxk08d7LgKIO11W2YXoWDp6N77NPHo4awIEjlThe1KatRgbufsRdv1EOloK/sIsqzO
         jvIWN4M6ORdZmL0nk+OVwMmcad0Rll39eegzg+hXKs3DWJCwiwRC7Apml/RQX9mnbhQT
         YQ0yY1ACQDY5J6Qp3qijLh/GR5Z66lQgq3jen0fIAefZ7/Llw+nG5ln/hG4Qf/6o9fPn
         ieT9ql1qAQeNzDPTf0hDy2ZQ+pfV340gYX3gej01B1a+ivcoxfZTSovz4uWzOgnYiX5/
         FC9ENBqRNG1JLaU/biOmKGDMFqd24XHZ03OEhFC1SGTm8vhxWO1mYO5Evicn9TAUY+eO
         2uIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mz67COhiP2LIOSR/RjOjcqP515AruE68ATdaRH6nni8=;
        b=MzOQfE6skP0plyUjZ9FqyyMPzSStLuajjpSXec787EoyXFQuj0Rbr8wz5u7vW1ZV9n
         AIoWx3X7sanvoASx19+dMgQgRRb2qIbOuncMQG/SVbYzJY3H5+SQYlWY/41bQLj0Bmc8
         4isw2nDRVI47NJFRpilFt3VaNLZ38/m1LL+6mfmVy+ntqK00wnmyRaKpPKN4RWZX01ip
         vSs198QpioRX+kyERWOp4bhytRya0Eonql5k2uFghHPbeCYBYDQAjW1loCW3Z6u5lEb/
         Dp+p7T3OqeCTZHfPWR0ZbfTnWmQqSqbRHPaz/C399uLOphPTl2AxEEXQ1AOXnHDQsk0x
         AFxA==
X-Gm-Message-State: ANoB5pnL/EdO0pm8eDC+Gm5huVoSRcGmMfP9w4DuPhcdarWnkTlKpgNr
        ihzJkbJec+tsGHZsxLQaO+Om6UOHb2dqGzKgwpY=
X-Google-Smtp-Source: AA0mqf44AXvVEUJV0E8tjOZWmdq5g2PebFd55FpDXlWOKp5M3htocvHLrqDql5SJAScaZGwcfDBNydfMw3AH9ZFYC/s=
X-Received: by 2002:a63:105c:0:b0:46f:f72c:cdae with SMTP id
 28-20020a63105c000000b0046ff72ccdaemr44554126pgq.237.1669934748081; Thu, 01
 Dec 2022 14:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org> <874juonbmv.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAHbLzkrmxyzH4R7a9sJQavrUyKCEiNYeA543+sdJLsgRPrwBwQ@mail.gmail.com>
 <87a64ad1iz.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHbLzkpVZf-3K0Ys8HG8x6D_XpPChB-H2XMYar7UwnNDeMiw8w@mail.gmail.com>
 <87ilixatyw.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAHbLzkr_njh2xtAf6RME_Fe0TgTKdC4mcsUe24orqVScjibUrA@mail.gmail.com>
 <87h6yfao37.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87h6yfao37.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Dec 2022 14:45:36 -0800
Message-ID: <CAHbLzkr9k8fvBGVskN1sMJiLX_JkWW7OrrscUrA0xASh+rYN7Q@mail.gmail.com>
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

On Wed, Nov 30, 2022 at 5:52 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Tue, Nov 29, 2022 at 9:33 PM Huang, Ying <ying.huang@intel.com> wrote:
> >>
> >> Yang Shi <shy828301@gmail.com> writes:
> >>
> >> > On Mon, Nov 28, 2022 at 4:54 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >>
> >> >> Yang Shi <shy828301@gmail.com> writes:
> >> >>
> >> >> > On Wed, Nov 23, 2022 at 9:52 PM Huang, Ying <ying.huang@intel.com> wrote:
> >> >> >>
> >> >> >> Hi, Johannes,
> >> >> >>
> >> >> >> Johannes Weiner <hannes@cmpxchg.org> writes:
> >> >> >> [...]
> >> >> >> >
> >> >> >> > The fallback to reclaim actually strikes me as wrong.
> >> >> >> >
> >> >> >> > Think of reclaim as 'demoting' the pages to the storage tier. If we
> >> >> >> > have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
> >> >> >> > CXL and from CXL to storage. If we reclaim a page from RAM, it means
> >> >> >> > we 'demote' it directly from RAM to storage, bypassing potentially a
> >> >> >> > huge amount of pages colder than it in CXL. That doesn't seem right.
> >> >> >> >
> >> >> >> > If demotion fails, IMO it shouldn't satisfy the reclaim request by
> >> >> >> > breaking the layering. Rather it should deflect that pressure to the
> >> >> >> > lower layers to make room. This makes sure we maintain an aging
> >> >> >> > pipeline that honors the memory tier hierarchy.
> >> >> >>
> >> >> >> Yes.  I think that we should avoid to fall back to reclaim as much as
> >> >> >> possible too.  Now, when we allocate memory for demotion
> >> >> >> (alloc_demote_page()), __GFP_KSWAPD_RECLAIM is used.  So, we will trigger
> >> >> >> kswapd reclaim on lower tier node to free some memory to avoid fall back
> >> >> >> to reclaim on current (higher tier) node.  This may be not good enough,
> >> >> >> for example, the following patch from Hasan may help via waking up
> >> >> >> kswapd earlier.
> >> >> >
> >> >> > For the ideal case, I do agree with Johannes to demote the page tier
> >> >> > by tier rather than reclaiming them from the higher tiers. But I also
> >> >> > agree with your premature OOM concern.
> >> >> >
> >> >> >>
> >> >> >> https://lore.kernel.org/linux-mm/b45b9bf7cd3e21bca61d82dcd1eb692cd32c122c.1637778851.git.hasanalmaruf@fb.com/
> >> >> >>
> >> >> >> Do you know what is the next step plan for this patch?
> >> >> >>
> >> >> >> Should we do even more?
> >> >> >
> >> >> > In my initial implementation I implemented a simple throttle logic
> >> >> > when the demotion is not going to succeed if the demotion target has
> >> >> > not enough free memory (just check the watermark) to make migration
> >> >> > succeed without doing any reclamation. Shall we resurrect that?
> >> >>
> >> >> Can you share the link to your throttle patch?  Or paste it here?
> >> >
> >> > I just found this on the mailing list.
> >> > https://lore.kernel.org/linux-mm/1560468577-101178-8-git-send-email-yang.shi@linux.alibaba.com/
> >>
> >> Per my understanding, this patch will avoid demoting if there's no free
> >> space on demotion target?  If so, I think that we should trigger kswapd
> >> reclaiming on demotion target before that.  And we can simply avoid to
> >> fall back to reclaim firstly, then avoid to scan as an improvement as
> >> that in your patch above.
> >
> > Yes, it should. The rough idea looks like:
> >
> > if (the demote target is contended)
> >     wake up kswapd
> >     reclaim_throttle(VMSCAN_THROTTLE_DEMOTION)
> >     retry demotion
> >
> > The kswapd is responsible for clearing the contention flag.
>
> We may do this, at least for demotion in kswapd.  But I think that this
> could be the second step optimization after we make correct choice
> between demotion/reclaim.  What if the pages in demotion target is too
> hot to be reclaimed first?  Should we reclaim in fast memory node to
> avoid OOM?

IMHO we can't avoid reclaiming from the fast nodes entirely if we
prioritize avoiding OOMs. But it should happen very very rarely with
the throttling logic or other methods. BTW did you run any test to see
how many times vmscan reclaims from fast nodes instead of demotion
with the current implementation for some typical workloads?

>
> Best Regards,
> Huang, Ying
>
> >>
> >> > But it didn't have the throttling logic, I may not submit that version
> >> > to the mailing list since we decided to drop this and merge mine and
> >> > Dave's.
> >> >
> >> > Anyway it is not hard to add the throttling logic, we already have a
> >> > few throttling cases in vmscan, for example, "mm/vmscan: throttle
> >> > reclaim until some writeback completes if congested".
> >> >>
> >> >> > Waking kswapd sooner is fine to me, but it may be not enough, for
> >> >> > example, the kswapd may not keep up so remature OOM may happen on
> >> >> > higher tiers or reclaim may still happen. I think throttling the
> >> >> > reclaimer/demoter until kswapd makes progress could avoid both. And
> >> >> > since the lower tiers memory typically is quite larger than the higher
> >> >> > tiers, so the throttle should happen very rarely IMHO.
> >> >> >
> >> >> >>
> >> >> >> From another point of view, I still think that we can use falling back
> >> >> >> to reclaim as the last resort to avoid OOM in some special situations,
> >> >> >> for example, most pages in the lowest tier node are mlock() or too hot
> >> >> >> to be reclaimed.
> >> >> >>
> >> >> >> > So I'm hesitant to design cgroup controls around the current behavior.
> >> >>
> >> >> Best Regards,
> >> >> Huang, Ying
