Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DC26B271
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 00:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgIOWqv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 18:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgIOPpH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 11:45:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE4EC061353;
        Tue, 15 Sep 2020 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=gUZlssLy9UpUFUzUUCOc7PANoLHYkS36G70FuogZvb8=; b=zrgVHfSTZglugojNEb8HXIzBxp
        6R1zZhKMLMt5Dvsabny+4pvxMQhm6V1JmPmfcwouiourPdiUh/k3JejnXSrIfNhk7bmfX3q6RMwls
        9eLWk/1HXQVbrbJGmaIqzzh96xZaIxZk67aFsVGWJcgoowvo/ju2Qqx8hYqC6Ozips/6APnRPi3OJ
        T0CpQFsJhMhgbjGVobHrY7LJwsaEnoQzpSJntNJvlSUQkurgJjbVh24HXIiAZXNc7VBt3AapozQ5q
        g7NC6IZgvgdQsWRPdyisf8KHzZTHhMALJs0Q4M9Jo7dlP5x411Sg3ZNF2o81r+fAYKW4oLlh4o1Tk
        CTroo6iA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kID8g-0005BT-KU; Tue, 15 Sep 2020 15:45:02 +0000
Subject: Re: [PATCH v4] mm: memcontrol: Add the missing numa_stat interface
 for cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, corbet@lwn.net,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200915055825.5279-1-songmuchun@bytedance.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a3e2a7bf-ae5a-9ca8-74f9-57af795f0380@infradead.org>
Date:   Tue, 15 Sep 2020 08:44:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915055825.5279-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 9/14/20 10:58 PM, Muchun Song wrote:
> In the cgroup v1, we have a numa_stat interface. This is useful for
> providing visibility into the numa locality information within an
> memcg since the pages are allowed to be allocated from any physical
> node. One of the use cases is evaluating application performance by
> combining this information with the application's CPU allocation.
> But the cgroup v2 does not. So this patch adds the missing information.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
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
>  		collapsing an existing range of pages. This counter is not
>  		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
>  
> +  memory.numa_stat
> +	A read-only flat-keyed file which exists on non-root cgroups.
> +
> +	This breaks down the cgroup's memory footprint into different
> +	types of memory, type-specific details, and other information
> +	per node on the state of the memory management system.
> +
> +	This is useful for providing visibility into the NUMA locality
> +	information within an memcg since the pages are allowed to be
> +	allocated from any physical node. One of the use cases is evaluating
> +	application performance by combining this information with the
> +	application's CPU allocation.
> +
> +	All memory amounts are in bytes.
> +
> +	The output format of memory.numa_stat is::
> +
> +	  type N0=<bytes in node 0 pages> N1=<bytes in node 1 pages> ...

I'm OK with Shakeel's suggested change here.

> +	The entries are ordered to be human readable, and new entries
> +	can show up in the middle. Don't rely on items remaining in a
> +	fixed position; use the keys to look up specific values!
> +
> +	  anon
> +		Amount of memory per node used in anonymous mappings such
> +		as brk(), sbrk(), and mmap(MAP_ANONYMOUS).
> +
> +	  file
> +		Amount of memory per node used to cache filesystem data,
> +		including tmpfs and shared memory.
> +
> +	  kernel_stack
> +		Amount of memory per node allocated to kernel stacks.
> +
> +	  shmem
> +		Amount of cached filesystem data per node that is swap-backed,
> +		such as tmpfs, shm segments, shared anonymous mmap()s.
> +
> +	  file_mapped
> +		Amount of cached filesystem data per node mapped with mmap().
> +
> +	  file_dirty
> +		Amount of cached filesystem data per node that was modified but
> +		not yet written back to disk.
> +
> +	  file_writeback
> +		Amount of cached filesystem data per node that was modified and
> +		is currently being written back to disk.
> +
> +	  anon_thp
> +		Amount of memory per node used in anonymous mappings backed by
> +		transparent hugepages.
> +
> +	  inactive_anon, active_anon, inactive_file, active_file, unevictable
> +		Amount of memory, swap-backed and filesystem-backed,
> +		per node on the internal memory management lists used
> +		by the page reclaim algorithm.
> +
> +		As these represent internal list state (e.g. shmem pages are on
> +		anon memory management lists), inactive_foo + active_foo may not
> +		be equal to the value for the foo counter, since the foo counter
> +		is type-based, not list-based.
> +
> +	  slab_reclaimable
> +		Amount of memory per node used for storing in-kernel data
> +		structures which might be reclaimed, such as dentries and
> +		inodes.
> +
> +	  slab_unreclaimable
> +		Amount of memory per node used for storing in-kernel data
> +		structures which cannot be reclaimed on memory pressure.
> +
>    memory.swap.current
>  	A read-only single value file which exists on non-root
>  	cgroups.
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 75cd1a1e66c8..ff919ef3b57b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6425,6 +6425,86 @@ static int memory_stat_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_NUMA
> +struct numa_stat {
> +	const char *name;
> +	unsigned int ratio;
> +	enum node_stat_item idx;
> +};
> +
> +static struct numa_stat numa_stats[] = {
> +	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
> +	{ "file", PAGE_SIZE, NR_FILE_PAGES },
> +	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
> +	{ "shmem", PAGE_SIZE, NR_SHMEM },
> +	{ "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
> +	{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
> +	{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	/*
> +	 * The ratio will be initialized in numa_stats_init(). Because
> +	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
> +	 * constant(e.g. powerpc).
> +	 */
> +	{ "anon_thp", 0, NR_ANON_THPS },
> +#endif
> +	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
> +	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
> +	{ "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
> +	{ "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
> +	{ "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
> +	{ "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
> +	{ "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
> +};
> +
> +static int __init numa_stats_init(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +		if (numa_stats[i].idx == NR_ANON_THPS)
> +			numa_stats[i].ratio = HPAGE_PMD_SIZE;
> +#endif
> +	}

Although the loop may be needed sometime in the future due to
other changes.. why couldn't it be like this for now?


> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	for (i = 0; i < ARRAY_SIZE(numa_stats); i++) {
> +		if (numa_stats[i].idx == NR_ANON_THPS)
> +			numa_stats[i].ratio = HPAGE_PMD_SIZE;
> +	}
> +#endif


> +
> +	return 0;
> +}
> +pure_initcall(numa_stats_init);


thanks.
-- 
~Randy

