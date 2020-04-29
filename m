Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28511BE46A
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2020 18:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD2Q4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Apr 2020 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgD2Q4a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Apr 2020 12:56:30 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9E7C03C1AE
        for <cgroups@vger.kernel.org>; Wed, 29 Apr 2020 09:56:30 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id s30so2470430qth.2
        for <cgroups@vger.kernel.org>; Wed, 29 Apr 2020 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rnHHxaQhtT4+RdRDGU5tOE+9a9rrpNd1LdRaMA/8Xws=;
        b=FvcA1FjygqWE42unECNdDBWBlDyRl6w5nneqciqqk+57WN0ZdyDO6khok8kIDfjNuk
         fAGZ9N28xSsYZPPUmEqUALlpo2Yb+Q6xQMtLX3Bu2UqauKHvzReNsR4x0dLu7pVondaP
         NuiMQ9QOMCj93k0M3T29tJbkldsoUpHqoP6DDWrOEEIPaTfKgJ1U0WTgqR3H2FB+bzAP
         JHKyV+U7REU96PTrWNZ0wkeHwhy+D7NiK2DmEHNClIfJASJdO3iHTsY5EnKRCxN0hgLz
         xhSVEIVZD7MKcIJih1Wwz02CwM2l4WwkdpGReuC+8V1P0sdL3hgqnFGkXvSgV4C+6B7x
         g3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnHHxaQhtT4+RdRDGU5tOE+9a9rrpNd1LdRaMA/8Xws=;
        b=SP6OwecCqfPT7nVnl2LZMgNUIpZfF+930fVwkwEr6czq2anHImIqPRhxgKNdlad9tT
         I4hHNaXmvrm6v1CAo9Ll1ZaBnfDdv586zTnUrWZYz5rCFrPAzDCxHbbAvr0d9S0S/An8
         CGA3adWVb7UiVrldnbvNI8/YcDnLb5wlvQj90mh7/0hKED1bY6Wc7lAfxml0o7Zsr5H4
         gKgINQadx1FseOlu4Tkkjee5YgMzPhjwwYnH1sMfmbxxgmw6bLhCGcazD6RkUsALolDL
         xeFclZJKPh4Xx1oXWeqVy/c0vZmpfmh7qp9sHOR7dPlOgxbasZ6IL5TbxabYB1scgucR
         50Yw==
X-Gm-Message-State: AGi0PuYf4azPmY9z2eSjB/IvjIHPIQIkTXaBXrbDILZE7eFcq2l8d6c4
        6QUov4uH5x7Es6ekDHcnRwo5wlgiz3g=
X-Google-Smtp-Source: APiQypKNSspppIYZLX8YP/iqVnuJ4JDLFmLd4r/PtvUxAHzpIvgHAdgju2vibc9BHt/Ts2nWYrvrMQ==
X-Received: by 2002:ac8:27b4:: with SMTP id w49mr36250211qtw.111.1588179389453;
        Wed, 29 Apr 2020 09:56:29 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k127sm16013425qkb.35.2020.04.29.09.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:56:28 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:56:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200429165627.GA24768@cmpxchg.org>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz>
 <20200429140330.GA5054@cmpxchg.org>
 <20200429150414.GI28637@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429150414.GI28637@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 29, 2020 at 05:04:14PM +0200, Michal Hocko wrote:
> On Wed 29-04-20 10:03:30, Johannes Weiner wrote:
> > On Wed, Apr 29, 2020 at 12:15:10PM +0200, Michal Hocko wrote:
> > > On Tue 28-04-20 19:26:47, Chris Down wrote:
> > > > From: Yafang Shao <laoar.shao@gmail.com>
> > > > 
> > > > A cgroup can have both memory protection and a memory limit to isolate
> > > > it from its siblings in both directions - for example, to prevent it
> > > > from being shrunk below 2G under high pressure from outside, but also
> > > > from growing beyond 4G under low pressure.
> > > > 
> > > > Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> > > > implemented proportional scan pressure so that multiple siblings in
> > > > excess of their protection settings don't get reclaimed equally but
> > > > instead in accordance to their unprotected portion.
> > > > 
> > > > During limit reclaim, this proportionality shouldn't apply of course:
> > > > there is no competition, all pressure is from within the cgroup and
> > > > should be applied as such. Reclaim should operate at full efficiency.
> > > > 
> > > > However, mem_cgroup_protected() never expected anybody to look at the
> > > > effective protection values when it indicated that the cgroup is above
> > > > its protection. As a result, a query during limit reclaim may return
> > > > stale protection values that were calculated by a previous reclaim cycle
> > > > in which the cgroup did have siblings.
> > > > 
> > > > When this happens, reclaim is unnecessarily hesitant and potentially
> > > > slow to meet the desired limit. In theory this could lead to premature
> > > > OOM kills, although it's not obvious this has occurred in practice.
> > > 
> > > Thanks this describes the underlying problem. I would be also explicit
> > > that the issue should be visible only on tail memcgs which have both
> > > max/high and protection configured and the effect depends on the
> > > difference between the two (the smaller it is the largrger the effect).
> > > 
> > > There is no mention about the fix. The patch resets effective values for
> > > the reclaim root and I've had some concerns about that
> > > http://lkml.kernel.org/r/20200424162103.GK11591@dhcp22.suse.cz.
> > > Johannes has argued that other races are possible and I didn't get to
> > > think about it thoroughly. But this patch is introducing a new
> > > possibility of breaking protection. If we want to have a quick and
> > > simple fix that would be easier to backport to older kernels then I
> > > would feel much better if we simply workedaround the problem as
> > > suggested earlier http://lkml.kernel.org/r/20200423061629.24185-1-laoar.shao@gmail.com
> > > We can rework the effective values calculation to be more robust against
> > > races on top of that because this is likely a more tricky thing to do.
> > 
> > Well, can you please *do* think more thoroughly about what I wrote,
> > instead of pushing for an alternative patch on gut feeling alone?
> > 
> > Especially when you imply that this should be a stable patch.
> 
> The patch has a Fixes tag and so it is not unrealistic to assume that it
> will hit older trees. I wasn't really implying stable tree backport and
> I do not think this is a stable material.

Okay, thanks for clarifying.

> > Not only does your alternative patch not protect against the race you
> > are worried about, the race itself doesn't matter. Racing reclaimers
> > will write their competing views of the world into the shared state on
> > all other levels anyway.
> > 
> > And that's okay. If the configuration and memory usage is such that
> > there is at least one reclaimer that scans without any protection
> > (like a limit reclaimer), it's not a problem when a second reclaimer
> > that meant to do protected global reclaim will also do one iteration
> > without protection. It's no different than if a second thread had
> > entered limit reclaim through another internal allocation.
> 
> Yes I do agree here.

Okay.

> > There is no semantical violation with the race in your patch or the
> > race in this patch. Any effective protection that becomes visible is
> > 1) permitted by the configuration, but 2) also triggered *right now*
> > by an acute need to reclaim memory with these parameters.
> > 
> > The *right now* part is important. That's what's broken before either
> > patch, and that's what we're fixing: to see really, really *old* stale
> > that might not be representative of the config semantics anymore.
> 
> No disagreement here either. But please remember that the example I've
> given is a clear violation of the protection. Let me paste it here so
> that we have both examples in one email:
> : Let's have global and A's reclaim in parallel:
> :  |
> :  A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
> :  |\
> :  | C (low = 1G, usage = 2.5G)
> :  B (low = 1G, usage = 0.5G)
> : 
> : for A reclaim we have
> : B.elow = B.low
> : C.elow = C.low
> : 
> : For the global reclaim
> : A.elow = A.low
> : B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
> : C.elow = min(C.usage, C.low)
> : 
> : With the effective values reseting we have A reclaim
> : A.elow = 0
> : B.elow = B.low
> : C.elow = C.low
> : 
> : and global reclaim could see the above and then
> : B.elow = C.elow = 0 because children_low_usage > A.elow
> 
> I hope we both agree that B shouldn't be reclaimed whether the reclaim
> comes from A or above A. The race is not possible with with the patch
> working around the problem in mem_cgroup_protection().

Okay, I misread this the first time.

The problem is that in limit reclaim we reset A.elow in anticipation
of treating B and C as the top-level groups of our scan cycle and will
be using their B.low and C.low verbatim. Global reclaim can then visit
them before us and propagate A.elow=0 down to them.

But doesn't this problem cut both ways? Say you have the following
subtree:

	A (memory.max=10G, memory.low=2G)
	`- A1 (memory.low=max)
	`- A2 (memory.low=max)
	`- A3 (memory.low=0)

A similar race can give A1 and A2 absolute exemption from global
reclaim instead of proportional distribution of the parental 2G.

The chances of that happening could be boosted maliciously by
triggering many short limit reclaim invocations, like ioless cache
from sparse files, to keep overwriting A1.elow and A2.elow to max.

I think to address this, we need a more comprehensive solution and
introduce some form of serialization. I'm not sure yet how that would
look like yet.

I'm still not sure it's worth having a somewhat ugly workaround in
mem_cgroup_protection() to protect against half of the bug. If you
think so, the full problem should at least be documented and marked
XXX or something.

In practice, I doubt this matters all that much because limit reclaim
and global reclaim tend to occur in complementary
containerization/isolation strategies, not heavily simultaneously.
