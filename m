Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC5287DA7
	for <lists+cgroups@lfdr.de>; Thu,  8 Oct 2020 23:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgJHVKu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Oct 2020 17:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJHVKu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Oct 2020 17:10:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D5DC0613D2
        for <cgroups@vger.kernel.org>; Thu,  8 Oct 2020 14:10:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b69so8533391qkg.8
        for <cgroups@vger.kernel.org>; Thu, 08 Oct 2020 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bKBtP0ujyc6cQVOrIcuXYWFHroSBLTISizcx1XMf6ng=;
        b=s3k82CHtM77kUlpDxAcCO0fDeNqzwcdQM8Of6YdH+JSnzn+xzdpRJ9ziqQJ17PbB71
         Mqtm7QLzZTQmjyHN54EEKjqcrnVar1NQomaJT3VkEktsowxDbaBgGtqLQVh0M/BOAaD9
         ARebNxoHOvYc4+h8nX3dYiA4ASrfoBZw+PtKvaDVCwv8CEtNux6iZ46m7efurvObQfKa
         pgRycL6/yDCFdXCxwCz2QfxOGdAsLD+tVl05QF2XfsTkXbk+27DnGXntvqhDOIaLbdua
         VjKUUQkR0jHnr0i/di/mlHqms2aF9AyPaAlyMuHaHfPx/5aXe43ZgQt8cORCWgcVX9tP
         HkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bKBtP0ujyc6cQVOrIcuXYWFHroSBLTISizcx1XMf6ng=;
        b=hxQMWSqIAekJt3fgRtIaBuu74+HaXclBjrIp0ZSo0N62ZusR08rIh35snlcpNvbTp7
         fMcSrZ6UZEkkazuNNXF+PDmZlVHBJZqawP/IU5VHzoJH8JiJBpUeab6a8FL0LMPOxWNh
         lmRbk7ufxzJ+/GefGmPEll/NyrOJsKRnRLanI20dsttlvRFM9npNw/HCCDnMvJodygFO
         O3yhj+C/cBZtxepsA4052amM2uogEmMnEmh4zSIN75K96bmzW1GvUcVp5I91bKPGHIlf
         lFv9nnPwLl8rQfZjxhuO4Phyx+wPxaGmrP9EK1X2wjYxI7im/TMaWXXqqn1JluORTrva
         nJEw==
X-Gm-Message-State: AOAM530Sw/5gQ0d5+tFuwa/2pCgOQraK302mFV9Yeccay32PZSkff47E
        t1T3skGz3Tkd3tcSRbhsEC3SAnBXIT46Tw==
X-Google-Smtp-Source: ABdhPJxenKO35fQ9lSRNBaYbfhGQdNs1hYB3lDMu7W+9q6jWyjKxp/Vymq+bjrw9ziIpsiADY/vacg==
X-Received: by 2002:a37:7106:: with SMTP id m6mr10003822qkc.412.1602191449434;
        Thu, 08 Oct 2020 14:10:49 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:9294])
        by smtp.gmail.com with ESMTPSA id r13sm4690244qtp.94.2020.10.08.14.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 14:10:48 -0700 (PDT)
Date:   Thu, 8 Oct 2020 17:09:17 -0400
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
Message-ID: <20201008210917.GC163830@cmpxchg.org>
References: <20200909215752.1725525-1-shakeelb@google.com>
 <20200928210216.GA378894@cmpxchg.org>
 <20200929150444.GG2277@dhcp22.suse.cz>
 <20200929215341.GA408059@cmpxchg.org>
 <CALvZod5eN0PDtKo8SEp1n-xGvgCX9k6-OBGYLT3RmzhA+Q-2hw@mail.gmail.com>
 <20201001143149.GA493631@cmpxchg.org>
 <CALvZod59cU40A3nbQtkP50Ae3g6T2MQSt+q1=O2=Gy9QUzNkbg@mail.gmail.com>
 <20201008145336.GA163830@cmpxchg.org>
 <CALvZod5-EtB0jNi9DXTmLSKrUzK2jXRhW8h6+7sqB356k0t1+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5-EtB0jNi9DXTmLSKrUzK2jXRhW8h6+7sqB356k0t1+g@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 08, 2020 at 08:55:57AM -0700, Shakeel Butt wrote:
> On Thu, Oct 8, 2020 at 7:55 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Oct 06, 2020 at 09:55:43AM -0700, Shakeel Butt wrote:
> > > On Thu, Oct 1, 2020 at 7:33 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > [snip]
> > > > > >    So instead of asking users for a target size whose suitability
> > > > > >    heavily depends on the kernel's LRU implementation, the readahead
> > > > > >    code, the IO device's capability and general load, why not directly
> > > > > >    ask the user for a pressure level that the workload is comfortable
> > > > > >    with and which captures all of the above factors implicitly? Then
> > > > > >    let the kernel do this feedback loop from a per-cgroup worker.
> > > > >
> > > > > I am assuming here by pressure level you are referring to the PSI like
> > > > > interface e.g. allowing the users to tell about their jobs that X
> > > > > amount of stalls in a fixed time window is tolerable.
> > > >
> > > > Right, essentially the same parameters that psi poll() would take.
> > >
> > > I thought a bit more on the semantics of the psi usage for the
> > > proactive reclaim.
> > >
> > > Suppose I have a top level cgroup A on which I want to enable
> > > proactive reclaim. Which memory psi events should the proactive
> > > reclaim should consider?
> > >
> > > The simplest would be the memory.psi at 'A'. However memory.psi is
> > > hierarchical and I would not really want the pressure due limits in
> > > children of 'A' to impact the proactive reclaim.
> >
> > I don't think pressure from limits down the tree can be separated out,
> > generally. All events are accounted recursively as well. Of course, we
> > remember the reclaim level for evicted entries - but if there is
> > reclaim triggered at A and A/B concurrently, the distribution of who
> > ends up reclaiming the physical pages in A/B is pretty arbitrary/racy.
> >
> > If A/B decides to do its own proactive reclaim with the sublimit, and
> > ends up consuming the pressure budget assigned to proactive reclaim in
> > A, there isn't much that can be done.
> >
> > It's also possible that proactive reclaim in A keeps A/B from hitting
> > its limit in the first place.
> >
> > I have to say, the configuration doesn't really strike me as sensible,
> > though. Limits make sense for doing fixed partitioning: A gets 4G, A/B
> > gets 2G out of that. But if you do proactive reclaim on A you're
> > essentially saying A as a whole is auto-sizing dynamically based on
> > its memory access pattern. I'm not sure what it means to then start
> > doing fixed partitions in the sublevel.
> >
> 
> Think of the scenario where there is an infrastructure owner and the
> large number of job owners. The aim of the infra owner is to reduce
> cost by stuffing as many jobs as possible on the same machine while
> job owners want consistent performance.
> 
> The job owners usually have meta jobs i.e. a set of small jobs that
> run on the same machines and they manage these sub-jobs themselves.
>
> The infra owner wants to do proactive reclaim to trim the current jobs
> without impacting their performance and more importantly to have
> enough memory to land new jobs (We have learned the hard way that
> depending on global reclaim for memory overcommit is really bad for
> isolation).
>
> In the above scenario the configuration you mentioned might not be
> sensible is really possible. This is exactly what we have in prod.

I apologize if my statement was worded too broadly. I fully understand
your motivation and understand the sub job structure. It's more about
at which level to run proactive reclaim when there are sub-domains.

You said you're already using a feedback loop to adjust proactive
reclaim based on refault rates. How do you deal with this issue today
of one subgroup potentially having higher refaults due to a limit?

It appears that as soon as the subgroups can age independently, you
also need to treat them independently for proactive reclaim. Because
one group hitting its pressure limit says nothing about its sibling.

If you apply equal reclaim on them both based on the independently
pressured subjob, you'll under-reclaim the siblings.

If you apply equal reclaim on them both based on the unpressured
siblings alone, you'll over-pressurize the one with its own limit.

This seems independent of the exact metric you're using, and more
about at which level you apply pressure, and whether reclaim
subdomains created through a hard limit can be treated as part of a
larger shared pool or not.
