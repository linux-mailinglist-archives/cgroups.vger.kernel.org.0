Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588B2261012
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgIHKiv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 06:38:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:37308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbgIHKir (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 8 Sep 2020 06:38:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB8FDAF3F;
        Tue,  8 Sep 2020 10:38:16 +0000 (UTC)
Date:   Tue, 8 Sep 2020 12:38:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: rename watermark as max_usage
Message-ID: <20200908103815.GC26850@dhcp22.suse.cz>
References: <1599560721-68915-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599560721-68915-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 08-09-20 18:25:21, Alex Shi wrote:
> The page_counter's watermark used to show as max_usage_in_bytes in memory
> cgroup. named as watermark is a kind of misleadking. So, let's rename it
> as it usage.

Is this really necessary? This just adds a code churn for something that
is highly subjective.

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: Johannes Weiner <hannes@cmpxchg.org> 
> Cc: Michal Hocko <mhocko@kernel.org> 
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com> 
> Cc: linux-kernel@vger.kernel.org 
> Cc: linux-mm@kvack.org 
> Cc: cgroups@vger.kernel.org 
> ---
>  include/linux/page_counter.h |  6 +++---
>  mm/hugetlb_cgroup.c          |  8 ++++----
>  mm/memcontrol.c              |  4 ++--
>  mm/page_counter.c            | 12 ++++++------
>  4 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 85bd413e784e..813f2da26c36 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -25,7 +25,7 @@ struct page_counter {
>  	atomic_long_t children_low_usage;
>  
>  	/* legacy */
> -	unsigned long watermark;
> +	unsigned long max_usage;	/* max_usage_in_bytes */
>  	unsigned long failcnt;
>  };
>  
> @@ -67,9 +67,9 @@ static inline void page_counter_set_high(struct page_counter *counter,
>  int page_counter_memparse(const char *buf, const char *max,
>  			  unsigned long *nr_pages);
>  
> -static inline void page_counter_reset_watermark(struct page_counter *counter)
> +static inline void page_counter_reset_max_usage(struct page_counter *counter)
>  {
> -	counter->watermark = page_counter_read(counter);
> +	counter->max_usage = page_counter_read(counter);
>  }
>  
>  #endif /* _LINUX_PAGE_COUNTER_H */
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 1f87aec9ab5c..c7484f5eb8ef 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -437,9 +437,9 @@ static u64 hugetlb_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	case RES_RSVD_LIMIT:
>  		return (u64)rsvd_counter->max * PAGE_SIZE;
>  	case RES_MAX_USAGE:
> -		return (u64)counter->watermark * PAGE_SIZE;
> +		return (u64)counter->max_usage * PAGE_SIZE;
>  	case RES_RSVD_MAX_USAGE:
> -		return (u64)rsvd_counter->watermark * PAGE_SIZE;
> +		return (u64)rsvd_counter->max_usage * PAGE_SIZE;
>  	case RES_FAILCNT:
>  		return counter->failcnt;
>  	case RES_RSVD_FAILCNT:
> @@ -553,10 +553,10 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
>  
>  	switch (MEMFILE_ATTR(of_cft(of)->private)) {
>  	case RES_MAX_USAGE:
> -		page_counter_reset_watermark(counter);
> +		page_counter_reset_max_usage(counter);
>  		break;
>  	case RES_RSVD_MAX_USAGE:
> -		page_counter_reset_watermark(rsvd_counter);
> +		page_counter_reset_max_usage(rsvd_counter);
>  		break;
>  	case RES_FAILCNT:
>  		counter->failcnt = 0;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c74f1200261..21b73de53073 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3559,7 +3559,7 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	case RES_LIMIT:
>  		return (u64)counter->max * PAGE_SIZE;
>  	case RES_MAX_USAGE:
> -		return (u64)counter->watermark * PAGE_SIZE;
> +		return (u64)counter->max_usage * PAGE_SIZE;
>  	case RES_FAILCNT:
>  		return counter->failcnt;
>  	case RES_SOFT_LIMIT:
> @@ -3839,7 +3839,7 @@ static ssize_t mem_cgroup_reset(struct kernfs_open_file *of, char *buf,
>  
>  	switch (MEMFILE_ATTR(of_cft(of)->private)) {
>  	case RES_MAX_USAGE:
> -		page_counter_reset_watermark(counter);
> +		page_counter_reset_max_usage(counter);
>  		break;
>  	case RES_FAILCNT:
>  		counter->failcnt = 0;
> diff --git a/mm/page_counter.c b/mm/page_counter.c
> index afe22ad335cc..d88ee074f4a6 100644
> --- a/mm/page_counter.c
> +++ b/mm/page_counter.c
> @@ -75,10 +75,10 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>  		propagate_protected_usage(c, new);
>  		/*
>  		 * This is indeed racy, but we can live with some
> -		 * inaccuracy in the watermark.
> +		 * inaccuracy in the max_usage.
>  		 */
> -		if (new > READ_ONCE(c->watermark))
> -			WRITE_ONCE(c->watermark, new);
> +		if (new > READ_ONCE(c->max_usage))
> +			WRITE_ONCE(c->max_usage, new);
>  	}
>  }
>  
> @@ -129,10 +129,10 @@ bool page_counter_try_charge(struct page_counter *counter,
>  		propagate_protected_usage(c, new);
>  		/*
>  		 * Just like with failcnt, we can live with some
> -		 * inaccuracy in the watermark.
> +		 * inaccuracy in the max_usage.
>  		 */
> -		if (new > READ_ONCE(c->watermark))
> -			WRITE_ONCE(c->watermark, new);
> +		if (new > READ_ONCE(c->max_usage))
> +			WRITE_ONCE(c->max_usage, new);
>  	}
>  	return true;
>  
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
