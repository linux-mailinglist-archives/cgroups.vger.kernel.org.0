Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C683921AC
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbhEZUyP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 16:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhEZUyM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 16:54:12 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00123C061574
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 13:52:38 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f30so4612127lfj.1
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4rL4ZNue6Ljpbr80Um7+WtGuIj1VHDvK86mKdNmljQ=;
        b=sou9i15FmrPZqYAW4inB0oXUePHg0dRp+/RQm+k2ORf8kOWxRnW3uSS71J5nwMaBqy
         hQwrVYiPiha0h2fhKhCMQfklVYVgAvDFzKiH3OJ7eYfJOCjlA7yXPGZB3K6QokT2kDbE
         BaWSb6lnnvAEsw38nWWwbYGzjCNEgHmgtKm3rJIgiou4Av8AKKLfD706jIBaq1MJBUKY
         ewD3FlJtjbTCsOOIoDR6QHYJvjvMMPQlN5Tq1aWIdWifiHynqj6GwJmLEH4DCBa6Egsf
         y4tn2m1jfxW8EmFyHq6X1J03bsASNtdsmlS6BqBAvNJzfzK/bSYTX6lA0jqM2zKpeu3P
         531Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4rL4ZNue6Ljpbr80Um7+WtGuIj1VHDvK86mKdNmljQ=;
        b=eFmg2tfyyi13ZaRmJNPdEBQa+tWvEw4X7mZlNBSQijwuF8ImJkAwk3qdSpf2faZTnQ
         cYR5cyxmBnlzu3En3Sru3QYQAgfEZnDuDyuEypT8w+rGXN0ZP0CMEJy7+SjOhEMooszK
         H3tIuNbiljcJlg6mlw6zIgYBb2DSGuGjTyXXHmsyA8F05wGLwRiEnV/AL83rysxb7hP8
         C5dg8E7HeIfXVIko9dfOpm+pDh8Fbv3dWb0L12kT4sYQxn0hgzMZqvdzAQPB78TVMcdj
         U/jZ+bZX+iPBhPfDnQ8xxALIKweoTEGZ5Nr9QklF9ZJ+5ADysoPGjdOKi7lVmH8ejL9T
         n6FQ==
X-Gm-Message-State: AOAM533B1OBYDvxltUlkHb/5IPTRFF5jNAvcu1+pYo1UGIjukFItczJY
        52I9FVTKPoTtcQ80MIyJKILODNlcfS57OIVbd3Zw/g==
X-Google-Smtp-Source: ABdhPJwbnWpyjCdp46SN7EoPPCbkv3U+ZcVSvpKDfnIKAI1oe0JpIh3gcZhBR4hmFx7O7/PlK040iDkwytg1jCn3FEo=
X-Received: by 2002:a05:6512:3da3:: with SMTP id k35mr3254389lfv.347.1622062356909;
 Wed, 26 May 2021 13:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622043596.git.yuleixzhang@tencent.com>
In-Reply-To: <cover.1622043596.git.yuleixzhang@tencent.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 May 2021 13:52:25 -0700
Message-ID: <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
To:     yulei zhang <yulei.kernel@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <christian@brauner.io>,
        Cgroups <cgroups@vger.kernel.org>, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Adding linux-mm and related folks.



On Wed, May 26, 2021 at 9:18 AM <yulei.kernel@gmail.com> wrote:
>
> From: Yulei Zhang <yuleixzhang@tencent.com>
>
> In this patch set we present the idea to suppress the memory allocation
> speed in memory cgroup, which aims to avoid direct reclaim caused by
> memory allocation burst while under memory pressure.
>

I am assuming here direct reclaim means global reclaim.

> As minimum watermark could be easily broken if certain tasks allocate
> massive amount of memory in a short period of time, in that case it will
> trigger the direct memory reclaim and cause unacceptable jitters for
> latency critical tasks, such as guaranteed pod task in K8s.
>
> With memory allocation speed throttle(mst) mechanism we could lower the
> memory allocation speed in certian cgroup, usually for low priority tasks,
> so that could avoid the direct memory reclaim in time.

Can you please explain why memory.high is not good enough for your
use-case? You can orchestrate the memory.high limits in such a way
that those certain cgroups hit their memory.high limit before causing
the global reclaim. You might need to dynamically adjust the limits
based on other workloads or unaccounted memory.

>
> And per-memcg interfaces are introduced under memcg tree, not visiable for
> root memcg.
> - <cgroup_root>/<cgroup_name>/memory.alloc_bps
>  - 0 -> means memory speed throttle disabled
>  - non-zero -> value in bytes for memory allocation speed limits
>
> - <cgroup_root>/<cgroup_name>/memory.stat:mst_mem_spd_max
>   it records the max memory allocation speed of the memory cgroup in the
>   last period of time slice
>
> - <cgroup_root>/<cgroup_name>/memory.stat:mst_nr_throttled
>   it represents the number of times for allocation throttling
>
> Yulei Zhang (7):
>   mm: record total charge and max speed counter in memcg
>   mm: introduce alloc_bps to memcg for memory allocation speed throttle
>   mm: memory allocation speed throttle setup in hierarchy
>   mm: introduce slice analysis into memory speed throttle mechanism
>   mm: introduce memory allocation speed throttle
>   mm: record the numbers of memory allocation throttle
>   mm: introduce mst low and min watermark
>
>  include/linux/memcontrol.h   |  23 +++
>  include/linux/page_counter.h |   8 +
>  init/Kconfig                 |   8 +
>  mm/memcontrol.c              | 295 +++++++++++++++++++++++++++++++++++
>  mm/page_counter.c            |  39 +++++
>  5 files changed, 373 insertions(+)
>
> --
> 2.28.0
>
