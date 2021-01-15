Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAD62F86F5
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 21:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbhAOU4W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jan 2021 15:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbhAOU4T (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jan 2021 15:56:19 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560F6C061793
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 12:55:39 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j26so7030233qtq.8
        for <cgroups@vger.kernel.org>; Fri, 15 Jan 2021 12:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SlNlvcKcVOLSQ+6ubVv+zQmNdKKd35YVKlEcU4lZbR0=;
        b=08diUBE1TRDu8jkonn5T7HGIPR4ggImv2F40SdRk2Vj2uUcUYhKHWt3hXjiCtm3yKM
         ktR2KdE6uaQ1EEo4scHUcpcm3q/u8L3zD02rEv+YWZ+/RjgfnSCX4igqLCJNqbP8JkhD
         wuai1GglPwLSYmuoHuc7NqKeNnvJ1fFTjed821X7BinBBXs30qDK83vV98QDudCTf35I
         B+3ADJAZ0QlHeLaozMOEt0o3EiMZpPbbLotoxVgV/V9yQv0oW9G4KO4F/FfwPOppPk8E
         Mq/xHc64yoKMTsKPSzaN74uXJU7RrcYKPM1MYdxLZUTxaZ/NPHUWglckARwnmnDXyPCl
         4wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SlNlvcKcVOLSQ+6ubVv+zQmNdKKd35YVKlEcU4lZbR0=;
        b=tZqs/C8bxr3y9hN/OKKzrQc1/LiyYWsTu9O2ZeA6Ns+vbAAj7gXhFK3cncn313E1io
         VIj38v2t1Q3NKmgyLnsI70+n0ZYqls8m5/ubcGGIr6zt1TEKGtsivopch734TOeAqUzO
         reMRxIMmgKoJ+x8XXSl8+CsaRhY15M7AWOiy9Zh+dLyd5elMOn6itHOLsmbQg2tHBygI
         O4bbAuCeOGvCXoOvpEAVzQO6hDQwPGwUInENozF2jwFF/yCJx6+A3tOzp1MYxtFfl3K5
         K7VnoEwDXGhm3xQAs3Ma8D1OLpNkuQoEw7brfFGNd5mq2MtlcCVmQt993qhH3qo82zQ8
         9dhA==
X-Gm-Message-State: AOAM532TKLKxTKxOp29j3duCO9gzOX8PAJdQXZkOAFM71SyD+KSE7WmE
        hsI1MlnX3G/Tjd37vTOXgByg1A==
X-Google-Smtp-Source: ABdhPJwk80MpECSM3D92ftFoulMk04vWZTvZa9AnLWrgNQu5NlTm9g0uQg+Mlh5ocsoZenQ38JBsLw==
X-Received: by 2002:ac8:45d7:: with SMTP id e23mr13629017qto.149.1610744138477;
        Fri, 15 Jan 2021 12:55:38 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:dbed])
        by smtp.gmail.com with ESMTPSA id 190sm5870540qkf.61.2021.01.15.12.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:55:37 -0800 (PST)
Date:   Fri, 15 Jan 2021 15:55:36 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: prevent starvation when writing
 memory.high
Message-ID: <YAIBSJg3btQ+2CNZ@cmpxchg.org>
References: <20210112163011.127833-1-hannes@cmpxchg.org>
 <20210113144654.GD22493@dhcp22.suse.cz>
 <YAHA4uBSLlnxxAbu@cmpxchg.org>
 <20210115170341.GA631549@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115170341.GA631549@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 15, 2021 at 09:03:41AM -0800, Roman Gushchin wrote:
> On Fri, Jan 15, 2021 at 11:20:50AM -0500, Johannes Weiner wrote:
> > On Wed, Jan 13, 2021 at 03:46:54PM +0100, Michal Hocko wrote:
> > > On Tue 12-01-21 11:30:11, Johannes Weiner wrote:
> > > > When a value is written to a cgroup's memory.high control file, the
> > > > write() context first tries to reclaim the cgroup to size before
> > > > putting the limit in place for the workload. Concurrent charges from
> > > > the workload can keep such a write() looping in reclaim indefinitely.
> > > > 
> > > > In the past, a write to memory.high would first put the limit in place
> > > > for the workload, then do targeted reclaim until the new limit has
> > > > been met - similar to how we do it for memory.max. This wasn't prone
> > > > to the described starvation issue. However, this sequence could cause
> > > > excessive latencies in the workload, when allocating threads could be
> > > > put into long penalty sleeps on the sudden memory.high overage created
> > > > by the write(), before that had a chance to work it off.
> > > > 
> > > > Now that memory_high_write() performs reclaim before enforcing the new
> > > > limit, reflect that the cgroup may well fail to converge due to
> > > > concurrent workload activity. Bail out of the loop after a few tries.
> > > 
> > > I can see that you have provided some more details in follow up replies
> > > but I do not see any explicit argument why an excessive time for writer
> > > is an actual problem. Could you be more specific?
> > 
> > Our writer isn't necessarily time sensitive, but there is a difference
> > between a) the write taking a few seconds to reclaim down the
> > requested delta and b) the writer essentially turning into kswapd for
> > the workload and busy-spinning inside the kernel indefinitely.
> > 
> > We've seen the writer stuck in this function for minutes, long after
> > the requested delta has been reclaimed, consuming alarming amounts of
> > CPU cycles - CPU time that should really be accounted to the workload,
> > not the system software performing the write.
> > 
> > Obviously, we could work around it using timeouts and signals. In
> > fact, we may have to until the new kernel is deployed everywhere. But
> > this is the definition of an interface change breaking userspace, so
> > I'm a bit surprised by your laid-back response.
> > 
> > > > Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> > > > Cc: <stable@vger.kernel.org> # 5.8+
> > > 
> > > Why is this worth backporting to stable? The behavior is different but I
> > > do not think any of them is harmful.
> > 
> > The referenced patch changed user-visible behavior in a way that is
> > causing real production problems for us. From stable-kernel-rules:
> > 
> >  - It must fix a real bug that bothers people (not a, "This could be a
> >    problem..." type thing).
> > 
> > > > Reported-by: Tejun Heo <tj@kernel.org>
> > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > 
> > > I am not against the patch. The existing interface doesn't provide any
> > > meaningful feedback to the userspace anyway. User would have to re check
> > > to see the result of the operation. So how hard we try is really an
> > > implementation detail.
> > 
> > Yeah, I wish it was a bit more consistent from an interface POV.
> > 
> > Btw, if you have noticed, Roman's patch to enforce memcg->high *after*
> > trying to reclaim went into the tree at the same exact time as Chris's
> > series "mm, memcg: reclaim harder before high throttling" (commit
> > b3ff92916af3b458712110bb83976a23471c12fa). It's likely they overlap.
> > 
> > Chris's patch changes memory.high reclaim on the allocation side from
> > 
> > 	reclaim once, sleep if there is still overage
> > 
> > to
> > 
> > 	reclaim the overage as long as you make forward progress;
> > 	sleep after 16 no-progress loops if there is still overage
> > 
> > Roman's patch describes a problem where allocating threads go to sleep
> > when memory.high is lowered by a wider step. This is exceedingly
> > unlikely after Chris's change.
> > 
> > Because after Chris's change, memory.high is reclaimed on the
> > allocation side as aggressively as memory.max. The only difference is
> > that upon failure, one sleeps and the other OOMs.
> > 
> > If Roman's issue were present after Chris's change, then we'd also see
> > premature OOM kills when memory.max is lowered by a large step. And I
> > have never seen that happening.
> > 
> > So I suggest instead of my fix here, we revert Roman's patch instead,
> > as it should no longer be needed. Thoughts?
> 
> Chris's patch was merged way earlier than mine into the kernel tree which
> was used when I observed the problem in the production. So likely it was there.

Chris's patch was in the tree earlier, but the first release
containing it was tagged a day before you put in your change, so I
doubt it was on the production system where you observed the issue.

As per above, it'd be very surprising to see premature sleeps when
lowering memory.high, when allocation-side reclaim keeps going until
the cgroup meets the definition of OOM.

> I think it makes sense to try to reclaim memory first before putting
> all processes in the cgroup into reclaim mode. Even without artificial delays
> it creates some latency and btw doesn't make the reclaim process more efficient.

It's not obvious that this is a practical problem. It certainly isn't
for memory.max, and there should be a good reason why the two should
be different aside from the documented OOM vs sleep behavior.

Absent any concrete evidence to the contrary, I'd make the behavior
the same again for those two.
