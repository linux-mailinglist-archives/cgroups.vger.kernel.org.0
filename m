Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5E26923E
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgINQ4e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgINQz2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 12:55:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE4C06178A
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 09:55:27 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id l126so40321pfd.5
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nn8uGO9a9X0XwaIfMVFd2VgaWgHbpK8dvPYHd7Sq/nA=;
        b=RB+2IbSgUvQBoAdsF0OTSCz20nt98NJ5VHwnf9jRx7zYNTMQeX4LZz03zL76irCDsG
         0mdg45wZp2YAKNVNcAwTPfapLTrblMQfnEi5juhLmTb8jSzbarIx3WRVlOGm1lwO0q4M
         JQXKYTnJSK2DV38j5skJQDiuqxCdrQ3kOy8gMmaXArc3C/XUvXxCidE0P/u3zhA62+yi
         xxn5pXMlfzPSghT6dqYreCTRbu1o6GiEEvmXJk4bl7fHVfWaL8keJwVa0PHKeirScjuK
         prJC8gaEvEx5yF4bvJyP9nUjr2ef9WkOsxRj3i4EAEkOXmG5T4VYP6A9imu3h5LqM1Nm
         5WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nn8uGO9a9X0XwaIfMVFd2VgaWgHbpK8dvPYHd7Sq/nA=;
        b=EzGqzoYtHEvdPK3udV9t0S0xFxXxn40FHgetw/lnlAaEYktwW3Jqmts1DPtxEZXDD6
         Xpfi4LMUU5pYw3vtCd/HH8x6jE/OPgpL1mnivrN9TlJTNQnowAlKKuLK2UJosnEBuc3Y
         UqH4DfVFGExANpWTFqC+5VfvQey5xmDNNsraXJjqeawrXyWTb7ybSDZXNx0MzpoZFsH4
         Tf6Gii6TfWfm7KTph5tscV9yNCX2FAfg8lQjSvHhRcdTJnLUhocAKzs1y+pAILpwQoI9
         +SJKsMDRm79+sqMU2EKhLYOCLsKZBfxlLtgCBpWdMYQcBf/5Ct0uXnhxOb8QyEWu5MVH
         4Epw==
X-Gm-Message-State: AOAM530KJSolmTR9xsj2oz8pn6mAhhesBCJFI4d4YVdy7n8oB5c+Doq8
        jd7dNCqb3qjOAcnsi5L1B9iSZ4bG1/lHm52j9oTu6Q==
X-Google-Smtp-Source: ABdhPJxzhrEWtHfAz9YebgAYjnUP/OKSRvXH7hybqZE4UdLRz9e4pHdbh/Rl/limT4J8drQRD3Oae84qwNQP5k5X5fM=
X-Received: by 2002:a62:8f4c:: with SMTP id n73mr13928326pfd.65.1600102526730;
 Mon, 14 Sep 2020 09:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200913070010.44053-1-songmuchun@bytedance.com> <CALvZod7VH3NDwBXrY9w95pUY7DV+R-b_chBHuygmwH_bhpULkQ@mail.gmail.com>
In-Reply-To: <CALvZod7VH3NDwBXrY9w95pUY7DV+R-b_chBHuygmwH_bhpULkQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 15 Sep 2020 00:54:50 +0800
Message-ID: <CAMZfGtXoBrFioh=FqRA82ZRSt=2oW=ie8BgZE0hAvtCOBRMXiw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] mm: memcontrol: Add the missing
 numa_stat interface for cgroup v2
To:     Shakeel Butt <shakeelb@google.com>
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

On Tue, Sep 15, 2020 at 12:07 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Sun, Sep 13, 2020 at 12:01 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > In the cgroup v1, we have a numa_stat interface. This is useful for
> > providing visibility into the numa locality information within an
> > memcg since the pages are allowed to be allocated from any physical
> > node. One of the use cases is evaluating application performance by
> > combining this information with the application's CPU allocation.
> > But the cgroup v2 does not. So this patch adds the missing information.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> [snip]
> > +
> > +static struct numa_stat numa_stats[] = {
> > +       { "anon", PAGE_SIZE, NR_ANON_MAPPED },
> > +       { "file", PAGE_SIZE, NR_FILE_PAGES },
> > +       { "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> > +       { "shmem", PAGE_SIZE, NR_SHMEM },
> > +       { "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> > +       { "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> > +       { "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +       /*
> > +        * The ratio will be initialized in numa_stats_init(). Because
> > +        * on some architectures, the macro of HPAGE_PMD_SIZE is not
> > +        * constant(e.g. powerpc).
> > +        */
> > +       { "anon_thp", 0, NR_ANON_THPS },
> > +#endif
> > +       { "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> > +       { "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> > +       { "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> > +       { "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> > +       { "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> > +       { "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> > +       { "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> > +};
> > +
> > +static int __init numa_stats_init(void)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +               if (numa_stats[i].idx == NR_ANON_THPS)
> > +                       numa_stats[i].ratio = HPAGE_PMD_SIZE;
> > +#endif
> > +       }
>
> The for loop seems excessive but I don't really have a good alternative.

Yeah, I also have no good alternative. The numa_stats is only initialized
once. So there may be no problem :).

>
> > +
> > +       return 0;
> > +}
> > +pure_initcall(numa_stats_init);
> > +
> > +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> > +                                          unsigned int nid,
> > +                                          enum node_stat_item idx)
> > +{
> > +       VM_BUG_ON(nid >= nr_node_ids);
> > +       return lruvec_page_state(mem_cgroup_lruvec(memcg, NODE_DATA(nid)), idx);
> > +}
> > +
> > +static const char *memory_numa_stat_format(struct mem_cgroup *memcg)
> > +{
> > +       int i;
> > +       struct seq_buf s;
> > +
> > +       /* Reserve a byte for the trailing null */
> > +       seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE - 1);
> > +       if (!s.buffer)
> > +               return NULL;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> > +               int nid;
> > +
> > +               seq_buf_printf(&s, "%s", numa_stats[i].name);
> > +               for_each_node_state(nid, N_MEMORY) {
> > +                       u64 size;
> > +
> > +                       size = memcg_node_page_state(memcg, nid,
> > +                                                    numa_stats[i].idx);
> > +                       size *= numa_stats[i].ratio;
> > +                       seq_buf_printf(&s, " N%d=%llu", nid, size);
> > +               }
> > +               seq_buf_putc(&s, '\n');
> > +       }
> > +
> > +       /* The above should easily fit into one page */
> > +       if (WARN_ON_ONCE(seq_buf_putc(&s, '\0')))
> > +               s.buffer[PAGE_SIZE - 1] = '\0';
>
> I think you should follow Michal's recommendation at
> http://lkml.kernel.org/r/20200914115724.GO16999@dhcp22.suse.cz

Here is different, because the seq_buf_putc(&s, '\n') will not add \0 unless
we use seq_buf_puts(&s, "\n").


-- 
Yours,
Muchun
