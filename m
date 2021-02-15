Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1031B6F2
	for <lists+cgroups@lfdr.de>; Mon, 15 Feb 2021 11:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbhBOKQz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Feb 2021 05:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhBOKQx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Feb 2021 05:16:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1AEC061756
        for <cgroups@vger.kernel.org>; Mon, 15 Feb 2021 02:16:13 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id t25so3964821pga.2
        for <cgroups@vger.kernel.org>; Mon, 15 Feb 2021 02:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u1c7h/mK6g+ogVZX7ggIUmGlrcBSJghu81rDVUuKJeo=;
        b=0FW5axmzuWLUD9WPtpoYRed/CptLJiwqxxA0oC3HxYlqxYr6uBNojbzJPsUS8mQmkN
         vDFuP6SBiWLEd/VrJ+S/uJSQAFLY4Ou/4VgcHFNVse+ImTNKDedz2knB9JWla6RAZvG4
         lr8hpfYy6vGcOCg28Kh7laHBDZ1r4Fc966DYiIwHqveX9UJb6Tn+PrW7IFxOmNEG+Qmy
         CELGwkYpG5+N3Z9/e7kkZF01HzyQnlM9RAXis+9nKiHiGKOLRp+FRGv29Wz3cU/ks2TL
         WLofAn/LIf3heA08rlSbJDpfaDFRBu5ZxClran+mrYIagZ7NE1v75Ep3V9JAmUPnuY8N
         2Ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u1c7h/mK6g+ogVZX7ggIUmGlrcBSJghu81rDVUuKJeo=;
        b=AiTxaNLz87HnxnkUDsV8BhLKpdrjAaYkWSuDWORsdM4bNOcpYtsUArYBF+2oYW3hGn
         vMZVBL3LYo/st46ZidSedU8IMUkuJHD80WX4iDzeaOuvhqgCwI9CUVqqR1LWkET0KxvG
         3PzH4WW1dEVY7QgINhQHnDQR+m4tsFYrsONTmYvdKm4losWkrg2nk46USv+uj1kEquQ4
         8+8htMKTROniknn+XpLK7XTV5p6QjEdQsMvdzGf8NS2CQA24CYb7m2CJv9T9wOcStYPP
         xV9wIv21P582GgG5M3zXv9pjcmExY73TZeXnNwMOLPJMsuih3+oG8+i3/Kt4oKN56cSY
         KnFQ==
X-Gm-Message-State: AOAM5303DHBU6Ho+jZ+W3awiMx4heUXL+QD3mkLYpqDVQfC0yeY9uLeo
        1ivuufykNDfpOKJyiAKN2gmoF5Myrx61Wa51cv9B6g==
X-Google-Smtp-Source: ABdhPJxXBRGesU5JU+bVoojrO9fDffFKJjc/jDshJpJ/mTgNuxqojW5PyGi2EYKVx7xEuXMzUYS0AgT4FZp6AbjIgl0=
X-Received: by 2002:a63:1f21:: with SMTP id f33mr14468774pgf.31.1613384172566;
 Mon, 15 Feb 2021 02:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-4-songmuchun@bytedance.com> <YCpDSnLSDoE/FHK5@dhcp22.suse.cz>
In-Reply-To: <YCpDSnLSDoE/FHK5@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Feb 2021 18:15:36 +0800
Message-ID: <CAMZfGtVSXG5BRR9R3_+eeoCCWBW87GLVNLPwZCyDUHNeAPrXUw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/4] mm: memcontrol: fix swap uncharge on
 cgroup v2
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 15, 2021 at 5:47 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Sat 13-02-21 01:01:59, Muchun Song wrote:
> > The swap charges the actual number of swap entries on cgroup v2.
> > If a swap cache page is charged successful, and then we uncharge
> > the swap counter. It is wrong on cgroup v2. Because the swap
> > entry is not freed.
>
> Is there any actual problem though? Can you describe the specific
> scenario please? Swap cache charge life time is a bit tricky and I have
> to confess I have to relearn it every time I need to understand it. The
> patch would be much more easier to review if the changelog was much more
> specific.

I copied the reply to Shakeel here. :-)

IIUC, I think that we cannot limit the swap to memory.swap.max
on cgroup v2.

  cd /sys/fs/cgroup/
  mkdir test
  cd test
  echo 8192 > memory.max
  echo 4096 > memory.swap.max

OK. Now we limit swap to 1 page and memory to 2 pages.
Firstly, we allocate 1 page from this memory cgroup and
swap this page to swap disk. We can see:

  memory.current: 0
  memory.swap.current: 1

Then we touch this page, we will swap in and charge
the swap cache page to the memory counter and uncharge
the swap counter.

  memory.current: 1
  memory.swap.current: 0 (but actually we use a swap entry)

Then we allocate another 1 page from this memory cgroup.

  memory.current: 2
  memory.swap.current: 0 (but actually we use a swap entry)

If we swap those 2 pages to swap disk. We can charge and swap
those 2 pages successfully. Right? Maybe I am wrong.

>
> > Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c737c8f05992..be6bc5044150 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
> >       memcg_check_events(memcg, page);
> >       local_irq_enable();
> >
> > -     if (PageSwapCache(page)) {
> > +     if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
> >               swp_entry_t entry = { .val = page_private(page) };
> >               /*
> >                * The swap entry might not get freed for a long time,
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
