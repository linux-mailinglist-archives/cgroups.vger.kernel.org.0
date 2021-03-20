Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF86A34297F
	for <lists+cgroups@lfdr.de>; Sat, 20 Mar 2021 01:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhCTAhK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 20:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCTAhJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 20:37:09 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C845C061760
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 17:37:09 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 30so5922236qva.9
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 17:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H32BiG5uVbVuFxmwCpF2KKiECub+9Q87dwD3O3nQAqE=;
        b=GBwCvH1XQnx7w1PrWLCnAJP/lbZicgZcZ6l+0dIOLGaqMyPeIUof3lZDWfnfrXXQcL
         Bm1vOOnoNETjUYTm6RGiXuzi5hDwncvfso74R5ebbfCcNneqquQ8eHevAaCL9YbWwjRH
         88+lJmMXWkonQp/xjvsgTd3W9m1RbKLzQHhOTIuKifakfSjd7VLWO3INyM0BcAYf7ytl
         M/D+KDX/hDusVctiE+iguv2c63rY6WthxqNjJayFUsRrg2qkYuIA5Qn2P8TYoN+1Jlmm
         oBXJPbZ1JFSYxgQAgd66uwnwu/FWpm1XdfTFsFU5Xq7JZdyl019ZDpzTJvRG3WK1eZoJ
         6Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H32BiG5uVbVuFxmwCpF2KKiECub+9Q87dwD3O3nQAqE=;
        b=iDCbbZgNPNpPXouXFcPFSSPCx3LzIx9/Nid+Hpwt2EBbdNiIcmHJiyXgFF14iN1gR8
         KdEGCpL+zQSwauH0Jn3grfgekjVD4IevZlSIvHTUdhwv0tQLRM+pouLr02DmFFNMeEnw
         ULtwwSiZy/jRRxScOcyzHWvrMBzJduxaWZi/+vHOenY9LF8z5hKnvP0TZzsirV8f2BBb
         xQW2SE8u472LIZnAVCQOgFagQfWzO1GSxUxBinF5JnyXRWdr464A3uD+a7XrOsrr6OUG
         DHRlbz4RaiGi2zAO7RT+sgBQQ5INHSKa4p7cvf+kec9U3//yBvCNjlfYufi8hmme11Cc
         Lx+Q==
X-Gm-Message-State: AOAM532p24n9HxhoCsIAkhH/SR3J53ZmWIcsk7+Ix2a8clGRZgOid+PY
        ue1h7KPZUZ2L5DZx8bclkOW69w==
X-Google-Smtp-Source: ABdhPJyzyu5DFfbH07loAVnMTYvMfRyWrSB+w2fAMD4Kq9e4mPb0X73hYa1mckV7xzsHt5Hem0HFWg==
X-Received: by 2002:a05:6214:4a4:: with SMTP id w4mr802511qvz.22.1616200627764;
        Fri, 19 Mar 2021 17:37:07 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k28sm5756083qki.101.2021.03.19.17.37.06
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 19 Mar 2021 17:37:07 -0700 (PDT)
Date:   Fri, 19 Mar 2021 17:37:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: memcontrol: deprecate swapaccounting=0 mode
In-Reply-To: <20210319054944.50048-2-hannes@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2103191633350.1043@eggly.anvils>
References: <20210319054944.50048-1-hannes@cmpxchg.org> <20210319054944.50048-2-hannes@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 19 Mar 2021, Johannes Weiner wrote:

> The swapaccounting= commandline option already does very little
> today. To close a trivial containment failure case, the swap ownership
> tracking part of the swap controller has recently become mandatory
> (see commit 2d1c498072de ("mm: memcontrol: make swap tracking an
> integral part of memory control") for details), which makes up the
> majority of the work during swapout, swapin, and the swap slot map.
> 
> The only thing left under this flag is the page_counter operations and
> the visibility of the swap control files in the first place, which are
> rather meager savings. There also aren't many scenarios, if any, where
> controlling the memory of a cgroup while allowing it unlimited access
> to a global swap space is a workable resource isolation stragegy.
> 
> On the other hand, there have been several bugs and confusion around
> the many possible swap controller states (cgroup1 vs cgroup2 behavior,
> memory accounting without swap accounting, memcg runtime disabled).
> 
> This puts the maintenance overhead of retaining the toggle above its
> practical benefits. Deprecate it.
> 
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

This crashes, and needs a fix: see below (plus some nits).

But it's a very welcome cleanup: just getting rid of all those
!cgroup_memory_noswap double negatives is a relief in itself.

It does suggest eliminating CONFIG_MEMCG_SWAP altogether (just
using #ifdef CONFIG_SWAP instead, in those parts of CONFIG_MEMCG code);
but you're right that's a separate cleanup, and not nearly so worthwhile
as this one (I notice CONFIG_MEMCG_SWAP in some of the arch defconfigs,
and don't know whether whoever removes CONFIG_MEMCG_SWAP would be
obligated to remove those too).

> ---
>  .../admin-guide/kernel-parameters.txt         |  5 --
>  include/linux/memcontrol.h                    |  4 --
>  mm/memcontrol.c                               | 48 ++++++-------------
>  3 files changed, 15 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 942bbef8f128..986d45dd8c37 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5322,11 +5322,6 @@
>  			This parameter controls use of the Protected
>  			Execution Facility on pSeries.
>  
> -	swapaccount=[0|1]
> -			[KNL] Enable accounting of swap in memory resource
> -			controller if no parameter or 1 is given or disable
> -			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
> -
>  	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
>  			Format: { <int> | force | noforce }
>  			<int> -- Number of I/O TLB slabs
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 4064c9dda534..ef9613538d36 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -874,10 +874,6 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>  					    struct mem_cgroup *oom_domain);
>  void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
>  
> -#ifdef CONFIG_MEMCG_SWAP
> -extern bool cgroup_memory_noswap;
> -#endif
> -
>  void lock_page_memcg(struct page *page);
>  void unlock_page_memcg(struct page *page);
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 49bdcf603af1..b036c4fb0fa7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -85,13 +85,6 @@ static bool cgroup_memory_nosocket;
>  /* Kernel memory accounting disabled? */
>  static bool cgroup_memory_nokmem;
>  
> -/* Whether the swap controller is active */
> -#ifdef CONFIG_MEMCG_SWAP
> -bool cgroup_memory_noswap __read_mostly;
> -#else
> -#define cgroup_memory_noswap		1
> -#endif
> -
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
>  #endif
> @@ -99,7 +92,11 @@ static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
>  /* Whether legacy memory+swap accounting is active */
>  static bool do_memsw_account(void)
>  {
> -	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_noswap;
> +	/* cgroup2 doesn't do mem+swap accounting */
> +	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return false;
> +
> +	return true;

Nit: I'm not fond of the "if (boolean()) return true; else return false;"
codestyle, and would prefer the straightforward

	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);

but you've chosen otherwise, so, okay.

>  }
>  
>  #define THRESHOLDS_EVENTS_TARGET 128
> @@ -7019,7 +7016,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	if (!mem_cgroup_is_root(memcg))
>  		page_counter_uncharge(&memcg->memory, nr_entries);
>  
> -	if (!cgroup_memory_noswap && memcg != swap_memcg) {
> +	if (memcg != swap_memcg) {
>  		if (!mem_cgroup_is_root(swap_memcg))
>  			page_counter_charge(&swap_memcg->memsw, nr_entries);
>  		page_counter_uncharge(&memcg->memsw, nr_entries);
> @@ -7073,7 +7070,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  
>  	memcg = mem_cgroup_id_get_online(memcg);
>  
> -	if (!cgroup_memory_noswap && !mem_cgroup_is_root(memcg) &&
> +	if (!mem_cgroup_is_root(memcg) &&
>  	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
>  		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
>  		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
> @@ -7108,7 +7105,7 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_id(id);
>  	if (memcg) {
> -		if (!cgroup_memory_noswap && !mem_cgroup_is_root(memcg)) {
> +		if (!mem_cgroup_is_root(memcg)) {
>  			if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  				page_counter_uncharge(&memcg->swap, nr_pages);
>  			else
> @@ -7124,7 +7121,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
>  {
>  	long nr_swap_pages = get_nr_swap_pages();
>  
> -	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))

That needs to check mem_cgroup_disabled() where it used to check
cgroup_memory_noswap.  The convolutions are confusing (which is
precisely why this is such a welcome cleanup), but without a
mem_cgroup_disabled() (or NULL memcg) check there, the
cgroup_disable=memory case oopses on NULLish pointer dereference
when mem_cgroup_get_nr_swap_pages() is called from get_scan_count().

(This little function has been repeatedly troublesome that way.)

>  		return nr_swap_pages;
>  	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
>  		nr_swap_pages = min_t(long, nr_swap_pages,
> @@ -7141,7 +7138,7 @@ bool mem_cgroup_swap_full(struct page *page)
>  
>  	if (vm_swap_full())
>  		return true;
> -	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))

Would it now be better to say "if (do_memsw_account())" there?
Or would it be better to eliminate do_memsw_account() altogether,
and just use !cgroup_subsys_on_dfl(memory_cgrp_subsys) throughout?
(Though I don't find "cgroup_subsys_on_dfl" very informative.)

>  		return false;
>  
>  	memcg = page_memcg(page);
> @@ -7161,11 +7158,10 @@ bool mem_cgroup_swap_full(struct page *page)
>  
>  static int __init setup_swap_account(char *s)
>  {
> -	if (!strcmp(s, "1"))
> -		cgroup_memory_noswap = false;
> -	else if (!strcmp(s, "0"))
> -		cgroup_memory_noswap = true;
> -	return 1;
> +	pr_warn_once("The swapaccount= commandline option is deprecated. "
> +		     "Please report your usecase to linux-mm@kvack.org if you "
> +		     "depend on this functionality.\n");

Okay: the long line would annoy me, but that might be its intent,
and follows precedent elsewhere.

> +	return 0;
>  }
>  __setup("swapaccount=", setup_swap_account);
>  
> @@ -7291,27 +7287,13 @@ static struct cftype memsw_files[] = {
>  	{ },	/* terminate */
>  };
>  
> -/*
> - * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
> - * instead of a core_initcall(), this could mean cgroup_memory_noswap still
> - * remains set to false even when memcg is disabled via "cgroup_disable=memory"
> - * boot parameter. This may result in premature OOPS inside
> - * mem_cgroup_get_nr_swap_pages() function in corner cases.
> - */
>  static int __init mem_cgroup_swap_init(void)
>  {
> -	/* No memory control -> no swap control */
> -	if (mem_cgroup_disabled())
> -		cgroup_memory_noswap = true;
> -
> -	if (cgroup_memory_noswap)
> -		return 0;
> -

Shakeel suggested "if (mem_cgroup_disabled()) return 0;" here,
and that was the first thing I tried when I got the crash.
It did not help, as you predicted.  Some moments I think it
would be good to put in, some moments I think not: whatever.

>  	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
>  	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
>  
>  	return 0;
>  }
> -core_initcall(mem_cgroup_swap_init);
> +subsys_initcall(mem_cgroup_swap_init);
>  
>  #endif /* CONFIG_MEMCG_SWAP */
> -- 
> 2.30.1
