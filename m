Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC62636E8C
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 00:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKWXse (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 18:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKWXsd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 18:48:33 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAC679E10
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 15:48:32 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id b2so212066iof.12
        for <cgroups@vger.kernel.org>; Wed, 23 Nov 2022 15:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=We3Y4AOZ212dC6RjyR8844fCrDkxjUuq7q5okkncMT8=;
        b=D3A4jBtc/8G4S2epmN4p4OBwn93F+sxWYPAoCVbH/9mMsTOa3iNam1TtPGm/mDMZqw
         qycXacXDoml97DjlmC/gx5ZecVJyzeEZqJC0UhjN4h7m3dd2Pw3PH2Z/BhD1EfjDHSw0
         /py9dp1lT1Lss7qS0ktvB5GO79cSzYxJNB22atbGbjS3/mSs3aga4jNzTp1XgcCwf5BB
         NMLH0au3WHG6WLbgiYYvOvIXbmWf4YFFHqSlbERVV8IWj++EORDDiK0RAevn4EywEG5W
         dmgDpYpIXg1kRUUoOyUNv/9VjvNwq26+nmylbg08OlADp1vrPqk45OuVdg3uq9DJ/UaQ
         T3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=We3Y4AOZ212dC6RjyR8844fCrDkxjUuq7q5okkncMT8=;
        b=mr/iZ0kDqf21BlzTW1MneN4HR/FJR6OhUYXvZgUESt79BeXUHGIsE9QoA3XMvYrRFi
         9+mZMlOdg6yx2PmSxI8aQv64hGnQKNtqeoKG+SXint+iW4MdVahOvpBHkgn1UQljxlAy
         ckNY8X5MpvE3skuGqaoGwZxjkMlHM8r/25yStWlRblIdhmV7n3jTMsuAZaG0IMZeM+I0
         +zb5bxtotxAlaapEeGp1rhJBijNpsPvKZLBYHPHyUDXCKFgvnjBs4DaY32Y9CITi+Sa7
         zATWp/4ZiqFQ+hStRDou4syfAka+/FZLMYykuMuxS3J0qwEPdgeHOdFH3SAMMy8NvFWI
         UufA==
X-Gm-Message-State: ANoB5plMXUzG8JSq59kS25nqXp16iWDke/WexSt0cg1JSQiY7h9T6x9+
        8Ew3vz1yy+iX4qWalbT7CYmqajBZF44lYM8gw1T3/g==
X-Google-Smtp-Source: AA0mqf6cu00HOcBKiFT/xHdbnsOmjtvrb2UAlsBmrJV/4rxn1+hPuVpAckuQ+0yGBIh7KmtbvZhOCDO+KrstkTGNG7U=
X-Received: by 2002:a6b:4409:0:b0:6de:bd7d:ee08 with SMTP id
 r9-20020a6b4409000000b006debd7dee08mr5396357ioa.0.1669247311479; Wed, 23 Nov
 2022 15:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20221122203850.2765015-1-almasrymina@google.com>
 <Y35fw2JSAeAddONg@cmpxchg.org> <CAHS8izN+xqM67XLT4y5qyYnGQMUWRQCJrdvf2gjTHd8nZ_=0sw@mail.gmail.com>
 <CAJD7tkZNW=u1TD-Fd_3RuzRNtaFjxihbGm0836QHkdp0Nn-vyQ@mail.gmail.com> <Y36fIGFCFKiocAd6@cmpxchg.org>
In-Reply-To: <Y36fIGFCFKiocAd6@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Nov 2022 15:47:55 -0800
Message-ID: <CAJD7tkZ_tz-JNEvGS3fOhHohuoHaKj_8FzpGRDSP2vhhAc+Pmg@mail.gmail.com>
Subject: Re: [RFC PATCH V1] mm: Disable demotion from proactive reclaim
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mina Almasry <almasrymina@google.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
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

On Wed, Nov 23, 2022 at 2:30 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Nov 23, 2022 at 01:35:13PM -0800, Yosry Ahmed wrote:
> > On Wed, Nov 23, 2022 at 1:21 PM Mina Almasry <almasrymina@google.com> wrote:
> > >
> > > On Wed, Nov 23, 2022 at 10:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > Hello Mina,
> > > >
> > > > On Tue, Nov 22, 2022 at 12:38:45PM -0800, Mina Almasry wrote:
> > > > > Since commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > > > > reclaim""), the proactive reclaim interface memory.reclaim does both
> > > > > reclaim and demotion. This is likely fine for us for latency critical
> > > > > jobs where we would want to disable proactive reclaim entirely, and is
> > > > > also fine for latency tolerant jobs where we would like to both
> > > > > proactively reclaim and demote.
> > > > >
> > > > > However, for some latency tiers in the middle we would like to demote but
> > > > > not reclaim. This is because reclaim and demotion incur different latency
> > > > > costs to the jobs in the cgroup. Demoted memory would still be addressable
> > > > > by the userspace at a higher latency, but reclaimed memory would need to
> > > > > incur a pagefault.
> > > > >
> > > > > To address this, I propose having reclaim-only and demotion-only
> > > > > mechanisms in the kernel. There are a couple possible
> > > > > interfaces to carry this out I considered:
> > > > >
> > > > > 1. Disable demotion in the memory.reclaim interface and add a new
> > > > >    demotion interface (memory.demote).
> > > > > 2. Extend memory.reclaim with a "demote=<int>" flag to configure the demotion
> > > > >    behavior in the kernel like so:
> > > > >       - demote=0 would disable demotion from this call.
> > > > >       - demote=1 would allow the kernel to demote if it desires.
> > > > >       - demote=2 would only demote if possible but not attempt any
> > > > >         other form of reclaim.
> > > >
> > > > Unfortunately, our proactive reclaim stack currently relies on
> > > > memory.reclaim doing both. It may not stay like that, but I'm a bit
> > > > wary of changing user-visible semantics post-facto.
> > > >
> > > > In patch 2, you're adding a node interface to memory.demote. Can you
> > > > add this to memory.reclaim instead? This would allow you to control
> > > > demotion and reclaim independently as you please: if you call it on a
> > > > node with demotion targets, it will demote; if you call it on a node
> > > > without one, it'll reclaim. And current users will remain unaffected.
> > >
> > > Hello Johannes, thanks for taking a look!
> > >
> > > I can certainly add the "nodes=" arg to memory.reclaim and you're
> > > right, that would help in bridging the gap. However, if I understand
> > > the underlying code correctly, with only the nodes= arg the kernel
> > > will indeed attempt demotion first, but the kernel will also merrily
> > > fall back to reclaiming if it can't demote the full amount. I had
> > > hoped to have the flexibility to protect latency sensitive jobs from
> > > reclaim entirely while attempting to do demotion.
> > >
> > > There are probably ways to get around that in the userspace. I presume
> > > the userspace can check if there is available memory on the node's
> > > demotion targets, and if so, the kernel should demote-only. But I feel
> > > that wouldn't be reliable as the demotion logic may change across
> > > kernel versions. The userspace may think the kernel would demote but
> > > instead demotion failed due to whatever heuristic introduced into the
> > > new kernel version.
> > >
> > > The above is just one angle of the issue. Another angle (which Yosry
> > > would care most about I think) is that at Google we call
> > > memory.reclaim mainly when memory.current is too close to memory.max
> > > and we expect the memory usage of the cgroup to drop as a result of a
> > > success memory.reclaim call. I suspect once we take in commit
> > > 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg reclaim""),
> > > we would run into that regression, but I defer to Yosry here, he may
> > > have a solution for that in mind already.
> >
> > We don't exactly rely on memory.current, but we do have a separate
> > proactive reclaim policy today from demotion, and we do expect
> > memory.reclaim to reclaim memory and not demote it. So it is important
> > that we can control reclaim vs. demotion separately. Having
> > memory.reclaim do demotions by default is not ideal for our current
> > setup, so at least having a demote= argument to control it (no
> > demotions, may demote, only demote) is needed.
>
> With a nodemask you should be able to only reclaim by specifying
> terminal memory tiers that do that, and leave out higher tiers that
> demote.
>
> That said, it would actually be nice if reclaim policy wouldn't have
> to differ from demotion policy longer term. Ultimately it comes down
> to mapping age to memory tier, right? Such that hot pages are in RAM,
> warm pages are in CXL, cold pages are in storage. If you apply equal
> presure on all tiers, it's access frequency that should determine
> which RAM pages to demote, and which CXL pages to reclaim. If RAM
> pages are hot and refuse demotion, and CXL pages are cold in
> comparison, CXL should clear out. If RAM pages are warm, they should
> get demoted to CXL but not reclaimed further from there (and rotate
> instead).
>
> Do we know what's preventing this from happening today? What's the
> reason you want to control them independently?

The motivation was giving user space more flexibility to design their
policies. However, as you point out, the current behavior of falling
back to reclaiming when we cannot demote is not ideal, and maybe we
should not design policies around it. We can always revisit this if a
use case arises where a clear distinction needs to be drawn between
reclaiming and demotion policies.
