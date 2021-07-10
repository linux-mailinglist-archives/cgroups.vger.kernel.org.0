Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A983C31F9
	for <lists+cgroups@lfdr.de>; Sat, 10 Jul 2021 04:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhGJCsT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 22:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236096AbhGJCsQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 22:48:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E438CC0774CE
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 19:41:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id o139so17478198ybg.9
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 19:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vaOH/a0ClI8BnfBSu2/Cfw1Ys0GE4IDd1evZ+TmP3ZA=;
        b=fqGFrgFBt2diwQKiTqZZNApiNANthCTvwlWzLq1LGuz4MZomNQvLrXmIZgsBA2SFKd
         hjmdLhO4u6AYDcGOz2gZc3+/t8rJb1EjoQxXMtEtpg5OmELvHgf5PqtxzU0C25KBkbrb
         F7rzClNNXbt2XSIsjAbC2Sp7Do2sMEc2OhIwS+P9W+DV1Pau5Oim5iwMrL8F4l4ehCde
         7hxae14TM0EPT7UjMovs2uOxao8RC9KHrfKLSIu0KG7jC5ZIipR9n0fgZBYHic7gKUMg
         Yn6MyAYOKSIeWEy3dRFWFKPw0RcSj8l3FaXi8i1b0a7VIKiv0of7ClqqVplpAQFw8QvN
         1VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vaOH/a0ClI8BnfBSu2/Cfw1Ys0GE4IDd1evZ+TmP3ZA=;
        b=eh2pmkJI5MwL94Hhng2s1t1fVaSdv0AyS9nlcsrWEfwzjocu7QDPuJEVK6scE7QZSn
         YO8X7pn05ehNGmnmt+mFALhSpNY433HoMGNBwobDKf6jzXm8dGiQpLUo47leIL7QxqQI
         kRcpYUIfdPthOHstPaIW6jn+LDJ40rnQVnlHvKe1HKYeb07RN7YCirFJJUc9IAe8ePKO
         7u2GcbG+hJiVpUmqq/JnVsZWke9nzlrBS3j/KWNUN55odFCU33VVMOh3o/z4yf72t9Zb
         7qQuYl5Y3Ph8U6Gi0ZWWKOyguczjvS7QqW39Ddi3M1oOXnxOfVpbhi+ioTYf02DK85aj
         aU2A==
X-Gm-Message-State: AOAM533e4IpQXP39oLYVmSMnMZB2eOAwipC1jxttzRqKeizwanXaPGsV
        qN5vtqHeXQUwX9Ece8N+37H3vBTiaoCi0Ctkk7Qx0A==
X-Google-Smtp-Source: ABdhPJy7qqHRX2CAmAe4p2VINq/yJeKUxUZqu2Ihaq6YYMsoz4JKJFb+DjSJ/HrYbLx8yVhD94mMgXBYXn7exUad/Uk=
X-Received: by 2002:a25:9945:: with SMTP id n5mr47307594ybo.294.1625884869986;
 Fri, 09 Jul 2021 19:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com> <b29493f5-34d9-6e8f-ec41-179a043641f4@huawei.com>
In-Reply-To: <b29493f5-34d9-6e8f-ec41-179a043641f4@huawei.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jul 2021 19:40:58 -0700
Message-ID: <CAJuCfpEGEoA9Pb8iLdXNH9Q3fiGEaNkKWM6p+M1KzE69cmEJww@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        richard.weiyang@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, apopple@nvidia.com,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 9, 2021 at 6:52 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2021/7/10 8:36, Suren Baghdasaryan wrote:
> > Add mem_cgroup_disabled check in vmpressure, mem_cgroup_uncharge_swap and
> > cgroup_throttle_swaprate functions. This minimizes the memcg overhead in
> > the pagefault and exit_mmap paths when memcgs are disabled using
> > cgroup_disable=memory command-line option.
> > This change results in ~2.1% overhead reduction when running PFT test
> > comparing {CONFIG_MEMCG=n, CONFIG_MEMCG_SWAP=n} against {CONFIG_MEMCG=y,
> > CONFIG_MEMCG_SWAP=y, cgroup_disable=memory} configuration on an 8-core
> > ARM64 Android device.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/memcontrol.c | 3 +++
> >  mm/swapfile.c   | 3 +++
> >  mm/vmpressure.c | 7 ++++++-
> >  3 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ae1f5d0cb581..a228cd51c4bd 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7305,6 +7305,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
> >       struct mem_cgroup *memcg;
> >       unsigned short id;
> >
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +
> >       id = swap_cgroup_record(entry, 0, nr_pages);
> >       rcu_read_lock();
> >       memcg = mem_cgroup_from_id(id);
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 1e07d1c776f2..707fa0481bb4 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -3778,6 +3778,9 @@ void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
> >       struct swap_info_struct *si, *next;
> >       int nid = page_to_nid(page);
> >
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +
>
> Many thanks for your patch. But I'am somewhat confused about this change.
> IMO, cgroup_throttle_swaprate() is only related to blk_cgroup and it seems
> it's irrelevant to mem_cgroup. Could you please have a explanation for me?

cgroup_throttle_swaprate() is a NoOp when CONFIG_MEMCG=n (see:
https://elixir.bootlin.com/linux/latest/source/include/linux/swap.h#L699),
therefore I assume we can safely skip it when memcgs are disabled via
"cgroup_disable=memory". From perf results I also see no hits on this
function when CONFIG_MEMCG=n.
However, looking into the code, I'm not sure why it should depend on
CONFIG_MEMCG. But it's Friday night and I might be missing some
details here...

>
> Thanks!
>
> >       if (!(gfp_mask & __GFP_IO))
> >               return;
> >
> > diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> > index d69019fc3789..9b172561fded 100644
> > --- a/mm/vmpressure.c
> > +++ b/mm/vmpressure.c
> > @@ -240,7 +240,12 @@ static void vmpressure_work_fn(struct work_struct *work)
> >  void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
> >               unsigned long scanned, unsigned long reclaimed)
> >  {
> > -     struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
> > +     struct vmpressure *vmpr;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +
> > +     vmpr = memcg_to_vmpressure(memcg);
> >
> >       /*
> >        * Here we only want to account pressure that userland is able to
> >
>
