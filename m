Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C418311714
	for <lists+cgroups@lfdr.de>; Sat,  6 Feb 2021 00:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhBEXZE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 18:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhBEJ43 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 04:56:29 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C766C061794
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 01:55:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fa16so2899908pjb.1
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 01:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ieUooMRLCXwYSeJ9XkKaTLtXyvbKzpUTDthbUyzSnHk=;
        b=n2VvabbtalXtuWpwbmHrFHJWDgt6VXAhGhwbdn3LLJHGWqrhuY1N1pvOqWjuurIqKV
         Wt3gfI4ENRh3m8WarXLdQHKsglwcB4jQsQTM1FI2RSigJffepY0Wy71+tM3V3y4RtSSB
         QTEvWtWx/bCX+wZeWnYBnFl6sOklG98bYXTY+nRt2JTdu7ep0btUjMsqM8vHPIE8xV2S
         zPjlJw9l0v6K132xILNn5kzQSUkq1lRERXtvOqA0aviqyozZSAcyU6EafIjtfPscn7Xj
         1M1ol+Alt9uIyVWhKELcKRAaY4CmATJTQRaZlrqnPDYlaEZCc6SKLOiJF0BeWF3ngw3K
         kCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieUooMRLCXwYSeJ9XkKaTLtXyvbKzpUTDthbUyzSnHk=;
        b=Osh4ebSXviSpheqaXZYr+DFwRZuUKiTDzwPyYm0ZZqODLZiNVBAi739+24eXAwu7VW
         0l0z9lg926qsmGbmdhgmkDfpt/JaLVo7JptU8kNvMgwQRiWnZZGY5QnU4Im61ftcDkkc
         uRn2TyJQsA7kOMuGMPKC30GtMlbASKkVS8IAPTsmYDfXO65gWlGXorNu5rSnjOq2axMN
         PiPKiCkg9LEO47r/0eBEEnqTx1YXibwpa6D67TQNA+2ikTalcm4V1LNUD4LlXrCG5cwm
         5XPuEu16r6hIhegVRSHvonh2jsds20F+NcZ76dU/JHMOS++lVCjJifas4S8cLbL1G5P4
         sWSw==
X-Gm-Message-State: AOAM532RavqwJrZLAhSwXJZBoJgcTYPf5vaPw2ZY4ph/XgGyNKBANNVF
        IAw9bEssQNwCKkj/kP6E5ntCLUkmPp6LlBa5t5FRvg==
X-Google-Smtp-Source: ABdhPJxK1r8J0nG6jTXmBfGsdJeNahQkfxe4JrZpdvLIp4t6/1mUBUVkIh/l3tNLmHc08ZQ1RyE72w6OxKnOVFPQonM=
X-Received: by 2002:a17:902:9341:b029:e1:7b4e:57a8 with SMTP id
 g1-20020a1709029341b02900e17b4e57a8mr3346497plp.34.1612518947675; Fri, 05 Feb
 2021 01:55:47 -0800 (PST)
MIME-Version: 1.0
References: <20210205062310.74268-1-songmuchun@bytedance.com> <YB0Ay+epP/hnFmDS@dhcp22.suse.cz>
In-Reply-To: <YB0Ay+epP/hnFmDS@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 5 Feb 2021 17:55:10 +0800
Message-ID: <CAMZfGtWKNNhc1Jy1jzp2uZU_PM6GNWup7d=yUVk9AehKFo_CRw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: fix missing wakeup oom task
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

On Fri, Feb 5, 2021 at 4:24 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 05-02-21 14:23:10, Muchun Song wrote:
> > We call memcg_oom_recover() in the uncharge_batch() to wakeup OOM task
> > when page uncharged, but for the slab pages, we do not do this when page
> > uncharged.
>
> How does the patch deal with this?

When we uncharge a slab page via __memcg_kmem_uncharge,
actually, this path forgets to do this for us compared to
uncharge_batch(). Right?

>
> > When we drain per cpu stock, we also should do this.
>
> Can we have anything the per-cpu stock while entering the OOM path. IIRC
> we do drain all cpus before entering oom path.

You are right. I did not notice this. Thank you.

>
> > The memcg_oom_recover() is small, so make it inline.
>
> Does this lead to any code generation improvements? I would expect
> compiler to be clever enough to inline static functions if that pays
> off. If yes make this a patch on its own.

I have disassembled the code, I see memcg_oom_recover is not
inline. Maybe because memcg_oom_recover has a lot of callers.
Just guess.

(gdb) disassemble uncharge_batch
 [...]
 0xffffffff81341c73 <+227>: callq  0xffffffff8133c420 <page_counter_uncharge>
 0xffffffff81341c78 <+232>: jmpq   0xffffffff81341bc0 <uncharge_batch+48>
 0xffffffff81341c7d <+237>: callq  0xffffffff8133e2c0 <memcg_oom_recover>

>
> > And the parameter
> > of memcg cannot be NULL, so remove the check.
>
> 2bd9bb206b338 has introduced the check without any explanation
> whatsoever. I indeed do not see any potential path to provide a NULL
> memcg here. This is an internal function so the check is unnecessary
> indeed. Please make it a patch on its own.

OK. Will do this. Thanks.

>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/memcontrol.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8c035846c7a4..8569f4dbea2a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1925,7 +1925,7 @@ static int memcg_oom_wake_function(wait_queue_entry_t *wait,
> >       return autoremove_wake_function(wait, mode, sync, arg);
> >  }
> >
> > -static void memcg_oom_recover(struct mem_cgroup *memcg)
> > +static inline void memcg_oom_recover(struct mem_cgroup *memcg)
> >  {
> >       /*
> >        * For the following lockless ->under_oom test, the only required
> > @@ -1935,7 +1935,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
> >        * achieved by invoking mem_cgroup_mark_under_oom() before
> >        * triggering notification.
> >        */
> > -     if (memcg && memcg->under_oom)
> > +     if (memcg->under_oom)
> >               __wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
> >  }
> >
> > @@ -2313,6 +2313,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
> >               page_counter_uncharge(&old->memory, stock->nr_pages);
> >               if (do_memsw_account())
> >                       page_counter_uncharge(&old->memsw, stock->nr_pages);
> > +             memcg_oom_recover(old);
> >               stock->nr_pages = 0;
> >       }
> >
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
