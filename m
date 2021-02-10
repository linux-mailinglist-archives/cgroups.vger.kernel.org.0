Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63EB316200
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 10:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhBJJVe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 04:21:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:50008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhBJJTR (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 10 Feb 2021 04:19:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612948709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ASj2m7GT07IQH1F8g5mMfrRhbhZLOXHsiTlFLSHPhQs=;
        b=IhNDtf/K8be4ssN5h3aEtbjD7q1P9y2RTK5JYLMDrdSoFCLe5AU2rSwLOfTw86//DhosMy
        n7z4EDkqtrZkJVswhdgEO9Sk6ZnqtjKhUhkhTdLr/VsK9c/u/KMkNjgtavvKrQ9u5a6WLZ
        QDiZ2U6LnZHJF8LmGEZb/Z7BO93S+ag=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF47EB13F;
        Wed, 10 Feb 2021 09:18:29 +0000 (UTC)
Date:   Wed, 10 Feb 2021 10:18:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: buffer: use raw page_memcg() on locked page
Message-ID: <YCOk40NPkTO+MINR@dhcp22.suse.cz>
References: <20210209190126.97842-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209190126.97842-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 09-02-21 14:01:26, Johannes Weiner wrote:
> alloc_page_buffers() currently uses get_mem_cgroup_from_page() for
> charging the buffers to the page owner, which does an rcu-protected
> page->memcg lookup and acquires a reference. But buffer allocation has
> the page lock held throughout, which pins the page to the memcg and
> thereby the memcg - neither rcu nor holding an extra reference during
> the allocation are necessary. Use a raw page_memcg() instead.
> 
> This was the last user of get_mem_cgroup_from_page(), delete it.
> 
> Reported-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  fs/buffer.c                |  4 ++--
>  include/linux/memcontrol.h |  7 -------
>  mm/memcontrol.c            | 23 -----------------------
>  3 files changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 96c7604f69b3..dc5d3e22c493 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -847,7 +847,8 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>  	if (retry)
>  		gfp |= __GFP_NOFAIL;
>  
> -	memcg = get_mem_cgroup_from_page(page);
> +	/* The page lock pins the memcg */
> +	memcg = page_memcg(page);
>  	old_memcg = set_active_memcg(memcg);
>  
>  	head = NULL;
> @@ -868,7 +869,6 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
>  	}
>  out:
>  	set_active_memcg(old_memcg);
> -	mem_cgroup_put(memcg);
>  	return head;
>  /*
>   * In case anything failed, we just free everything we got.
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a8c7a0ccc759..a44b2d51aecc 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -687,8 +687,6 @@ struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
>  
>  struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
>  
> -struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
> -
>  struct lruvec *lock_page_lruvec(struct page *page);
>  struct lruvec *lock_page_lruvec_irq(struct page *page);
>  struct lruvec *lock_page_lruvec_irqsave(struct page *page,
> @@ -1169,11 +1167,6 @@ static inline struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  	return NULL;
>  }
>  
> -static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> -{
> -	return NULL;
> -}
> -
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 51778fa9b462..9e455815fb7a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1048,29 +1048,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
>  }
>  EXPORT_SYMBOL(get_mem_cgroup_from_mm);
>  
> -/**
> - * get_mem_cgroup_from_page: Obtain a reference on given page's memcg.
> - * @page: page from which memcg should be extracted.
> - *
> - * Obtain a reference on page->memcg and returns it if successful. Otherwise
> - * root_mem_cgroup is returned.
> - */
> -struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
> -{
> -	struct mem_cgroup *memcg = page_memcg(page);
> -
> -	if (mem_cgroup_disabled())
> -		return NULL;
> -
> -	rcu_read_lock();
> -	/* Page should not get uncharged and freed memcg under us. */
> -	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -		memcg = root_mem_cgroup;
> -	rcu_read_unlock();
> -	return memcg;
> -}
> -EXPORT_SYMBOL(get_mem_cgroup_from_page);
> -
>  static __always_inline struct mem_cgroup *active_memcg(void)
>  {
>  	if (in_interrupt())
> -- 
> 2.30.0

-- 
Michal Hocko
SUSE Labs
