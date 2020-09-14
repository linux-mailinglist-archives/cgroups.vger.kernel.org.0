Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510C7269947
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 00:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgINW5i (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 18:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgINW5g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 18:57:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27EFC061788
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 15:57:33 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x77so1073665lfa.0
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 15:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WViTl0b8x+giGHFZh+rVEKrUPQoCKo+J/50WQCvSoeU=;
        b=cRqX/VoiJlNpAl8z1euxYLDbFZouqQx0Mt33brymprI2vtjrByuRMCH42vuV/btT6h
         OV05p0Cytn9A45Ob2T8JxSWLWKRCcbNClVcFRUdmCfOa5zrsHmKyYMsHNY/6dZ9gV+g0
         Z8IZWuFtKTlqacd2ikYCTZeFd+UdvXSiw1lsPVPZAE9nGhBRYsYW47ufhafLdKP5LGOU
         ++fzP4+9m0MsmjaQjTV9Ks/RJm7Nz6m0NC2meTZOjUOeMz4gwIKUxHViVTr8n5pMZ71D
         mf4ZaigkjBXHPrm1KGiAyFnK+ZPMozHVtg89PLTj6Al/4lCyQjxTgfjPoc3+LROM/sk1
         5Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WViTl0b8x+giGHFZh+rVEKrUPQoCKo+J/50WQCvSoeU=;
        b=fFHMCSvIIgEdf03mlJ9DrolCMJ0L6pXP0F1e7jJKRxgL4i47BCDoaTcMc8/0I9trD4
         FOqhKsrbO0c8gz2RcIJ7+i5Vgyv12vLM2R/oEhlSKeJcdm3ri/7rnhA4/C1N6JcqkZvL
         l5h++cIVBbD9JB+wYVC69f4ZFzq/z22WL5KIurqNn3XMe9Nhk06qhQuJTHTSW53YaBCR
         3kPF82NXer6cvlw4wyhnIc/pi/UDPWZ7bBjcswhVStKqQCGd5Lbnfwb07iRALy16fO2a
         UxN6ak3f4R2s6tefLlYcrlEmbBwJO9L7XDcIIoPgCACDC9IYEK28iycyI8yYsionewru
         KuDw==
X-Gm-Message-State: AOAM531z4oAitSNxphCxsH/oBINdyxLh059nBNFuaeaUDtWeb+xt7gf2
        qYrgarrV8S2kZGcII7hEGxI8UFSiRHdHzyJnGeB++Q==
X-Google-Smtp-Source: ABdhPJxpmWLKvjsFtNH48os0OOkxFZ9XHBl2kW6WD3M1V9ZZEOYafjadmVljfxRxlpn9ArTUR/z9stoRHFiD3XEOk9w=
X-Received: by 2002:a19:4084:: with SMTP id n126mr2701402lfa.54.1600124251790;
 Mon, 14 Sep 2020 15:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200913070010.44053-1-songmuchun@bytedance.com>
 <CALvZod7VH3NDwBXrY9w95pUY7DV+R-b_chBHuygmwH_bhpULkQ@mail.gmail.com> <CAMZfGtXoBrFioh=FqRA82ZRSt=2oW=ie8BgZE0hAvtCOBRMXiw@mail.gmail.com>
In-Reply-To: <CAMZfGtXoBrFioh=FqRA82ZRSt=2oW=ie8BgZE0hAvtCOBRMXiw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 14 Sep 2020 15:57:20 -0700
Message-ID: <CALvZod4niTJmA99GFifoi8rdnM8X-GoUUafGHZA3LQWJYXu_tg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 9:55 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Tue, Sep 15, 2020 at 12:07 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Sun, Sep 13, 2020 at 12:01 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > In the cgroup v1, we have a numa_stat interface. This is useful for
> > > providing visibility into the numa locality information within an
> > > memcg since the pages are allowed to be allocated from any physical
> > > node. One of the use cases is evaluating application performance by
> > > combining this information with the application's CPU allocation.
> > > But the cgroup v2 does not. So this patch adds the missing information.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > ---
> > [snip]
> > > +
> > > +static struct numa_stat numa_stats[] = {
> > > +       { "anon", PAGE_SIZE, NR_ANON_MAPPED },
> > > +       { "file", PAGE_SIZE, NR_FILE_PAGES },
> > > +       { "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> > > +       { "shmem", PAGE_SIZE, NR_SHMEM },
> > > +       { "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> > > +       { "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> > > +       { "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > +       /*
> > > +        * The ratio will be initialized in numa_stats_init(). Because
> > > +        * on some architectures, the macro of HPAGE_PMD_SIZE is not
> > > +        * constant(e.g. powerpc).
> > > +        */
> > > +       { "anon_thp", 0, NR_ANON_THPS },
> > > +#endif
> > > +       { "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> > > +       { "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> > > +       { "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> > > +       { "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> > > +       { "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> > > +       { "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> > > +       { "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> > > +};
> > > +
> > > +static int __init numa_stats_init(void)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > +               if (numa_stats[i].idx == NR_ANON_THPS)
> > > +                       numa_stats[i].ratio = HPAGE_PMD_SIZE;
> > > +#endif
> > > +       }
> >
> > The for loop seems excessive but I don't really have a good alternative.
>
> Yeah, I also have no good alternative. The numa_stats is only initialized
> once. So there may be no problem :).
>
> >
> > > +
> > > +       return 0;
> > > +}
> > > +pure_initcall(numa_stats_init);
> > > +
> > > +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> > > +                                          unsigned int nid,
> > > +                                          enum node_stat_item idx)
> > > +{
> > > +       VM_BUG_ON(nid >= nr_node_ids);
> > > +       return lruvec_page_state(mem_cgroup_lruvec(memcg, NODE_DATA(nid)), idx);
> > > +}
> > > +
> > > +static const char *memory_numa_stat_format(struct mem_cgroup *memcg)
> > > +{
> > > +       int i;
> > > +       struct seq_buf s;
> > > +
> > > +       /* Reserve a byte for the trailing null */
> > > +       seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE - 1);
> > > +       if (!s.buffer)
> > > +               return NULL;
> > > +
> > > +       for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> > > +               int nid;
> > > +
> > > +               seq_buf_printf(&s, "%s", numa_stats[i].name);
> > > +               for_each_node_state(nid, N_MEMORY) {
> > > +                       u64 size;
> > > +
> > > +                       size = memcg_node_page_state(memcg, nid,
> > > +                                                    numa_stats[i].idx);
> > > +                       size *= numa_stats[i].ratio;
> > > +                       seq_buf_printf(&s, " N%d=%llu", nid, size);
> > > +               }
> > > +               seq_buf_putc(&s, '\n');
> > > +       }
> > > +
> > > +       /* The above should easily fit into one page */
> > > +       if (WARN_ON_ONCE(seq_buf_putc(&s, '\0')))
> > > +               s.buffer[PAGE_SIZE - 1] = '\0';
> >
> > I think you should follow Michal's recommendation at
> > http://lkml.kernel.org/r/20200914115724.GO16999@dhcp22.suse.cz
>
> Here is different, because the seq_buf_putc(&s, '\n') will not add \0 unless
> we use seq_buf_puts(&s, "\n").
>

Why a separate memory_numa_stat_format()? For memory_stat_format(), it
is called from two places. There is no need to have a separate
memory_numa_stat_format(). Similarly why not just call seq_printf()
instead of formatting into a seq_buf?
