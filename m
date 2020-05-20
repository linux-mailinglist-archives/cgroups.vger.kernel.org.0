Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81AC1DBA66
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgETQ7f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 May 2020 12:59:35 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43705 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETQ7f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 May 2020 12:59:35 -0400
Received: by mail-ej1-f67.google.com with SMTP id a2so4786903ejb.10;
        Wed, 20 May 2020 09:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ulK8UjBcVR88erWI+DBVtEzBcjfexz2ALmk1KaikEeE=;
        b=Guq15TKhii54fz86KViM72ZQKoUigoduUrKfP7Hv8effARsvmK749+sqbgVNdesEvV
         wji5r4TSOYX6BP3WBD1LJ64jxH2er+dd/KGuVNyUcAb4ROrBdgqo0ItHf9GG5MV4UVJG
         WWFg/cIyZTsimG5AGInXs16UjD9cSD2Efqls3G5hzk8HiwbbBGYRGhi/SinBOLRl7y8T
         Y01ZVMKFwfmtcc85yfV64uyVL5NJf5TUPTqtIKBBNYCSzyYxSfaEzwhMDUb0XE63UFsY
         PttRZJOoaCTqq9BrmVM18KeSfv+pM4I6pL17HgKrhxpl6BSSSle3GVFApyl3AOevmBFw
         qtkg==
X-Gm-Message-State: AOAM532SRQu+gXGANwTDq6jkXnZST5iUiNCpiYU1wsqhs7l+R8/hLrIy
        kn5hXo7Mz6oRPNYDTP7NnZc=
X-Google-Smtp-Source: ABdhPJxKJgx5XBPyBkWBT1fGe9dfNWGjBmU9XzwJaHwySJbBASqYFUxO125YFnq5b+LbkAd0l7I75g==
X-Received: by 2002:a17:906:3912:: with SMTP id f18mr4709801eje.539.1589993973055;
        Wed, 20 May 2020 09:59:33 -0700 (PDT)
Received: from localhost (ip-37-188-251-131.eurotel.cz. [37.188.251.131])
        by smtp.gmail.com with ESMTPSA id z14sm2355795ejd.37.2020.05.20.09.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 09:59:32 -0700 (PDT)
Date:   Wed, 20 May 2020 18:59:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: unify reclaim retry limits with page allocator
Message-ID: <20200520165930.GF6462@dhcp22.suse.cz>
References: <20200520163142.GA808793@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520163142.GA808793@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 20-05-20 17:31:42, Chris Down wrote:
> Reclaim retries have been set to 5 since the beginning of time in
> 66e1707bc346 ("Memory controller: add per cgroup LRU and reclaim").
> However, we now have a generally agreed-upon standard for page reclaim:
> MAX_RECLAIM_RETRIES (currently 16), added many years later in
> 0a0337e0d1d1 ("mm, oom: rework oom detection").
> 
> In the absence of a compelling reason to declare an OOM earlier in memcg
> context than page allocator context, it seems reasonable to supplant
> MEM_CGROUP_RECLAIM_RETRIES with MAX_RECLAIM_RETRIES, making the page
> allocator and memcg internals more similar in semantics when reclaim
> fails to produce results, avoiding premature OOMs or throttling.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>

I have already expressed my dislike to some of the MEM_CGROUP_RECLAIM_RETRIES
usage but using MAX_RECLAIM_RETRIES is a reasonable thing to do. There
is simply no reason to have two retry limits.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b040951ccd6b..d3b23c57bed4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -73,9 +73,6 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
>  
>  struct mem_cgroup *root_mem_cgroup __read_mostly;
>  
> -/* The number of times we should retry reclaim failures before giving up. */
> -#define MEM_CGROUP_RECLAIM_RETRIES	5
> -
>  /* Socket memory accounting disabled? */
>  static bool cgroup_memory_nosocket;
>  
> @@ -2386,7 +2383,7 @@ void mem_cgroup_handle_over_high(void)
>  	unsigned long pflags;
>  	unsigned long nr_reclaimed;
>  	unsigned int nr_pages = current->memcg_nr_pages_over_high;
> -	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +	int nr_retries = MAX_RECLAIM_RETRIES;
>  	struct mem_cgroup *memcg;
>  
>  	if (likely(!nr_pages))
> @@ -2438,7 +2435,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		      unsigned int nr_pages)
>  {
>  	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
> -	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +	int nr_retries = MAX_RECLAIM_RETRIES;
>  	struct mem_cgroup *mem_over_limit;
>  	struct page_counter *counter;
>  	unsigned long nr_reclaimed;
> @@ -2557,7 +2554,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		       get_order(nr_pages * PAGE_SIZE));
>  	switch (oom_status) {
>  	case OOM_SUCCESS:
> -		nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +		nr_retries = MAX_RECLAIM_RETRIES;
>  		goto retry;
>  	case OOM_FAILED:
>  		goto force;
> @@ -3168,7 +3165,7 @@ static inline bool memcg_has_children(struct mem_cgroup *memcg)
>   */
>  static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  {
> -	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +	int nr_retries = MAX_RECLAIM_RETRIES;
>  
>  	/* we call try-to-free pages for make this cgroup empty */
>  	lru_add_drain_all();
> @@ -6001,7 +5998,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  				 char *buf, size_t nbytes, loff_t off)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> -	unsigned int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>  	bool drained = false;
>  	unsigned long high;
>  	int err;
> @@ -6049,7 +6046,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  				char *buf, size_t nbytes, loff_t off)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> -	unsigned int nr_reclaims = MEM_CGROUP_RECLAIM_RETRIES;
> +	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
>  	bool drained = false;
>  	unsigned long max;
>  	int err;
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
