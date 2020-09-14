Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41583269541
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 21:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgINTHK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 15:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINTHJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 15:07:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369FBC06174A;
        Mon, 14 Sep 2020 12:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=N8T1tOQR2qSaR9SyfG7NteG59Ly5LuoTRUVFcE43ejU=; b=Ecx5Y31AlKnUhF8sXiscXGFIIB
        JTAlDxNPr/zeVUsrVCiFy7EckaHazxjuuNYGH70OaQjzQgJmn6TWMmuMTO2kOmylfn25jg1MYb5GE
        m9Fmx2lLCfgFlxSnjmCTQ0g5FtuJ7JC2vqGjBfkpA7dIoF6dvhCKWBrELvUJon4TAJ2+6gtzavTZs
        J433nKXEHXHypR8mAtl0NACx3CQUsIsdBpm4yCBl0wBZAdHCSllkRYxOrONb1Lgkq4vAZYVtTtQUG
        HFeEFVSahZQBHnZef0RHKlBKY71FHxMqq524y4b1L0/C+Q8Dt5V7F+eu9g+DMKkgis6HD4fCC8XmM
        owHU1kEw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHtoW-0002rB-SZ; Mon, 14 Sep 2020 19:06:57 +0000
Subject: Re: [PATCH v3] mm: memcontrol: Add the missing numa_stat interface
 for cgroup v2
To:     Muchun Song <songmuchun@bytedance.com>, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, corbet@lwn.net,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel test robot <lkp@intel.com>
References: <20200913070010.44053-1-songmuchun@bytedance.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8387344f-0e43-9b6e-068d-b2c45bbda1de@infradead.org>
Date:   Mon, 14 Sep 2020 12:06:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200913070010.44053-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/13/20 12:00 AM, Muchun Song wrote:
> In the cgroup v1, we have a numa_stat interface. This is useful for
> providing visibility into the numa locality information within an
> memcg since the pages are allowed to be allocated from any physical
> node. One of the use cases is evaluating application performance by
> combining this information with the application's CPU allocation.
> But the cgroup v2 does not. So this patch adds the missing information.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  changelog in v3:
>  1. Fix compiler error on powerpc architecture reported by kernel test robot.
>  2. Fix a typo from "anno" to "anon".
> 
>  changelog in v2:
>  1. Add memory.numa_stat interface in cgroup v2.
> 
>  Documentation/admin-guide/cgroup-v2.rst |  72 ++++++++++++++++
>  mm/memcontrol.c                         | 107 ++++++++++++++++++++++++
>  2 files changed, 179 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 6be43781ec7f..92207f0012e4 100644
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
> +	This is useful for providing visibility into the numa locality

capitalize acronyms, please:                             NUMA


> +	information within an memcg since the pages are allowed to be
> +	allocated from any physical node. One of the use cases is evaluating
> +	application performance by combining this information with the
> +	application's CPU allocation.
> +
> +	All memory amounts are in bytes.
> +
> +	The output format of memory.numa_stat is::
> +
> +	  type N0=<node 0 pages> N1=<node 1 pages> ...

Now I'm confused.  5 lines above here it says "All memory amounts are in bytes"
but these appear to be in pages. Which is it?  and what size pages if that matters?

Is it like this?
	  type N0=<bytes in node 0 pages> N1=<bytes in node 1 pages> ...



> +	The entries are ordered to be human readable, and new entries
> +	can show up in the middle. Don't rely on items remaining in a
> +	fixed position; use the keys to look up specific values!
> +
> +	  anon
> +		Amount of memory per node used in anonymous mappings such
> +		as brk(), sbrk(), and mmap(MAP_ANONYMOUS)
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
> +		such as tmpfs, shm segments, shared anonymous mmap()s
> +
> +	  file_mapped
> +		Amount of cached filesystem data per node mapped with mmap()
> +
> +	  file_dirty
> +		Amount of cached filesystem data per node that was modified but
> +		not yet written back to disk
> +
> +	  file_writeback
> +		Amount of cached filesystem data per node that was modified and
> +		is currently being written back to disk
> +
> +	  anon_thp
> +		Amount of memory per node used in anonymous mappings backed by
> +		transparent hugepages
> +
> +	  inactive_anon, active_anon, inactive_file, active_file, unevictable
> +		Amount of memory, swap-backed and filesystem-backed,
> +		per node on the internal memory management lists used
> +		by the page reclaim algorithm.
> +
> +		As these represent internal list state (eg. shmem pages are on anon

		                                         e.g.

> +		memory management lists), inactive_foo + active_foo may not be equal to
> +		the value for the foo counter, since the foo counter is type-based, not
> +		list-based.
> +
> +	  slab_reclaimable
> +		Amount of memory per node used for storing in-kernel data
> +		structures which might be reclaimed, such as dentries and
> +		inodes.
> +
> +	  slab_unreclaimable
> +		Amount of memory per node used for storing in-kernel data
> +		structures which cannot be reclaimed on memory pressure.

Some of the descriptions above end with a '.' and some do not. Please be consistent.

> +
>    memory.swap.current
>  	A read-only single value file which exists on non-root
>  	cgroups.


thanks.
-- 
~Randy

