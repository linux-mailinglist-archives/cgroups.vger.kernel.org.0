Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FFE37312F
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 22:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhEDUHc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhEDUHa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 16:07:30 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9CCC06174A
        for <cgroups@vger.kernel.org>; Tue,  4 May 2021 13:06:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h4so7498101lfv.0
        for <cgroups@vger.kernel.org>; Tue, 04 May 2021 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bicsEuUz1gvZF81DYUlP6NvUpuHppuBYNALePyNxC9g=;
        b=bNvfSVbrfIgA95/qF4ZeFRRJsvGk4NJDBuE/W5Mo3pSCABnQdq0tJklynnt2iyRivt
         9xOMr5TEYWmPqYFVpqHiDwRLKNXBwFrMNDLuFGAun6YlWgWL+rtnaFljOoB6/Gx1qSIm
         iBVni8M3rbgLVuzq1Qu2Zk24kVhwOSchxgP8/xupAYXq5ju4dW2MrHTdjEWuC9C8JM/f
         RXoTLo3gqaDhyUq5y7WB3V+oHJ6W5V2ha3OD+WXseWJNokN6WU0deSL4hmToQEUOdQmn
         EcXf4Iix1oU4U1299rFyIyIhXxCYmfP5GNGSXAK+6/acAjcQxLvg4dn1/lWs/fVeR6ZF
         /Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bicsEuUz1gvZF81DYUlP6NvUpuHppuBYNALePyNxC9g=;
        b=eK+HKEzhT7kMpOWQ9ARRd0A7soAI65ptybsq+cZt6b+6ZiDAt9sybFSWxQ9G5kTo6f
         QM6ED1pQ7/kZ1MsSKGMxbJ0ix+XMe8oxJyaMggDfgYPjBGmCaoXU4gYU3uiHlHtm/PSW
         j+hy8VaSltCEp3Mwxo3iqZwL8JrnV+PccWDx3jjwujdqOVdErwzI8bvNcJ0X/Li03xBv
         gy9X8tkbd3ucq9iTacX/nQl4dyQh69tU7x+jMCxMitAaIJwqEaDavGY9BYuOHrnQe1Lo
         E6ZmfXi+MVAEka/L04x0KGMMh4eLymkuMn+BaH+mgoX5GY+IEyPSn2wYsSkXi95c7B8/
         Uglw==
X-Gm-Message-State: AOAM532QEE8CeSoCefkQX7zYnPIVqe3xOgSpyz4BG1KLHzvsV/zG/vu8
        QKicppuyfS///VSAeA+AABbsQeIGvVROFWle0RMFZg==
X-Google-Smtp-Source: ABdhPJwKtfoljjPRo13PwAVotpRKJyTHqnYx5fpV6N1HiH3pDpyXr0DLOCZ+VOj2Zig8ET/uSnimzlZ9y/etJutPfbI=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr8642302lfr.117.1620158790666;
 Tue, 04 May 2021 13:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210504132350.4693-1-longman@redhat.com> <20210504132350.4693-2-longman@redhat.com>
 <CALvZod438=YKZtV0qckoaMkdL1seu5PiLnvPPQyRzA0S60-TpQ@mail.gmail.com> <267501a0-f416-4058-70d3-e32eeec3d6da@redhat.com>
In-Reply-To: <267501a0-f416-4058-70d3-e32eeec3d6da@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 May 2021 13:06:19 -0700
Message-ID: <CALvZod5gakHaAZfU2gH6QVNJRcX90MVSmqBpBSgCmF-Zhpz_vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
To:     Waiman Long <llong@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 4, 2021 at 1:02 PM Waiman Long <llong@redhat.com> wrote:
>
> On 5/4/21 3:37 PM, Shakeel Butt wrote:
> > On Tue, May 4, 2021 at 6:24 AM Waiman Long <longman@redhat.com> wrote:
> >> Since the merging of the new slab memory controller in v5.9, the page
> >> structure may store a pointer to obj_cgroup pointer array for slab pages.
> >> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
> >> is not readily reclaimable and doesn't need to come from the DMA buffer.
> >> So those GFP bits should be masked off as well.
> >>
> >> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
> >> that it is consistently applied no matter where it is called.
> >>
> >> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >>   mm/memcontrol.c | 8 ++++++++
> >>   mm/slab.h       | 1 -
> >>   2 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index c100265dc393..5e3b4f23b830 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -2863,6 +2863,13 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
> >>   }
> >>
> >>   #ifdef CONFIG_MEMCG_KMEM
> >> +/*
> >> + * The allocated objcg pointers array is not accounted directly.
> >> + * Moreover, it should not come from DMA buffer and is not readily
> >> + * reclaimable. So those GFP bits should be masked off.
> >> + */
> >> +#define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
> > What about __GFP_DMA32? Does it matter? It seems like DMA32 requests
> > go to normal caches.
>
> I included __GFP_DMA32 in my first draft patch. However, __GFP_DMA32 is
> not considered in determining the right kmalloc_type() (patch 2), so I
> took it out to make it consistent. I can certainly add it back.
>

No this is fine and DMA32 question is unrelated to this patch series.
