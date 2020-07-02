Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4702127B0
	for <lists+cgroups@lfdr.de>; Thu,  2 Jul 2020 17:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgGBPWZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jul 2020 11:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgGBPWY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jul 2020 11:22:24 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8775C08C5C1
        for <cgroups@vger.kernel.org>; Thu,  2 Jul 2020 08:22:23 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g139so16457269lfd.10
        for <cgroups@vger.kernel.org>; Thu, 02 Jul 2020 08:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uibEynu9caySlMhz/bcWJ3z7yd2MwyAMeTu6m4gB4zc=;
        b=RK3GXi1aY7MEN+2tdQDYtYDkP2NKLLfuyONsx/qMFu5vMGiUeJ/EgWLsCvzj7eHo71
         qCetpDEr0Kc60UJaafyl8JNrJP/G/rDmX+Z1H3aVCLacD74uEbKgOZIf9Gq3JTWFgrsk
         DSgPufYXy45QK2vdrFiD6QUUydkIBc9FZ86OULQeiIi9gdQvYrfqsZ4ZhiMAscR/Symi
         7vNydxRvLI5UfDomaSdR8V0MpzjtJ0R8Oz8IVogo0jweNskHD30tPIZR7jmxzU+KlJAk
         /SdLdHG2uzOLb16MATHJgbD8P/e791l3j9AZ7yHzuAJxWTWU87mwYDDSFPqLZOsUe8kU
         hb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uibEynu9caySlMhz/bcWJ3z7yd2MwyAMeTu6m4gB4zc=;
        b=bhsLnblgXDEYZKr9HprGa0soT7QmotYyPC2K8myHiTuBewaR4Sempp2rjiPnaq7RDt
         nkDtqrfSCjue4B1XBvB9aud1rxUPpkLutnXPrX0WfhMk9EyY9LUBh+/6/eoKLnqKMyOI
         SQ86OrY3rlWdOqUUvtG/QkoYB/drU4TlzMZLpXmH2yAiAUMRJUKtQDXjoHR4KR2RZzMc
         3Eh6Et/01IYDCKPsDXL3jdQioC35nZCHQcNPvWkWI3RTuDLY8TTLhFu0OMTlPfFMmwM7
         TKDmaC+w4EbJFioKVHq1Q/bjyg6Yps2ef7lBlOj8ZP4/XPLA1rvRi8NeACQlKvYh969h
         YTWg==
X-Gm-Message-State: AOAM531WuwzspezSkc4bvM2UaOm2ZzGCRAWPA7k1jg8mZUO1mBzO3LPX
        URPc8rLHNtjKo4b05cms8N1ITRJS6mya2euPS1W8hw==
X-Google-Smtp-Source: ABdhPJymxrHUoM7Aur1RTVcKEJSXASLPqIoUTB2V7nkFrCYLdjWGjzu128+2jK3XpBjhgOOdGIcouLK3OxSlp7PTK9Q=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr18422051lfq.3.1593703341896;
 Thu, 02 Jul 2020 08:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.22.394.2006281445210.855265@chino.kir.corp.google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Jul 2020 08:22:10 -0700
Message-ID: <CALvZod5Zv33oNLxS_8TyGV_QT4CsBjiEuocxpt2+U-XDMaFDPw@mail.gmail.com>
Subject: Re: Memcg stat for available memory
To:     David Rientjes <rientjes@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(Adding more people who might be interested in this)


On Sun, Jun 28, 2020 at 3:15 PM David Rientjes <rientjes@google.com> wrote:
>
> Hi everybody,
>
> I'd like to discuss the feasibility of a stat similar to
> si_mem_available() but at memcg scope which would specify how much memory
> can be charged without I/O.
>
> The si_mem_available() stat is based on heuristics so this does not
> provide an exact quantity that is actually available at any given time,
> but can otherwise provide userspace with some guidance on the amount of
> reclaimable memory.  See the description in
> Documentation/filesystems/proc.rst and its implementation.
>
>  [ Naturally, userspace would need to understand both the amount of memory
>    that is available for allocation and for charging, separately, on an
>    overcommitted system.  I assume this is trivial.  (Why don't we provide
>    MemAvailable in per-node meminfo?) ]
>
> For such a stat at memcg scope, we can ignore totalreserves and
> watermarks.  We already have ~precise (modulo MEMCG_CHARGE_BATCH) data for
> both file pages and slab_reclaimable.
>
> We can infer lazily free memory by doing
>
>         file - (active_file + inactive_file)
>
> (This is necessary because lazy free memory is anon but on the inactive
>  file lru and we can't infer lazy freeable memory through pglazyfree -
>  pglazyfreed, they are event counters.)
>
> We can also infer the number of underlying compound pages that are on
> deferred split queues but have yet to be split with active_anon - anon (or
> is this a bug? :)
>
> So it *seems* like userspace can make a si_mem_available()-like
> calculation ("avail") by doing
>
>         free = memory.high - memory.current
>         lazyfree = file - (active_file + inactive_file)
>         deferred = active_anon - anon
>
>         avail = free + lazyfree + deferred +
>                 (active_file + inactive_file + slab_reclaimable) / 2
>
> For userspace interested in knowing how much memory it can charge without
> incurring I/O (and assuming it has knowledge of available memory on an
> overcommitted system), it seems like:
>
>  (a) it can derive the above avail amount that is at least similar to
>      MemAvailable,
>
>  (b) it can assume that all reclaim is considered equal so anything more
>      than memory.high - memory.current is disruptive enough that it's a
>      better heuristic than the above, or
>
>  (c) the kernel provide an "avail" stat in memory.stat based on the above
>      and can evolve as the kernel implementation changes (how lazy free
>      memory impacts anon vs file lru stats, how deferred split memory is
>      handled, any future extensions for "easily reclaimable memory") that
>      userspace can count on to the same degree it can count on
>      MemAvailable.
>
> Any thoughts?


I think we need to answer two questions:

1) What's the use-case?
2) Why is user space calculating their MemAvailable themselves not good?

The use case I have in mind is the latency sensitive distributed
caching service which would prefer to reduce the amount of its caching
over the stalls incurred by hitting the limit. Such applications can
monitor their MemAvailable and adjust their caching footprint.

For the second, I think it is to hide the internal implementation
details of the kernel from the user space. The deferred split queues
is an internal detail and we don't want that exposed to the user.
Similarly how lazyfree is implemented (i.e. anon pages on file LRU)
should not be exposed to the users.

Shakeel
