Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A73924C72B
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 23:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgHTVZ5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 17:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgHTVZ4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 17:25:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF47DC061386
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 14:25:54 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so3718922ljc.3
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 14:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qg7ruuG7drWC0btRbr1uOGU4H3EwWSnI1pvnZe6oIgQ=;
        b=WYASPIx5hMDjYGgzF+G0RR6vw6melkP0mguy36kGh/wXS2V3ohz4Yii1y0Dtu6iU+C
         lgRRuCa0Yz5B35a2ewWAKf33bxKi/ZqAeyD8rQWw85LdFb2z8gOVCfCrvbQvZJodRNNh
         93t7iBP1COzAj3azTPFpmNT9k287RMuDfF0QdK0dNPN9GZd/Pm2A1vVPjU1lJWZkZaHf
         nU6xPpk8TwGTW75Mc7AKO0NSOXk++jx1+LU8HnsQ1FWGYEidvRi3cymONp0dCcu0QeUG
         4+nCMyIA/qqZc1mDImkpEjw/YDWEjMczSHz8TTIH2lTkWLwJ5jB54ykxBxVdOEh8OdXx
         YVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qg7ruuG7drWC0btRbr1uOGU4H3EwWSnI1pvnZe6oIgQ=;
        b=oSrqoljcvwK4HrWv3CSNRoMduyat1SpHCvY7eVTb6Dp8LIvh40+1YGlitvgnb9wXbR
         F3mIywaq12smKjN8DvH+VKu3TD+dfACCqMa951RMReKdScmlXcoSKDLHA5nlB0E8VG6l
         4A48zPoLbrHYduvD2dwsDFrz3ewWPfYAd2RI5//GyFPUak+DaJRaMygFSVt5C4czU27b
         fcuoD9jru/X9Uo8vJbErzN2ZIZnEzD91zmeg48o91bgrsultgevlyI/FmgJJWKBmms1e
         7jNu9YPRyD6VaiBIoEkhcpwb7mfDJR5t1WAJdQEvcpFav6wi5cPRyJz1WxrZN4vqDGLY
         /mJg==
X-Gm-Message-State: AOAM530CcIQkc8iYwGBf3LnHutxLkf17qPxx/66ezc+V1tzp1p0PFFGp
        LhjX49ItNf6H+UUYfYPvrJBlkY6at1dzjxbn6aVrtQ==
X-Google-Smtp-Source: ABdhPJzqYADzY46O//FIwuGauKEriUJHxgBT1Pgq+Qn+KFzEpsr1NawCQfd1pK50vIf1JrU/YAnSLFtnkF/7XxmoXBo=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr121322ljh.446.1597958752359;
 Thu, 20 Aug 2020 14:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200820130350.3211-1-longman@redhat.com> <20200820130350.3211-3-longman@redhat.com>
 <20200820173546.GB912520@cmpxchg.org> <a3d4783b-5aee-da40-06c0-ac63e292ccdb@redhat.com>
In-Reply-To: <a3d4783b-5aee-da40-06c0-ac63e292ccdb@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 14:25:41 -0700
Message-ID: <CALvZod6GARMuO8YzMp-1FZaasSZJ8t2b9dUu5tXUcDeuHxA6KA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/memcg: Simplify mem_cgroup_get_max()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 20, 2020 at 1:29 PM Waiman Long <longman@redhat.com> wrote:
>
> On 8/20/20 1:35 PM, Johannes Weiner wrote:
> > On Thu, Aug 20, 2020 at 09:03:49AM -0400, Waiman Long wrote:
> >> The mem_cgroup_get_max() function used to get memory+swap max from
> >> both the v1 memsw and v2 memory+swap page counters & return the maximum
> >> of these 2 values. This is redundant and it is more efficient to just
> >> get either the v1 or the v2 values depending on which one is currently
> >> in use.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >>   mm/memcontrol.c | 14 +++++---------
> >>   1 file changed, 5 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index 26b7a48d3afb..d219dca5239f 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -1633,17 +1633,13 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
> >>    */
> >>   unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
> >>   {
> >> -    unsigned long max;
> >> +    unsigned long max = READ_ONCE(memcg->memory.max);
> >>
> >> -    max = READ_ONCE(memcg->memory.max);
> >>      if (mem_cgroup_swappiness(memcg)) {
> >> -            unsigned long memsw_max;
> >> -            unsigned long swap_max;
> >> -
> >> -            memsw_max = memcg->memsw.max;
> >> -            swap_max = READ_ONCE(memcg->swap.max);
> >> -            swap_max = min(swap_max, (unsigned long)total_swap_pages);
> >> -            max = min(max + swap_max, memsw_max);
> >> +            if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >> +                    max += READ_ONCE(memcg->swap.max);
> >> +            else
> >> +                    max = memcg->memsw.max;
> > I agree with the premise of the patch, but v1 and v2 have sufficiently
> > different logic, and the way v1 overrides max from the innermost
> > branch again also doesn't help in understanding what's going on.
> >
> > Can you please split out the v1 and v2 code?
> >
> >       if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> >               max = READ_ONCE(memcg->memory.max);
> >               if (mem_cgroup_swappiness(memcg))
> >                       max += READ_ONCE(memcg->swap.max);
> >       } else {
> >               if (mem_cgroup_swappiness(memcg))
> >                       max = memcg->memsw.max;
> >               else
> >                       max = READ_ONCE(memcg->memory.max);
> >       }
> >
> > It's slightly repetitive, but IMO much more readable.
> >
> Sure. That makes it even better.
>

Can you please also add in the commit message why it is ok to drop
total_swap_pages comparison from mem_cgroup_get_max()?
