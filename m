Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F111BE091
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2020 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgD2OSB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 10:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726836AbgD2OSA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 10:18:00 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFE7C03C1AD;
        Wed, 29 Apr 2020 07:18:00 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z2so2324766iol.11;
        Wed, 29 Apr 2020 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpXUf/vkO/R5yvacaxjyLtNiC2qft6yapuPXFNqdrtk=;
        b=l8kNMZolNNRTje0ib1VyxH/4hTylfD414hWySHi/Pk5fJDdLTzmXJ+tL4bwZfbBrwe
         x5aQaQIkJtYncgehYFquzLcHki7V2njzUJqCVP9iQ4Zunpp44t4JYWi3j/io5iVnRoMW
         1xmQhmWhiq1P4108Evf5bFjMHPtdpV9v9Eo8PShJ2xq8IAGkmu6K6Y0S8RD5YrFN9b2p
         hK94zWWO+FvBM3q9jwp82O5zwEgl4eGa3nIGqGMoH0cdScve/oMIdgpnQ/+y0515LRFF
         o/6JUz4+Ndj+GUQiqd43ji0ijprsKeJTzaOCV8jQTMhGPObZdjzrM2buPfhN4z6lbB/+
         gOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpXUf/vkO/R5yvacaxjyLtNiC2qft6yapuPXFNqdrtk=;
        b=Fa1m7vJLYT0L+WBssuQjiOOhDgzApzxvYCAZgnWTsTqKETJ9LDgC1QNBPm0pe1TmZg
         +uNUJj65BdGwsG2saL+Sbn+lKHy+S0ANrimPy6oZsIZE+kvOhHJ3imlO7bNuV7SozfRF
         kw2YlqOmhWUC60Ce9LLML2fMjceQsfjYemyIm7LHCRNkL+fhlAi7lFsn/3jX56OqT/S5
         wDzH9+wRh+Vb2xyRUi3a1b7hNReikXKRCmQSQRLBltGkZI8Ibk+gVJZmCnP0C0p7SEI2
         PqN69x1+OL4u1WfqXovB0GhOQMCmp5HhoPEK+jN7+euuetP5dZEnOgb0W+0XBNbjwgKb
         JJzw==
X-Gm-Message-State: AGi0PuZ4hVqZdtoMTU2/TtRaTFQen8wtGIHnhMd4aM9sFy/rGPLqOHGB
        yUXE6DIZxTi0TT1XQz9f/rsQUkwEhFAfOnh5tCY=
X-Google-Smtp-Source: APiQypK82VvXMlKNIqQa1QabCy02RcVqT8OoQ2IeGadn05A3gUPuRWf7A0wd9yYXJiPYRbjYNrz1I2L+gZGWkydziIc=
X-Received: by 2002:a05:6638:31b:: with SMTP id w27mr29082935jap.94.1588169878532;
 Wed, 29 Apr 2020 07:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588092152.git.chris@chrisdown.name> <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz> <20200429140330.GA5054@cmpxchg.org>
In-Reply-To: <20200429140330.GA5054@cmpxchg.org>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 29 Apr 2020 22:17:21 +0800
Message-ID: <CALOAHbCC-oT+CwzyokNfomEMf0GdzpipBeZJjnnE8RrPPZ_Maw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 29, 2020 at 10:03 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Apr 29, 2020 at 12:15:10PM +0200, Michal Hocko wrote:
> > On Tue 28-04-20 19:26:47, Chris Down wrote:
> > > From: Yafang Shao <laoar.shao@gmail.com>
> > >
> > > A cgroup can have both memory protection and a memory limit to isolate
> > > it from its siblings in both directions - for example, to prevent it
> > > from being shrunk below 2G under high pressure from outside, but also
> > > from growing beyond 4G under low pressure.
> > >
> > > Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> > > implemented proportional scan pressure so that multiple siblings in
> > > excess of their protection settings don't get reclaimed equally but
> > > instead in accordance to their unprotected portion.
> > >
> > > During limit reclaim, this proportionality shouldn't apply of course:
> > > there is no competition, all pressure is from within the cgroup and
> > > should be applied as such. Reclaim should operate at full efficiency.
> > >
> > > However, mem_cgroup_protected() never expected anybody to look at the
> > > effective protection values when it indicated that the cgroup is above
> > > its protection. As a result, a query during limit reclaim may return
> > > stale protection values that were calculated by a previous reclaim cycle
> > > in which the cgroup did have siblings.
> > >
> > > When this happens, reclaim is unnecessarily hesitant and potentially
> > > slow to meet the desired limit. In theory this could lead to premature
> > > OOM kills, although it's not obvious this has occurred in practice.
> >
> > Thanks this describes the underlying problem. I would be also explicit
> > that the issue should be visible only on tail memcgs which have both
> > max/high and protection configured and the effect depends on the
> > difference between the two (the smaller it is the largrger the effect).
> >
> > There is no mention about the fix. The patch resets effective values for
> > the reclaim root and I've had some concerns about that
> > http://lkml.kernel.org/r/20200424162103.GK11591@dhcp22.suse.cz.
> > Johannes has argued that other races are possible and I didn't get to
> > think about it thoroughly. But this patch is introducing a new
> > possibility of breaking protection. If we want to have a quick and
> > simple fix that would be easier to backport to older kernels then I
> > would feel much better if we simply workedaround the problem as
> > suggested earlier http://lkml.kernel.org/r/20200423061629.24185-1-laoar.shao@gmail.com
> > We can rework the effective values calculation to be more robust against
> > races on top of that because this is likely a more tricky thing to do.
>
> Well, can you please *do* think more thoroughly about what I wrote,
> instead of pushing for an alternative patch on gut feeling alone?
>
> Especially when you imply that this should be a stable patch.
>
> Not only does your alternative patch not protect against the race you
> are worried about, the race itself doesn't matter. Racing reclaimers
> will write their competing views of the world into the shared state on
> all other levels anyway.
>
> And that's okay. If the configuration and memory usage is such that
> there is at least one reclaimer that scans without any protection
> (like a limit reclaimer), it's not a problem when a second reclaimer
> that meant to do protected global reclaim will also do one iteration
> without protection. It's no different than if a second thread had
> entered limit reclaim through another internal allocation.
>
> There is no semantical violation with the race in your patch or the
> race in this patch. Any effective protection that becomes visible is
> 1) permitted by the configuration, but 2) also triggered *right now*
> by an acute need to reclaim memory with these parameters.
>
> The *right now* part is important. That's what's broken before either
> patch, and that's what we're fixing: to see really, really *old* stale
> that might not be representative of the config semantics anymore.
>
> Since you haven't linked to my email, here is my counter argument to
> the alternative patch "fixing" this race somehow.
>
> A reclaim:
>
>   root
>      `- A (low=2G, max=3G -> elow=0)
>         `- A1 (low=0G -> elow=0)
>
> Global reclaim:
>
>   root
>      `- A (low=2G, max=3G -> elow=2G)
>         `- A1 (low=0G -> elow=2G)
>
> During global reclaim, A1 is supposed to have 2G effective low
> protection. If A limit reclaim races, it can set A1's elow to
> 0.

Before the commit  8a931f801340c2be ("mm: memcontrol: recursive
memory.low protection"), the A1's elow should be 0, while after this
commit A1's elow is 2G.
That is a behavior change.

Then this case gives us another example why accessing emin and elow in
the very deap reclaiming code (get_scan_count) is the root of ALL
EVIL.

>  Global reclaim will now query mem_cgroup_protection(root, A1), the
> root == memcg check you insist we add will fail and it'll reclaim A1
> without protection.
>
> The alternative patch is nothing except slightly worse code.



-- 
Thanks
Yafang
