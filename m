Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01F61C0B26
	for <lists+cgroups@lfdr.de>; Fri,  1 May 2020 02:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgEAAAg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Apr 2020 20:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgEAAAf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Apr 2020 20:00:35 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89721C035494;
        Thu, 30 Apr 2020 17:00:35 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id 19so3417733ioz.10;
        Thu, 30 Apr 2020 17:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOWNIHM3btZ9j8NGTIPkfbXQJm50r4PKpoMQv4LKbCU=;
        b=TOA/ANfb70xaeNIZuwPe7XM6HwdhADVz6L1VFwi33HMb/y5M5WgGTtZpDZ8WlZjY+s
         xFY3SD+a5uwlNQCX0ZZ30liXUSeyUwQ4/PePP7Ta2QfGSPDRtU8sygsaBZbpQ/XD4US4
         gj99XYNqk93FaBc/yFpxyenl4NfN4hIhvPjMIgNN2tLL7WhxcWoYaOG6iC1w+kVfJ4Sh
         TWt9bMNxfD7/wzCIh5RzTmAHqnQua/zu9GmPI66+VnLZ56vD6wgxB92fHKLOlw3zA6NB
         XxrU2jcjVQS2AVlubjNuSb0wg9qgF/ANq+MixLoLAbQaEvrX0pCBj0f8Dvyi4Y4GWoEh
         S0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOWNIHM3btZ9j8NGTIPkfbXQJm50r4PKpoMQv4LKbCU=;
        b=LwN5+gy6VXZKS6S98rgz8tPf/MsKaQn7mxrcczH2kqkTNVdBH2Cynq0EMCi+Abc/Nn
         sPCz9YvADOXKZWgC/m6M6ue2SxPr7aYViSF7z5OwJIAsrfU+AcyRQnxaHHj90r/xaDaI
         VvxHQ5e6trW/KL9tWuv+REmwVMaW74g9+KZD4UJfWEHh6DLG7MNcT9fcMvql08ZDrIS7
         uQLl33mni1B2Y6r9dWnXxUxU5i/feuEeMoNKH3R+NUQs4I5gJLeoAQz2+9YB14twCZCZ
         WNLTNWHFZ2Us+GzgnJ4QMrUhPunkTAd8hoGbILX65jymCZOgx7233EYPFyr9y/n2Yr5q
         qMfw==
X-Gm-Message-State: AGi0PuZm1Lc1ddHjDaeRtSJScHAMWWwgdR1hfkqIagwALxkHvYdDM1z7
        wUvFXS1p3kkgmKwU2Z0mJ2j4XukgyYQmgPbETTs=
X-Google-Smtp-Source: APiQypI0Rcquo6Afuwt/R1LcEJK7cymRT8m2/uzj444J31+eCm4fl/hATjqRADUVj9umz79W6KdO/dbd40bqCdfKrYA=
X-Received: by 2002:a6b:7903:: with SMTP id i3mr1497420iop.66.1588291234028;
 Thu, 30 Apr 2020 17:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588092152.git.chris@chrisdown.name> <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz> <20200429140330.GA5054@cmpxchg.org>
 <20200429150414.GI28637@dhcp22.suse.cz> <20200429165627.GA24768@cmpxchg.org> <20200430145721.GF12655@dhcp22.suse.cz>
In-Reply-To: <20200430145721.GF12655@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 1 May 2020 07:59:57 +0800
Message-ID: <CALOAHbBub_oojkb5DpXUoHV=-e9PDAeVzJvKvDtyk-9Jg6_Pkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 30, 2020 at 10:57 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 29-04-20 12:56:27, Johannes Weiner wrote:
> [...]
> > I think to address this, we need a more comprehensive solution and
> > introduce some form of serialization. I'm not sure yet how that would
> > look like yet.
>
> Yeah, that is what I've tried to express earlier and that is why I would
> rather go with an uglier workaround for now and think about a more
> robust effective values calculation on top.
>

Agreed.
If there's a more robust effective values calculation on top, then we
don't need to hack it here and there.

> > I'm still not sure it's worth having a somewhat ugly workaround in
> > mem_cgroup_protection() to protect against half of the bug. If you
> > think so, the full problem should at least be documented and marked
> > XXX or something.
>
> Yes, this makes sense to me. What about the following?

Many thanks for the explaination on this workaround.
With this explanation, I think the others will have a clear idea why
we must add this ugly workaround here.


> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 1b4150ff64be..50ffbc17cdd8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -350,6 +350,42 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
>         if (mem_cgroup_disabled())
>                 return 0;
>
> +       /*
> +        * There is no reclaim protection applied to a targeted reclaim.
> +        * We are special casing this specific case here because
> +        * mem_cgroup_protected calculation is not robust enough to keep
> +        * the protection invariant for calculated effective values for
> +        * parallel reclaimers with different reclaim target. This is
> +        * especially a problem for tail memcgs (as they have pages on LRU)
> +        * which would want to have effective values 0 for targeted reclaim
> +        * but a different value for external reclaim.
> +        *
> +        * Example
> +        * Let's have global and A's reclaim in parallel:
> +        *  |
> +        *  A (low=2G, usage = 3G, max = 3G, children_low_usage = 1.5G)
> +        *  |\
> +        *  | C (low = 1G, usage = 2.5G)
> +        *  B (low = 1G, usage = 0.5G)
> +        *
> +        * For the global reclaim
> +        * A.elow = A.low
> +        * B.elow = min(B.usage, B.low) because children_low_usage <= A.elow
> +        * C.elow = min(C.usage, C.low)
> +        *
> +        * With the effective values resetting we have A reclaim
> +        * A.elow = 0
> +        * B.elow = B.low
> +        * C.elow = C.low
> +        *
> +        * If the global reclaim races with A's reclaim then
> +        * B.elow = C.elow = 0 because children_low_usage > A.elow)
> +        * is possible and reclaiming B would be violating the protection.
> +        *
> +        */
> +       if (memcg == root)
> +               return 0;
> +
>         if (in_low_reclaim)
>                 return READ_ONCE(memcg->memory.emin);
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 05b4ec2c6499..df88a22f09bc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6385,6 +6385,14 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
>
>         if (!root)
>                 root = root_mem_cgroup;
> +
> +       /*
> +        * Effective values of the reclaim targets are ignored so they
> +        * can be stale. Have a look at mem_cgroup_protection for more
> +        * details.
> +        * TODO: calculation should be more robust so that we do not need
> +        * that special casing.
> +        */
>         if (memcg == root)
>                 return MEMCG_PROT_NONE;
>
>
> > In practice, I doubt this matters all that much because limit reclaim
> > and global reclaim tend to occur in complementary
> > containerization/isolation strategies, not heavily simultaneously.
>
> I would expect that as well but this is always hard to tell.
>
> --
> Michal Hocko
> SUSE Labs



-- 
Thanks
Yafang
