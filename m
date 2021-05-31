Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB490395A29
	for <lists+cgroups@lfdr.de>; Mon, 31 May 2021 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhEaMNB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 May 2021 08:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbhEaMNA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 May 2021 08:13:00 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3932EC061574
        for <cgroups@vger.kernel.org>; Mon, 31 May 2021 05:11:20 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso10922264ote.1
        for <cgroups@vger.kernel.org>; Mon, 31 May 2021 05:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QabDEnSZP2Zk/nIpGBcw5lJ+v0F8frsBzEZMTlyQPGM=;
        b=bHgL3AKF8WE5bzHtyLSXl4V6zpvrAdWWLDQxf9SvFvoD9jSR2EevvzYsrBoZyTmCCL
         8WFwvDZrAQ9wTTEdjtXQBOswe3RO9Ly7GhHQjLwNCxiCmBGVvEW7aYwLHivyeaLwIiB1
         axN3APEE9GV/NZZJ7CZd/2rxGDQQ4rmpty8XVetA2+oIzjMGr0JiyvDMjgmPce1m8EoN
         fd//+c4gRQSfRS4XfVCwoz3HsSkpV/FLnwnWiLgQ6MKxPsVRnr4Xgnv9+I5YRZkCDoEi
         bL1eFxUuSrv7YxY+qOVTC9G26FiEOh2Pk5mywmxl15ayABi5FpGvPZ1JzyLxvjobedu+
         CU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QabDEnSZP2Zk/nIpGBcw5lJ+v0F8frsBzEZMTlyQPGM=;
        b=NSGXC4vBON/px0Iw8/LOLWcSBeRnsckfBPDOP6/HKw/TUrB9rPB50T6KmZtOS0ICfX
         gxQ0iQCjIxoxCNJnT59Of7V4NYDKrfWEtXvcz6rdjLdNJOQ6bu1N4LCU6Q+zUfctuANW
         pA0WvzQGyr/dAKjp8OE4XYrKZrHRXvn512TJe/MHyip3XTLst7FABqRt88DTS73f4cFn
         SE4LIKCyq+NGeRw/OG17XBUZg22x+2/IY/koxfucyf+D/dzkx2iDN6o97Z3ha/b7GdWA
         EXkwUxsJB0CqM8SnF1Spguceo/nOo3dyN/nUIQtVYeCiXupIn2CFliy2x8u/gxdJ05ZZ
         fd0w==
X-Gm-Message-State: AOAM530OwK/d/aaw2tIKqhaf4nB3sRsr3AfuQoYex0eY0YhnQBUqJh02
        Iajx6HKbU0NdpaWhrK9lNIijKKlx899TXoL4Gx4=
X-Google-Smtp-Source: ABdhPJwGNdECKffawoJYU1TW43FEozf9zue7wpsHD/KRczV5sAeo3LCsc8ydmrg7VN+TGkzS41g/9uAYwEqGiW1pTyg=
X-Received: by 2002:a9d:71c8:: with SMTP id z8mr16518370otj.304.1622463079619;
 Mon, 31 May 2021 05:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622043596.git.yuleixzhang@tencent.com> <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
In-Reply-To: <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Mon, 31 May 2021 20:11:08 +0800
Message-ID: <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
To:     Shakeel Butt <shakeelb@google.com>
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

On Thu, May 27, 2021 at 4:52 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> Adding linux-mm and related folks.
>
>
>
> On Wed, May 26, 2021 at 9:18 AM <yulei.kernel@gmail.com> wrote:
> >
> > From: Yulei Zhang <yuleixzhang@tencent.com>
> >
> > In this patch set we present the idea to suppress the memory allocation
> > speed in memory cgroup, which aims to avoid direct reclaim caused by
> > memory allocation burst while under memory pressure.
> >
>
> I am assuming here direct reclaim means global reclaim.
>

Yep.

> > As minimum watermark could be easily broken if certain tasks allocate
> > massive amount of memory in a short period of time, in that case it will
> > trigger the direct memory reclaim and cause unacceptable jitters for
> > latency critical tasks, such as guaranteed pod task in K8s.
> >
> > With memory allocation speed throttle(mst) mechanism we could lower the
> > memory allocation speed in certian cgroup, usually for low priority tasks,
> > so that could avoid the direct memory reclaim in time.
>
> Can you please explain why memory.high is not good enough for your
> use-case? You can orchestrate the memory.high limits in such a way
> that those certain cgroups hit their memory.high limit before causing
> the global reclaim. You might need to dynamically adjust the limits
> based on other workloads or unaccounted memory.
>

Yep, dynamically adjust the memory.high limits can ease the memory pressure
and postpone the global reclaim, but it can easily trigger the oom in
the cgroups,
which may not be suitable in certain usage cases when we want the services
alive. Using throttle to suppress the allocation may help keep the
activities and
doesn't impact others.  Thanks.

> >
> > And per-memcg interfaces are introduced under memcg tree, not visiable for
> > root memcg.
> > - <cgroup_root>/<cgroup_name>/memory.alloc_bps
> >  - 0 -> means memory speed throttle disabled
> >  - non-zero -> value in bytes for memory allocation speed limits
> >
> > - <cgroup_root>/<cgroup_name>/memory.stat:mst_mem_spd_max
> >   it records the max memory allocation speed of the memory cgroup in the
> >   last period of time slice
> >
> > - <cgroup_root>/<cgroup_name>/memory.stat:mst_nr_throttled
> >   it represents the number of times for allocation throttling
> >
> > Yulei Zhang (7):
> >   mm: record total charge and max speed counter in memcg
> >   mm: introduce alloc_bps to memcg for memory allocation speed throttle
> >   mm: memory allocation speed throttle setup in hierarchy
> >   mm: introduce slice analysis into memory speed throttle mechanism
> >   mm: introduce memory allocation speed throttle
> >   mm: record the numbers of memory allocation throttle
> >   mm: introduce mst low and min watermark
> >
> >  include/linux/memcontrol.h   |  23 +++
> >  include/linux/page_counter.h |   8 +
> >  init/Kconfig                 |   8 +
> >  mm/memcontrol.c              | 295 +++++++++++++++++++++++++++++++++++
> >  mm/page_counter.c            |  39 +++++
> >  5 files changed, 373 insertions(+)
> >
> > --
> > 2.28.0
> >
