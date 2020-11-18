Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94C42B7DC8
	for <lists+cgroups@lfdr.de>; Wed, 18 Nov 2020 13:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKRMqT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Nov 2020 07:46:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:53684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbgKRMqT (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 18 Nov 2020 07:46:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605703578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+Qzkkhk4C6GtBU8xVUeEofjQe9CXbPuBs8NdbyYcoo=;
        b=WCfWgtAO+igB5OcpcKj8XOlT7ogXI+httgsZpXzYSpk3Km0SZhrb6ps0ZOT5fbIm96o19n
        vdUme6DBKNrcaRw6s/+riMxSYyKWQ6nn3SO4dsmP8RXVu+XeNwdfKVshKdhIM/P48G/xyx
        H/ktOrSgKNdjYtJKma1fDR8T0nAoays=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3BFBAAC91;
        Wed, 18 Nov 2020 12:46:18 +0000 (UTC)
Date:   Wed, 18 Nov 2020 13:46:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: remove obsolete memcg_has_children()
Message-ID: <20201118124617.GR12284@dhcp22.suse.cz>
References: <20201116055043.20886-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116055043.20886-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 16-11-20 06:50:43, Lukas Bulwahn wrote:
> Commit 2ef1bf118c40 ("mm: memcg: deprecate the non-hierarchical mode")
> removed the only use of memcg_has_children() in
> mem_cgroup_hierarchy_write() as part of the feature deprecation.
> 
> Hence, since then, make CC=clang W=1 warns:
> 
>   mm/memcontrol.c:3421:20:
>     warning: unused function 'memcg_has_children' [-Wunused-function]
> 
> Simply remove this obsolete unused function.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

git grep agrees
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> applies cleanly on next-20201113, not on current master
> 
> Roman, please ack.
> 
> Andrew, please pick this minor non-urgent patch into your -next tree.
> 
>  mm/memcontrol.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f95ddb3e9898..d49d7c507284 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3415,19 +3415,6 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  	return nr_reclaimed;
>  }
>  
> -/*
> - * Test whether @memcg has children, dead or alive.
> - */
> -static inline bool memcg_has_children(struct mem_cgroup *memcg)
> -{
> -	bool ret;
> -
> -	rcu_read_lock();
> -	ret = css_next_child(NULL, &memcg->css);
> -	rcu_read_unlock();
> -	return ret;
> -}
> -
>  /*
>   * Reclaims as many pages from the given memcg as possible.
>   *
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
