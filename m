Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9042A274707
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVQzf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 12:55:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42354 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgIVQzf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 22 Sep 2020 12:55:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600793733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jCObW2aZuYsbwA3+WNFccCphyTXD8hTQNq4fK3Vcz4=;
        b=hzHNG52oRkd8BTbo/rvSiMraoa3PW+GRD3nIN/EKcbZ1CcZkYHkNfV7IqIX12/325qcZP5
        rIk2+5rEZzHWH5/tM/25LnBmaoGyWt0r8F2V2paOE5XNRFwpqnGImXV+mDk7khw/js3/3h
        YaNIIXAhRI97QIaQHHtm1a+yn8pPrTY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 64A23AD32;
        Tue, 22 Sep 2020 16:56:10 +0000 (UTC)
Date:   Tue, 22 Sep 2020 18:55:27 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20200922165527.GD12990@dhcp22.suse.cz>
References: <20200909215752.1725525-1-shakeelb@google.com>
 <20200921163055.GQ12990@dhcp22.suse.cz>
 <CALvZod43VXKZ3StaGXK_EZG_fKcW3v3=cEYOWFwp4HNJpOOf8g@mail.gmail.com>
 <20200922114908.GZ12990@dhcp22.suse.cz>
 <CALvZod4FvE12o53BpeH5WB_McTdCkFTFXgc9gcT1CEHXzQLy_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4FvE12o53BpeH5WB_McTdCkFTFXgc9gcT1CEHXzQLy_A@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-09-20 08:54:25, Shakeel Butt wrote:
> On Tue, Sep 22, 2020 at 4:49 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 21-09-20 10:50:14, Shakeel Butt wrote:
[...]
> > > Let me add one more point. Even if the high limit reclaim is swift, it
> > > can still take 100s of usecs. Most of our jobs are anon-only and we
> > > use zswap. Compressing a page can take a couple usec, so 100s of usecs
> > > in limit reclaim is normal. For latency sensitive jobs, this amount of
> > > hiccups do matters.
> >
> > Understood. But isn't this an implementation detail of zswap? Can it
> > offload some of the heavy lifting to a different context and reduce the
> > general overhead?
> >
> 
> Are you saying doing the compression asynchronously? Similar to how
> the disk-based swap triggers the writeback and puts the page back to
> LRU, so the next time reclaim sees it, it will be instantly reclaimed?
> Or send the batch of pages to be compressed to a different CPU and
> wait for the completion?

Yes.

[...]

> > You are right that misconfigured limits can result in problems. But such
> > a configuration should be quite easy to spot which is not the case for
> > targetted reclaim calls which do not leave any footprints behind.
> > Existing interfaces are trying to not expose internal implementation
> > details as much as well. You are proposing a very targeted interface to
> > fine control the memory reclaim. There is a risk that userspace will
> > start depending on a specific reclaim implementation/behavior and future
> > changes would be prone to regressions in workloads relying on that. So
> > effectively, any user space memory reclaimer would need to be tuned to a
> > specific implementation of the memory reclaim.
> 
> I don't see the exposure of internal memory reclaim implementation.
> The interface is very simple. Reclaim a given amount of memory. Either
> the kernel will reclaim less memory or it will over reclaim. In case
> of reclaiming less memory, the user space can retry given there is
> enough reclaimable memory. For the over reclaim case, the user space
> will backoff for a longer time. How are the internal reclaim
> implementation details exposed?

In an ideal world yes. A feedback mechanism will be independent on the
particular implementation. But the reality tends to disagree quite
often. Once we provide a tool there will be users using it to the best
of their knowlege. Very often as a hammer. This is what the history of
kernel regressions and "we have to revert an obvious fix because
userspace depends on an undocumented behavior which happened to work for
some time" has thought us in a hard way.

I really do not want to deal with reports where a new heuristic in the
memory reclaim will break something just because the reclaim takes
slightly longer or over/under reclaims differently so the existing
assumptions break and the overall balancing from userspace breaks.

This might be a shiny exception of course. And please note that I am not
saying that the interface is completely wrong or unacceptable. I just
want to be absolutely sure we cannot move forward with the existing API
space that we have.

So far I have learned that you are primarily working around an
implementation detail in the zswap which is doing the swapout path
directly in the pageout path. That sounds like a very bad reason to add
a new interface. You are right that there are likely other usecases to
like this new interface - mostly to emulate drop_caches - but I believe
those are quite misguided as well and we should work harder to help
them out to use the existing APIs. Last but not least the memcg
background reclaim is something that should be possible without a new
interface.
-- 
Michal Hocko
SUSE Labs
