Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2426827E6FA
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 12:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgI3KsW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 06:48:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:40846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3KsV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 30 Sep 2020 06:48:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601462900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7IFfx3OZnBqgehUu2cMHgsqKwAUzAFD3b+C2ju1XQ1M=;
        b=kSGXheRNDCMV2H2V8U5XRM1cHAIxtJscvMNLblFLwwRrfidDvPGlPhMlrG3r6uyWFZ9oXY
        YanXrUHiJfGiwjrjUrUcNNMenjR/RUHxXRfHFR1/6VlLiweKCqlQY9y3xFchtwGGU8Aw9I
        3+hP1Y9IMTAAk2cLWQSeH7GPviQsPlM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 340C0ACF5;
        Wed, 30 Sep 2020 10:48:20 +0000 (UTC)
Date:   Wed, 30 Sep 2020 12:48:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: memcontrol: reword obsolete comment of
 mem_cgroup_unmark_under_oom()
Message-ID: <20200930104819.GS2277@dhcp22.suse.cz>
References: <20200930095336.21323-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930095336.21323-1-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 30-09-20 05:53:36, Miaohe Lin wrote:
> Since commit 79dfdaccd1d5 ("memcg: make oom_lock 0 and 1 based rather than
> counter"), the mem_cgroup_unmark_under_oom() is added and the comment of
> the mem_cgroup_oom_unlock() is moved here.  But this comment make no sense
> here because mem_cgroup_oom_lock() does not operate on under_oom field. So
> we reword the comment as this would be helpful.
> [Thanks Michal Hocko for rewording this comment.]
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6877c765b8d0..4f0c14cb8690 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1817,8 +1817,8 @@ static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
>  	struct mem_cgroup *iter;
>  
>  	/*
> -	 * When a new child is created while the hierarchy is under oom,
> -	 * mem_cgroup_oom_lock() may not be called. Watch for underflow.
> +	 * Be careful about under_oom underflows becase a child memcg
> +	 * could have been added after mem_cgroup_mark_under_oom.
>  	 */
>  	spin_lock(&memcg_oom_lock);
>  	for_each_mem_cgroup_tree(iter, memcg)
> -- 
> 2.19.1

-- 
Michal Hocko
SUSE Labs
