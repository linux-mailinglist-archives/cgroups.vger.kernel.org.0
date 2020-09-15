Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78EF26A77E
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgIOOsH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbgIOOr7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 10:47:59 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80FAC06121D
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 06:54:00 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x69so3210459lff.3
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 06:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePEgJYcBWrhr7muyl2siRCTK9L57Ry0nh+Btj8rtlQc=;
        b=R9uJhZs2koe9dinXPuA2NgCgCBbx9zPE8BC4JQmGK0zjFtHAOJ0OvmDNcE+W3yfLT+
         Z1VQZKj4NIfbUGOq/I7NDMouDden3fCHbC10bIH3DRi2dlh7n1BhOKSAuDfRFm74rJEg
         l4nnhv501aw81OpJsEEKylFYiEwfqMqdzHLAynbWjtjy5QMMHUpiC6dvaE/Sv0wdIl00
         RAjGRqncpfHC+LV8n4EcDewNqLJhVLFljplof3+F2kiPTcUng6gYw0xXiWlDS+5Le+TJ
         T7Zs4gicVeidpuCHbk9Y0s4P7LELaY/CZCAKtpa56e/VhSssmbocaQRwRtjNjDvydEd+
         wFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePEgJYcBWrhr7muyl2siRCTK9L57Ry0nh+Btj8rtlQc=;
        b=N99E0iQ3bkcAjy02Uz9FzIRctJXF/uoRJv2ehN58ezPGi/8i/dfSzM6GlL5DjGfql7
         cEHkN8tk7mD/7XTxIYXwK+D0Hdyt4GyPAJ9n7fTfvc5MkB4xMTvkUoewPeT3w944BeFd
         RTDY5XDeTFSKPUnmtW0SEil1eIGrcuBD4iS7MRj20i4B6MB7OHVrirWincUHyR0hQDGI
         cs0TREsT3wfloQ4DKJkl9nis6BNyPjAiugAUyQdSN+rIr4cWIbmAmdi+CmIhrezXjA7c
         CtptN/uQOlM/IR6D6hcuj1rmODBnm88Nw+V0vEZeP0QK1BEY0B6yO9A0NsLRKsNj/C5i
         vqkg==
X-Gm-Message-State: AOAM530M87CSfqpfUEr186nzLbbdtis8ToSlRFwugw5ovhoLDTyDtjpt
        iqMSY0kSDPB9jCMvdFD8mbGJcsgscVk/FeXfVWQE9A==
X-Google-Smtp-Source: ABdhPJxpL+DWyC0FoTO1YAWYVnlZAdQJ5WxGvtfVW7gwpqnEEE8vaCj5NbgMNP60cY78yTLqrL4BOkDVYACEyGq6G/w=
X-Received: by 2002:a19:771d:: with SMTP id s29mr2365496lfc.521.1600178038699;
 Tue, 15 Sep 2020 06:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200915055825.5279-1-songmuchun@bytedance.com>
In-Reply-To: <20200915055825.5279-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 15 Sep 2020 06:53:47 -0700
Message-ID: <CALvZod52oXCF49GuU1GM3Zk25n1hgCVwKqz1ckigPHMuCQhvDQ@mail.gmail.com>
Subject: Re: [PATCH v4] mm: memcontrol: Add the missing numa_stat interface
 for cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 10:59 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> In the cgroup v1, we have a numa_stat interface. This is useful for
> providing visibility into the numa locality information within an
> memcg since the pages are allowed to be allocated from any physical
> node. One of the use cases is evaluating application performance by
> combining this information with the application's CPU allocation.
> But the cgroup v2 does not. So this patch adds the missing information.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Shakeel Butt <shakeelb@google.com>

Small nits below.

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  changelog in v4:
>  1. Fix some document problems pointed out by Randy Dunlap.
>  2. Remove memory_numa_stat_format() suggested by Shakeel Butt.
>
>  changelog in v3:
>  1. Fix compiler error on powerpc architecture reported by kernel test robot.
>  2. Fix a typo from "anno" to "anon".
>
>  changelog in v2:
>  1. Add memory.numa_stat interface in cgroup v2.
>
>  Documentation/admin-guide/cgroup-v2.rst | 72 +++++++++++++++++++++
>  mm/memcontrol.c                         | 86 +++++++++++++++++++++++++
>  2 files changed, 158 insertions(+)
>
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 6be43781ec7f..bcb7b202e88d 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1368,6 +1368,78 @@ PAGE_SIZE multiple when read back.
>                 collapsing an existing range of pages. This counter is not
>                 present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
>
> +  memory.numa_stat
> +       A read-only flat-keyed file which exists on non-root cgroups.
> +
> +       This breaks down the cgroup's memory footprint into different
> +       types of memory, type-specific details, and other information
> +       per node on the state of the memory management system.
> +
> +       This is useful for providing visibility into the NUMA locality
> +       information within an memcg since the pages are allowed to be
> +       allocated from any physical node. One of the use cases is evaluating

use case

> +       application performance by combining this information with the
> +       application's CPU allocation.
> +
> +       All memory amounts are in bytes.
> +
> +       The output format of memory.numa_stat is::
> +
> +         type N0=<bytes in node 0 pages> N1=<bytes in node 1 pages> ...

I would remove 'pages' here as it can be confusing. Just <bytes on node 0>...

> +
> +       The entries are ordered to be human readable, and new entries
> +       can show up in the middle. Don't rely on items remaining in a
> +       fixed position; use the keys to look up specific values!
> +
> +         anon
> +               Amount of memory per node used in anonymous mappings such
> +               as brk(), sbrk(), and mmap(MAP_ANONYMOUS).
> +
> +         file
> +               Amount of memory per node used to cache filesystem data,
> +               including tmpfs and shared memory.
> +
> +         kernel_stack
> +               Amount of memory per node allocated to kernel stacks.
> +
> +         shmem
> +               Amount of cached filesystem data per node that is swap-backed,
> +               such as tmpfs, shm segments, shared anonymous mmap()s.
> +
> +         file_mapped
> +               Amount of cached filesystem data per node mapped with mmap().
> +
> +         file_dirty
> +               Amount of cached filesystem data per node that was modified but
> +               not yet written back to disk.
> +
> +         file_writeback
> +               Amount of cached filesystem data per node that was modified and
> +               is currently being written back to disk.
> +
> +         anon_thp
> +               Amount of memory per node used in anonymous mappings backed by
> +               transparent hugepages.
> +
> +         inactive_anon, active_anon, inactive_file, active_file, unevictable
> +               Amount of memory, swap-backed and filesystem-backed,
> +               per node on the internal memory management lists used
> +               by the page reclaim algorithm.
> +
> +               As these represent internal list state (e.g. shmem pages are on
> +               anon memory management lists), inactive_foo + active_foo may not
> +               be equal to the value for the foo counter, since the foo counter
> +               is type-based, not list-based.
> +
> +         slab_reclaimable
> +               Amount of memory per node used for storing in-kernel data
> +               structures which might be reclaimed, such as dentries and
> +               inodes.
> +
> +         slab_unreclaimable
> +               Amount of memory per node used for storing in-kernel data
> +               structures which cannot be reclaimed on memory pressure.
> +
>    memory.swap.current
>         A read-only single value file which exists on non-root
>         cgroups.
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 75cd1a1e66c8..ff919ef3b57b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6425,6 +6425,86 @@ static int memory_stat_show(struct seq_file *m, void *v)
>         return 0;
>  }
>
> +#ifdef CONFIG_NUMA
> +struct numa_stat {
> +       const char *name;
> +       unsigned int ratio;
> +       enum node_stat_item idx;
> +};
> +
> +static struct numa_stat numa_stats[] = {
> +       { "anon", PAGE_SIZE, NR_ANON_MAPPED },
> +       { "file", PAGE_SIZE, NR_FILE_PAGES },
> +       { "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> +       { "shmem", PAGE_SIZE, NR_SHMEM },
> +       { "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> +       { "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> +       { "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       /*
> +        * The ratio will be initialized in numa_stats_init(). Because
> +        * on some architectures, the macro of HPAGE_PMD_SIZE is not
> +        * constant(e.g. powerpc).
> +        */
> +       { "anon_thp", 0, NR_ANON_THPS },
> +#endif
> +       { "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> +       { "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> +       { "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> +       { "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> +       { "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> +       { "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> +       { "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> +};
> +
> +static int __init numa_stats_init(void)
> +{
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +               if (numa_stats[i].idx == NR_ANON_THPS)
> +                       numa_stats[i].ratio = HPAGE_PMD_SIZE;
> +#endif
> +       }
> +
> +       return 0;
> +}
> +pure_initcall(numa_stats_init);
> +
> +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> +                                          unsigned int nid,
> +                                          enum node_stat_item idx)
> +{
> +       VM_BUG_ON(nid >= nr_node_ids);
> +       return lruvec_page_state(mem_cgroup_lruvec(memcg, NODE_DATA(nid)), idx);
> +}
> +
> +static int memory_numa_stat_show(struct seq_file *m, void *v)
> +{
> +       int i;
> +       struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> +
> +       for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> +               int nid;
> +
> +               seq_printf(m, "%s", numa_stats[i].name);
> +               for_each_node_state(nid, N_MEMORY) {
> +                       u64 size;
> +
> +                       size = memcg_node_page_state(memcg, nid,
> +                                                    numa_stats[i].idx);
> +                       VM_WARN_ON_ONCE(!numa_stats[i].ratio);
> +                       size *= numa_stats[i].ratio;
> +                       seq_printf(m, " N%d=%llu", nid, size);
> +               }
> +               seq_putc(m, '\n');
> +       }
> +
> +       return 0;
> +}
> +#endif
> +
>  static int memory_oom_group_show(struct seq_file *m, void *v)
>  {
>         struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
> @@ -6502,6 +6582,12 @@ static struct cftype memory_files[] = {
>                 .name = "stat",
>                 .seq_show = memory_stat_show,
>         },
> +#ifdef CONFIG_NUMA
> +       {
> +               .name = "numa_stat",
> +               .seq_show = memory_numa_stat_show,
> +       },
> +#endif
>         {
>                 .name = "oom.group",
>                 .flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
> --
> 2.20.1
>
