Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51D93A8B6B
	for <lists+cgroups@lfdr.de>; Tue, 15 Jun 2021 23:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFOVyz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Jun 2021 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOVyz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Jun 2021 17:54:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38FCC06175F
        for <cgroups@vger.kernel.org>; Tue, 15 Jun 2021 14:52:49 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l4so864186ljg.0
        for <cgroups@vger.kernel.org>; Tue, 15 Jun 2021 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XQnzVjTuP7aBILPyoyVQYQXqE/KQql4/BGG/kkVsjE=;
        b=gGfsNADVzHheLJtshFSvaD/DGD7MMjGpXn9cuW+cqCUX2Xd2zmn5p3v+yDXFjhYjtK
         PDLnOr1KKcT1OLCV6DmMntBGhrfUy0fxFML9PTdLQwix8Sd1hhPKRkJq6T0G7E4Ih+NA
         bygB5L8TqSiTWvrpf2PeCWl4nP29lwEvs0p8hAUMjE225soFkN2+WNABhSNuB+euV8Q/
         HSj4o5EqiwXTsqhpK8SRG3q2fz0JovM5ppq9RUlGel+tygTg+OEql0sia8kFjIp7n0lC
         rSEFJnNMUDNnbVoVZyuQrRWa9O1SgCOtrk9ljun/mmLILGGgE16kacXSjSAUEPM4K2jZ
         iBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XQnzVjTuP7aBILPyoyVQYQXqE/KQql4/BGG/kkVsjE=;
        b=BViA92EdaqnfnkeXp96hdX65P9ZndtV4+JIEXsakn8xh5svkzIMqTguBWO08mN2AQd
         Do8CNCZQ2sZb+iQ+Buek9Ci1FS6SgKpJZkJvr9o42L9uZkw2vJu1b8ctzp2vFCQ9a3Eu
         Qdgbj5dGUPlhc70BsmjnrKgiBw0HYigz5QhSe5954OW00B2wwmGwiLgPE0jUghdYBtPp
         HL1Wm2UakEaNbqt0WpyoGyD+2M+5sfnBpwmSRrXmYnz/LmtosFupu5ulakX6i9IKgGx/
         NnIxOaKkEkxIfT2KgkOKdoMGRgPAiQJM6xxdYpA0P4MV11LmEeBIItd+LP4lQKLHx9yr
         NZSA==
X-Gm-Message-State: AOAM530iZafHQVesB4UFd/f8JtsL4ddillEVPpp16mvL2Nbl4BdM5cyG
        m/ZxjoQ1G6ZkoZ0ksyF/IrkGvGZTI44FuYHUvMCuJQ==
X-Google-Smtp-Source: ABdhPJwJu/tvSMtLHSaZgYb0ugWasxEscMYkOfpr1bpGAqWcyf39Efy4gbX1yv+dRzvE6RNhfOZX1SkRbib2UJyn5IE=
X-Received: by 2002:a05:651c:3c6:: with SMTP id f6mr1450704ljp.456.1623793968085;
 Tue, 15 Jun 2021 14:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210615174435.4174364-1-shakeelb@google.com> <20210615174435.4174364-2-shakeelb@google.com>
 <YMj/s26uF+cQOB2D@cmpxchg.org>
In-Reply-To: <YMj/s26uF+cQOB2D@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 15 Jun 2021 14:52:37 -0700
Message-ID: <CALvZod6Hpema0uMcnMGPS+_2iZuxc8JqkjHRVBeEGp-vdcpPYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] memcg: periodically flush the memcg stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 15, 2021 at 12:29 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hey Shakeel,
>
> On Tue, Jun 15, 2021 at 10:44:35AM -0700, Shakeel Butt wrote:
> > At the moment memcg stats are read in four contexts:
> >
> > 1. memcg stat user interfaces
> > 2. dirty throttling
> > 3. page fault
> > 4. memory reclaim
> >
> > Currently the kernel flushes the stats for first two cases. Flushing the
> > stats for remaining two casese may have performance impact. Always
> > flushing the memcg stats on the page fault code path may negatively
> > impacts the performance of the applications. In addition flushing in the
> > memory reclaim code path, though treated as slowpath, can become the
> > source of contention for the global lock taken for stat flushing because
> > when system or memcg is under memory pressure, many tasks may enter the
> > reclaim path.
> >
> > Instead of synchronously flushing the stats, this patch adds support of
> > asynchronous periodic flushing of the memcg stats. For now the flushing
> > period is hardcoded to 2*HZ but that can be changed later through maybe
> > sysctl if need arise.
>
> I'm concerned that quite a lot can happen in terms of reclaim and page
> faults in 2 seconds. It's conceivable that the error of a fixed 2s
> flush can actually exceed the error of a fixed percpu batch size.
>

Yes, that is possible.

> The way the global vmstat implementation manages error is doing both:
> ratelimiting and timelimiting. It uses percpu batching to limit the
> error when it gets busy, and periodic flushing to limit the length of
> time consumers of those stats could be stuck trying to reach a state
> that the batching would otherwise prevent from being reflected.
>
> Maybe we can use a combination of ratelimiting and timelimiting too?
>
> We shouldn't flush on every fault, but what about a percpu ratelimit
> that would at least bound the error to NR_CPU instead of nr_cgroups?
>

Couple questions here:

First, to convert the error bound to NR_CPU from nr_cgroups, I think
we have to move from (delta > threshold) comparison to
(num_update_events > threshold). Previously an increment event
followed by decrement would keep the delta to 0 (or same) but after
this change num_update_events would be 2. Is that ok?

Second, do we want to synchronously flush the stats when we cross the
threshold on update or asynchronously by queuing the flush with zero
delay?

> For thundering herds during reclaim: as long as they all tried to
> flush from the root, only one of them would actually need to do the
> work, and we could use trylock. If the lock is already taken, you can
> move on knowing that somebody is already doing the shared flush work.

Yes, this makes sense.
