Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8E668E34D
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 23:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBGWO3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 17:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBGWO2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 17:14:28 -0500
Received: from out-90.mta0.migadu.com (out-90.mta0.migadu.com [91.218.175.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676277A94
        for <cgroups@vger.kernel.org>; Tue,  7 Feb 2023 14:14:25 -0800 (PST)
Date:   Tue, 7 Feb 2023 14:14:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675808063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uqkBz1BwvABXk+fsiQK1YP1rTVoIDj7zQGjJtDLYqgU=;
        b=ttdOrrC/ZvG/BtGm5MOljJxe/vL1Mtec+IOrUdPMmx/LKsaa8Y48Yrg+EDYN3Dbrxnnd5U
        COLQp1ahqHDCGJrR4rAXZNE46n789zGyRnNGBLWPjCpfKlvxFUtZxs3OP9lqqbOuR+zpxC
        3saeSEif/01T9wGGK/oQJHBj6VjpEz8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] mm: memcontrol: don't account swap failures not due
 to cgroup limits
Message-ID: <Y+LNK4IhwsI7AQPi@P9FQF9L96D.corp.robot.car>
References: <20230202155626.1829121-1-hannes@cmpxchg.org>
 <CAJD7tkaCpD0LpzdA+NsZj2WK=iQCLn7RS9qc7K53Qonxhp4TgA@mail.gmail.com>
 <Y+Kh5atM0TQmkR+R@cmpxchg.org>
 <CAJD7tkZ_vBTh6Nj_8AViJbQ1dFf3zxS3cEjHu0CsuGq+pKH+Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZ_vBTh6Nj_8AViJbQ1dFf3zxS3cEjHu0CsuGq+pKH+Jw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 07, 2023 at 11:21:15AM -0800, Yosry Ahmed wrote:
> On Tue, Feb 7, 2023 at 11:09 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Thu, Feb 02, 2023 at 10:30:40AM -0800, Yosry Ahmed wrote:
> > > On Thu, Feb 2, 2023 at 7:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > Christian reports the following situation in a cgroup that doesn't
> > > > have memory.swap.max configured:
> > > >
> > > >   $ cat memory.swap.events
> > > >   high 0
> > > >   max 0
> > > >   fail 6218
> > > >
> > > > Upon closer examination, this is an ARM64 machine that doesn't support
> > > > swapping out THPs. In that case, the first get_swap_page() fails, and
> > > > the kernel falls back to splitting the THP and swapping the 4k
> > > > constituents one by one. /proc/vmstat confirms this with a high rate
> > > > of thp_swpout_fallback events.
> > > >
> > > > While the behavior can ultimately be explained, it's unexpected and
> > > > confusing. I see three choices how to address this:
> > > >
> > > > a) Specifically exlude THP fallbacks from being counted, as the
> > > >    failure is transient and the memory is ultimately swapped.
> > > >
> > > >    Arguably, though, the user would like to know if their cgroup's
> > > >    swap limit is causing high rates of THP splitting during swapout.
> > >
> > > We have the option to add THP_SWPOUT_FALLBACK (and THP_SWPOUT for
> > > completeness) to memcg events for this if/when a use case arises,
> > > right?
> >
> > Yes, we can add that to memory.stat.
> >
> > > > b) Only count cgroup swap events when they are actually due to a
> > > >    cgroup's own limit. Exclude failures that are due to physical swap
> > > >    shortage or other system-level conditions (like !THP_SWAP). Also
> > > >    count them at the level where the limit is configured, which may be
> > > >    above the local cgroup that holds the page-to-be-swapped.
> > > >
> > > >    This is in line with how memory.swap.high, memory.high and
> > > >    memory.max events are counted.
> > > >
> > > >    However, it's a change in documented behavior.
> > >
> > > This option makes sense to me, but I can't speak to the change of
> > > documented behavior. However, looking at the code, it seems like if we do this
> > > the "max" & "fail" counters become effectively the same. "fail" would
> > > not provide much value then.
> >
> > Right.
> >
> > > I wonder if it makes sense to have both, and clarify that "fail" -
> > > "max" would be non-limit based failures (e.g. ran out of swap space),
> > > or would this cause confusion as to whether those non-limit failures
> > > were transient (THP fallback) or eventual?
> >
> > If we add the fallback events, the user can calculate it. I wouldn't
> > split the fail counter itself. There are too many reasons why swap can
> > fail, half of them implementation-defined (as in the ARM example).
> >
> > So I think I'll send patches either way to:
> >
> > 1. Fix the hierarchical accounting of the events to make it consistent
> >    with other counters.
> >
> > 2. Add THP swap/fallback counts to memory.stat
> 
> Sounds good, thanks!
> 
> >
> > We could consider excluding THP fallbacks from the fail count. But it
> > seems really wrong for the cgroup controller to start classifying
> > individual types of failures in the swap layer and make decisions on
> > how to report them to the user. Cgroups really shouldn't be in the
> > business of making up its own MM events. I should provide per-cgroup
> > accounting of native MM events. And nobody has felt the need to add
> > native swap failure counts yet.
> >
> > So I'd argue we should either remove the swap fail count altogether
> > for all the reasons mentioned, or just leave it as is and as a
> > documented interface that is unfortunately out the door.
> >
> > Thoughts?
> 
> Agreed. We should either report all failures or failures specific to
> cgroup limits (which the max count already tracks).
> 
> About removing the fail count completely as-is or completely removing
> it, I don't feel strongly either way. If we add THP swap fallbacks to
> memory.stat, then the fail counter becomes more understandable as you
> can break it down into (max, THP swap fallback, others), with others
> being *probably* swap is full. Arguably, it seems like the interesting
> components (or the cgroup-relevant) components are already there
> regardless. The counter might be useful from a monitoring perspective,
> if a memcg OOMs for example a high fail count can show us that it
> tried to swap multiple times but failed, we can then look at the max
> count and THP fallbacks to understand where the failure is coming
> from.
> 
> I would say we can leave it as-is, but whatever you prefer.

+1

On one hand, the less counters the better.
On the other, removing things which is an API break should have a really good reason.
So probably let's leave it as it is.
