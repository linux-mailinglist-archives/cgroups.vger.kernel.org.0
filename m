Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8763C4DE3
	for <lists+cgroups@lfdr.de>; Mon, 12 Jul 2021 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbhGLHPl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 03:15:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44212 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbhGLHO3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 03:14:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 44E3222026;
        Mon, 12 Jul 2021 07:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626073900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88g+Hjk4+ngCRfrrCWN3sqteBTz3zSMuvPk+OffCI/w=;
        b=QSjr81nJ86GNXrBLiEXZ9n+OxYly8KMT/KnJRS3hK0s4IBzcFD0Q7TEgI27ADbtps3GtaD
        fDrsFb+HWjyySQ4gt75pAsEJzVQn0lT1Q6mZ9SYwUH1m3wUX1WgSeDSf+RdYiGPq5OTCbm
        4Ppx5SYX+pY2J2XHtONUaBDa8DgtAk4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99B2AA3DB6;
        Mon, 12 Jul 2021 07:11:39 +0000 (UTC)
Date:   Mon, 12 Jul 2021 09:11:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     tj@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, vbabka@suse.cz, axboe@kernel.dk,
        iamjoonsoo.kim@lge.com, david@redhat.com, willy@infradead.org,
        apopple@nvidia.com, minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
Message-ID: <YOvrKzvG+nHJpV+V@dhcp22.suse.cz>
References: <20210710003626.3549282-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210710003626.3549282-1-surenb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 09-07-21 17:36:24, Suren Baghdasaryan wrote:
> Add mem_cgroup_disabled check in vmpressure, mem_cgroup_uncharge_swap and
> cgroup_throttle_swaprate functions. This minimizes the memcg overhead in
> the pagefault and exit_mmap paths when memcgs are disabled using
> cgroup_disable=memory command-line option.
> This change results in ~2.1% overhead reduction when running PFT test

What is PFT test?

> comparing {CONFIG_MEMCG=n, CONFIG_MEMCG_SWAP=n} against {CONFIG_MEMCG=y,
> CONFIG_MEMCG_SWAP=y, cgroup_disable=memory} configuration on an 8-core
> ARM64 Android device.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 3 +++
>  mm/swapfile.c   | 3 +++
>  mm/vmpressure.c | 7 ++++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ae1f5d0cb581..a228cd51c4bd 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7305,6 +7305,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>  	struct mem_cgroup *memcg;
>  	unsigned short id;
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	id = swap_cgroup_record(entry, 0, nr_pages);
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_id(id);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1e07d1c776f2..707fa0481bb4 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3778,6 +3778,9 @@ void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
>  	struct swap_info_struct *si, *next;
>  	int nid = page_to_nid(page);
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	if (!(gfp_mask & __GFP_IO))
>  		return;
>  
> diff --git a/mm/vmpressure.c b/mm/vmpressure.c
> index d69019fc3789..9b172561fded 100644
> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -240,7 +240,12 @@ static void vmpressure_work_fn(struct work_struct *work)
>  void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>  		unsigned long scanned, unsigned long reclaimed)
>  {
> -	struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
> +	struct vmpressure *vmpr;
> +
> +	if (mem_cgroup_disabled())
> +		return;
> +
> +	vmpr = memcg_to_vmpressure(memcg);
>  
>  	/*
>  	 * Here we only want to account pressure that userland is able to
> -- 
> 2.32.0.93.g670b81a890-goog

-- 
Michal Hocko
SUSE Labs
