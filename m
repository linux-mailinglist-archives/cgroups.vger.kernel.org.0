Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41101AE1E6
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2020 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgDQQLs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Apr 2020 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgDQQLs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Apr 2020 12:11:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B444FC061A0C
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 09:11:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q22so2637045ljg.0
        for <cgroups@vger.kernel.org>; Fri, 17 Apr 2020 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1APeQIZSwYvgzGtI49u613t4lCqukuDkbPUvWkvPzU=;
        b=ThYKyseGRAxgJFZMUU4L4u54kmHxMZkY8P61z911368jzyeY/e9JAfj8tF2wCkj6bA
         V5ZduIWFzynFO88OwEbWxf1JjarT+nqTzButGm04VyflH+r9Ibs22c7zQFOCl29NhUP+
         6mL1TkTeUxBY9Ifi3JreaImUiuqjAcM2j0HdBQxnr+ggLD+6Y/gO+PXQsc25/Bu5zTir
         mtlHksZ3pCs3gTsN1zuxUHgTZ+LTvYuY5D0UkbrML+Oqx56cP8qPYsHh+w1C5u5R7jFV
         DqPtL7fhjmjx5VfGf9JIqqDMx5KZwBJUp60FWDviwDPbWVNroD/VGG/oNusPZ+fsQ0vD
         vEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1APeQIZSwYvgzGtI49u613t4lCqukuDkbPUvWkvPzU=;
        b=WuSm9cXaxCF4Ng2hpFnkTY+QeCUgiWb6WXG/Mk9XxBQsSLWqEwS0GAn6hILP1avCUa
         RiqmRgOqyCB7UHvt+/heJcm+RfQQukaFdA0Ac7FxJ6yW4ZvhlFfm13xsca1qCaoX0yom
         W6I1ClM686VUmASv4a8OkgssB3q+mUWuWKn4fOgbX4ll9PhNz5DOlNPtqTwpcGYGw053
         qwmm8B08wNm6p5q8dXG9EeiYfz9cnveHSVXBPDmjOdw/HFSnhwSEhN3vGsn2Jz/W3wbS
         7imkRTna1wiqf6NXBIFo5kr0ghdgoaTjI88Q30/o+Ou3H3oBorU7lWdCmG+28pcXRMNn
         4qxA==
X-Gm-Message-State: AGi0PuYU5iAoXcwYxb1WmBS+6TweJMeVCyW7GChFlHtryXywD/txhAtv
        +p/K/6XZaXz5zDNwb2vVHZOxDdIUrw4pKioO0PUSIQ==
X-Google-Smtp-Source: APiQypIMx30LE6PxP+XRRTzQjNJKcLRuAZj4sZfr/V0Hfw0WOjOF/DEC8pHQo1LUqncf2p/NKk3A4RN1eV/CC2a6XOo=
X-Received: by 2002:a2e:b6cf:: with SMTP id m15mr2549490ljo.168.1587139905662;
 Fri, 17 Apr 2020 09:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200417010617.927266-1-kuba@kernel.org>
In-Reply-To: <20200417010617.927266-1-kuba@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 Apr 2020 09:11:33 -0700
Message-ID: <CALvZod78ZUhU+yr2x1h_gv+VgVGTPnSSGKh_+fd+MeiAKreJvg@mail.gmail.com>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 16, 2020 at 6:06 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Tejun describes the problem as follows:
>
> When swap runs out, there's an abrupt change in system behavior -
> the anonymous memory suddenly becomes unmanageable which readily
> breaks any sort of memory isolation and can bring down the whole
> system.

Can you please add more info on this abrupt change in system behavior
and what do you mean by anon memory becoming unmanageable?

Once the system is in global reclaim and doing swapping the memory
isolation is already broken. Here I am assuming you are talking about
memcg limit reclaim and memcg limits are overcommitted. Shouldn't
running out of swap will trigger the OOM earlier which should be
better than impacting the whole system.

> To avoid that, oomd [1] monitors free swap space and triggers
> kills when it drops below the specific threshold (e.g. 15%).
>
> While this works, it's far from ideal:
>  - Depending on IO performance and total swap size, a given
>    headroom might not be enough or too much.
>  - oomd has to monitor swap depletion in addition to the usual
>    pressure metrics and it currently doesn't consider memory.swap.max.
>
> Solve this by adapting the same approach that memory.high uses -
> slow down allocation as the resource gets depleted turning the
> depletion behavior from abrupt cliff one to gradual degradation
> observable through memory pressure metric.
>
> [1] https://github.com/facebookincubator/oomd
>
> Jakub Kicinski (3):
>   mm: prepare for swap over-high accounting and penalty calculation
>   mm: move penalty delay clamping out of calculate_high_delay()
>   mm: automatically penalize tasks with high swap use
>
>  include/linux/memcontrol.h |   4 +
>  mm/memcontrol.c            | 166 ++++++++++++++++++++++++++++---------
>  2 files changed, 131 insertions(+), 39 deletions(-)
>
> --
> 2.25.2
>
