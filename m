Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE9287675
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 16:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgJHOzK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Oct 2020 10:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbgJHOzK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Oct 2020 10:55:10 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53021C061755
        for <cgroups@vger.kernel.org>; Thu,  8 Oct 2020 07:55:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q63so7305759qkf.3
        for <cgroups@vger.kernel.org>; Thu, 08 Oct 2020 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uyKHtfoarsj+UYs2PP4XCdlBcu5iL8M8TqmjexyJtjo=;
        b=gSpOReNk6UlU6+gBPtDU3TmLons5StnRVP+CSGLouttWxPrXlWzOUzwAitmC+kccP2
         0zmeEv8fvogdspFm1WObJnfz37SM5ZQXGJVkNbRt3U9rIh7Pyw4kD0vw0G9kikekdRdl
         C2gz/68+9dh12edgZNkL+yu9ynPSKifE62fxva7Ow56HS1u8kUWSsGm2yoI9rtaJKJiN
         nJA/QAp95vu+Fs1ILvQcjFYZDG+JxrV4BqbTRG3oG/QYOK4UZCI4Cc9geDfeNj3qsVsq
         MFI8DWNCMjRkARF4wR2mrx1S+YWbkkW2KhHKaCXXeQQUOCxJQtRVVlpJiKio3PpqqbwF
         TK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uyKHtfoarsj+UYs2PP4XCdlBcu5iL8M8TqmjexyJtjo=;
        b=GEWy0xsgeCadU6lhQlnRRvBwM1QcqnP8VSExO1gvOLFGszFrI1O9E1QIzPB4YUPXRf
         b18jajRzCAWuceA5hVOnPj/1c63NReHv65vwEMT7JomKAyRrEMg7ZveJWOMKd65LWHjo
         +bwj6FZHMKnHNHs1U/N+Swk8oY7UbbzCh9h5O2vCixO33m4WBoehEM4BPGHUKnFAT/n+
         O72n5wQOL5isChkECJOXyVLZKvV03jr77MLbVfyuffhSHBnrfyPd0TDzIHFxg6fBc0lP
         eTmueMcIFSOx6G3Hn1mxMEJ7qo2a61qUkVY7YCGkPwY8jz41G+6ahe4I2y+SCJNxa6z2
         cRog==
X-Gm-Message-State: AOAM533i76LEAGjklp70NnBGSSxXAKFRjxbR/68/zC3UQpzQ8zRjBRTy
        1UFcuDnQR8PKeXAyS54fmZUUDQ==
X-Google-Smtp-Source: ABdhPJwCjDD186qpBAmnjaTWRt1sPwSBHJUbvD4s+XLrOlPjgXCU4uGDse/682h+yj3I+EQxRHgfig==
X-Received: by 2002:ae9:e644:: with SMTP id x4mr8391439qkl.270.1602168908459;
        Thu, 08 Oct 2020 07:55:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:9294])
        by smtp.gmail.com with ESMTPSA id e23sm3955591qkl.67.2020.10.08.07.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:55:07 -0700 (PDT)
Date:   Thu, 8 Oct 2020 10:53:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Righi <andrea.righi@canonical.com>,
        SeongJae Park <sjpark@amazon.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20201008145336.GA163830@cmpxchg.org>
References: <20200909215752.1725525-1-shakeelb@google.com>
 <20200928210216.GA378894@cmpxchg.org>
 <20200929150444.GG2277@dhcp22.suse.cz>
 <20200929215341.GA408059@cmpxchg.org>
 <CALvZod5eN0PDtKo8SEp1n-xGvgCX9k6-OBGYLT3RmzhA+Q-2hw@mail.gmail.com>
 <20201001143149.GA493631@cmpxchg.org>
 <CALvZod59cU40A3nbQtkP50Ae3g6T2MQSt+q1=O2=Gy9QUzNkbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod59cU40A3nbQtkP50Ae3g6T2MQSt+q1=O2=Gy9QUzNkbg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 06, 2020 at 09:55:43AM -0700, Shakeel Butt wrote:
> On Thu, Oct 1, 2020 at 7:33 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> [snip]
> > > >    So instead of asking users for a target size whose suitability
> > > >    heavily depends on the kernel's LRU implementation, the readahead
> > > >    code, the IO device's capability and general load, why not directly
> > > >    ask the user for a pressure level that the workload is comfortable
> > > >    with and which captures all of the above factors implicitly? Then
> > > >    let the kernel do this feedback loop from a per-cgroup worker.
> > >
> > > I am assuming here by pressure level you are referring to the PSI like
> > > interface e.g. allowing the users to tell about their jobs that X
> > > amount of stalls in a fixed time window is tolerable.
> >
> > Right, essentially the same parameters that psi poll() would take.
> 
> I thought a bit more on the semantics of the psi usage for the
> proactive reclaim.
> 
> Suppose I have a top level cgroup A on which I want to enable
> proactive reclaim. Which memory psi events should the proactive
> reclaim should consider?
> 
> The simplest would be the memory.psi at 'A'. However memory.psi is
> hierarchical and I would not really want the pressure due limits in
> children of 'A' to impact the proactive reclaim.

I don't think pressure from limits down the tree can be separated out,
generally. All events are accounted recursively as well. Of course, we
remember the reclaim level for evicted entries - but if there is
reclaim triggered at A and A/B concurrently, the distribution of who
ends up reclaiming the physical pages in A/B is pretty arbitrary/racy.

If A/B decides to do its own proactive reclaim with the sublimit, and
ends up consuming the pressure budget assigned to proactive reclaim in
A, there isn't much that can be done.

It's also possible that proactive reclaim in A keeps A/B from hitting
its limit in the first place.

I have to say, the configuration doesn't really strike me as sensible,
though. Limits make sense for doing fixed partitioning: A gets 4G, A/B
gets 2G out of that. But if you do proactive reclaim on A you're
essentially saying A as a whole is auto-sizing dynamically based on
its memory access pattern. I'm not sure what it means to then start
doing fixed partitions in the sublevel.

> PSI due to refaults and slow IO should be included or maybe only
> those which are caused by the proactive reclaim itself. I am
> undecided on the PSI due to compaction. PSI due to global reclaim
> for 'A' is even more complicated. This is a stall due to reclaiming
> from the system including self. It might not really cause more
> refaults and IOs for 'A'. Should proactive reclaim ignore the
> pressure due to global pressure when tuning its aggressiveness.

Yeah, I think they should all be included, because ultimately what
matters is what the workload can tolerate without sacrificing
performance.

Proactive reclaim can destroy THPs, so the cost of recreating them
should be reflected. Otherwise you can easily overpressurize.

For global reclaim, if you say you want a workload pressurized to X
percent in order to drive the LRUs and chop off all cold pages the
workload can live without, it doesn't matter who does the work. If
there is an abundance of physical memory, it's going to be proactive
reclaim. If physical memory is already tight enough that global
reclaim does it for you, there is nothing to be done in addition, and
proactive reclaim should hang back. Otherwise you can again easily
overpressurize the workload.
