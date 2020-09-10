Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4F264E43
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 21:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIJTHr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 15:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731346AbgIJQC0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 12:02:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DE0C061795
        for <cgroups@vger.kernel.org>; Thu, 10 Sep 2020 09:02:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n25so8887617ljj.4
        for <cgroups@vger.kernel.org>; Thu, 10 Sep 2020 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXFL8zxGAkEAFklyf5PNn/rioB+MLXLEPv+A6IYV3Is=;
        b=i6hq+vV98YA8q8Wcq6doLG+y5wjiyjWWL96kdQw0H+jDMxeA9Mj+NVqTkSuQ8Cvuzi
         66mGBRjmRbCe9uCMwVNKAt1PgIRZYmt68YEjOSvJPvvH8zdiyELwSOGs7GgYgWzw54ws
         MC8K5MYJ8ipMU0WZOqCAicBPqNbNhDMXRBDNFnCsWb6RoO0DyJQhfzijsLqCQrq9YBtU
         TATSHj1U8l9J2pHnmzcIKjevg8aAQtqDezGDeSRun2tajWl072+qD4mHPnB/Uk28jBej
         gD8NcxlU7ER8jI+FCE4AYxqnIymDHUbxmHzJfKUTcK43WNeC0qU86q+M9AU+YtZ2sYec
         4pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXFL8zxGAkEAFklyf5PNn/rioB+MLXLEPv+A6IYV3Is=;
        b=aiJlc8tMYVm0pHm1AGruySP/DOPhX+tyto8G9iZxC4iCx+jEAcAmjwgMaIvDPoguib
         rQZqdkZ4KTu9pGEOaCt1HqG+mDRsop5U0wCr9EAXrz4jXuiKCsKe83NCcmkXdbCy5DQn
         BxDjB//OqT4JX8QXpfAM9mVSKg7lfP++z/lorFJbznyC2b6CGEwP9B/fnOQ5R0qrlSzh
         8FfeBtLQEhyDsr4GgzFDqLxvGsSnRqNe6Gafve8HIwivSCOBx6QvnJc3OFTEwnkjjjAm
         GDb5h0V4QBiB8qg4ID8rMjonM155xRs0NAOCvf0fBGACMtnKd8//s+EI3svJ72uePV8M
         mZ1g==
X-Gm-Message-State: AOAM532gsNGMXGMrAhs3NWDEUwDsZ1ix7EjuxuKubirA46vXz2OD/M0i
        DXLdOag3YqgPvjHLi/72oxfsA9stczyUXJdpQG/uRg==
X-Google-Smtp-Source: ABdhPJz54WOPqVjLoiOAMEPFyivI7Bk2NO3KuFh9RoqJBEjdb4PNOM4gxm78bc2Klo+DIfoL656LWL7Khq/ccs7aPG0=
X-Received: by 2002:a2e:92d6:: with SMTP id k22mr5137971ljh.332.1599753725639;
 Thu, 10 Sep 2020 09:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200910084258.22293-1-songmuchun@bytedance.com>
In-Reply-To: <20200910084258.22293-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 10 Sep 2020 09:01:54 -0700
Message-ID: <CALvZod5JQWGHUAPnj9S0pKFQreLPST441mZnp+h=fue_nnh1yQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: Add the missing numa stat of anon and
 file for cgroup v2
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

On Thu, Sep 10, 2020 at 1:46 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> In the cgroup v1, we have a numa_stat interface. This is useful for
> providing visibility into the numa locality information within an
> memcg since the pages are allowed to be allocated from any physical
> node. One of the use cases is evaluating application performance by
> combining this information with the application's CPU allocation.
> But the cgroup v2 does not. So this patch adds the missing information.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---

I am actually working on exposing this info on v2 as well.

>  mm/memcontrol.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 75cd1a1e66c8..c779673f29b2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1492,10 +1492,34 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
>         return false;
>  }
>
> +#ifdef CONFIG_NUMA
> +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> +                                          unsigned int nid,
> +                                          enum node_stat_item idx)
> +{
> +       long x;
> +       struct mem_cgroup_per_node *pn;
> +       struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
> +
> +       VM_BUG_ON(nid >= nr_node_ids);
> +
> +       pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> +       x = atomic_long_read(&pn->lruvec_stat[idx]);
> +#ifdef CONFIG_SMP
> +       if (x < 0)
> +               x = 0;
> +#endif
> +       return x;
> +}
> +#endif
> +
>  static char *memory_stat_format(struct mem_cgroup *memcg)
>  {
>         struct seq_buf s;
>         int i;
> +#ifdef CONFIG_NUMA
> +       int nid;
> +#endif
>
>         seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
>         if (!s.buffer)
> @@ -1512,12 +1536,30 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>          * Current memory state:
>          */
>

Let's not break the parsers of memory.stat. I would prefer a separate
interface like v1 i.e. memory.numa_stat.

> -       seq_buf_printf(&s, "anon %llu\n",
> +       seq_buf_printf(&s, "anon %llu",
>                        (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
>                        PAGE_SIZE);
> -       seq_buf_printf(&s, "file %llu\n",
> +#ifdef CONFIG_NUMA
> +       for_each_node_state(nid, N_MEMORY)
> +               seq_buf_printf(&s, " N%d=%llu", nid,
> +                              (u64)memcg_node_page_state(memcg, nid,
> +                                                         NR_ANON_MAPPED) *
> +                              PAGE_SIZE);
> +#endif
> +       seq_buf_putc(&s, '\n');
> +
> +       seq_buf_printf(&s, "file %llu",
>                        (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
>                        PAGE_SIZE);
> +#ifdef CONFIG_NUMA
> +       for_each_node_state(nid, N_MEMORY)
> +               seq_buf_printf(&s, " N%d=%llu", nid,
> +                              (u64)memcg_node_page_state(memcg, nid,
> +                                                         NR_FILE_PAGES) *
> +                              PAGE_SIZE);
> +#endif
> +       seq_buf_putc(&s, '\n');
> +

The v1's numa_stat exposes the LRUs, why NR_ANON_MAPPED and NR_FILE_PAGES?

Also I think exposing slab_[un]reclaimable per node would be beneficial as well.

>         seq_buf_printf(&s, "kernel_stack %llu\n",
>                        (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
>                        1024);
> --
> 2.20.1
>
