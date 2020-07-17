Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813CE223718
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 10:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgGQIeY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 04:34:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43342 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQIeY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 04:34:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id j4so10070890wrp.10
        for <cgroups@vger.kernel.org>; Fri, 17 Jul 2020 01:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UfhL2reVkXBsS/hWgwm1viNovyFExr39sLp/lV2ioDI=;
        b=FLuT1SNLtG/HOwtfHsBi8oFUZvqFYh8+rxadwb9V+AZl7vvxXHwxMeyFou/taokqM9
         U+VkP2oJsTPx0HZwnTjSQqgrTv1OdkenQmZYFLg+TOmn6WvNLjNGrBSWy/nOwHpNENIK
         9TYvxelsu5/NeWpRVJIU/qAEz9hc4Yjk5gaadmI6fTeMJbz4XmmXAw5uutJNZKzPvxwD
         cQgguReKK+LtsKT6R6AyRBeSaZJCPZCyWGmFgJL+CgyhhLu6SonlOXE3EY4Zj2FtAByA
         BVMJoX3GfBJHbJHPayecuLJrNzXKy+91Vb3s0AostzS/mzieGi+D4TPhh2i8xLnKtzga
         UbIQ==
X-Gm-Message-State: AOAM530W6dstT8ZFUbJR5q1GLvC6cmeVvt02pLXUOXHLMqVLFMEI6SWU
        c0LpLNF6hXdkwbIMV0PUOks=
X-Google-Smtp-Source: ABdhPJzGDL/B3yrMnkpUkwB1qMqdmYEMftHGGpTAO2v1HxlyNaX29hMz1jHqMlYuXIKel7d4LrZYXQ==
X-Received: by 2002:adf:f452:: with SMTP id f18mr9031837wrp.389.1594974861386;
        Fri, 17 Jul 2020 01:34:21 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id 5sm12008096wmk.9.2020.07.17.01.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 01:34:20 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:34:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, memcg: provide an anon_reclaimable stat
Message-ID: <20200717083419.GD10655@dhcp22.suse.cz>
References: <20200715071522.19663-1-sjpark@amazon.com>
 <alpine.DEB.2.23.453.2007151031020.2788464@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 16-07-20 13:58:19, David Rientjes wrote:
> Userspace can lack insight into the amount of memory that can be reclaimed
> from a memcg based on values from memory.stat.  Two specific examples:
> 
>  - Lazy freeable memory (MADV_FREE) that are clean anonymous pages on the
>    inactive file LRU that can be quickly reclaimed under memory pressure
>    but otherwise shows up as mapped anon in memory.stat, and
> 
>  - Memory on deferred split queues (thp) that are compound pages that can
>    be split and uncharged from the memcg under memory pressure, but
>    otherwise shows up as charged anon LRU memory in memory.stat.
> 
> Both of this anonymous usage is also charged to memory.current.
> 
> Userspace can currently derive this information but it depends on kernel
> implementation details for how this memory is handled for the purposes of
> reclaim (anon on inactive file LRU or unmapped anon on the LRU).
> 
> For the purposes of writing portable userspace code that does not need to
> have insight into the kernel implementation for reclaimable memory, this
> exports a stat that reveals the amount of anonymous memory that can be
> reclaimed and uncharged from the memcg to start new applications.
> 
> As the kernel implementation evolves for memory that can be reclaimed
> under memory pressure, this stat can be kept consistent.

Please be much more specific about the expected usage. You have
mentioned something in the email thread but this really belongs to the
changelog.

Why is reclaimable anonymous memory without any swap any special, say
from any other clean and easily reclaimable caches? What if there is a
swap available?

> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  6 +++++
>  mm/memcontrol.c                         | 31 +++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1296,6 +1296,12 @@ PAGE_SIZE multiple when read back.
>  		Amount of memory used in anonymous mappings backed by
>  		transparent hugepages
>  
> +	  anon_reclaimable
> +		The amount of charged anonymous memory that can be reclaimed
> +		under memory pressure without swap.  This currently includes
> +		lazy freeable memory (MADV_FREE) and compound pages that can be
> +		split and uncharged.
> +
>  	  inactive_anon, active_anon, inactive_file, active_file, unevictable
>  		Amount of memory, swap-backed and filesystem-backed,
>  		on the internal memory management lists used by the
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1350,6 +1350,32 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> +/*
> + * Returns the amount of anon memory that is charged to the memcg that is
> + * reclaimable under memory pressure without swap, in pages.
> + */
> +static unsigned long memcg_anon_reclaimable(struct mem_cgroup *memcg)
> +{
> +	long deferred, lazyfree;
> +
> +	/*
> +	 * Deferred pages are charged anonymous pages that are on the LRU but
> +	 * are unmapped.  These compound pages are split under memory pressure.
> +	 */
> +	deferred = max_t(long, memcg_page_state(memcg, NR_ACTIVE_ANON) +
> +			       memcg_page_state(memcg, NR_INACTIVE_ANON) -
> +			       memcg_page_state(memcg, NR_ANON_MAPPED), 0);
> +	/*
> +	 * Lazyfree pages are charged clean anonymous pages that are on the file
> +	 * LRU and can be reclaimed under memory pressure.
> +	 */
> +	lazyfree = max_t(long, memcg_page_state(memcg, NR_ACTIVE_FILE) +
> +			       memcg_page_state(memcg, NR_INACTIVE_FILE) -
> +			       memcg_page_state(memcg, NR_FILE_PAGES), 0);
> +
> +	return deferred + lazyfree;
> +}
> +
>  static char *memory_stat_format(struct mem_cgroup *memcg)
>  {
>  	struct seq_buf s;
> @@ -1363,6 +1389,9 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	 * Provide statistics on the state of the memory subsystem as
>  	 * well as cumulative event counters that show past behavior.
>  	 *
> +	 * All values in this buffer are read individually, so no implied
> +	 * consistency amongst them.
> +	 *
>  	 * This list is ordered following a combination of these gradients:
>  	 * 1) generic big picture -> specifics and details
>  	 * 2) reflecting userspace activity -> reflecting kernel heuristics
> @@ -1405,6 +1434,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  		       (u64)memcg_page_state(memcg, NR_ANON_THPS) *
>  		       HPAGE_PMD_SIZE);
>  #endif
> +	seq_buf_printf(&s, "anon_reclaimable %llu\n",
> +		       (u64)memcg_anon_reclaimable(memcg) * PAGE_SIZE);
>  
>  	for (i = 0; i < NR_LRU_LISTS; i++)
>  		seq_buf_printf(&s, "%s %llu\n", lru_list_name(i),

-- 
Michal Hocko
SUSE Labs
