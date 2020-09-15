Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73D0C269C0F
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 04:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgIOCrB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 22:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgIOCq7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 22:46:59 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DADC06174A
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 19:46:59 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so1202159pgd.5
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 19:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0FQ0nfZ2Wc8LZgyuuXYTX78UCL16O8uTa9n4V+OwUo=;
        b=fSs6uCfAjjro3EnF93Kpk7JX7abQU5TpqgxG1AVkOpAPB2gnjE3erXCZw1C3ekj3Vq
         skmqCNnaP+DezWOJGLNMOG10DgNjZoRghI6njGU7FpwVAN/WK7iohqLjs47VF1H7RHTb
         oJ9m639MA0tdr9KzrifVqsil73D57GG4Wf1lZXLdnOc7nvsyyVLNAHBqxab7o67TWxHx
         CS02eoGVX59h7Nao1KAoNa/sFnGExTo6y+SLwnkHTj8hFsG0zesoY2NosrnkGVyaN9Ts
         FZkP589aTsWIbvdMvGuxFtv7aigbuH8NxaJqLhDlLDqqUmRgOzBsTmK6vFVeMePs05sl
         Zjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0FQ0nfZ2Wc8LZgyuuXYTX78UCL16O8uTa9n4V+OwUo=;
        b=VwIliNscZ8/Xx82kd2zLL6om4DwQ8SNcP+bsrs8+nASETVURI/3blnG6aoRECWb3hG
         meS5+KYD8811LxHkac+tCNoFv28w6D2DTI4Styu5AfcqI3zKUqX2Oy3MLLo0H57Zlvr1
         mHm0AjdwR7+Wd/6v4ee/RF4encwFXYW+X4RA20+Pr1fTrfDdtk1XBB7ENmu7bOZimxzg
         CdnMovwh+OeGuiIlH4WB2ykiU7lv+KhiB7rGnXBR/yoYC0qSR4IGd63ceIj8pusVkPg3
         lV6r2km21TSqYn5yCpxp8pcAhp3UIDpt7O1GHwWm7UjUMDbN6DoicolpclV/2CJ2Ydw4
         ZyWQ==
X-Gm-Message-State: AOAM531MOTtZK2HunsnDs0kmFzmYwLmpv3JBVUt+KlNQZ14WgWhSN+9p
        B8lhoDsblKedc+EeKPfMQcuUbk8Q78n6PJBmL/sapg==
X-Google-Smtp-Source: ABdhPJwmvQ+nKPf9WKg2i0x4PycRJ+B/sEJ9jElgrzmOufgwQsH03ZsqjbBtr+eOUdZjqfC9sthGV7Rf6p+CwQhfkuQ=
X-Received: by 2002:a63:3047:: with SMTP id w68mr12740841pgw.341.1600138018835;
 Mon, 14 Sep 2020 19:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200913070010.44053-1-songmuchun@bytedance.com>
 <CALvZod7VH3NDwBXrY9w95pUY7DV+R-b_chBHuygmwH_bhpULkQ@mail.gmail.com>
 <CAMZfGtXoBrFioh=FqRA82ZRSt=2oW=ie8BgZE0hAvtCOBRMXiw@mail.gmail.com> <CALvZod4niTJmA99GFifoi8rdnM8X-GoUUafGHZA3LQWJYXu_tg@mail.gmail.com>
In-Reply-To: <CALvZod4niTJmA99GFifoi8rdnM8X-GoUUafGHZA3LQWJYXu_tg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 15 Sep 2020 10:46:22 +0800
Message-ID: <CAMZfGtVZ_VgiLHY+CDAJ=5nitQ4-SbUKfToF-NGw-bfu2_PzNg@mail.gmail.com>
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

On Tue, Sep 15, 2020 at 6:57 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Sep 14, 2020 at 9:55 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 12:07 AM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Sun, Sep 13, 2020 at 12:01 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > > >
> > > > In the cgroup v1, we have a numa_stat interface. This is useful for
> > > > providing visibility into the numa locality information within an
> > > > memcg since the pages are allowed to be allocated from any physical
> > > > node. One of the use cases is evaluating application performance by
> > > > combining this information with the application's CPU allocation.
> > > > But the cgroup v2 does not. So this patch adds the missing information.
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > ---
> > > [snip]
> > > > +
> > > > +static struct numa_stat numa_stats[] = {
> > > > +       { "anon", PAGE_SIZE, NR_ANON_MAPPED },
> > > > +       { "file", PAGE_SIZE, NR_FILE_PAGES },
> > > > +       { "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> > > > +       { "shmem", PAGE_SIZE, NR_SHMEM },
> > > > +       { "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> > > > +       { "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> > > > +       { "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > +       /*
> > > > +        * The ratio will be initialized in numa_stats_init(). Because
> > > > +        * on some architectures, the macro of HPAGE_PMD_SIZE is not
> > > > +        * constant(e.g. powerpc).
> > > > +        */
> > > > +       { "anon_thp", 0, NR_ANON_THPS },
> > > > +#endif
> > > > +       { "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> > > > +       { "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> > > > +       { "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> > > > +       { "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> > > > +       { "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> > > > +       { "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> > > > +       { "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> > > > +};
> > > > +
> > > > +static int __init numa_stats_init(void)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > +               if (numa_stats[i].idx == NR_ANON_THPS)
> > > > +                       numa_stats[i].ratio = HPAGE_PMD_SIZE;
> > > > +#endif
> > > > +       }
> > >
> > > The for loop seems excessive but I don't really have a good alternative.
> >
> > Yeah, I also have no good alternative. The numa_stats is only initialized
> > once. So there may be no problem :).
> >
> > >
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +pure_initcall(numa_stats_init);
> > > > +
> > > > +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> > > > +                                          unsigned int nid,
> > > > +                                          enum node_stat_item idx)
> > > > +{
> > > > +       VM_BUG_ON(nid >= nr_node_ids);
> > > > +       return lruvec_page_state(mem_cgroup_lruvec(memcg, NODE_DATA(nid)), idx);
> > > > +}
> > > > +
> > > > +static const char *memory_numa_stat_format(struct mem_cgroup *memcg)
> > > > +{
> > > > +       int i;
> > > > +       struct seq_buf s;
> > > > +
> > > > +       /* Reserve a byte for the trailing null */
> > > > +       seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE - 1);
> > > > +       if (!s.buffer)
> > > > +               return NULL;
> > > > +
> > > > +       for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> > > > +               int nid;
> > > > +
> > > > +               seq_buf_printf(&s, "%s", numa_stats[i].name);
> > > > +               for_each_node_state(nid, N_MEMORY) {
> > > > +                       u64 size;
> > > > +
> > > > +                       size = memcg_node_page_state(memcg, nid,
> > > > +                                                    numa_stats[i].idx);
> > > > +                       size *= numa_stats[i].ratio;
> > > > +                       seq_buf_printf(&s, " N%d=%llu", nid, size);
> > > > +               }
> > > > +               seq_buf_putc(&s, '\n');
> > > > +       }
> > > > +
> > > > +       /* The above should easily fit into one page */
> > > > +       if (WARN_ON_ONCE(seq_buf_putc(&s, '\0')))
> > > > +               s.buffer[PAGE_SIZE - 1] = '\0';
> > >
> > > I think you should follow Michal's recommendation at
> > > http://lkml.kernel.org/r/20200914115724.GO16999@dhcp22.suse.cz
> >
> > Here is different, because the seq_buf_putc(&s, '\n') will not add \0 unless
> > we use seq_buf_puts(&s, "\n").
> >
>
> Why a separate memory_numa_stat_format()? For memory_stat_format(), it
> is called from two places. There is no need to have a separate
> memory_numa_stat_format(). Similarly why not just call seq_printf()
> instead of formatting into a seq_buf?

I was indeed affected by memory_stat_format(). Thank you for
making me sober.




-- 
Yours,
Muchun
