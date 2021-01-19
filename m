Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2A02FBCF8
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 17:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387927AbhASQwc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 11:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbhASQsM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 11:48:12 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44664C061575
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:47:32 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z6so7085681qtn.0
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HQhIiqouZYO54MDphZpxd2e5yZbQev4tgCFWsf4zZmo=;
        b=SKZViz0B81l15glJySEmk2KHv0dZ42QnZw63XyroVp+LT997+JqLHviX++WY4bwsHw
         Snuf9828SnnBvpcPDuzcVgzwoaAzwIoEXSRgWikHQNIebuJ5zjAQF1W8NGfMoeBU5cg2
         fqussE3+f/VCdDM6WdROtEOn1ozeSND0xsgBSYkIgy2JccFTUI3fLGvM3TzKVRZ0opee
         uNc0diVqCRL1wP7dEI9CQo8n6I10dbbFY/dQ2Llw1snQ6926q0DUTby6ljheVvzykUvH
         soPCZPyR+SAqb2rH2Z3V778u+xC5PPQdRPgJdtl5+gWx5bypel3J4131SY82hw/Vhjri
         HdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HQhIiqouZYO54MDphZpxd2e5yZbQev4tgCFWsf4zZmo=;
        b=PjTJeUWVIVbHOBNy4IVT1xOcvAvCcXG5KHvV2qMa8n5CW/d7E5aq15HuGrhiX6s8oH
         ++pQ5OiFEU9DLasBeOpxnvHM2e2qCr8AulAnMJo/XJmVgPMHTav5GKbSzn0VDvw03l+g
         0n1NLwW3NgPLvPBgyvFExRhaLJUtXYY3ooPUURjz+Mse5Kf1OU2YHxoHalOMFp7llz/8
         z6zH8hYc3L/xwZWPyunAM7zw9LaISPekMkR3KaPFmEek0mQCVKz7Bybim0HzoeSrTs9J
         yCMaf9HmvfbJgL4RLgI/eqlr3rzde2aQe8qwZqF5T0xkDfprE8E0spi0k4YaTvzACZy8
         ViCA==
X-Gm-Message-State: AOAM533BNsuuOCU3Ewyq29sBi6ejSmIn4J434AhvZQgKenrlyKe9cMTW
        NxUXAWbUdsk8oql90O/7Y/4Jrw==
X-Google-Smtp-Source: ABdhPJwE/MGthli/KCussSAE4vhaxFqSEWpfSlSLArsBv7ezEQscUgXUBOTZJraVuocscB/ps0H7xA==
X-Received: by 2002:ac8:57c1:: with SMTP id w1mr5032944qta.313.1611074851420;
        Tue, 19 Jan 2021 08:47:31 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q27sm13022037qkj.131.2021.01.19.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:47:30 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:47:29 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <YAcNISYNGDA/26pw@cmpxchg.org>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210113144654.GD22493@dhcp22.suse.cz>
 <YAHA4uBSLlnxxAbu@cmpxchg.org>
 <20210115170341.GA631549@carbon.dhcp.thefacebook.com>
 <YAIBSJg3btQ+2CNZ@cmpxchg.org>
 <20210115212723.GB631549@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115212723.GB631549@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 15, 2021 at 01:27:23PM -0800, Roman Gushchin wrote:
> On Fri, Jan 15, 2021 at 03:55:36PM -0500, Johannes Weiner wrote:
> > On Fri, Jan 15, 2021 at 09:03:41AM -0800, Roman Gushchin wrote:
> > > On Fri, Jan 15, 2021 at 11:20:50AM -0500, Johannes Weiner wrote:
> > > > On Wed, Jan 13, 2021 at 03:46:54PM +0100, Michal Hocko wrote:
> > > > > On Tue 12-01-21 11:30:11, Johannes Weiner wrote:
> > > > > > When a value is written to a cgroup's memory.high control file, the
> > > > > > write() context first tries to reclaim the cgroup to size before
> > > > > > putting the limit in place for the workload. Concurrent charges from
> > > > > > the workload can keep such a write() looping in reclaim indefinitely.
> > > > > > 
> > > > > > In the past, a write to memory.high would first put the limit in place
> > > > > > for the workload, then do targeted reclaim until the new limit has
> > > > > > been met - similar to how we do it for memory.max. This wasn't prone
> > > > > > to the described starvation issue. However, this sequence could cause
> > > > > > excessive latencies in the workload, when allocating threads could be
> > > > > > put into long penalty sleeps on the sudden memory.high overage created
> > > > > > by the write(), before that had a chance to work it off.
> > > > > > 
> > > > > > Now that memory_high_write() performs reclaim before enforcing the new
> > > > > > limit, reflect that the cgroup may well fail to converge due to
> > > > > > concurrent workload activity. Bail out of the loop after a few tries.
> > > > > 
> > > > > I can see that you have provided some more details in follow up replies
> > > > > but I do not see any explicit argument why an excessive time for writer
> > > > > is an actual problem. Could you be more specific?
> > > > 
> > > > Our writer isn't necessarily time sensitive, but there is a difference
> > > > between a) the write taking a few seconds to reclaim down the
> > > > requested delta and b) the writer essentially turning into kswapd for
> > > > the workload and busy-spinning inside the kernel indefinitely.
> > > > 
> > > > We've seen the writer stuck in this function for minutes, long after
> > > > the requested delta has been reclaimed, consuming alarming amounts of
> > > > CPU cycles - CPU time that should really be accounted to the workload,
> > > > not the system software performing the write.
> > > > 
> > > > Obviously, we could work around it using timeouts and signals. In
> > > > fact, we may have to until the new kernel is deployed everywhere. But
> > > > this is the definition of an interface change breaking userspace, so
> > > > I'm a bit surprised by your laid-back response.
> > > > 
> > > > > > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > > > > > Cc: <stable@vger.kernel.org> # 5.8+
> > > > > 
> > > > > Why is this worth backporting to stable? The behavior is different but I
> > > > > do not think any of them is harmful.
> > > > 
> > > > The referenced patch changed user-visible behavior in a way that is
> > > > causing real production problems for us. From stable-kernel-rules:
> > > > 
> > > >  - It must fix a real bug that bothers people (not a, "This could be a
> > > >    problem..." type thing).
> > > > 
> > > > > > Reported-by: Tejun Heo <tj@kernel.org>
> > > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > 
> > > > > I am not against the patch. The existing interface doesn't provide any
> > > > > meaningful feedback to the userspace anyway. User would have to re check
> > > > > to see the result of the operation. So how hard we try is really an
> > > > > implementation detail.
> > > > 
> > > > Yeah, I wish it was a bit more consistent from an interface POV.
> > > > 
> > > > Btw, if you have noticed, Roman's patch to enforce memcg->high *after*
> > > > trying to reclaim went into the tree at the same exact time as Chris's
> > > > series "mm, memcg: reclaim harder before high throttling" (commit
> > > > b3ff92916af3b458712110bb83976a23471c12fa). It's likely they overlap.
> > > > 
> > > > Chris's patch changes memory.high reclaim on the allocation side from
> > > > 
> > > > 	reclaim once, sleep if there is still overage
> > > > 
> > > > to
> > > > 
> > > > 	reclaim the overage as long as you make forward progress;
> > > > 	sleep after 16 no-progress loops if there is still overage
> > > > 
> > > > Roman's patch describes a problem where allocating threads go to sleep
> > > > when memory.high is lowered by a wider step. This is exceedingly
> > > > unlikely after Chris's change.
> > > > 
> > > > Because after Chris's change, memory.high is reclaimed on the
> > > > allocation side as aggressively as memory.max. The only difference is
> > > > that upon failure, one sleeps and the other OOMs.
> > > > 
> > > > If Roman's issue were present after Chris's change, then we'd also see
> > > > premature OOM kills when memory.max is lowered by a large step. And I
> > > > have never seen that happening.
> > > > 
> > > > So I suggest instead of my fix here, we revert Roman's patch instead,
> > > > as it should no longer be needed. Thoughts?
> > > 
> > > Chris's patch was merged way earlier than mine into the kernel tree which
> > > was used when I observed the problem in the production. So likely it was there.
> > 
> > Chris's patch was in the tree earlier, but the first release
> > containing it was tagged a day before you put in your change, so I
> > doubt it was on the production system where you observed the issue.
> > 
> > As per above, it'd be very surprising to see premature sleeps when
> > lowering memory.high, when allocation-side reclaim keeps going until
> > the cgroup meets the definition of OOM.
> > 
> > > I think it makes sense to try to reclaim memory first before putting
> > > all processes in the cgroup into reclaim mode. Even without artificial delays
> > > it creates some latency and btw doesn't make the reclaim process more efficient.
> > 
> > It's not obvious that this is a practical problem. It certainly isn't
> > for memory.max,
> 
> Because memory.max is usually not adjusted dynamically?
> 
> > and there should be a good reason why the two should
> > be different aside from the documented OOM vs sleep behavior.
> 
> Maybe we have different examples in our heads, but mine is a cgroup
> with a significant amount of relatively cold pagecache and a multi-threaded
> workload. Now somebody wants to tighten memory.high. Why would we put all
> threads into a direct reclaim? I don't see a good reason.

But how is that different than a multi-threaded workload simply
running up against a static limit?

As soon as one event puts the cgroup over the limit, all concurrent
allocations will form a thundering herd of reclaimers. I don't see
much of a difference between a burst of allocations exceeding the
limit from below and the limit being lowered from above.

Sure, the requested limit delta is usually bigger than a single
allocation. However, memory.high enforcement is batched, and quite a
few threads could contribute to the overage and be marked to enter
direct reclaim before the first page is actually scanned. Also, while
we do adjust memory.high dynamically, we do so no more than once every
5-10 seconds, whereas a multi-threaded workload may breach its limit
and provoke thundering herds many times a second.

So I just cannot imagine the sequence of events here would make a
practical difference for the aspect of the thundering herd (whereas it
was VERY obvious with the premature sleep issue on the allocation
side). But the thundering herd may start as soon as you lower the
limit, whether you reclaim before or after. It may already be
occurring against the higher limit before you even enter write().

Allocation latency is a real concern, I agree with you there. But
that's IMO more to do with how cgroup limits are enforced in
general. That's why there have been multiple discussions and patch
submissions around async reclaim.

But the fact is, the change of sequence is causing real problems in
production, and with the premature-throttling-on-large-delta-bug out
of the way, the justification for keeping it are somewhat nebulous.

So unless we can clearly show from production that the sequence still
matters after Chris's patch, I'd say we go with the revert and take
the small risk of getting data to the contrary.

As opposed to accruing additional complexity and special-cased code on
a hunch, that we then may carry unnecessarily for a very long time -
until somebody later on, under the pressure of keeping all this stuff
maintainable, takes the risk of chopping it again with much less of
the original context and stake holders available.
