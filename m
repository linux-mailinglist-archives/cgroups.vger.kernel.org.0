Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161CF636D3D
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 23:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKWWhS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 17:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKWWhR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 17:37:17 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3915F28B
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 14:37:16 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id v128so4303368vsb.13
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 14:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dWg4CPBS1rHon+H83SkA4H14sLH1o04yGoKobBsvf5w=;
        b=Joz6LLphsQFnzqMzE4EJRbSIxf04MbkPtcfl1yd2mTjwLfuf81a5HnRued3BN/uBBD
         0FWJFMBhdek23e6wLn5uNHNdPLmb5CBF2HQgUyGr0xvZyQtuKOMzAWMMLRMGTEwhIr7R
         zqwu1u5FxN5GLmL9OUnnb6ZTffbaJJZnTV3BljIfjPBMfEYFJyS52V4+FwxGaGDoo+HG
         jXPIUo83qe2S5+nBg7r7+ptiu7GOP+OHiocf/XkDpJVhoNn4T7FLqHMl08ahlqL29W/9
         Z59/0l3nS7xdfcY25FrzRzByxPMS5qrxvHqzJYAmK0YkEIN90C7gcaIRqLUYEBrKrmPh
         C3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWg4CPBS1rHon+H83SkA4H14sLH1o04yGoKobBsvf5w=;
        b=DrTRvT9bxVjN6ulI5ogaHFhmPpb0blhnsgy+X6QvQBU1O2qnji6zRFLZpDlEi/vwlD
         5OVK/esM/HZov2ivbkWrWeb0uTOuwBweK//jVW61+CXklcdyplxF9S+8XdWmokt3IQSJ
         yofzijntY8GfdRpwcD+cWzqJ8tG55MBxt/JJP4fXO5XdY3q52yiaNNwifXRSF0mooFlf
         UBJEmBeN1LcrPrL5d42H3JuExIRdWMk6M/HUvxBH7kIn+CwO07KP0noLnlLuV9PQbyOl
         NwO1hUWmYNolztYndCA+BfqqMQja5Gz4R1yHqRpLGOBGvfjEolYb4knima4PAm9+tcf3
         p/1g==
X-Gm-Message-State: ANoB5pm9FimIak+nqkBKtZuFaE8KW7XHUruosb5u0GtRY9Y2tH16H4lZ
        FbOWOCNvtyoRTN5m6Hm9cI0qQR779U0GpfpqgPfPWw==
X-Google-Smtp-Source: AA0mqf4phBfqh4Fj7+uZdO4AuzHjDowKnNnPoPbZHlOwQOAlLz8bxwIb+0/5pStBLISuOqdq5zddxDrQbR5u/4dJS4E=
X-Received: by 2002:a05:6102:54a5:b0:3b0:7462:a88c with SMTP id
 bk37-20020a05610254a500b003b07462a88cmr2101038vsb.49.1669243035410; Wed, 23
 Nov 2022 14:37:15 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <Y36XchdgTCsMP4jT@cmpxchg.org>
In-Reply-To: <Y36XchdgTCsMP4jT@cmpxchg.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 23 Nov 2022 14:37:04 -0800
Message-ID: <CAHS8izNoWM_oSdntpacFaEyVrXfX5YrzAWtMGvU6j_pAVNsvtA@mail.gmail.com>
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Huang Ying <ying.huang@intel.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 1:57 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Nov 23, 2022 at 01:20:57PM -0800, Mina Almasry wrote:
> > On Wed, Nov 23, 2022 at 10:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Hello Mina,
> > >
> > > On Tue, Nov 22, 2022 at 12:38:45PM -0800, Mina Almasry wrote:
> > > > Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > > reclaim""), the proactive reclaim interface memory.reclaim does both
> > > > reclaim and demotion. This is likely fine for us for latency critical
> > > > jobs where we would want to disable proactive reclaim entirely, and is
> > > > also fine for latency tolerant jobs where we would like to both
> > > > proactively reclaim and demote.
> > > >
> > > > However, for some latency tiers in the middle we would like to demote but
> > > > not reclaim. This is because reclaim and demotion incur different latency
> > > > costs to the jobs in the cgroup. Demoted memory would still be addressable
> > > > by the userspace at a higher latency, but reclaimed memory would need to
> > > > incur a pagefault.
> > > >
> > > > To address this, I propose having reclaim-only and demotion-only
> > > > mechanisms in the kernel. There are a couple possible
> > > > interfaces to carry this out I considered:
> > > >
> > > > 1. Disable demotion in the memory.reclaim interface and add a new
> > > >    demotion interface (memory.demote).
> > > > 2. Extend memory.reclaim with a "demote=<int>" flag to configure the demotion
> > > >    behavior in the kernel like so:
> > > >       - demote=0 would disable demotion from this call.
> > > >       - demote=1 would allow the kernel to demote if it desires.
> > > >       - demote=2 would only demote if possible but not attempt any
> > > >         other form of reclaim.
> > >
> > > Unfortunately, our proactive reclaim stack currently relies on
> > > memory.reclaim doing both. It may not stay like that, but I'm a bit
> > > wary of changing user-visible semantics post-facto.
> > >
> > > In patch 2, you're adding a node interface to memory.demote. Can you
> > > add this to memory.reclaim instead? This would allow you to control
> > > demotion and reclaim independently as you please: if you call it on a
> > > node with demotion targets, it will demote; if you call it on a node
> > > without one, it'll reclaim. And current users will remain unaffected.
> >
> > Hello Johannes, thanks for taking a look!
> >
> > I can certainly add the "nodes=" arg to memory.reclaim and you're
> > right, that would help in bridging the gap. However, if I understand
> > the underlying code correctly, with only the nodes= arg the kernel
> > will indeed attempt demotion first, but the kernel will also merrily
> > fall back to reclaiming if it can't demote the full amount. I had
> > hoped to have the flexibility to protect latency sensitive jobs from
> > reclaim entirely while attempting to do demotion.
>
> The fallback to reclaim actually strikes me as wrong.
>
> Think of reclaim as 'demoting' the pages to the storage tier. If we
> have a RAM -> CXL -> storage hierarchy, we should demote from RAM to
> CXL and from CXL to storage. If we reclaim a page from RAM, it means
> we 'demote' it directly from RAM to storage, bypassing potentially a
> huge amount of pages colder than it in CXL. That doesn't seem right.
>

Ah, I see. When you put it like that it makes a lot of sense. Reclaim
would be just another type of demotion as you put it, i.e. demoting
from the lowest memory tier to storage. I assume in your model
demoting from the lowest memory tier to storage includes all of
swapping, writing back of dirty pages, and discarding clean file
pages. All these pages (anon, clean file pages, or dirty file pages)
should first be demoted down the memory tiers until finally they get
'demoted' to storage. i.e. reclaimed.

> If demotion fails, IMO it shouldn't satisfy the reclaim request by
> breaking the layering. Rather it should deflect that pressure to the
> lower layers to make room. This makes sure we maintain an aging
> pipeline that honors the memory tier hierarchy.
>

Also got it. I believe the pseudo code would be roughly like a bubble
sort algorithm of sorts, where the coldest pages are demoted to the
next memory tier, and finally reclaimed from the final memory tier:

demoted_pages = 0;
retry:
    memory_tier = lowest_tier:
    for (; memory_tier < 0; memory_tier--) {
        if (memory_tier == lowest_tier)
            demoted_pages += demote_to_storage();
        else
            demote_pages += demote_to_the_next_memory_tier(memory_tier);
    }
    if (demoted_pages < pages_to_demote)
         goto retry;

> So I'm hesitant to design cgroup controls around the current behavior.
>

Thanks for taking the time to explain this. I think if it sounds good
to folks I'll add the "nodes=" arg as you described now. Reworking the
reclaim algorithm for memory tiering would be a bigger change in need
of its own patchset.

I think the nodes= arg by itself would help bridge the gap quite a
bit. I surmise for Google we can :
1. Force reclaim by: echo "<size> nodes=<lowest memory tier nodes>" >
memory.reclaim
2. Almost force demotion by: echo "<size> nodes=<highest memory tier
nodes>" > memory.reclaim

In case #2 the kernel may still reclaim it if it can't demote the full
amount, but that is as you put it more of a bug that should be fixed.

However, even in a world where the reclaim code works as you
described, I wonder if we still need some kind of demote= arg. The
issue is that demoting from the lowest memory tier to storage incurs
more of a latency impact to the application than demoting between the
other memory tiers, and that's because the other memory tiers are
directly addressable, while pages demote to storage incur a pagefault.
Not sure if that's a big concern at the moment.

> > The above is just one angle of the issue. Another angle (which Yosry
> > would care most about I think) is that at Google we call
> > memory.reclaim mainly when memory.current is too close to memory.max
> > and we expect the memory usage of the cgroup to drop as a result of a
> > success memory.reclaim call. I suspect once we take in commit
> > 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg reclaim""),
> > we would run into that regression, but I defer to Yosry here, he may
> > have a solution for that in mind already.
>
> IMO it should both demote and reclaim. Simliar to how memory.reclaim
> on a non-tiered memory system would both deactivate active pages and
> reclaim inactive pages.
