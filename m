Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22D5B4862
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392665AbfIQHkG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Sep 2019 03:40:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:56752 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392664AbfIQHkG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 17 Sep 2019 03:40:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBCF3AD3A;
        Tue, 17 Sep 2019 07:40:04 +0000 (UTC)
Date:   Tue, 17 Sep 2019 09:40:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: fix a -Wunused-function warning
Message-ID: <20190917074003.GA17727@dhcp22.suse.cz>
References: <1568648453-5482-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568648453-5482-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 16-09-19 11:40:53, Qian Cai wrote:
> mem_cgroup_id_get() was introduced in the commit 73f576c04b94
> ("mm:memcontrol: fix cgroup creation failure after many small jobs").
> 
> Later, it no longer has any user since the commits,
> 
> 1f47b61fb407 ("mm: memcontrol: fix swap counter leak on swapout from offline cgroup")
> 58fa2a5512d9 ("mm: memcontrol: add sanity checks for memcg->id.ref on get/put")
> 
> so safe to remove it.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9ec5e12486a7..9a375b376157 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4675,11 +4675,6 @@ static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
>  	}
>  }
>  
> -static inline void mem_cgroup_id_get(struct mem_cgroup *memcg)
> -{
> -	mem_cgroup_id_get_many(memcg, 1);
> -}
> -
>  static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
>  {
>  	mem_cgroup_id_put_many(memcg, 1);
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
