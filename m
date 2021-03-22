Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5385F343D1F
	for <lists+cgroups@lfdr.de>; Mon, 22 Mar 2021 10:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVJlz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Mar 2021 05:41:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhCVJlt (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Mar 2021 05:41:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616406107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MrLrWusuMoiI8O7+3wbzgaIdF+kB6mkdoYQZJejkd4=;
        b=E8D+jDAB+COFZKQcu1xIYYrlMjFnpzSSEQuIxnyvEKfQx0biUZEIj+nLhEn2vmvJUbQNmH
        K3bE7QPucLJ9hKYrmqtXLCNBJRqkWS8KyFJRMX4AAB0BBVw0pYsDBd/0peRXIdpft3Zkrh
        mSDjAXUSYypyfpU/g4bLolctjgMumgk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B9D5AAD38;
        Mon, 22 Mar 2021 09:41:47 +0000 (UTC)
Date:   Mon, 22 Mar 2021 10:41:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2] mm: memcontrol: don't allocate cgroup swap arrays
 when memcg is disabled
Message-ID: <YFhmW63Py+UbmFTS@dhcp22.suse.cz>
References: <20210319054944.50048-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319054944.50048-1-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 19-03-21 01:49:43, Johannes Weiner wrote:
> Since commit 2d1c498072de ("mm: memcontrol: make swap tracking an
> integral part of memory control"), the cgroup swap arrays are used to
> track memory ownership at the time of swap readahead and swapoff, even
> if swap space *accounting* has been turned off by the user via
> swapaccount=0 (which sets cgroup_memory_noswap).
> 
> However, the patch was overzealous: by simply dropping the
> cgroup_memory_noswap conditionals in the swapon, swapoff and uncharge
> path, it caused the cgroup arrays being allocated even when the memory
> controller as a whole is disabled. This is a waste of that memory.
> 
> Restore mem_cgroup_disabled() checks, implied previously by
> cgroup_memory_noswap, in the swapon, swapoff, and swap_entry_free
> callbacks.
> 
> Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c  | 3 +++
>  mm/swap_cgroup.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 668d1d7c2645..49bdcf603af1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -7101,6 +7101,9 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
>  	struct mem_cgroup *memcg;
>  	unsigned short id;
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	id = swap_cgroup_record(entry, 0, nr_pages);
>  	rcu_read_lock();
>  	memcg = mem_cgroup_from_id(id);
> diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
> index 7f34343c075a..08c3246f9269 100644
> --- a/mm/swap_cgroup.c
> +++ b/mm/swap_cgroup.c
> @@ -171,6 +171,9 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
>  	unsigned long length;
>  	struct swap_cgroup_ctrl *ctrl;
>  
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
>  	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
>  	array_size = length * sizeof(void *);
>  
> @@ -206,6 +209,9 @@ void swap_cgroup_swapoff(int type)
>  	unsigned long i, length;
>  	struct swap_cgroup_ctrl *ctrl;
>  
> +	if (mem_cgroup_disabled())
> +		return;
> +
>  	mutex_lock(&swap_cgroup_mutex);
>  	ctrl = &swap_cgroup_ctrl[type];
>  	map = ctrl->map;
> -- 
> 2.30.1
> 

-- 
Michal Hocko
SUSE Labs
