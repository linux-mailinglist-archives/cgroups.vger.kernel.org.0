Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2402026CD0B
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 22:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgIPUxA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 16:53:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44742 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbgIPQyM (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600268017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XWkcsvUYLuBv2uzcZZ0bcAz6BNNnURdggjQevDJBQMk=;
        b=B4ZfZkQTyh6ucc0CDOCoHrBoEoqEKXhzrWyFLZovTbslQ3qlxl9dwKILWewGtRRgbZ7jGN
        oCspOgcD2NxVF2Uoem6CrWV3rZeIQ/jL0GIJHPid+1dBMZDai76UsFfEyMFdmZh6hP3hek
        u5SxSi1yYLMTJa8Ok4sHOjNvjrDALiyEom14min4kLbKOpiXjiz0q6wWZP3Sl7L2LAQOJK
        TooeaSbvdjdOiHfDIHSO4Y9pzziFgRwbKx3Oce7RH+V+V18TxBd5v16Yhn6CMBrJZFZBM/
        wW8YMf2r4GqiIzDVqE7f+EN/iorB0kzWQEY67MdhIffOxYm1PWAsFZvjS8rLYg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C570AC4D;
        Wed, 16 Sep 2020 14:53:52 +0000 (UTC)
Date:   Wed, 16 Sep 2020 16:53:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: correct the comment of
 mem_cgroup_unmark_under_oom()
Message-ID: <20200916145336.GI18998@dhcp22.suse.cz>
References: <20200916131927.11340-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916131927.11340-1-linmiaohe@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 16-09-20 09:19:27, Miaohe Lin wrote:
> Since commit fb2a6fc56be6 ("mm: memcg: rework and document OOM waiting and
> wakeup"), we have renamed mem_cgroup_oom_lock to mem_cgroup_oom_trylock. So
> replace mem_cgroup_oom_lock with mem_cgroup_oom_trylock in comment.

While you are right I find the comment more confusing then helpful.
What does it try to tell us actually? Is it still valid? Shouldn't we
rather remove it or make it more clear?
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3d26b4b954e2..702aa4d7ebbc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1846,7 +1846,7 @@ static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
>  
>  	/*
>  	 * When a new child is created while the hierarchy is under oom,
> -	 * mem_cgroup_oom_lock() may not be called. Watch for underflow.
> +	 * mem_cgroup_oom_trylock() may not be called. Watch for underflow.
>  	 */
>  	spin_lock(&memcg_oom_lock);
>  	for_each_mem_cgroup_tree(iter, memcg)
> -- 
> 2.19.1

-- 
Michal Hocko
SUSE Labs
