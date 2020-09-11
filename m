Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C2726628C
	for <lists+cgroups@lfdr.de>; Fri, 11 Sep 2020 17:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgIKPwt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Sep 2020 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgIKPsQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Sep 2020 11:48:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB84C061757
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 08:47:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f2so4906592pgd.3
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/FxP5cNAkpu9V91Tg3DKH/Ny09wUejGvsK8pL9rWrkk=;
        b=JniAzZ3xST4x7XGSyxnitWxVX3bZfGnuePIGwoojCFb46nGadnsTtmipUi/taEv3MZ
         8zvchl4SSbsvH1ewN5k6YLLaoCxKoT2ohERbw8u/Iyh4b8xrTSrTAYGJrPFCFHkN2bHi
         /xneXJVPG2IslDGdD76+kwU4WeWb/kq3bcMEEdW5ctkloTqq3o47htr+U5VQ77rOoQik
         9kHa4Yo6LP/+QnWj1qMZTBUYnehDmJkPbhY5waq1K7lw70HJ0Xr7u3K4xb/fr/H+Opcn
         drvtiAnFgsStlY6yvGVpTO0v4/Tbdh3VNBjwvpCbOanenPw0kl4oLdu3juldltMPRbQN
         6WRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FxP5cNAkpu9V91Tg3DKH/Ny09wUejGvsK8pL9rWrkk=;
        b=bVhIIJagetXG9n4MwsbMbFDx2ZYqpUKqtS1GXaVFAShJNZo4hxvPTABO3/gOrv14KC
         u/GmZpeiJ/7QsLB/PUgIxTcSJKzkv7BxDgKrVc5chTW1BwKcNxP2UBobIcYMMqMWNtWm
         06nf0IvPu5jiQ/nQLnqK0ph2mAKVbgEPQm1m2qbYAG8tIVaRN+nbbkBlzPVK2JTPkpYl
         gp/h/XxDp1zYqXugteruX377ShVI4sAHBRvWPCJRJtEKLJSOiVKqgaVJzgLS37vMwwdL
         74motcfuizR1nkKXwxAVC+46zw4q1eM/fZ/1t+KWHtSFpRnWgPdPGYZ9yR16zKUYi3yG
         kjvQ==
X-Gm-Message-State: AOAM531QZySadQhq/cDMO3bfaWo0DWMQGlrFnzbMf4UaIUb+G9LfQR8p
        IJxuwbttD8ekrLD8NldQ78/RnsnkPY0I/t6PxV+FGHhBZOsFFqt1
X-Google-Smtp-Source: ABdhPJxbIsZtozG0G42NrF8x3zqNun6QflXpXiIIl35qSaaCxDs5WOfSPTNN7HAstJIk+HPY/FxyJlS0/gRmPkydrOE=
X-Received: by 2002:a17:902:a70e:b029:d1:9be4:b49c with SMTP id
 w14-20020a170902a70eb02900d19be4b49cmr3056458plq.20.1599839275489; Fri, 11
 Sep 2020 08:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200910084258.22293-1-songmuchun@bytedance.com>
 <CALvZod5JQWGHUAPnj9S0pKFQreLPST441mZnp+h=fue_nnh1yQ@mail.gmail.com>
 <CAMZfGtUncFZZe2RDb54ALMt1DAVqBxAD1TQrpjei1H5nRbH6jg@mail.gmail.com> <CALvZod5_1nGJ2-QfSnYm4rCB+qvMEKAuVJrCeCyv_vQs7EoYfw@mail.gmail.com>
In-Reply-To: <CALvZod5_1nGJ2-QfSnYm4rCB+qvMEKAuVJrCeCyv_vQs7EoYfw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Sep 2020 23:47:16 +0800
Message-ID: <CAMZfGtX7UF7VSNbcutibLu7ZO-cn6jFYHURHG9ycEmkmnjB08Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Add the missing numa stat
 of anon and file for cgroup v2
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 11, 2020 at 10:55 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Sep 10, 2020 at 8:52 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Fri, Sep 11, 2020 at 12:02 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Thu, Sep 10, 2020 at 1:46 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > In the cgroup v1, we have a numa_stat interface. This is useful for
> > > > providing visibility into the numa locality information within an
> > > > memcg since the pages are allowed to be allocated from any physical
> > > > node. One of the use cases is evaluating application performance by
> > > > combining this information with the application's CPU allocation.
> > > > But the cgroup v2 does not. So this patch adds the missing information.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > >
> > > I am actually working on exposing this info on v2 as well.
> > >
> > > >  mm/memcontrol.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
> > > >  1 file changed, 44 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 75cd1a1e66c8..c779673f29b2 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -1492,10 +1492,34 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> > > >         return false;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_NUMA
> > > > +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> > > > +                                          unsigned int nid,
> > > > +                                          enum node_stat_item idx)
> > > > +{
> > > > +       long x;
> > > > +       struct mem_cgroup_per_node *pn;
> > > > +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> > > > +
> > > > +       VM_BUG_ON(nid >= nr_node_ids);
> > > > +
> > > > +       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > > > +       x = atomic_long_read(&pn->lruvec_stat[idx]);
> > > > +#ifdef CONFIG_SMP
> > > > +       if (x < 0)
> > > > +               x = 0;
> > > > +#endif
> > > > +       return x;
> > > > +}
> > > > +#endif
> > > > +
> > > >  static char *memory_stat_format(struct mem_cgroup *memcg)
> > > >  {
> > > >         struct seq_buf s;
> > > >         int i;
> > > > +#ifdef CONFIG_NUMA
> > > > +       int nid;
> > > > +#endif
> > > >
> > > >         seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> > > >         if (!s.buffer)
> > > > @@ -1512,12 +1536,30 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> > > >          * Current memory state:
> > > >          */
> > > >
> > >
> > > Let's not break the parsers of memory.stat. I would prefer a separate
> > > interface like v1 i.e. memory.numa_stat.
> >
> > It is also a good idea to expose a new interface like memory.numa_stat.
> >
> > >
> > > > -       seq_buf_printf(&s, "anon %llu\n",
> > > > +       seq_buf_printf(&s, "anon %llu",
> > > >                        (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
> > > >                        PAGE_SIZE);
> > > > -       seq_buf_printf(&s, "file %llu\n",
> > > > +#ifdef CONFIG_NUMA
> > > > +       for_each_node_state(nid, N_MEMORY)
> > > > +               seq_buf_printf(&s, " N%d=%llu", nid,
> > > > +                              (u64)memcg_node_page_state(memcg, nid,
> > > > +                                                         NR_ANON_MAPPED) *
> > > > +                              PAGE_SIZE);
> > > > +#endif
> > > > +       seq_buf_putc(&s, '\n');
> > > > +
> > > > +       seq_buf_printf(&s, "file %llu",
> > > >                        (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
> > > >                        PAGE_SIZE);
> > > > +#ifdef CONFIG_NUMA
> > > > +       for_each_node_state(nid, N_MEMORY)
> > > > +               seq_buf_printf(&s, " N%d=%llu", nid,
> > > > +                              (u64)memcg_node_page_state(memcg, nid,
> > > > +                                                         NR_FILE_PAGES) *
> > > > +                              PAGE_SIZE);
> > > > +#endif
> > > > +       seq_buf_putc(&s, '\n');
> > > > +
> > >
> > > The v1's numa_stat exposes the LRUs, why NR_ANON_MAPPED and NR_FILE_PAGES?
> >
> > If we want to expose the anon per node, we need to add inactive anon and
> > active anon together. Why not use NR_ANON_MAPPED directly?
> >
>
> Active anon plus inactive anon is not equal to NR_ANON_MAPPED. The
> shmem related memory is on anon LRUs but not accounted in
> NR_ANON_MAPPED.
>
> Similarly file LRU can contain MADV_FREE pages which are not accounted
> in NR_FILE_PAGES.

I got it, thanks. Because the "state" interface exposes the anon and
file information. So I think that we also should expose the anon and
file for "numa_stat" per node instead of the lru statistics. Maybe it is
better that we expose both of all the information.

>
> > >
> > > Also I think exposing slab_[un]reclaimable per node would be beneficial as well.
> >
> > Yeah, I agree with you. Maybe kernel_stack and percpu also should
> > be exposed.
> >
> > >
> > > >         seq_buf_printf(&s, "kernel_stack %llu\n",
> > > >                        (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
> > > >                        1024);
> > > > --
> > > > 2.20.1
> > > >
> >
> >
> >
> > --
> > Yours,
> > Muchun



-- 
Yours,
Muchun
