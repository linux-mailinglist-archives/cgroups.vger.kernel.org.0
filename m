Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2226AFEA
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgIOVua (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 17:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgIOVuZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 17:50:25 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D8C061797
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 14:50:11 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k25so4518306qtu.4
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 14:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gwAGdDXVM4r4OL55XSo1884lNeDAwaOm7bwctRtLrys=;
        b=uOWcBox38dGodh/iQrPqVF2GLIJyW9L4Y3ANaEZXp2ypNq6/uKrX+x43BZP8K1yuwB
         TjBbkfHme3SAZjHyCDwS27BnDVQcAodcI29aOajz9qZKP6YTdfgiHiG7ERgW0xkoMkZc
         vnnYhnh1hdS2aYSiqfXF918Ttjkg/AZluGilhI1SM4HJ2oSeNm8sbJrtEH/4xheskIPM
         Fn349hTQnPUj1MoyZwZEIsaKO2GhGt3GRpPEws4hszG3mSahAm4PmzMdhBav2zpg/aGG
         GkAk3u/IFwWEN8bb5pmjgdXCg+UJyIAZ1cTAk/PMXcWapHOK0hyjAleZE0fB0RVgd8O4
         IhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gwAGdDXVM4r4OL55XSo1884lNeDAwaOm7bwctRtLrys=;
        b=c5JxHt6I6BZuM02Wz8HO2duIT6VluH9ntgZ425R9V+duPXL2RzUypcYHtTMbxW533Z
         HMrR6Rx3TNIXsNKC5K8GmaVe2ReE/fu0NqB6Qvgxm0RMnP4PvmL3j9dyNJ1WdjY62pfP
         oFwpgg1UY8SqcgLYbRAaPjD6dEcHnnSb3LuVRtDrontiDDrh4IJUPd2XRWJhi9zRFaSk
         UA92BS/AGn/b/2oTXg9ib5ifx2nl7dEE9ObSSy4cVHqFQ6dt4zdZl2koBVhJq8ZfxE5G
         jvT3anhiXOEeYJ2sALuVCYqdZguIHHcOC6iJcdPCAHcXXOOkWgvmQhMCJlfuV3AuxVEF
         g/5g==
X-Gm-Message-State: AOAM533yz6E5FjP9haoMXW9Ql3ADUYbE05LmGizzhE9iifXYgOnl5s/j
        Uu2BoCx0HDou3GPdonJvHsTACg==
X-Google-Smtp-Source: ABdhPJzQh75yII3N5KV/1tjYmS/zxa6QaCbe44anS0rhYQ2i1j9XbUmXAcwDIwvYDSQHA5IH+rQ8SQ==
X-Received: by 2002:ac8:863:: with SMTP id x32mr7523555qth.27.1600206609589;
        Tue, 15 Sep 2020 14:50:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:124c])
        by smtp.gmail.com with ESMTPSA id b79sm18586859qkg.10.2020.09.15.14.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 14:50:08 -0700 (PDT)
Date:   Tue, 15 Sep 2020 17:48:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     tj@kernel.org, lizefan@huawei.com, corbet@lwn.net,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        rdunlap@infradead.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5] mm: memcontrol: Add the missing numa_stat interface
 for cgroup v2
Message-ID: <20200915214845.GB189808@cmpxchg.org>
References: <20200915171801.39761-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915171801.39761-1-songmuchun@bytedance.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 16, 2020 at 01:18:01AM +0800, Muchun Song wrote:
> In the cgroup v1, we have a numa_stat interface. This is useful for
> providing visibility into the numa locality information within an
> memcg since the pages are allowed to be allocated from any physical
> node. One of the use cases is evaluating application performance by
> combining this information with the application's CPU allocation.
> But the cgroup v2 does not. So this patch adds the missing information.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Yup, that would be useful information to have. Just a few comments on
the patch below:

> @@ -1368,6 +1368,78 @@ PAGE_SIZE multiple when read back.
>  		collapsing an existing range of pages. This counter is not
>  		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
>  
> +  memory.numa_stat
> +	A read-only flat-keyed file which exists on non-root cgroups.

It's a nested key file, not flat.

> +	This breaks down the cgroup's memory footprint into different
> +	types of memory, type-specific details, and other information
> +	per node on the state of the memory management system.
> +
> +	This is useful for providing visibility into the NUMA locality
> +	information within an memcg since the pages are allowed to be
> +	allocated from any physical node. One of the use case is evaluating
> +	application performance by combining this information with the
> +	application's CPU allocation.
> +
> +	All memory amounts are in bytes.
> +
> +	The output format of memory.numa_stat is::
> +
> +	  type N0=<bytes in node 0> N1=<bytes in node 1> ...
> +
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

This is a bit duplicative with memory_stat_format(), and the
collections will easily go out of sync as we add/change stat items.

Can you please convert memory_stat_format() to use the same shared table?

You may have to add another flag for the MEMCG_* items for which we
don't have per-node counters.

The same applies to the documentation. Please don't duplicate the list
of items, but have memory.numa_stat refer to the list for memory.stat.
You can add (not in memory.numa_stat) or something to percpu and sock.

> +static unsigned long memcg_node_page_state(struct mem_cgroup *memcg,
> +					   unsigned int nid,
> +					   enum node_stat_item idx)
> +{
> +	VM_BUG_ON(nid >= nr_node_ids);
> +	return lruvec_page_state(mem_cgroup_lruvec(memcg, NODE_DATA(nid)), idx);
> +}

Please drop this wrapper and use lruvec_page_state directly below.

Otherwise, this looks reasonable to me.
