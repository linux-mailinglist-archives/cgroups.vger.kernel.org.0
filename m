Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CEA213D8A
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2020 18:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgGCQ1e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jul 2020 12:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCQ1d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jul 2020 12:27:33 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E76C061794
        for <cgroups@vger.kernel.org>; Fri,  3 Jul 2020 09:27:33 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id h22so30494028lji.9
        for <cgroups@vger.kernel.org>; Fri, 03 Jul 2020 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KcSwCD8ehLU/B3QNKmMXqmLG2nfUoa8CRrvpDaEqynw=;
        b=aA3CxAPywsEECYk7HA55y/TnZvUHyMJa+H7L7zkuPqWu+SFym0bgvdxpKDd6b5IFKo
         lsiajzdRGT0ACjkznuQLwoDoHR/1dPiP5VltP4vTuxOUJ21D2bXNmG5QWs8GW0jw2Omx
         Tzi39QUCzgkVoA+HKdzc4bozQi7kKP8tEl99FFwHKOBcZscgh2d5GxAi4UWLOu9xu4W8
         CujI1ALU/QEdHaMY7GTwT4v3eVcYy0xRr+ugX8rAiZTTdiCBdz30ay/hr6Xiz8NucxNb
         cYmHkQvMmjHajlRViCjJK1B9fMQnj2Br/meo/+mtVi4Fbqwp+l5mpBdzx4jArAYe5q1c
         QDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KcSwCD8ehLU/B3QNKmMXqmLG2nfUoa8CRrvpDaEqynw=;
        b=AQdLFKHh9+OsEIUlC5vD70mM2r1qKkEMr61uNEVaKsnSgGYZ1iQW51Iv6qGecU5zYc
         YdsKLEqXqOQOCuvCRcg+MKX/ab6UtkDWSImsLUABUnx1wCbrPyMJHaKRk1EYvgf8yoix
         OWnv4l5EwGsAyTA94TV31RoxacW2Tbq8KkPj9Zu1JS3KITtIbiOl+Ac6i3T+FZzjwNgA
         8mLL5EbanbgnRro8f0O7jz4TVACaWufLTTxcMnDEojEvt7adk4esuCu0uCT2LjO7Zayb
         l/E0BL/aMd02EPqWt4Rqs03jTfqePmPJDXcx6oNSrl5D0kLntmmZkCobvYXZVXhBzoo6
         pAuQ==
X-Gm-Message-State: AOAM5326aTx3nIZd0dhCJC/hysU73mRUi4lI8/ESAjgf5z+Uw1G0t2az
        UinqPXoPr09S5bD9PbWI5M5I/d46jtpdNPnRMs/VtQ==
X-Google-Smtp-Source: ABdhPJytgNJa60ASLPPZfeIcxsiunKccYp8qRVzYACKj6fdI1vtw8On/o+zuRfEIOb8lyzsf+OESOnVprVcq/3zSils=
X-Received: by 2002:a2e:a58a:: with SMTP id m10mr20800065ljp.347.1593793651592;
 Fri, 03 Jul 2020 09:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152222.2630760-1-shakeelb@google.com> <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com> <20200703155021.GB114903@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200703155021.GB114903@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 3 Jul 2020 09:27:19 -0700
Message-ID: <CALvZod5Z4=1CijJp0QRnx+pdH=Me6sYPXASCxVATnshU0RW-Qw@mail.gmail.com>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 3, 2020 at 8:50 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Jul 03, 2020 at 07:23:14AM -0700, Shakeel Butt wrote:
> > On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> > > [...]
> > > > Interface options:
> > > > ------------------
> > > >
> > > > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> > > >
> > > > + simple
> > > > + can be extended to target specific type of memory (anon, file, kmem).
> > > > - most probably restricted to cgroup v2.
> > > >
> > > > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> > > >
> > > > + more general and applicable to other FSes (actually we are using
> > > > something similar for tmpfs).
> > > > + can be extended in future to just age the LRUs instead of reclaim or
> > > > some new use cases.
> > >
> > > Could you explain why memory.high as an interface to trigger pro-active
> > > memory reclaim is not sufficient. Also memory.low limit to protect
> > > latency sensitve workloads?
>
> I initially liked the proposal, but after some thoughts I've realized
> that I don't know a good use case where memory.high is less useful.
> Shakeel, what's the typical use case you thinking of?
> Who and how will use the new interface?
>
> >
> > Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
> > but note that it can also introduce stalls in the application running
> > in that memcg. Let's suppose the memory.current of a memcg is 100MiB
> > and we want to reclaim 20MiB from it, we can set the memory.high to
> > 80MiB but any allocation attempt from the application running in that
> > memcg can get stalled/throttled. I want the functionality of the
> > reclaim without potential stalls.
>
> But reclaiming some pagecache/swapping out anon pages can always
> generate some stalls caused by pagefaults, no?
>

Thanks for looking into the proposal. Let me answer both of your
questions together. I have added the two use-cases but let me explain
the proactive reclaim a bit more as we actually use that in our
production.

We have defined tolerable refault rates for the applications based on
their type (latency sensitive or not). Proactive reclaim is triggered
in the application based on their current refault rates and usage. If
the current refault rate exceeds the tolerable refault rate then
stop/slowdown the proactive reclaim.

For the second question, yes, each individual refault can induce the
stall as well but we have more control on that stall as compared to
stalls due to reclaim. For us almost all the reclaimable memory is
anon and we use compression based swap, so, the cost of each refault
is fixed and a couple of microseconds.

I think the next question is what about the refaults from disk or
source with highly variable cost. Usually the latency sensitive
applications remove such uncertainty by mlocking the pages backed by
such backends (e.g. mlocking the executable) or at least that is the
case for us.

Thanks,
Shakeel
