Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD3126651B
	for <lists+cgroups@lfdr.de>; Fri, 11 Sep 2020 18:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgIKQxc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Sep 2020 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgIKPGO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Sep 2020 11:06:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDCCC0612F5
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 07:55:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z19so6145436lfr.4
        for <cgroups@vger.kernel.org>; Fri, 11 Sep 2020 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyGETUg9mUKb771YPAmqWLGZaTO7mZ6hKFj3E91siek=;
        b=DRq2hDtsbMxfpg7W5O+ZLV1lUVDBsWosPPite6Mp7DI9sgN0NZSVPPtwxQe6bBU/f3
         gLNTTgHzLJMDPfUAcKbMD3OW8k3KoymNgxK8mLl9QWoIw0sZDr1T4Vx4mu7k9k7JdEs5
         3x/fFhmTkY7qWGxK22snBGLvTN6Z7TlrJxfY+2ncfuGRKZpwYXJ11akrgf7sTNurnp85
         lmT4gl5NmTNytzmc/6rAngMH+OxJ4BXDeC75yDziaV9eauYodGRNeKbu9vo8/uWsqzeX
         lfI7glc9MDT5UAMYVjxq+qRPGwA/gilQEYXic/i7Fh+QKmW24oQoJ6FcBWMzloucXDDQ
         OdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyGETUg9mUKb771YPAmqWLGZaTO7mZ6hKFj3E91siek=;
        b=lY/3IXorymq/w2xy2FwixQdtC/2eagGRVS8pixhdyZbnT126Al5A1pktK9zXs0c5A6
         r8lTMp0zD8pF7c9ILMGuTzKeCrbIgb6NuZUnXfxeSzrEees5/1YnFxgsJJsYwhK3UYKV
         j+xHSO32w0qqEs2jQizYp59V495Oqibmu99h5fGKpYzVmk1qXIBKDKDlzpqFIzHmZ2Lk
         Y+PdUfshlYaupEwLtdV2ZOG1vsadHXfEJx2ngRp4s2FQHMxRjz8cnewUXWjrOO3RFRfa
         HRKlnj/Bx2leZxe437898wACQ43VNu6H132LYjD/fH53ZQ5qY1ccdxflT0GbXVxFqMtD
         fziQ==
X-Gm-Message-State: AOAM533Ih/nRyQwFX85pfxFOZzzb3WLwRhO7ViuaGuDnIVsqqLvFEQwk
        +EYxn9Inc7X16ZEMPe+LNIrq9p63yT0Fsd+/iIZXtA==
X-Google-Smtp-Source: ABdhPJzIfXWEoPr+pejl9ICIZBfdEPcdhSa0BRgky84fzVsWoAMK+i7zNMib2U+DpXd++dQwMqw6Op9w7E45OQMrsVg=
X-Received: by 2002:ac2:59da:: with SMTP id x26mr449757lfn.346.1599836132004;
 Fri, 11 Sep 2020 07:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200910084258.22293-1-songmuchun@bytedance.com>
 <CALvZod5JQWGHUAPnj9S0pKFQreLPST441mZnp+h=fue_nnh1yQ@mail.gmail.com> <CAMZfGtUncFZZe2RDb54ALMt1DAVqBxAD1TQrpjei1H5nRbH6jg@mail.gmail.com>
In-Reply-To: <CAMZfGtUncFZZe2RDb54ALMt1DAVqBxAD1TQrpjei1H5nRbH6jg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Sep 2020 07:55:20 -0700
Message-ID: <CALvZod5_1nGJ2-QfSnYm4rCB+qvMEKAuVJrCeCyv_vQs7EoYfw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Add the missing numa stat
 of anon and file for cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>
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

On Thu, Sep 10, 2020 at 8:52 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Fri, Sep 11, 2020 at 12:02 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Thu, Sep 10, 2020 at 1:46 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > In the cgroup v1, we have a numa_stat interface. This is useful for
> > > providing visibility into the numa locality information within an
> > > memcg since the pages are allowed to be allocated from any physical
> > > node. One of the use cases is evaluating application performance by
> > > combining this information with the application's CPU allocation.
> > > But the cgroup v2 does not. So this patch adds the missing information.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> >
> > I am actually working on exposing this info on v2 as well.
> >
> > >  mm/memcontrol.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 44 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 75cd1a1e66c8..c779673f29b2 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -1492,10 +1492,34 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
> > >         return false;
> > >  }
> > >
> > > +#ifdef CONFIG_NUMA
> > > +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> > > +                                          unsigned int nid,
> > > +                                          enum node_stat_item idx)
> > > +{
> > > +       long x;
> > > +       struct mem_cgroup_per_node *pn;
> > > +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> > > +
> > > +       VM_BUG_ON(nid >= nr_node_ids);
> > > +
> > > +       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> > > +       x = atomic_long_read(&pn->lruvec_stat[idx]);
> > > +#ifdef CONFIG_SMP
> > > +       if (x < 0)
> > > +               x = 0;
> > > +#endif
> > > +       return x;
> > > +}
> > > +#endif
> > > +
> > >  static char *memory_stat_format(struct mem_cgroup *memcg)
> > >  {
> > >         struct seq_buf s;
> > >         int i;
> > > +#ifdef CONFIG_NUMA
> > > +       int nid;
> > > +#endif
> > >
> > >         seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> > >         if (!s.buffer)
> > > @@ -1512,12 +1536,30 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
> > >          * Current memory state:
> > >          */
> > >
> >
> > Let's not break the parsers of memory.stat. I would prefer a separate
> > interface like v1 i.e. memory.numa_stat.
>
> It is also a good idea to expose a new interface like memory.numa_stat.
>
> >
> > > -       seq_buf_printf(&s, "anon %llu\n",
> > > +       seq_buf_printf(&s, "anon %llu",
> > >                        (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
> > >                        PAGE_SIZE);
> > > -       seq_buf_printf(&s, "file %llu\n",
> > > +#ifdef CONFIG_NUMA
> > > +       for_each_node_state(nid, N_MEMORY)
> > > +               seq_buf_printf(&s, " N%d=%llu", nid,
> > > +                              (u64)memcg_node_page_state(memcg, nid,
> > > +                                                         NR_ANON_MAPPED) *
> > > +                              PAGE_SIZE);
> > > +#endif
> > > +       seq_buf_putc(&s, '\n');
> > > +
> > > +       seq_buf_printf(&s, "file %llu",
> > >                        (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
> > >                        PAGE_SIZE);
> > > +#ifdef CONFIG_NUMA
> > > +       for_each_node_state(nid, N_MEMORY)
> > > +               seq_buf_printf(&s, " N%d=%llu", nid,
> > > +                              (u64)memcg_node_page_state(memcg, nid,
> > > +                                                         NR_FILE_PAGES) *
> > > +                              PAGE_SIZE);
> > > +#endif
> > > +       seq_buf_putc(&s, '\n');
> > > +
> >
> > The v1's numa_stat exposes the LRUs, why NR_ANON_MAPPED and NR_FILE_PAGES?
>
> If we want to expose the anon per node, we need to add inactive anon and
> active anon together. Why not use NR_ANON_MAPPED directly?
>

Active anon plus inactive anon is not equal to NR_ANON_MAPPED. The
shmem related memory is on anon LRUs but not accounted in
NR_ANON_MAPPED.

Similarly file LRU can contain MADV_FREE pages which are not accounted
in NR_FILE_PAGES.

> >
> > Also I think exposing slab_[un]reclaimable per node would be beneficial as well.
>
> Yeah, I agree with you. Maybe kernel_stack and percpu also should
> be exposed.
>
> >
> > >         seq_buf_printf(&s, "kernel_stack %llu\n",
> > >                        (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
> > >                        1024);
> > > --
> > > 2.20.1
> > >
>
>
>
> --
> Yours,
> Muchun
