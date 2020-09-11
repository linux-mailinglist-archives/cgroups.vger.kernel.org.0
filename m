Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9632657B0
	for <lists+cgroups@lfdr.de>; Fri, 11 Sep 2020 05:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgIKDw0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 23:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDwX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 23:52:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC59C061573
        for <cgroups@vger.kernel.org>; Thu, 10 Sep 2020 20:52:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so6238111pfi.4
        for <cgroups@vger.kernel.org>; Thu, 10 Sep 2020 20:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9IV7HFefw1NIebU4itnNPdbQ5lYPIj2T1tDtgZeUqmc=;
        b=vS8pt+NfBa8G2NMGBwUEeLv/u22mt84ER/i3XbVd5kfjLV6iWfj5LWSD9iDugOdnJi
         pnvRudVBrBizJJ2mMTSXO7123cysHit9IRTi5qxshFE/l7znxMilhIyVgzMTUvlwwIVl
         5AsiwAofwATThXaG71cGe9qJ5ra5/xRjuLPd+L0OFDGgo44tZC0UBijE2aHZuWcaxczx
         qFpOsOWdJz4NGHwe5S27nH4cb8sWsXOnqCFD7HKGxVRjRnIEHhv/G8beTkJBMWa48og/
         hwbTtHoUabIfXa/kz0FZFks5V6kzqblc0tEHNIurI3lJQddNf7TkTdF8QrPjis93fL1d
         fwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9IV7HFefw1NIebU4itnNPdbQ5lYPIj2T1tDtgZeUqmc=;
        b=azdkIsgQ898MI4T8euy0MSmoZcD96HcVgMW0loCV80Pnr/PXPlhHJ4VuSdhykT1pPE
         XQC00R2cz5sSwLUUWD3YmHpW0AwcGUzghwo3qPI3ex2+56Q/htxJ8EMJ70DFVqP6xFU1
         zUgWTZyLKmhFLxkAS5LrvyISYEJendiYM+NLa+LtW/zm/wH8MBtVLw9eiX2y3FDj5eLl
         F3e2OezTPBxJ3SQQ4faXFQ/vcfOnxZkhrXGdifRuBnSWR9JDzyFUOb5gg10iM/3OnIHj
         59L9xAk6HcsnMMamIDdbOeeOVwJ362tEa0GO4Swb8gqLhGI45ebXFS21tuTvDTFflPJH
         yt3g==
X-Gm-Message-State: AOAM533qN2nHfXIz6IV68H0x1sk7XPWMpqWx1gBsDhFuW1HDdy7tODoH
        24rZgYv3HuZLvXZXin9XRov4+4T0MztjITRwL8jN8A==
X-Google-Smtp-Source: ABdhPJxibbvSxKxO41BlACQqUJkBTdPD+KmfwtRs9Q8JsaaA0IpfDaDkzF2vKoPJHR+yf3YXwcRu+z8uwQCaNwHKXUs=
X-Received: by 2002:a62:38ce:0:b029:138:838f:dd53 with SMTP id
 f197-20020a6238ce0000b0290138838fdd53mr328874pfa.2.1599796341600; Thu, 10 Sep
 2020 20:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200910084258.22293-1-songmuchun@bytedance.com> <CALvZod5JQWGHUAPnj9S0pKFQreLPST441mZnp+h=fue_nnh1yQ@mail.gmail.com>
In-Reply-To: <CALvZod5JQWGHUAPnj9S0pKFQreLPST441mZnp+h=fue_nnh1yQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Sep 2020 11:51:42 +0800
Message-ID: <CAMZfGtUncFZZe2RDb54ALMt1DAVqBxAD1TQrpjei1H5nRbH6jg@mail.gmail.com>
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

On Fri, Sep 11, 2020 at 12:02 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Sep 10, 2020 at 1:46 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > In the cgroup v1, we have a numa_stat interface. This is useful for
> > providing visibility into the numa locality information within an
> > memcg since the pages are allowed to be allocated from any physical
> > node. One of the use cases is evaluating application performance by
> > combining this information with the application's CPU allocation.
> > But the cgroup v2 does not. So this patch adds the missing information.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
>
> I am actually working on exposing this info on v2 as well.
>
> >  mm/memcontrol.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 44 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 75cd1a1e66c8..c779673f29b2 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1492,10 +1492,34 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> >         return false;
> >  }
> >
> > +#ifdef CONFIG_NUMA
> > +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> > +                                          unsigned int nid,
> > +                                          enum node_stat_item idx)
> > +{
> > +       long x;
> > +       struct mem_cgroup_per_node *pn;
> > +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> > +
> > +       VM_BUG_ON(nid >= nr_node_ids);
> > +
> > +       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > +       x = atomic_long_read(&pn->lruvec_stat[idx]);
> > +#ifdef CONFIG_SMP
> > +       if (x < 0)
> > +               x = 0;
> > +#endif
> > +       return x;
> > +}
> > +#endif
> > +
> >  static char *memory_stat_format(struct mem_cgroup *memcg)
> >  {
> >         struct seq_buf s;
> >         int i;
> > +#ifdef CONFIG_NUMA
> > +       int nid;
> > +#endif
> >
> >         seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> >         if (!s.buffer)
> > @@ -1512,12 +1536,30 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> >          * Current memory state:
> >          */
> >
>
> Let's not break the parsers of memory.stat. I would prefer a separate
> interface like v1 i.e. memory.numa_stat.

It is also a good idea to expose a new interface like memory.numa_stat.

>
> > -       seq_buf_printf(&s, "anon %llu\n",
> > +       seq_buf_printf(&s, "anon %llu",
> >                        (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
> >                        PAGE_SIZE);
> > -       seq_buf_printf(&s, "file %llu\n",
> > +#ifdef CONFIG_NUMA
> > +       for_each_node_state(nid, N_MEMORY)
> > +               seq_buf_printf(&s, " N%d=%llu", nid,
> > +                              (u64)memcg_node_page_state(memcg, nid,
> > +                                                         NR_ANON_MAPPED) *
> > +                              PAGE_SIZE);
> > +#endif
> > +       seq_buf_putc(&s, '\n');
> > +
> > +       seq_buf_printf(&s, "file %llu",
> >                        (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
> >                        PAGE_SIZE);
> > +#ifdef CONFIG_NUMA
> > +       for_each_node_state(nid, N_MEMORY)
> > +               seq_buf_printf(&s, " N%d=%llu", nid,
> > +                              (u64)memcg_node_page_state(memcg, nid,
> > +                                                         NR_FILE_PAGES) *
> > +                              PAGE_SIZE);
> > +#endif
> > +       seq_buf_putc(&s, '\n');
> > +
>
> The v1's numa_stat exposes the LRUs, why NR_ANON_MAPPED and NR_FILE_PAGES?

If we want to expose the anon per node, we need to add inactive anon and
active anon together. Why not use NR_ANON_MAPPED directly?

>
> Also I think exposing slab_[un]reclaimable per node would be beneficial as well.

Yeah, I agree with you. Maybe kernel_stack and percpu also should
be exposed.

>
> >         seq_buf_printf(&s, "kernel_stack %llu\n",
> >                        (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
> >                        1024);
> > --
> > 2.20.1
> >



-- 
Yours,
Muchun
